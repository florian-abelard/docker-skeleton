# docker-skeleton

## Démarrage

### Pré-requis

* docker
* docker-compose (version 3)

### Usage

#### Initialisation du projet

```bash
git clone git@github.com:florian-abelard/docker-starter-kit.git <app_name>
cd <app_name>

rm -Rf .git/
git init

git remote add origin git@github.com:florian-abelard/flo-gift-list.git
```

Modifier le fichier `README.md`

```bash
git add .
git commit -a -m "Initial commit"
```

#### Démarrage des containers docker

Editer le fichier `.env`, puis : 
```bash
make up
```

### Avec symfony

```bash
rm application/ -Rf
composer create-project symfony/website-skeleton application
```

### Accès

Accès interface sur `http://localhost`
