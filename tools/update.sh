#!/usr/bin/env bash

para --version 2>&1 > /dev/null
if [ ! $? -eq 0 ]; then
    echo "\033[0;34mPara is not installed\033[0m"
    exit
fi

CURRENT_DIR=$(pwd)

composer --version 2>&1 > /dev/null
COMPOSER_IS_AVAILABLE=$?

if [ ! $COMPOSER_IS_AVAILABLE -eq 0 ]; then
    echo "composer is not installed"
    exit
fi

git --version 2>&1 > /dev/null
GIT_IS_AVAILABLE=$?

if [ $GIT_IS_AVAILABLE -eq 0 ]; then
    cd ~/.para 2>&1 > /dev/null
    echo "\033[0;34mUpdating para to the latest version...\033[0m"
    hash git >/dev/null && /usr/bin/env git pull origin master 2>&1 > /dev/null
fi

# Install dependencies.
echo "\033[0;34mUpdating dependencies...\033[0m"
composer install --no-dev --optimize-autoloader --quiet
cd $CURRENT_DIR 2>&1 > /dev/null

VERSION=$(para --version)
PARA_UPDATED=$?

if [ $PARA_UPDATED -eq 0 ]; then
    echo "\033[0;34mSuccessfully updated para to version ${VERSION} \033[0m"
    exit
fi
echo "\033[0;34mFailed to update para\033[0m"