#!/usr/bin/env bash
# Lancé par deploy.sh dans le dossier déployé, avec bash -e : tout s'arrête à la première erreur.
# EVA_ENVIRONMENT vaut prod ou preprod. EVA_COMMIT et EVA_BRANCH sont aussi disponibles.

composer install 

php bin/console cache:clear

php bin/console doctrine:database:create --if-not-exists --no-interaction

# Écrit la migration de l'écart entre les entités et la base. Sans écart, sort en 0 sans rien écrire.
php bin/console make:migration --no-interaction

# Applique les migrations que le dépôt porte : sur une base vide, elles construisent le schéma.
# --allow-no-migration : aucune migration enregistrée sort en erreur sinon, ce qui arrive dès que
# la synchronisation de production a effacé la migration générée, que git ne suit pas.
php bin/console doctrine:migrations:migrate --no-interaction --allow-no-migration

# Écart entre les entités et la base, puis application de la migration générée.
# --allow-empty-diff : sans écart, diff sort en erreur et arrêterait le déploiement
php bin/console doctrine:migrations:diff --no-interaction --allow-empty-diff
php bin/console doctrine:migrations:migrate --no-interaction --allow-no-migration

if [ "$EVA_ENVIRONMENT" = feat ]; then
  php bin/console doctrine:fixtures:load --no-interaction
fi