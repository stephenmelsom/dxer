# Inside Playdate

Copyright © Panic Inc.  

Table of Contents

- [1. What is Playdate?](#_what_is_playdate)
  - [1.1. Playdate specifications](#_playdate_specifications)
  - [1.2. Playdate hardware naming conventions](#_playdate_hardware_naming_conventions)
- [2. Contents of the SDK](#_contents_of_the_sdk)
- [3. Installation](#_installation)
- [4. Writing a game](#_writing_a_game)
  - [4.1. Choosing your development language](#_choosing_your_development_language)
  - [4.2. Structuring your project](#_structuring_your_project)
  - [4.3. Compiling a project](#_compiling_a_project)
    - [Set `PLAYDATE_SDK_PATH` Environment Variable](#_set_playdate_sdk_path_environment_variable)
  - [4.4. Using the Playdate Simulator](#using-playdate-simulator)
    - [Running your game](#_running_your_game)
    - [Running your game on Playdate hardware](#_running_your_game_on_playdate_hardware)
    - [Using your Playdate to control the Simulator](#_using_your_playdate_to_control_the_simulator)
  - [4.5. Using the Nova extension](#usingNova)
  - [4.6. Game metadata](#pdxinfo)
  - [4.7. Saving game state](#saving-state)
  - [4.8. Localization](#localization)
  - [4.9. Game size](#_game_size)
- [5. Developing in Lua](#developing-in-lua)
  - [5.1. A Basic Playdate Game in Lua](#basic-playdate-game)
  - [5.2. Playdate Lua API conventions](#_playdate_lua_api_conventions)
    - [Arrays](#_arrays)
    - [Calling functions](#_calling_functions)
    - [Return values](#_return_values)
  - [5.3. Lua Tips](#lua-tips)
    - [Initialize variables with `local`](#_initialize_variables_with_local)
    - [Assign frequently-used objects to local variables](#_assign_frequently_used_objects_to_local_variables)
  - [5.4. Object-oriented programming in Lua](#_object_oriented_programming_in_lua)
  - [5.5. CoreLibs](#_corelibs)
- [6. Developing in C](#developing-in-c)
- [7. API reference](#api-reference)
  - [7.1. Playdate SDK Lua enhancements](#playdate-sdk-lua-enhancements)
    - [Additional assignment operators](#additional-assignment-operators)
    - [Table additions](#table-additions)
  - [7.2. System and Game Metadata](#system-and-game-metadata)
  - [7.3. Game flow](#game-flow)
    - [Callbacks](#_callbacks)
      - [Coroutines and playdate.update()](#_coroutines_and_playdate_update)
    - [Functions](#_functions)
  - [7.4. Game lifecycle](#game-lifecycle)
  - [7.5. Interacting with the System Menu](#system-menu)
    - [Menu Item operations](#menu-item)
  - [7.6. Localization](#_localization)
  - [7.7. Accessibility](#M-accessibility)
  - [7.8. Accelerometer](#accelerometer)
  - [7.9. Buttons](#buttons)
    - [Querying buttons directly](#_querying_buttons_directly)
    - [Button callbacks](#buttonCallbacks)
    - [Input handlers](#_input_handlers)
  - [7.10. Crank](#crank)
    - [Reading crank input](#_reading_crank_input)
      - [Querying crank status directly](#_querying_crank_status_directly)
      - [Crank callbacks](#_crank_callbacks)
      - [Input handlers](#_input_handlers_2)
    - [Crank sounds](#_crank_sounds)
  - [7.11. Input Handlers](#M-inputHandlers)
  - [7.12. Device Auto Lock](#M-autoLock)
  - [7.13. Date & Time](#date-and-time)
  - [7.14. Debugging](#M-debug)
    - [Advanced Debugging](#_advanced_debugging)
  - [7.15. Profiling](#M-profiling)
    - [Using the Simulator](#_using_the_simulator)
      - [Profiling performance](#_profiling_performance)
      - [Profiling memory usage](#_profiling_memory_usage)
      - [Profiling malloc calls in the Simulator](#_profiling_malloc_calls_in_the_simulator)
      - [Profiling malloc calls on the Device](#_profiling_malloc_calls_on_the_device)
  - [7.16. Display](#M-display)
    - [Display updating](#_display_updating)
    - [Other display properties](#_other_display_properties)
    - [Displaying an image](#_displaying_an_image)
  - [7.17. Easing functions](#M-easingFunctions)
  - [7.18. Files](#file)
    - [playdate.datastore](#M-datastore)
    - [playdate.file](#M-file)
      - [File reading and writing](#_file_reading_and_writing)
    - [Filesystem operations](#_filesystem_operations)
    - [.pdz files](#_pdz_files)
  - [7.19. Geometry](#M-geometry)
    - [Affine transform](#C-geometry.affineTransform)
    - [Arc](#C-geometry.arc)
    - [Line segment](#C-geometry.lineSegment)
    - [Point](#C-geometry.point)
    - [Polygon](#C-geometry.polygon)
    - [Rect](#C-geometry.rect)
    - [Size](#C-geometry.size)
    - [Utility functions](#_utility_functions)
    - [Vector](#C-geometry.vector2D)
  - [7.20. Graphics](#M-graphics)
    - [Conventions](#_conventions)
    - [Contexts](#_contexts)
    - [Clearing the Screen](#_clearing_the_screen)
    - [Image](#C-graphics.image)
      - [Image basics](#_image_basics)
      - [Image transformations](#_image_transformations)
      - [Image masks](#_image_masks)
      - [Image effects](#_image_effects)
      - [Other image stuff](#_other_image_stuff)
    - [Color & Pattern](#_color_pattern)
    - [Drawing](#_drawing)
      - [Line](#_line)
      - [Pixel](#_pixel)
      - [Rect](#_rect)
      - [Round rect](#_round_rect)
      - [Arc](#_arc)
      - [Circle](#_circle)
      - [Ellipse](#_ellipse)
      - [Polygon](#_polygon)
      - [Triangle](#_triangle)
      - [Nine slice](#C-graphics.nineSlice)
      - [Perlin noise](#_perlin_noise)
      - [QRCode](#_qrcode)
      - [Sine wave](#_sine_wave)
    - [Drawing Modifiers](#_drawing_modifiers)
      - [Clipping](#_clipping)
      - [Stencil](#_stencil)
      - [Drawing mode](#_drawing_mode)
      - [Lines & Strokes](#_lines_strokes)
    - [Offscreen Drawing](#_offscreen_drawing)
    - [Animation](#_animation)
      - [Animation loop](#C-graphics.animation.loop)
      - [Animator](#C-graphics.animator)
      - [Blinker](#C-graphics.animation.blinker)
    - [Scrolling](#_scrolling)
    - [Frame buffer](#_frame_buffer)
    - [Image table](#C-graphics.imagetable)
    - [Tilemap](#C-graphics.tilemap)
      - [How-To](#_how_to)
      - [Configuring](#_configuring)
      - [Setting tile values](#_setting_tile_values)
      - [Drawing](#_drawing_2)
      - [Collisions](#_collisions)
      - [Other tilemap functions](#_other_tilemap_functions)
    - [Sprite](#C-graphics.sprite)
      - [Sprite Basics](#_sprite_basics)
      - [Drawing images alongside sprites](#_drawing_images_alongside_sprites)
      - [Automatically animating sprites](#_automatically_animating_sprites)
      - [Clipping](#_clipping_2)
      - [Drawing](#_drawing_3)
      - [Group operations](#_group_operations)
      - [Sprite callbacks](#_sprite_callbacks)
      - [Sprite collision detection](#M-sprite-collisions)
      - [Sprites in tilemap-based games](#_sprites_in_tilemap_based_games)
    - [Text](#_text)
      - [Fonts](#C-graphics.font)
      - [Drawing Text](#_drawing_text)
    - [Video](#C-graphics.video)
  - [7.21. JSON](#M-json)
  - [7.22. Keyboard](#M-keyboard)
  - [7.23. Math](#M-math)
  - [7.24. Networking](#M-network)
    - [HTTP](#C-network.http)
    - [TCP](#M-network.tcp)
  - [7.25. Pathfinding](#M-pathfinder)
    - [Graph](#C-pathfinder.graph)
    - [Node](#C-playdate.pathfinder.node)
  - [7.26. Power](#power)
  - [7.27. Simulator-only functionality](#simulator)
    - [Simulator debug callbacks](#_simulator_debug_callbacks)
  - [7.28. Sound](#M-sound)
    - [Sampleplayer](#C-sound.sampleplayer)
    - [Fileplayer](#C-sound.fileplayer)
    - [Sample](#C-sound.sample)
    - [Channel](#C-sound.channel)
    - [Source](#C-sound.source)
    - [Synth](#C-sound.synth)
      - [Synth parameters](#_synth_parameters)
    - [Signal](#C-sound.signal)
    - [LFO](#C-sound.lfo)
    - [Envelope](#C-sound.envelope)
    - [Effects](#C-sound.effect)
    - [Bitcrusher](#C-sound.bitcrusher)
    - [Ring Modulator](#C-sound.ringmod)
    - [One pole filter](#C-sound.onepolefilter)
    - [Two pole filter](#C-sound.twopolefilter)
    - [Overdrive](#C-sound.overdrive)
    - [Delay line](#C-sound.delayline)
    - [Delay line tap](#C-sound.delaylinetap)
    - [Sequence](#C-sound.sequence)
    - [Track](#C-sound.track)
    - [Instrument](#C-sound.instrument)
    - [Control Signal](#C-sound.controlsignal)
    - [Mic Input](#_mic_input)
    - [Audio Output](#C-sound.output)
    - [Audio Device Time](#C-sound.time)
  - [7.29. Strings](#C-string)
  - [7.30. Timers](#C-timer)
    - [Standard timers](#_standard_timers)
    - [Delay timers](#_delay_timers)
    - [Value timers](#_value_timers)
    - [Key repeat timers](#_key_repeat_timers)
    - [Common timer methods](#C-commonTimerMethods)
    - [Common timer properties](#C-commonTimerProperties)
    - [Timer sample code](#_timer_sample_code)
  - [7.31. Frame timers](#C-frameTimer)
    - [Standard frame timers](#_standard_frame_timers)
    - [Delay frame timers](#_delay_frame_timers)
    - [Value frame timers](#_value_frame_timers)
    - [Common frame timer methods](#C-commonFrameTimerMethods)
    - [Common frame timer properties](#C-commonFrameTimerProperties)
    - [Frame timer sample code](#_frame_timer_sample_code)
  - [7.32. UI components](#M-ui)
    - [Crank indicator](#C-ui.crankIndicator)
    - [Grid view](#C-ui.gridview)
      - [Drawing](#_drawing_4)
      - [Configuration](#_configuration)
      - [Scrolling](#_scrolling_2)
      - [Selection](#_selection)
      - [Properties](#_properties)
      - [Grid view sample code](#_grid_view_sample_code)
  - [7.33. Serial communication](#M-wired-networking)
  - [7.34. Playdate Mirror](#M-mirror)
  - [7.35. Garbage collection](#M-garbage-collection)
- [8. Hidden Gems](#hidden-gems)
  - [8.1. Lua enhancements](#_lua_enhancements)
  - [8.2. Debugging](#_debugging)
  - [8.3. Enhancing your game’s user experience](#_enhancing_your_games_user_experience)
  - [8.4. Buttons](#_buttons)
  - [8.5. Responding to device events](#_responding_to_device_events)
  - [8.6. Drawing](#_drawing_5)
  - [8.7. Effects](#_effects)
  - [8.8. Accessibility](#_accessibility)
  - [8.9. File I/O](#_file_io)
  - [8.10. Game logic](#_game_logic)
  - [8.11. Deployment](#_deployment)
  - [8.12. Odds & ends](#_odds_ends)
- [9. Getting Help](#getting-help)
  - [9.1. Where can I download the SDK?](#_where_can_i_download_the_sdk)
  - [9.2. Where do I go if I have questions about the SDK?](#_where_do_i_go_if_i_have_questions_about_the_sdk)
  - [9.3. Where do I report bugs or issues relating to the SDK?](#_where_do_i_report_bugs_or_issues_relating_to_the_sdk)
  - [9.4. List of Helpful Libraries and Code](#_list_of_helpful_libraries_and_code)
- [10. Legal information](#_legal_information)

## 1. What is Playdate?

Playdate is a curious handheld gaming console.

Playdate players collectively share the experience of a curated selection of video games made by independent developers, revealed one at a time on a fixed schedule. A collection of these games is known as a "season", analogous to a season of a television show.

Playdate developers write their games using the simple scripting language Lua, and asset creation tools they are already familiar with.

### 1.1. Playdate specifications

Display  
- Monochrome (1-bit) memory LCD display

- 400 x 240 pixel resolution

- Refreshed at 30 frames-per-second (fps) by default, maximum 50 fps

Controls  
- Eight-way directional control (D-pad)

- Two primary buttons

- Menu button

- Lock button

- Collapsible crank

- Accelerometer

Sound  
- Internal speaker

- Microphone

- Headphone jack supporting mic input

Connectivity  
- Wi-Fi

- Bluetooth

Memory & Storage  
- 16MB RAM

- 4GB flash storage

### 1.2. Playdate hardware naming conventions

![playdate definitions](Inside%20Playdate/playdate-definitions.png)

Figure 1. A Playdate and the name of its components.

Lock button  
The top-edge metal button, which sleeps and wakes the system. Referred to as the capital-L "Lock button".

Menu button  
The top-right button on the face of the device, with a dot in its center. This presents the System Menu. Referred to as the capital-M "Menu button".

D-pad  
The D is capitalized if the term is at the beginning of the sentence; otherwise, it is "d-pad".

A button/B button  
"A" and "B" are capitalized; the "b" in "button" is not.

Crank  
The action of taking out the crank is called *extending* the crank. Putting it away is *stowing* the crank. If the crank is turned in the direction shown in the illustration below, it is said to be turning *forward*. The opposite direction is *backward*.

![crank rotation](Inside%20Playdate/crank-rotation.png)

Figure 2. Playdate cranking direction.

## 2. Contents of the SDK

This SDK contains:

- Software tools to compile your game

- A device Simulator to test your game

- A set of libraries for common functions you can use in your game

- Some fonts and other assets you can use in your game

- Some example code and games

- Documentation

## 3. Installation

After [downloading the SDK](https://play.date/dev/) for your desired platform you will need to complete the installation:

- MacOS: Run the SDK installer application

- Windows: Extract the SDK and run the SDK installer application

- Linux

  1.  Extract the SDK folder archive

  2.  Move the SDK folder to your desired user-writable location

  3.  Run the `setup.sh` script inside the SDK folder to complete the installation

## 4. Writing a game

### 4.1. Choosing your development language

Most Playdate games are [written in Lua](#developing-in-lua) for ease of development, but games with the strictest performance needs can be [written partially or entirely in C](#developing-in-c). See the associated sections for information on which might be the right choice for you.

### 4.2. Structuring your project

Place all scripts and assets together in a single project directory.

Your source directory must, at minimum, contain one Lua script called *main.lua*. This script can source other scripts if necessary via the *import* statement. The Playdate runtime uses *import* instead of the standard Lua *require* function, and it behaves a little differently: All files imported from main.lua (and imported from files imported from main.lua, and so on) are compiled into a single pdz file, and *import* runs the code from the file only once. A second *import* call from **anywhere** in the pdz will do nothing.

```lua
a.lua:
  return "hello"

b.lua:
  print("b says " .. import "a" or "nil")

main.lua:
  print(import "a" or "nil")
  import "b"
```

prints the following:

```lua
  hello
  b says nil
```

Though Lua projects can be organized in many ways, here is a suggested structure:

```lua
[myProjectName]/
    source/
        main.lua
        ...and other .lua files
        images/
            [myImageFile1].png
            [myImageFile2].png
            ...and so on
        sounds/
            [myAudioFile1].wav
            [myAudioFile2].mp3
            ...and other ADPCM- or MP3-formatted files
    support/
        Project files including Photoshop assets, project outlines, etc.
```

With this structure, you can do the following:

- *Import a Lua file* via an `import "myLuaFile"` at the start of your file.

- *Load an image* with `myImage = playdate.graphics.image.new("images/myImageFile")`

- *Load a sound* with `mySound = playdate.sound.sampleplayer.new("sounds/mySoundFile")`

- If your project will be object-oriented, *create a subclass* ***B*** of class ***A*** in file `B.lua`, like so:

```lua
import "A"
class("B").extends(A)

function B:init()
    B.super.init(self) -- calls superclass initializer
    -- initialization code goes here
end
```

Note that we use forward slashes `/` for path separators everywhere. Windows style backslashes `\` might work in the Windows simulator but will break everywhere else, including on the device.

### 4.3. Compiling a project

Playdate projects are compiled with the command line tool **`pdc`** (for "Playdate Compiler").

#### Set `PLAYDATE_SDK_PATH` Environment Variable

On **macOS**, it is recommended, but not required.

On **Linux**, it is required for CMake and Make files, and recommended for Lua projects.

On **Windows**, it is required for CMake files (see the *Building on Windows* section in the [***Inside Playdate for C***](#developing-in-c) docs for instructions), and recommended for Lua projects

Add the following line to your shell’s startup file (*~/.bash_profile* or *~/.bashrc* for **bash**, or *~/.zprofile* if you use **zsh**, etc.). Replace `<path to SDK>` placeholder text with the SDK location:

    export PLAYDATE_SDK_PATH=<path to SDK>

|      |                                                                                                                                  |
|------|----------------------------------------------------------------------------------------------------------------------------------|
| Note | The **`pdc`** compiler will use this value for the default location of the SDK if it is not specified using the `-sdkpath` flag. |

|     |                                                                                                                                                                                      |
|-----|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Tip | You may also want to add `<path to SDK>/bin` to your shell `$PATH` variable. This allows running `pdc`, `pdutil` and the Simulator from any location without a fully qualified path. |

**`pdc`** requires two arguments: the input (source) directory, and an output directory.

    $ pdc MyGameSource MyGame.pdx

The output directory, by convention, should end with the extension *.pdx*. This directory will appear as a single-icon bundle in Finder. It will contain the compiled source as well as any files that weren’t recognized as Lua source, such as images, sounds, or data files.

Passing the `-s` option to **`pdc`** will strip debugging information from the output files.

To specify folders outside of the project source folder or the SDK as locations for files to be imported, you can set the `PLAYDATE_LIB_PATH` environment variable, or pass them in using the `-I` or `--libpath` command-line flag.

    $ export PLAYDATE_LIB_PATH=~/pddev/Libs
    $ pdc -I ~/pddev/OtherLibs MyGameSource MyGame.pdx

In this case, **`pdc`** will first search the `MyGameSource` folder, then the `OtherLibs` folder, then `Libs`, and finally the SDK folder when locating files via the `import` command.

A few other helpful command line arguments:

    -v/--verbose: verbose mode, gives info about what the compiler is doing
    -q/--quiet: quiet mode, suppresses non-error output
    -k/--skip-unknown: skip unrecognized files instead of copying them to the pdx folder

And finally, to tell **`pdc`** to ignore specific files or folders (other than expected files like main.lua) in the source folder, add it to a file called `.pdcignore` in the source folder; e.g.

    images/logo.bak.png
    test

will keep both the file `logo-old.png` in the `images` subfolder and the entire `test` folder from getting compiled. Empty lines and lines starting with `#` are ignored. Wildcard/regex is not currently supported.

### 4.4. Using the Playdate Simulator

The **Playdate Simulator** is an application that mimics the Playdate device, and makes Playdate development quick and easy. The Simulator not only runs Playdate applications, but can also emulate the functionality of Playdate’s controls, including its crank and accelerometer.

Games running in the Simulator can be controlled by the on-screen GUI, or keyboard equivalents. The Simulator can also be controlled by a select number of a compatible game controllers or the Playdate console itself, if connected.

#### Running your game

To run your game, take one of these three approaches:

1.  Launch the Playdate Simulator app.

    - Do one of the following to choose which game to run:

      - Choose **Open** from the **File** menu to select the *.pdx* folder you’d like to run.

      - Drag your *.pdx* folder onto the Simulator window.

2.  Double-click on a *.pdx* folder.

3.  If you’re using Nova as your development environment, press Command+R to launch the Simulator and start your game.

|         |                                                                                                                                                                                                                 |
|---------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Caution | Game performance is considerably faster in the Simulator than on the Playdate hardware. Please take that into consideration when developing your game, and make sure to periodically test on Playdate hardware. |

#### Running your game on Playdate hardware

1.  Attach your Playdate to your computer via USB cable.

2.  Turn on your Playdate by pushing the ***Unlock*** button on top.

3.  Run your game in the Playdate Simulator.

4.  Choose **Upload Game to Device** from the Simulator’s **Device** menu. After the game is uploaded to your Playdate, it will start running automatically.

|      |                                                                                                                                                                                                                            |
|------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Note | If you do not see a **Device** menu in the Simulator’s menubar, check to ensure your Playdate is *unlocked* (via the metal button on top of Playdate), *powered*, and *properly connected* to your computer via USB cable. |

#### Using your Playdate to control the Simulator

If you enjoy the rapid development the Playdate Simulator offers, while also wanting the tactile feel of Playdate controls, you can put your Playdate device into *controller mode* to control the Simulator with your Playdate hardware.

1.  Attach your Playdate to your computer via USB cable.

2.  Unlock your Playdate by pushing the metal *Lock* button on Playdate’s top edge.

3.  Press the button with the little Playdate on it that will appear in the lower right corner of the Simulator window.

4.  Choose **Use Device as Controller** in the menu that appears. Your Playdate’s inputs will now control the Simulator.

![device menu](Inside%20Playdate/device-menu.png)

Figure 3. The Playdate Simulator’s "Device" menu.

|      |                                                                                                                                                                                                                                                       |
|------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Note | If you do not see a button with a Playdate icon on the lower edge of the Simulator window, check to ensure your Playdate is *unlocked* (via the metal button on top of Playdate), *powered*, and *properly connected* to your computer via USB cable. |

### 4.5. Using the Nova extension

Mac users with Nova installed can make use of additional features provided by the Playdate extension. It offers syntax highlighting, autocompletion for Playdate API and allows you to compile, run and debug your project in the Simulator with a single keypress.

To install the extension:

1.  Install Nova on your Mac.

2.  Find the [Playdate extension in the Nova extension repository](https://extensions.panic.com/extensions/com.panic/com.panic.Playdate/).

3.  Click the "Install" button on the web page.

The best way to develop for Playdate using Nova is to create a Project for each Playdate game.

1.  After creating your project, click on the project name in the top left of the window tooolbar.

2.  In the **Build & Run** section of the resulting dialog, click the **plus (+)** button.

3.  Choose **Playdate Simulator** from the list of options to create a new configuration.

4.  Specify our project’s *Source* folder. If it is the default *./Source* or *./source*, then you don’t need to do anything.

5.  Click **Done** to finish.

6.  Press the **Run** (▶️) button in the upper left corner of the window to invoke the Playdate Simulator and run your game. (Make sure you have a *main.lua* file in your project.)

### 4.6. Game metadata

If a file named ***pdxinfo*** is present at the root of your project’s source directory, it will be used by the system to gather information about your game.

Here is a sample *pdxinfo* file:

Sample pdxinfo file

```lua
name=b360
author=Panic Inc.
description=When all you have is a ton of bricks, everything looks like a paddle.
bundleID=com.panic.b360
version=1.0
buildNumber=123
imagePath=path/to/launcher/assets
launchSoundPath=path/to/launch/sound/file
contentWarning=This game contains mild realistic violence and bloodshed.
contentWarning2=This game contains flashing content that may not be suitable for photosensitive epilepsy.
```

The compiler will automatically copy your game’s metadata from your project folder into the resulting game. The contents of the *pdxinfo* file are accessible via [`playdate.metadata`](#f-metadata).

|      |                                                                                                                                            |
|------|--------------------------------------------------------------------------------------------------------------------------------------------|
| Note | Image files are compiled to Playdate *.pdi* files by the `pdc` compiler. When referencing images use no extension or the *.pdi* extension. |

bundleID

A unique identifier for your game, in reverse DNS notation.

version

A game version number, formatted any way you wish, that is displayed to players. It is not used to compute when updates should occur.

buildNumber

A monotonically-increasing integer value used to indicate a unique version of your game. This can be set using an automated build process like Continuous Integration to avoid having to set the value by hand.

|           |                                                                                                                         |
|-----------|-------------------------------------------------------------------------------------------------------------------------|
| Important | For sideloaded games, `buildNumber` is required and is used to determine when a newer version is available to download. |

imagePath

A *directory of images* that will be used by the launcher.

Images should be named as follows:

*card.png*

The game’s main card image, visible in the launcher when the view mode is set to "cards". Must be 350 x 155 pixels.

*card-highlighted/*

A folder of images that will be played in a loop when your game is selected in the launcher when the view mode is set to "cards". Images should be named *`1.png`*, *`2.png`*, etc. Each image must be 350 x 155 pixels. This folder can optionally contain a text file called `animation.txt` with the format:

animation.txt

```lua
loopCount = 2
frames = 1, 2, 3x4, 4x2, 5, 5
introFrames = 1, 2x2, 3, 4x2
```

All three lines are optional. `loopCount` indicates the number of times the animation will repeat (indefinitely by default). `frames` is the sequence in which the frames will be shown. Add an `x#` after the frame image number to repeat the image for multiple animation frames. `introFrames` is a sequence of frames that will play once before the `frames` sequence begins, when the card is first highlighted. If a frame sequence is not specified, images will play in order from 1 to the last sequentially numbered image found.

*card-pressed.png*

Displayed on A button down in the launcher when the view mode is set to "cards". Must be 350 x 155 pixels.

*icon.png*

The game’s main icon image, visible in the launcher when the view mode is set to "list". Must be 32 x 32 pixels.

*icon-highlighted/*

A folder of images that will be played in a loop when your game is selected in the launcher when the view mode is set to "list". Images should be named *`1.png`*, *`2.png`*, etc. Each image must be 32 x 32 pixels. This folder can optionally contain a text file called `animation.txt` with same format as described for *card-highlighted*.

*icon-pressed.png*

Displayed on A button down in the launcher when the view mode is set to "list". Must be 32 x 32 pixels.

*launchImage.png*

An image that displays while your game is loading, before it is responsive, when the launcher is set to "card" view mode, or in "list" view mode if *launchImage-list.png* is not provided. Must be fullscreen 400 x 240 pixels, and should not contain transparency. In "card" view mode, this image will be used as the last frame in the game launch animation, if *launchImages/* are provided.

*launchImage-list.png*

An image that displays while your game is loading, before it is responsive, when the launcher is set to "list" view mode. Must be fullscreen 400 x 240 pixels, and should not contain transparency.

*launchImages/*

A folder of images (named *1.png*, *2.png*, …) that will be played as a transition animation at 20 frames per second when your game is launched when the view mode in the launcher is set to "cards".

Images can contain transparency, but should all be 400 x 240 pixels. See the provided sample game *Level 1-1* for an example. Before the game launch animation your game’s card image (or *card-highlighted*, or *card-pressed* image, if available) is drawn by the launcher centered on the screen, drawn in the rect (25, 43, 350, 155) so your animation should assume that image with transparent surrounding space as a starting frame.

*wrapping-pattern.png*

Optional, but if present, will be used as the pattern for the wrapping paper on newly-downloaded games that have yet to be unwrapped. The image dimensions should be 400 x 240 pixels. ([Template files](./Inside%20Playdate/wrapping-pattern-templates.zip) are available to help you design the wrapping-paper art for your game. This functionality can be tested in the simulator by selecting "Wrap Current Game" from the Playdate menu.)

At minimum, all games should include ***card.png***,

icon.png and a **\_launchImage.png** which will be displayed as the system loads the game.

launchSoundPath

*Optional.* Should point to the path of a short audio file to be played as the game launch animation is taking place.

contentWarning

*Optional.* A content warning that displays when the user launches your game for the first time. The user will have the option of backing out and not launching your game if they choose.

contentWarning2

*Optional.* A *second* content warning that displays on a second screen when the user launches your game for the first time. The user will have the option of backing out and not launching your game if they choose. Note: `contentWarning2` will only display if a `contentWarning` attribute is also specified.

|         |                                                                                                                                                                                                                         |
|---------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Caution | The string displayed on the content warning screen can only be so long before it will be truncated with an "…" character. Be sure to keep this in mind when designing your `contentWarning` and `contentWarning2` text. |

<img src="Inside%20Playdate/content-warning.png" width="400" height="240" alt="Content warning displayed on Playdate screen" />

Figure 4. Content warning displayed on a Playdate’s screen.

### 4.7. Saving game state

In most games, your users will expect that if they exit your game and come back, they’ll find the game in the same — or similar — state as when they left it.

To implement basic state saving functionality, do the following:

1.  Write a function that saves pertinent game data into a table.

2.  Serialize your table to a [playdate.datastore](#M-datastore). (If you need greater flexibility, you can use any of Playdate’s [File APIs](#files).)

3.  Implement the functions [playdate.gameWillTerminate()](#c-gameWillTerminate) and [playdate.deviceWillSleep()](#c-deviceWillSleep) and invoke your `saveGameData` function in each.

4.  Write code that executes near the beginning of your game that will load game state data from your [datastore](#M-datastore) into a table. Populate your game structures with the saved data in the table.

An example of basic state saving functionality

```lua
-- Some examples of game data
local level = 1
local health = 100

-- Function that saves game data
function saveGameData()
    -- Save game data into a table first
    local gameData = {
        currentLevel = level,
        currentHealth = health
    }
    -- Serialize game data table into the datastore
    playdate.datastore.write(gameData)
end

-- Automatically save game data when the player chooses
-- to exit the game via the System Menu or Menu button
function playdate.gameWillTerminate()
    saveGameData()
end

-- Automatically save game data when the device goes
-- to low-power sleep mode because of a low battery
function playdate.gameWillSleep()
    saveGameData()
end

-- Call near the start of your game to load saved data
local gameData = playdate.datastore.read()
-- If game data has never been saved, the read value will
-- be 'nil', so check if the game data exists first
if gameData then
    -- Populate game structures with the saved data
    level = gameData.currentLevel
    health = gameData.currentHealth
end
```

### 4.8. Localization

Localization in Playdate is achieved through the use of string lookup files. Currently, English and Japanese are supported. The files should be called *en.strings* and *jp.strings* respectively and should be placed in the root of the game’s *source* folder.

The format of a *.strings* file is as follows:

Sample en.strings file

    "greeting" = "Howdy"
    "farewell" = "Goodbye"
    -- comments are allowed
    "video game" = "video game"

The corresponding *jp.strings* file would be:

Sample jp.strings file

    "greeting" = "こんにちは"
    "farewell" = "さようなら"
    -- comments are allowed
    "video game" = "ビデオゲーム"

Refer to the API reference for how to retrieve or draw localized text.

### 4.9. Game size

Playdate has 4GB of flash storage. While that is a decent amount, it isn’t inexhaustible.

What’s a good size for a Playdate game? From what we’ve seen so far, a typical Playdate game might be in the 20-40MB range. Some — primarily those that use synthesized audio — are much smaller, even less than 100KB. Large games with a lot of audio can grow to be 100MB or more.

Out of respect for Playdate owners, we ask that you try to keep your games closer to that average size of 20-40MB. (Of course, you can make your game as big as you want — and maybe there is some spectacular 400MB game out there just waiting to be written. Shy of that, however, we — and the Playdate owners you’re targeting — would prefer it if you keep the size down.)

The biggest culprit in blowing up game size is ***audio***. If your game is large due to the inclusion of a lot of audio, we recommend:

1.  Ensuring your audio is compressed. [See here for some tips](#M-sound-prep).

2.  If your audio is already compressed, consider [synthesized audio](#C-sound.synth), using the rich set of APIs provided. Or consider simply using less audio.

## 5. Developing in Lua

Lua is a great language for writing Playdate games. Its easy to use, and enables speedy development. Lua’s main drawback is performance, including sporadic hits due to garbage collection. For games with moderate performance requirements, these drawbacks should be manageable.

Your game can use any of Lua’s standard features. Please refer to the [Lua 5.4 manual](http://www.lua.org/manual/5.4/) for detailed information on the language itself.

Our build of the Lua runtime is configured to use 32-bit numbers.

### 5.1. A Basic Playdate Game in Lua

To showcase basic Playdate API features, we’ll implement a little game in Lua. (You can code this in C if you want as well — the concepts are similar.) All this game does is display a sprite on a background. The sprite can be moved by pressing on the Playdate’s d-pad.

And that’s it! But there’s hopefully enough here to provide a good framework for your own game.

A sample Playdate main.lua file.

```lua
-- Name this file `main.lua`. Your game can use multiple source files if you wish
-- (use the `import "myFilename"` command), but the simplest games can be written
-- with just `main.lua`.

-- You'll want to import these in just about every project you'll work on.

import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

-- Declaring this "gfx" shorthand will make your life easier. Instead of having
-- to preface all graphics calls with "playdate.graphics", just use "gfx."
-- Performance will be slightly enhanced, too.
-- NOTE: Because it's local, you'll have to do it in every .lua source file.

local gfx <const> = playdate.graphics

-- Here's our player sprite declaration. We'll scope it to this file because
-- several functions need to access it.

local playerSprite = nil

-- A function to set up our game environment.

function myGameSetUp()

    -- Set up the player sprite.

    local playerImage = gfx.image.new("Images/playerImage")
    assert( playerImage ) -- make sure the image was where we thought

    playerSprite = gfx.sprite.new( playerImage )
    playerSprite:moveTo( 200, 120 ) -- this is where the center of the sprite is placed; (200,120) is the center of the Playdate screen
    playerSprite:add() -- This is critical!

    -- We want an environment displayed behind our sprite.
    -- There are generally two ways to do this:
    -- 1) Use setBackgroundDrawingCallback() to draw a background image. (This is what we're doing below.)
    -- 2) Use a tilemap, assign it to a sprite with sprite:setTilemap(tilemap),
    --       and call :setZIndex() with some low number so the background stays behind
    --       your other sprites.

    local backgroundImage = gfx.image.new( "Images/background" )
    assert( backgroundImage )

    gfx.sprite.setBackgroundDrawingCallback(
        function( x, y, width, height )
            -- x,y,width,height is the updated area in sprite-local coordinates
            -- The clip rect is already set to this area, so we don't need to set it ourselves
            backgroundImage:draw( 0, 0 )
        end
    )

end

-- Now we'll call the function above to configure our game.
-- After this runs (it just runs once), nearly everything will be
-- controlled by the OS calling `playdate.update()` 30 times a second.

myGameSetUp()

-- `playdate.update()` is the heart of every Playdate game.
-- This function is called right before every frame is drawn onscreen.
-- Use this function to poll input, run game logic, and move sprites.

function playdate.update()

    -- Poll the d-pad and move our player accordingly.
    -- (There are multiple ways to read the d-pad; this is the simplest.)
    -- Note that it is possible for more than one of these directions
    -- to be pressed at once, if the user is pressing diagonally.

    if playdate.buttonIsPressed( playdate.kButtonUp ) then
        playerSprite:moveBy( 0, -2 )
    end
    if playdate.buttonIsPressed( playdate.kButtonRight ) then
        playerSprite:moveBy( 2, 0 )
    end
    if playdate.buttonIsPressed( playdate.kButtonDown ) then
        playerSprite:moveBy( 0, 2 )
    end
    if playdate.buttonIsPressed( playdate.kButtonLeft ) then
        playerSprite:moveBy( -2, 0 )
    end

    -- Call the functions below in playdate.update() to draw sprites and keep
    -- timers updated. (We aren't using timers in this example, but in most
    -- average-complexity games, you will.)

    gfx.sprite.update()
    playdate.timer.updateTimers()

end
```

Playdate’s API is exposed in a Lua namespace called `playdate`. Our API is explained in detail [later in this document](#api-reference).

### 5.2. Playdate Lua API conventions

#### Arrays

By convention, Lua arrays are 1-indexed. It is recommended that you follow this idiom to avoid confusion with other Lua code. (Arrays are in fact implemented as a specialized form of tables, which are the only container type in Lua. One of the most notable consequences of this is that arrays cannot contain nil values, since a nil value represents the end of the array.)

#### Calling functions

***Class/table functions*** are invoked with a *period*, as in `myTable.function(a, b, c)`.

***Instance functions*** are invoked with a *colon*, as in `myObject:function(a, b, c)`.

Why is this? The colon version passes the table itself as an implicit first argument to the function. This is generally used to simulate the object-oriented programming concept of "self" in Lua, which does not have "objects", "classes" or any other OOP affordances built-in. Again, we recommend you review the [official Lua 5.4 reference manual](https://www.lua.org/manual/5.4/) to make sure you understand the difference. Playdate, through CoreLibs, provides a simple implementation of Lua "objects" which you can choose to use or not use as you see fit.

|         |                                                                                                        |
|---------|--------------------------------------------------------------------------------------------------------|
| Caution | Confusing these two invocation methods can result in very-difficult-to-track-down bugs, so be careful! |

#### Return values

Some APIs return *objects* and others return a list of scalar values. Make sure you know what type of value is being returned! To make things even more confusing, some "objects" are Lua tables but others are Lua *userdata* that can have metamethods defined to provide table-like access to properties.

```lua
-- returns a rect object
r1 = playdate.geometry.rect.new(5, 5, 10, 10)
r2 = playdate.geometry.rect.new(8, 8, 10, 10)
intersection = r1:intersection(r2)
print(intersection.x, intersection.y, intersection.width, intersection.height)

-- returns a rect using a list of return values
x, y, w, h = playdate.geometry.rect.fast_intersection(5, 8, 5, 8, 10, 10, 10, 10)
print(x, y, w, h)
```

|     |                                                                                            |
|-----|--------------------------------------------------------------------------------------------|
| Tip | You can use the Lua function `table.unpack(table)` to turn any table’s values into a list. |

### 5.3. Lua Tips

#### Initialize variables with `local`

You should almost always use `local` in your variable initializers to narrow your variable’s scope to the current block. Not doing this will perhaps unnecessarily broaden your variable’s scope. Also, globals are slower to access during runtime than locals.

```lua
function MyClass:myFunction(a, b, c)

    -- You probably want to do this:
    local x, y, z = a*a, b*b, c*c

    -- …and not this. Here, x, y, and z are defined as globals.
    x, y, z = a*a, b*b, c*c

    return x, y, z
end
```

#### Assign frequently-used objects to local variables

If you are frequently accessing playdate API objects like `playdate.graphics`, performance will increase by assigning that object to a local variable at the beginning of your source file. (It’ll also make your code less verbose.) So instead of this:

```lua
playdate.graphics.setColor(playdate.graphics.kColorWhite)
playdate.graphics.drawRect(14, 14, 22, 22)
playdate.graphics.setColor(playdate.graphics.kColorBlack)
playdate.graphics.fillRect(15, 15, 20, 20)
```

Do this:

```lua
local gfx <const> = playdate.graphics -- do this at the top of your source file
-- (<const> is a Lua constant declaration that will improve performance slightly)

...

gfx.setColor(gfx.kColorWhite)
gfx.drawRect(14, 14, 22, 22)
gfx.setColor(gfx.kColorBlack)
gfx.fillRect(15, 15, 20, 20)
```

...and you’ll only be doing *one* look-up of the `playdate` and `graphics` objects in the global namespace, instead of six.

### 5.4. Object-oriented programming in Lua

Lua does not offer built-in support for object-oriented programming of any kind. Some developers like to use language extensions to provide an "OOP-like" environment, but you should have an understanding of what is happening behind the scenes.

This is purely a personal preference. There is no need for you to use object-oriented programming techniques, unless you want to.

CoreLibs provides a basic object-oriented class system. ***Object*** is the base class all new subclasses inherit from.

|           |                                                           |
|-----------|-----------------------------------------------------------|
| Important | You must import *CoreLibs/object* to use these functions. |

New Object subclasses can be created as follows:

```lua
class(ClassName, [properties], [namespace]).extends(ParentClass)
```

Where `properties` is a table of default key/value pairs for the class. If a parent class is not provided, Object will be used.

So, to create a `Tree` class:

```lua
class('Tree').extends()
```

or

```lua
class('Tree', {color = 'Brown'}).extends(Object)
```

And to create a subclass of `Tree`:

```lua
class('Oak').extends(Tree)
```

Classes are provided with an ***init*** function. The subclass decides how many and what type of arguments its init function takes:

```lua
function Oak:init(age, height)
    Oak.super.init(self, age)
    self.height = height
end
```

The init function will normally want to call its superclass’s implementation of init and must use the syntax above. (Calling `Oak.super:init(age)` would pass *super* as self, which will lead to incorrect behavior.)

Instances of a class are created by calling the class as a function:

```lua
oakInstance = Oak(age, height)
```

Class names can be accessed via the ***className*** property:

```lua
oakInstance.className -- equals 'Oak'
```

The base Object class defines an `isa()` function:

```lua
oakInstance:isa(Tree) -- returns true
```

A debugging function `Object:tableDump([indent], [table])` is provided to print all key/value pairs from the object and its superclasses.

```lua
oakInstance:tableDump()
```

### 5.5. CoreLibs

In addition to the default Playdate functions, a set of optional utility libraries named ***CoreLibs*** is available for you to use. CoreLibs provides functionality for such things as managing sprites, handling timers, animation curves, collision detection, and more.

CoreLibs is itself written in Lua and can be inspected in the SDK in the *CoreLibs* directory. Documentation for each of the CoreLibs is detailed later in this document. Use of each of the CoreLibs requires an `import "CoreLibs/[nameOfLibrary]"` in your game source file, and will be noted when necessary.

## 6. Developing in C

If your Playdate game requires maximum performance, C is the best choice.

Parts of your game, or the entire game if desired, can be written in C using the Playdate C API. For details, see [Inside Playdate with C](./Inside%20Playdate%20with%20C.html). There are also a few examples in the C_API/Examples folder that should help get you started.

We are still in the process of adding more functions to the C API, and creating more examples.

## 7. API reference

### 7.1. Playdate SDK Lua enhancements

#### Additional assignment operators

Lua does not by default support assignment operators like `+=` and `-=` that are common in other languages. As a convenience for developers, the Playdate SDK adds the following:

|       |                            |
|-------|----------------------------|
| `+=`  | Addition                   |
| `-=`  | Subtraction                |
| `*=`  | Multiplication             |
| `/=`  | Division                   |
| `//=` | Integer division           |
| `%=`  | Modulo                     |
| `<<=` | Shift left                 |
| `>>=` | Shift right                |
| `&=`  | Bitwise AND                |
| `|=`  | Bitwise OR                 |
| `^=`  | Exponent (not bitwise XOR) |

#### Table additions

The Playdate SDK offers some convenience functions for handling Lua tables, beyond what is available in Lua itself:

table.indexOfElement(table, element)

Returns the first index of *element* in the given array-style table. If the table does not contain *element*, the function returns nil.

table.getsize(table)

Returns the size of the given table as multiple values (*arrayCount*, *hashCount*).

table.create(arrayCount, hashCount)

Returns a new Lua table with the array and hash parts preallocated to accommodate *arrayCount* and *hashCount* elements respectively.

|     |                                                                                                                                                                                                                                                                                                                               |
|-----|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Tip | If you can make a decent estimation of how big your table will need to be, `table.create()` can be much more efficient than the alternative, especially in loops. For example, if you know your array is always going to contain approximately ten elements, say `myArray = table.create( 10, 0 )` instead of `myArray = {}`. |

table.shallowcopy(source, \[destination\])

`shallowcopy` returns a shallow copy of the *source* table. If a *destination* table is provided, it copies the contents of *source* into *destination* and returns *destination*. The copy will contain references to any nested tables.

table.deepcopy(source)

`deepcopy` returns a deep copy of the *source* table. The copy will contain copies of any nested tables.

### 7.2. System and Game Metadata

playdate.apiVersion()

Returns two values, the current API version of the Playdate runtime and the minimum API version supported by the runtime.

playdate.metadata

The `playdate.metadata` table contains the values in the current game’s [pdxinfo](#pdxinfo) file, keyed by variable name. To retrieve the version number of the game, for example, you would use `playdate.metadata.version`.

Changing values in this table at run time has no effect.

### 7.3. Game flow

#### Callbacks

playdate.update()

Implement this callback and Playdate OS will call it once per frame. This is the place to put the main update-and-draw code for your game. Playdate will attempt to call this function by default 30 times per second; that value can be changed by calling [playdate.display.setRefreshRate()](#f-display.setRefreshRate).

|      |                                                                                                                                                                                                                                                                                                                                           |
|------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Note | If your `update()` function takes too long to execute, Playdate OS may not be able to call it as often as specified by the current refresh rate. In this case, Playdate OS will simply try and call it as often as it can, with a not-to-exceed rate of [playdate.display.getRefreshRate()](#f-display.getRefreshRate) frames per second. |

##### Coroutines and playdate.update()

If you are familiar with [Lua coroutines](https://www.lua.org/pil/9.1.html), it’s useful to know that `playdate.update()` is invoked as a coroutine. This allows you to call `coroutine.yield()` during execution of lengthy processes inside `update()`, facilitating more frequent screen updates by Playdate OS.

For example, while loading assets at the beginning of execution, you could use coroutines to aid in displaying a progress bar:

Example: How to use coroutine.yield() in playdate.update().

```lua
local allImagesProcessed = false

-- our main update function, called every 0.033 seconds by Playdate OS.
function playdate.update()

    if allImagesProcessed == false then

        -- process images
        for i = 1, #images do

            -- some time-consuming process…
            processImage( images[i] )

            -- draw a progress bar
            local progressPercentage = i / #images
            playdate.graphics.fillRect( 100, 20, 200*progressPercentage, 40 )

            -- yield to the OS, giving it a chance to update the screen
            coroutine.yield()

            -- execution will resume here when the OS calls coroutine.resume()

        end

        allImagesProcessed = true

    else

        -- main game update and drawing code

    end

end
```

As an exercise, it’s worth removing the `coroutine.yield()` call from the above code to see how its execution differs. (Spoiler: all images will be processed before there are any screen redraws, rendering the progress bar useless.) It’s also an interesting exercise to attempt code that performs the same as above without use of the `.yield()` function. In this simple case it’s not terribly difficult — you need to save off your loop’s state after each iteration — but the code is messier, and it can quickly get unwieldy in more complex cases. `.yield()` makes things much easier.

For more on coroutine usage in games, [view this tutorial](https://edw.is/how-to-implement-action-sequences-and-cutscenes/#coroutines-basics).

#### Functions

playdate.wait(milliseconds)

Suspends callbacks to [`playdate.update()`](#c-update) for the specified number of milliseconds.

|     |                                                                                                                                                                                                                                                                                                                                                                       |
|-----|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Tip | `playdate.wait()` is ideal for pausing game execution to, for example, show a message to the player. Because `.update()` will not be called, the screen will freeze during `.wait()`. Audio will continue to play. Animation during this wait period is possible, but you will need to explicitly call [`playdate.display.flush()`](#f-display.flush) once per frame. |

|         |                                                                                                                                                                                                                                                                                                                                                              |
|---------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Caution | While timers should pause during `playdate.wait()` (assuming [`playdate.timer.updateTimers()`](#f-timer.updateTimers) and [`playdate.frameTimer.updateTimers()`](#f-frameTimer.updateTimers) are invoked during `playdate.update()`), [animators](#C-graphics.animator) will *not* pause during `playdate.wait()`. Be sure to account for this in your code. |

playdate.stop()

Stops per-frame callbacks to [playdate.update()](#c-update). Useful in conjunction with [playdate.display.flush()](#f-display.flush) if your program only does things in response to button presses.

playdate.start()

Resumes per-frame callbacks to [playdate.update()](#c-update).

playdate.restart(arg)

Reinitializes the Playdate runtime and restarts the currently running game. The optional string `arg` passed in is available after restart in [playdate.argv](#v-argv) as if it had been passed in on the command line when launching the simulator. The `arg` string will be split on spaces, but respecting quotes, when added to the argv list.

### 7.4. Game lifecycle

playdate.gameWillTerminate()

Called when the player chooses to exit the game via the System Menu or Menu button.

playdate.deviceWillSleep()

Called before the device goes to low-power sleep mode because of a low battery.

|           |                                                                                                                                |
|-----------|--------------------------------------------------------------------------------------------------------------------------------|
| Important | If your game saves its state, `playdate.gameWillTerminate()` and `playdate.deviceWillSleep()` are good opportunities to do it. |

playdate.deviceWillLock()

If your game is running on the Playdate when the device is locked, this function will be called. Implementing this function allows your game to take special action when the Playdate is locked, e.g., saving state.

playdate.deviceDidUnlock()

If your game is running on the Playdate when the device is unlocked, this function will be called.

playdate.gameWillPause()

Called before the system pauses the game. (In the current version of Playdate OS, this only happens when the device’s Menu button is pushed.) Implementing these functions allows your game to take special action when it is paused, e.g., updating the [menu image](#f-setMenuImage).

playdate.gameWillResume()

Called before the system resumes the game.

### 7.5. Interacting with the System Menu

Your game can add up to three menu items to the System Menu. Three types of menu items are supported: normal action menu items, checkmark menu items, and options menu items.

|           |                                                                                                                                                                                                                                                                                                    |
|-----------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Important | When titling your System Menu additions, try to give them names that demonstrate that they pertain to your game, and not Playdate overall. For example, the title "restart game" will be clearer to the player than just "restart" — the player might assume the latter will restart the hardware. |

```lua
local menu = playdate.getSystemMenu()

local menuItem, error = menu:addMenuItem("Item 1", function()
    print("Item 1 selected")
end)

local checkmarkMenuItem, error = menu:addCheckmarkMenuItem("Item 2", true, function(value)
    print("Checkmark menu item value changed to: ", value)
end)
```

playdate.getSystemMenu()

Returns a `playdate.menu` object. Use this to add your custom menu items.

playdate.menu:addMenuItem(title, callback)

*title* will be the title displayed by the menu item.

When this menu item is selected, the OS will:

1.  Hide the System Menu.

2.  Invoke your `callback` function.

3.  Unpause your game and call [playdate.gameWillResume](#c-gameWillResume).

If the returned [playdate.menu.item](#menu-item) is nil, a second `errorMessage` return value will indicate the reason the operation failed.

|      |                                                                                             |
|------|---------------------------------------------------------------------------------------------|
| Note | Playdate OS allows a maximum of **three** custom menu items to be added to the System Menu. |

playdate.menu:addCheckmarkMenuItem(title, \[initialValue\], callback)

Creates a new menu item that can be checked or unchecked by the player.

*title* will be the title displayed by the menu item.

*initialValue* can be set to `true` or `false`, indicating the checked state of the menu item. Optional, defaults to `false`.

If this menu item is interacted with while the system menu is open, *callback* will be called when the menu is closed, before [playdate.gameWillResume](#c-gameWillResume) is called. The callback function will be passed one argument, a boolean value, indicating the current value of the menu item.

If the returned [playdate.menu.item](#menu-item) is nil, a second `errorMessage` return value will indicate the reason the operation failed.

|      |                                                                                             |
|------|---------------------------------------------------------------------------------------------|
| Note | Playdate OS allows a maximum of **three** custom menu items to be added to the System Menu. |

playdate.menu:addOptionsMenuItem(title, options, \[initalValue\], callback)

Creates a menu item that allows the player to cycle through a set of options.

*title* will be the title displayed by the menu item.

*options* should be an array-style table of strings representing the states the menu item can have. Due to limited horizontal space, the option strings and title should be kept short for this type of menu item.

*initialValue* can optionally be set to any of the values in the options array.

If the value of this menu item is changed while the system menu is open, *callback* will be called when the menu is closed, before [playdate.gameWillResume](#c-gameWillResume) is called. The callback function will be passed one string argument indicating the currently selection option.

If the returned [playdate.menu.item](#menu-item) is nil, a second `errorMessage` return value will indicate the reason the operation failed.

|      |                                                                                             |
|------|---------------------------------------------------------------------------------------------|
| Note | Playdate OS allows a maximum of **three** custom menu items to be added to the System Menu. |

playdate.menu:getMenuItems()

Returns an array-style table containing all [playdate.menu.item](#menu-item)s your game has added to the menu.

|      |                                                                                                                                           |
|------|-------------------------------------------------------------------------------------------------------------------------------------------|
| Note | Items that were added to the System Menu by the operating system will not be returned via `getMenuItems()`, or via any other method call. |

playdate.menu:removeMenuItem(menuItem)

Removes the specified [playdate.menu.item](#menu-item) from the menu.

playdate.menu:removeAllMenuItems()

Removes from the referenced menu object all [playdate.menu.item](#menu-item)s added by your game.

|      |                                                                                                                     |
|------|---------------------------------------------------------------------------------------------------------------------|
| Note | Items that were added to the System Menu by the operating system cannot be removed by this operation, or any other. |

playdate.setMenuImage(image, \[xOffset\])

While the game is paused it can optionally provide an image to be displayed alongside the System Menu. Use this function to set that image.

*image* should be a 400 x 240 pixel [playdate.graphics.image](#C-graphics.image). All important content should be in the left half of the image in an area 200 pixels wide, as the menu will obscure the rest. The right side of the image will be visible briefly as the menu animates in and out.

Optionally, *xOffset* can be provided which must be a number between 0 and 200 and will cause the menu image to animate to a position offset left by *xOffset* pixels as the menu is animated in.

To remove a previously-set menu image, pass `nil` for the *image* argument.

#### Menu Item operations

playdate.menu.item:setCallback(callback)

Sets the callback function for this menu item.

playdate.menu.item:setTitle(newTitle)

Sets the title displayed for this menu item.

The `title` for a menu item can also be set using dot syntax.

playdate.menu.item:getTitle()

Returns the title displayed for this menu item.

playdate.menu.item:setValue(newValue)

Sets the value for this menu item. The value is of a different type depending on the type of menu item:

- normal: integer

- checkmark: boolean

- options: string

Values for any menu type can also be set using integers.

The `value` for a menu item can also be set using dot syntax.

playdate.menu.item:getValue()

Returns the value for this menu item.

### 7.6. Localization

playdate.getSystemLanguage()

Returns the current language of the system, which will be one of the constants *playdate.graphics.font.kLanguageEnglish* or *playdate.graphics.font.kLanguageJapanese*.

### 7.7. Accessibility

playdate.getReduceFlashing()

Returns *true* if the user has checked the "Reduce Flashing" option in Playdate Settings; *false* otherwise. Games should read this value and, if *true*, avoid visuals that could be problematic for people with sensitivities to flashing lights or patterns.

playdate.getFlipped()

Returns *true* if the user has checked the "Upside Down" option in Playdate Settings; *false* otherwise. (Upside Down mode can be convenient for players wanting to hold Playdate upside-down so they can use their left hand to operate the crank.)

Typically your game doesn’t need to anything in regards to this setting. But it is available in case your game wants to take some special actions, display special instructions, etc.

|           |                                                                                                                                                                                                                                                                                                                                        |
|-----------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Important | Reported d-pad directions are flipped when in Upside Down mode — RIGHT will be reported as LEFT, UP as DOWN, etc. — so that the d-pad will make sense to a user holding Playdate upside-down. However, the A and B buttons — since they are still labeled as "A" and "B" — retain their normal meanings and will be reported as usual. |

### 7.8. Accelerometer

playdate.startAccelerometer()

The accelerometer is off by default, to save a bit of power. If you will be using the accelerometer in your game, you’ll first need to call `playdate.startAccelerometer()` then wait for the next update cycle before reading its values. If you won’t be using the accelerometer again for a while, calling `playdate.stopAccelerometer()` will put it back into a low-power idle state.

playdate.stopAccelerometer()

Puts the accelerometer into a low-power idle state. (Though, to be honest, the accelerometer draws so little power when it’s running you’d never notice the difference.)

playdate.readAccelerometer()

If the accelerometer has been turned on with [playdate.startAccelerometer()](#f-startAccelerometer), returns the x, y, and z values from the accelerometer as a list. Positive x points right, positive y points to the bottom of the screen, and positive z points through the screen away from the viewer. For example, with the device held upright this function returns the values (0,1,0). With it flat on its back, it returns (0,0,1).

playdate.accelerometerIsRunning()

Returns true if the accelerometer is currently running.

Example: A simple ball rolling demo using the accelerometer

```lua
-- You can copy and paste this example directly as your main.lua file to see it in action
import "CoreLibs/graphics"

local function clamp(value, min, max)
    return math.max(math.min(value, max), min)
end

local x, y = 200, 120
-- Make sure to start the accelerometer to begin reading!
playdate.startAccelerometer()

-- A simple example of rolling around a ball on the screen using the accelerometer
function playdate.update()
    playdate.graphics.clear()

    -- We can get the accelerometer values by storing them in multiple variables
    local gravityX, gravityY, _gravityZ = playdate.readAccelerometer()

    -- Try orienting the Playdate flat and tilting it around
    x = clamp(x + gravityX * 10, 0, 400)
    y = clamp(y + gravityY * 10, 0, 240)
    playdate.graphics.fillCircleAtPoint(x, y, 10)
end
```

### 7.9. Buttons

There are several different methods for determining button presses.

#### Querying buttons directly

playdate.buttonIsPressed(button)

Returns true if *button* is currently being pressed.

*button* should be one of the constants:

- *playdate.kButtonA*

- *playdate.kButtonB*

- *playdate.kButtonUp*

- *playdate.kButtonDown*

- *playdate.kButtonLeft*

- *playdate.kButtonRight*

Or one of the strings "a", "b", "up", "down", "left", "right".

playdate.buttonJustPressed(button)

Returns true for *just one update cycle* if *button* was pressed. `buttonJustPressed` will not return true again until the button is released and pressed again. This is useful for, say, a player "jump" action, so the jump action is taken only once and not on every single update.

*button* should be one of the constants listed in [playdate.buttonIsPressed()](#f-buttonIsPressed)

playdate.buttonJustReleased(button)

Returns true for *just one update cycle* if *button* was released. `buttonJustReleased` will not return true again until the button is pressed and released again.

*button* should be one of the constants listed in [playdate.buttonIsPressed()](#f-buttonIsPressed)

playdate.getButtonState()

Returns the above data in one call, with multiple return values (*current*, *pressed*, *released*) containing bitmasks indicating which buttons are currently down, and which were pressed and released since the last update. For example, if the d-pad left button and the A button are both down, the *current* value will be (*playdate.kButtonA*\|*playdate.kButtonLeft*).

playdate.setButtonQueueSize(size)

When set, button up/down events on the D pad and the A and B buttons are added to a list instead of simply polled at the beginning of a frame, allowing the code to handle multiple taps on a given button in a single frame. At the default 30 FPS, a queue size of 5 should be adequate. At lower frame rates/longer frame times, the queue size should be extended until all button presses are caught. Additionally, when the button queue is enabled the button callbacks listed below are passed the event time as an argument.

#### Button callbacks

Playdate will attempt to call the following functions in your script when input events occur:

playdate.AButtonDown()

Called immediately after the player presses the A Button.

playdate.AButtonHeld()

Called after the A Button is held down for one second. This can be used for secondary actions (e.g., displaying a game world map, changing weapons).

playdate.AButtonUp()

Called immediately after the player releases the A Button.

playdate.BButtonDown()

Called immediately after the player presses the B Button.

playdate.BButtonHeld()

Called after the B Button is held down for one second. This can be used for secondary actions (e.g., displaying a game world map, changing weapons).

playdate.BButtonUp()

Called immediately after the player releases the B Button.

playdate.downButtonDown()

Called immediately after the player presses the down direction on the d-pad.

playdate.downButtonUp()

Called immediately after the player releases the down direction on the d-pad.

playdate.leftButtonDown()

Called immediately after the player presses the left direction on the d-pad.

playdate.leftButtonUp()

Called immediately after the player releases the left direction on the d-pad.

playdate.rightButtonDown()

Called immediately after the player presses the right direction on the d-pad.

playdate.rightButtonUp()

Called immediately after the player releases the right direction on the d-pad.

playdate.upButtonDown()

Called immediately after the player presses the up direction on the d-pad.

playdate.upButtonUp()

Called immediately after the player releases the up direction on the d-pad.

#### Input handlers

Button interactions can also be observed via [input handlers](#M-inputHandlers).

### 7.10. Crank

#### Reading crank input

There are multiple ways to determine how the player is interacting with the crank control:

##### Querying crank status directly

playdate.isCrankDocked()

Returns a boolean indicating whether or not the crank is folded into the unit.

|     |                                                                                                                                                                         |
|-----|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Tip | If your game requires the crank and `:isCrankDocked()` is true, you can use a [crank alert](#C-ui.crankIndicator) to notify the user that the crank should be extended. |

playdate.getCrankPosition()

Returns the absolute position of the crank (in degrees). Zero is pointing straight up parallel to the device. Turning the crank clockwise (when looking at the right edge of an upright device) increases the angle, up to a maximum value 359.9999. The value then resets back to zero as the crank continues its rotation.

```lua
local crankPosition = playdate.getCrankPosition()
```

playdate.getCrankChange()

Returns two values, *change* and *acceleratedChange*. *change* represents the angle change (in degrees) of the crank since the last time this function (or the [playdate.cranked()](#c-cranked) callback) was called. Negative values are anti-clockwise. *acceleratedChange* is change multiplied by a value that increases as the crank moves faster, similar to the way mouse acceleration works.

```lua
local change, acceleratedChange = playdate.getCrankChange()
```

playdate.getCrankTicks(ticksPerRevolution)

Returns the number of "ticks" — whose frequency is defined by the value of *ticksPerRevolution* — the crank has turned through since the last time this function was called. Tick boundaries are set at absolute positions along the crank’s rotation. Ticks can be positive or negative, depending upon the direction of rotation.

For example, say you have a movie player and you want your movie to advance 6 frames for every one revolution of the crank. Calling `playdate.getCrankTicks(6)` during each update will give you a return value of 1 as the crank turns past each 60 degree increment. (Since we passed in a 6, each tick represents 360 ÷ 6 = 60 degrees.) So `getCrankTicks(6)` will return a 1 as the crank turns past the 0 degree absolute position, the 60 degree absolute position, and so on for the 120, 180, 240, and 300 degree positions. Otherwise, 0 will be returned. (-1 will be returned if the crank moves past one of these mentioned positions while going in a backward direction.)

|           |                                                            |
|-----------|------------------------------------------------------------|
| Important | You must import *CoreLibs/crank* to use `getCrankTicks()`. |

Example: Reading crank input using getCrankTicks

```lua
import "CoreLibs/crank"

local ticksPerRevolution = 6

function playdate.update()
    local crankTicks = playdate.getCrankTicks(ticksPerRevolution)

    if crankTicks == 1 then
        print("Forward tick")
    elseif crankTicks == -1 then
        print("Backward tick")
    end
end
```

##### Crank callbacks

playdate.cranked(change, acceleratedChange)

For playdate.cranked(), *change* is the angle change in degrees. *acceleratedChange* is *change* multiplied by a value that increases as the crank moves faster, similar to the way mouse acceleration works. Negative values are anti-clockwise.

playdate.crankDocked()

This function, if defined, is called when the crank is docked.

playdate.crankUndocked()

This function, if defined, is called when the crank is undocked.

##### Input handlers

Crank interactions can also be observed via [input handlers](#M-inputHandlers).

#### Crank sounds

playdate.setCrankSoundsDisabled(disable)

*True* disables the default crank docking/undocking sound effects. *False* re-enables them. Useful if the crank sounds seem out-of-place in your game.

|      |                                                                           |
|------|---------------------------------------------------------------------------|
| Note | When your game terminates, crank sounds will automatically be re-enabled. |

### 7.11. Input Handlers

The InputHandlers architecture allows you to push and pop a series of `playdate.inputHandler` objects, each capable of handling any or all button and crank interactions. New input is propagated down the stack until it finds the first responder (or drops it altogether), which allows for switching out control schemes and temporarily stealing focus.

You can define an inputHandler as in the sample below, implementing just as few or as many handler functions as you want.

|      |                                                                                    |
|------|------------------------------------------------------------------------------------|
| Note | An inputHandlers object is just an ordinary Lua table. No subclassing is required. |

```lua
local myInputHandlers = {

    AButtonDown = function()
        -- do stuff
    end,

    cranked = function(change, acceleratedChange)
        -- do other stuff
    end,

    -- etc.
}
```

...and later, put them into effect by pushing them on the stack:

```lua
playdate.inputHandlers.push(myInputHandlers)
-- myInputHandlers are in effect

playdate.inputHandlers.pop()
-- original handlers are back now
```

The following functions can be defined in your custom inputHandlers table:

- `AButtonDown()`

- `AButtonHeld()`

- `AButtonUp()`

- `BButtonDown()`

- `BButtonHeld()`

- `BButtonUp()`

- `downButtonDown()`

- `downButtonUp()`

- `leftButtonDown()`

- `leftButtonUp()`

- `rightButtonDown()`

- `rightButtonUp()`

- `upButtonDown()`

- `upButtonUp()`

- `cranked(change, acceleratedChange)`

For definitions of how each of these functions works, see [Button Callbacks](#buttonCallbacks).

|      |                                                                                                                                      |
|------|--------------------------------------------------------------------------------------------------------------------------------------|
| Note | Since the playdate table is always at the bottom of the stack, existing *playdate.BButtonDown* definitions will work out of the box. |

playdate.inputHandlers.push(handler, \[masksPreviousHandlers\])

Pushes a new input handler onto the stack.

- *handler:* A table containing one or more custom input functions.

- *masksPreviousHandlers:* If true, input functions not defined in *handler* will not be called. If missing or false, the previously-pushed input handler tables will be searched for input functions missing from *handler*, cascading down to the default `playdate` table.

playdate.inputHandlers.pop()

Pops the last input handler off of the stack.

### 7.12. Device Auto Lock

Playdate will automatically lock if the user doesn’t press any buttons or use the crank for more than 3 minutes. In order for games that expect longer periods without interaction to continue to function, it is possible to manually disable the auto lock feature.

playdate.setAutoLockDisabled(disable)

*True* disables the 3 minute auto-lock feature. *False* re-enables it and resets the timer back to 3 minutes.

|      |                                                                       |
|------|-----------------------------------------------------------------------|
| Note | Auto-lock will automatically be re-enabled when your game terminates. |

|     |                                                                                                                                                                                                                             |
|-----|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Tip | If disabling auto-lock, developers should look for opportunities to re-enable auto-lock when appropriate. (For example, if your game is an MP3 audio player, auto-lock could be re-enabled when the user pauses the audio.) |

### 7.13. Date & Time

|           |                                                                                                                                                                                                                                                                     |
|-----------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Important | `playdate.getCurrentTimeMilliseconds()` and `playdate.getElapsedTime()` report game time, not real time. That is, when the game is not active — say, when the System Menu is visible, or when the Playdate is locked — that time is not counted by these functions. |

playdate.getCurrentTimeMilliseconds()

Returns the number of milliseconds the game has been *active* since launched.

playdate.resetElapsedTime()

Resets the high-resolution timer.

playdate.getElapsedTime()

Returns the number of seconds since `playdate.resetElapsedTime()` was called. The value is a floating-point number with microsecond accuracy.

playdate.getSecondsSinceEpoch()

Returns the number of seconds and milliseconds elapsed since midnight (hour 0), January 1 2000 UTC, as a list: *(seconds, milliseconds)*. This function is suitable for seeding the random number generator:

Sample code for seeding the random number generator

```lua
math.randomseed(playdate.getSecondsSinceEpoch())
```

playdate.getTime()

Returns a table with values for the local time, accessible via the following keys:

- *year*: 4-digit year (until 10,000 AD)

- *month*: month of the year, where 1 is January and 12 is December

- *day*: day of the month, 1 - 31

- *weekday*: day of the week, where 1 is Monday and 7 is Sunday

- *hour*: 0 - 23

- *minute*: 0 - 59

- *second*: 0 - 59 (or 60 on a leap second)

- *millisecond*: 0 - 999

playdate.getGMTTime()

Returns a table in the same format as [playdate.getTime()](#f-getTime), but in GMT rather than local time.

playdate.epochFromTime(time)

Returns the number of seconds and milliseconds between midnight (hour 0), January 1 2000 UTC and *time*, specified in local time, as a list: *(seconds, milliseconds)*.

*time* should be a table of the same format as the one returned by [playdate.getTime()](#f-getTime).

playdate.epochFromGMTTime(time)

Returns the number of seconds and milliseconds between midnight (hour 0), January 1 2000 UTC and *time*, specified in GMT time, as a list: *(seconds, milliseconds)*.

*time* should be a table of the same format as the one returned by [playdate.getTime()](#f-getTime).

playdate.timeFromEpoch(seconds, milliseconds)

Converts the epoch to a local date and time table, in the same format as the table returned by [playdate.getTime()](#f-getTime).

playdate.GMTTimeFromEpoch(seconds, milliseconds)

Converts the epoch to a GMT date and time table, in the same format as the table returned by [playdate.getTime()](#f-getTime).

playdate.getServerTime(function(time, error))

Queries the Playdate server for the current time, in seconds elapsed since midnight (hour 0), January 1 2000 UTC. This provides games with a reliable clock source, since the internal clock can be set by the user. The function is asynchronous, returning the server time to a callback function passed in. The callback function is given two arguments: the time (as a string, to avoid 32-bit rollover) if the query was successful, otherwise nil and an error string.

    playdate.getServerTime(function(time, error)
        if time ~= nil then print("server time: "..time)
        else print("server error: "..error)
        end
    end)

playdate.shouldDisplay24HourTime()

Returns true if the user has set the 24-Hour Time preference in the Settings program.

### 7.14. Debugging

Note that some [simulator-only functions](#simulator) may also provide assistance in debugging.

print(string)

Text output from `print()` will be displayed in the simulator’s console, in black if generated by a game running in the simulator or in blue if it’s coming from a plugged-in Playdate device. Printed text is also copied to stdout, which is helpful if you run the simulator from the command line.

|     |                                                                                                    |
|-----|----------------------------------------------------------------------------------------------------|
| Tip | You should ideally remove debugging print statements from your final games to improve performance. |

printTable(table)

Identical to `print()`, but instead of a string `printTable()` prints the contents of a table formatted for legibility.

|           |                                                        |
|-----------|--------------------------------------------------------|
| Important | You must import *CoreLibs/object* to use `printTable`. |

|     |                                                                                                    |
|-----|----------------------------------------------------------------------------------------------------|
| Tip | You should ideally remove debugging print statements from your final games to improve performance. |

playdate.argv

The first item in the `playdate.argv` array is the filename of the currently running pdx. If the simulator is launched from the command line, any extra arguments passed there are added to this array; additionally, the [playdate.restart(arg)](#f-restart) function puts its `arg` argument into the argv array, splitting the string on spaces outside of quoted ranges.

playdate.setNewlinePrinted(flag)

*flag* determines whether or not the print() function adds a newline to the end of the printed text. Default is *true*.

playdate.drawFPS(x, y)

Calculates the current frames per second and draws that value at *x, y*.

playdate.getFPS()

Returns the *measured, actual* refresh rate in frames per second. This value may be different from the *specified* refresh rate (see [playdate.display.getRefreshRate()](#f-display.getRefreshRate)) by a little or a lot depending upon how much calculation is being done per frame.

where()

Returns a single-line stack trace as a string. For example:

```lua
main.lua:10 foo() < main.lua:18 (from C)
```

Use `print(where())` to see this trace written to the console.

|           |                                                                  |
|-----------|------------------------------------------------------------------|
| Important | You must import *CoreLibs/utilities/where* to use this function. |

#### Advanced Debugging

The Simulator supports the [Debug Adapter Protocol](https://microsoft.github.io/debug-adapter-protocol/) to do advanced debugging such as setting breakpoints, stepping code and inspecting variables in Lua. On the Mac we recommend using the [Nova extension](#usingNova) for debugging. On Windows and Linux we recommend using the [Playdate Debug](https://github.com/midouest/vscode-playdate-debug) extension for Visual Studio Code.

### 7.15. Profiling

sample(name, function)

Suspect some code is running hot? Wrap it in an anonymous function and pass it to `sample()` like so:

```lua
sample("name of this sample", function()
        -- nested for loops, lots of table creation, member access...
end)
```

By moving around where you start and end the anonymous function in your code, you can get a better idea of where the problem lies.

Multiple code paths can be sampled at once by using different names for each sample.

|           |                                                                    |
|-----------|--------------------------------------------------------------------|
| Important | You must import *CoreLibs/utilities/sampler* to use this function. |

playdate.getStats()

Returns a table containing percentages of time spent in each system task over the last interval, if more than zero. Possible keys are

- `kernel`

- `serial`

- `game`

- `GC`

- `wifi`

- `audio`

- `trace`

- `idle`

|           |                                                                                                           |
|-----------|-----------------------------------------------------------------------------------------------------------|
| Important | `playdate.getStats()` only functions on a Playdate device. In the Simulator, this function returns `nil`. |

playdate.setStatsInterval(seconds)

`setStatsInterval()` sets the length of time for each sample frame of runtime stats. Set *seconds* to zero to disable stats collection.

#### Using the Simulator

##### Profiling performance

1.  Press the Sampler button.

    ![sampler button](Inside%20Playdate/sampler-button.png)

2.  The Sampler window appears.

    ![sampling menu](Inside%20Playdate/sampling-menu.png)
    Choose whether you want to sample:

    - Simulator performance in Lua code

    - Device performance in Lua code

    - Device performance in C code

3.  Press the `Sample` button in the upper right corner to start.

##### Profiling memory usage

1.  Press the Memory button.

    ![memory button](Inside%20Playdate/memory-button.png)

2.  The Memory window appears:

    ![memory window](Inside%20Playdate/memory-window.png)
    |      |                                                                                 |
    |------|---------------------------------------------------------------------------------|
    | Note | The first item displayed, `_G`, is the table where Lua stores global variables. |

##### Profiling malloc calls in the Simulator

1.  From the Simulator menubar, choose **16MB** from the **Playdate** → **Malloc Pool** menu.

2.  From the Simulator menubar, choose **Malloc Log** from the **Window** menu.

3.  To make your life easier, click on the **Autorefresh** checkbox at the bottom of the window.

    ![malloc log](Inside%20Playdate/malloc-log.png)

4.  There’s also a **Map** mode. See below.

    ![malloc log map](Inside%20Playdate/malloc-log-map.png)
    Figure 5. *Gray* denotes the total 16MB memory space; *white* is the total amount of heap allocated so far; *purple* — which overlaps the white region — is currently active or "in-use" memory.

##### Profiling malloc calls on the Device

1.  From the Simulator menubar, choose the **Device Info** menu item.

2.  In the Device Info window you can observe frames per second data, CPU usage data, and total memory usage.

    ![device info](Inside%20Playdate/device-info.png)
    |      |                                                                                                                                                                                                                                                                                                                                                                                                                                           |
    |------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
    | Note | If large amounts of time spent in GC is reported it does not necessarily mean your game has a problem: if your game doesn’t use all of its allotted CPU, the Lua runtime will try and grab as much time as it can for GC, causing the GC percentage to balloon. See [Garbage Collection](#M-garbage-collection) for details on how to modify the behavior of the garbage collector, including having it run for a shorter amount of time. |

3.  Select "Memory" to see the memory map:

    ![device info map](Inside%20Playdate/device-info-map.png)

### 7.16. Display

The playdate.display module contains functions pertaining to Playdate’s screen. Functions related to drawing can be found in [playdate.graphics](#M-graphics).

#### Display updating

playdate.display.setRefreshRate(rate)

Sets the desired refresh rate in frames per second. The default is 30 fps, which is a recommended figure that balances animation smoothness with performance and power considerations. Maximum is 50 fps.

If *rate* is 0, [playdate.update()](#c-update) is called as soon as possible. Since the display refreshes line-by-line, and unchanged lines aren’t sent to the display, the update cycle will be faster than 30 times a second but at an indeterminate rate. [playdate.getCurrentTimeMilliseconds()](#f-getCurrentTimeMilliseconds) should then be used as a steady time base.

Equivalent to [`playdate->display->setRefreshRate()`](./Inside%20Playdate%20with%20C.html#f-display.setRefreshRate) in the C API.

playdate.display.getRefreshRate()

Returns the specified refresh rate in frames per second. See also [playdate.getFPS()](#f-getFPS) for *measured, actual* frame rate.

playdate.display.flush()

Sends the contents of the frame buffer to the display immediately. Useful if you have called [playdate.stop()](#f-stop) to disable update callbacks in, say, the case where your app updates the display only in reaction to button presses.

#### Other display properties

playdate.display.getHeight()

Returns the height the Playdate display, taking the current display scale into account; e.g., if the scale is 2, the values returned will be based off of a 200 x 120-pixel screen rather than the native 400 x 240. (See [playdate.display.setScale()](#f-display.setScale).)

Equivalent to [`playdate->display->getHeight()`](./Inside%20Playdate%20with%20C.html#f-display.getHeight) in the C API.

playdate.display.getWidth()

Returns the width the Playdate display, taking the current display scale into account; e.g., if the scale is 2, the values returned will be based off of a 200 x 120-pixel screen rather than the native 400 x 240. (See [playdate.display.setScale()](#f-display.setScale).)

Equivalent to [`playdate->display->getWidth()`](./Inside%20Playdate%20with%20C.html#f-display.getWidth) in the C API.

playdate.display.getSize()

Returns the values *(width, height)* describing the Playdate display size. Takes the current display scale into account; e.g., if the scale is 2, the values returned will be based off of a 200 x 120-pixel screen rather than the native 400 x 240. (See [playdate.display.setScale()](#f-display.setScale).)

playdate.display.getRect()

Returns the values *(x, y, width, height)* describing the Playdate display size. Takes the current display scale into account; e.g., if the scale is 2, the values returned will be based off of a 200 x 120-pixel screen rather than the native 400 x 240. (See [playdate.display.setScale()](#f-display.setScale).)

playdate.display.setScale(scale)

Sets the display scale factor. Valid values for *scale* are 1, 2, 4, and 8.

The top-left corner of the frame buffer is scaled up to fill the display; e.g., if the scale is set to 4, the pixels in rectangle \[0,100\] x \[0,60\] are drawn on the screen as 4 x 4 squares.

Equivalent to [`playdate->display->setScale()`](./Inside%20Playdate%20with%20C.html#f-display.setScale) in the C API.

playdate.display.getScale()

Gets the display scale factor. Valid values for *scale* are 1, 2, 4, and 8.

playdate.display.setInverted(flag)

If the argument passed to `setInverted()` is true, the frame buffer will be drawn inverted (everything onscreen that was black will now be white, etc.)

Equivalent to [`playdate->display->setInverted()`](./Inside%20Playdate%20with%20C.html#f-display.setInverted) in the C API.

playdate.display.getInverted()

Returns the current value of the display invert flag.

playdate.display.setMosaic(x, y)

Adds a mosaic effect to the display. Valid *x* and *y* values are between 0 and 3, inclusive.

Equivalent to [`playdate->display->setMosaic()`](./Inside%20Playdate%20with%20C.html#f-display.setMosaic) in the C API.

playdate.display.getMosaic()

Returns the current mosaic effect settings as multiple values (*x*, *y*).

playdate.display.setOffset(x, y)

Offsets the entire display by *x*, *y*. Offset values can be negative. The "exposed" part of the display is black or white, according to the value set in [playdate.graphics.setBackgroundColor()](#f-graphics.setBackgroundColor). This is an efficient way to make a "shake" effect without redrawing anything.

|         |                                                                                                 |
|---------|-------------------------------------------------------------------------------------------------|
| Caution | This function is different from [playdate.graphics.setDrawOffset()](#f-graphics.setDrawOffset). |

Equivalent to [`playdate->display->setOffset()`](./Inside%20Playdate%20with%20C.html#f-display.setOffset) in the C API.

Example: A screen shake effect using setOffset

```lua
-- You can copy and paste this example directly as your main.lua file to see it in action
import "CoreLibs/graphics"
import "CoreLibs/timer"

-- This function relies on the use of timers, so the timer core library
-- must be imported, and updateTimers() must be called in the update loop
local function screenShake(shakeTime, shakeMagnitude)
    -- Creating a value timer that goes from shakeMagnitude to 0, over
    -- the course of 'shakeTime' milliseconds
    local shakeTimer = playdate.timer.new(shakeTime, shakeMagnitude, 0)
    -- Every frame when the timer is active, we shake the screen
    shakeTimer.updateCallback = function(timer)
        -- Using the timer value, so the shaking magnitude
        -- gradually decreases over time
        local magnitude = math.floor(timer.value)
        local shakeX = math.random(-magnitude, magnitude)
        local shakeY = math.random(-magnitude, magnitude)
        playdate.display.setOffset(shakeX, shakeY)
    end
    -- Resetting the display offset at the end of the screen shake
    shakeTimer.timerEndedCallback = function()
        playdate.display.setOffset(0, 0)
    end
end

function playdate.update()
    playdate.timer.updateTimers()
    if playdate.buttonJustPressed(playdate.kButtonA) then
        -- Shake the screen for 500ms, with the screen
        -- shaking around by about 5 pixels on each side
        screenShake(500, 5)
    end

    -- A circle to be able to view what the shaking looks like
    playdate.graphics.fillCircleAtPoint(200, 120, 10)
end
```

playdate.display.getOffset()

`getOffset()` returns the current display offset as multiple values (*x*, *y*).

playdate.display.setFlipped(x, y)

Flips the display on the x or y axis, or both.

|         |                                                                      |
|---------|----------------------------------------------------------------------|
| Caution | Function arguments are booleans, and in Lua `0` evaluates to `true`. |

Equivalent to [`playdate->display->setFlipped()`](./Inside%20Playdate%20with%20C.html#f-display.setFlipped) in the C API.

#### Displaying an image

playdate.display.loadImage(path)

The simplest method for putting an image on the display. Copies the contents of the image at *path* directly to the frame buffer. The image must be 400x240 pixels with no transparency.

|     |                                                                                                                                                                                                             |
|-----|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Tip | Loading an image via [playdate.graphics.image.new()](#f-graphics.image.new-path) and drawing it at a desired coordinate with [playdate.graphics.image:draw()](#m-graphics.imgDraw) offers more flexibility. |

### 7.17. Easing functions

A set of easing functions to aid with animation timing.

|           |                                                           |
|-----------|-----------------------------------------------------------|
| Important | You must import *CoreLibs/easing* to use these functions. |

playdate.easingFunctions.linear(t, b, c, d)  
playdate.easingFunctions.inQuad(t, b, c, d)  
playdate.easingFunctions.outQuad(t, b, c, d)  
playdate.easingFunctions.inOutQuad(t, b, c, d)  
playdate.easingFunctions.outInQuad(t, b, c, d)  
playdate.easingFunctions.inCubic(t, b, c, d)  
playdate.easingFunctions.outCubic(t, b, c, d)  
playdate.easingFunctions.inOutCubic(t, b, c, d)  
playdate.easingFunctions.outInCubic(t, b, c, d)  
playdate.easingFunctions.inQuart(t, b, c, d)  
playdate.easingFunctions.outQuart(t, b, c, d)  
playdate.easingFunctions.inOutQuart(t, b, c, d)  
playdate.easingFunctions.outInQuart(t, b, c, d)  
playdate.easingFunctions.inQuint(t, b, c, d)  
playdate.easingFunctions.outQuint(t, b, c, d)  
playdate.easingFunctions.inOutQuint(t, b, c, d)  
playdate.easingFunctions.outInQuint(t, b, c, d)  
playdate.easingFunctions.inSine(t, b, c, d)  
playdate.easingFunctions.outSine(t, b, c, d)  
playdate.easingFunctions.inOutSine(t, b, c, d)  
playdate.easingFunctions.outInSine(t, b, c, d)  
playdate.easingFunctions.inExpo(t, b, c, d)  
playdate.easingFunctions.outExpo(t, b, c, d)  
playdate.easingFunctions.inOutExpo(t, b, c, d)  
playdate.easingFunctions.outInExpo(t, b, c, d)  
playdate.easingFunctions.inCirc(t, b, c, d)  
playdate.easingFunctions.outCirc(t, b, c, d)  
playdate.easingFunctions.inOutCirc(t, b, c, d)  
playdate.easingFunctions.outInCirc(t, b, c, d)  
playdate.easingFunctions.inElastic(t, b, c, d, \[a, p\])  
playdate.easingFunctions.outElastic(t, b, c, d, \[a, p\])  
playdate.easingFunctions.inOutElastic(t, b, c, d, \[a, p\])  
playdate.easingFunctions.outInElastic(t, b, c, d, \[a, p\])  
playdate.easingFunctions.inBack(t, b, c, d, \[s\])  
playdate.easingFunctions.outBack(t, b, c, d, \[s\])  
playdate.easingFunctions.inOutBack(t, b, c, d, \[s\])  
playdate.easingFunctions.outInBack(t, b, c, d, \[s\])  
playdate.easingFunctions.outBounce(t, b, c, d)  
playdate.easingFunctions.inBounce(t, b, c, d)  
playdate.easingFunctions.inOutBounce(t, b, c, d)  
playdate.easingFunctions.outInBounce(t, b, c, d)

- *t* is elapsed time

- *b* is the beginning value

- *c* is the change (or end value - start value)

- *d* is the duration

- *a* - amplitude

- *p* - period parameter

- *s* - amount of "overshoot"

See [playdate.graphics.animator](#C-graphics.animator), [playdate.timer](#C-timer), or [playdate.frameTimer](#C-frameTimer) for use-cases.

|     |                                                                                                                                            |
|-----|--------------------------------------------------------------------------------------------------------------------------------------------|
| Tip | [This page](https://easings.net/en) does a great job illustrating the shape of each easing function. (A mouseover will show an animation.) |

### 7.18. Files

The Playdate SDK offers a few different approaches to writing and reading data:

- [*playdate.datastore*](#M-datastore) is the simplest way to write or read tables and images.

- Advanced file access functions are implemented in [playdate.file](#M-file).

- To encode or decode a JSON file or string, see [playdate.json](#M-json).

|      |                                                                                                                                                                                             |
|------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Note | When running in the Simulator, all Playdate file operations will happen in the SDK’s *Disk/Data/(bundleID)* folder. *bundleID* is as specified in your project’s [metadata file](#pdxinfo). |

#### playdate.datastore

If you’re looking for a simple way to save data, the Datastore APIs allow easy serialization of Lua tables and images.

playdate.datastore.write(table, \[filename\], \[pretty-print\])

Encodes the given table into the named file. (The `.json` extension should be omitted from the file name.) The default file name is "data". If *pretty-print* is true, the JSON will be nicely formatted.

playdate.datastore.read(\[filename\])

Returns a table instantiated with the data in the JSON-encoded file you specify. (The `.json` extension should be omitted.) The default file name is "data". If no file is found, this function returns nil.

playdate.datastore.delete(\[filename\])

Deletes the specified datastore file. The default file name is "data". Returns `false` if the datastore file could not be deleted.

playdate.datastore.writeImage(image, path)

Saves a [playdate.graphics.image](#C-graphics.image) to a file. If *path* doesn’t contain a folder name, the image is stored in a folder named "images".

By default, this method writes out a PDI file, a custom image format used by Playdate that can be read back in using [readImage()](#f-datastore.readImage). If you want to write out a GIF file, append a `.gif` extension to your *path*.

|           |                                                                                                                                                                                                                                                                                                                                                                                           |
|-----------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Important | Because `writeImage()` doesn’t currently support GIF transparency, if you attempt to write a GIF from an image buffer you instantiated, you must call [playdate.graphics.image.new( *width, height, bgcolor* )](#f-graphics.image.new) with *bgcolor* set to `playdate.graphics.kColorWhite` or `playdate.graphics.kColorBlack`, otherwise your image will render improperly to the file. |

playdate.datastore.readImage(path)

Reads a [playdate.graphics.image](#C-graphics.image) from a file in the data folder. If *path* doesn’t contain a folder name, the image is searched for in a folder named "images".

|           |                                                                                                                                    |
|-----------|------------------------------------------------------------------------------------------------------------------------------------|
| Important | `readImage()` can only load compiled pdi files. ([`writeImage()`](#f-datastore.writeImage) by default creates compiled pdi files.) |

#### playdate.file

The *playdate.file* module contains functions which allow you to interact with files on Playdate’s filesystem. It contains the *playdate.file.file* submodule for interacting with an opened file.

About the Playdate filesystem

Behind the scenes, there are two directories your game has access to: **the root of your app bundle** (read-only), and a **Data directory** unique to your game (readable and writeable) where you can store your game’s saved state or other data.

From your game’s perspective, these two locations are treated as one. If you attempt to read a file, the Playdate OS will first look for the file in the Data directory, then look in the app bundle. If you attempt to create or append to a file, this file will be created in your game’s Data directory. Calling [`playdate.file.listFiles()`](#f-file.listFiles) returns a list of files and directories at the root of *both* your app bundle and your game’s Data directory.

You are not permitted access to files outside of these two directories.

##### File reading and writing

playdate.file.open(path, \[mode\])

Returns a [playdate.file.file](#M-file) corresponding to the opened file. *mode* should be one of the following:

- **playdate.file.kFileRead**: the file is opened for reading; the system first looks in the /Data/\<bundleid\> folder for the given file, then in the game’s pdx folder if it isn’t found

- **playdate.file.kFileWrite**: the file is created if it doesn’t exist, truncated to zero length if it does, then opened for writing

- **playdate.file.kFileAppend**: the file is created if it doesn’t exist, opened for writing, with new data written to the end of the file

If *mode* is not specified, the default is *playdate.file.kFileRead*.

If the file couldn’t be opened, a second return value indicates the error. The filesystem has a limit of 64 simultaneous open files.

Equivalent to [`playdate->file->open()`](./Inside%20Playdate%20with%20C.html#f-file.open) in the C API.

playdate.file.file:close()

Closes the file.

Equivalent to [`playdate->file->close()`](./Inside%20Playdate%20with%20C.html#f-file.close) in the C API.

playdate.file.file:write(string)

Writes the given string to the file and returns the number of bytes written if successful, or 0 and a second return value describing the error. If you wish to include line termination characters (`\n`, `\r`), please include them in the string.

playdate.file.file:flush()

Flushes any buffered data written to the file to the disk.

Equivalent to [`playdate->file->flush()`](./Inside%20Playdate%20with%20C.html#f-file.flush) in the C API.

playdate.file.file:readline()

Returns the next line of the file, delimited by either `\n` or `\r\n`. The returned string does not include newline characters.

playdate.file.file:read(numberOfBytes)

Returns a buffer containing up to *numberOfBytes* bytes from the file, and the number of bytes read. If the read failed, the function returns `nil` and a second value describing the error.

Equivalent to [`playdate->file->read()`](./Inside%20Playdate%20with%20C.html#f-file.read) in the C API.

playdate.file.file:seek(offset, \[whence\])

Sets the file read/write position to the given byte offset. `whence`, if given is one of the following:

- **playdate.file.kSeekSet**: `offset` is an absolute offset from the start of the file

- **playdate.file.kSeekFromCurrent**: `offset` is relative to the current position

- **playdate.file.kSeekFromEnd**: `offset` is an offset from the end of the file (negative values are before the end, positive are past the end)

Equivalent to [`playdate->file->seek()`](./Inside%20Playdate%20with%20C.html#f-file.seek) in the C API.

playdate.file.file:tell()

Returns the current byte offset of the read/write position in the file.

Equivalent to [`playdate->file->tell()`](./Inside%20Playdate%20with%20C.html#f-file.tell) in the C API.

#### Filesystem operations

playdate.file.listFiles(path, \[showhidden\])

Returns an array containing the file names in the given directory path as strings. Folders are indicated by a slash `/` at the end of the filename. If *showhidden* is set, files beginning with a period will be included; otherwise, they are skipped.

Call with no argument to get a list of all files and folders your game has access to. (For a game with default access permissions, `listFiles()`, `listFiles("/")`, and `listFiles(".")` should all return the same result.)

Equivalent to [`playdate->file->listfiles()`](./Inside%20Playdate%20with%20C.html#f-file.listfiles) in the C API.

[Learn more about the Playdate filesystem](#about-playdate-filesystem).

playdate.file.exists(path)

Returns true if a file exists at the given path. Unlike the [image](#f-graphics.image.new-path) or [sound](#f-sound.sample.new-path) loading functions, this function requires *path* to include the file extension since it cannot be inferred from context. Additionally, note that asset files are compiled into a format easier for Playdate to use and will have a different extension: `.wav` and `.aiff` audio files are compiled to `.pda` format, and `.gif` and `.png` files become \`.pdi\`s.

playdate.file.isdir(path)

Returns true if a directory exists at the given path.

playdate.file.mkdir(path)

Creates a directory at the given path, under the /Data/\<bundleid\> folder. See [About the Playdate Filesystem](#about-playdate-filesystem) for details.

`playdate.file.mkdir()` will create all intermediate directories, if a succession of directories ("testdir/testdir/testdir/") is specified in *path*.

Equivalent to [`playdate->file->mkdir()`](./Inside%20Playdate%20with%20C.html#f-file.mkdir) in the C API.

playdate.file.delete(path, \[recursive\])

Deletes the file at the given path. Returns true if successful, else false.

If *recursive* is `true`, this function will delete the directory at *path* and its contents, otherwise the directory must be empty to be deleted.

playdate.file.getSize(path)

Returns the size of the file at the given path.

playdate.file.getType(path)

Returns the type of the file at the given path.

playdate.file.modtime(path)

Returns the modification date/time of the file at the given path, as a table with keys:

- *year*: 4-digit year (until 10,000 AD)

- *month*: month of the year, where 1 is January and 12 is December

- *day*: day of the month, 1 - 31

- *hour*: 0 - 23

- *minute*: 0 - 59

- *second*: 0 - 59 (or 60 on a leap second)

playdate.file.rename(path, newPath)

Renames the file at *path*, if it exists, to the value of newPath. This can result in the file being moved to a new directory, but directories will not be created. Returns true if the operation was successful.

Equivalent to [`playdate->file->rename()`](./Inside%20Playdate%20with%20C.html#f-file.rename) in the C API.

#### .pdz files

playdate.file.load(path, \[env\])

Loads the compiled *.pdz* file at the given location and returns the contents as a function. The .pdz extension on *path* is optional.

*env*, if specified, is a table to use as the function’s global namespace instead of *\_G*.

playdate.file.run(path, \[env\])

Runs the pdz file at the given location. Equivalent to `playdate.file.load(path, env)()`.

The *.pdz* extension on *path* is optional. Values returned from the pdz file are left on the stack.

*env*, if specified, is a table to use as the function’s global namespace instead of *\_G*.

### 7.19. Geometry

The playdate.geometry library allows you to store and manipulate points, sizes, rectangles, line segments, 2D vectors, polygons, and affine transforms.

All new geometry objects are created with a new() function using syntax like:

Example of creating a new rect

    r = playdate.geometry.rect.new(x, y, width, height)

They can be output to the Simulator console:

Example of printing a rect to the console

    print('rect', r)

And tested for equality:

Example of testing two rects for equality

    b = r1 == r2

Fields on most geometry objects can be set directly:

Example of directly setting a rect’s x coordinate

    r.x = 42.0

Functions for drawing playdate.geometry objects to screen are available in [playdate.graphics](#M-graphics).

#### Affine transform

Affine transforms can be used to modify the coordinates of points, rects (as axis aligned bounding boxes (AABBs)), line segments, and polygons. The underlying matrix is of the form:

The matrix of an affine transform

```lua
[m11 m12 tx]
[m21 m22 ty]
[ 0   0  1 ]
```

You can directly read and write the *m11*, *m12*, *m21*, *m22*, *tx* and *ty* values of an `affineTransform`.

playdate.geometry.affineTransform.new(m11, m12, m21, m22, tx, ty)

Returns a new playdate.geometry.affineTransform. Use new() instead to get a new copy of the identity transform.

playdate.geometry.affineTransform.new()

Returns a new playdate.geometry.affineTransform that is the identity transform.

playdate.geometry.affineTransform:copy()

Returns a new copy of the affine transform.

playdate.geometry.affineTransform:invert()

Mutates the caller so that it is an affine transformation matrix constructed by inverting itself.

Inversion is generally used to provide reverse transformation of points within transformed objects. Given the coordinates (x, y), which have been transformed by a given matrix to new coordinates (x’, y’), transforming the coordinates (x’, y’) by the inverse matrix produces the original coordinates (x, y).

playdate.geometry.affineTransform:reset()

Mutates the the caller, changing it to an identity transform matrix.

playdate.geometry.affineTransform:concat(af)

Mutates the the caller. The affine transform *af* is concatenated to the caller.

Concatenation combines two affine transformation matrices by multiplying them together. You might perform several concatenations in order to create a single affine transform that contains the cumulative effects of several transformations.

Note that matrix operations are not commutative — the order in which you concatenate matrices is important. That is, the result of multiplying matrix t1 by matrix t2 does not necessarily equal the result of multiplying matrix t2 by matrix t1.

playdate.geometry.affineTransform:translate(dx, dy)

Mutates the caller by applying a translate transformation. x values are moved by *dx*, y values by *dy*.

playdate.geometry.affineTransform:translatedBy(dx, dy)

Returns a copy of the calling affine transform with a translate transformation appended.

playdate.geometry.affineTransform:scale(sx, \[sy\])

Mutates the caller by applying a scaling transformation.

If both parameters are passed, *sx* is used to scale the x values of the transform, *sy* is used to scale the y values.

If only one parameter is passed, it is used to scale both x and y values.

playdate.geometry.affineTransform:scaledBy(sx, \[sy\])

Returns a copy of the calling affine transform with a scaling transformation appended.

If both parameters are passed, *sx* is used to scale the x values of the transform, *sy* is used to scale the y values.

If only one parameter is passed, it is used to scale both x and y values.

playdate.geometry.affineTransform:rotate(angle, \[x, y\])

Mutates the caller by applying a rotation transformation.

*angle* is the value, in degrees, by which to rotate the affine transform. A positive value specifies clockwise rotation and a negative value specifies counterclockwise rotation. If the optional *x* and *y* arguments are given, the transform rotates around (*x*,*y*) instead of (0,0).

playdate.geometry.affineTransform:rotate(angle, \[point\])

Mutates the caller by applying a rotation transformation.

*angle* is the value, in degrees, by which to rotate the affine transform. A positive value specifies clockwise rotation and a negative value specifies counterclockwise rotation. If the optional [playdate.geometry.point](#C-geometry.point) *point* argument is given, the transform rotates around the *point* instead of (0,0).

playdate.geometry.affineTransform:rotatedBy(angle, \[x, y\])

Returns a copy of the calling affine transform with a rotate transformation appended.

*angle* is the value, in degrees, by which to rotate the affine transform. A positive value specifies clockwise rotation and a negative value specifies counterclockwise rotation. If the optional *x* and *y* arguments are given, the transform rotates around (*x*,*y*) instead of (0,0).

playdate.geometry.affineTransform:rotatedBy(angle, \[point\])

Returns a copy of the calling affine transform with a rotate transformation appended.

*angle* is the value, in degrees, by which to rotate the affine transform. A positive value specifies clockwise rotation and a negative value specifies counterclockwise rotation. If the optional [point](#C-geometry.point) *point* argument is given, the transform rotates around the *point* instead of (0,0).

playdate.geometry.affineTransform:skew(sx, sy)

Mutates the caller, appending a skew transformation. *sx* is the value by which to skew the x axis, and *sy* the value for the y axis. Values are in degrees.

playdate.geometry.affineTransform:skewedBy(sx, sy)

Returns the given transform with a skew transformation appended. *sx* is the value by which to skew the x axis, and *sy* the value for the y axis. Values are in degrees.

playdate.geometry.affineTransform:transformPoint(p)

Modifies the [point](#C-geometry.point) *p* by applying the affine transform.

playdate.geometry.affineTransform:transformedPoint(p)

As above, but returns a new point rather than modifying *p*.

playdate.geometry.affineTransform:transformXY(x, y)

Returns two values calculated by applying the affine transform to the point (*x*, *y*)

playdate.geometry.affineTransform:transformLineSegment(ls)

Modifies the [line segment](#C-geometry.lineSegment) *ls* by applying the affine transform.

playdate.geometry.affineTransform:transformedLineSegment(ls)

As above, but returns a new [line segment](#C-geometry.lineSegment) rather than modifying *ls*.

playdate.geometry.affineTransform:transformAABB(r)

Modifies the axis aligned bounding box *r* (a [rect](#C-geometry.rect)) by applying the affine transform.

playdate.geometry.affineTransform:transformedAABB(r)

As above, but returns a new [rect](#C-geometry.rect) rather than modifying *r*.

playdate.geometry.affineTransform:transformPolygon(p)

Modifies the [polygon](#C-geometry.polygon) *p* by applying the affine transform.

playdate.geometry.affineTransform:transformedPolygon(p)

As above, but returns a new [polygon](#C-geometry.polygon) rather than modifying *p*.

t1 \* t2

Returns the transform created by multiplying transform *t1* by transform *t2*

t \* v

Returns the vector2D created by applying the transform *t* to the [`vector2D`](#C-geometry.vector2D) `v`

t \* p

Returns the point created by applying the transform *t* to the [`point`](#C-geometry.point) *p*

#### Arc

playdate.geometry.arc implements an arc.

You can directly read or write the *x*, *y*, *radius*, *startAngle*, *endAngle* and *clockwise* values of an `arc`.

playdate.geometry.arc.new(x, y, radius, startAngle, endAngle, \[direction\])

Returns a new playdate.geometry.arc. Angles should be specified in degrees. Zero degrees represents the top of the circle.

![unitcircle](Inside%20Playdate/unitcircle.png)

If specified, *direction* should be true for clockwise, false for counterclockwise. If not specified, the direction is inferred from the start and end angles.

playdate.geometry.arc:copy()

Returns a new copy of the arc.

playdate.geometry.arc:length()

Returns the length of the arc.

playdate.geometry.arc:isClockwise()

Returns true if the direction of the arc is clockwise.

playdate.geometry.arc:setIsClockwise(flag)

Sets the direction of the arc.

playdate.geometry.arc:pointOnArc(distance, \[extend\])

Returns a new [point](#C-geometry.point) on the arc, `distance` pixels from the arc’s start angle. If `extend` is true, the returned point is allowed to project past the arc’s endpoints; otherwise, it is constrained to the arc’s initial point if `distance` is negative, or the end point if `distance` is greater than the arc’s length.

#### Line segment

playdate.geometry.lineSegment implements a line segment between two points in two-dimensional space.

You can directly read or write *x1*, *y1*, *x2*, or *y2* values to a lineSegment.

playdate.geometry.lineSegment.new(x1, y1, x2, y2)

Returns a new playdate.geometry.lineSegment.

playdate.geometry.lineSegment:copy()

Returns a new copy of the line segment.

playdate.geometry.lineSegment:unpack()

Returns the values *x1, y1, x2, y2*.

playdate.geometry.lineSegment:length()

Returns the length of the line segment.

playdate.geometry.lineSegment:offset(dx, dy)

Modifies the line segment, offsetting its values by *dx*, *dy*.

playdate.geometry.lineSegment:offsetBy(dx, dy)

Returns a new line segment, the given segment offset by *dx*, *dy*.

playdate.geometry.lineSegment:midPoint()

Returns a [playdate.geometry.point](#C-geometry.point) representing the mid point of the line segment.

playdate.geometry.lineSegment:pointOnLine(distance, \[extend\])

Returns a [playdate.geometry.point](#C-geometry.point) on the line segment, `distance` pixels from the start of the line. If `extend` is true, the returned point is allowed to project past the segment’s endpoints; otherwise, it is constrained to the line segment’s initial point if `distance` is negative, or the end point if `distance` is greater than the segment’s length.

playdate.geometry.lineSegment:segmentVector()

Returns a [playdate.geometry.vector2D](#C-geometry.vector2D) representation of the line segment.

playdate.geometry.lineSegment:closestPointOnLineToPoint(p)

Returns a [playdate.geometry.point](#C-geometry.point) that is the closest point to point *p* that is on the line segment.

playdate.geometry.lineSegment:intersectsLineSegment(ls)

Returns true if there is an intersection between the caller and the line segment *ls*.

If there is an intersection, a [playdate.geometry.point](#C-geometry.point) representing that point is also returned.

playdate.geometry.lineSegment.fast_intersection(x1, y1, x2, y2, x3, y3, x4, y4)

For use in inner loops where speed is the priority.

Returns true if there is an intersection between the line segments defined by *(x1, y1)*, *(x2, y2)* and *(x3, y3)*, *(x4, y4)*. If there is an intersection, *x, y* values representing the intersection point are also returned.

playdate.geometry.lineSegment:intersectsPolygon(poly)

Returns the values (*intersects*, *intersectionPoints*).

*intersects* is true if there is at least one intersection between the caller and [poly](#C-geometry.polygon).

*intersectionPoints* is an array of [playdate.geometry.point](#C-geometry.point)s containing all intersection points between the caller and [poly](#C-geometry.polygon).

playdate.geometry.lineSegment:intersectsRect(rect)

Returns the values (*intersects*, *intersectionPoints*).

*intersects* is true if there is at least one intersection between the caller and [rect](#C-geometry.rect).

*intersectionPoints* is an array of [playdate.geometry.point](#C-geometry.point)s containing all intersection points between the caller and [rect](#C-geometry.rect).

#### Point

playdate.geometry.point implements a two-dimensional point. You can directly read or write the *x* and *y* values of a `point`.

playdate.geometry.point.new(x, y)

Returns a new playdate.geometry.point.

playdate.geometry.point:copy()

Returns a new copy of the point.

playdate.geometry.point:unpack()

Returns the values *x, y*.

playdate.geometry.point:offset(dx, dy)

Modifies the point, offsetting its values by *dx*, *dy*.

playdate.geometry.point:offsetBy(dx, dy)

Returns a new point object, the given point offset by *dx*, *dy*.

playdate.geometry.point:squaredDistanceToPoint(p)

Returns the square of the distance to point *p*.

playdate.geometry.point:distanceToPoint(p)

Returns the distance to point *p*.

p + v

Returns a new point by adding the [vector](#C-geometry.vector2D) *v* to point *p*.

p1 - p2

Returns the vector constructed by subtracting *p2* from *p1*. By this construction, *p2* + (*p1* - *p2*) == *p1*.

p \* t

Returns a new point by applying the [transform](#C-geometry.affineTransform) *t* to point *p*.

p1 .. p2

Returns a new [lineSegment](#C-geometry.lineSegment) connecting points *p1* and *p2*.

#### Polygon

playdate.geometry.polygon implements two-dimensional open or closed polygons.

playdate.geometry.polygon.new(x1, y1, x2, y2, ..., xn, yn)  
playdate.geometry.polygon.new(p1, p2, ..., pn)  
playdate.geometry.polygon.new(numberOfVertices)

`new(x1, y1, x2, y2, ..., xn, yn)` returns a new playdate.geometry.polygon with vertices *(x1, y1)* through *(xn, yn)*. The Lua function `table.unpack()` can be used to turn an array into function arguments.

`new(p1, p2, ..., pn)` does the same, except the points are expressed via [point objects](#C-geometry.point).

`new(numberOfVertices)` returns a new playdate.geometry.polygon with space allocated for *numberOfVertices* vertices. All vertices are initially (0, 0). Vertex coordinates can be set with [playdate.geometry.polygon:setPointAt()](#m-geometry.polygon.setPointAt).

|      |                                                                                                                                                                                                                                     |
|------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Note | If the polygon’s first and last points are coincident, the polygon will be considered [closed](#m-geometry.polygon.isClosed). Alternatively, you may call [:close()](#m-geometry.polygon.close) to automatically close the polygon. |

|     |                                                                                      |
|-----|--------------------------------------------------------------------------------------|
| Tip | To draw a polygon, use [`playdate.graphics.drawPolygon()`](#f-graphics.drawPolygon). |

playdate.geometry.polygon:copy()

Returns a copy of a polygon.

playdate.geometry.polygon:close()

`:close()` closes a polygon. If the polygon’s first and last point aren’t coincident, a line segment will be generated to connect them.

playdate.geometry.polygon:isClosed()

Returns true if the polygon is closed, false if not.

playdate.geometry.polygon:containsPoint(p, \[fillRule\])  
playdate.geometry.polygon:containsPoint(x, y, \[fillRule\])

Returns a boolean value, true if the [point](#C-geometry.point) *p* or the point at *(x, y)* is contained within the caller polygon.

`fillrule` is an optional argument that can be one of the values defined in [playdate.graphics.setPolygonFillRule](#f-graphics.setPolygonFillRule). By default *`playdate.graphics.kPolygonFillEvenOdd`* is used.

playdate.geometry.polygon:getBounds()

Returns multiple values (*x*, *y*, *width*, *height*) giving the axis-aligned bounding box for the polygon.

playdate.geometry.polygon:getBoundsRect()

Returns the axis-aligned bounding box for the given polygon as a [`playdate.geometry.rect`](#C-geometry.rect) object.

playdate.geometry.polygon:count()

Returns the number of points in the polygon.

playdate.geometry.polygon:length()

Returns the total length of all line segments in the polygon.

playdate.geometry.polygon:setPointAt(n, x, y)

Sets the polygon’s *n*-th point to (*x*, *y*).

playdate.geometry.polygon:getPointAt(n)

Returns the polygon’s *n*-th point.

playdate.geometry.polygon:intersects(p)

Returns true if the given polygon intersects the polygon *p*.

playdate.geometry.polygon:pointOnPolygon(distance, \[extend\])

Returns a [playdate.geometry.point](#C-geometry.point) on one of the polygon’s line segments, `distance` pixels from the start of the polygon. If `extend` is true, the point is allowed to project past the polygon’s ends; otherwise, it is constrained to the polygon’s initial point if `distance` is negative, or the last point if `distance` is greater than the polygon’s length.

playdate.geometry.polygon:translate(dx, dy)

Translates each point on the polygon by *dx*, *dy* pixels.

p \* t

Returns a new polygon formed by applying the [transform](#C-geometry.affineTransform) *t* to polygon *p*.

#### Rect

playdate.geometry.rect implements a rectangle.

You can directly read or write *x*, *y*, *width*, or *height* values to a rect.

The values of *top*, *bottom*, *right*, *left*, *origin*, and *size* are read-only.

playdate.geometry.rect.new(x, y, width, height)

Returns a new playdate.geometry.rect.

playdate.geometry.rect:copy()

Returns a new copy of the rect.

playdate.geometry.rect:toPolygon()

Returns a new playdate.geometry.polygon version of the rect.

playdate.geometry.rect:unpack()

Returns *x*, *y*, *width* and *height* as individual values.

playdate.geometry.rect:isEmpty()

Returns true if a rectangle has zero width or height.

playdate.geometry.rect:isEqual(r2)

Returns true if the *x*, *y*, *width*, and *height* values of the caller and *r2* are all equal.

playdate.geometry.rect:intersects(r2)

Returns true if *r2* intersects the caller.

playdate.geometry.rect:intersection(r2)

Returns a rect representing the overlapping portion of the caller and *r2*.

playdate.geometry.rect.fast_intersection(x1, y1, w1, h1, x2, y2, w2, h2)

For use in inner loops where speed is the priority. About 3x faster than [intersection](#m-geometry.rect.intersection).

Returns multiple values (*x, y, width, height*) representing the overlapping portion of the two rects defined by *x1, y1, w1, h1* and *x2, y2, w2, h2*. If there is no intersection, (0, 0, 0, 0) is returned.

playdate.geometry.rect:union(r2)

Returns the smallest possible rect that contains both the source rect and *r2*.

playdate.geometry.rect.fast_union(x1, y1, w1, h1, x2, y2, w2, h2)

For use in inner loops where speed is the priority. About 3x faster than [union](#m-geometry.rect.union).

Returns multiple values (*x, y, width, height*) representing the smallest possible rect that contains the two rects defined by *x1, y1, w1, h1* and *x2, y2, w2, h2*.

playdate.geometry.rect:inset(dx, dy)

Insets the rect by the given *dx* and *dy*.

playdate.geometry.rect:insetBy(dx, dy)

Returns a rect that is inset by the given *dx* and *dy*, with the same center point.

playdate.geometry.rect:offset(dx, dy)

Offsets the rect by the given *dx* and *dy*.

playdate.geometry.rect:offsetBy(dx, dy)

Returns a rect with its origin point offset by *dx*, *dy*.

playdate.geometry.rect:containsRect(r2)

Returns true if the [rect](#C-geometry.rect) *r2* is contained within the caller [rect](#C-geometry.rect).

playdate.geometry.rect:containsRect(x, y, width, height)

Returns true if the rect defined by *(x, y, width, height)* is contained within the caller [rect](#C-geometry.rect).

playdate.geometry.rect:containsPoint(p)

Returns true if the [point](#C-geometry.point) *p* is contained within the caller [rect](#C-geometry.rect).

playdate.geometry.rect:containsPoint(x, y)

Returns true if the point at *(x, y)* is contained within the caller [rect](#C-geometry.rect).

playdate.geometry.rect:centerPoint()

Returns a [point](#C-geometry.point) at the center of the caller.

playdate.geometry.rect:flipRelativeToRect(r2, flip)

Flips the caller about the center of rect *r2*.

*flip* should be one of the following constants:

- *playdate.geometry.kUnflipped*

- *playdate.geometry.kFlippedX*

- *playdate.geometry.kFlippedY*

- *playdate.geometry.kFlippedXY*

#### Size

You can directly read or write the *width* and *height* values of a `size`.

playdate.geometry.size.new(width, height)

Returns a new playdate.geometry.size.

playdate.geometry.size:copy()

Returns a new copy of the size.

playdate.geometry.size:unpack()

Returns the values *width, height*.

#### Utility functions

playdate.geometry.squaredDistanceToPoint(x1, y1, x2, y2)

Returns the square of the distance from point *(x1, y1)* to point *(x2, y2)*.

Compared to [geometry.point:squaredDistanceToPoint()](#m-geometry.point.squaredDistanceToPoint), this version will be slightly faster.

playdate.geometry.distanceToPoint(x1, y1, x2, y2)

Returns the the distance from point *(x1, y1)* to point *(x2, y2)*.

Compared to [geometry.point:distanceToPoint()](#m-geometry.point.distanceToPoint), this version will be slightly faster.

#### Vector

playdate.geometry.vector2D implements a two-dimensional vector.

You can directly read or write *dx*, or *dy* values to a vector2D.

playdate.geometry.vector2D.new(x, y)

Returns a new playdate.geometry.vector2D.

playdate.geometry.vector2D.newPolar(length, angle)

Returns a new playdate.geometry.vector2D. Angles should be specified in degrees. Zero degrees represents the top of the circle.

playdate.geometry.vector2D:copy()

Returns a new copy of the vector2D.

playdate.geometry.vector2D:unpack()

Returns the values *dx, dy*.

playdate.geometry.vector2D:addVector(v)

Modifies the caller by adding vector *v*.

playdate.geometry.vector2D:scale(s)

Modifies the caller, scaling it by amount *s*.

playdate.geometry.vector2D:scaledBy(s)

Returns the given vector scaled by *s*.

playdate.geometry.vector2D:normalize()

Modifies the caller by normalizing it so that its length is 1. If the vector is (0,0), the vector is unchanged.

playdate.geometry.vector2D:normalized()

Returns a new vector by normalizing the given vector.

playdate.geometry.vector2D:dotProduct(v)

Returns the dot product of the caller and the vector *v*.

playdate.geometry.vector2D:magnitude()

Returns the magnitude of the caller.

playdate.geometry.vector2D:magnitudeSquared()

Returns the square of the magnitude of the caller.

playdate.geometry.vector2D:projectAlong(v)

Modifies the caller by projecting it along the vector *v*.

playdate.geometry.vector2D:projectedAlong(v)

Returns a new vector created by projecting the given vector along the vector *v*.

playdate.geometry.vector2D:angleBetween(v)

Returns the angle between the caller and the vector *v*.

playdate.geometry.vector2D:leftNormal()

Returns a vector that is the left normal of the caller.

playdate.geometry.vector2D:rightNormal()

Returns a vector that is the right normal of the caller.

-v

Returns the vector formed by negating the components of vector *v*.

v1 + v2

Returns the vector formed by adding vector *v2* to vector *v1*.

v1 - v2

Returns the vector formed by subtracting vector *v2* from vector *v1*.

v1 \* s

Returns the vector *v1* scaled by *s*.

v1 \* v2

Returns the dot product of the two vectors.

v1 \* t

Returns the vector transformed by transform *t*.

v / s

Returns the vector divided by scalar *s*.

### 7.20. Graphics

The playdate.graphics module contains functions related to displaying information on the device screen.

#### Conventions

- The Playdate coordinate system has its origin point (0, 0) at the upper left. The x-axis increases to the right, and the y-axis increases downward.

- (0, 0) represents the upper-left corner of the first pixel onscreen. The center of that pixel is (0.5, 0.5).

- In the Playdate SDK, angle values should always be provided in degrees, and angle values returned will be in degrees. Not radians. (This is in contrast to Lua’s built-in math libraries, which use radians.)

#### Contexts

playdate.graphics.pushContext(\[image\])

Pushes the current graphics state to the context stack and creates a new context. If a [playdate.graphics.image](#C-graphics.image) is given, drawing functions are applied to the image instead of the screen buffer.

|           |                                                                                                                                                                                                                                                                               |
|-----------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Important | If you draw into an image context with color set to *playdate.graphics.kColorClear*, those drawn pixels will be set to transparent. When you later draw the image into the framebuffer, those pixels will not be rendered, i.e., will act as transparent pixels in the image. |

|      |                                                                                                                                                |
|------|------------------------------------------------------------------------------------------------------------------------------------------------|
| Note | [playdate.graphics.lockFocus(*image*)](#f-graphics.lockFocus) will reroute drawing into an image, without saving the overall graphics context. |

Equivalent to [`playdate->graphics->pushContext()`](./Inside%20Playdate%20with%20C.html#f-graphics.pushContext) in the C API.

playdate.graphics.popContext()

Pops a graphics context off the context stack and restores its state.

Equivalent to [`playdate->graphics->popContext()`](./Inside%20Playdate%20with%20C.html#f-graphics.popContext) in the C API.

Example: Using contexts to reset drawing modifiers

```lua
local gfx = playdate.graphics

gfx.setLineWidth(1) -- Original line width
gfx.setColor(gfx.kColorBlack) -- Original color

gfx.pushContext() -- Creating a new graphics context
gfx.setLineWidth(5) -- Setting the line width to 5
gfx.setColor(gfx.kColorWhite) -- Setting the draw color to white
gfx.drawCircleAtPoint(200, 120, 10) -- Only thing you're trying to modify
gfx.popContext() -- All modifications done during the context get removed

-- Unaffected by modifiers and gets drawn with the original color/line width
gfx.drawLine(0, 120, 400, 120)
```

Example: Using contexts to draw something to an image

```lua
-- You can copy and paste this example directly as your main.lua file to see it in action
import "CoreLibs/graphics"

-- In this example, we'll be drawing a smiley face to an image, which saves our
-- drawing, makes it easier to draw, and helps improve performance since we don't
-- have to redraw each element separately each time
local gfx = playdate.graphics

local smileWidth, smileHeight = 36, 36
local smileImage = gfx.image.new(smileWidth, smileHeight)
-- Pushing our new image to the graphics context, so everything
-- drawn will be drawn directly to the image
gfx.pushContext(smileImage)
    -- => Indentation not required, but helps organize things!
    gfx.setColor(gfx.kColorWhite)
    -- Coordinates are based on the image being drawn into
    -- (e.g. (x=0, y=0) refers to the top left of the image)
    gfx.fillCircleInRect(0, 0, smileWidth, smileHeight)
    gfx.setColor(gfx.kColorBlack)
    -- Drawing the eyes
    gfx.fillCircleAtPoint(11, 13, 3)
    gfx.fillCircleAtPoint(25, 13, 3)
    -- Drawing the mouth
    gfx.setLineWidth(3)
    gfx.drawArc(smileWidth/2, smileHeight/2, 11, 115, 245)
    -- Drawing the outline
    gfx.setLineWidth(2)
    gfx.setStrokeLocation(gfx.kStrokeInside)
    gfx.drawCircleInRect(0, 0, smileWidth, smileHeight)
-- Popping context to stop drawing to image
gfx.popContext()

function playdate.update()
    -- Draw smile in the center of the screen
    local screenWidth, screenHeight = playdate.display.getSize()
    smileImage:drawAnchored(screenWidth/2, screenHeight/2, 0.5, 0.5)
end

-- Works really well with sprites! Just set the sprite image to your new image
local smileSprite = gfx.sprite.new(smileImage)
smileSprite:add()
```

#### Clearing the Screen

playdate.graphics.clear(\[color\])

Clears the entire display, setting the color to either the given *color* argument, or the current background color set in [setBackgroundColor(color)](#f-graphics.setBackgroundColor) if no argument is given.

Equivalent to [`playdate->graphics->clear()`](./Inside%20Playdate%20with%20C.html#f-graphics.clear) in the C API.

#### Image

PNG and GIF images in the source folder are compiled into a Playdate-specific format by **`pdc`**, and can be loaded into Lua with [playdate.graphics.image.new(path)](#f-graphics.image.new-path). Playdate images are 1 bit per pixel, with an optional alpha channel.

##### Image basics

playdate.graphics.image.new(width, height, \[bgcolor\])

Creates a new blank image of the given width and height. The image can be drawn on using [playdate.graphics.pushContext()](#f-graphics.pushContext) or [playdate.graphics.lockFocus()](#f-graphics.lockFocus). The optional *bgcolor* argument is one of the color constants as used in [playdate.graphics.setColor()](#f-graphics.setColor), defaulting to *kColorClear*.

playdate.graphics.image.new(path)

Returns a [playdate.graphics.image](#C-graphics.image) object from the data at *path*. If there is no file at *path*, the function returns nil and a second value describing the error.

playdate.graphics.image:load(path)

Loads a new image from the data at *path* into an already-existing image, without allocating additional memory. The image at *path* must be of the same dimensions as the original.

Returns *(success, \[error\])*. If the boolean *success* is false, *error* is also returned.

playdate.graphics.image:copy()

Returns a new `playdate.graphics.image` that is an exact copy of the original.

playdate.graphics.image:getSize()

Returns the pair (*width*, *height*)

playdate.graphics.imageSizeAtPath(path)

Returns the pair (*width*, *height*) for the image at *path* without actually loading the image.

playdate.graphics.image:draw(x, y, \[flip, \[sourceRect\]\])  
playdate.graphics.image:draw(p, \[flip, \[sourceRect\]\])

Draws the image with its upper-left corner at location (*x*, *y*) or [playdate.geometry.point](#C-geometry.point) *p*.

The optional *flip* argument can be one of the following:

-  *playdate.graphics.kImageUnflipped*: the image is drawn normally

-  *playdate.graphics.kImageFlippedX*: the image is flipped left to right

-  *playdate.graphics.kImageFlippedY*: the image is flipped top to bottom

-  *playdate.graphics.kImageFlippedXY*: the image if flipped both ways; i.e., rotated 180 degrees

Alternately, one of the strings "flipX", "flipY", or "flipXY" can be used for the *flip* argument.

*sourceRect*, if specified, will cause only the part of the image within sourceRect to be drawn. *sourceRect* should be relative to the image’s bounds and can be a [playdate.geometry.rect](#C-geometry.rect) or four integers, (*x*, *y*, *w*, *h*), representing the rect.

playdate.graphics.image:drawAnchored(x, y, ax, ay, \[flip\])

Draws the image at location *(x, y)* centered at the point within the image represented by *(ax, ay)* in unit coordinate space. For example, values of *ax = 0.0*, *ay = 0.0* represent the image’s top-left corner, *ax = 1.0*, *ay = 1.0* represent the bottom-right, and *ax = 0.5*, *ay = 0.5* represent the center of the image.

The *flip* argument is optional; see [`playdate.graphics.image:draw()`](#m-graphics.imgDraw) for valid values.

|           |                                                         |
|-----------|---------------------------------------------------------|
| Important | You must import *CoreLibs/graphics* to use this method. |

playdate.graphics.image:drawCentered(x, y, \[flip\])

Draws the image centered at location *(x, y)*.

The *flip* argument is optional; see [`playdate.graphics.image:draw()`](#m-graphics.imgDraw) for valid values.

|           |                                                         |
|-----------|---------------------------------------------------------|
| Important | You must import *CoreLibs/graphics* to use this method. |

playdate.graphics.image:drawIgnoringOffset(x, y, \[flip\])  
playdate.graphics.image:drawIgnoringOffset(p, \[flip\])

Draws the image ignoring the currently-set [`drawOffset`](#f-graphics.setDrawOffset).

playdate.graphics.image:clear(color)

Erases the contents of the image, setting all pixels to white if *color* is *playdate.graphics.kColorWhite*, black if it’s *playdate.graphics.kColorBlack*, or clear if it’s *playdate.graphics.kColorClear*. If the image is cleared to black or white, the mask (if it exists) is set to fully opaque. If the image is cleared to kColorClear and the image doesn’t have a mask, a mask is added to it.

playdate.graphics.image:sample(x, y)

Returns *playdate.graphics.kColorWhite* if the image is white at (*x*, *y*), *playdate.graphics.kColorBlack* if it’s black, or *playdate.graphics.kColorClear* if it’s transparent.

|      |                                                              |
|------|--------------------------------------------------------------|
| Note | The upper-left pixel of the image is at coordinate *(0, 0)*. |

##### Image transformations

|           |                                                                                                                                                                                                                                   |
|-----------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Important | The following functions can be quite slow, especially when rotating images off-axis. Transforming a large image can take many milliseconds on the device. Be sure to test performance on the hardware when using these functions. |

playdate.graphics.image:drawRotated(x, y, angle, \[scale, \[yscale\]\])

Draws this image centered at point *(x,y)* at (clockwise) *angle* degrees, scaled by optional argument *scale*, with an optional separate scaling for the y axis.

playdate.graphics.image:rotatedImage(angle, \[scale, \[yscale\]\])

Returns a new image containing this image rotated by (clockwise) *angle* degrees, scaled by optional argument *scale*, with an optional separate scaling for the y axis.

|         |                                                                                                               |
|---------|---------------------------------------------------------------------------------------------------------------|
| Caution | Unless rotating by a multiple of 180 degrees, the new image will have different dimensions than the original. |

playdate.graphics.image:drawScaled(x, y, scale, \[yscale\])

Draws this image with its upper-left corner at point *(x,y)*, scaled by amount *scale*, with an optional separate scaling for the y axis.

playdate.graphics.image:scaledImage(scale, \[yscale\])

Returns a new image containing this image scaled by amount *scale*, with an optional separate scaling for the y axis.

playdate.graphics.image:drawWithTransform(xform, x, y)

Draws this image centered at point *(x,y)* with the [transform](#C-geometry.affineTransform) *xform* applied.

playdate.graphics.image:transformedImage(xform)

Returns a new image containing the image with the [transform](#C-geometry.affineTransform) *xform* applied.

playdate.graphics.image:drawSampled(x, y, width, height, centerx, centery, dxx, dyx, dxy, dyy, dx, dy, z, tiltAngle, tile)

Draws the image as if it’s mapped onto a tilted plane, transforming the target coordinates to image coordinates using an affine transform:

    x' = dxx * x + dyx * y + dx
    y' = dxy * x + dyy * y + dy

- *x, y, width, height*: The rectangle to fill

- *centerx, centery*: The point in the above rectangle \[in (0,1)x(0,1) coordinates\] for the center of the transform

- *dxx, dyx, dxy, dyy, dx, dy*: Defines an affine transform from geometry coordinates to image coordinates

- *z*: The distance from the viewer to the target plane — lower z means more exaggerated perspective

- *tiltAngle*: The tilt of the target plane about the x axis, in degrees

- *tile*: A boolean, indicating whether the image is tiled on the target plane

The *Mode7Driver* demo in the */Examples* folder of the SDK demonstrates the usage of this function.

##### Image masks

Image masks are how transparency is handled by images on the Playdate. When an image is drawn, the image mask is checked to see what parts of the image should be transparent.

The image mask takes the form of another image that must be the same dimensions as the image that it is masking. Regions that should be transparent are filled in with black pixels and opaque regions are filled in with white pixels. Any transparent image that is created or loaded from a file will automatically have an image mask applied to it to handle the transparency. Fully opaque images will, by default, have no image mask. An image may only have at most one image mask.

playdate.graphics.image:setMaskImage(maskImage)

Sets the image’s mask to a copy of *maskImage*.

playdate.graphics.image:getMaskImage()

If the image has a mask, returns the mask as a separate image. Otherwise, returns `nil`.

|           |                                                                                                                 |
|-----------|-----------------------------------------------------------------------------------------------------------------|
| Important | The returned image references the original’s data, so drawing into this image alters the original image’s mask. |

playdate.graphics.image:addMask(\[opaque\])

Adds a mask to the image if it doesn’t already have one. If *opaque* is `true` or not specified, the image mask applied will be completely white, so the image will be entirely opaque. If *opaque* is `false`, the mask will be completely black, so the image will be entirely transparent.

playdate.graphics.image:removeMask()

Removes the mask from the image if it has one.

playdate.graphics.image:hasMask()

Returns *true* if the image has a mask.

playdate.graphics.image:clearMask(\[opaque\])

Erases the contents of the image’s mask, so that the image is entirely opaque if *opaque* is 1, transparent otherwise. This function has no effect if the image doesn’t have a mask.

Example: How transparency is handled by image masks

```lua
-- By default, new images are transparent, so an image mask is automatically applied to 'image'
local image = playdate.graphics.image.new(20, 20)
-- maskImage will be a 20x20 black image, to mark that the entire image should be transparent
local maskImage = image:getMaskImage()
maskImage:draw(0, 0)

-- When the image is drawn, there will be nothing drawn, because the image mask makes it all transparent
image:draw(0, 0)

-- Removing the mask here will result in 'image' no longer having transparency
image:removeMask()

-- Drawing the image again will draw a black square, because without an image mask, there is no transparency
image:draw(0, 0)

-- Hopefully this cements the concept that all transparency is handled by image masks
```

Example: Using image masks to apply a dither filter and a hole punch out effect

```lua
-- You can copy and paste this example directly as your main.lua file to see it in action
import "CoreLibs/graphics"

local gfx = playdate.graphics

-- Creating an image with a black circle
local circleDiameter = 25
local circleImage = gfx.image.new(circleDiameter, circleDiameter)
gfx.pushContext(circleImage)
    gfx.fillCircleInRect(0, 0, circleImage:getSize())
gfx.popContext()

-- Saving the original mask (the transparency in the corners of the image not covered by the circle)
local circleMask = circleImage:getMaskImage():copy()

-- Copying the original mask to preserve transparent regions around the circle
local ditherMask = circleMask:copy()
-- Drawing into mask with a dither effect
gfx.pushContext(ditherMask)
    gfx.setColor(gfx.kColorBlack)
    gfx.setDitherPattern(0.5, gfx.image.kDitherTypeBayer8x8)
    gfx.fillRect(0, 0, ditherMask:getSize())
gfx.popContext()

-- Copying the original mask to preserve transparent regions around the circle
local holeMask = circleMask:copy()
-- Drawing a hole into mask
gfx.pushContext(holeMask)
    gfx.setColor(gfx.kColorBlack)
    local width, height = holeMask:getSize()
    gfx.fillCircleAtPoint(width/2, height/2, width/4)
gfx.popContext()

function playdate.update()
    -- Circle is drawn with dithered regions transparent
    circleImage:setMaskImage(ditherMask)
    circleImage:drawAnchored(100, 120, 0.5, 0.5)

    -- Circle is drawn with hole in center
    circleImage:setMaskImage(holeMask)
    circleImage:drawAnchored(200, 120, 0.5, 0.5)

    -- Resetting the original mask returns the circle to normal
    circleImage:setMaskImage(circleMask)
    circleImage:drawAnchored(300, 120, 0.5, 0.5)
end

-- Technical details: Why copy the mask after getting it? :getMaskImage() returns a reference
-- to the mask image. Using :setMaskImage after will update that mask image to a new image, which
-- overwrites the referenced image and the original is lost. That's why we make a copy. Of course,
-- no :copy() calls are necessary if you don't intend to save the original mask.
```

##### Image effects

playdate.graphics.image:drawTiled(x, y, width, height, \[flip\])  
playdate.graphics.image:drawTiled(rect, \[flip\])

Tiles the image into the given rectangle, using either listed dimensions or a [`playdate.geometry.rect`](#C-geometry.rect) object, and the optional flip style.

playdate.graphics.image:drawBlurred(x, y, radius, numPasses, ditherType, \[flip\], \[xPhase, yPhase\])

Draws a blurred version of the image at (*x*, *y*).

- *radius*: A bigger radius means a more blurred result. Processing time is independent of the radius.

- *numPasses*: A box blur is used to blur the image. The more passes, the more closely the blur approximates a gaussian blur. However, higher values will take more time to process.

- *ditherType*: The algorithm to use when blurring the image, must be one of the values listed in [`playdate.graphics.image:blurredImage()`](#m-graphics.image.blurredImage)

- *flip*: optional; see [`playdate.graphics.image:draw()`](#m-graphics.imgDraw) for valid values.

- *xPhase*, *yPhase*: optional; integer values that affect the appearance of *playdate.graphics.image.kDitherTypeDiagonalLine*, *playdate.graphics.image.kDitherTypeVerticalLine*, *playdate.graphics.image.kDitherTypeHorizontalLine*, *playdate.graphics.image.kDitherTypeScreen*, *playdate.graphics.image.kDitherTypeBayer2x2*, *playdate.graphics.image.kDitherTypeBayer4x4*, and *playdate.graphics.image.kDitherTypeBayer8x8*.

playdate.graphics.image:blurredImage(radius, numPasses, ditherType, \[padEdges, \[xPhase, yPhase\]\])

Returns a blurred copy of the caller.

- *radius*: A bigger radius means a more blurred result. Processing time is independent of the radius.

- *numPasses*: A box blur is used to blur the image. The more passes, the more closely the blur approximates a gaussian blur. However, higher values will take more time to process.

- *ditherType*: The original image is blurred into a greyscale image then dithered back to 1-bit using one of the following dithering algorithms:

  -  *playdate.graphics.image.kDitherTypeNone*

  -  *playdate.graphics.image.kDitherTypeDiagonalLine*

  -  *playdate.graphics.image.kDitherTypeVerticalLine*

  -  *playdate.graphics.image.kDitherTypeHorizontalLine*

  -  *playdate.graphics.image.kDitherTypeScreen*

  -  *playdate.graphics.image.kDitherTypeBayer2x2*

  -  *playdate.graphics.image.kDitherTypeBayer4x4*

  -  *playdate.graphics.image.kDitherTypeBayer8x8*

  -  *playdate.graphics.image.kDitherTypeFloydSteinberg*

  -  *playdate.graphics.image.kDitherTypeBurkes*

  -  *playdate.graphics.image.kDitherTypeAtkinson*

- *padEdges*: Boolean indicating whether the edges of the images should be padded to accommodate the blur radius. Defaults to false.

- *xPhase*, *yPhase*: optional; integer values that affect the appearance of *playdate.graphics.image.kDitherTypeDiagonalLine*, *playdate.graphics.image.kDitherTypeVerticalLine*, *playdate.graphics.image.kDitherTypeHorizontalLine*, *playdate.graphics.image.kDitherTypeScreen*, *playdate.graphics.image.kDitherTypeBayer2x2*, *playdate.graphics.image.kDitherTypeBayer4x4*, and *playdate.graphics.image.kDitherTypeBayer8x8*.

playdate.graphics.image:drawFaded(x, y, alpha, ditherType)

Draws a partially transparent image with its upper-left corner at location (*x*, *y*)

- *alpha*: The alpha value used to draw the image, with 1 being fully opaque, and 0 being completely transparent.

- *ditherType*: The caller is faded using one of the dithering algorithms listed in [`playdate.graphics.image:blurredImage()`](#m-graphics.image.blurredImage)

playdate.graphics.image:fadedImage(alpha, ditherType)

Returns a faded version of the caller.

- *alpha*: The alpha value assigned to the caller, in the range 0.0 - 1.0. If an image mask already exists it is multiplied by *alpha*.

- *ditherType*: The caller is faded into a greyscale image and dithered with one of the dithering algorithms listed in [playdate.graphics.image:blurredImage()](#m-graphics.image.blurredImage)

playdate.graphics.image:setInverted(flag)

If *flag* is true, the image will be drawn with its colors inverted. If the image is being used as a stencil, its behavior is reversed: pixels are drawn where the stencil is black, nothing is drawn where the stencil is white.

playdate.graphics.image:invertedImage()

Returns a color-inverted copy of the caller.

playdate.graphics.image:blendWithImage(image, alpha, ditherType)

Returns an image that is a blend between the caller and *image*.

- *image*: the playdate.graphics.image to be blended with the caller.

- *alpha*: The alpha value assigned to the caller. *image* will have an alpha of (1 - *alpha*).

- *ditherType*: The caller and *image* are blended into a greyscale image and dithered with one of the dithering algorithms listed in [`playdate.graphics.image:blurredImage()`](#m-graphics.image.blurredImage)

playdate.graphics.image:vcrPauseFilterImage()

Returns an image created by applying a VCR pause effect to the calling image.

To add a VCR effect to a single image, call this function once on the source image; the function will return a distorted version of the source image. To add a VCR effect to a series of frames / video, call this function on every frame and display each returned image. (This function uses an internal random number to determine the appearance of the effect on each frame, so the effect will vary from frame to frame in a way that makes it appear like "live" paused video.)

##### Other image stuff

playdate.graphics.checkAlphaCollision(image1, x1, y1, flip1, image2, x2, y2, flip2)

Returns true if the non-alpha-masked portions of *image1* and *image2* overlap if they were drawn at positions (*x1*, *y1*) and (*x2*, *y2*) and flipped according to *flip1* and *flip2*, which should each be one of the values listed in [`playdate.graphics.image:draw()`](#m-graphics.imgDraw).

#### Color & Pattern

playdate.graphics.setColor(color)

Sets and gets the current drawing color for primitives.

*color* should be one of the constants:

- *playdate.graphics.kColorBlack*

- *playdate.graphics.kColorWhite*

- *playdate.graphics.kColorClear*

- *playdate.graphics.kColorXOR*

This color applies to drawing primitive shapes such as lines and rectangles, not bitmap images.

|           |                                                                                                                                                                                                                            |
|-----------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Important | [`setColor()`](#f-graphics.setColor) and [`setPattern()`](#f-graphics.setPattern) / [`setDitherPattern()`](#f-graphics.setDitherPattern) are mutually exclusive. Setting a color will overwrite a pattern, and vice versa. |

playdate.graphics.getColor()

Gets the current drawing color for primitives.

playdate.graphics.setBackgroundColor(color)

Sets the color used for drawing the background, if necessary, before [playdate.graphics.sprite](#C-graphics.sprite)s are drawn on top.

*color* should be one of the constants:

- *playdate.graphics.kColorBlack*

- *playdate.graphics.kColorWhite*

- *playdate.graphics.kColorClear*

Use *kColorClear* if you intend to draw behind sprites.

Equivalent to [`playdate->graphics->setBackgroundColor()`](./Inside%20Playdate%20with%20C.html#f-graphics.setBackgroundColor) in the C API.

playdate.graphics.getBackgroundColor()

Gets the color used for drawing the background, if necessary, before [playdate.graphics.sprite](#C-graphics.sprite)s are drawn on top.

playdate.graphics.setPattern(pattern)

Sets the 8x8 pattern used for drawing. The *pattern* argument is an array of 8 numbers describing the bitmap for each row; for example, *{ 0xaa, 0x55, 0xaa, 0x55, 0xaa, 0x55, 0xaa, 0x55 }* specifies a checkerboard pattern. An additional 8 numbers can be specified for an alpha mask bitmap.

|           |                                                                                                                                                                                                                                                                                              |
|-----------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Important | To "un-set" a pattern, call [`setColor()`](#f-graphics.setColor). [`setColor()`](#f-graphics.setColor) and [`setPattern()`](#f-graphics.setPattern) / [`setDitherPattern()`](#f-graphics.setDitherPattern) are mutually exclusive. Setting a pattern will overwrite a color, and vice versa. |

**`playdate.graphics.setPattern(image, [x, y])`**

Uses the given [playdate.graphics.image](#C-graphics.image) to set the 8 x 8 pattern used for drawing. The optional *x*, *y* offset (default 0, 0) indicates the top left corner of the 8 x 8 pattern.

playdate.graphics.setDitherPattern(alpha, \[ditherType\])

Sets the pattern used for drawing to a dithered pattern. If the current drawing color is white, the pattern is white pixels on a transparent background and (due to a bug) the *alpha* value is inverted: 1.0 is transparent and 0 is opaque. Otherwise, the pattern is black pixels on a transparent background and *alpha* 0 is transparent while 1.0 is opaque.

The optional *ditherType* argument is a dither type as used in [`playdate.graphics.image:blurredImage()`](#m-graphics.image.blurredImage), and should be an ordered dither type; i.e., line, screen, or Bayer.

|         |                                                                                                                                                                                                             |
|---------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Caution | The error-diffusing dither types Floyd-Steinberg (`kDitherTypeFloydSteinberg`), Burkes (`kDitherTypeBurkes`), and Atkinson (`kDitherTypeAtkinson`) are allowed but produce very unpredictable results here. |

#### Drawing

##### Line

playdate.graphics.drawLine(x1, y1, x2, y2)  
playdate.graphics.drawLine(ls)

Draws a line from (*x1*, *y1*) to (*x2*, *y2*), or draws the [playdate.geometry.lineSegment](#C-geometry.lineSegment) *ls*.

Line width is specified by [setLineWidth()](#f-graphics.setLineWidth). End cap style is specified by [setLineCapStyle()](#f-graphics.setLineCapStyle).

Equivalent to [`playdate->graphics->drawLine()`](./Inside%20Playdate%20with%20C.html#f-graphics.drawLine) in the C API.

playdate.graphics.setLineCapStyle(style)

Specifies the shape of the endpoints drawn by [drawLine](#f-graphics.drawLine).

*style* should be one of these constants:

- *playdate.graphics.kLineCapStyleButt*

- *playdate.graphics.kLineCapStyleRound*

- *playdate.graphics.kLineCapStyleSquare*

Equivalent to [`playdate->graphics->setLineCapStyle()`](./Inside%20Playdate%20with%20C.html#f-graphics.setLineCapStyle) in the C API.

##### Pixel

playdate.graphics.drawPixel(x, y)

Draw a single pixel in the current color at (*x*, *y*).

**`playdate.graphics.drawPixel(p)`**

Draw a single pixel in the current color at [playdate.geometry.point](#C-geometry.point) *p*.

##### Rect

playdate.graphics.drawRect(x, y, w, h)  
playdate.graphics.drawRect(r)

Draws the rect *r* or the rect with origin (*x*, *y*) with a size of (*w*, *h*).

Line width is specified by [setLineWidth()](#f-graphics.setLineWidth). Stroke location is specified by [setStrokeLocation()](#f-graphics.setStrokeLocation).

Equivalent to [`playdate->graphics->drawRect()`](./Inside%20Playdate%20with%20C.html#f-graphics.drawRect) in the C API.

playdate.graphics.fillRect(x, y, width, height)  
playdate.graphics.fillRect(r)

Draws the filled rectangle *r* or the rect at (*x*, *y*) of the given width and height.

Equivalent to [`playdate->graphics->fillRect()`](./Inside%20Playdate%20with%20C.html#f-graphics.fillRect) in the C API.

##### Round rect

playdate.graphics.drawRoundRect(x, y, w, h, radius)  
playdate.graphics.drawRoundRect(r, radius)

Draws a rectangle with rounded corners in the rect *r* or the rect with origin (*x*, *y*) and size (*w*, *h*).

*radius* defines the radius of the corners.

playdate.graphics.fillRoundRect(x, y, w, h, radius)  
playdate.graphics.fillRoundRect(r, radius)

Draws a filled rectangle with rounded corners in the rect *r* or the rect with origin (*x*, *y*) and size (*w*, *h*).

*radius* defines the radius of the corners.

##### Arc

|           |                                                                       |
|-----------|-----------------------------------------------------------------------|
| Important | You must import *CoreLibs/graphics* to use the arc drawing functions. |

playdate.graphics.drawArc(arc)  
playdate.graphics.drawArc(x, y, radius, startAngle, endAngle)

Draws an arc using the current color.

Angles are specified in degrees, not radians.

##### Circle

|           |                                                                          |
|-----------|--------------------------------------------------------------------------|
| Important | You must import *CoreLibs/graphics* to use the circle drawing functions. |

playdate.graphics.drawCircleAtPoint(x, y, radius)  
playdate.graphics.drawCircleAtPoint(p, radius)

Draws a circle at the point *(x, y)* (or *p*) with radius *radius*.

playdate.graphics.drawCircleInRect(x, y, width, height)  
playdate.graphics.drawCircleInRect(r)

Draws a circle in the rect *r* or the rect with origin *(x, y)* and size *(width, height)*.

If the rect is not a square, the circle will be drawn centered in the rect.

playdate.graphics.fillCircleAtPoint(x, y, radius)  
playdate.graphics.fillCircleAtPoint(p, radius)

Draws a filled circle at the point *(x, y)* (or *p*) with radius *radius*.

playdate.graphics.fillCircleInRect(x, y, width, height)  
playdate.graphics.fillCircleInRect(r)

Draws a filled circle in the rect *r* or the rect with origin *(x, y)* and size *(width, height)*.

If the rect is not a square, the circle will be drawn centered in the rect.

##### Ellipse

playdate.graphics.drawEllipseInRect(x, y, width, height, \[startAngle, endAngle\])  
playdate.graphics.drawEllipseInRect(rect, \[startAngle, endAngle\])

Draws an ellipse in the rect *r* or the rect with origin *(x, y)* and size *(width, height)*.

*startAngle* and *endAngle*, if provided, should be in degrees (not radians), and will cause only the segment of the ellipse between *startAngle* and *endAngle* to be drawn.

playdate.graphics.fillEllipseInRect(x, y, width, height, \[startAngle, endAngle\])  
playdate.graphics.fillEllipseInRect(rect, \[startAngle, endAngle\])

Draws a filled ellipse in the rect *r* or the rect with origin *(x, y)* and size *(width, height)*.

*startAngle* and *endAngle*, if provided, should be in degrees (not radians), and will cause only the segment of the ellipse between *startAngle* and *endAngle* to be drawn.

##### Polygon

playdate.graphics.drawPolygon(p)

Draw the [playdate.geometry.polygon](#C-geometry.polygon) *p*. Only draws a line between the first and last vertex if the polygon is [closed](#m-geometry.polygon.close).

Line width is specified by [setLineWidth()](#f-graphics.setLineWidth).

playdate.graphics.drawPolygon(x1, y1, x2, y2, \[...\])

Draw the polygon specified by the given sequence of x,y coordinates, including an edge between the last vertex and the first. The Lua function `table.unpack()` can be used to turn an array into function arguments.

Line width is specified by [setLineWidth()](#f-graphics.setLineWidth).

playdate.graphics.fillPolygon(x1, y1, x2, y2, \[...\])

Fills the polygon specified by a list of x,y coordinates. An edge between the last vertex and the first is assumed.

Equivalent to [`playdate->graphics->fillPolygon()`](./Inside%20Playdate%20with%20C.html#f-graphics.fillPolygon) in the C API.

playdate.graphics.fillPolygon(p)

Fills the polygon specified by the [playdate.geometry.polygon](#C-geometry.polygon) *p* with the currently selected color or pattern. The function throws an error if the polygon is not [closed](#m-geometry.polygon.isClosed).

|     |                                                                                         |
|-----|-----------------------------------------------------------------------------------------|
| Tip | The Lua function `table.unpack()` can be used to turn an array into function arguments. |

playdate.graphics.setPolygonFillRule(rule)

Sets the winding rule for filling polygons, one of:

- *playdate.graphics.kPolygonFillNonZero*

- *playdate.graphics.kPolygonFillEvenOdd*

See <a href="https://en.wikipedia.org/wiki/Nonzero-rule" class="bare">https://en.wikipedia.org/wiki/Nonzero-rule</a> for an explanation of the winding rule.

##### Triangle

playdate.graphics.drawTriangle(x1, y1, x2, y2, x3, y3)

Draws a triangle with vertices (*x1*, *y1*), (*x2*, *y2*), and (*x3*, *y3*).

playdate.graphics.fillTriangle(x1, y1, x2, y2, x3, y3)

Draws a filled triangle with vertices (*x1*, *y1*), (*x2*, *y2*), and (*x3*, *y3*).

Equivalent to [`playdate->graphics->fillTriangle()`](./Inside%20Playdate%20with%20C.html#f-graphics.fillTriangle) in the C API.

##### Nine slice

A "9 slice" is a rectangular image that is made "stretchable" by being sliced into nine pieces — the four corners, the four edges, and the center.

|           |                                                              |
|-----------|--------------------------------------------------------------|
| Important | You must import *CoreLibs/nineslice* to use these functions. |

playdate.graphics.nineSlice.new(imagePath, innerX, innerY, innerWidth, innerHeight)

Returns a new 9 slice image from the image at imagePath with the stretchable region defined by other parameters. The arguments represent the origin and dimensions of the innermost ("center") slice.

playdate.graphics.nineSlice:getSize()

Returns the size of the 9 slice image as a pair *(width, height)*.

playdate.graphics.nineSlice:getMinSize()

Returns the minimum size of the 9 slice image as a pair *(width, height)*.

playdate.graphics.nineSlice:drawInRect(x, y, width, height)  
playdate.graphics.nineSlice:drawInRect(rect)

Draws the 9 slice image at the desired coordinates by stretching the defined region to achieve the width and height inputs.

##### Perlin noise

Perlin noise is an algorithm useful for generating "organic" looking things procedurally, such as terrain, visual effects, and more. For a good introduction to Perlin noise, see: <a href="http://flafla2.github.io/2014/08/09/perlinnoise.html" class="bare">http://flafla2.github.io/2014/08/09/perlinnoise.html</a>

playdate.graphics.perlin(x, y, z, repeat, \[octaves, persistence\])

Returns the Perlin value (from 0.0 to 1.0) at position *(x, y, z)*.

If *repeat* is greater than 0, the pattern of noise will repeat at that point on all 3 axes.

*octaves* is the number of octaves of noise to apply. Compute time increases linearly with each additional octave, but the results are a bit more organic, consisting of a combination of larger and smaller variations.

When using more than one octave, *persistence* is a value from 0.0 - 1.0 describing the amount the amplitude is scaled each octave. The lower the value of *persistence*, the less influence each successive octave has on the final value.

playdate.graphics.perlinArray(count, x, dx, \[y, dy, z, dz, repeat, octaves, persistence\])

Returns an array of Perlin values at once, avoiding the performance penalty of calling *perlin()* multiple times in a loop.

The parameters are the same as *perlin()* except:

*count* is the number of values to be returned.

*dx*, *dy*, and *dz* are how far to step along the x, y, and z axes in each iteration.

##### QRCode

playdate.graphics.generateQRCode(stringToEncode, desiredEdgeDimension, callback)

|           |                                                         |
|-----------|---------------------------------------------------------|
| Important | You must import *CoreLibs/qrcode* to use this function. |

|         |                                                                                                                                                                                                                                               |
|---------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Caution | This function uses [`playdate.timer`](#C-timer) internally, so be sure to call [`playdate.timer.updateTimers()`](#f-timer.updateTimers) in your main [`playdate.update()`](#c-update) function, otherwise the callback will never be invoked. |

Asynchronously returns an image representing a QR code for the passed-in string to the function `callback`. The arguments passed to the callback are [*image*](#C-graphics.image), *errorMessage*. (If an *errorMessage* string is returned, *image* will be nil.)

`desiredEdgeDimension` lets you specify an approximate edge dimension in pixels for the desired QR code, though the function has limited flexibility in sizing QR codes, based on the amount of information to be encoded, and the restrictions of a 1-bit screen. The function will attempt to generate a QR code *smaller* than `desiredEdgeDimension` if possible. (Note that QR codes always have the same width and height.)

If you specify nil for `desiredEdgeDimension`, the returned image will balance small size with easy readability. If you specify 0, the returned image will be the smallest possible QR code for the specified string.

`generateQRCode()` will return a reference to the [timer](#C-timer) it uses to run asynchronously. If you wish to stop execution of the background process generating the QR code, call [`:remove()`](#m-timer.remove) on that returned timer.

|     |                                                                                                                                                                                                                                                                                 |
|-----|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Tip | If you know ahead of time what data you plan to encode, it is much faster to pre-generate the QR code, store it as a .png file in your game, and draw the .png at runtime. You can use [`playdate.simulator.writeToFile()`](#f-simulator.writeToFile) to create this .png file. |

##### Sine wave

playdate.graphics.drawSineWave(startX, startY, endX, endY, startAmplitude, endAmplitude, period, \[phaseShift\])

|           |                                                           |
|-----------|-----------------------------------------------------------|
| Important | You must import *CoreLibs/graphics* to use this function. |

Draws an approximation of a sine wave between the points *startX, startY* and *endX, endY*.

- *startAmplitude*: The number of pixels above and below the line from *startX, startY* and *endX, endY* the peaks and valleys of the wave will be drawn at the start of the wave.

- *endAmplitude*: The number of pixels above and below the line from *startX, startY* and *endX, endY* the peaks and valleys of the wave will be drawn at the end of the wave.

- *period*: The distance between peaks, in pixels.

- *phaseShift*: If provided, specifies the wave’s offset, in pixels.

#### Drawing Modifiers

##### Clipping

playdate.graphics.setClipRect(x, y, width, height)  
playdate.graphics.setClipRect(rect)

`setClipRect()` sets the clipping rectangle for all subsequent graphics drawing, including bitmaps. The argument can either be separate dimensions or a [playdate.geometry.rect](#C-geometry.rect) object. The clip rect is automatically cleared at the beginning of the [`playdate.update()`](#c-update) callback. The function uses world coordinates; that is, the given rectangle will be translated by the current drawing offset. To use screen coordinates instead, use [`setScreenClipRect()`](#f-graphics.setScreenClipRect)

Equivalent to [`playdate->graphics->setClipRect()`](./Inside%20Playdate%20with%20C.html#f-graphics.setClipRect) in the C API.

playdate.graphics.setClipRect(rect)

`setClipRect()` sets the clipping rectangle for all subsequent graphics drawing, including bitmaps. The argument can either be separate dimensions or a [playdate.geometry.rect](#C-geometry.rect) object. The clip rect is automatically cleared at the beginning of the [`playdate.update()`](#c-update) callback. The function uses world coordinates; that is, the given rectangle will be translated by the current drawing offset. To use screen coordinates instead, use [`setScreenClipRect()`](#f-graphics.setScreenClipRect)

playdate.graphics.getClipRect()

`getClipRect()` returns multiple values (*x*, *y*, *width*, *height*) giving the current clipping rectangle.

playdate.graphics.setScreenClipRect(x, y, width, height)  
playdate.graphics.setScreenClipRect(rect)

Sets the clip rectangle as above, but uses screen coordinates instead of world coordinates—​that is, it ignores the current drawing offset.

Equivalent to [`playdate->graphics->setScreenClipRect()`](./Inside%20Playdate%20with%20C.html#f-graphics.setScreenClipRect) in the C API.

playdate.graphics.getScreenClipRect()

Returns the clip rect as in `getClipRect()`, but using screen coordinates instead of world coordinates.

playdate.graphics.clearClipRect()

Clears the current clipping rectangle, set with [`setClipRect()`](#f-graphics.setClipRect).

Equivalent to [`playdate->graphics->clearClipRect()`](./Inside%20Playdate%20with%20C.html#f-graphics.clearClipRect) in the C API.

##### Stencil

playdate.graphics.setStencilImage(image, \[tile\])

Sets the current [stencil](https://en.wikipedia.org/wiki/Stencil_buffer) to the given image. While the stencil is active, drawing functions will only draw pixels where the stencil is white and nothing is drawn where the stencil is black. If *tile* is set, the the stencil will be tiled; in this case, the image width must be a multiple of 32 pixels.

Equivalent to [`playdate->graphics->setStencilImage()`](./Inside%20Playdate%20with%20C.html#f-graphics.setStencilImage) in the C API.

playdate.graphics.setStencilPattern(pattern)

Sets a pattern to use for stenciled drawing, as an alternative to creating an image, drawing a pattern into the image, then using that in `setStencilImage()`. `pattern` should be a table of the form `{ row1, row2, row3, row4, row5, row6, row7, row8 }`.

playdate.graphics.setStencilPattern(row1, row2, row3, row4, row5, row6, row7, row8)

Sets a pattern to use for stenciled drawing, as an alternative to creating an image, drawing a pattern into the image, then using that in `setStencilImage()`.

playdate.graphics.setStencilPattern(level, \[ditherType\])

Sets the stencil to a dither pattern specified by *level* and optional *ditherType* (defaults to `playdate.graphics.image.kDitherTypeBayer8x8`).

playdate.graphics.clearStencil()

Clears the [stencil buffer](https://en.wikipedia.org/wiki/Stencil_buffer).

playdate.graphics.clearStencilImage()

|         |               |
|---------|---------------|
| Caution | *Deprecated.* |

Clears the [stencil buffer](https://en.wikipedia.org/wiki/Stencil_buffer).

##### Drawing mode

playdate.graphics.setImageDrawMode(mode)

Sets the current drawing mode for images.

|           |                                                                                                                                                         |
|-----------|---------------------------------------------------------------------------------------------------------------------------------------------------------|
| Important | The draw mode applies to images and fonts (which are technically images). The draw mode does not apply to primitive shapes such as lines or rectangles. |

The available options for *mode* (demonstrated by drawing a two-color background image first, setting the specified draw mode, then drawing the Crankin' character on top) are:

- *playdate.graphics.kDrawModeCopy*: Images are drawn exactly as they are (black pixels are drawn black and white pixels are drawn white)

![drawmode copy](Inside%20Playdate/drawmode-copy.png)

- *playdate.graphics.kDrawModeWhiteTransparent*: Any white portions of an image are drawn transparent (black pixels are drawn black and white pixels are drawn transparent)

![drawmode whitetransparent](Inside%20Playdate/drawmode-whitetransparent.png)

- *playdate.graphics.kDrawModeBlackTransparent*: Any black portions of an image are drawn transparent (black pixels are drawn transparent and white pixels are drawn white)

![drawmode blacktransparent](Inside%20Playdate/drawmode-blacktransparent.png)

- *playdate.graphics.kDrawModeFillWhite*: All non-transparent pixels are drawn white (black pixels are drawn white and white pixels are drawn white)

![drawmode fillwhite](Inside%20Playdate/drawmode-fillwhite.png)

- *playdate.graphics.kDrawModeFillBlack*: All non-transparent pixels are drawn black (black pixels are drawn black and white pixels are drawn black)

![drawmode fillblack](Inside%20Playdate/drawmode-fillblack.png)

- *playdate.graphics.kDrawModeXOR*: Pixels are drawn inverted on white backgrounds, creating an effect where any white pixels in the original image will always be visible, regardless of the background color, and any black pixels will appear transparent (on a white background, black pixels are drawn white and white pixels are drawn black)

![drawmode xor](Inside%20Playdate/drawmode-xor.png)

- *playdate.graphics.kDrawModeNXOR*: Pixels are drawn inverted on black backgrounds, creating an effect where any black pixels in the original image will always be visible, regardless of the background color, and any white pixels will appear transparent (on a black background, black pixels are drawn white and white pixels are drawn black)

![drawmode nxor](Inside%20Playdate/drawmode-nxor.png)

- *playdate.graphics.kDrawModeInverted*: Pixels are drawn inverted (black pixels are drawn white and white pixels are drawn black)

![drawmode inverted](Inside%20Playdate/drawmode-inverted.png)

Instead of the above-specified constants, you can also use one of the following strings: "copy", "inverted", "XOR", "NXOR", "whiteTransparent", "blackTransparent", "fillWhite", or "fillBlack".

Equivalent to [`playdate->graphics->setDrawMode()`](./Inside%20Playdate%20with%20C.html#f-graphics.setDrawMode) in the C API.

playdate.graphics.getImageDrawMode()

Gets the current drawing mode for images.

##### Lines & Strokes

playdate.graphics.setLineWidth(width)

Sets the width of the line for [drawLine](#f-graphics.drawLine), [drawRect](#f-graphics.drawRect), [drawPolygon](#f-graphics.drawPolygon), and [drawArc](#f-graphics.drawArc) when a [playdate.geometry.arc](#C-geometry.arc) is passed as the argument. This value is saved and restored when pushing and popping the [graphics context](#f-graphics.pushContext).

playdate.graphics.getLineWidth()

Gets the current line width.

playdate.graphics.setStrokeLocation(location)

Specifies where the stroke is placed relative to the rectangle passed into [drawRect](#f-graphics.drawRect).

*location* is one of these constants:

- *playdate.graphics.kStrokeCentered*

- *playdate.graphics.kStrokeOutside*

- *playdate.graphics.kStrokeInside*

This value is saved and restored when pushing and popping the [graphics context](#f-graphics.pushContext).

playdate.graphics.getStrokeLocation()

Gets the current stroke position.

#### Offscreen Drawing

playdate.graphics.lockFocus(image)

`lockFocus()` routes all drawing to the given [playdate.graphics.image](#C-graphics.image). [playdate.graphics.unlockFocus()](#f-graphics.unlockFocus) returns drawing to the frame buffer.

|           |                                                                                                                                                                                                                                                                       |
|-----------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Important | If you draw into an image with color set to *playdate.graphics.kColorClear*, those drawn pixels will be set to transparent. When you later draw the image into the framebuffer, those pixels will not be rendered, i.e., will act as transparent pixels in the image. |

|      |                                                                                                                                                                                                      |
|------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Note | [playdate.graphics.pushContext(*image*)](#f-graphics.pushContext) will also allow offscreen drawing into an image, with the additional benefit of being able to save and restore the graphics state. |

playdate.graphics.unlockFocus()

After calling `unlockFocus()`, drawing is routed to the frame buffer.

Example: Drawing into multiple images with lockFocus

```lua
-- If you're drawing into multiple different images, using lockFocus might be easier (and
-- slightly faster performance-wise) than having to repeatedly call pushContext/popContext

local tinyCircle = gfx.image.new(10, 10)
local smallCircle = gfx.image.new(20, 20)
local mediumCircle = gfx.image.new(30, 30)
local largeCircle = gfx.image.new(40, 40)

gfx.lockFocus(tinyCircle) -- draw into tinyCircle image
-- Drawing coordinates are relative to the image, so (0, 0) is the top left of the image
gfx.fillCircleInRect(0, 0, tinyCircle:getSize())
gfx.lockFocus(smallCircle) -- draw into smallCircle image
gfx.fillCircleInRect(0, 0, smallCircle:getSize())
gfx.lockFocus(mediumCircle) -- draw into mediumCircle image
gfx.fillCircleInRect(0, 0, mediumCircle:getSize())
gfx.lockFocus(largeCircle) -- draw into largeCircle image
gfx.fillCircleInRect(0, 0, largeCircle:getSize())
gfx.unlockFocus() -- unlock focus to bring drawing back to frame buffer
```

#### Animation

##### Animation loop

playdate.graphics.animation.loop helps keep track of animation frames, especially for frames in an [`playdate.graphics.imagetable`](#C-graphics.imagetable). For a more general timer see [playdate.timer](#C-timer) or [playdate.frameTimer](#C-frameTimer).

|           |                                                              |
|-----------|--------------------------------------------------------------|
| Important | You must import *CoreLibs/animation* to use these functions. |

playdate.graphics.animation.loop.new(\[interval\], imageTable, \[shouldLoop\])

Creates a new animation object.

- ***imageTable*** must be a [`playdate.graphics.imagetable`](#C-graphics.imagetable) or an array-style table of [`playdate.graphics.images`](#C-graphics.image).

The following properties can be read or set directly, and have these defaults:

- ***interval*** : the value of *interval*, if passed, or 100ms (the elapsed time before advancing to the next imageTable frame)

- ***startFrame*** : 1 (the value the object resets to when the loop completes)

- ***endFrame*** : the number of images in *imageTable* if passed, or 1 (the last frame value in the loop)

- ***frame*** : 1 (the current frame counter)

- ***step*** : 1 (the value by which frame increments)

- ***shouldLoop*** : the value of *shouldLoop*, if passed, or true. (whether the object loops when it completes)

- ***paused*** : false (paused loops don’t change their frame value)

playdate.graphics.animation.loop:draw(x, y, \[flip\])

Draw’s the loop’s current image at *x*, *y*.

The *flip* argument is optional; see [`playdate.graphics.image:draw()`](#m-graphics.imgDraw) for valid values.

playdate.graphics.animation.loop:image()

Returns a [`playdate.graphics.image`](#C-graphics.image) from the caller’s *imageTable* if it exists. The image returned will be at the imageTable’s index that matches the caller’s *frame*.

playdate.graphics.animation.loop:isValid()

Returns false if the loop has passed its last frame and does not loop.

playdate.graphics.animation.loop:setImageTable(imageTable)

Sets the [`playdate.graphics.imagetable`](#C-graphics.imagetable) to be used for this animation loop, and sets the loop’s endFrame property to \#imageTable.

Example: Using an animation loop to draw an animated image

```lua
local gfx = playdate.graphics

-- Each frame of the animation will last 200ms
local frameTime = 200
local animationImagetable = gfx.imagetable.new("path/to/imagetable")
-- Setting the last argument to true makes it so the animation will loop
local animationLoop = gfx.animation.loop.new(frameTime, animationImagetable, true)

function playdate.update()
    -- Draws the animation in a loop
    animationLoop:draw(0, 0)
end
```

Example: Creating multiple animation states from one sprite sheet

```lua
local gfx = playdate.graphics

-- In this example, the imagetable is one sprite sheet, made up of multiple animations
local animationImagetable = gfx.imagetable.new("path/to/imagetable")

-- Creating the idle animation loop (400ms per frame)
local idleAnimation = gfx.animation.loop.new(400, animationImagetable, true)
-- In this example, the idle animation is made of up frames 1 through 3 of the
-- imagetable, so the startFrame and endFrame properties are set accordingly
idleAnimation.startFrame = 1
idleAnimation.endFrame = 3

-- Creating the run animation loop (200ms per frame)
local runAnimation = gfx.animation.loop.new(200, animationImagetable, true)
-- In this example, the run animation is made of up frames 4 through 8 of the
-- imagetable, so the startFrame and endFrame properties are set accordingly
runAnimation.startFrame = 4
runAnimation.endFrame = 8

-- Creating a simple state tracker
local states = {idle = 1, run = 2}
local state = states.idle

function playdate.update()
    -- Draw different animations based on the state
    if state == states.idle then
        idleAnimation:draw(0, 0)
    elseif state == states.run then
        runAnimation:draw(0, 0)
    end
end
```

Example: Using an animation loop in a sprite

```lua
local gfx = playdate.graphics

-- Each frame of the animation will last 200ms
local frameTime = 200
local animationImagetable = gfx.imagetable.new("path/to/imagetable")
-- Setting the last argument to false makes the animation stop on the last frame
local animationLoop = gfx.animation.loop.new(frameTime, animationImagetable, false)
-- Set sprite image to first frame of the animation
local animatedSprite = gfx.sprite.new(animationLoop:image())
-- Add sprite to display list
animatedSprite:add()
-- One easy way to update the sprite image to match the animation
-- is to simply override the sprite update method and do it there
animatedSprite.update = function()
    animatedSprite:setImage(animationLoop:image())
    -- Optionally, removing the sprite when the animation finished
    if not animationLoop:isValid() then
        animatedSprite:remove()
    end
end
```

##### Animator

Animators are lightweight objects that keep track of animation progress. They can animate between two numbers, two points, along a line segment, arc, or polygon, or along a compound path made up of all three.

Usage is simple: create a new Animator, query for its current value when you need to update your animation, and optionally call [`animator:ended()`](#m-graphics.animator.ended) to see if the animation is complete.

|     |                                                                           |
|-----|---------------------------------------------------------------------------|
| Tip | Example code: `<Playdate SDK>/Examples/Single File Examples/animator.lua` |

|           |                                                             |
|-----------|-------------------------------------------------------------|
| Important | You must import *CoreLibs/animator* to use these functions. |

playdate.graphics.animator.new(duration, startValue, endValue, \[easingFunction, \[startTimeOffset\]\])

Animates between two number or [playdate.geometry.point](#C-geometry.point) values.

*duration* is the total time of the animation in milliseconds.

*startValue* and *endValue* should be either numbers or [playdate.geometry.point](#C-geometry.point)

*easingFunction*, if supplied, should be a value from [playdate.easingFunctions](#M-easingFunctions). If your easing function requires additional variables *s*, *a*, or *p*, set them on the animator directly after creation. For example:

```lua
local a = playdate.graphics.animator.new(1000, 0, 100, playdate.easingFunctions.inBack)
a.s = 1.9
```

*startTimeOffset*, if supplied, will shift the start time of the animation by the specified number of milliseconds. (If positive, the animation will be delayed. If negative, the animation will effectively have started before the moment the animator is instantiated.)

Example: Using an animator to animate movement

```lua
-- You can copy and paste this example directly as your main.lua file to see it in action
import "CoreLibs/graphics"
import "CoreLibs/animator"

-- We'll be demonstrating how to use an animator to animate a square moving across the screen
local square = playdate.graphics.image.new(20, 20, playdate.graphics.kColorBlack)

-- 1000ms, or 1 second
local animationDuration = 1000
-- We're animating from the left to the right of the screen
local startX, endX = -20, 400
-- Setting an easing function to get a nice, smooth movement
local easingFunction = playdate.easingFunctions.inOutCubic
local animator = playdate.graphics.animator.new(animationDuration, startX, endX, easingFunction)
animator.repeatCount = -1 -- Make animator repeat forever

function playdate.update()
    -- Clear the screen
    playdate.graphics.clear()

    -- By using :currentValue() as the x value, the square follows along with the animation
    square:draw(animator:currentValue(), 120)
end
```

playdate.graphics.animator.new(duration, lineSegment, \[easingFunction, \[startTimeOffset\]\])

Creates a new Animator that will animate along the provided [playdate.geometry.lineSegment](#C-geometry.lineSegment)

Example: Using an animator to animate along a line

```lua
-- You can copy and paste this example directly as your main.lua file to see it in action
import "CoreLibs/graphics"
import "CoreLibs/animator"

-- We'll be demonstrating how to use an animator to animate a square moving across the screen
local square = playdate.graphics.image.new(20, 20, playdate.graphics.kColorBlack)

-- 1000ms, or 1 second
local animationDuration = 1000
-- We're animating from the top left to the bottom right of the screen
local line = playdate.geometry.lineSegment.new(0, 0, 400, 240)
local animator = playdate.graphics.animator.new(animationDuration, line)

function playdate.update()
    -- Clear the screen
    playdate.graphics.clear()

    -- We can use :currentValue() directly, as it returns a point
    square:draw(animator:currentValue())
end
```

playdate.graphics.animator.new(duration, arc, \[easingFunction, \[startTimeOffset\]\])

Creates a new Animator that will animate along the provided [playdate.geometry.arc](#C-geometry.arc)

playdate.graphics.animator.new(duration, polygon, \[easingFunction, \[startTimeOffset\]\])

Creates a new Animator that will animate along the provided [playdate.geometry.polygon](#C-geometry.polygon)

playdate.graphics.animator.new(durations, parts, easingFunctions, \[startTimeOffset\])

Creates a new Animator that will animate along each of the items in the *parts* array in order, which should be comprised of [playdate.geometry.lineSegment](#C-geometry.lineSegment), [playdate.geometry.arc](#C-geometry.arc), or [playdate.geometry.polygon](#C-geometry.polygon) objects.

*durations* should be an array of durations, one for each item in *parts*.

*easingFunctions* should be an array of [playdate.easingFunctions](#M-easingFunctions), one for each item in *parts*.

|      |                                                                                                                                                                                                                                                                                                                                                                               |
|------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Note | By default, animators do not repeat. If you would like them to, set the animator’s *repeatCount* property to the number of times the animation should repeat. It can be set to any positive number or -1 to indicate the animation should repeat forever. Note that a repeat count of 1 means the animation will play twice - once for the initial animation plus one repeat. |

Example: Using an animator with parts

```lua
-- You can copy and paste this example directly as your main.lua file to see it in action
import "CoreLibs/graphics"
import "CoreLibs/animator"

-- We'll be demonstrating how to animate something with parts
local square = playdate.graphics.image.new(20, 20, playdate.graphics.kColorBlack)

-- First part will take 3 seconds, second part will take 1, and third part will take 2
local animationDurations = {3000, 1000, 2000}
-- We'll first animate along a line, then an arc, and then a polygon
local animationParts = {
    playdate.geometry.lineSegment.new(0, 0, 200, 80),
    playdate.geometry.arc.new(200, 120, 40, 0, 180),
    playdate.geometry.polygon.new(200, 160, 300, 90, 390, 230)
}
-- We must set the easing functions for each part, and they can all be different
local animationEasingFunctions = {
    playdate.easingFunctions.outQuart,
    playdate.easingFunctions.inOutCubic,
    playdate.easingFunctions.outBounce
}

-- To animate by parts, each argument must be arrays of equal length
local animator = playdate.graphics.animator.new(animationDurations, animationParts, animationEasingFunctions)

function playdate.update()
    -- Clear the screen
    playdate.graphics.clear()

    -- We can use :currentValue() directly, as it returns a point
    square:draw(animator:currentValue())
end
```

playdate.graphics.animator:currentValue()

Returns the current value of the animation, which will be either a number or a [playdate.geometry.point](#C-geometry.point), depending on the type of animator.

playdate.graphics.animator:valueAtTime(time)

Returns the value of the animation at the given number of milliseconds after the start time. The value will be either a number or a [playdate.geometry.point](#C-geometry.point), depending on the type of animator.

playdate.graphics.animator:progress()

Returns the current progress of the animation as a value from 0 to 1.

playdate.graphics.animator:reset(\[duration\])

Resets the animation, setting its start time to the current time, and changes the animation’s duration if a new duration is given.

playdate.graphics.animator:ended()

Returns true if the animation is completed. Only returns true if this function or [`currentValue()`](#m-graphics.animator.currentValue) has been called since the animation ended in order to allow animations to fully finish before true is returned.

playdate.graphics.animator.easingAmplitude

For [easing functions](#M-easingFunctions) that take additional amplitude (such as *inOutElastic*), set these values on animator instances to the desired values.

playdate.graphics.animator.easingPeriod

For [easing functions](#M-easingFunctions) that take additional period arguments (such as *inOutElastic*), set these values on animator instances to the desired values.

playdate.graphics.animator.repeatCount

Indicates the number of times after the initial animation the animator should repeat; i.e., if repeatCount is set to 2, the animation will play through 3 times.

playdate.graphics.animator.reverses

If set to true, after the animation reaches the end, it runs in reverse from the end to the start. The time to complete both the forward and reverse will be *duration* x 2. Defaults to false.

##### Blinker

playdate.graphics.animation.blinker keeps track of a boolean that changes on a timer.

|           |                                                        |
|-----------|--------------------------------------------------------|
| Important | You must import *CoreLibs/animation* to use `blinker`. |

playdate.graphics.animation.blinker.new(\[onDuration, \[offDuration, \[loop, \[cycles, \[default\]\]\]\]\])

Creates a new blinker object. Check the object’s `on` property to determine whether the blinker is on (`true`) or off (`false`). The default properties are:

- *onDuration*: 200 (the number of milliseconds the blinker is "on")

- *offDuration*: 200 (the number of milliseconds the blinker is "off")

- *loop*: false (should the blinker restart after completing)

- *cycles*: 6 (the number of changes the blinker goes through before it’s complete)

- *default*: true (the state the blinker will start in. **Note:** if default is `true`, `blinker.on` will return `true` when the blinker is in its *onDuration* phase. If default is `false`, `blinker.on` will return `false` when the blinker is in its *onDuration* phase.)

Other informative properties:

- *counter*: Read this property to see which cycle the blinker is on (counts from *n* down to zero)

- *on*: Read this property to determine the current state of the blinker. The blinker always starts in the state specified by the `default` property.

- *running*: Read this property to see if the blinker is actively running

playdate.graphics.animation.blinker.updateAll()

Updates the state of all valid blinkers by calling [:update()](#m-graphics.animation.blinker.update) on each.

|           |                                                                                                                                               |
|-----------|-----------------------------------------------------------------------------------------------------------------------------------------------|
| Important | If you intend to use blinkers, be sure to call `:updateAll()` once a cycle, ideally in your game’s [`playdate.update()`](#c-update) function. |

playdate.graphics.animation.blinker:update()

Updates the caller’s state.

playdate.graphics.animation.blinker:start(\[onDuration, \[offDuration, \[loop, \[cycles, \[default\]\]\]\]\])

Starts a blinker if it’s not running. Pass values for any property values you wish to modify.

playdate.graphics.animation.blinker:startLoop()

Starts a blinker if it’s not running and sets its `loop` property to true. Equivalent to calling `playdate.graphics.animation.blinker:start(nil, nil, true)`

playdate.graphics.animation.blinker:stop()

Stops a blinker if it’s running, returning the blinker’s `on` properly to the default value.

playdate.graphics.animation.blinker.stopAll()

Stops all blinkers.

playdate.graphics.animation.blinker:remove()

Flags the caller for removal from the global list of blinkers

#### Scrolling

playdate.graphics.setDrawOffset(x, y)

`setDrawOffset(x, y)` offsets the origin point for all drawing calls to *x*, *y* (can be negative). So, for example, if the offset is set to -20, -20, an image drawn at 20, 20 will appear at the origin (in the upper left corner.)

This is useful, for example, for centering a "camera" on a sprite that is moving around a world larger than the screen.

|      |                                                                                                                                                                                                                                                                                                             |
|------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Note | The *x* and *y* arguments to `.setDrawOffset()` are always specified in the original, unaltered coordinate system. So, for instance, repeated calls to `playdate.graphics.setDrawOffset(-10, -10)` will leave the draw offset unchanged. Likewise, `.setDrawOffset(0, 0)` will always "disable" the offset. |

|     |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
|-----|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Tip | It can be useful to have operations sometimes ignore the draw offsets. For example, you may want to have the score or some other heads-up display appear onscreen apart from scrolling content. A sprite can be set to ignore offsets by calling [playdate.graphics.sprite:setIgnoresDrawOffset(true)](#m-graphics.sprite.setIgnoresDrawOffset). [playdate.graphics.image:drawIgnoringOffsets()](#m-graphics.image.drawIgnoringOffset) lets you render an image using screen coordinates. |

Equivalent to [`playdate->graphics->setDrawOffset()`](./Inside%20Playdate%20with%20C.html#f-graphics.setDrawOffset) in the C API.

playdate.graphics.getDrawOffset()

`getDrawOffset()` returns multiple values (*x*, *y*) giving the current draw offset.

|         |                                                                                                                                                   |
|---------|---------------------------------------------------------------------------------------------------------------------------------------------------|
| Caution | These functions are different from [playdate.display.setOffset()](#f-display.setOffset) and [playdate.display.getOffset()](#f-display.getOffset). |

#### Frame buffer

playdate.graphics.getDisplayImage()

Returns a copy the contents of the *last completed frame*, i.e., a "screenshot", as a [playdate.graphics.image](#C-graphics.image).

|      |                                                                                                                                                                                                                   |
|------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Note | Display functions like [setMosaic()](#f-display.setMosaic), [setInverted()](#f-display.setInverted), [setScale()](#f-display.setScale), and [setOffset()](#f-display.setOffset) do not affect the returned image. |

playdate.graphics.getWorkingImage()

Returns a copy the contents of the working frame buffer — *the current frame, in-progress* — as a [playdate.graphics.image](#C-graphics.image).

|      |                                                                                                                                                                                                                   |
|------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Note | Display functions like [setMosaic()](#f-display.setMosaic), [setInverted()](#f-display.setInverted), [setScale()](#f-display.setScale), and [setOffset()](#f-display.setOffset) do not affect the returned image. |

#### Image table

There are two kinds of image tables: **matrix** and **sequential**.

**Matrix image tables** are great as sources of imagery for [tilemap](#C-graphics.tilemap). They are loaded from a single file in your game’s source folder with the suffix `-table-<w>-<h>` before the file extension. The compiler splits the image into separate bitmaps of dimension *w* by *h* pixels that are accessible via [imagetable:getImage(x,y)](#m-graphics.imagetable.getImage-xy).

**Sequential image tables** are useful as a way to load up sequential frames of animation. They are loaded from a sequence of files in your game’s source folder *at compile time* from filenames with the suffix `-table-<sequenceNumber>` before the file extension. Individual images in the sequence are accessible via [imagetable:getImage(n)](#m-graphics.imagetable.getImage-n). The images employed by a sequential image table are not required to be the same size, unlike the images used in a matrix image table.

playdate.graphics.imagetable.new(path)

Returns a [playdate.graphics.imagetable](#C-graphics.imagetable) object from the data at *path*. If there is no file at *path*, the function returns nil and a second value describing the error. If the file at *path* is an animated GIF, successive frames of the GIF will be loaded as consecutive bitmaps in the imagetable. Any timing data in the animated GIF will be ignored.

|           |                                                                                                                              |
|-----------|------------------------------------------------------------------------------------------------------------------------------|
| Important | To load a **matrix** image table defined in `frames-table-16-16.png`, you call `playdate.graphics.imagetable.new("frames")`. |

|           |                                                                                                                                                                      |
|-----------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Important | To load a **sequential** image table defined with the files `frames-table-1.png`, `frames-table-2.png`, etc., you call `playdate.graphics.imagetable.new("frames")`. |

playdate.graphics.imagetable.new(count, \[cellsWide\], \[cellSize\])

Returns an empty image table for loading images into via [imagetable:load()](#m-graphics.imagetable.load) or setting already-loaded images into with [imagetable:setImage()](#m-graphics.imagetable.setImage). If set, *cellsWide* is used to locate images by x,y position. The optional *cellSize* argument gives the allocation size for the images, if [load()](#m-graphics.imagetable.load) will be used. (This is a weird technical detail, so ask us if you need guidance here.)

playdate.graphics.imagetable:getImage(n)

Returns the *n*-th [playdate.graphics.image](#C-graphics.image) in the table (ordering left-to-right, top-to-bottom). The first image is at index 1. If .n\_ or (*x*,*y*) is out of bounds, the function returns nil. See also [imagetable\[n\]](#m-graphics.imagetable.__len).

playdate.graphics.imagetable:getImage(x,y)

Returns the image in cell (*x*,*y*) in the original bitmap. The first image is at index 1. If *n* or (*x*,*y*) is out of bounds, the function returns nil. See also [imagetable\[n\]](#m-graphics.imagetable.__len).

playdate.graphics.imagetable:setImage(n, image)

Sets the image at slot *n* in the image table by creating a reference to the data in *image*.

playdate.graphics.imagetable:load(path)

Loads a new image table from the data at *path* into an already-existing image table, without allocating additional memory. The image table at *path* must contain images of the same dimensions as the previous.

Returns `(success, [error])`. If the boolean `success` is false, `error` is also returned.

playdate.graphics.imagetable:getLength()

Returns the number of images in the table. See also [\#imagetable](#m-graphics.imagetable.__len).

playdate.graphics.imagetable:getSize()

Returns the pair (*cellsWide*, *cellsHigh*).

playdate.graphics.imagetable:drawImage(n,x,y,\[flip\])

Equivalent to `graphics.imagetable:getImage(n):draw(x,y,[flip])`.

playdate.graphics.imagetable\[n\]

Equivalent to [imagetable:getImage(n)](#m-graphics.imagetable.getImage-n).

\#playdate.graphics.imagetable

Equivalent to [imagetable:getLength()](#m-graphics.imagetable.getLength)

|     |                                                                                                                                                                                                                                                                                 |
|-----|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Tip | In Lua, you can get the length of a string or table using the [length operator](http://www.lua.org/manual/5.1/manual.html#2.5.5). For a `playdate.graphics.imagetable` called `myImageTable`, both `#myImageTable` and `myImageTable:getLength()` would return the same result. |

#### Tilemap

Tilemaps are often used to represent the game environment. Tiles are a very efficient way to create levels and scenery. (Alternatively, [sprites](#C-graphics.sprite) are the best way to create objects that move about your playfield, like the character that represents the player, enemies, etc.)

At its most fundamental, a tilemap is a table of indexes into an [playdate.graphics.imagetable](#C-graphics.imagetable). The images in the imagetable represent small chunks of your scenery; the tilemap is what organizes them into a specific arrangement.

##### How-To

A typical usage of tilemaps might be to assist in drawing a game level:

1.  Instantiate a blank [tilemap](#f-graphics.tilemap.new).

2.  Attach an [imagetable](#m-graphics.tilemap.setImageTable) — a matrix of tile images that your game level will utilize.

3.  Set your tilemap’s matrix of indices — these represent your game level — into the imagetable using [:setTiles()](#m-graphics.tilemap.setTiles). (A tilemap editor such as [Tiled](https://www.mapeditor.org) can be very useful for this.) This is also where you specify your tilemap’s width.

4.  Draw your tilemap using [:draw()](#m-graphics.tilemap.draw).

##### Configuring

playdate.graphics.tilemap.new()

Creates a new tilemap object.

playdate.graphics.tilemap:setImageTable(table)

Sets the tilemap’s [playdate.graphics.imagetable](#C-graphics.imagetable) to *table*, a [playdate.graphics.imagetable](#C-graphics.imagetable).

playdate.graphics.tilemap:setSize(width, height)

Sets the tilemap’s width and height, in number of tiles.

|      |                                                                                                      |
|------|------------------------------------------------------------------------------------------------------|
| Note | The tilemap’s width can also be configured in a call to [:setTiles()](#m-graphics.tilemap.setTiles). |

playdate.graphics.tilemap:getSize()

Returns the size of the tilemap, in tiles, as a pair, (*width*, *height*).

##### Setting tile values

playdate.graphics.tilemap:setTiles(data, width)

Sets the tilemap’s width to *width*, then populates the tilemap with *data*, which should be a flat, one-dimensional array-like table containing index values to the [tilemap’s imagetable](#m-graphics.tilemap.setImageTable).

|     |                                                                                                                           |
|-----|---------------------------------------------------------------------------------------------------------------------------|
| Tip | This function is especially useful for configuring a large number of tiles at once — say when first loading a game level. |

playdate.graphics.tilemap:getTiles()

Returns *data*, *width*  
*data* is a flat, one-dimensional array-like table containing index values to the [tilemap’s imagetable](#m-graphics.tilemap.setImageTable).  
*width* is the width of the tilemap, in number of tiles.

playdate.graphics.tilemap:setTileAtPosition(x, y, index)

Sets the index of the tile at tilemap position (*x*, *y*). *index* is the (1-based) index of the image in the tilemap’s [playdate.graphics.imagetable](#C-graphics.imagetable).

|     |                                                                                                                                             |
|-----|---------------------------------------------------------------------------------------------------------------------------------------------|
| Tip | This function is especially useful for making small adjustments to existing tilemaps — say, if the state of a tile changes during gameplay. |

|           |                                                                                                                                                                             |
|-----------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Important | Tilemaps and imagetables, like Lua arrays, are 1-based, not 0-based. `tilemap:setTileAtPosition(1, 1, 2)` will set the index of the tile in the top-leftmost position to 2. |

playdate.graphics.tilemap:getTileAtPosition(x, y)

Returns the image index of the tile at the given *x* and *y* coordinate. If *x* or *y* is out of bounds, returns nil.

|           |                                                                                                                                                        |
|-----------|--------------------------------------------------------------------------------------------------------------------------------------------------------|
| Important | Tilemaps and imagetables, like Lua arrays, are 1-based, not 0-based. `tilemap:getTileAtPosition(1, 1)` will return the index of the top-leftmost tile. |

##### Drawing

playdate.graphics.tilemap:draw(x, y, \[sourceRect\])

Draws the tilemap at screen coordinate (*x*, *y*).

*sourceRect*, if specified, will cause only the part of the tilemap within sourceRect to be drawn. *sourceRect* should be relative to the tilemap’s bounds and can be a [playdate.geometry.rect](#C-geometry.rect) or four integers, (*x*, *y*, *w*, *h*), representing the rect.

playdate.graphics.tilemap:drawIgnoringOffset(x, y, \[sourceRect\])

Draws the tilemap ignoring the currently set [`drawOffset`](#f-graphics.setDrawOffset).

##### Collisions

playdate.graphics.tilemap:getCollisionRects(emptyIDs)

This function returns an array of [playdate.geometry.rect](#C-geometry.rect) objects that describe the areas of the tilemap that should trigger collisions. You can also think of them as the "impassable" rects of your tilemap. These rects will be in tilemap coordinates, not pixel coordinates.

*emptyIDs* is an array that contains the tile IDs of "empty" (or "passable") tiles in the tilemap — in other words, tile IDs that should not trigger a collision. Tiles with default IDs of 0 are treated as empty by default, so you do not need to include 0 in the array.

For example, if you have a tilemap describing terrain, where tile ID 1 represents grass the player can walk over, and tile ID 2 represents mountains that the player can’t cross, you’d pass an array containing just the value 1. You’ll get a back an array of a minimal number of rects describing the areas where there are mountain tiles.

You can then pass each of those rects into [playdate.graphics.sprite.addEmptyCollisionSprite()](#f-graphics.sprite.addEmptyCollisionSprite) to add an empty (invisible) sprite into the scene for the built-in collision detection methods. In this example, collide rects would be added around mountain tiles but not grass tiles.

Alternatively, instead of calling getCollisionRects() at all, you can use the convenience function [playdate.graphics.sprite.addWallSprites()](#f-graphics.sprite.addWallSprites), which is effectively a shortcut for calling getCollisionRects() and passing all the resulting rects to [addEmptyCollisionSprite()](#f-graphics.sprite.addEmptyCollisionSprite).

##### Other tilemap functions

playdate.graphics.tilemap:getPixelSize()

Returns the size of the tilemap in pixels; that is, the size of the image multiplied by the number of rows and columns in the map. Returns multiple values (*width*, *height*).

The tilemap size in pixels is determined by the tile size of the [imagetable](#m-graphics.tilemap.setImageTable) it is referencing, and the width of the tilemap set via [:setTiles()](#m-graphics.tilemap.setTiles) or [:setSize()](#m-graphics.tilemap.setSize). It is not otherwise configurable.

playdate.graphics.tilemap:getTileSize()

Returns two values (*width*, *height*), the pixel width and height of an individual tile.

These values are determined by the tile size of the associated [imagetable](#m-graphics.tilemap.setImageTable) and are not otherwise configurable.

#### Sprite

Sprites are graphic objects that can be used to represent moving entities in your games, like the player, or the enemies that chase after your player. Sprites animate efficiently, and offer collision detection and a host of other built-in functionality. (If you want to create an environment for your sprites to move around in, consider using [tilemaps](#C-graphics.tilemap) or [drawing a background image](#f-graphics.sprite.setBackgroundDrawingCallback).)

|      |                                                                                                                                        |
|------|----------------------------------------------------------------------------------------------------------------------------------------|
| Note | To have access to all the sprite functionality described below, be sure to `import "CoreLibs/sprites"` at the top of your source file. |

The simplest way to create a sprite is using `sprite.new(`*`image`*`)`:

Creating a standalone sprite

```lua
import "CoreLibs/sprites"

local image = playdate.graphics.image.new("coin")
local sprite = playdate.graphics.sprite.new(image)
sprite:moveTo(100, 100)
sprite:add()
```

If you want to use an object-oriented approach, you can also subclass sprites and create instance of those subclasses.

Creating a sprite subclass

```lua
import "CoreLibs/sprites"

class('MySprite').extends(playdate.graphics.sprite)

local sprite = MySprite()
local image = playdate.graphics.image.new("coin")
sprite:setImage(image)
sprite:moveTo(100, 100)
sprite:add()
```

Or with a custom initializer:

Creating a sprite subclass with a custom initializer

```lua
import "CoreLibs/sprites"

class('MySprite').extends(playdate.graphics.sprite)

local image = playdate.graphics.image.new("coin")

function MySprite:init(x, y)
    MySprite.super.init(self) -- this is critical
    self:setImage(image)
    self:moveTo(x, y)
end

local sprite = MySprite(100, 100)
sprite:add()
```

##### Sprite Basics

playdate.graphics.sprite.new(\[image_or_tilemap\])

This class method (note the "." syntax rather than ":") returns a new sprite object. A previously-loaded [image](#C-graphics.image) or [tilemap](#C-graphics.tilemap) object can be optionally passed-in.

|           |                                                                                                                                     |
|-----------|-------------------------------------------------------------------------------------------------------------------------------------|
| Important | To see your sprite onscreen, you will need to call [`:add()`](#m-graphics.sprite.add) on your sprite to add it to the display list. |

playdate.graphics.sprite.spriteWithText(text, maxWidth, maxHeight, \[backgroundColor, \[leadingAdjustment, \[truncationString, \[alignment, \[font\]\]\]\]\])

|           |                                                          |
|-----------|----------------------------------------------------------|
| Important | You must import *CoreLibs/sprites* to use this function. |

A conveneince function that creates a sprite with an image of *`text`*, as generated by [imageWithText()](#f-graphics.imageWithText).

The arguments are the same as those in [imageWithText()](#f-graphics.imageWithText).

Returns *`sprite`*, *`textWasTruncated`*

*`sprite`* is a newly-created [sprite](#C-graphics.sprite) with its image set to an image of the text specified. The sprite’s dimensions may be smaller than *`maxWidth`*, *`maxHeight`*.

*`textWasTruncated`* indicates if the text was truncated to fit within the specified width and height.

playdate.graphics.sprite.update()

This class method (note the "." syntax rather than ":") calls the [update()](#c-graphics.sprite.update) function on every sprite in the global sprite list and redraws all of the dirty rects.

|           |                                                                                                                                                                                                                                                                  |
|-----------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Important | You will generally want to call `playdate.graphics.sprite.update()` once in your [`playdate.update()`](#c-update) method, to ensure that your sprites are updated and drawn during every frame. Failure to do so may mean your sprites will not appear onscreen. |

|         |                                                                                                                                                                                 |
|---------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Caution | Be careful not confuse `sprite.update()` with [`sprite:update()`](#c-graphics.sprite.update): the former updates all sprites; the latter updates just the sprite being invoked. |

playdate.graphics.sprite:setImage(image, \[flip, \[scale, \[yscale\]\]\])

Sets the sprite’s image to `image`, which should be an instance of [playdate.graphics.image](#C-graphics.image). The .flip\_ argument is optional; see [playdate.graphics.image:draw()](#m-graphics.imgDraw) for valid values. Optional scale arguments are also accepted. Unless disabled with [playdate.graphics.sprite:setRedrawOnImageChange()](#m-graphics.sprite.setRedrawsOnImageChange), the sprite is automatically marked for redraw if the image isn’t the previous image.

playdate.graphics.sprite:getImage()

Returns the playdate.graphics.image object that was set with setImage().

playdate.graphics.sprite:add()

Adds the given sprite to the display list, so that it is drawn in the current scene.

playdate.graphics.sprite.addSprite(sprite)

Adds the given sprite to the display list, so that it is drawn in the current scene. Note that this is called with a period `.` instead of a colon `:`.

playdate.graphics.sprite:remove()

Removes the given sprite from the display list.

playdate.graphics.sprite.removeSprite(sprite)

Removes the given sprite from the display list. As with `add()`/`addSprite()`, note that this is called with a period `.` instead of a colon `:`.

playdate.graphics.sprite:moveTo(x, y)

Moves the sprite and resets the bounds based on the image dimensions and center.

playdate.graphics.sprite:getPosition()

Returns the sprite’s current x, y position as multiple values (*x*, *y*).

playdate.graphics.sprite.x

Can be used to directly read your sprite’s x position.

playdate.graphics.sprite.y

Can be used to directly read your sprite’s y position.

|         |                                                                                             |
|---------|---------------------------------------------------------------------------------------------|
| Caution | Do not set these properties directly. Use [`:moveTo()`](#m-graphics.sprite.moveTo) instead. |

playdate.graphics.sprite:moveBy(x, y)

Moves the sprite by *x*, *y* pixels relative to its current position.

playdate.graphics.sprite:setZIndex(z)

Sets the Z-index of the given sprite. Sprites with higher Z-indexes are drawn on top of those with lower Z-indexes. Valid values for *z* are in the range (-32768, 32767).

playdate.graphics.sprite:getZIndex()

Returns the Z-index of the given sprite.

playdate.graphics.sprite:setVisible(flag)

Sprites that aren’t visible don’t get their [draw()](#c-graphics.sprite.draw) method called.

playdate.graphics.sprite:isVisible()

Returns a boolean value, true if the sprite is visible.

playdate.graphics.sprite:setCenter(x, y)

Sets the sprite’s drawing center as a fraction (ranging from 0.0 to 1.0) of the height and width. Default is 0.5, 0.5 (the center of the sprite). This means that when you call [:moveTo(x, y)](#m-graphics.sprite.moveTo), the center of your sprite will be positioned at *x*, *y*. If you want x and y to represent the upper left corner of your sprite, specify the center as 0, 0.

playdate.graphics.sprite:getCenter()

Returns multiple values (`x, y`) representing the sprite’s drawing center as a fraction (ranging from 0.0 to 1.0) of the height and width.

playdate.graphics.sprite:getCenterPoint()

Returns a [playdate.geometry.point](#C-geometry.point) representing the sprite’s drawing center as a fraction (ranging from 0.0 to 1.0) of the height and width.

playdate.graphics.sprite:setSize(width, height)

Sets the sprite’s size. The method has no effect if the sprite has an image set.

playdate.graphics.sprite:getSize()

Returns multiple values *(width, height)*, the current size of the sprite.

playdate.graphics.sprite.width

Can be used to directly read your sprite’s width.

playdate.graphics.sprite.height

Can be used to directly read your sprite’s height.

|         |                                                                                               |
|---------|-----------------------------------------------------------------------------------------------|
| Caution | Do not set these properties directly. Use [`:setSize()`](#m-graphics.sprite.setSize) instead. |

playdate.graphics.sprite:setScale(scale, \[yScale\])

Sets the scaling factor for the sprite, with an optional separate scaling for the y axis. If setImage() is called after this, the scale factor is applied to the new image. Only affects sprites that have an image set.

playdate.graphics.sprite:getScale()

Returns multiple values *(xScale, yScale)*, the current scaling of the sprite.

playdate.graphics.sprite:setRotation(angle, \[scale, \[yScale\]\])

Sets the rotation for the sprite, in degrees clockwise, with an optional scaling factor. If setImage() is called after this, the rotation and scale is applied to the new image. Only affects sprites that have an image set. This function should be used with discretion, as it’s likely to be slow on the hardware. Consider pre-rendering rotated images for your sprites instead.

playdate.graphics.sprite:getRotation()

Returns the current rotation of the sprite.

playdate.graphics.sprite:copy()

Returns a copy of the caller.

playdate.graphics.sprite:setUpdatesEnabled(flag)

The sprite’s *updatesEnabled* flag (defaults to true) determines whether a sprite’s [update()](#c-graphics.sprite.update) method will be called. By default, a sprite’s `update` method does nothing; however, you may choose to have your sprite do something on every frame by implementing an update method on your sprite instance, or implementing it in your sprite subclass.

playdate.graphics.sprite:updatesEnabled()

Returns a boolean value, true if updates are enabled on the sprite.

playdate.graphics.sprite:setTag(tag)

Sets the sprite’s tag, an integer value in the range of 0 to 255, useful for identifying sprites later, particularly when working with collisions.

playdate.graphics.sprite:getTag()

Returns the sprite’s tag, an integer value.

playdate.graphics.sprite:setImageDrawMode(mode)

Sets the mode for drawing the bitmap. See [playdate.graphics.setImageDrawMode(mode)](#f-graphics.setImageDrawMode) for valid modes.

playdate.graphics.sprite:setImageFlip(flip, \[flipCollideRect\])

Flips the bitmap. See [playdate.graphics.image:draw()](#m-graphics.imgDraw) for valid `flip` values.

If `true` is passed for the optional *flipCollideRect* argument, the sprite’s collideRect will be flipped as well.

Calling setImage() will reset the sprite to its default, non-flipped orientation. So, if you call both setImage() and setImageFlip(), call setImage() first.

playdate.graphics.sprite:getImageFlip()

Returns one of the values listed at [playdate.graphics.image:draw()](#m-graphics.imgDraw).

playdate.graphics.sprite:setIgnoresDrawOffset(flag)

When set to *true*, the sprite will draw in screen coordinates, ignoring the currently-set [*drawOffset*](#f-graphics.setDrawOffset).

This only affects drawing, and should not be used on sprites being used for collisions, which will still happen in world-space.

playdate.graphics.sprite:setBounds(upper-left-x, upper-left-y, width, height)

`setBounds()` positions and sizes the sprite, used for drawing and for calculating dirty rects. *upper-left-x* and *upper-left-y* are relative to the overall display coordinate system. (If an image is attached to the sprite, the size will be defined by that image, and not by the *width* and *height* parameters passed in to `setBounds()`.)

|      |                                                                                                                                                                                                                                                                                                                                                                          |
|------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Note | In `setBounds()`, *x* and *y* always correspond to the upper left corner of the sprite, regardless of how a [sprite’s center](#m-graphics.sprite.setCenter) is defined. This makes it different from [sprite:moveTo()](#m-graphics.sprite.moveTo), where *x* and *y* honor the sprite’s defined center (by default, at a point 50% along the sprite’s width and height.) |

playdate.graphics.sprite:setBounds(rect)

`setBounds(rect)` sets the bounds of the sprite with a [`playdate.geometry.rect`](#C-geometry.rect) object.

playdate.graphics.sprite:getBounds()

`getBounds()` returns multiple values (*x*, *y*, *width*, *height*).

playdate.graphics.sprite:getBoundsRect()

`getBoundsRect()` returns the sprite bounds as a [`playdate.geometry.rect`](#C-geometry.rect) object.

playdate.graphics.sprite:setOpaque(flag)

Marking a sprite opaque tells the sprite system that it doesn’t need to draw anything underneath the sprite, since it will be overdrawn anyway. If you set an image without a mask/alpha channel on the sprite, it automatically sets the opaque flag.

Setting a sprite to opaque can have performance benefits.

playdate.graphics.sprite:isOpaque()

Returns the sprite’s current opaque flag.

##### Drawing images alongside sprites

playdate.graphics.sprite.setBackgroundDrawingCallback(drawCallback)

|           |                                                          |
|-----------|----------------------------------------------------------|
| Important | You must import *CoreLibs/sprites* to use this function. |

A convenience function for drawing a background image behind your sprites.

*drawCallback* is a routine you specify that implements your background drawing. The callback should be a function taking the arguments `x, y, width, height`, where *x, y, width, height* specify the region (in screen coordinates, not world coordinates) of the background region that needs to be updated.

|      |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
|------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Note | Some implementation details: `setBackgroundDrawingCallback()` creates a screen-sized sprite with a z-index set to the lowest possible value so it will draw behind other sprites, and adds the sprite to the display list so that it is drawn in the current scene. The background sprite ignores the [drawOffset](#f-graphics.setDrawOffset), and will not be automatically redrawn when the draw offset changes; use [playdate.graphics.sprite.redrawBackground()](#f-graphics.sprite.redrawBackground) if necessary in this case. *drawCallback* will be called from the newly-created background sprite’s [playdate.graphics.sprite:draw()](#c-graphics.sprite.draw) callback function and is where you should do your background drawing. This function returns the newly created [playdate.graphics.sprite](#C-graphics.sprite). |

For additional background, here is the implementation of `setBackgroundDrawingCallback()` in the Playdate SDK. (This does *not* reflect how you should use `setBackgroundDrawingCallback()` in your game. For an example of game usage, see [A Basic Playdate Game in Lua](#basic-playdate-game).)

```lua
function playdate.graphics.sprite.setBackgroundDrawingCallback(drawCallback)
        local bgsprite = gfx.sprite.new()
        bgsprite:setSize(playdate.display.getSize())
        bgsprite:setCenter(0, 0)
        bgsprite:moveTo(0, 0)
        bgsprite:setZIndex(-32768)
        bgsprite:setIgnoresDrawOffset(true)
        bgsprite:setUpdatesEnabled(false)
        bgsprite.draw = function(s, x, y, w, h)
                drawCallback(x, y, w, h)
        end
        bgsprite:add()
        return bgsprite
end
```

playdate.graphics.sprite.redrawBackground()

|           |                                                          |
|-----------|----------------------------------------------------------|
| Important | You must import *CoreLibs/sprites* to use this function. |

Marks the background sprite dirty, forcing the drawing callback to be run when [playdate.graphics.sprite.update()](#f-graphics.sprite.update) is called.

playdate.graphics.sprite:setTilemap(tilemap)

Sets the sprite’s contents to the given [tilemap](#C-graphics.tilemap). Useful if you want to automate drawing of your tilemap, especially if interleaved by depth with other sprites being drawn.

##### Automatically animating sprites

While it is customary to move sprites around onscreen by calling `sprite:moveTo(x, y)` on successive `playdate.update()` calls, it is possible to automate animation behavior with the use of [animators](#C-graphics.animator).

playdate.graphics.sprite:setAnimator(animator, \[moveWithCollisions, \[removeOnCollision\]\])

|           |                                                                     |
|-----------|---------------------------------------------------------------------|
| Important | You must import *CoreLibs/sprites* to use the `setAnimator` method. |

`setAnimator` assigns an [playdate.graphics.animator](#C-graphics.animator) to the sprite, which will cause the sprite to automatically update its position each frame while the animator is active.

*animator* should be a [playdate.graphics.animator](#C-graphics.animator) created using [playdate.geometry.point](#C-geometry.point)s for its start and end values.

*movesWithCollisions*, if provided and true will cause the sprite to move with collisions. A collision rect must be set on the sprite prior to passing true for this argument.

*removeOnCollision*, if provided and true will cause the animator to be removed from the sprite when a collision occurs.

|      |                                                                                                |
|------|------------------------------------------------------------------------------------------------|
| Note | `setAnimator` should be called only after any custom update method has been set on the sprite. |

playdate.graphics.sprite:removeAnimator()

Removes a [playdate.graphics.animator](#C-graphics.animator) assigned to the sprite

Example: Setting an animator on a sprite

```lua
-- You can copy and paste this example directly as your main.lua file to see it in action
import "CoreLibs/animator"
import "CoreLibs/sprites"

-- We'll be demonstrating how to use an animator to animate a sprite
local square = playdate.graphics.image.new(20, 20, playdate.graphics.kColorBlack)
local squareSprite = playdate.graphics.sprite.new(square)
squareSprite:add()

-- 4000ms, or 4 seconds
local animationDuration = 4000
-- We're animating in a rectangle, around the screen. The animator must be animating along some geometry
-- or between two points if used on a sprite - just animating between two values will result in an error
local polygon = playdate.geometry.polygon.new(20, 20, 380, 20, 380, 220, 20, 220, 20, 20)
-- Setting an easing function to get a nice, smooth movement
local easingFunction = playdate.easingFunctions.inOutCubic
local animator = playdate.graphics.animator.new(animationDuration, polygon, easingFunction)

-- Setting the animator on the sprite to move it
squareSprite:setAnimator(animator)

function playdate.update()
    -- Everything is handled automatically, provided you call the sprite update function
    playdate.graphics.sprite.update()

    -- Set to and stays true on animation end - will print continuously when the animation finishes
    if animator:ended() then
        print("Animation ended!")
    end
end
```

##### Clipping

playdate.graphics.sprite:setClipRect(x, y, width, height)  
playdate.graphics.sprite:setClipRect(rect)

Sets the clipping rectangle for the sprite, using separate parameters or a [`playdate.geometry.rect`](#C-geometry.rect) object. Only areas within the rect will be drawn.

playdate.graphics.sprite:clearClipRect()

Clears the sprite’s current clipping rectangle.

playdate.graphics.sprite.setClipRectsInRange(x, y, width, height, startz, endz)  
playdate.graphics.sprite.setClipRectsInRange(rect, startz, endz)

Sets the clip rect for sprites in the given z-index range.

playdate.graphics.sprite.clearClipRectsInRange(startz, endz)

Clears sprite clip rects in the given z-index range.

playdate.graphics.sprite:setStencilImage(stencil, \[tile\])

Specifies a stencil image to be set before the sprite is drawn. As with [playdate.graphics.setStencilImage()](#f-graphics.setStencilImage), the sprite pixels will be drawn where the stencil is white and nothing drawn where the stencil is black. Note that the stencil is attached to the frame buffer (i.e., the screen), not the sprite—it does not move along with the sprite. If *tile* is set, the stencil will be tiled; in this case, the image width must be a multiple of 32 pixels.

playdate.graphics.setStencilPattern({ row1, row2, row3, row4, row5, row6, row7, row8 })

Sets the sprite’s stencil to the given pattern, tiled across the screen.

playdate.graphics.setStencilPattern(pattern)

Sets the sprite’s stencil to the given pattern, tiled across the screen. `pattern` should be a table of the form `{ row1, row2, row3, row4, row5, row6, row7, row8 }`.

playdate.graphics.sprite:setStencilPattern(level, \[ditherType\])

Sets the sprite’s stencil to a dither pattern specified by *level* and optional *ditherType* (defaults to `playdate.graphics.image.kDitherTypeBayer8x8`).

playdate.graphics.sprite:clearStencil()

Clears the sprite’s stencil.

##### Drawing

playdate.graphics.sprite.setAlwaysRedraw(flag)

If set to true, causes all sprites to draw each frame, whether or not they have been marked dirty. This may speed up the performance of your game if the system’s dirty rect tracking is taking up too much time - for example if there are many sprites moving around on screen at once.

playdate.graphics.sprite.getAlwaysRedraw()

Return’s the sprites "always redraw" flag.

playdate.graphics.sprite:markDirty()

Marks the rect defined by the sprite’s current bounds as needing a redraw.

playdate.graphics.sprite.addDirtyRect(x, y, width, height)

Marks the given rectangle (in screen coordinates) as needing a redraw. playdate.graphics drawing functions now call this automatically, adding their drawn areas to the sprite’s dirty list, so there’s likely no need to call this manually any more. This behavior may change in the future, though.

playdate.graphics.sprite:setRedrawsOnImageChange(flag)

By default, sprites are automatically marked for redraw when their image is changed via [playdate.graphics.sprite:setImage()](#m-graphics.sprite.setImage). If disabled by calling this function with a *false* argument, [playdate.graphics.sprite.addDirtyRect()](#m-graphics.sprite.addDirtyRect) can be used to mark the (potentially smaller) area of the screen that needs to be redrawn.

##### Group operations

playdate.graphics.sprite.getAllSprites()

Returns an array of all sprites in the display list.

playdate.graphics.sprite.performOnAllSprites(f)

|           |                                                          |
|-----------|----------------------------------------------------------|
| Important | You must import *CoreLibs/sprites* to use this function. |

Performs the function *f* on all sprites in the display list. *f* should take one argument, which will be a sprite.

playdate.graphics.sprite.spriteCount()

Returns the number of sprites in the display list.

playdate.graphics.sprite.removeAll()

Removes all sprites from the global sprite list.

playdate.graphics.sprite.removeSprites(spriteArray)

Removes all sprites in `spriteArray` from the global sprite list.

##### Sprite callbacks

playdate.graphics.sprite:draw(x, y, width, height)

If the sprite doesn’t have an image, the sprite’s draw function is called as needed to update the display. The rect passed in is the current dirty rect being updated by the display list. The rect coordinates passed in are relative to the sprite itself (i.e. x = 0, y = 0 refers to the top left corner of the sprite). Note that the callback is only called when the sprite is on screen and has a size specified via [sprite:setSize()](#m-graphics.sprite.setSize) or [sprite:setBounds()](#m-graphics.sprite.setBounds).

Example: Overriding the sprite draw method

```lua
-- You can copy and paste this example directly as your main.lua file to see it in action
import "CoreLibs/graphics"
import "CoreLibs/sprites"

local mySprite = playdate.graphics.sprite.new()
mySprite:moveTo(200, 120)
-- You MUST set a size first for anything to show up (either directly or by setting an image)
mySprite:setSize(30, 30)
mySprite:add()

-- The x, y, width, and height arguments refer to the dirty rect being updated, NOT the sprite dimensions
function mySprite:draw(x, y, width, height)
    -- Custom draw methods gives you more flexibility over what's drawn, but with the added benefits of sprites

    -- Here we're just modulating the circle radius over time
    local spriteWidth, spriteHeight = self:getSize()
    if not self.radius or self.radius > spriteWidth then
        self.radius = 0
    end
    self.radius += 1

    -- Drawing coordinates are relative to the sprite (e.g. (0, 0) is the top left of the sprite)
    playdate.graphics.fillCircleAtPoint(spriteWidth / 2, spriteHeight / 2, self.radius)
end

function playdate.update()
    -- Your custom draw method gets called here, but only if the sprite is dirty
    playdate.graphics.sprite.update()

    -- You might need to manually mark it dirty
    mySprite:markDirty()
end
```

playdate.graphics.sprite:update()

Called by [playdate.graphics.sprite.update()](#f-graphics.sprite.update) (note the syntactic difference between the period and the colon) before sprites are drawn. Implementing `:update()` gives you the opportunity to perform some code upon every frame.

|      |                                                                                                                                                                                     |
|------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Note | The update method will only be called on sprites that have had [add()](#m-graphics.sprite.add) called on them, and have their [updates enabled](#m-graphics.sprite.updatesEnabled). |

|         |                                                                                                                                                                                 |
|---------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Caution | Be careful not confuse `sprite:update()` with [`sprite.update()`](#f-graphics.sprite.update): the latter updates all sprites; the former updates just the sprite being invoked. |

Example: Overriding the sprite update method

```lua
local mySprite = playdate.graphics.sprite.new()
mySprite:moveTo(200, 120)
mySprite:add() -- Sprite needs to be added to get drawn and updated
-- mySprite:remove() will make it so the sprite stops getting drawn/updated

-- Option 1: override the update method using an anonymous function
mySprite.update = function(self)
    print("This gets called every frame when I'm added to the display list")
    -- Manipulate sprite using "self"
    print(self.x) -- Prints 200.0
    print(self.y) -- Prints 120.0
end

-- Option 2: override the update method using a function stored in a variable
local function mySpriteUpdate(self)
    print("This gets called every frame when I'm added to the display list")
    -- Manipulate sprite using "self"
    print(self.x) -- Prints 200.0
    print(self.y) -- Prints 120.0
end
mySprite.update = mySpriteUpdate

-- Option 3: override the update method by directly defining it
function mySprite:update()
    print("This gets called every frame when I'm added to the display list")
    -- Manipulate sprite using "self"
    print(self.x) -- Prints 200.0
    print(self.y) -- Prints 120.0
end

function playdate.update()
    -- Your custom update method gets called here every frame if the sprite has been added
    playdate.graphics.sprite.update()
end

-- VERY simplified psuedocode explanation of what's happening in sprite.update() (not real code)
local displayList = {} -- Added sprites are kept track of in a list
function playdate.graphics.sprite.update()
    -- The display list is iterated over
    for i=1, #displayList do
        local sprite = displayList[i]
        -- Checks if updates on the sprites are enabled
        if sprite:updatesEnabled() then
            -- The sprite update method is called
            sprite:update()
        end
        ...
        -- Redraw all of the dirty rects, handle collisions, etc.
    end
end
```

##### Sprite collision detection

The following functions are based on the [bump.lua collision detection library](https://github.com/kikito/bump.lua). Some things to note:

- To participate in collisions, a sprite must have its [*collideRect*](#m-graphics.sprite.setCollideRect) set.

- Only handles axis-aligned bounding box (AABB) collisions.

- Handles tunneling — all items are treated as "bullets". The fact that we only use AABBs makes this fast.

- Centered on detection, but also offers some (minimal & basic) collision response.

Ideal for:

- Tile-based games, and games where most entities can be represented as axis-aligned rectangles.

- Games which require some physics but not a full realistic simulation, like a platformer.

- Examples of appropriate genres: top-down games (Zelda), shoot 'em ups, fighting games (Street Fighter), platformers (Super Mario).

Not a good match for:

- Games that require polygons for collision detection.

- Games that require highly realistic simulations of physics - things stacking up, rolling over slides, etc.

- Games that require very fast objects colliding realistically against each other (sprites here are moved and collided one at a time).

- Simulations where the order in which the collisions are resolved isn’t known.

###### Basic collision checking

playdate.graphics.sprite:setCollideRect(x, y, width, height)  
playdate.graphics.sprite:setCollideRect(rect)

`setCollideRect()` marks the area of the sprite, relative to its own internal coordinate system, to be checked for collisions with other sprites' collide rects. Note that the coordinate space is relative to the top-left corner of the bounds, regardless of where the sprite’s [center/anchor](#m-graphics.sprite.setCenter) is located.

|     |                                                                                                                                                         |
|-----|---------------------------------------------------------------------------------------------------------------------------------------------------------|
| Tip | If you want to set the sprite’s collide rect to be the same size as the sprite itself, you can write `sprite:setCollideRect( 0, 0, sprite:getSize() )`. |

|           |                                                                                                 |
|-----------|-------------------------------------------------------------------------------------------------|
| Important | `setCollideRect()` must be invoked on a sprite in order to get it to participate in collisions. |

|           |                                                                                                                                          |
|-----------|------------------------------------------------------------------------------------------------------------------------------------------|
| Important | Very large sprites with very large collide rects should be avoided, as they will have a negative impact on performance and memory usage. |

playdate.graphics.sprite:getCollideRect()

Returns the sprite’s collide rect set with [`setCollideRect()`](#m-graphics.sprite.setCollideRect). Return value is a [`playdate.geometry.rect`](#C-geometry.rect).

|           |                                                                                                                       |
|-----------|-----------------------------------------------------------------------------------------------------------------------|
| Important | This function return coordinates relative to the sprite itself; the sprite’s position has no bearing on these values. |

playdate.graphics.sprite:getCollideBounds()

Returns the sprite’s collide rect as multiple values, (*x*, *y*, *width*, *height*).

|           |                                                                                                                       |
|-----------|-----------------------------------------------------------------------------------------------------------------------|
| Important | This function return coordinates relative to the sprite itself; the sprite’s position has no bearing on these values. |

playdate.graphics.sprite:clearCollideRect()

Clears the sprite’s collide rect set with [`setCollideRect()`](#m-graphics.sprite.setCollideRect).

playdate.graphics.sprite:overlappingSprites()

Returns an array of sprites that have collide rects that are currently overlapping the calling sprite’s collide rect, taking the sprites' groups and collides-with masks into consideration.

playdate.graphics.sprite.allOverlappingSprites()

Returns an array of array-style tables, each containing two sprites that have overlapping collide rects. All sprite pairs that are have overlapping collide rects (taking the sprites' group and collides-with masks into consideration) are returned.

An example of iterating over the collisions array:

```lua
local collisions = gfx.sprite.allOverlappingSprites()

for i = 1, #collisions do
        local collisionPair = collisions[i]
        local sprite1 = collisionPair[1]
        local sprite2 = collisionPair[2]
        -- do something with the colliding sprites
end
```

playdate.graphics.sprite:alphaCollision(anotherSprite)

Returns a boolean value set to true if a pixel-by-pixel comparison of the sprite images shows that non-transparent pixels are overlapping, based on the current bounds of the sprites.

This method may be used in conjunction with the standard collision architecture. Say, if [`overlappingSprites()`](#m-graphics.sprite.overlappingSprites) or [`moveWithCollisions()`](#m-graphics.sprite.moveWithCollisions) report a collision of two sprite’s bounding rects, alphaCollision() could then be used to discern if a pixel-level collision occurred.

playdate.graphics.sprite:setCollisionsEnabled(flag)

The sprite’s *collisionsEnabled* flag (defaults to true) can be set to `false` in order to temporarily keep a sprite from colliding with any other sprite.

playdate.graphics.sprite:collisionsEnabled()

Returns the sprite’s *collisionsEnabled* flag.

###### Restricting collisions

Collisions can be restricted using one of two methods: setting **collision groups**, or setting **group masks**. Groups are in fact just a simplified API for configuring group masks; they both operate on the same underlying architecture.

###### Collision groups

playdate.graphics.sprite:setGroups(groups)

Adds the sprite to one or more collision groups. A group is a collection of sprites that exhibit similar collision behavior. (An example: in Atari’s *Asteroids*, asteroid sprites would all be added to the same group, while the player’s spaceship might be in a different group.) Use [`setCollidesWithGroups()`](#m-graphics.sprite.setCollidesWithGroups) to define which groups a sprite should collide with.

There are 32 groups, each defined by the integer 1 through 32. To add a sprite to only groups 1 and 3, for example, call `mySprite:setGroups({1, 3})`.

Alternatively, use [`setGroupMask()`](#m-graphics.sprite.setGroupMask) to set group membership via a bitmask.

playdate.graphics.sprite:setCollidesWithGroups(groups)

Pass in a group number or an array of group numbers to specify which groups this sprite can collide with. Groups are numbered 1 through 32. Use [`setGroups()`](#m-graphics.sprite.setGroups) to specify which groups a sprite belongs to.

Alternatively, you can specify group collision behavior with a bitmask by using [`setCollidesWithGroupsMask()`](#m-graphics.sprite.setCollidesWithGroupsMask).

###### Group masks

Sprites may be assigned to groups and define which groups they collide with as a method of filtering collisions. These groups are represented by two bitmasks on the sprites: a group bitmask, and a collides-with-groups bitmask. If sprite A’s collides-with-groups bitmask overlaps sprite B’s groups (a bitwise AND of the masks is not zero), or if no groups have been set (both masks are set to 0x00000000), a collision will happen when moving sprite A through sprite B. Convenience functions [`setGroups()`](#m-graphics.sprite.setGroups) and [`setCollidesWithGroups()`](#m-graphics.sprite.setCollidesWithGroups) exist to avoid the need to deal with bitmasks directly.

playdate.graphics.sprite:setGroupMask(mask)

`setGroupMask()` sets the sprite’s group bitmask, which is 32 bits. In conjunction with the [`setCollidesWithGroupsMask()`](#m-graphics.sprite.setCollidesWithGroupsMask) method, this controls which sprites can collide with each other.

For large group mask numbers, pass the number as a hex value, eg. `0xFFFFFFFF` to work around limitations in Lua’s integer sizes.

playdate.graphics.sprite:getGroupMask()

`getGroupMask()` returns the integer value of the sprite’s group bitmask.

playdate.graphics.sprite:setCollidesWithGroupsMask(mask)

Sets the sprite’s collides-with-groups bitmask, which is 32 bits. The mask specifies which other sprite groups this sprite can collide with. Sprites only collide if the moving sprite’s *collidesWithGroupsMask* matches at least one group of a potential collision sprite (i.e. a bitwise AND (&) between the moving sprite’s *collidesWithGroupsMask* and a potential collision sprite’s *groupMask* != zero) or if the moving sprite’s *collidesWithGroupsMask* and the other sprite’s *groupMask* are both set to 0x00000000 (the default values).

For large mask numbers, pass the number as a hex value, eg. `0xFFFFFFFF` to work around limitations in Lua’s integer sizes.

playdate.graphics.sprite:getCollidesWithGroupsMask()

Returns the integer value of the sprite’s collision bitmask.

playdate.graphics.sprite:resetGroupMask()

Resets the sprite’s group mask to `0x00000000`.

playdate.graphics.sprite:resetCollidesWithGroupsMask()

Resets the sprite’s collides-with-groups mask to `0x00000000`.

###### Advanced Collisions

playdate.graphics.sprite:moveWithCollisions(goalX, goalY)  
playdate.graphics.sprite:moveWithCollisions(goalPoint)

Moves the sprite towards *goalX*, *goalY* or *goalPoint* taking collisions into account, which means the sprite’s final position may not be the same as *goalX*, *goalY* or *goalPoint*.

Returns *actualX*, *actualY*, *collisions*, *length*.

<table class="tableblock frame-all grid-all stretch">
<colgroup>
<col style="width: 20%" />
<col style="width: 80%" />
</colgroup>
<tbody>
<tr class="odd">
<td class="tableblock halign-right valign-top"><p><em>actualX</em>, <em>actualY</em></p></td>
<td class="tableblock halign-left valign-top"><p>the final position of the sprite. If no collisions occurred, this will be the same as <em>goalX</em>, <em>goalY</em>.</p></td>
</tr>
<tr class="even">
<td class="tableblock halign-right valign-top"><p><em>collisions</em></p></td>
<td class="tableblock halign-left valign-top"><p>an array of userdata objects containing information about all collisions that occurred. Each item in the array contains values for the following indices:</p>
<p>- <em>sprite</em>: The sprite being moved.</p>
<p>- <em>other</em>: The sprite colliding with the sprite being moved.</p>
<p>- <em>type</em>: The result of <a href="#c-graphics.sprite.collisionResponse"><em>collisionResponse</em></a>.</p>
<p>- <em>overlaps</em>: Boolean. True if the sprite was overlapping <em>other</em> when the collision started. False if it didn’t overlap but tunneled through <em>other</em>.</p>
<p>- <em>ti</em>: A number between 0 and 1 indicating how far along the movement to the goal the collision occurred.</p>
<p>- <em>move</em>: <a href="#C-geometry.vector2D">playdate.geometry.vector2D</a>. The difference between the original coordinates and the actual ones when the collision happened.</p>
<p>- <em>normal</em>: <a href="#C-geometry.vector2D">playdate.geometry.vector2D</a>. The collision normal; usually -1, 0, or 1 in <em>x</em> and <em>y</em>. Use this value to determine things like if your character is touching the ground.</p>
<p>- <em>touch</em>: <a href="#C-geometry.point">playdate.geometry.point</a>. The coordinates where the sprite started touching <em>other</em>.</p>
<p>- <em>spriteRect</em>: <a href="#C-geometry.rect">playdate.geometry.rect</a>. The rectangle the sprite occupied when the touch happened.</p>
<p>- <em>otherRect</em>: <a href="#C-geometry.rect">playdate.geometry.rect</a>. The rectangle <code>other</code> occupied when the touch happened.</p>
<p>If the collision type was <em>playdate.graphics.sprite.kCollisionTypeBounce</em> the table also contains <em>bounce</em>, a <a href="#C-geometry.point">playdate.geometry.point</a> indicating the coordinates to which the sprite attempted to bounce (could be different than <em>actualX</em>, <em>actualY</em> if further collisions occurred).</p>
<p>If the collision type was <em>playdate.graphics.sprite.kCollisionTypeSlide</em> the table also contains <em>slide</em>, a <a href="#C-geometry.point">playdate.geometry.point</a> indicating the coordinates to which the sprite attempted to slide.</p></td>
</tr>
<tr class="odd">
<td class="tableblock halign-right valign-top"><p><em>length</em></p></td>
<td class="tableblock halign-left valign-top"><p>the length of the collisions array, equal to <em>#collisions</em></p></td>
</tr>
</tbody>
</table>

Note that the collision info items are only valid until the next call of *moveWithCollisions* or *checkCollisions*. To save collision information for later, the data should be copied out of the collision info userdata object.

See also [`checkCollisions()`](#m-graphics.sprite.checkCollisions) to check for collisions without actually moving the sprite.

Example: Using moveWithCollisions for a simple player collision example

```lua
-- You can copy and paste this example directly as your main.lua file to see it in action
import "CoreLibs/graphics"
import "CoreLibs/sprites"

-- Creating a tags object, to keep track of tags more easily
TAGS = {
    player = 1,
    obstacle = 2,
    coin = 3,
    powerUp = 4
}

-- Creating a player sprite we can move around and collide things with
local playerImage = playdate.graphics.image.new(20, 20)
playdate.graphics.pushContext(playerImage)
    playdate.graphics.fillCircleInRect(0, 0, playerImage:getSize())
playdate.graphics.popContext()
local playerSprite = playdate.graphics.sprite.new(playerImage)
-- Setting a tag on the player, so we can check the tag to see if we're colliding against the player
playerSprite:setTag(TAGS.player)
playerSprite:moveTo(200, 120)
-- Remember to set a collision rect, or this all doesn't work!
playerSprite:setCollideRect(0, 0, playerSprite:getSize())
playerSprite:add()

-- Creating an obstacle sprite we can collide against
local obstacleImage = playdate.graphics.image.new(20, 20, playdate.graphics.kColorBlack)
local obstacleSprite = playdate.graphics.sprite.new(obstacleImage)
-- Setting a tag for the obstacle as well
obstacleSprite:setTag(TAGS.obstacle)
obstacleSprite:moveTo(300, 120)
-- Can't forget this!
obstacleSprite:setCollideRect(0, 0, obstacleSprite:getSize())
obstacleSprite:add()

function playdate.update()
    playdate.graphics.sprite.update()

    -- Some simple movement code for the sake of demonstration
    local moveSpeed = 3
    local goalX, goalY = playerSprite.x, playerSprite.y
    if playdate.buttonIsPressed(playdate.kButtonUp) then
        goalY -= moveSpeed
    elseif playdate.buttonIsPressed(playdate.kButtonDown) then
        goalY += moveSpeed
    elseif playdate.buttonIsPressed(playdate.kButtonLeft) then
        goalX -= moveSpeed
    elseif playdate.buttonIsPressed(playdate.kButtonRight) then
        goalX += moveSpeed
    end

    -- Remember to use :moveWithCollisions(), and not :moveTo() or :moveBy(), or collisions won't happen!
    -- To do a "moveBy" operation, sprite:moveBy(5, 5) == sprite:moveWithCollisions(sprite.x + 5, sprite.y + 5)
    local actualX, actualY, collisions, numberOfCollisions = playerSprite:moveWithCollisions(goalX, goalY)

    -- If we get into this loop, there was a collision
    for i=1, numberOfCollisions do
        -- This is getting data about one of things we're currently colliding with. Since we could
        -- be colliding with multiple things at once, we have to handle each collision individually
        local collision = collisions[i]

        -- Always prints 'true', as the sprite property is the sprite being moved (in this case, the player)
        print(collision.sprite == playerSprite)
        -- Also prints 'true', as we set the tag on the player sprite to the player tag
        print(collision.sprite:getTag() == TAGS.player)

        -- This gets the actual sprite object we're colliding with
        local collidedSprite = collision.other
        local collisionTag = collidedSprite:getTag()
        -- Since we set a tag on the obstacle, we can check if we're colliding with that
        if collisionTag == TAGS.obstacle then
            print("Collided with an obstacle!")

            -- We can use the collision normal to check which side we collided with
            local collisionNormal = collision.normal
            if collisionNormal.x == -1 then
                print("Touched left side!")
            elseif collisionNormal.x == 1 then
                print("Touched right side!")
            end

            if collisionNormal.y == -1 then
                print("Touched top!")
            elseif collisionNormal.y == 1 then
                print("Touched bottom!")
            end
        -- Handle some other collisions, like collecting a coin or a power up
        elseif collisionTag == TAGS.coin then
            print("Coin collected!")
        elseif collisionTag == TAGS.powerUp then
            print("Powered up!")
        end
    end
end
```

playdate.graphics.sprite:checkCollisions(x, y)  
playdate.graphics.sprite:checkCollisions(point)

Returns the same values as [`moveWithCollisions()`](#m-graphics.sprite.moveWithCollisions) but does not actually move the sprite.

playdate.graphics.sprite:collisionResponse(other)

A callback that can be defined on a sprite to control the type of collision response that should happen when a collision with *other* occurs. This callback should return one of the following four values:

- *playdate.graphics.sprite.kCollisionTypeSlide*: Use for collisions that should slide over other objects, like Super Mario does over a platform or the ground.

- *playdate.graphics.sprite.kCollisionTypeFreeze*: Use for collisions where the sprite should stop moving as soon as it collides with *other*, such as an arrow hitting a wall.

- *playdate.graphics.sprite.kCollisionTypeOverlap*: Use for collisions in which you want to know about the collision but it should not impact the movement of the sprite, such as when collecting a coin.

- *playdate.graphics.sprite.kCollisionTypeBounce*: Use when the sprite should move away from *other*, like the ball in Pong or Arkanoid.

The strings "slide", "freeze", "overlap", and "bounce" can be used instead of the constants.

Feel free to return different values based on the value of *other*. For example, if *other* is a wall sprite, you may want to return "slide" or "bounce", but if it’s a coin you might return "overlap".

If the callback is not present, or returns nil, *kCollisionTypeFreeze* is used.

|     |                                                                                                                                                                                                                                                           |
|-----|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Tip | Instead of defining a callback, the collisionResponse property of a sprite can be set directly to one of the four collision response types. This will be faster, as the lua function will not need to be called, but does not allow for dynamic behavior. |

This method should not attempt to modify the sprites in any way. While it might be tempting to deal with collisions here, doing so will have unexpected and undesirable results. Instead, this function should return one of the collision response values as quickly as possible. If sprites need to be modified as the result of a collision, do so elsewhere, such as by inspecting the list of collisions returned by [`moveWithCollisions()`](#m-graphics.sprite.moveWithCollisions).

playdate.graphics.sprite.querySpritesAtPoint(x, y)  
playdate.graphics.sprite.querySpritesAtPoint([p](#C-geometry.point))

Returns all sprites with collision rects containing the point.

playdate.graphics.sprite.querySpritesInRect(x, y, width, height)  
playdate.graphics.sprite.querySpritesInRect([rect](#C-geometry.rect))

Returns all sprites with collision rects overlapping the rect.

playdate.graphics.sprite.querySpritesAlongLine(x1, y1, x2, y2)  
playdate.graphics.sprite.querySpritesAlongLine([lineSegment](#C-geometry.lineSegment))

Returns all sprites with collision rects intersecting the line segment.

playdate.graphics.sprite.querySpriteInfoAlongLine(x1, y1, x2, y2)  
playdate.graphics.sprite.querySpriteInfoAlongLine([lineSegment](#C-geometry.lineSegment))

Similar to *querySpritesAlongLine()*, but instead of sprites returns an array of *collisionInfo* tables containing information about sprites intersecting the line segment, and *len*, which is the number of collisions found. If you don’t need this information, use *querySpritesAlongLine()* as it will be faster.

Each *collisionInfo* table contains:

- *sprite*: the sprite being intersected by the segment.

- *entryPoint*: a [`point`](#C-geometry.point) representing the coordinates of the first intersection between `sprite` and the line segment.

- *exitPoint*: a [`point`](#C-geometry.point) representing the coordinates of the second intersection between `sprite` and the line segment.

- *ti1* & *ti2*: numbers between 0 and 1 which indicate how far from the starting point of the line segment the collision happened; t1 for the entry point, t2 for the exit point. This can be useful for things like having a laser cause more damage if the impact is close.

##### Sprites in tilemap-based games

For tile-based games, the built-in tilemap library has a convenience function called [getCollisionRects()](#m-graphics.tilemap.getCollisionRects), which will generate from the tilemap an array of rectangles suitable for use with the collision system to define walls and other impassable regions.

playdate.graphics.sprite.addEmptyCollisionSprite(r)  
playdate.graphics.sprite.addEmptyCollisionSprite(x, y, w, h)

|           |                                                          |
|-----------|----------------------------------------------------------|
| Important | You must import *CoreLibs/sprites* to use this function. |

This convenience function adds an invisible sprite defined by the rectangle *x*, *y*, *w*, *h* (or the [playdate.geometry.rect](#C-geometry.rect) *r*) for the purpose of triggering collisions. This is useful for making areas impassable, triggering an event when a sprite enters a certain area, and so on.

playdate.graphics.sprite.addWallSprites(tilemap, emptyIDs, \[xOffset, yOffset\])

|           |                                                          |
|-----------|----------------------------------------------------------|
| Important | You must import *CoreLibs/sprites* to use this function. |

This convenience function automatically adds empty collision sprites necessary to restrict movement within a tilemap.

*tilemap* is a [playdate.graphics.tilemap](#C-graphics.tilemap).

*emptyIDs* is an array of tile IDs that should be considered "passable" — in other words, not walls. Tiles with default IDs of 0 are treated as passable by default, so you do not need to include 0 in the array.

*xOffset, yOffset* optionally indicate the distance the new sprites should be offset from (0,0).

Returns an array-style table of the newly created sprites.

Calling this function is effectively a shortcut for calling [playdate.graphics.tilemap:getCollisionRects()](#m-graphics.tilemap.getCollisionRects) and passing the resulting rects to [addEmptyCollisionSprite()](#f-graphics.sprite.addEmptyCollisionSprite).

#### Text

##### Fonts

Playdate fonts are [playdate.graphics.font](#C-graphics.font) objects, loaded into Lua with the [playdate.graphics.font.new(path)](#f-graphics.font.new) function and drawn on screen using [playdate.graphics.drawText(text, x, y)](#f-graphics.drawText).

The compiler can create a font from a standalone .fnt file with embedded image data or by combining a dependent .fnt file with a related image table. For example, if a dependent .fnt file is named awesomefont.fnt then the related image table would be named awesomefont-table-9-12.png

Standalone .fnt files can be created with the [*Playdate Caps*](https://play.date/caps/) web app from scratch or from a dependent .fnt file and image table pair.

At its simplest, a dependent .fnt file contains one line per glyph. Each line contains the glyph (the space character is indicted with the text "space"), in the order the glyph appears in the image table, and the width of the glyph, separated by any amount of whitespace. Unicode *U+xxxx* format is supported for glyph names.

Sample .fnt file excerpt

    space  6
    !       2
    "       4
    #       7

Blank lines are ignored. Comments begin with two dashes.

Sample .fnt file excerpt

    $      6
    %       8
    -- this comment will be ignored, as will any blank lines
    &       7

An optional, default tracking value can be specified on its own line like so:

Sample .fnt file excerpt

    tracking = 2

The tracking value is the number of pixels of whitespace between each character drawn in a string.

Kerning pairs are supported, one line per pair. Each line contains the two character pair, and the offset, separated by any amount of whitespace.

Sample .fnt file excerpt

    To     -2
    ll      3
    bU+20   -1

A standalone .fnt file must contain these additional properties to compile correctly. (While a standalone .fnt file can be authored manually, most will be created with *Playdate Caps*. This informataion is included here for thoroughness.)

Embedding a font’s pixel data requires 4 additional properties: the string length of the base64-encoded image table data as `datalen`, a base64-encoded image table as `data`, and the pixel dimensions of each uniform cell in the image table as `width`, and `height`.

Sample standalone .fnt file excerpt

    datalen=8984
    data=iVBO...YII=
    width=8
    height=12

*Playdate Caps* will also embed some metrics used for authoring as a JSON object in a comment.

Sample standalone .fnt file excerpt

    --metrics={"baseline":17,"xHeight":6,"capHeight":2}

###### Supported characters

Playdate supports all code points in the first four Unicode planes, up to U+3FFFF.

If a replacement character is specified it will be drawn in place of any missing characters in your font. If it is not, characters missing from the font will be drawn using the system font, if available.

###### Variants

In order to support formatting and localization, Playdate allows you to set up to three font files as variants: normal, bold, and italic.

###### Font class functions

playdate.graphics.font.new(path)

Returns a [playdate.graphics.font](#C-graphics.font) object from the data at *path*. If there is no file at *path*, the function returns nil.

playdate.graphics.font.newFamily(fontPaths)

Returns a font family table from the font files specified in *fontPaths*. *fontPaths* should be a table with the following format:

    local fontPaths = {
     [playdate.graphics.font.kVariantNormal] = "path/to/normalFont",
        [playdate.graphics.font.kVariantBold] = "path/to/boldFont",
        [playdate.graphics.font.kVariantItalic] = "path/to/italicFont"
    }

The table returned is of the same format with font objects in place of the paths, and is appropriate to pass to the functions [setFontFamily()](#f-graphics.setFontFamily) and [getTextSize()](#f-graphics.getTextSize).

playdate.graphics.setFont(font, \[variant\])

Sets the current font, a [playdate.graphics.font](#C-graphics.font).

*variant* should be one of the strings "normal", "bold", or "italic", or one of the constants:

- *playdate.graphics.font.kVariantNormal*

- *playdate.graphics.font.kVariantBold*

- *playdate.graphics.font.kVariantItalic*

If no variant is specified, *kFontVariantNormal* is used.

Equivalent to [`playdate->graphics->setFont()`](./Inside%20Playdate%20with%20C.html#f-graphics.setFont) in the C API.

playdate.graphics.getFont(\[variant\])

Returns the current font, a [playdate.graphics.font](#C-graphics.font).

playdate.graphics.setFontFamily(fontFamily)

Sets multiple font variants at once. `fontFamily` should be a table using the following format:

    local fontFamily = {
     [playdate.graphics.font.kVariantNormal] = normal_font,
        [playdate.graphics.font.kVariantBold] = bold_font,
        [playdate.graphics.font.kVariantItalic] = italic_font
    }

All fonts and font variants need not be present in the table.

playdate.graphics.setFontTracking(pixels)

Sets the global font tracking (spacing between letters) in pixels. This value is added to the font’s own tracking value as specified in its .fnt file.

See [playdate.graphics.font:setTracking](#m-graphics.font.setTracking) to adjust tracking on a specific font.

playdate.graphics.getFontTracking()

Gets the global font tracking (spacing between letters) in pixels.

playdate.graphics.getSystemFont(\[variant\])

Like [getFont()](#f-graphics.getFont) but returns the system font rather than the currently set font.

*variant* should be one of the strings "normal", "bold", or "italic", or one of the constants:

- *playdate.graphics.font.kVariantNormal*

- *playdate.graphics.font.kVariantBold*

- *playdate.graphics.font.kVariantItalic*

###### Font instance functions

playdate.graphics.font:drawText(text, x, y, \[width, height\], \[leadingAdjustment\], \[wrapMode\], \[alignment\])  
playdate.graphics.font:drawText(text, rect, \[leadingAdjustment\], \[wrapMode\], \[alignment\])

Draws a string at the specified *x, y* coordinate using this particular font instance. (Compare to [playdate.graphics.drawText(text, x, y)](#f-graphics.drawText), which draws the string with whatever the "current font" is, as defined by [playdate.graphics.setFont(font)](#f-graphics.setFont)).

If *width* and *height* are specified, drawing is constrained to the rectangle `(x,y,width,height)`, using the given `wrapMode` and `alignment` if provided. Alternatively, a [`playdate.geometry.rect`](#C-geometry.rect) object can be passed instead of `x,y,width,height`. Valid values for *wrapMode* are

- *playdate.graphics.kWrapClip*

- *playdate.graphics.kWrapCharacter*

- *playdate.graphics.kWrapWord*

and values for *alignment* are

- *playdate.graphics.kAlignLeft*

- *playdate.graphics.kAlignCenter*

- *playdate.graphics.kAlignRight*

The default wrap mode is `playdate.graphics.kWrapWord` and the default alignment is `playdate.graphics.kAlignLeft`.

The optional *leadingAdjustment* may be used to modify the spacing between lines of text.

The function returns two numbers indicating the width and height of the drawn text.

|      |                                                                                                                                           |
|------|-------------------------------------------------------------------------------------------------------------------------------------------|
| Note | `font:drawText()` does not support inline styles like bold and italics. Instead use [playdate.graphics.drawText()](#f-graphics.drawText). |

playdate.graphics.font:drawTextAligned(text, x, y, alignment, \[leadingAdjustment\])

|           |                                                           |
|-----------|-----------------------------------------------------------|
| Important | You must import *CoreLibs/graphics* to use this function. |

Draws the string *text* aligned to the left, right, or centered on the *x* coordinate. Pass one of *kTextAlignment.left*, *kTextAlignment.center*, *kTextAlignment.right* for the *alignment* parameter. (Compare to [playdate.graphics.drawTextAligned(text, x, y, alignment)](#f-graphics.drawTextAligned), which draws the string with the "current font", as defined by [playdate.graphics.setFont(font)](#f-graphics.setFont)).

playdate.graphics.font:getHeight()

Returns the pixel height of this font.

playdate.graphics.font:getTextWidth(text)

Returns the pixel width of the text when rendered with this font.

playdate.graphics.font:setTracking(pixels)

Sets the tracking of this font (spacing between letters), in pixels.

Equivalent to [`playdate->graphics->setTextTracking()`](./Inside%20Playdate%20with%20C.html#f-graphics.setTextTracking) in the C API.

playdate.graphics.font:getTracking()

Returns the tracking of this font (spacing between letters), in pixels.

Equivalent to [`playdate->graphics->getTextTracking()`](./Inside%20Playdate%20with%20C.html#f-graphics.getTextTracking) in the C API.

playdate.graphics.font:setLeading(pixels)

Sets the leading (spacing between lines) of this font, in pixels.

Equivalent to [`playdate->graphics->setTextLeading()`](./Inside%20Playdate%20with%20C.html#f-graphics.setTextLeading) in the C API.

playdate.graphics.font:getLeading()

Returns the leading (spacing between lines) of this font, in pixels.

playdate.graphics.font:getGlyph(character)

Returns the [`playdate.graphics.image`](#C-graphics.image) containing the requested glyph. *character* can either be a string or a unicode codepoint number.

##### Drawing Text

playdate.graphics.drawText(text, x, y, \[width, height\], \[fontFamily\], \[leadingAdjustment\], \[wrapMode\], \[alignment\])  
playdate.graphics.drawText(text, rect, \[fontFamily\], \[leadingAdjustment\], \[wrapMode\], \[alignment\])

Draws the text using the current font and font advance at location (*x*, *y*). If *width* and *height* are specified, drawing is constrained to the rectangle `(x,y,width,height)`, using the given *wrapMode* and *alignment*, if provided. Alternatively, a [`playdate.geometry.rect`](#C-geometry.rect) object can be passed instead of `x,y,width,height`. Valid values for *wrapMode* are

- *playdate.graphics.kWrapClip*

- *playdate.graphics.kWrapCharacter*

- *playdate.graphics.kWrapWord*

and values for *alignment* are

- *playdate.graphics.kAlignLeft*

- *playdate.graphics.kAlignCenter*

- *playdate.graphics.kAlignRight*

The default wrap mode is `playdate.graphics.kWrapWord` and the default alignment is `playdate.graphics.kAlignLeft`.

If *fontFamily* is provided, the text is draw using the given fonts instead of the currently set font. *fontFamily* should be a table of fonts using keys as specified in [setFontFamily(fontFamily)](#f-graphics.setFontFamily).

The optional *leadingAdjustment* may be used to modify the spacing between lines of text. Pass nil to use the default leading for the font.

Returns two numbers indicating the width and height of the drawn text.

**Styling text**

To draw bold text, surround the bold portion of text with asterisks. To draw italic text, surround the italic portion of text with underscores. For example:

    playdate.graphics.drawText("normal *bold* _italic_", x, y)

which will output: "normal **bold** *italic*". Bold and italic font variations must be set using [setFont()](#f-graphics.setFont) with the appropriate variant argument, otherwise the default Playdate fonts will be used.

**Escaping styling characters**

To draw an asterisk or underscore, use a double-asterisk or double-underscore. Styles may not be nested, but double-characters can be used inside of a styled portion of text.

For a complete set of characters allowed in *text*, see [playdate.graphics.font](#C-graphics.font). In addition, the newline character `\n` is allowed and works as expected.

**Avoiding styling**

Use [playdate.graphics.font:drawText()](#m-graphics.font.drawText), which doesn’t support formatted text.

**Inverting text color**

To draw white-on-black text (assuming the font you are using is defined in the standard black-on-transparent manner), first call [playdate.graphics.setImageDrawMode(playdate.graphics.kDrawModeFillWhite)](#f-graphics.setImageDrawMode), followed by the appropriate drawText() call. setImageDrawMode() affects how text is rendered because characters are technically images.

Equivalent to [`playdate->graphics->drawText()`](./Inside%20Playdate%20with%20C.html#f-graphics.drawText) in the C API.

playdate.graphics.drawLocalizedText(key, x, y, \[width, height\], \[language\], \[leadingAdjustment\], \[wrapMode\], \[alignment\])  
playdate.graphics.drawLocalizedText(key, rect, \[language\], \[leadingAdjustment\])

Draws the text found by doing a lookup of *key* in the .strings file corresponding to the current system language, or *language*, if specified.

The optional *language* argument can be one of the strings "en", "jp", or one of the constants:

- *playdate.graphics.font.kLanguageEnglish*

- *playdate.graphics.font.kLanguageJapanese*

Other arguments work the same as in [`drawText()`](#f-graphics.drawText).

For more information about localization and strings files, see the [Localization](#localization) section.

playdate.graphics.getLocalizedText(key, \[language\])

Returns a string found by doing a lookup of *key* in the .strings file corresponding to the current system language, or *language*, if specified.

The optional *language* argument can be one of the strings "en", "jp", or one of the constants:

- *playdate.graphics.font.kLanguageEnglish*

- *playdate.graphics.font.kLanguageJapanese*

For more information about localization and strings files, see the [Localization](#localization) section.

playdate.graphics.getTextSize(str, \[fontFamily, \[leadingAdjustment\]\])

Returns multiple values *(width, height)* giving the dimensions required to draw the text *str* using [drawText()](#f-graphics.drawText). Newline characters (`\n`) are respected.

*fontFamily* should be a table of fonts using keys as specified in [setFontFamily(fontFamily)](#f-graphics.setFontFamily). If provided, fonts from *fontFamily* will be used for calculating the size of *str* instead of the currently set font.

playdate.graphics.drawTextAligned(text, x, y, alignment, \[leadingAdjustment\])

|           |                                                           |
|-----------|-----------------------------------------------------------|
| Important | You must import *CoreLibs/graphics* to use this function. |

Draws the string *text* aligned to the left, right, or centered on the *x* coordinate. Pass one of *kTextAlignment.left*, *kTextAlignment.center*, *kTextAlignment.right* for the *alignment* parameter.

For text formatting options, see [drawText()](#f-graphics.drawText)

To draw unstyled text using a single font, see [playdate.graphics.font:drawTextAligned()](#m-graphics.font.drawTextAligned)

playdate.graphics.drawTextInRect(text, x, y, width, height, \[leadingAdjustment, \[truncationString, \[alignment, \[font\]\]\]\])  
playdate.graphics.drawTextInRect(text, rect, \[leadingAdjustment, \[truncationString, \[alignment, \[font\]\]\]\])

|           |                                                             |
|-----------|-------------------------------------------------------------|
| Important | You must import *CoreLibs/graphics* to use these functions. |

Draws the text using the current font and font advance into the rect defined by (*`x`*, *`y`*, *`width`*, *`height`*) (or *`rect`*).

If *`truncationString`* is provided and the text cannot fit in the rect, *`truncationString`* will be appended to the last line.

*`alignment`*, if provided, should be one of one of *`kTextAlignment.left`*, *`kTextAlignment.center`*, *`kTextAlignment.right`*. Pass `nil` for *`leadingAdjustment`* and *`truncationString`* if those parameters are not required.

*`font`*, if provided, will cause the text to be drawn unstyled using [font:drawText()](#m-graphics.font.drawText) rather than [playdate.graphics.drawText()](#f-graphics.drawText) using the currently-set system fonts.

For text formatting options, see [drawText()](#f-graphics.drawText)

Returns *`width`*, *`height`*, *`textWasTruncated`*

*`width`* and *`height`* indicate the size in pixels of the drawn text. These values may be smaller than the width and height specified when calling the function.

*`textWasTruncated`* indicates if the text was truncated to fit within the specified rect.

playdate.graphics.drawLocalizedTextAligned(text, x, y, alignment, \[language, \[leadingAdjustment\]\])

|           |                                                           |
|-----------|-----------------------------------------------------------|
| Important | You must import *CoreLibs/graphics* to use this function. |

Same as [drawTextAligned()](#f-graphics.drawTextAligned) except localized text is drawn.

playdate.graphics.drawLocalizedTextInRect(text, x, y, width, height, \[leadingAdjustment, \[truncationString, \[alignment, \[font, \[language\]\]\]\]\])  
playdate.graphics.drawLocalizedTextInRect(text, rect, \[leadingAdjustment, \[truncationString, \[alignment, \[font, \[language\]\]\]\]\])

|           |                                                             |
|-----------|-------------------------------------------------------------|
| Important | You must import *CoreLibs/graphics* to use these functions. |

Same as [drawTextInRect()](#f-graphics.drawTextInRect) except localized text is drawn.

playdate.graphics.getTextSizeForMaxWidth(text, maxWidth, \[leadingAdjustment, \[font\]\]\])

|           |                                                           |
|-----------|-----------------------------------------------------------|
| Important | You must import *CoreLibs/graphics* to use this function. |

Returns *`width`*, *`height`* which indicate the minimum size required for *`text`* to be drawn using [drawTextInRect()](#f-graphics.drawTextInRect). The *`width`* returned will be less than or equal to *`maxWidth`*.

*`font`*, if provided, will cause the text size to be calculated without bold or italic styling using the specified font.

playdate.graphics.imageWithText(text, maxWidth, maxHeight, \[backgroundColor, \[leadingAdjustment, \[truncationString, \[alignment, \[font\]\]\]\]\])

|           |                                                           |
|-----------|-----------------------------------------------------------|
| Important | You must import *CoreLibs/graphics* to use this function. |

Generates an image containing *`text`*. This is useful if you need to redraw the same text frequently.

*`maxWidth`* and *`maxHeight`* specify the maximum size of the returned image.

*`backgroundColor`*, if specified, will cause the image’s background to be one of *playdate.graphics.kColorWhite*, *playdate.graphics.kColorBlack*, or *playdate.graphics.kColorClear*.

*`font`*, if provided, will cause the text to be drawn without bold or italic styling using the specified font.

The remaining arguments are the same as those in [drawTextInRect()](#f-graphics.drawTextInRect).

Returns *`image`*, *`textWasTruncated`*

*`image`* is a newly-created image containing the specified text, or nil if an image could not be created. The image’s dimensions may be smaller than *`maxWidth`*, *`maxHeight`*.

*`textWasTruncated`* indicates if the text was truncated to fit within the specified width and height.

#### Video

The video player renders frames from a pdv file into an image or directly to the screen. Note that the renderer expects to have ownership of the data in its drawing context, whether it’s the screen or a separate image. Drawing over the video frames in the render context can cause the image to become garbled. If you want to use drawing functions on top of the video, create a context image for the video to render to (calling video:getContext() will create the image), call video:renderFrame(), then draw the context image to the screen, then draw on top of that. The pdv file does not (currently) contain audio, so typically you’d play the audio in a fileplayer or sampleplayer and use the current audio offset to determine which video frame to display.

A minimal video player:

```lua
local disp = playdate.display
local gfx = playdate.graphics
local snd = playdate.sound

disp.setRefreshRate(0)

local video = gfx.video.new('movie')
video:useScreenContext()
video:renderFrame(0)

local lastframe = 0

local audio, loaderr = snd.sampleplayer.new('movie')

if audio ~= nil then
        audio:play(0)
else
        print(loaderr)
end

function playdate.update()

        local frame = math.floor(audio:getOffset() * video:getFrameRate())

        if frame ~= lastframe then
                video:renderFrame(frame)
                lastframe = frame
        end
end
```

playdate.graphics.video.new(path)

Returns a [playdate.graphics.video](#C-graphics.video) object from the pdv file at *path*. If the file at *path* can’t be opened, the function returns nil.

playdate.graphics.video:getSize()

Returns the width and height of the video as multiple vlaues (*width*, *height*).

playdate.graphics.video:getFrameCount()

Returns the number of frames in the video.

playdate.graphics.video:getFrameRate()

Returns the number of frames per second of the video source. This number is simply for record-keeping, it is not used internally—​the game code is responsible for figuring out which frame to show when.

playdate.graphics.video:setContext(image)

Sets the given image to the video render context. Future `video:renderFrame()` calls will draw into this image.

playdate.graphics.video:getContext()

Returns the image into which the video will be rendered, creating it if needed.

playdate.graphics.video:useScreenContext()

Sets the display framebuffer as the video’s render context.

playdate.graphics.video:renderFrame(number)

Draws the given frame into the video’s render context.

playdate.graphics.video:getCurrentFrame()

Returns the frame number of the currently displayed frame.

### 7.21. JSON

Provides encoding and decoding of JSON files and strings.

json.decode(string)

Takes the JSON encoded string and converts it to a Lua table.

Equivalent to [`playdate->json->decode()`](./Inside%20Playdate%20with%20C.html#f-json.decode) in the C API.

json.decodeFile(file)  
json.decodeFile(path)

Reads the given [playdate.file.file](#M-file) object or the file at the given `path` and converts it to a Lua table.

json.encode(table)

Returns a string containing the JSON representation of the passed-in Lua table.

json.encodePretty(table)

Returns a string containing the JSON representation of a Lua table, with human-readable formatting.

json.encodeToFile(file, \[pretty\], table)  
json.encodeToFile(path, \[pretty\], table)

Encodes the Lua table `table` to JSON and writes it to the given [playdate.file.file](#M-file) object or the given `path`. If `pretty` is true, the output is formatted to make it human-readable. Otherwise, no additional whitespace is added.

|     |                                                                                               |
|-----|-----------------------------------------------------------------------------------------------|
| Tip | For a very simple way to serialize a table to a file, see [playdate.datastore](#M-datastore). |

### 7.22. Keyboard

An on-screen keyboard that can be used for text entry.

|           |                                                             |
|-----------|-------------------------------------------------------------|
| Important | You must import *CoreLibs/keyboard* to use these functions. |

|      |                                                                                                                              |
|------|------------------------------------------------------------------------------------------------------------------------------|
| Note | Keyboard is only designed to work at 1x display scale, and will not work well at other [scale factors](#f-display.setScale). |

playdate.keyboard.show(\[text\])

Opens the keyboard, taking over input focus.

*text*, if provided, will be used to set the initial text value of the keyboard.

playdate.keyboard.hide()

Hides the keyboard.

playdate.keyboard.text

Access or set the text value of the keyboard.

playdate.keyboard.setCapitalizationBehavior(behavior)

*behavior* should be one of the constants *playdate.keyboard.kCapitalizationNormal*, *playdate.keyboard.kCapitalizationWords*, or *playdate.keyboard.kCapitalizationSentences*.

In the case of *playdate.keyboard.kCapitalizationWords*, the keyboard selection will automatically move to the upper case column after a space is entered. For *playdate.keyboard.kCapitalizationSentences* the selection will automatically move to the upper case column after a period and a space have been entered.

playdate.keyboard.left()

Returns the current x location of the left edge of the keyboard.

playdate.keyboard.width()

Returns the pixel width of the keyboard.

playdate.keyboard.isVisible()

Returns true if the keyboard is currently being shown.

playdate.keyboard.keyboardDidShowCallback

If set, this function will be called when the keyboard is finished the opening animation.

playdate.keyboard.keyboardDidHideCallback

If set, this function will be called when the keyboard has finished the hide animation.

playdate.keyboard.keyboardWillHideCallback

If set, this function will be called when the keyboard starts to close. A Boolean argument will be passed to the callback, `true` if the user selected "OK" close the keyboard, `false` otherwise.

playdate.keyboard.keyboardAnimatingCallback

If set, this function is called as the keyboard animates open or closed. Provided as a way to sync animations with the keyboard movement.

playdate.keyboard.textChangedCallback

If set, this function will be called every time a character is entered or deleted.

### 7.23. Math

playdate.math.lerp(min, max, t)

Returns a number that is the linear interpolation between *min* and *max* based on *t*, where *t = 0.0* will return *min* and *t = 1.0* will return *max*.

|           |                                                       |
|-----------|-------------------------------------------------------|
| Important | You must import *CoreLibs/math* to use this function. |

### 7.24. Networking

Playdate OS 2.7 adds support for both HTTP and TCP networking. Up to four simultaneous connections are possible.

playdate.network.setEnabled(flag, function)

Playdate will connect to the configured access point automatically as needed and turn off the wifi radio after a 30 second idle timeout. This function allows a game to start connecting to the access point sooner, since that can take upwards of 10 seconds, or turn off wifi as soon as it’s no longer needed instead of waiting 30 seconds. If `flag` is true, a callback function can be provided to check for an error connecting to the access point; the argument passed to the callback is a string describing the error, or nil if no error occurred.

playdate.network.getStatus()

Returns one of the constants:

- *playdate.network.kStatusNotConnected* : Not connected to an AP

- *playdate.network.kStatusConnected* : Device is connected to an AP

- *playdate.network.kStatusNotAvailable* : No configured AP is available

#### HTTP 

playdate.network.http.new(server, \[port\], \[usessl\], \[reason\])

Returns a `playdate.network.http` object for connecting to the given server. The default port is 443 if `usessl` is true, otherwise 80; the default value for `usessl` is false. If the user has not yet given permission for the device to connect to the server, the game is paused while the system asks the user to allow or deny network access for the provided `reason`, if one is given. Since the system uses a coroutine `yield()` to show the dialog to request access (if not already given), it cannot be called at load time or from an input handler or other system callback.

playdate.network.http.requestAccess(\[server\], \[port\], \[usessl\], \[reason\])

`playdate.network.http.new()` will automatically request access if needed (and note that `new()` only creates an object for connecting, doesn’t open the connection until `get()` or `post()` is called) but if you want to present the access dialog ahead of time you can use this function. Notably, this lets you request access to all HTTP servers by leaving the `server` field empty, or all subdomains of a domain by passing in the parent. Note that this function uses a coroutine `yield()` to pause the runtime while the permission dialog is up, so it can’t be called immediately at startup, must be called from a `playdate.update()` context

playdate.network.http:close()

Closes the HTTP connection. The connection may be used again for another request.

playdate.network.http:setKeepAlive(flag)

If `flag` is true, this causes the HTTP request to include a *Connection: keep-alive* header.

playdate.network.http:setByteRange(from, to)

Adds a `Range: bytes` header to the HTTP request.

playdate.network.http:setConnectTimeout(seconds)

Sets the length of time (in seconds) to wait for the connection to the server to be made.

playdate.network.http:get(path, \[headers\])

Opens the connection to the server if it’s not already open (e.g. from a previous request with the given path and additional *headers* if specified. The *headers* argument can either be a string containing all of the headers to send (with newlines between individual headers), an array of strings, or a table of key/value pairs.

If the request is successfully queued, the function returns `true`. On error, the function returns `false` and a string indicating the error.

playdate.network.http:query(path, \[headers\], data)

Opens the connection to the server if it’s not already open (e.g. from a previous request with keep-alive enabled) and sends the given request with the given path, additional *headers* if specified, and the provided *data*. The *headers* argument can either be a string containing all of the headers to send (with newlines between individual headers), an array of strings, or a table of key/value pairs. If there is only one argument after *path* it is assumed to be *data*.

If the request is successfully queued, the function returns `true`. On error, the function returns `false` and a string indicating the error.

playdate.network.http:post(path, \[headers\], data)

Equivalent to calling `playdate.network.http:query()` with *method* equal to `POST`.

playdate.network.http:getError()

Returns a text description of the last error on the connection, or nil if no error occurred.

playdate.network.http:getProgress()

Returns two values: the number of bytes already read from the connection and the total bytes the server plans to send.

playdate.network.http:getBytesAvailable()

Returns the number of bytes currently available for reading from the connection.

playdate.network.http:setReadTimeout(seconds)

Sets the length of time, in seconds, `playdate.network.http:read()` will wait for incoming data before returning. The default value is one second.

playdate.network.http:setReadBufferSize(bytes)

Sets the size of the connection’s read buffer.

playdate.network.http:read(\[length\])

On success, returns up to `length` bytes (maximum 64KB) from the connection. If `length` is more than the number of bytes available the function will wait for more data up to the length of time set by `setReadTimeout()` (default one second).

playdate.network.http:getResponseStatus()

Returns the HTTP status response code, if the request response headers have been received and parsed.

playdate.network.http:getResponseHeaders()

Returns a table containing the key/value pairs in the HTTP response headers, or nil if no headers were received.

playdate.network.http:setRequestCallback(function)

Sets a function to be called when response data is available.

playdate.network.http:setHeadersReadCallback(function)

Sets a function to be called after the connection has parsed the headers from the server response. At this point, `getResponseStatus()` and `getProgress()` can be used to query the status and size of the response, and `get()`/`post()` can queue another request if `connection:setKeepAlive(true)` was set.

playdate.network.http:setRequestCompleteCallback(function)

Sets a function to be called when all data for the request has been received (if the response contained a Content-Length header and the size is known) or the request times out.

playdate.network.http:setConnectionClosedCallback(function)

Sets a function to be called when the server has closed the connection.

#### TCP 

playdate.network.tcp.new(server, port, \[usessl\], \[reason\])

Returns a `playdate.network.tcp` object for connecting to the given server. The default value for `usessl` is false. If the user has not yet given permission for the device to connect to the server, the game is paused while the system asks the user to allow or deny network access for the provided `reason`, if one is given. Since the system uses a coroutine `yield()` to show the dialog to request access (if not already given), it cannot be called at load time or from an input handler or other system callback.

playdate.network.tcp.requestAccess(\[server\], \[port\], \[reason\])

`playdate.network.tcp.new()` will automatically request access if needed (and note that `new()` only creates an object for connecting, doesn’t open the connection until `open()` is called) but if you want to present the access dialog ahead of time you can use this function. Notably, this lets you request access to all servers by leaving the `server` field empty, or all subdomains of a domain by passing in the parent. Access to all ports on a given server can be requested by leaving `port` empty. Note that this function uses a coroutine `yield()` to pause the runtime while the permission dialog is up, so it can’t be called immediately at startup, must be called from a `playdate.update()` context

playdate.network.tcp:setConnectTimeout(seconds)

Sets the length of time (in seconds) to wait for the connection to the server to be made.

playdate.network.tcp:open(connectCallback)

Attempts to open the TCP connection. `connectCallback` is a function to be called when the connection either succeeds or fails. The function is called with a boolean indicating whether the connection was successful, and an error string if the connection failed.

```lua
connection:open(function tcpConnectCallback(connected, err)
        if connected then print("connected!") else print("connection failed: "..err) end
end)
```

playdate.network.tcp:close()

Closes the connection. `open()` may be called again after this to reopen the connection to the server.

playdate.network.tcp:getBytesAvailable()

Returns the number of bytes currently available in the connection’s read buffer for reading from the connection.

playdate.network.tcp:setReadTimeout(seconds)

Sets the length of time, in seconds, `playdate.network.tcp:read()` will wait for incoming data before returning. The default value is one second.

playdate.network.tcp:setReadBufferSize(bytes)

Sets the size of the connection’s read buffer.

playdate.network.tcp:read(\[length\])

On success, returns up to `length` bytes (maximum 64KB) from the connection as well as the number of bytes that were read. If `length` is more than the number of bytes available the function will wait for more data up to the length of time set by `setReadTimeout()` (default one second).

playdate.network.tcp:write(data)

Attempts to write the given data to the connection. On success, returns `true`; on failure, returns `false` and a string describing the error.

playdate.network.tcp:getError()

Returns a text description of the last error on the connection, or nil if no error occurred.

playdate.network.tcp:setConnectionClosedCallback(function)

Sets a function to be called when the server has closed the connection.

### 7.25. Pathfinding

An implementation of the popular A\* pathfinding algorithm. To find a path first create a [playdate.pathfinder.graph](#C-playdate.pathfinder.graph) containing connected [playdate.pathfinder.nodes](#C-playdate.pathfinder.node) then call [findPath](#m-pathfinder.graph.findPath) on the graph. A heuristic function callback can be specified for determining an estimate of the distance between two nodes, otherwise the manhattan distance between nodes will be used. In that case it is important to set appropriate x and y values on the nodes.

|     |                                                     |
|-----|-----------------------------------------------------|
| Tip | Example code: `<Playdate SDK>/Examples/Pathfinder/` |

#### Graph 

playdate.pathfinder.graph.new(\[nodeCount, \[coordinates\]\])

Returns a new empty [playdate.pathfinder.graph](#C-playdate.pathfinder.graph) object.

If `nodeCount` is supplied, that number of nodes will be allocated and added to the graph. Their IDs will be set from 1 to `nodeCount`.

`coordinates`, if supplied, should be a table containing tables of x, y values, indexed by node IDs. For example, `{{10, 10}, {50, 30}, {20, 100}, {100, 120}, {160, 130}}`.

playdate.pathfinder.graph.new2DGrid(width, height, \[allowDiagonals, \[includedNodes\]\])

Convenience function that returns a new [playdate.pathfinder.graph](#C-playdate.pathfinder.graph) object containing nodes for for each grid position, even if not connected to any other nodes. This allows for easier graph modification once the graph is generated. Weights for connections between nodes are set to 10 for horizontal and vertical connections and 14 for diagonal connections (if included), as this tends to produce nicer paths than using uniform weights. Nodes have their indexes set from 1 to *width* \* *height*, and have their *x, y* values set appropriately for the node’s position.

- *width*: The width of the grid to be created.

- *height*: The height of the grid to be created.

- *allowDiagonals*: If true, diagonal connections will also be created.

- *includedNodes*: A one-dimensional array of length *width* \* *height*. Each entry should be a 1 or a 0 to indicate nodes that should be connected to their neighbors and nodes that should not have any connections added. If not provided, all nodes will be connected to their neighbors.

playdate.pathfinder.graph:addNewNode(id, \[x, y, \[connectedNodes, weights, addReciprocalConnections\]\])

Creates a new [playdate.pathfinder.node](#C-playdate.pathfinder.node) and adds it to the graph.

- *id*: id value for the new node.

- *x*: Optional x value for the node.

- *y*: Optional y value for the node.

- *connectedNodes*: Array of existing nodes to create connections to from the new node.

- *weights*: Array of weights for the new connections. Array must be the same length as *connectedNodes*. Weights affect the path the A\* algorithm will solve for. A longer, lighter-weighted path will be chosen over a shorter heavier path, if available.

- *addReciprocalConnections*: If true, connections will also be added in the reverse direction for each node.

playdate.pathfinder.graph:addNewNodes(count)

Creates *count* new nodes, adding them to the graph, and returns them in an array-style table. The new node’s *id_s will be assigned values 1 through \_count*-1.

This method is useful to improve performance if many nodes need to be allocated at once rather than one at a time, for example when creating a new graph.

playdate.pathfinder.graph:addNode(node, \[connectedNodes, weights, addReciprocalConnections\])

Adds an already-existing node to the graph. The node must have originally belonged to the same graph.

- *node*: Node to be added to the graph.

- *connectedNodes*: Array of existing nodes to create connections to from the new node.

- *weights*: Array of weights for the new connections. Array must be the same length as *connectedNodes*. Weights affect the path the A\* algorithm will solve for. A longer, lighter-weighted path will be chosen over a shorter heavier path, if available.

- *addReciprocalConnections*: If true, connections will also be added in the reverse direction for each connection added.

playdate.pathfinder.graph:addNodes(nodes)

Adds an array of already-existing nodes to the graph.

playdate.pathfinder.graph:allNodes()

Returns an array containing all nodes in the graph.

playdate.pathfinder.graph:removeNode(node)

Removes node from the graph. Also removes all connections to and from the node.

playdate.pathfinder.graph:removeNodeWithXY(x, y)

Returns the first node found with coordinates matching *x, y*, after removing it from the graph and removing all connections to and from the node.

playdate.pathfinder.graph:removeNodeWithID(id)

Returns the first node found with a matching *id*, after removing it from the graph and removing all connections to and from the node.

playdate.pathfinder.graph:nodeWithID(id)

Returns the first node found in the graph with a matching *id*, or nil if no such node is found.

playdate.pathfinder.graph:nodeWithXY(x, y)

Returns the first node found in the graph with matching *x* and *y* values, or nil if no such node is found.

playdate.pathfinder.graph:addConnections(connections)

`connections` should be a table of array-style tables. The keys of the outer table should correspond to node IDs, while the inner array should be a series if connecting node ID and weight combinations that will be assigned to that node. For example, `{[1]={2, 10, 3, 12}, [2]={1, 20}, [3]={1, 20, 2, 10}}` will create a connection from node ID 1 to node ID 2 with a weight of 10, and a connection to node ID 3 with a weight of 12, and so on for the other entries.

playdate.pathfinder.graph:addConnectionToNodeWithID(fromNodeID, toNodeID, weight, addReciprocalConnection)

Adds a connection from the node with `id` `fromNodeID` to the node with `id` `toNodeID` with a weight value of `weight`. Weights affect the path the A\* algorithm will solve for. A longer, lighter-weighted path will be chosen over a shorter heavier path, if available. If `addReciprocalConnection` is true, the reverse connection will also be added.

playdate.pathfinder.graph:removeAllConnections()

Removes all connections from all nodes in the graph.

playdate.pathfinder.graph:removeAllConnectionsFromNodeWithID(id, \[removeIncoming\])

Removes all connections from the matching node.

If `removeIncoming` is true, all connections from other nodes to the calling node are also removed. False by default. Please note: this can signficantly increase the time this function takes as it requires a full search of the graph - O(1) vs O(n)).

playdate.pathfinder.graph:findPath(startNode, goalNode, \[heuristicFunction, \[findPathToGoalAdjacentNodes\]\])

Returns an array of nodes representing the path from *startNode* to *goalNode*, or *nil* if no path can be found.

- *heuristicFunction*: If provided, this function should be of the form *function(startNode, goalNode)* and should return an integer value estimate or underestimate of the distance from *startNode* to *goalNode*. If not provided, a manhattan distance function will be used to calculate the estimate. This requires that the *x, y* values of the nodes in the graph have been set properly.

- *findPathToGoalAdjacentNodes*: If true, a path will be found to any node adjacent to the goal node, based on the *x, y* values of those nodes and the goal node. This does not rely on connections between adjacent nodes and the goal node, which can be entirely disconnected from the rest of the graph.

playdate.pathfinder.graph:findPathWithIDs(startNodeID, goalNodeID, \[heuristicFunction, \[findPathToGoalAdjacentNodes\]\])

Works the same as [findPath](#m-pathfinder.graph.findPath), but looks up nodes to find a path between using startNodeID and goalNodeID and returns a list of nodeIDs rather than the nodes themselves.

playdate.pathfinder.graph:setXYForNodeWithID(id, x, y)

Sets the matching node’s `x` and `y` values.

#### Node

You can directly read or write **x**, **y** and **id** values on a playdate.pathfinder.node.

playdate.pathfinder.node:addConnection(node, weight, addReciprocalConnection)

Adds a new connection between nodes.

- *node*: The node the new connection will point to.

- *weight*: Weight for the new connection. Weights affect the path the A\* algorithm will solve for. A longer, lighter-weighted path will be chosen over a shorter heavier path, if available.

- *addReciprocalConnection*: If true, a second connection will be created with the same weight in the opposite direction.

playdate.pathfinder.node:addConnections(nodes, weights, addReciprocalConnections)

Adds a new connection to each node in the nodes array.

- *nodes*: An array of nodes which the new connections will point to.

- *weights*: An array of weights for the new connections. Must be of the same length as the nodes array. Weights affect the path the A\* algorithm will solve for. A longer, lighter-weighted path will be chosen over a shorter heavier path, if available.

- *addReciprocalConnections*: If true, connections will also be added in the reverse direction for each node.

playdate.pathfinder.node:addConnectionToNodeWithXY(x, y, weight, addReciprocalConnection)

Adds a connection to the first node found with matching *x* and *y* values, if it exists.

- *weight*: The weight for the new connection. Weights affect the path the A\* algorithm will solve for. A longer, lighter-weighted path will be chosen over a shorter heavier path, if available.

- *addReciprocalConnections*: If true, a connection will also be added in the reverse direction, from the node at x, y to the caller.

playdate.pathfinder.node:connectedNodes()

Returns an array of nodes that have been added as connections to this node.

playdate.pathfinder.node:removeConnection(node, \[removeReciprocal\])

Removes a connection to node, if it exists. If *removeReciprocal* is true the reverse connection will also be removed, if it exists.

playdate.pathfinder.node:removeAllConnections(\[removeIncoming\])

Removes all connections from the calling node.

If `removeIncoming` is true, all connections from other nodes to the calling node are also removed. False by default. Please note: this can signficantly increase the time this function takes as it requires a full search of the graph - O(1) vs O(n)).

playdate.pathfinder.node:setXY(x, y)

Sets the *x* and *y* values for the node.

### 7.26. Power

playdate.getPowerStatus()

Returns a table holding booleans with the following keys:

- *charging*: The battery is actively being charged

- *USB*: There is a powered USB cable connected

- *screws*: There is 5V being applied to the corner screws (via the dock, for example)

playdate.getBatteryPercentage()

Returns a value from 0-100 denoting the current level of battery charge. 0 = empty; 100 = full.

playdate.getBatteryVoltage()

Returns the battery’s current voltage level.

### 7.27. Simulator-only functionality

playdate.isSimulator

This variable—not a function, so don’t invoke with *()*—it is set to 1 when running inside of the Simulator and is *nil* otherwise.

playdate.simulator.writeToFile(image, path)

Writes an image to a PNG file at the path specified. Only available on the Simulator.

|      |                                                                                                                                                                                                                                                                                                                                                                                                         |
|------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Note | *path* represents a path on your development computer, not the Playdate filesystem. It’s recommended you prefix your path with `~/` to ensure you are writing to a writeable directory, for example, `~/myImageFile.png`. Please include the `.png` file extension in your path name. Any directories in your path must already exist on your development computer in order for the file to be written. |

playdate.simulator.exit()

Quits the Playdate Simulator app.

playdate.simulator.getURL(url)

Returns the contents of the URL *url* as a string.

playdate.clearConsole()

Clears the simulator console.

playdate.setDebugDrawColor(r, g, b, a)

Sets the color of the [playdate.debugDraw()](#c-debugDraw) overlay image. Values are in the range 0-1.

#### Simulator debug callbacks

These callbacks are only invoked when your game is running in the Simulator.

playdate.keyPressed(key)

Lets you act on keyboard keypresses when running in the Simulator ONLY. These can be useful for adding debugging functions that can be enabled via your keyboard.

|      |                                                                                                                                                                |
|------|----------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Note | It is possible test a game on Playdate hardware and trap computer keyboard keypresses if you are using the Simulator’s `Control Device with Simulator` option. |

`key` is a string containing the character pressed or released on the keyboard. Note that:

- The key in question needs to have a textual representation or these functions will not be called. For instance, alphanumeric keys will call these functions; keyboard directional arrows will not.

- If the keypress in question is already in use by the Simulator for another purpose (say, to control the d-pad or A/B buttons), these functions will not be called.

- If *key* is an alphabetic character, the value will always be lowercase, even if the user deliberately typed an uppercase character.

playdate.keyReleased(key)

Lets you act on keyboard key releases when running in the Simulator ONLY. These can be useful for adding debugging functions that can be enabled via your keyboard.

playdate.debugDraw()

Called immediately after [playdate.update()](#c-update), any drawing performed during this callback is overlaid on the display in 50% transparent red (or another color selected with [playdate.setDebugDrawColor()](#f-setDebugDrawColor)).

White pixels are drawn in the [debugDrawColor](#f-setDebugDrawColor). Black pixels are transparent.

### 7.28. Sound

The Playdate audio engine provides [sample playback](#C-sound.sampleplayer) from memory for short on-demand samples, [file streaming](#C-sound.fileplayer) for playing longer files (uncompressed, MP3, and ADPCM formats), and a [synthesis](#C-sound.synth) library for generating "computer-y" sounds. Sound sources are grouped into [channels](#C-sound.channel), which can be panned separately, and various [effects](#C-sound.effect) may be applied to the channels. Additionally, [signals](#C-sound.signal) can automate various parameters of the sound objects.

playdate.sound.getSampleRate()

Returns the sample rate of the audio system (44100). The sample rate is determined by the hardware, and is not currently mutable.

Preparing your sound files

**ADPCM** is the ideal audio format to use for Playdate games. It is less CPU-intensive to decode than MP3, while still providing a much smaller file size than uncompressed audio.

To encode into ADPCM with [Audacity](https://www.audacityteam.org)  
File \> Export Audio… \> File type: WAV (Microsoft), Encoding: IMA ADPCM.

To encode into ADPCM with [ffmpeg](https://www.ffmpeg.org)  
type `ffmpeg -i input.mp3 -acodec adpcm_ima_wav output.wav` at the command line.

#### Sampleplayer

The sampleplayer class is used for playing short samples like sound effects. Audio data is loaded into memory at instantiation, so it plays with little overhead. For longer audio like background music, the [fileplayer](#C-sound.fileplayer) class may be more appropriate; there, audio data is streamed from disk as it’s played and only a small portion of the data is in memory at any given time.

|      |                                                                                                                                                                                                          |
|------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Note | Unlike [fileplayer](#C-sound.fileplayer), sampleplayer cannot play MP3 files. For a balance of good performance and small file size, we recommend encoding audio into [ADPCM .wav files](#M-sound-prep). |

playdate.sound.sampleplayer.new(path)

Returns a new playdate.sound.sampleplayer object, with the sound data loaded in memory. If the sample can’t be loaded, the function returns nil and a second value containing the error.

playdate.sound.sampleplayer.new(sample)

Returns a new playdate.sound.sampleplayer object for playing the given [sample](#C-sound.sample).

playdate.sound.sampleplayer:copy()

Returns a new playdate.sound.sampleplayer with the same sample, volume, and rate as the given sampleplayer.

playdate.sound.sampleplayer:play(\[repeatCount\], \[rate\])

Starts playing the sample. If *repeatCount* is greater than one, it loops the given number of times. If zero, it loops endlessly until it is stopped with [playdate.sound.sampleplayer:stop()](#m-sound.sampleplayer.stop). If *rate* is set, the sample will be played at the given rate instead of the rate previous set with [playdate.sound.sampleplayer.setRate()](#m-sound.sampleplayer.setRate).

playdate.sound.sampleplayer:playAt(when, \[vol\], \[rightvol\], \[rate\])

Schedules the sound for playing at device time *when*. If *vol* is specified, the sample will be played at level *vol* (with optional separate right channel volume *rightvol*), otherwise it plays at the volume set by [playdate.sound.sampleplayer.setVolume()](#m-sound.sampleplayer.setVolume). Note that the *when* argument is an offset in the audio device’s time scale, as returned by [playdate.sound.getCurrentTime()](#f-sound.getCurrentTime); it is **not** relative to the current time! If *when* is less than the current audio time, the sample is played immediately. If *rate* is set, the sample will be played at the given rate instead of the rate previously set with [playdate.sound.sampleplayer.setRate()](#m-sound.sampleplayer.setRate).

Only one event can be queued at a time. If `playAt()` is called while another event is queued, it will overwrite it with the new values.

The function returns true if the sample was successfully added to the sound channel, otherwise false (i.e., if the channel is full).

playdate.sound.sampleplayer:setVolume(left, \[right\])

Sets the playback volume (0.0 - 1.0) for left and right channels. If the optional *right* argument is omitted, it is the same as *left*. If the sampleplayer is currently playing using the default volume (that is, it wasn’t triggered by `playAt()` with a volume given) it also changes the volume of the playing sample.

playdate.sound.sampleplayer:getVolume()

Returns the playback volume for the sampleplayer, a single value for mono sources or a pair of values (left, right) for stereo sources.

playdate.sound.sampleplayer:setLoopCallback(callback, \[arg\])

Sets a function to be called every time the sample loops. The sample object is passed to this function as the first argument, and the optional *arg* argument is passed as the second.

playdate.sound.sampleplayer:setPlayRange(start, end)

Sets the range of the sample to play. *start* and *end* are frame offsets from the beginning of the sample.

playdate.sound.sampleplayer:setPaused(flag)

Pauses or resumes playback.

playdate.sound.sampleplayer:isPlaying()

Returns a boolean indicating whether the sample is playing.

playdate.sound.sampleplayer:stop()

Stops playing the sample.

playdate.sound.sampleplayer:setFinishCallback(func, \[arg\])

Sets a function to be called when playback has completed. The sample object is passed to this function as the first argument, and the optional *arg* argument is passed as the second.

playdate.sound.sampleplayer:setSample(sample)

Sets the [sample](#C-sound.sample) to be played.

playdate.sound.sampleplayer:getSample()

Gets the [sample](#C-sound.sample) to be played.

playdate.sound.sampleplayer:getLength()

Returns the length of the sampleplayer’s sample, in seconds. Length is not scaled by playback rate.

playdate.sound.sampleplayer:setRate(rate)

Sets the playback rate for the sample. 1.0 is normal speed, 0.5 is down an octave, 2.0 is up an octave, etc. Sampleplayers can also play samples backwards, by setting a negative rate; note, however, this does not work with ADPCM-encoded files.

playdate.sound.sampleplayer:getRate()

Returns the playback rate for the sample.

playdate.sound.sampleplayer:setRateMod(signal)

Sets the [signal](#C-sound.signal) to use as a rate modulator, added to the rate set with [playdate.sound.sampleplayer:setRate()](#m-sound.sampleplayer.setRate). Set to *nil* to clear the modulator.

playdate.sound.sampleplayer:setOffset(seconds)

Sets the current offset of the sampleplayer, in seconds. This value is not adjusted for rate.

playdate.sound.sampleplayer:getOffset()

Returns the current offset of the sampleplayer, in seconds. This value is not adjusted for rate.

#### Fileplayer

The fileplayer class is used for streaming audio from a file on disk. This requires less memory than keeping all of the file’s data in memory (as with the [sampleplayer](#C-sound.sampleplayer)), but can increase overhead at run time.

|      |                                                                                                                                                                                              |
|------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Note | Fileplayer can play MP3 files, but MP3 decoding is CPU-intensive. For a balance of good performance and small file size, we recommend encoding audio into [ADPCM .wav files](#M-sound-prep). |

playdate.sound.fileplayer.new(\[buffersize\])

Returns a fileplayer object, which can stream samples from disk. The file to play is set with the [playdate.sound.fileplayer:load()](#m-sound.fileplayer.load) function.

If given, *buffersize* specifies the size in seconds of the fileplayer’s data buffer. A shorter value reduces the latency of a [playdate.sound.fileplayer:setOffset()](#m-sound.fileplayer.setOffset) call, but increases the chance of a buffer underrun.

playdate.sound.fileplayer.new(path, \[buffersize\])

Returns a fileplayer object for streaming samples from the file at *path*. Note that the file isn’t loaded until [playdate.sound.fileplayer:play()](#m-sound.fileplayer.play) or [playdate.sound.fileplayer:setBufferSize()](#m-sound.fileplayer.setBufferSize) is called, in order to reduce initialization overhead.

If given, *buffersize* specifies the size in seconds of the fileplayer’s data buffer. A shorter value reduces the latency of a [playdate.sound.fileplayer:setOffset()](#m-sound.fileplayer.setOffset) call, but increases the chance of a buffer underrun.

playdate.sound.fileplayer:load(path)

Instructs the fileplayer to load the file at *path* when [play()](#m-sound.fileplayer.play) is called on it. The fileplayer must not be playing when this function is called. The fileplayer’s play offset is reset to the beginning of the file, and its loop range is cleared.

playdate.sound.fileplayer:play(\[repeatCount\])

Opens and starts playing the file, first creating and filling a 1/4 second playback buffer if a buffer size hasn’t been set yet.

If repeatCount is set, playback repeats when it reaches the end of the file or the end of the [loop range](#m-sound.fileplayer.setLoopRange) if one is set. After the loop has run *repeatCount* times, it continues playing to the end of the file. A *repeatCount* of zero loops endlessly. If repeatCount is not set, the file plays once.

The function returns true if the file was successfully opened and the fileplayer added to the sound channel, otherwise false and a string describing the error.

playdate.sound.fileplayer:stop()

Stops playing the file, resets the playback offset to zero, and calls the finish callback.

playdate.sound.fileplayer:pause()

Stops playing the file. A subsequent play() call resumes playback from where it was paused.

playdate.sound.fileplayer:isPlaying()

Returns a boolean indicating whether the fileplayer is playing.

playdate.sound.fileplayer:getLength()

Returns the length, in seconds, of the audio file.

playdate.sound.fileplayer:setFinishCallback(func, \[arg\])

Sets a function to be called when playback has completed. The fileplayer is passed as the first argument to *func*. The optional argument *arg* is passed as the second.

playdate.sound.fileplayer:didUnderrun()

Returns the fileplayer’s underrun flag, indicating that the player ran out of data. This can be checked in the finish callback function to check for an underrun error.

playdate.sound.fileplayer:setStopOnUnderrun(flag)

By default, if the fileplayer runs out of data it does not stop playback but instead restarts (after an audible stutter) as soon as data becomes available. Setting the flag to *true* changes this behavior so that it stops playback and calls the fileplayer’s [finish callback](#m-sound.fileplayer.setFinishCallback), if set.

playdate.sound.fileplayer:setLoopRange(start, \[end, \[loopCallback, \[arg\]\]\])

Provides a way to loop a portion of an audio file. In the following code:

```lua
local fp = playdate.sound.fileplayer.new( "myaudiofile" )
fp:setLoopRange( 10, 20 )
fp:play( 3 )
```

…the fileplayer will start playing from the beginning of the audio file, loop the 10-20 second range three times, and then stop playing.

*start* and *end* are specified in seconds. If *end* is omitted, the end of the file is used. If the function *loopCallback* is provided, it is called every time the player loops, with the fileplayer as the first argument and the optional *arg* argument as the second.

|           |                                                                                                                                                                                                          |
|-----------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Important | The [fileplayer:play(\[repeatCount\])](#m-sound.fileplayer.play) call needs to be invoked with a *repeatCount* value of 0 (infinite looping), or 2 or greater in order for the looping action to happen. |

playdate.sound.fileplayer:setLoopCallback(callback, \[arg\])

Sets a function to be called every time the fileplayer loops. The fileplayer object is passed to this function as the first argument, and *arg* as the second.

|           |                                                                                                                                                                                                             |
|-----------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Important | The [fileplayer:play(\[repeatCount\])](#m-sound.fileplayer.play) call needs to be invoked with a *repeatCount* value of 0 (infinite looping), or 2 or greater in order for the loop callback to be invoked. |

playdate.sound.fileplayer:setBufferSize(seconds)

Sets the buffer size for the fileplayer, in seconds. Larger buffers protect against buffer underruns, but consume more memory. Calling this function also fills the output buffer if a source file has been set. On success, the function returns *true*; otherwise it returns *false* and a string describing the error.

playdate.sound.fileplayer:setRate(rate)

Sets the playback rate for the file. 1.0 is normal speed, 0.5 is down an octave, 2.0 is up an octave, etc. Unlike sampleplayers, fileplayers can’t play in reverse (i.e., rate \< 0).

playdate.sound.fileplayer:getRate()

Returns the playback rate for the file. as set with `setRate()`.

playdate.sound.fileplayer:setRateMod(signal)

Sets the [signal](#C-sound.signal) to use as a rate modulator, added to the rate set with [playdate.sound.fileplayer:setRate()](#m-sound.fileplayer.setRate). Set to *nil* to clear the modulator.

playdate.sound.fileplayer:setVolume(left, \[right, \[fadeSeconds, \[fadeCallback, \[arg\]\]\]\])

Sets the playback volume (0.0 - 1.0). If a single value is passed in, both left side and right side volume are set to the given value. If two values are given, volumes are set separately. The optional *fadeSeconds* specifies the time it takes to fade from the current volume to the specified volume, in seconds. If the function *fadeCallback* is given, it is called when the volume fade has completed. The fileplayer object is passed as the first argument to the callback, and the optional *arg* argument is passed as the second.

playdate.sound.fileplayer:getVolume()

Returns the current volume for the fileplayer, a single value for mono sources or a pair of values (left, right) for stereo sources.

playdate.sound.fileplayer:setOffset(seconds)

Sets the current offset of the fileplayer, in seconds. This value is not adjusted for rate.

playdate.sound.fileplayer:getOffset()

Returns the current offset of the fileplayer, in seconds. This value is not adjusted for rate.

#### Sample

playdate.sound.sample is an abstraction of an individual sound sample. If all you want to do is play a single sound sample, you may wish to use [playdate.sound.sampleplayer](#C-sound.sampleplayer) instead. However, playdate.sound.sample exists so you can preload sounds and swap them in and out without fragmenting device memory.

playdate.sound.sample.new(path)

Returns a new playdate.sound.sample object, with the sound data loaded in memory. If the sample can’t be loaded, the function returns nil and a second value containing the error.

playdate.sound.sample.new(seconds, \[format\])

Returns a new playdate.sound.sample object, with a buffer size of *seconds* in the given format. If *format* is not specified, it defaults to [playdate.sound.kFormat16bitStereo](#m-sound.sample.getFormat). When used with playdate.sound.sample:load(), this allows you to swap in a different sample without re-allocating the buffer, which could lead to memory fragmentation.

playdate.sound.sample:getSubsample(startOffset, endOffset)

Returns a new subsample containing a subrange of the given sample. Offset values are in frames, not bytes.

playdate.sound.sample:load(path)

Loads the sound data from the file at *path* into an existing sample buffer. If there is no file at *path*, the function returns nil.

playdate.sound.sample:decompress()

If the sample is ADPCM compressed, decompresses the sample data to 16-bit PCM data. This increases the sample’s memory footprint by 4x and does not affect the quality in any way, but it is necessary if you want to use the sample in a synth or play the file backwards. Returns `true` if successful, or `false` and an error message as a second return value if decompression failed.

playdate.sound.sample:getSampleRate()

Returns the sample rate as an integer, such as 44100 or 22050.

playdate.sound.sample:getFormat()

Returns the format of the sample, one of

- *playdate.sound.kFormat8bitMono*

- *playdate.sound.kFormat8bitStereo*

- *playdate.sound.kFormat16bitMono*

- *playdate.sound.kFormat16bitStereo*

playdate.sound.sample:getLength()

Returns two values, the length of the available sample data and the size of the allocated buffer. Both values are measured in seconds. For a sample loaded from disk, these will be the same; for a sample used for recording, the available data may be less than the allocated size.

playdate.sound.sample:play(\[repeatCount\], \[rate\])

Convenience function: Creates a new sampleplayer for the sample and passes the function arguments to its [play](#m-sound.sampleplayer.play) function.

playdate.sound.sample:playAt(when, \[vol\], \[rightvol\], \[rate\])

Convenience function: Creates a new sampleplayer for the sample and passes the function arguments to its [playAt](#m-sound.sampleplayer.playAt) function.

playdate.sound.sample:save(filename)

Saves the sample to the given file. If `filename` has a `.wav` extension it will be saved in WAV format (and be unreadable by the Playdate sound functions), otherwise it will be saved in the Playdate pda format.

#### Channel

Channels are collections of sources ([synths](#C-sound.synth), [sampleplayers](#C-sound.sampleplayer), and [fileplayers](#C-sound.fileplayer)) with a list of effects to apply to the sounds, and pan and volume parameters.

playdate.sound.channel.new()

Returns a new channel object and adds it to the global list.

playdate.sound.channel:remove()

Removes the channel from the global list.

playdate.sound.channel:addEffect(effect)

Adds an [effect](#C-sound.effect) to the channel.

playdate.sound.channel:removeEffect(effect)

Removes an [effect](#C-sound.effect) from the channel.

playdate.sound.channel:addSource(source)

Adds a [source](#C-sound.source) to the channel. If a source is not assigned to a channel, it plays on the default global channel.

playdate.sound.channel:removeSource(source)

Removes a [source](#C-sound.source) from the channel.

playdate.sound.channel:setVolume(volume)

Sets the volume (0.0 - 1.0) for the channel.

playdate.sound.channel:getVolume()

Gets the volume (0.0 - 1.0) for the channel.

playdate.sound.channel:setPan(pan)

Sets the pan parameter for the channel. -1 is left, 0 is center, and 1 is right.

playdate.sound.channel:setPanMod(signal)

Sets a [signal](#C-sound.signal) to automate the pan parameter. Set to *nil* to clear the modulator.

playdate.sound.channel:setVolumeMod(signal)

Sets a [signal](#C-sound.signal) to automate the volume parameter. Set to *nil* to clear the modulator.

playdate.sound.channel:getDryLevelSignal()

Returns a [signal](#C-sound.signal) that follows the volume of the channel before effects are applied.

playdate.sound.channel:getWetLevelSignal()

Returns a [signal](#C-sound.signal) that follows the volume of the channel after effects are applied.

#### Source

*playdate.sound.source* is the parent class of our sound sources, [playdate.sound.fileplayer](#C-sound.fileplayer), [playdate.sound.sampleplayer](#C-sound.sampleplayer), [playdate.sound.synth](#C-sound.synth), and [playdate.sound.instrument](#C-sound.instrument).

playdate.sound.playingSources()

Returns a list of all sources currently playing.

#### Synth

playdate.sound.synth.new(\[waveform\])

Returns a new synth object to play a waveform or wavetable. See [playdate.sound.synth:setWaveform](#m-sound.synth.setWaveform) for `waveform` values.

playdate.sound.synth.new(sample, \[sustainStart, sustainEnd\])

Returns a new synth object to play a [Sample](#C-sound.sample). Sample data must be uncompressed PCM, not ADPCM. An optional sustain region (measured in sample frames) defines a loop to play while the note is active. When the note ends, if an envelope has been set on the synth and the sustain range goes to the end of the sample (i.e. there’s no release section of the sample after the sustain range) then the sustain section continues looping during the envelope release; otherwise it plays through the end of the sample and stops. As a convenience, if `sustainStart` is greater than zero and `sustainEnd` isn’t given, it will be set to the length of the sample.

playdate.sound.synth:copy()

Returns a copy of the given synth.

playdate.sound.synth:playNote(pitch, \[volume, \[length, \[when\]\]\])

Plays a note with the current waveform or sample.

- *pitch*: the pitch value is in Hertz. If a sample is playing, pitch=261.63 (C4) plays at normal speed

  - in either function, a string like `Db3` can be used instead of a number

- *volume*: 0 to 1, defaults to 1

- *length*: in seconds. If omitted, note will play until you call noteOff()

- *when*: seconds since the sound engine started (see [playdate.sound.getCurrentTime](#f-sound.getCurrentTime)). Defaults to the current time.

The function returns true if the synth was successfully added to the sound channel, otherwise false (i.e., if the channel is full).

If *pitch* is zero, this function calls `noteOff()` instead of potentially adding a non-zero sample, or DC offset, to the output.

|      |                                                                                                                                                                                                                                                                  |
|------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Note | Synths currently only have a buffer of one note event. If you call *playNote()* while another note is waiting to play, it will replace that note. To create a sequence of notes to play over a period of time, see [playdate.sound.sequence](#C-sound.sequence). |

playdate.sound.synth:playMIDINote(note, \[volume, \[length, \[when\]\]\])

Identical to [playNote](#m-sound.synth.playNote) but uses a note name like "C4", or MIDI note number (60=C4, 61=C#4, etc.). In the latter case, fractional values are allowed.

playdate.sound.synth:noteOff()

Releases the note, if one is playing. The note will continue to be voiced through the release section of the synth’s envelope.

playdate.sound.synth:stop()

Stops the synth immediately, without playing the release part of the envelope.

playdate.sound.synth:isPlaying()

Returns true if the synth is still playing, including the release phase of the envelope.

playdate.sound.synth:setAmplitudeMod(signal)

Sets the [signal](#C-sound.signal) to use as the amplitude modulator. Set to *nil* to clear the modulator.

playdate.sound.synth:setADSR(attack, decay, sustain, release)

Sets the attack time, decay time, sustain level, and release time for the sound envelope, and optionally the [curvature](#m-sound.synth.setEnvelopeCurvature).

playdate.sound.synth:setAttack(time)

Sets the attack time, in seconds.

playdate.sound.synth:setDecay(time)

Sets the decay time, in seconds.

playdate.sound.synth:setSustain(level)

Sets the sustain level, as a proportion of the total level (0.0 to 1.0).

playdate.sound.synth:setRelease(time)

Sets the release time, in seconds.

playdate.sound.synth:clearEnvelope()

Clears the synth’s envelope settings.

playdate.sound.synth:setEnvelopeCurvature(amount)

Smoothly changes the envelope’s shape from linear (amount=0) to exponential (amount=1).

playdate.sound.synth:getEnvelope()

Returns the synth’s envelope as a [playdate.sound.envelope](#C-sound.envelope) object.

playdate.sound.synth:setFinishCallback(function)

Sets a function to be called when the synth stops playing.

playdate.sound.synth:setFrequencyMod(signal)

Sets the [signal](#C-sound.signal) to use as the frequency modulator. Set to *nil* to clear the modulator.

playdate.sound.synth:setLegato(flag)

Sets whether to use legato phrasing for the synth. If the legato flag is set and a new note starts while a previous note is still playing, the synth’s envelope remains in the sustain phase instead of starting a new attack.

playdate.sound.synth:setVolume(left, \[right\])

Sets the synth volume. If a single value is passed in, sets both left side and right side volume to the given value. If two values are given, volumes are set separately.

Volume values are between 0.0 and 1.0.

playdate.sound.synth:getVolume()

Returns the current volume for the synth, a single value for mono sources or a pair of values (left, right) for stereo sources.

Volume values are between 0.0 and 1.0.

playdate.sound.synth:setWaveform(waveform)

Sets the waveform or [Sample](#C-sound.sample) the synth plays. If a sample is given, its data must be uncompressed PCM, not ADPCM. Otherwise *waveform* should be one of the following constants:

-  *playdate.sound.kWaveSine*

-  *playdate.sound.kWaveSquare*

-  *playdate.sound.kWaveSawtooth*

-  *playdate.sound.kWaveTriangle*

-  *playdate.sound.kWaveNoise*

-  *playdate.sound.kWavePOPhase*

-  *playdate.sound.kWavePODigital*

-  *playdate.sound.kWavePOVosim*

playdate.sound.synth:setWavetable(sample, samplesize, xsize, \[ysize\])

Sets a wavetable for the synth to play. Sample data must be 16-bit mono uncompressed. `samplesize` is the number of samples in each waveform "cell" in the table and must be a power of 2. `xsize` is the number of cells across the wavetable. If the wavetable is two-dimensional, `ysize` gives the number of cells in the y direction.

The synth’s "position" in the wavetable is set manually with [setParameter()](#m-sound.synth.setParameter) or automated with [setParameterMod()](#m-sound.synth.setParameterMod). In some cases it’s easier to use a parameter that matches the waveform position in the table, in others (notably when using envelopes and lfos) it’s more convenient to use a 0-1 scale, so there’s some redundancy here. Parameters are

- 1: x position, values are from 0 to the table width

- 2: x position, values are from 0 to 1, parameter is scaled up to table width

For 2-D tables (`rowwidth` \> 0):

- 3: y position, values are from 0 to the table height

- 4: y position, values are from 0 to 1, parameter is scaled up to table height

##### Synth parameters

Some synth types have parameters that can be set manually or driven by a signal, such as an envelope or LFO. On the square waveform the single parameter changes the pulse width; the PO synths have 2 parameters each, changing various aspects of the generator algorithm; and wavetable synths have up to four, [described above](#m-sound.synth.setWavetable).

playdate.sound.synth:setParameter(parameter, value)

Sets the parameter at (1-based) position *num* to the given value. Unless otherwise specified, *value* ranges from 0 to 1.

playdate.sound.synth:setParameterMod(parameter, signal)

Sets the [signal](#C-sound.signal) to modulate the parameter. Set to *nil* to clear the modulator.

#### Signal

*playdate.sound.signal* is the parent class of our low-frequency signals, [playdate.sound.lfo](#C-sound.lfo), [playdate.sound.envelope](#C-sound.envelope), and [playdate.sound.controlsignal](#C-sound.controlsignal). These can be used to automate certain parameters in the audio engine.

playdate.sound.signal:setOffset(offset)

Adds a constant offset to the signal (lfo, envelope, etc.).

playdate.sound.signal:setScale(scale)

Multiplies the signal’s output by the given scale factor. The scale is applied before the offset.

playdate.sound.signal:getValue()

Returns the current output value of the signal.

#### LFO

playdate.sound.lfo.new(\[type\])

Returns a new LFO object, which can be used to modulate sounds. See [playdate.sound.lfo:setType()](#m-sound.lfo.setType) for LFO types.

playdate.sound.lfo:setType(type)

Sets the waveform of the LFO. Valid values are

-  *playdate.sound.kLFOSquare*

-  *playdate.sound.kLFOSawtoothUp*

-  *playdate.sound.kLFOSawtoothDown*

-  *playdate.sound.kLFOTriangle*

-  *playdate.sound.kLFOSine*

-  *playdate.sound.kLFOSampleAndHold*

playdate.sound.lfo:setArpeggio(note1, ...)

Sets the LFO type to arpeggio, where the given values are in half-steps from the center note. For example, the sequence (0, 4, 7, 12) plays the notes of a major chord.

playdate.sound.lfo:setCenter(center)  
playdate.sound.lfo:setOffset(center)

Sets the center value of the LFO.

playdate.sound.lfo:setDepth(depth)  
playdate.sound.lfo:setScale(depth)

Sets the depth of the LFO’s modulation.

playdate.sound.lfo:setRate(rate)

Sets the rate of the LFO, in cycles per second.

playdate.sound.lfo:setPhase(phase)

Sets the current phase of the LFO, from 0 to 1.

playdate.sound.lfo:setStartPhase(phase)

Sets the initial phase of the LFO, from 0 to 1.

playdate.sound.lfo:setGlobal(flag)

If an LFO is marked global, it is continuously updated whether or not it’s attached to any source.

playdate.sound.lfo:setRetrigger(flag)

If retrigger is on, the LFO’s phase is reset to its initial phase (default 0) when a synth using the LFO starts playing a note.

playdate.sound.lfo:setDelay(holdoff, ramp)

Sets an initial holdoff time for the LFO where the LFO remains at its center value, and a ramp time where the value increases linearly to its maximum depth. Values are in seconds.

playdate.sound.lfo:getValue()

Returns the current signal value of the LFO.

#### Envelope

playdate.sound.envelope.new(\[attack, decay, sustain, release\])

Creates a new envelope with the given (optional) parameters.

playdate.sound.envelope:setAttack(attack)

Sets the envelope attack time to *attack*, in seconds.

playdate.sound.envelope:setDecay(decay)

Sets the envelope decay time to *decay*, in seconds.

playdate.sound.envelope:setSustain(sustain)

Sets the envelope sustain level to *sustain*, as a proportion of the maximum. For example, if the sustain level is 0.5, the signal value rises to its full value over the attack phase of the envelope, then drops to half its maximum over the decay phase, and remains there while the envelope is active.

playdate.sound.envelope:setRelease(release)

Sets the envelope release time to *release*, in seconds.

playdate.sound.envelope:setCurvature(amount)

Smoothly changes the envelope’s shape from linear (amount=0) to exponential (amount=1).

playdate.sound.envelope:setVelocitySensitivity(amount)

Changes the amount by which note velocity scales output level. At the default value of 1, output is proportional to velocity; at 0 velocity has no effect on output level.

playdate.sound.envelope:setRateScaling(scaling, \[start, end\])

Scales the envelope rate according to the played note. For notes below `start`, the envelope’s set rate is used; for notes above `end` envelope rates are scaled by the `scaling` parameter. Between the two notes the scaling factor is interpolated from 1.0 to `scaling`. `start` and `end` are either MIDI note numbers or names like "C4". If omitted, the default range is C1 (36) to C5 (84).

playdate.sound.envelope:setScale(scale)

Sets the scale value for the envelope. The transformed envelope has an initial value of *offset* and a maximum (minimum if *scale* is negative) of *offset* + *scale*.

playdate.sound.envelope:setOffset(offset)

Sets the offset value for the envelope. The transformed envelope has an initial value of *offset* and a maximum (minimum if *scale* is negative) of *offset* + *scale*.

playdate.sound.envelope:setLegato(flag)

Sets whether to use legato phrasing for the envelope. If the legato flag is set, when the envelope is re-triggered before it’s released, it remains in the sustain phase instead of jumping back to the attack phase.

playdate.sound.envelope:setRetrigger(flag)

If retrigger is on, the envelope always starts from 0 when a note starts playing, instead of the current value if it’s active.

playdate.sound.envelope:trigger(velocity, \[length\])

Triggers the envelope at the given *velocity*. If a *length* parameter is given, the envelope moves to the release phase after the given time. Otherwise, the envelope is held in the sustain phase until the trigger function is called again with *velocity* equal to zero.

playdate.sound.envelope:setGlobal(flag)

If an envelope is marked global, it is continuously updated whether or not it’s attached to any source.

playdate.sound.envelope:getValue()

Returns the current signal value of the envelope.

#### Effects

*playdate.sound.effect* is the parent class of our sound effects, [playdate.sound.bitcrusher](#C-sound.bitcrusher), [playdate.sound.twopolefilter](#C-sound.twopolefilter), [playdate.sound.onepolefilter](#C-sound.onepolefilter), [playdate.sound.ringmod](#C-sound.ringmod), [playdate.sound.overdrive](#C-sound.overdrive), and [playdate.sound.delayline](#C-sound.delayline)

playdate.sound.addEffect(effect)

Adds the given [playdate.sound.effect](#C-sound.effect) to the default sound channel.

playdate.sound.removeEffect(effect)

Removes the given effect from the default sound channel.

#### Bitcrusher

playdate.sound.bitcrusher.new()

Creates a new bitcrusher filter.

playdate.sound.bitcrusher:setMix(level)

Sets the wet/dry mix for the effect. A level of 1 (full wet) replaces the input with the effect output; 0 leaves the effect out of the mix.

playdate.sound.bitcrusher:setMixMod(signal)

Sets a [signal](#C-sound.signal) to modulate the mix level. Set to *nil* to clear the modulator.

playdate.sound.bitcrusher:setAmount(amt)

Sets the amount of crushing to *amt*. Valid values are 0 (no effect) to 1 (quantizing output to 1-bit).

playdate.sound.bitcrusher:setAmountMod(signal)

Sets a [signal](#C-sound.signal) to modulate the filter level. Set to *nil* to clear the modulator.

playdate.sound.bitcrusher:setUndersampling(amt)

Sets the number of samples to repeat; 0 is no undersampling, 1 effectively halves the sample rate.

playdate.sound.bitcrusher:setUndersamplingMod(signal)

Sets a [signal](#C-sound.signal) to modulate the filter level. Set to *nil* to clear the modulator.

#### Ring Modulator

playdate.sound.ringmod.new()

Creates a new ring modulator filter.

playdate.sound.ringmod:setMix(level)

Sets the wet/dry mix for the effect. A level of 1 (full wet) replaces the input with the effect output; 0 leaves the effect out of the mix.

playdate.sound.ringmod:setMixMod(signal)

Sets a [signal](#C-sound.signal) to modulate the mix level. Set to *nil* to clear the modulator.

playdate.sound.ringmod:setFrequency(f)

Sets the ringmod frequency to *f*.

playdate.sound.ringmod:setFrequencyMod(signal)

Sets a [signal](#C-sound.signal) to modulate the ringmod frequency. Set to *nil* to clear the modulator.

#### One pole filter

The one pole filter is a simple low/high pass filter, with a single parameter describing the cutoff frequency: values above 0 (up to 1) are high-pass, values below 0 (down to -1) are low-pass.

playdate.sound.onepolefilter.new()

Returns a new one pole filter.

playdate.sound.onepolefilter:setMix(level)

Sets the wet/dry mix for the effect. A level of 1 (full wet) replaces the input with the effect output; 0 leaves the effect out of the mix.

playdate.sound.onepolefilter:setMixMod(signal)

Sets a [signal](#C-sound.signal) to modulate the mix level. Set to *nil* to clear the modulator.

playdate.sound.onepolefilter:setParameter(p)

Sets the filter’s single parameter (cutoff frequency) to *p*.

playdate.sound.onepolefilter:setParameterMod(m)

Sets a modulator for the filter’s parameter. Set to *nil* to clear the modulator.

#### Two pole filter

playdate.sound.twopolefilter.new(type)

Creates a new two pole IIR filter of the given *type*:

-  *playdate.sound.kFilterLowPass* (or the string "lowpass" or "lopass")

-  *playdate.sound.kFilterHighPass* (or "highpass" or "hipass")

-  *playdate.sound.kFilterBandPass* (or "bandpass")

-  *playdate.sound.kFilterNotch* (or "notch")

-  *playdate.sound.kFilterPEQ* (or "peq")

-  *playdate.sound.kFilterLowShelf* (or "lowshelf" or "loshelf")

-  *playdate.sound.kFilterHighShelf* (or "highshelf" or "hishelf")

playdate.sound.twopolefilter:setMix(level)

Sets the wet/dry mix for the effect. A level of 1 (full wet) replaces the input with the effect output; 0 leaves the effect out of the mix.

playdate.sound.twopolefilter:setMixMod(signal)

Sets a [signal](#C-sound.signal) to modulate the mix level. Set to *nil* to clear the modulator.

playdate.sound.twopolefilter:setFrequency(f)

Sets the center frequency (in Hz) of the filter to *f*.

playdate.sound.twopolefilter:setFrequencyMod(signal)

Sets a [signal](#C-sound.signal) to modulate the filter frequency. Set to *nil* to clear the modulator.

playdate.sound.twopolefilter:setResonance(r)

Sets the resonance of the filter to *r*. Valid values are in the range 0-1. This parameter has no effect on shelf type filters.

playdate.sound.twopolefilter:setResonanceMod(signal)

Sets a [signal](#C-sound.signal) to modulate the filter resonance. Set to *nil* to clear the modulator.

playdate.sound.twopolefilter:setGain(g)

Sets the gain of the filter to *g*. Gain is only used in PEQ and shelf type filters.

playdate.sound.twopolefilter:setType(type)

Sets the type of the filter to *type*.

#### Overdrive

playdate.sound.overdrive.new()

Creates a new overdrive effect.

playdate.sound.overdrive:setMix(level)

Sets the wet/dry mix for the effect. A level of 1 (full wet) replaces the input with the effect output; 0 leaves the effect out of the mix.

playdate.sound.overdrive:setMixMod(signal)

Sets a [signal](#C-sound.signal) to modulate the mix level. Set to *nil* to clear the modulator.

playdate.sound.overdrive:setGain(level)

Sets the gain of the filter.

playdate.sound.overdrive:setLimit(level)

Sets the level where the amplified input clips.

playdate.sound.overdrive:setLimitMod(signal)

Sets a [signal](#C-sound.signal) to modulate the limit level. Set to *nil* to clear the modulator.

playdate.sound.overdrive:setOffset(level)

Adds an offset to the upper and lower limits to create an asymmetric clipping.

playdate.sound.overdrive:setOffsetMod(signal)

Sets a [signal](#C-sound.signal) to modulate the offset value. Set to *nil* to clear the modulator.

#### Delay line

playdate.sound.delayline.new(length)

Creates a new delay line effect, with the given length (in seconds).

playdate.sound.delayline:setMix(level)

Sets the wet/dry mix for the effect. A level of 1 (full wet) replaces the input with the effect output; 0 leaves the effect out of the mix, which is useful if you’re using taps for varying delays.

playdate.sound.delayline:setMixMod(signal)

Sets a [signal](#C-sound.signal) to modulate the mix level. Set to *nil* to clear the modulator.

playdate.sound.delayline:addTap(delay)

Returns a new [playdate.sound.delaylinetap](#C-sound.delaylinetap) on the delay line, at the given delay (which must be less than or equal to the delay line’s length).

playdate.sound.delayline:setFeedback(level)

Sets the feedback level of the delay line.

#### Delay line tap

*playdate.sound.delaylinetap* is a subclass of *playdate.sound.source*. Note that a tap can be added to any channel, not just the channel the tap’s delay line is on.

playdate.sound.delaylinetap:setDelay(time)

Sets the position of the tap on the delay line, up to the delay line’s length.

playdate.sound.delaylinetap:setDelayMod(signal)

Sets a [signal](#C-sound.signal) to modulate the tap delay. If the signal is continuous (e.g. an envelope or a triangle LFO, but not a square LFO) playback is sped up or slowed down to compress or expand time. Set to *nil* to clear the modulator.

playdate.sound.delaylinetap:setVolume(level)

Sets the tap’s volume.

playdate.sound.delaylinetap:getVolume()

Returns the tap’s volume.

playdate.sound.delaylinetap:setFlipChannels(flag)

If set and the delay line is stereo, the tap outputs the delay line’s left channel to its right output and vice versa.

#### Sequence

playdate.sound.sequence.new(\[midi_path\])

Creates a new sound sequence. If `midi_path` is given, it attempts to load data from the midi file into the sequence.

playdate.sound.sequence:play(\[finishCallback\])

Starts playing the sequence. `finishCallback` is an optional function to be called when the sequence finishes playing or is stopped. The sequence is passed to the callback as its single argument.

playdate.sound.sequence:stop()

Stops playing the sequence.

playdate.sound.sequence:isPlaying()

Returns true if the sequence is currently playing.

playdate.sound.sequence:getLength()

Returns the length of the longest track in the sequence, in steps. See also [playdate.sound.track.getLength()](#m-sound.track.getLength).

playdate.sound.sequence:goToStep(step, \[play\])

Moves the play position for the sequence to step number `step`. If `play` is set, triggers the notes at that step.

playdate.sound.sequence:getCurrentStep()

Returns the step number the sequence is currently at.

playdate.sound.sequence:setTempo(stepsPerSecond)

Sets the tempo of the sequence, in steps per second.

playdate.sound.sequence:getTempo()

Returns the tempo of the sequence, in steps per second.

playdate.sound.sequence:setLoops(startStep, endStep, \[loopCount\])

Sets the looping range of the sequence. If *loops* is 0 or unset, the loop repeats endlessly.

playdate.sound.sequence:setLoops(loopCount)

Same as above, with startStep set to 0 and endStep set to `sequence:getLength()`.

playdate.sound.sequence:getTrackCount()

Returns the number of tracks in the sequence.

playdate.sound.sequence:addTrack(\[track\])

Adds the given [playdate.sound.track](#C-sound.track) to the sequence. If `track` omitted, the function creates and returns a new track.

playdate.sound.sequence:setTrackAtIndex(n, track)

Sets the given [playdate.sound.track](#C-sound.track) object at position `n` in the sequence.

playdate.sound.sequence:getTrackAtIndex(n)

Returns the [playdate.sound.track](#C-sound.track) object at position `n` in the sequence.

playdate.sound.sequence:allNotesOff()

Sends an [allNotesOff()](#m-sound.instrument.allNotesOff) message to each track’s instrument.

#### Track

playdate.sound.track.new()

Creates a new `playdate.sound.track` object.

playdate.sound.track:addNote(step, note, length, \[velocity\])  
playdate.sound.track:addNote(table)

Adds a single note event to the track, letting you specify `step`, `note`, `length`, and `velocity` directly. The second format allows you to pack them into a table, using the format returned by [getNotes()](#m-sound.track.getNotes). The `note` argument can be a MIDI note number or a note name like "Db3". `length` is the length of the note in steps, not time—​that is, it follows the sequence’s tempo. The default velocity is 1.0.

See [setNotes()](#m-sound.track.setNotes) for the ability to add more than one note at a time.

playdate.sound.track:setNotes(list)

Set multiple notes at once, each array element should be a table containing values for the keys The tables contain values for keys `step`, `note`, `length`, and `velocity`.

playdate.sound.track:getNotes(\[step\], \[endstep\])

Returns an array of tables representing the note events in the track.

The tables contain values for keys `step`, `note`, `length`, and `velocity`. If `step` is given, the function returns only the notes at that step; if both `step` and `endstep` are set, it returns the notes between the two steps (including notes at endstep). n.b. The `note` field in the event tables is always a MIDI note number value, even if the note was added using the string notation.

playdate.sound.track:removeNote(step, note)

Removes the note event at *step* playing *note*.

playdate.sound.track:clearNotes()

Clears all notes from the track.

playdate.sound.track:getLength()

Returns the length, in steps, of the track—​that is, the step where the last note in the track ends.

playdate.sound.track:getNotesActive()

Returns the current number of notes active in the track.

playdate.sound.track:getPolyphony()

Returns the maximum number of notes simultaneously active in the track. (Known bug: this currently only works for midi files)

playdate.sound.track:setInstrument(inst)

Sets the [playdate.sound.instrument](#C-sound.instrument) that this track plays. If `inst` is a [playdate.sound.synth](#C-sound.synth), the function creates an instrument for the synth.

playdate.sound.track:getInstrument()

Gets the [playdate.sound.instrument](#C-sound.instrument) that this track plays.

playdate.sound.track:setMuted(flag)

Mutes or unmutes the track.

playdate.sound.track:addControlSignal(s)

Adds a [playdate.sound.controlsignal](#C-sound.controlsignal) object to the track. Note that the signal must be assigned to a modulation input for it to have any audible effect. The input can be anywhere in the sound engine—​it’s not required to belong to the track in any way.

playdate.sound.track:getControlSignals()

Returns an array of [playdate.sound.controlsignal](#C-sound.controlsignal) objects assigned to this track.

#### Instrument

playdate.sound.instrument.new(\[synth\])

Creates a new `playdate.sound.instrument` object. If `synth` is given, adds it as a voice for the instrument.

playdate.sound.instrument:addVoice(v, \[note\], \[rangeend\], \[transpose\])

Adds the given [playdate.sound.synth](#C-sound.synth) to the instrument. If only the *note* argument is given, the voice is only used for that note, and is transposed to play at normal speed (i.e. rate=1.0 for samples, or C4 for synths). If *rangeend* is given, the voice is assigned to the range *note* to *rangeend*, inclusive, with the first note in the range transposed to rate=1.0/C4. The `note` and `rangeend` arguments can be MIDI note numbers or note names like "Db3". The final transpose argument transposes the note played, in half-tone units.

playdate.sound.instrument:setPitchBend(amount)

Sets the pitch bend to be applied to the voices in the instrument, as a fraction of the full range.

playdate.sound.instrument:setPitchBendRange(halfsteps)

Sets the pitch bend range for the voices in the instrument. The default range is 12, for a full octave.

playdate.sound.instrument:setTranspose(halfsteps)

Transposes all voices in the instrument. *halfsteps* can be a fractional value.

playdate.sound.instrument:playNote(frequency, \[vel\], \[length\], \[when\])

Plays the given note on the instrument. A string like `Db3` can be used instead of a pitch/note number. Fractional values are allowed. *vel* defaults to 1.0, fully on. If *length* isn’t specified, the note stays on until *instrument.noteOff(note)* is called. *when* is the number of seconds in the future to start playing the note, default is immediately.

playdate.sound.instrument:playMIDINote(note, \[vel\], \[length\], \[when\])

Identical to `instrument:playNote()` but *note* is a MIDI note number: 60=C4, 61=C#4, etc. Fractional values are allowed.

playdate.sound.instrument:noteOff(note, \[when\])

Stops the instrument voice playing note *note*. If *when* is given, the note is stopped *when* seconds in the future, otherwise it’s stopped immediately.

playdate.sound.instrument:allNotesOff()

Sends a stop signal to all playing notes.

playdate.sound.instrument:setVolume(left, \[right\])

Sets the instrument volume. If a single value is passed in, sets both left side and right side volume to the given value. If two values are given, volumes are set separately.

Volume values are between 0.0 and 1.0.

playdate.sound.instrument:getVolume()

Returns the current volume for the synth, a single value for mono sources or a pair of values (left, right) for stereo sources.

Volume values are between 0.0 and 1.0.

#### Control Signal

playdate.sound.controlsignal.new()

Creates a new control signal object, for automating effect parameters, channel pan and level, etc.

playdate.sound.controlsignal.events

The signal’s event list is modified by getting and setting the `events` property of the object. This is an array of tables, each containing values for keys `step` and `value`, and optionally `interpolate`.

playdate.sound.controlsignal:addEvent(step, value, \[interpolate\])  
playdate.sound.controlsignal:addEvent(event)

`addEvent` is a simpler way of adding events one at a time than setting the entire *events* table. Arguments are either the values themselves in the given order, or a table containing values for `step`, `value`, and optionally `interpolate`. If `interpolate` is set, the signal’s output value is linearly interpolated from `value` at step `step` to the next event’s value at its given step.

playdate.sound.controlsignal:clearEvents()

Clears all events from the control signal.

playdate.sound.controlsignal:setControllerType(number)

Sets the midi controller number for the control signal, if that’s something you want to do. The value has no effect on playback.

playdate.sound.controlsignal:getControllerType()

Control signals in midi files are assigned a controller number, which describes the intent of the control. This function returns the controller number.

playdate.sound.controlsignal:setScale(scale)

Sets the scale value for the control signal.

playdate.sound.controlsignal:setOffset(offset)

Sets the offset value for the control signal.

playdate.sound.controlsignal:getValue()

Returns the current output value of the control signal.

#### Mic Input

playdate.sound.micinput.recordToSample(buffer, completionCallback)

`buffer` should be a [Sample](#C-sound.sample) created with the following code, with *secondsToRecord* replaced by a number specifying the record duration:

```lua
local buffer = playdate.sound.sample.new(_secondsToRecord_, playdate.sound.kFormat16bitMono)
```

`completionCallback` is a function called at the end of recording, when the buffer is full. It has one argument, the recorded sample. To override the device’s headset detection and force recording from either the internal mic or a headset mic or line in connected to a headset splitter, first call [playdate.sound.micinput.startListening()](#f-sound.micinput.startListening) with the required source. `recordToSample()` returns `true` on success, `false` on error.

playdate.sound.micinput.stopRecording()

Stops a sample recording started with recordToSample, if it hasn’t already reached the end of the buffer. The recording’s completion callback is called immediately.

playdate.sound.micinput.startListening(\[source\])

Starts monitoring the microphone input level. The optional *source* argument of "headset" or "device" causes the mic input to record from the given source. If no source is given, it uses the headset detection circuit to determine which source to use. The function returns the pair `true` and a string indicating which source it’s recording from on success, or `false` on error.

playdate.sound.micinput.stopListening()

Stops monitoring the microphone input level.

playdate.sound.micinput.getLevel()

Returns the current microphone input level, a value from 0.0 (quietest) to 1.0 (loudest).

playdate.sound.micinput.getSource()

Returns the current microphone input source, either "headset" or "device".

#### Audio Output

playdate.sound.getHeadphoneState(changeCallback)

Returns a pair of booleans (headphone, mic) indicating whether headphones are plugged in, and if so whether they have a microphone attached. If *changeCallback* is a function, it will be called every time the headphone state changes, until it is cleared by calling `playdate.sound.getHeadphoneState(nil)`. If a change callback is set, the audio does **not** automatically switch from speaker to headphones when headphones are plugged in (and vice versa), so the callback should use `playdate.sound.setOutputsActive()` to change the output if needed. The callback is passed two booleans, matching the return values from `getHeadphoneState()`: the first `true` if headphones are connect, and the second `true` if the headphones have a microphone.

Equivalent to [`playdate->sound->getHeadphoneState()`](./Inside%20Playdate%20with%20C.html#f-sound.getHeadphoneState) in the C API.

playdate.sound.setOutputsActive(headphones, speaker)

Forces sound to be played on the headphones or on the speaker, regardless of whether headphones are plugged in or not. (With the caveat that it is not actually possible to play on the headphones if they’re not plugged in.) This function has no effect in the Simulator.

Equivalent to [`playdate->sound->setOutputsActive()`](./Inside%20Playdate%20with%20C.html#f-sound.setOutputsActive) in the C API.

#### Audio Device Time

playdate.sound.getCurrentTime()

Returns the current time, in seconds, as measured by the audio device. The audio device uses its own time base in order to provide accurate timing.

Equivalent to [`playdate->sound->getCurrentTime()`](./Inside%20Playdate%20with%20C.html#f-sound.getCurrentTime) in the C API.

playdate.sound.resetTime()

Resets the audio output device time counter.

### 7.29. Strings

|           |                                                           |
|-----------|-----------------------------------------------------------|
| Important | You must import *CoreLibs/string* to use these functions. |

playdate.string.UUID(length)

Generates a random string of uppercase letters

playdate.string.trimWhitespace(string)

Returns a string with the whitespace removed from the beginning and ending of *string*.

playdate.string.trimLeadingWhitespace(string)

Returns a string with the whitespace removed from the beginning of *string*.

playdate.string.trimTrailingWhitespace(string)

Returns a string with the whitespace removed from the ending of *string*.

### 7.30. Timers

playdate.timer provides a time-based timer useful for handling animation timings, countdowns, or performing tasks after a delay. For a frame-based timer see [playdate.frameTimer](#C-frameTimer).

|           |                                                                                                                                                                                                                                                       |
|-----------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Important | You must import *CoreLibs/timer* to use these functions. It is **also** to critical to call [playdate.timer.updateTimers()](#f-timer.updateTimers) in your [playdate.update()](#c-update) function to ensure that all timers are updated every frame. |

playdate.timer.updateTimers()

This should be called from the main playdate.update() loop to drive the timers.

#### Standard timers

playdate.timer.new(duration, callback, ...)

Returns a new playdate.timer that will run for *duration* milliseconds. *callback* is a function closure that will be called when the timer is complete.

Accepts a variable number of arguments that will be passed to the callback function when it is called. If arguments are not provided, the timer itself will be passed to the callback instead.

By default, timers start upon instantiation. To modify the behavior of a timer, see [common timer methods](#C-commonTimerMethods) and [properties](#C-commonTimerProperties).

#### Delay timers

playdate.timer.performAfterDelay(delay, callback, ...)

Performs the function *callback* after *delay* milliseconds. Accepts a variable number of arguments that will be passed to the callback function when it is called. If arguments are not provided, the timer itself will be passed to the callback instead.

#### Value timers

playdate.timer.new(duration, \[startValue, endValue, \[easingFunction\]\])

Returns a new playdate.timer that will run for *duration* milliseconds. If not specified, *startValue* and *endValue* will be 0, and a linear easing function will be used.

By default, timers start upon instantiation. To modify the behavior of a timer, see [common timer methods](#C-commonTimerMethods) and [properties](#C-commonTimerProperties).

playdate.timer.value

Current value calculated from the start and end values, the time elapsed, and the easing function.

playdate.timer.easingFunction

The function used to calculate *value*. The function should be of the form *function(t, b, c, d)*, where *t* is elapsed time, *b* is the beginning value, *c* is the change (or end value - start value), and *d* is the duration. Many such functions are available in [playdate.easingFunctions](#M-easingFunctions).

playdate.timer.easingAmplitude  
playdate.timer.easingPeriod

For [easing functions](#M-easingFunctions) that take additional amplitude and period arguments (such as *inOutElastic*), set these to the desired values.

playdate.timer.reverseEasingFunction

Set to provide an easing function to be used for the reverse portion of the timer. The function should be of the form *function(t, b, c, d)*, where *t* is elapsed time, *b* is the beginning value, *c* is the change (or end value - start value), and *d* is the duration. Many such functions are available in [playdate.easingFunctions](#M-easingFunctions).

playdate.timer.startValue

Start value used when calculating *value*.

playdate.timer.endValue

End value used when calculating *value*.

#### Key repeat timers

playdate.timer.keyRepeatTimer(callback, ...)

Calls `keyRepeatTimerWithDelay()` below with standard values of *delayAfterInitialFiring* = 300 and *delayAfterSecondFiring* = 100.

playdate.timer.keyRepeatTimerWithDelay(delayAfterInitialFiring, delayAfterSecondFiring, callback, ...)

returns a timer that fires at key-repeat intervals. The function *callback* will be called immediately, then again after *delayAfterInitialFiring* milliseconds, then repeatedly at *delayAfterSecondFiring* millisecond intervals.

Both functions accept any number of arguments; those arguments will be passed to the callback function when it is called. If arguments are not provided, the timer itself will be passed instead.

Sample keyRepeatTimer callback

```lua
import "CoreLibs/timer"

local keyTimer = nil

function playdate.BButtonDown()
    local function timerCallback()
        print("key repeat timer fired!")
    end
    keyTimer = playdate.timer.keyRepeatTimer(timerCallback)
end

function playdate.BButtonUp()
    keyTimer:remove()
end

function playdate.update()
    playdate.timer.updateTimers()
end
```

#### Common timer methods

playdate.timer:pause()

Pauses a timer. (There is no need to call :start() on a newly-instantiated timer: timers start automatically.)

playdate.timer:start()

Resumes a previously paused timer. There is no need to call :start() on a newly-instantiated timer: timers start automatically.

playdate.timer:remove()

Removes this timer from the list of timers. This happens automatically when a non-repeating timer reaches its end, but you can use this method to dispose of timers manually.

Note that timers do not actually get removed until the next invocation of [playdate.timer.updateTimers()](#f-timer.updateTimers).

playdate.timer:reset()

Resets a timer to its initial values.

playdate.timer.allTimers()

Returns an array listing all running timers.

|      |                                                                                      |
|------|--------------------------------------------------------------------------------------|
| Note | Note the "." syntax rather than ":". This is a class method, not an instance method. |

#### Common timer properties

playdate.timer.currentTime

The number of milliseconds the timer has been running. Read-only.

playdate.timer.delay

Number of milliseconds to wait before starting the timer.

playdate.timer.discardOnCompletion

If true, the timer is discarded once it is complete. Defaults to true.

playdate.timer.duration

The number of milliseconds for which the timer will run.

playdate.timer.timeLeft

The number of milliseconds remaining in the timer. Read-only.

playdate.timer.paused

If true, the timer will be paused. The update callback will not be called when the timer is paused. Can be set directly, or by using `playdate.timer:pause()` and `playdate.timer:start()`. Defaults to false.

playdate.timer.repeats

If true, the timer starts over from the beginning when it completes. Defaults to false.

playdate.timer.reverses

If true, the timer plays in reverse once it has completed. The time to complete both the forward and reverse will be *duration* x 2. Defaults to false.

Please note that *currentTime* will restart at 0 and count up to *duration* again when the reverse timer starts, but *value* will be calculated in reverse, from *endValue* to *startValue*. The same easing function (as opposed to the inverse of the easing function) will be used for the reverse timer unless an alternate is provided by setting *reverseEasingFunction*.

playdate.timer.timerEndedCallback

A Function of the form *function(timer)* or *function(...)* where "..." corresponds to the values in the table assigned to *timerEndedArgs*. Called when the timer has completed.

playdate.timer.timerEndedArgs

For repeating timers, this function will be called each time the timer completes, before it starts again.

An array-style table of values that will be passed to the *timerEndedCallback* function.

playdate.timer.updateCallback

A callback function that will be called on every frame (every time *timer.updateAll()* is called). If the timer was created with arguments, those will be passed as arguments to the function provided. Otherwise, the timer is passed as the single argument.

#### Timer sample code

To count milliseconds, a simple timer can be created as follows:

    t = playdate.timer.new(1000)

The timer will begin running immediately. The current time can be read by looking at *t.currentTime*.

To transition between two values, set up a timer like:

    t = timer(500, 0, 100)

If no easing function is provided as a fourth argument linear easing will be used. As the timer runs, you can access the current value by looking at *t.value*.

In both of these examples, the timer will be automatically discarded once it is finished. Set *discardOnCompletion* to false to keep the timer around for later reuse.

An example of setting up a bouncing ball animation (assuming the ball would be drawn elsewhere based on the rectangle *r*):

    local r = playdate.geometry.rect.new(100, 10, 40, 40)

    local t = playdate.timer.new(1000, 10, 150, easingFunctions.inCubic)
    t.reverses = true
    t.repeats = true
    t.reverseEasingFunction = easingFunctions.outQuad
    t.updateCallback = function(timer)
        r.y = timer.value
    end

### 7.31. Frame timers

A frame-based timer useful for handling frame-precise animation timings. For a time-based timer see [playdate.timer](#C-timer) or [playdate.graphics.animation.loop](#C-graphics.animation.loop)

|           |                                                                                                                                                                                                                                                                 |
|-----------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Important | You must import *CoreLibs/frameTimer* to use these functions. It is **also** to critical to call [playdate.frameTimer.updateTimers()](#f-timer.updateTimers) in your [playdate.update()](#c-update) function to ensure that all timers are updated every frame. |

playdate.frameTimer.updateTimers()

This should be called from the main playdate.update() loop to drive the frame timers.

#### Standard frame timers

playdate.frameTimer.new(duration, callback, ...)

Returns a new playdate.frameTimer that will run for *duration* frames. *callback* is a function closure that will be called when the timer is complete.

Accepts a variable number of arguments that will be passed to the callback function when it is called. If arguments are not provided, the timer itself will be passed to the callback instead.

By default, frame timers start upon instantiation. To modify the behavior of a frame timer, see [common frame timer methods](#C-commonFrameTimerMethods) and [properties](#C-commonFrameTimerProperties).

#### Delay frame timers

playdate.frameTimer.performAfterDelay(delay, callback, ...)

Performs the function *callback* after the *delay* number of frames. Accepts a variable number of arguments that will be passed to the callback function when it is called. If arguments are not provided, the timer itself will be passed to the callback instead.

#### Value frame timers

playdate.frameTimer.new(duration, \[startValue, endValue, \[easingFunction\]\])

Returns a new playdate.frameTimer that will run for *duration* number of frames. If not specified, *startValue* and *endValue* will be 0, and a linear easing function will be used.

By default, frame timers start upon instantiation. To modify the behavior of a frame timer, see [common frame timer methods](#C-commonFrameTimerMethods) and [properties](#C-commonFrameTimerProperties).

playdate.frameTimer.value

Current value calculated from the start and end values, the current frame, and the easing function.

playdate.frameTimer.startValue

Start value used when calculating *value*.

playdate.frameTimer.endValue

End value used when calculating *value*.

playdate.frameTimer.easingFunction

The function used to calculate *value*. The function should be of the form *function(t, b, c, d)*, where *t* is elapsed time, *b* is the beginning value, *c* is the change (or *endValue - startValue*), and *d* is the duration.

playdate.frameTimer.easingAmplitude  
playdate.frameTimer.easingPeriod

For easing functions in *CoreLibs/easing* that take additional amplitude and period arguments (such as *inOutElastic*), set these to desired values.

playdate.frameTimer.reverseEasingFunction

Set to provide an easing function to be used for the reverse portion of the timer. The function should be of the form *function(t, b, c, d)*, where *t* is elapsed time, *b* is the beginning value, *c* is the change (or *endValue - startValue*), and *d* is the duration.

#### Common frame timer methods

playdate.frameTimer:pause()

Pauses a timer.

playdate.frameTimer:start()

Resumes a timer. There is no need to call :start() on a newly-instantiated frame timer: frame timers start automatically.

playdate.frameTimer:remove()

Removes this timer from the list of timers. This happens automatically when a non-repeating timer reaches it’s end, but you can use this method to dispose of timers manually.

playdate.frameTimer:reset()

Resets a timer to its initial values.

playdate.frameTimer.allTimers()

Returns an array listing all running frameTimers.

|      |                                                                                      |
|------|--------------------------------------------------------------------------------------|
| Note | Note the "." syntax rather than ":". This is a class method, not an instance method. |

#### Common frame timer properties

playdate.frameTimer.delay

Number of frames to wait before starting the timer.

playdate.frameTimer.discardOnCompletion

If true, the timer is discarded once it is complete. Defaults to true.

playdate.frameTimer.duration

The number of frames for which the timer will run.

playdate.frameTimer.frame

The current frame.

playdate.frameTimer.repeats

If true, the timer starts over from the beginning when it completes. Defaults to false.

playdate.frameTimer.reverses

If true, the timer plays in reverse once it has completed. The number of frames to complete both the forward and reverse will be *duration x 2*. Defaults to false.

Please note that the frame counter will restart at 0 and count up to *duration* again when the reverse timer starts, but *value* will be calculated in reverse, from *endValue* to *startValue*. The same easing function (as opposed to the inverse of the easing function) will be used for the reverse timer unless an alternate is provided by setting *reverseEasingFunction*.

playdate.frameTimer.timerEndedCallback

A Function of the form *function(timer)* or *function(...)* where "..." corresponds to the values in the table assigned to *timerEndedArgs*. Called when the timer has completed.

playdate.frameTimer.timerEndedArgs

For repeating timers, this function will be called each time the timer completes, before it starts again.

An array-style table of values that will be passed to the *timerEndedCallback* function.

playdate.frameTimer.updateCallback

A function to be called on every frame update. If the frame timer was created with arguments, those will be passed as arguments to the function provided. Otherwise, the timer is passed as the single argument.

#### Frame timer sample code

To count frames a simple timer can be created as follows:

```lua
t = playdate.frameTimer.new(200)
```

The timer will begin running immediately, and the current frame can be read by looking at *t.frame*.

To transition between two values, set up a timer like:

```lua
t = FrameTimer(50, 0, 100)
```

If no easing function is provided as a fourth argument linear easing will be used. As the timer runs, you can access the current value by looking at *t.value*.

In both of these examples, the timer will be automatically discarded once it is finished. Set *discardOnCompletion* to false to keep the timer around for later reuse.

An example of setting up a bouncing ball animation (assuming the ball would be drawn elsewhere based on the rectangle *r*):

```lua
local r = playdate.geometry.rect.new(100, 10, 40, 40)

local t = playdate.frameTimer.new(20, 10, 150, playdate.easingFunctions.inCubic)
t.reverses = true
t.repeats = true
t.reverseEasingFunction = playdate.easingFunctions.outQuad
t.updateCallback = function(timer)
    r.y = timer.value
end
```

### 7.32. UI components

playdate.ui provides common UI elements for playdate games.

#### Crank indicator

`playdate.ui.crankIndicator` is used to draw a standard indicator at the lower right corner of the screen that directs the player to use the crank.

As your game calls [`playdate.ui.crankIndicator:draw()`](#m-ui.crankIndicator.draw) on successive frames, the Playdate screen will display a "Use the Crank" message for ~0.7 seconds, then an animation of a rotating crank for ~1.4 seconds. (The direction of animation is specified by [`.clockwise`](#v-ui.crankIndicator.clockwise).)

In some situations you may only want to alert the player to "use the crank" if [`playdate.isCrankDocked()`](#f-isCrankDocked) returns `true`, indicating that the crank is not extended.

|           |                                                                                                                                                                                                      |
|-----------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Important | You must import *CoreLibs/ui* to use crankIndicator. There is no need to instantiate a crankIndicator object; `playdate.ui.crankIndicator` automatically returns the shared crankIndicator instance. |

playdate.ui.crankIndicator:draw(\[xOffset, yOffset\])

Draws the next frame of the crank indicator animation, and is typically invoked in the [`playdate.update()`](#c-update) callback. *xOffset* and *yOffset* can be used to alter the position of the indicator by a specified number of pixels if desired. To stop drawing the crank indicator, simply stop calling `:draw()` in `playdate.update()`.

Note that if sprites are being used, this call should usually happen after [playdate.graphics.sprite.update()](#f-graphics.sprite.update).

playdate.ui.crankIndicator.clockwise

Boolean property specifying which direction to animate the crank. Defaults to true.

playdate.ui.crankIndicator:resetAnimation()

Resets the crank animation to the beginning of its sequence.

playdate.ui.crankIndicator:getBounds()

Returns *x*, *y*, *width*, *height* representing the bounds that the crank indicator draws within. If necessary, this rect could be passed into [playdate.graphics.sprite.addDirtyRect()](#m-graphics.sprite.addDirtyRect), or used to manually draw over the indicator image drawn by [playdate.ui.crankIndicator:draw()](#m-crankIndicator.draw) when you want to stop showing the crank indicator.

#### Grid view

playdate.ui.gridview provides a means for drawing a grid view composed of cells, and optionally sections with section headers.

|           |                                                |
|-----------|------------------------------------------------|
| Important | You must import *CoreLibs/ui* to use gridview. |

Some notes:

- playdate.ui.gridview uses [playdate.timer](#C-timer) internally, so [playdate.timer.updateTimers()](#f-timer.updateTimers) must be called in the main [playdate.update()](#c-update) function.

- If the gridview’s cell width is set to 0, cells will be drawn the same width as the table (minus any padding).

- Section headers always draw the full width of the grid (minus padding), and do not scroll horizontally along with the rest of the content.

playdate.ui.gridview.new(cellWidth, cellHeight)

Returns a new [playdate.ui.gridview](#C-ui.gridview) with cells sized *cellWidth*, *cellHeight*. (Sizes are in pixels.) If cells should span the entire width of the grid (as in a list view), pass zero (0) for *cellWidth*.

##### Drawing

playdate.ui.gridview:drawCell(section, row, column, selected, x, y, width, height)

Override this method to draw the cells in the gridview. *selected* is a boolean, true if the cell being drawn is the currently-selected cell.

playdate.ui.gridview:drawSectionHeader(section, x, y, width, height)

Override this method to draw section headers. This function will only be called if the header height has been set to a value greater than zero (0).

playdate.ui.gridview:drawHorizontalDivider(x, y, width, height)

Override this method to customize the drawing of horizontal dividers. This function will only be called if the horizontal divider height is greater than zero (0) and at least one divider has been added.

playdate.ui.gridview:drawInRect(x, y, width, height)

Draws the gridview in the specified rect. Ideally this should be called on every [playdate.update()](#c-update) to accommodate scrolling.

playdate.ui.gridview.needsDisplay

This read-only variable returns true if the gridview needs to be redrawn. This can be used to help optimize drawing in your app. Keep in mind that a gridview cannot know all reasons it may need to be redrawn, such as changes in your drawing callback functions, coordinate or size changes, or overlapping drawing, so you may need to additionally redraw at other times.

Conditionally draw a grid view

```lua
if myGridView.needsDisplay == true then
    myGridView:drawInRect(x, y, w, h)
end
```

##### Configuration

playdate.ui.gridview:setNumberOfSections(num)

Sets the number of sections in the grid view. Each section contains at least one row, and row numbering starts at 1 in each section.

playdate.ui.gridview:getNumberOfSections()

Returns the number of sections in the grid view.

playdate.ui.gridview:setNumberOfRowsInSection(section, num)

Sets the number of rows in *section*.

playdate.ui.gridview:getNumberOfRowsInSection(section)

Returns the number of rows in *section*.

playdate.ui.gridview:setNumberOfColumns(num)

Sets the number of columns in the gridview. 1 by default.

playdate.ui.gridview:getNumberOfColumns()

Returns the number of columns in the gridview. 1 by default.

playdate.ui.gridview:setNumberOfRows(…​)

Convenience method for list-style gridviews, or for setting the number of rows for multiple sections at a time. Pass in a list of numbers of rows for sections starting from section 1.

playdate.ui.gridview:setCellSize(cellWidth, cellHeight)

Sets the size of the cells in the gridview. If cells should span the entire width of the grid (as in a list view), pass zero (0) for *cellWidth*.

playdate.ui.gridview:setCellPadding(left, right, top, bottom)

Sets the amount of padding around cells.

playdate.ui.gridview:setContentInset(left, right, top, bottom)

Sets the amount of space the content is inset from the edges of the gridview. Useful if a background image is being used as a border.

playdate.ui.gridview:getCellBounds(section, row, column, \[gridWidth\])

Returns multiple values (x, y, width, height) representing the bounds of the cell, not including padding, relative to the top-right corner of the grid view.

If the grid view is configured with zero width cells (see [playdate.ui.gridview:new](#f-gridview.new)), *gridWidth* is required, and should be the same value you would pass to [playdate.ui.gridview:drawInRect](#m-gridview.drawInRect).

playdate.ui.gridview:setSectionHeaderHeight(height)

Sets the height of the section headers. 0 by default, which causes section headers not to be drawn.

playdate.ui.gridview.getSectionHeaderHeight()

Returns the current height of the section headers.

playdate.ui.gridview:setSectionHeaderPadding(left, right, top, bottom)

Sets the amount of padding around section headers.

playdate.ui.gridview:setHorizontalDividerHeight(height)

Sets the height of the horizontal dividers. The default height is half the cell height specified when creating the grid view.

playdate.ui.gridview:getHorizontalDividerHeight()

Returns the height of the horizontal dividers.

playdate.ui.gridview:addHorizontalDividerAbove(section, row)

Causes a horizontal divider to be drawn above the specified row. Drawing can be customized by overriding [playdate.ui.gridview:drawHorizontalDivider](#m-gridview.drawHorizontalDivider).

playdate.ui.gridview:removeHorizontalDividers()

Removes all horizontal dividers from the grid view.

##### Scrolling

playdate.ui.gridview:setScrollDuration(ms)

Controls the duration of scroll animations. 250ms by default.

playdate.ui.gridview:setScrollPosition(x, y, \[animated\])

'set' scrolls to the coordinate *x*, *y*.

If *animated* is true (or not provided) the new scroll position is animated to using [playdate.ui.gridview.scrollEasingFunction](#v-gridview.scrollEasingFunction) and the value set in [playdate.ui.gridview:setScrollDuration()](#m-gridview.setScrollDuration).

playdate.ui.gridview:getScrollPosition()

Returns the current scroll location as a pair *x*, *y*.

playdate.ui.gridview:scrollToCell(section, row, column, \[animated\])

Scrolls to the specified cell, just enough so the cell is visible.

playdate.ui.gridview:scrollCellToCenter(section, row, column, \[animated\])

Scrolls to the specified cell, so the cell is centered in the gridview, if possible.

playdate.ui.gridview:scrollToRow(row, \[animated\])

Convenience function for list-style gridviews. Scrolls to the specified row in the list.

playdate.ui.gridview:scrollToTop(\[animated\])

Scrolls to the top of the gridview.

##### Selection

Changing the selection can also change the scroll position. By default cells are scrolled so that they are centered in the gridview, if possible. To change that behavior so the grid is just scrolled enough to make the cell visible, set [scrollCellsToCenter](#v-gridview.scrollCellsToCenter) to false.

playdate.ui.gridview:setSelection(section, row, column)

Selects the cell at the given position.

playdate.ui.gridview:getSelection()

Returns the currently-selected cell as *section*, *row*, *column*

playdate.ui.gridview:setSelectedRow(row)

Convenience method for list-style gridviews. Selects the cell at *row* in section 1.

playdate.ui.gridview:getSelectedRow()

Convenience method for list-style gridviews. Returns the selected cell at *row* in section 1.

playdate.ui.gridview:selectNextRow(wrapSelection, \[scrollToSelection, animate\])

Selects the cell directly below the currently-selected cell.

If *wrapSelection* is true, the selection will wrap around to the opposite end of the grid. If *scrollToSelection* is true (or not provided), the newly-selected cell will be scrolled to. If *animate* is true (or not provided), the scroll will be animated.

playdate.ui.gridview:selectPreviousRow(wrapSelection, \[scrollToSelection, animate\])

Identical to `selectNextRow()` but goes the other direction.

playdate.ui.gridview:selectNextColumn(wrapSelection, \[scrollToSelection, animate\])

Selects the cell directly to the right of the currently-selected cell.

If the last column is currently selected and *wrapSelection* is true, the selection will wrap around to the opposite side of the grid. If a wrap occurs and the gridview’s [`changeRowOnColumnWrap`](#v-gridview.changeRowOnColumnWrap) is `true` the row will also be advanced or moved back.

If *scrollToSelection* is true (or not provided), the newly-selected cell will be scrolled to. If *animate* is true (or not provided), the scroll will be animated.

playdate.ui.gridview:selectPreviousColumn(wrapSelection, \[scrollToSelection, animate\])

Identical to `selectNextColumn()` but goes the other direction.

##### Properties

playdate.ui.gridview.backgroundImage

A background image that draws behind the gridview’s cells. This image can be either a [`playdate.graphics.image`](#C-graphics.image) which will be tiled or a [`playdate.nineSlice`](#C-graphics.nineSlice).

playdate.ui.gridview.isScrolling

Read-only. True if the gridview is currently performing a scroll animation.

playdate.ui.gridview.scrollEasingFunction

The easing function used when performing scroll animations. The function should be of the form function(t, b, c, d), where t is elapsed time, b is the beginning value, c is the change, or end value - start value, and d is the duration. Many such functions are available in [`playdate.easingFunctions`](#M-easingFunctions). [`playdate.easingFunctions.outCubic`](#f-easingFunctions.outCubic) is the default.

playdate.ui.gridview.easingAmplitude  
playdate.ui.gridview.easingPeriod

For [easing functions](#M-easingFunctions) that take additional amplitude and period arguments (such as *inOutElastic*), set these to the desired values.

playdate.ui.gridview.changeRowOnColumnWrap

Controls the behavior of [playdate.ui.gridview:selectPreviousColumn()](#m-gridview.selectPreviousColumn) and [playdate.ui.gridview:selectNextColumn()](#m-gridview.selectNextColumn) if the current selection is at the first or last column, respectively. If set to true, the selection switch to a new row to allow the selection to change. If false, the call will have no effect on the selection. True by default.

playdate.ui.gridview.scrollCellsToCenter

If true, the gridview will attempt to center cells when scrolling. If false, the gridview will be scrolled just as much as necessary to make the cell visible.

##### Grid view sample code

To set up a grid view, specify the dimensions and override the necessary drawing methods:

Grid view example

```lua
local gfx = playdate.graphics
local gridview = playdate.ui.gridview.new(44, 44)
gridview.backgroundImage = playdate.graphics.nineSlice.new('shadowbox', 4, 4, 45, 45)
gridview:setNumberOfColumns(8)
gridview:setNumberOfRows(2, 4, 3, 5) -- number of sections is set automatically
gridview:setSectionHeaderHeight(24)
gridview:setContentInset(1, 4, 1, 4)
gridview:setCellPadding(4, 4, 4, 4)
gridview.changeRowOnColumnWrap = false

function gridview:drawCell(section, row, column, selected, x, y, width, height)
    if selected then
        gfx.drawCircleInRect(x-2, y-2, width+4, height+4, 3)
    else
        gfx.drawCircleInRect(x+4, y+4, width-8, height-8, 0)
    end
    local cellText = ""..row.."-"..column
    gfx.drawTextInRect(cellText, x, y+14, width, 20, nil, nil, kTextAlignment.center)
end

function gridview:drawSectionHeader(section, x, y, width, height)
    gfx.drawText("*SECTION ".. section .. "*", x + 10, y + 8)
end
```

For the simple case of a simple list-style grid:

List-style grid view example

```lua
local menuOptions = {"Sword", "Shield", "Arrow", "Sling", "Stone", "Longbow", "MorningStar", "Armour", "Dagger", "Rapier", "Skeggox", "War Hammer", "Battering Ram", "Catapult"}
local listview = playdate.ui.gridview.new(0, 10)
listview.backgroundImage = playdate.graphics.nineSlice.new('scrollbg', 20, 23, 92, 28)
listview:setNumberOfRows(#menuOptions)
listview:setCellPadding(0, 0, 13, 10)
listview:setContentInset(24, 24, 13, 11)

function listview:drawCell(section, row, column, selected, x, y, width, height)
        if selected then
                gfx.fillRoundRect(x, y, width, 20, 4)
                gfx.setImageDrawMode(gfx.kDrawModeFillWhite)
        else
                gfx.setImageDrawMode(gfx.kDrawModeCopy)
        end
        gfx.drawTextInRect(menuOptions[row], x, y+2, width, height, nil, "...", kTextAlignment.center)
end
```

Then, to draw the grid view:

Drawing a grid view

```lua
function playdate.update()
    gridview:drawInRect(20, 20, 180, 200)
    listview:drawInRect(220, 20, 160, 210)
    playdate.timer:updateTimers()
end
```

### 7.33. Serial communication

playdate.serialMessageReceived(message)

Called when a `msg <text>` command is received on the serial port. The text following the command is passed to the function as the string *message*.

Running `!msg <message>` in the simulator Lua console sends the command to the device if one is connected, otherwise it sends it to the game running in the simulator.

### 7.34. Playdate Mirror

[Mirror](http://play.date/mirror/) is an app that routes Playdate’s audio and video to an PC running Windows, macOS, or Linux.

playdate.mirrorStarted()

Called when the device is connected to Mirror.

|         |                                                                                                                                                                                                                                                                                                                                                                                       |
|---------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Caution | In rare situations, Mirror may have trouble keeping up with games running at a high framerate (\> 40 fps). If you find this consistently happens to your game, you can optionally use these callbacks to lower the amount of computation or drawing you do so as to give more time to Playdate OS on each frame, improving your user’s experience while playing your game via Mirror. |

playdate.mirrorEnded()

Called when the device is disconnected from Mirror.

### 7.35. Garbage collection

playdate.setCollectsGarbage(flag)

If *flag* is false, automatic garbage collection is disabled and the game should manually collect garbage with Lua’s `collectgarbage()` function.

playdate.setMinimumGCTime(ms)

Force the Lua garbage collector to run for at least *ms* milliseconds every frame, so that garbage doesn’t pile up and cause the game to run out of memory and stall in emergency garbage collection. The default value is 1 millisecond.

|     |                                                                                                                                                      |
|-----|------------------------------------------------------------------------------------------------------------------------------------------------------|
| Tip | If your game isn’t generating a lot of garbage, it might be advantageous to set a smaller minimum GC time, granting more CPU bandwidth to your game. |

playdate.setGCScaling(min, max)

When the amount of used memory is less than `min` (scaled from 0-1, as a percentage of total system memory), the system will only run the collector for the minimum GC time, as set by [playdate.setGCScaling()](#f-setGCScaling), every frame. If the used memory is more than `max`, the system will spend all free time running the collector. Between the two, the time used by the garbage collector is scaled proportionally.

For example, if the scaling is set to a min of 0.4 and max of 0.7, and memory is half full, the collector will run for the minimum GC time plus 1/3 of whatever time is left before the next frame (because (0.5 - 0.4) / (0.7 - 0.4) = 1/3).

The default behavior is a scaling of `(0.0, 1.0)`. If set to `(0.0, 0.0)`, the system will use all available extra time each frame running GC.

## 8. Hidden Gems

The Playdate APIs include a lot of functionality you might expect:

- [graphics](#M-graphics)

- [sprites](#C-graphics.sprite)

- [collisions](#M-sprite-collisions)

- [animation](#C-graphics.animator)

- [sound](#M-sound)

- [file I/O](#M-file)

- [localization](#f-graphics.getLocalizedText)

There are also some unexpected APIs, some unique to the Playdate platform, that you may not be aware of. Be sure to take a look at these:

### 8.1. Lua enhancements

The Playdate SDK offers some enhancements to standard Lua, including [additional assignment operators](#additional-assignment-operators) (`+=`, `-=`) and [convenience functions for handling Lua tables](#table-additions).

### 8.2. Debugging

- [playdate.drawFPS()](#f-drawFPS): Displays the current framerate onscreen.

- [playdate.debugDraw()](#c-debugDraw): Highlight regions on the Simulator screen in a different color, to aid in debugging.

- [printTable()](#f-printTable): Outputs the contents of a table to the console.

- [playdate.keyPressed()](#c-keyPressed): Captures computer keyboard keypresses as an aid in debugging. For example, typing a number might advance the game to a higher level.

### 8.3. Enhancing your game’s user experience

- [playdate.ui.crankIndicator()](#C-ui.crankIndicator): Inform the player that your game uses the crank.

- [playdate.menu:addOptionsMenuItem()](#m-menu.addOptionsMenuItem): Add a special menu item for your game into the System Menu.

- [playdate.wait()](#f-wait): Pause your game’s execution for a specified period of time. Useful for, say, suspending gameplay while displaying a message to the player.

- [playdate.setMenuImage()](#f-setMenuImage): Set a custom image that displays on the left-side of the screen while your game is paused.

- [playdate.keyboard](#M-keyboard): Display a special Playdate keyboard onscreen and collect text input from the player.

- [playdate.timer.keyRepeatTimer()](#f-timer.keyRepeatTimer): Useful, keyboard-style repeating.

### 8.4. Buttons

- [playdate.AButtonHeld()](#c-AButtonHeld), [playdate.BButtonHeld()](#c-BButtonHeld): Called after the A or B buttons are held for one second. Useful for adding a "second function" to a button (display a map, for instance).

### 8.5. Responding to device events

- [playdate.gameWillTerminate()](#c-gameWillTerminate): Notifies your game it’s about to end its execution.

- [playdate.deviceWillLock()](#c-deviceWillLock), [playdate.deviceDidUnlock()](#c-deviceDidUnlock): Notifies your game the Playdate is about to be locked, or woken up.

- [playdate.gameWillPause()/Resume()](#c-gameWillPause): Notifies your game it’s about to be paused or resumed.

### 8.6. Drawing

- [playdate.graphics.setDrawOffset()](#f-graphics.setDrawOffset): Force all drawing calls to render with an offset; ideal for games with scrolling content.

- [playdate.ui.gridview](#C-ui.gridview): Render one- or two-dimensional grids of content.

- [playdate.graphics.nineslice](#C-graphics.nineSlice): Create resizable rectangular assets.

### 8.7. Effects

- [playdate.graphics.image.vcrPauseFilterImage()](#m-graphics.image.vcrPauseFilterImage) - add glitchiness to your game’s appearance

### 8.8. Accessibility

- [playdate.getReduceFlashing()](#f-getReduceFlashing): Check this at the beginning of your game. If *true*, your game should avoid visuals that could be problematic for people with sensitivities to flashing lights or patterns.

### 8.9. File I/O

- [playdate.datastore](#M-datastore): Easy writing and reading of data.

- [json](#M-json): Read and write JSON.

### 8.10. Game logic

- [playdate.pathfinder](#M-pathfinder): An implementation of the A\* pathfinding algorithm.

### 8.11. Deployment

- [buildNumber](#pdxinfo): It is critical to update your `buildNumber` for every public release of your game.

### 8.12. Odds & ends

- [playdate.graphics.perlin](#f-graphics.perlin): Generate natural-looking patterns.

- [playdate.graphics.generateQRCode](#f-graphics.generateQRCode): Display a QR code onscreen.

- [playdate.serialMessageReceived](#c-serialMessageReceived): Communicate over the USB port.

## 9. Getting Help

### 9.1. Where can I download the SDK?

Head to the [Playdate Developer](https://play.date/dev/) page to download the latest SDK.

### 9.2. Where do I go if I have questions about the SDK?

You can find the SDK documentation for Lua [here](https://sdk.play.date/inside-playdate) and C [here](https://sdk.play.date/inside-playdate-with-c) . If you’re interested in seeing the Playdate SDK in action, check out our [Twitch stream](https://www.twitch.tv/videos/608372277) . For tips on making Playdate games, [click here](https://sdk.play.date/designing-for-playdate).

Searching in the [Get Help](https://devforum.play.date/c/get-help/38) and [Development Discussion](https://devforum.play.date/c/development-discussion/80) on our Developer Forum to find solutions will also be a good place to look at. If you still need help, the best way to get help from either the community or Panic is to post in that same Get Help category.

### 9.3. Where do I report bugs or issues relating to the SDK?

Head to the [Bug Reports](https://devforum.play.date/c/bugs/47) category and check the [Bug Report category info](https://devforum.play.date/t/about-the-bug-reports-category/1463) for information on how to post a bug report. One of us at Panic will take a look at it! And what if I have feature requests?

To share your ideas, suggestions, and requests relating to Playdate, head to the [Feature Request](https://devforum.play.date/c/feature-requests/48) category and check the [Feature Request category info](https://devforum.play.date/t/about-the-feature-requests-category/1464) before posting your feature request.

### 9.4. List of Helpful Libraries and Code

This thread includes some helpful tips from the community. Check it out [here](https://devforum.play.date/t/a-list-of-helpful-libraries-and-code/221). For more resources, head to the [Development Discussion](https://devforum.play.date/c/development-discussion/80) category.

## 10. Legal information

Playdate fonts are licensed to you under the [Creative Commons Attribution 4.0 International (CC BY 4.0) license.](https://creativecommons.org/licenses/by/4.0/)

Last updated 2026-05-04 11:24:53 -0700
