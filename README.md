# ![icon](Image/icon/48.png) Everlasting Candy

Looping arcade platformer game, based on [Candy Wrapper] by [Harmony Honey]

![shot1](Image/thumb/1.png)
![shot2](Image/thumb/2.png)
![shot3](Image/thumb/3.png)

## Background

Endless runs [game-making learning programs](https://www.endlessos.org/game-making) focused on novice through advanced learners ages 13+. We provide opportunities for career-readiness and collaboration within a community of game makers.

[Candy Wrapper] is an openly-licensed game built with Godot 4.3. Its simple nature and expandable design lead us to choose it as the base for programs where learners collaboratively build and maintain a game, onboarding them to a real community experience. With our fork, _Everlasting Candy_, we respect the original Candy Wrapper design while facilitating community-contributed content and design. We hope to foster a lasting community of open source game developers who can continuously improve and expand upon the game while learning new skills and sharpening existing ones.

## Adding New Worlds

Copy the `Worlds/Sample` folder to `Worlds/Your World Name`. Run the game: you
should see “Your World Name” in the world selection menu.

Now, you can add new numbered levels and edit the existing levels in
`Worlds/Your World Name`. Each level should be a numbered scene file, with a
single `TileMapLayer` node. Each level should have the player tile in exactly
one cell, and one or more “goober” tiles. When the level is played, they will be
replaced with the player and goober scenes, offset horizontally by half a tile.

The levels with the lowest and highest numbers (`0.tscn` and `999.tscn`
respectively in the `Sample` world) are treated specially by the game: the
player cannot move, and pressing Jump starts the game proper.

A core part of the game is that the levels wrap around: if the player or enemies
move off any of the four sides of the screen, they reappear on the opposite
side. For this to work correctly, you currently need to manually copy any ledges
that are at the edge of the tile map to the corresponding position just off the
other edge of the map. See
https://github.com/endlessm/everlasting-candy/issues/19 for more details.

## Development

Built with [Godot Engine 4.3](https://godotengine.org)

## License & Credits

Licensed under The Unlicense; see [LICENSE](LICENSE) for more information.

Original game by [Harmony Honey].

[Border Basic](https://v3x3d.itch.io/border-basic) font by VEXED, used under Creative Commons Attribution v4.0 International license.

[Candy Wrapper]: https://github.com/HarmonyHoney/CandyWrapper
[Harmony Honey]: https://github.com/HarmonyHoney
