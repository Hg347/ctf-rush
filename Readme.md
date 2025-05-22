# CTF Rush - Capture the flag
[![Deploy AWS Account with Terraform](https://github.com/Hg347/ctf-rush/actions/workflows/terraform-deploy.yml/badge.svg)](https://github.com/Hg347/ctf-rush/actions/workflows/terraform-deploy.yml)  [![Player API Lambda](https://github.com/Hg347/ctf-rush/actions/workflows/player-api-deploy.yml/badge.svg)](https://github.com/Hg347/ctf-rush/actions/workflows/player-api-deploy.yml)

CTF-Rush is a new variation of the traditional urban game [Capture the Flag (CTF)](./Ctf-Instruction.md). It integrates the possibilities of modern technologies, such as smartphones, and makes it a pervasive game.

The idea is to encourage children and young people to play together outdoors in the real world, rather than playing online games alone indoors. We strongly believe that there is enormous potential in technology-sustained games to encourage everyday movement and play.

For more information about the traditional game, see [Wikipedia](https://en.wikipedia.org/wiki/Capture_the_flag).

## Project Status
The project is currently in the conception phase.

### Concepts and Design 
Refer to [concepts folder](./concept/Readme.md)


## How to contribute?
Feel free to contact the maintainers via email as published on GitHub.
For more details, see [contribution guide](./Contribute.md).

## Development Environment

Currently, the following information is only a preliminary idea. Running a web server via LAMP web hosting for an API seems like a lot of effort, also for the api scaffolding in php and deployment. Furthermore, this approach doesn't scale. It will probably be more likely to be a serverless version with AWS.

### Backend 

For backend processing by an API service that is database backed, we intend to use either 

1. [Laravel Homestead](https://laravel.com/docs/12.x/homestead) as development environment for the web server part.
   - Linux, Apache, MySQL, PHP (LAMP)
   - Laravel PHP framework
   - LiveWire

2. or [AWS Serverless Computing](https://aws.amazon.com/serverless/)

### Frontend, Mobile Client

We intend to use [Flutter](https://flutter.dev/) as development environment for a mobile app running on iOS and Android.

- [cross-platform app with Flutter](https://medium.com/flutter-community/create-a-cross-platform-app-using-flutter-in-2021-59e582cb625f)

### Tools
- [OpenAPI Playground](https://criteria.sh/play) 