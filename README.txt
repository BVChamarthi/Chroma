Welcome to CHROMA!!!

CHROMA is a single-player 2D platformer game that was designed and coded up by me, 
Bharath, for my CSCB58 final project for the Winter 2022 semester at UTSC.

Youtube link of demo video : https://youtu.be/qW6Sib0Xo-M

In the repository, you will find the .asm file of the game itself, a local copy of
the MARS IDE to run the game with (i will explain why), and a bunch of asset (.dat) files.

The asset files are out in the open like that because MARS doesn't like to open
files inside directories, but you can ignore them. No, seriously, don't mess with them.

To play the game: 
1)  download the repository, open the local copy of MARS (the one that I provided. It's not 
    modded or anything, it's the same as MARS v4.5 you can download from the official website,
    http://courses.missouristate.edu/kenvollmar/mars/download.htm , but you need it to be in 
    the same directory as the asset files, or it can't open them).

2)  go to File > Open, choose game.asm and open it

3)  go to Tools > Bitmap Display and make sure the settings of the display are such:
    Unit Width in Pixels:       2
    Unit Height in Pixels:      2
    Display Width in Pixels:    1024
    Display Height in Pixels:   512
    Base Address of Display:    0x10010000 (static data)
    then click [Connect to MIPS], and resize the display's window so you can see all 
    of the display
    
    this will set up the display of the game
    
4)  go to Tools > Keyboard and Display MMIO Simulator
    click [Connect to MIPS], and put a cursor in the second text-box
    
    this will set up our keyboard input. so to play the game, we need to type the controls
    into this second/lower textbox.
 
5)  go to Run > Assemble, and then Run > Go. this will start the game. put the cursor
    back in the lower textbox of the Keyboard and Display MMIO Simulator, and you are
    ready to play. the instructions on controls and tutorials are in the game itself.
