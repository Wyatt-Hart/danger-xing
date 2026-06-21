# Danger X-ing

## Project Overview
This game is a recreation of the classic arcade game "Frogger". The goal is simple, safely get to the nests on the other side of the river without being hit or falling into the water. Currently there are only 3 levels and a basic Victory screen if you manage to make it to the end.

## Specifications
This game was coded in GD Script using Godot 4.6.2.

Game elements include:
  - NPCs: Cars driving along the road will kill player if they collide
  - Rideable Platforms: Logs in the river provide a way to get across to the nests
  - UI: A lives and score counter are visible as well as a main menu, pause, game over and victory screen
  - Levels: As mentioned there are 3 levels currently, each loaded after the next once you successfully reach each nest
  
Meshes were designed in Godot using basic MeshInstance3D nodes and custom made materials.

## Demo
In the build folder there is a version built for linux as well as a web version.
The web application version can be found [here](https://wyatt-hart.github.io/danger-xing/). (Note: this version is still not consistantly working online, downloading from the build page is recommended)


###### Last modified with: Godot 4.6.2
