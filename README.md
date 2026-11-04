# 🎼 Symfony App

Projet **Symfony 7.1** (profil "webapp") : Twig, Doctrine ORM/DBAL, Security, Maker Bundle et Web Profiler (en développement).

> ⚠️ Cette structure a été générée manuellement (fichiers de configuration standards d'un projet Symfony Flex). Le dossier `vendor/` n'est pas versionné : il faut exécuter `composer install` pour installer les dépendances avant de démarrer le projet.

## 🗂️ Structure du projet

```
symfony-app/
├── bin/
│   └── console              # Point d'entrée de la console Symfony
├── config/
│   ├── packages/             # Configuration des bundles (framework, twig, doctrine, security...)
│   ├── bundles.php           # Déclaration des bundles actifs par environnement
│   ├── routes.yaml           # Chargement des routes (attributs PHP)
│   └── services.yaml         # Configuration des services (autowiring, autoconfiguration)
├── public/
│   └── index.php             # Front controller
├── src/
│   ├── Controller/
│   │   └── HomeController.php
│   └── Kernel.php
├── templates/
│   ├── base.html.twig
│   └── home/index.html.twig
├── .env                       # Variables d'environnement par défaut (non sensibles)
├── .gitignore
└── composer.json
```

## 🚀 Installation

### Prérequis

- PHP **>= 8.2** avec les extensions `ctype` et `iconv`
- [Composer](https://getcomposer.org/)
- Une base de données (MySQL/MariaDB, PostgreSQL ou SQLite) si vous utilisez Doctrine
- (Optionnel) [Symfony CLI](https://symfony.com/download) pour le serveur de développement

### Étapes

1. Cloner le dépôt :
   ```bash
   git clone https://github.com/tianairiela/symfony-app.git
   cd symfony-app
   ```

2. Installer les dépendances PHP :
   ```bash
   composer install
   ```

3. Configurer les variables d'environnement :
   - Copier `.env` en `.env.local` (fichier non versionné) et ajuster au besoin :
     ```bash
     cp .env .env.local
     ```
   - Définir une vraie valeur pour `APP_SECRET` (ex. `openssl rand -hex 16`).
   - Adapter `DATABASE_URL` à votre base de données (MySQL, PostgreSQL ou SQLite).

4. (Si vous utilisez Doctrine) Créer la base de données et lancer les migrations :
   ```bash
   php bin/console doctrine:database:create
   php bin/console doctrine:migrations:migrate
   ```

5. Démarrer le serveur de développement :
   ```bash
   symfony server:start
   # ou, sans Symfony CLI :
   php -S localhost:8000 -t public
   ```

6. Ouvrir [http://localhost:8000](http://localhost:8000) dans votre navigateur.

## 🧰 Commandes utiles

| Commande | Description |
|---|---|
| `php bin/console make:controller` | Générer un nouveau contrôleur (via Maker Bundle) |
| `php bin/console make:entity` | Générer une entité Doctrine |
| `php bin/console cache:clear` | Vider le cache de l'application |
| `php bin/console debug:router` | Lister toutes les routes disponibles |

## 🛠️ Technologies

- **Symfony** 7.1 (FrameworkBundle, TwigBundle, SecurityBundle)
- **Doctrine** ORM / DBAL / Migrations
- **Twig** pour le rendu des templates
- **Maker Bundle**, **Web Profiler**, **Var Dumper** en environnement de développement

## 📄 Licence

Projet propriétaire (à adapter selon vos besoins).
