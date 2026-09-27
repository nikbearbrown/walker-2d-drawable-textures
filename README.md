# Walker — Drawable Textures

This is a title-only Walker adaptation of Godot's `2d/drawable_textures` demo.
You paint on a 2D canvas, and the same texture appears live on a 3D cube or
sphere. It sits in Walker as a demonstration of runtime texture painting with
`DrawableTexture2D`. It is a tech demo, not a game. The import, the runtime
startup and 17 headless state assertions pass. Actual GPU painting and erasing
have not yet been seen on screen.

## How to run

Open `godot/project.godot` in Godot 4.7 and run the main scene (`main.tscn`).

Controls:

- Left-click and drag on the canvas: draw.
- Right-click and drag: erase (paints the white background colour).
- Click a colour swatch to choose a colour, or the Godot logo to use it as a stamp.
- Slider: brush size.
- **Cube** / **Sphere** buttons: switch the 3D preview mesh.

## Design

- [GDD.md](GDD.md): the recovered game design document (identical copy of
  `design/GDD.md`).
- [design/DECK.html](design/DECK.html): slide deck for review.
- [design/IMPLEMENTATION-MAP.md](design/IMPLEMENTATION-MAP.md): feature → scene/script paths.
- [design/decisions.md](design/decisions.md): open questions.

The GDD is a **recovered, unapproved description** of what the code does,
produced by Walker's `/gdd reverse` pass in silent mode. No design gate has been
signed.

## Source & license

An independent, title-only runtime adaptation of Godot `2d/drawable_textures`,
source commit `a3b5c113112f77291d5f3d1360f33a882fdc52f7`, by the Godot Engine
contributors. The original demo, assets, UIDs and source attribution are
preserved. The upstream MIT license is retained in LICENSE.md. Walker added a
headless input/state test, not fabricated gameplay.

## Status

The import, the runtime startup and 17 headless state assertions pass. Actual
GPU painting, erasing, edge clipping, texture appearance on meshes, and both
native-4K Liam films remain pending. See FRICTIONAL.md for the evidence and its
limitations.

Repository: https://github.com/nikbearbrown/walker-2d-drawable-textures
