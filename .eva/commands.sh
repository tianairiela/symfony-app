#!/usr/bin/env bash
# Lancé par deploy.sh dans le dossier déployé, avec bash -e : tout s'arrête à la première erreur.
# EVA_ENVIRONMENT vaut prod ou preprod. EVA_COMMIT et EVA_BRANCH sont aussi disponibles.

composer_options=(--no-interaction --no-progress --prefer-dist)
if [ "$EVA_ENVIRONMENT" = prod ]; then
  composer_options+=(--no-dev --optimize-autoloader)
fi

composer install "${composer_options[@]}"

php bin/console cache:clear

php bin/console doctrine:database:create --if-not-exists --no-interaction

# Applique les migrations que le dépôt porte : sur une base vide, elles construisent le schéma
php bin/console doctrine:migrations:migrate --no-interaction

# Écart entre les entités et la base, puis application de la migration générée.
# --allow-empty-diff : sans écart, diff sort en erreur et arrêterait le déploiement
php bin/console doctrine:migrations:diff --no-interaction --allow-empty-diff
php bin/console doctrine:migrations:migrate --no-interaction

if [ "$EVA_ENVIRONMENT" = preprod ]; then
  php bin/console doctrine:fixtures:load --no-interaction
fi