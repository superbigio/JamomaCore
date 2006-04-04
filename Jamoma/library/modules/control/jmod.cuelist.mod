max v2;
#N vpatcher 32 194 982 726;
#P window setfont "Sans Serif" 9.;
#P hidden newex 419 159 113 196617 pvar SaveScriptButton;
#P window linecount 3;
#P hidden newex 419 180 374 196617 jmod.message.mxt $0_ /save_script @description "Save cue script to a file. An argument determines the path and name of the file.  No argument will bring up a file dialog (like saveas) or save the script to the existing file that is in use.";
#P user jsui 7 40 94 19 1 0 0 jsui_textbutton.js "Save Cue Script";
#P objectname SaveScriptButton;
#P window linecount 2;
#P hidden newex 419 433 280 196617 jmod.parameter.mxt $0_ /listen @type toggle @repetitions 0 @description "Listen to remote change of parameters.";
#P objectname jmod.parameter;
#P window linecount 1;
#P hidden newex 419 413 90 196617 pvar ListenToggle;
#P user radiogroup 168 42 54 16;
#X size 1;
#X offset 16;
#X inactive 0;
#X itemtype 1;
#X flagmode 0;
#X set 0;
#X done;
#P objectname ListenToggle;
#P hidden newex 104 192 78 196617 jmod.pass open;
#P window linecount 2;
#P hidden newex 419 265 208 196617 jmod.message.mxt $0_ /view @description "View current cue script in a text window.";
#P window linecount 1;
#P hidden newex 419 243 84 196617 pvar OpenButten;
#P user jsui 103 20 52 19 1 0 0 jsui_textbutton.js View;
#P objectname OpenButten;
#P window linecount 2;
#P hidden newex 419 365 305 196617 jmod.message.mxt $0_ /remote @type generic @description "Wireless communication of messages to modules via the bridge.";
#P hidden newex 419 305 238 196617 jmod.message.mxt $0_ /cue_event @type generic @description "Recall cue event from cue script.";
#P user jsui 157 20 94 19 1 0 0 jsui_textbutton.js "Get State";
#P objectname GetStateButton;
#P user jsui 7 20 94 19 1 0 0 jsui_textbutton.js "Load Cue Script";
#P objectname CueScriptButton;
#P window linecount 1;
#P hidden newex 104 227 45 196617 pcontrol;
#P hidden message 38 89 50 196617 /autodoc;
#P hidden newex 419 75 107 196617 pvar CueScriptButton;
#P window linecount 4;
#P hidden newex 419 96 338 196617 jmod.message.mxt $0_ /load_script @description "Load cue script from file. <br>NOTE: jmod.cue_list will be watching the file and automatically update if the content of the file is changed. This way you can use an external editor to work on the cue script while Jamoma is running.";
#P window linecount 2;
#P hidden message 16 406 65 196617 \; max refresh;
#P hidden message 16 369 75 196617 \; jmod.init bang;
#P window linecount 1;
#P hidden newex 104 285 103 196617 jmod.cuelist.alg $0_;
#P hidden newex 419 16 102 196617 pvar GetStateButton;
#P window linecount 4;
#P hidden newex 16 114 181 196617 jmod.hub $0_ jmod.cuelist @size 1U-half @module_type control @description "Manage cue list in text format";
#P objectname jmod.hub;
#P hidden inlet 16 90 13 0;
#P hidden outlet 16 316 13 0;
#P window linecount 2;
#P hidden newex 419 36 280 196617 jmod.message.mxt $0_ /get_state @description "Poll state for all bridged modules\\\, and display in text window.";
#P objectname jmod.parameter.mxt;
#P window linecount 3;
#P hidden newex 210 114 79 196617 pattrstorage @autorestore 0 @savemode 0;
#X client_rect 14 59 654 299;
#X storage_rect 0 0 640 240;
#P objectname jmod.cuelist;
#P window linecount 1;
#P comment 186 44 47 196617 listen;
#B frgb 255 255 255;
#P bpatcher 0 0 256 62 0 0 jmod.gui.mxt 0 $0_;
#P objectname jmod.gui.1Uh.a.stereo.mxt;
#P hidden connect 5 0 6 0;
#P hidden fasten 13 0 6 0 43 108 21 108;
#P hidden connect 6 0 4 0;
#P hidden connect 6 1 22 0;
#P hidden connect 22 0 14 0;
#P hidden connect 14 0 8 0;
#P hidden fasten 22 1 8 0 177 259 109 259;
#P hidden connect 2 0 6 1;
#P hidden connect 6 2 2 0;
#P hidden connect 7 0 3 0;
#P hidden connect 12 0 11 0;
#P hidden connect 28 0 27 0;
#P hidden connect 20 0 21 0;
#P hidden fasten 25 0 24 0 424 467 411 467 411 409 424 409;
#P hidden connect 24 0 25 0;
#P pop;
