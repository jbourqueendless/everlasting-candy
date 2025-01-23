## Adding New Worlds

Copy the `Worlds/Sample` folder to `Worlds/Your World Name`. Run the game: you should see “Your World Name” in the world selection menu.

Now, you can add new numbered levels and edit the existing levels in `Worlds/Your World Name`. Each level should be a numbered scene file, with a single `TileMapLayer` node. Each level should have the player tile in exactly one cell, and one or more “goober” tiles. When the level is played, they will be replaced with the player and goober scenes, offset horizontally by half a tile.

The levels with the lowest and highest numbers (`0.tscn` and `999.tscn` respectively in the `Sample` world) are treated specially by the game: the player cannot move, and pressing Jump starts the game proper.

A core part of the game is that the levels wrap around: if the player or enemies move off any of the four sides of the screen, they reappear on the opposite side. For this to work correctly, you currently need to manually copy any ledges that are at the edge of the tile map to the corresponding position just off the other edge of the map. See https://github.com/endlessm/everlasting-candy/issues/19 for more details.
