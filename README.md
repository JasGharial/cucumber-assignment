# README

## Running the server locally

- Clone repository and move to project folder

```sh
git clone https://github.com/JasGharial/cucumber-assignment
```

```sh
cd ./cucumber-assignment
```
- Install RVM

Below step is supported for Linux, for other Operating Systems steps may differ, Please refer to official documentation for updated details:

Linux
```
1) sudo apt install gnupg2

2) gpg2 --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
```

```sh
curl -sSL https://get.rvm.io | bash -s stable
```

- Install required ruby version by project

```sh
rvm install "ruby-3.2.2"
```

```
ruby --version
ruby 3.2.2
```

Note: if `ruby` command throws a command not found error, try using `/bin/bash --login`.

For Postgresql Database:

```sh
sudo apt install postgresql libpq-dev
```

- Install Bun

For this project, Bun.js has been used as JS runtime.
Make sure below steps are followed properly:

```sh
sudo apt update
```

If want to install node using NVM ( node version manager ), then please skp the below command and follow official documentation for installing NVM
```sh
sudo apt install nodejs npm
```

Check if node is installed on your local
```sh
node -v npm -v
```
Install bun using npm/yarn
```sh
npm install -g bun
```
Check Bun Installation:
```sh
bun --version
```
Pre-requisite for creating database
Run the following command to create local_env.yml
```sh
touch config/local_env.yml
```
Then, paste the following components into above created file:
```
DB_USER: 'USER_DATABASE_USER'
DB_PASSWORD: 'USER_DATABASE_PASSWORD'
```
- Create Database
```sh
rails db:create
```
- Run Migrations
```sh
rails db:migrate
```

- Run server

```sh
bin/dev
```