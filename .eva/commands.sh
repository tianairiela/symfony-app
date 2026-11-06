#!/usr/bin/env bash
# Lancé par deploy.sh dans le dossier déployé, avec bash -e : tout s'arrête à la première erreur.
# EVA_ENVIRONMENT vaut prod ou preprod. EVA_COMMIT et EVA_BRANCH sont aussi disponibles.

composer_options=(--no-interaction --no-progress --prefer-dist)
if [ "$EVA_ENVIRONMENT" = prod ]; then
  composer_options+=(--no-dev --optimize-autoloader)
fi

composer install "${composer_options[@]}"

php bin/console cache:clear
php bin/console doctrine:migrations:migrate --no-interaction

if [ "$EVA_ENVIRONMENT" = preprod ]; then
  php bin/console doctrine:fixtures:load --no-interaction
fi
