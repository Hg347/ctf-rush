# Capture The Flag (CTF)


## Use Cases
For details on game scenarios refer to [scenarios folder](./scenarios/Readme.md).


## Tech Stack
Server 
- Linux, Apache, MySQL, PHP (LAMP)
- Laravel PHP framework
  - LiveWire

Mobile Client
- Android native app

## Intended Software Architecture
The software architecture uses a layered architecture design and decoupling through the implementation of an application programming interface (API).

![Architecture](Architecture.png)

## Draft of Database Design 
The basic database design is outlined in the following entity-relationship model.

![Database Concept](./ctf_db_concept.drawio.png)



## Ideas
Further ideas that will be examined in more detail and implemented if necessary at a later date:

- incorporating NFC tags
- using Openstreet maps 
- geo locations by Smartphone sensor
- movements by Smartphone sensor
- speeds by Smartphone sensor