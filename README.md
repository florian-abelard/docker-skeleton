# docker-skeleton

## Démarrage

### Pré-requis

* docker
* docker-compose (version 3)

### Usage

#### Initialisation du projet

```bash
APPLICATION_NAME='<application_name>' # A personnaliser

git clone git@github.com:florian-abelard/docker-starter-kit.git $APPLICATION_NAME
cd $APPLICATION_NAME

rm -Rf .git/
git init

git remote add origin git@github.com:florian-abelard/$APPLICATION_NAME.git
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
docker-compose exec php composer create-project symfony/website-skeleton application

# A compléter
```

### Accès

Accès interface web sur `http://localhost:8080`

Accès adminer sur `http://localhost:8081`
