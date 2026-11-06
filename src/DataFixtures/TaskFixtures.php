<?php

namespace App\DataFixtures;

use App\Entity\Task;
use Doctrine\Bundle\FixturesBundle\Fixture;
use Doctrine\Persistence\ObjectManager;

class TaskFixtures extends Fixture
{
    /**
     * Jeu de données de démonstration pour l'entité Task.
     */
    private const TASKS = [
        [
            'title' => 'Mettre en place le projet Symfony',
            'description' => 'Initialiser la structure et les dépendances de base du projet.',
            'isDone' => true,
        ],
        [
            'title' => "Créer l'entité Task",
            'description' => 'Définir les propriétés et le mapping Doctrine de la tâche.',
            'isDone' => true,
        ],
        [
            'title' => 'Ajouter des fixtures de test',
            'description' => 'Générer un jeu de données pour le développement et les démonstrations.',
            'isDone' => false,
        ],
        [
            'title' => "Afficher les tâches sur la page d'accueil",
            'description' => "Lister les tâches existantes directement sur la route home.",
            'isDone' => false,
        ],
        [
            'title' => 'Écrire les tests fonctionnels',
            'description' => null,
            'isDone' => false,
        ],
    ];

    public function load(ObjectManager $manager): void
    {
        foreach (self::TASKS as $data) {
            $task = new Task($data['title'], $data['description']);
            $task->setIsDone($data['isDone']);

            $manager->persist($task);
        }

        $manager->flush();
    }
}
