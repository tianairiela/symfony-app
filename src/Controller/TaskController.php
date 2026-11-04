<?php

namespace App\Controller;

use App\Entity\Task;
use App\Repository\TaskRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;

#[Route('/tasks')]
class TaskController extends AbstractController
{
    #[Route('', name: 'task_index', methods: ['GET'])]
    public function index(TaskRepository $taskRepository): Response
    {
        return $this->render('task/index.html.twig', [
            'tasks' => $taskRepository->findAllOrderedByCreatedAt(),
        ]);
    }

    #[Route('', name: 'task_create', methods: ['POST'])]
    public function create(Request $request, EntityManagerInterface $entityManager): Response
    {
        $title = trim((string) $request->request->get('title'));

        if ('' !== $title) {
            $description = $request->request->get('description');
            $task = new Task($title, '' !== $description ? $description : null);

            $entityManager->persist($task);
            $entityManager->flush();
        }

        return $this->redirectToRoute('task_index');
    }

    #[Route('/{id}/toggle', name: 'task_toggle', methods: ['POST'])]
    public function toggle(Task $task, EntityManagerInterface $entityManager): Response
    {
        $task->setIsDone(!$task->isDone());
        $entityManager->flush();

        return $this->redirectToRoute('task_index');
    }

    #[Route('/{id}/delete', name: 'task_delete', methods: ['POST'])]
    public function delete(Task $task, EntityManagerInterface $entityManager): Response
    {
        $entityManager->remove($task);
        $entityManager->flush();

        return $this->redirectToRoute('task_index');
    }
}
