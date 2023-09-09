# LevelDesignEngine-Baba-is-You
> *Based on the game "Baba Is You" from Arvi Teikari.*

This repo is a game made in godot, applying some data-structures strategies to get better perfomances, and allowing an easy way to create new levels.
Each object in the game has no default inherited property, so to an object to has property an sentence need to be made.

### The properties are:
```gdscript
var INSTANCE_STATES = {
	YOU_C: EMPTY,   # The current player
	PUSH_C: EMPTY,  # The current object that can be pushed
	STOP_C: EMPTY,  # The current object that stop the player
	WIN_C: EMPTY    # The current object that by touching you win the level
}
```

### The tiles are:

```gdscript
var COMMANDS = [
	BOB_C, WALL_C, FLAG_C, ROCK_C, IS_C, YOU_C, STOP_C, PUSH_C, WIN_C 
]

var OBJECTS = [
	BOB, FLAG, ROCK, WALL
]

```

### Level creation sample:

> The real gain is that, by using a sparse matrix to design a new level it costs less memory.
> That was made because usually we don't have that much filled tiles.

```gdscript
var LEVEL1_POS = [

  # The OBJECTS design
	[WALL, [12, 5]], [WALL, [13, 5]], [WALL, [14, 5]], [WALL, [15, 5]], [WALL, [16, 5]], [WALL, [17, 5]], [WALL, [18, 5]], [WALL, [19, 5]], [WALL, [20, 5]],
	[WALL, [12, 11]], [WALL, [13, 11]], [WALL, [14, 11]], [WALL, [15, 11]], [WALL, [16, 11]], [WALL, [17, 11]], [WALL, [18, 11]], [WALL, [19, 11]], [WALL, [20, 11]],
	[ROCK, [16, 6]], [ROCK, [16, 7]], [ROCK, [16, 8]], [ROCK, [16, 9]], [ROCK, [16, 10]],
	[BOB, [8, 8]],
	[FLAG, [24, 8]],

  # The COMMANDS design
	[BOB_C, [12, 3]], [IS_C, [13, 3]], [YOU_C, [14, 3]],
	[WALL_C, [18, 3]], [IS_C, [19, 3]], [STOP_C, [20, 3]],
	[ROCK_C, [12, 13]], [IS_C, [13, 13]], [PUSH_C, [14, 13]],
	[FLAG_C, [18, 13]], [IS_C, [19, 13]], [WIN_C, [20, 13]],
]
```

### Gameplay demonstration:

https://github.com/JCGCosta/LevelDesignEngine-Baba-is-You/assets/51680369/763d8222-deaf-4bbc-a25b-c2d685c52d5b

