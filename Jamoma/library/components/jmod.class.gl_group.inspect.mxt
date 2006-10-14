max v2;#N vpatcher 1 46 1274 850;#P window setfont "Sans Serif" 9.;#P window linecount 1;#P hidden newex 779 22 73 196617 r $0_defaults;#P hidden newex 166 707 73 196617 s $0_defaults;#P user jsui 76 705 84 19 3 0 0 jsui_textbutton.js Defaults;#P hidden message 1022 393 17 196617 1.;#B color 6;#P hidden message 1020 505 17 196617 1.;#B color 6;#P hidden message 1016 142 17 196617 1.;#B color 6;#P hidden message 1005 318 23 196617 16.;#B color 6;#P hidden newex 779 42 226 196617 t b 0 b;#B color 5;#P hidden message 601 658 55 196617 0. 0. 0. 0.;#B color 5;#P hidden message 583 591 55 196617 0. 0. 0. 0.;#B color 5;#P hidden message 589 523 55 196617 0. 0. 0. 0.;#B color 5;#P hidden message 601 455 55 196617 0. 0. 0. 0.;#B color 5;#P hidden message 777 323 17 196617 1.;#B color 5;#P hidden message 777 342 43 196617 1. 1. 1.;#B color 5;#P hidden message 778 408 91 196617 0. 0. 0. 0. 0. 0. 0.;#B color 5;#P hidden message 610 237 23 196617 6 7;#B color 5;#P hidden message 548 175 43 196617 1. 1. 1.;#B color 5;#P hidden message 605 110 55 196617 0. 0. 1. 0.;#B color 5;#P hidden message 533 39 43 196617 0. 0. 0.;#B color 5;#P window linecount 2;#P hidden newex 497 259 290 196617 jmod.parameter.mxt $1 /blend/mode @type msg_list @description "Blend modes for source and destination planes.";#P objectname jmod.parameter[10];#P window linecount 1;#P hidden newex 347 259 144 196617 jmod.list2parameter.mxt 2;#P hidden newex 447 235 96 196617 pvar BlendModeDst;#P hidden newex 347 235 97 196617 pvar BlendModeSrc;#P hidden newex 547 235 60 196617 jmod.round;#P comment 7 143 89 196617 Mode destination:;#B frgb 255 255 255;#P user umenu 94 143 158 196647 1 64 159 1;#X add 0: zero;#X add 1: one;#X add 2: destination color;#X add 3: source color;#X add 4: one minus destination color;#X add 5: one minus source color;#X add 6: source alpha;#X add 7: one minus source alpha;#X add 8: destination alpha;#X add 9: one minus destination alpha;#X add 10: source alpha saturate;#P objectname BlendModeDst;#P window linecount 3;#P hidden newex 1041 329 268 196617 jmod.parameter $1 /fog/amount @type msg_float @range 0. 255. @clipmode both @ramp 1 @description "Material shininess.";#P objectname jmod.parameter[23];#P window linecount 2;#P hidden newex 944 329 52 196617 pvar Shininess;#P hidden newex 1041 563 265 196617 jmod.parameter $1 /render/enable @type toggle @description "Enable drawing.";#P objectname jmod.parameter[24];#P hidden newex 1041 526 226 196617 jmod.parameter $1 /render/automatic @type toggle @description "Automatic rendering flag.";#P objectname jmod.parameter[22];#P hidden newex 1041 489 268 196617 jmod.parameter $1 /render/antialias @type toggle @description "Aliasing flag.";#P objectname jmod.parameter[21];#P hidden newex 1041 452 267 196617 jmod.parameter $1 /material/inherit @type toggle @description "Inherit material properties from context.";#P objectname jmod.parameter[20];#P hidden newex 1041 415 249 196617 jmod.parameter $1 /material/automatic @type toggle @description "Automatic material attributes.";#P objectname jmod.parameter[19];#P hidden newex 1041 378 222 196617 jmod.parameter $1 /material/light/enable @type toggle @description "Calculate lighting.";#P objectname jmod.parameter[18];#P hidden newex 943 563 69 196617 pvar RenderEnable;#P hidden newex 943 526 87 196617 pvar RenderAutomatic;#P hidden newex 943 489 50 196617 pvar Antialias;#P hidden newex 943 452 78 196617 pvar MaterialInherit;#P hidden newex 943 415 94 196617 pvar MaterialAutomatic;#P hidden newex 943 378 73 196617 pvar LightingEnable;#P hidden newex 944 255 59 196617 pvar FogAmount;#P hidden newex 1041 255 254 196617 jmod.parameter $1 /fog/amount @type msg_float @range 0. 1. @description "The amount of fog effect.";#P objectname jmod.parameter[17];#P hidden newex 1041 292 243 196617 jmod.parameter $1 /fog/inherit @type toggle @description "inherit fog properties from context.";#P objectname jmod.parameter[16];#P hidden newex 944 292 55 196617 pvar FogInherit;#P hidden newex 1041 218 253 196617 jmod.parameter $1 /depth/inherit @type toggle @description "Inherit depth properties from context.";#P objectname jmod.parameter[15];#P hidden newex 944 218 65 196617 pvar DepthInherit;#P hidden newex 1041 181 281 196617 jmod.parameter $1 /depth/enable @type toggle @description "Enable depth buffering.";#P objectname jmod.parameter[14];#P hidden newex 944 181 63 196617 pvar DepthEnable;#P hidden newex 1041 144 282 196617 jmod.parameter $1 /depth/clear @type toggle @description "Clear depth buffer before rendering the object.";#P objectname jmod.parameter[13];#P hidden newex 944 144 59 196617 pvar DepthClear;#P hidden newex 1041 107 252 196617 jmod.parameter $1 /color/inherit @type toggle @description "Inherit color properties from context.";#P objectname jmod.parameter[12];#P hidden newex 944 107 64 196617 pvar ColorInherit;#P hidden newex 1041 70 265 196617 jmod.parameter $1 /blend/enable @type toggle @description "Enable blending.";#P objectname jmod.parameter[11];#P hidden newex 944 70 62 196617 pvar BlendEnable;#P window linecount 1;#P hidden newex 535 658 62 196617 pvar SpecA;#P window linecount 2;#P hidden newex 497 684 370 196617 jmod.parameter.mxt $1 /material/light/specular @type msg_list @description "The specular light material property as red\\\, green\\\, blue\\\, alpha (0.-1.).";#P objectname jmod.parameter[9];#P window linecount 1;#P hidden newex 346 684 144 196617 jmod.list2parameter.mxt 4;#P hidden newex 472 658 61 196617 pvar SpecB;#P hidden newex 409 658 61 196617 pvar SpecG;#P hidden newex 346 658 61 196617 pvar SpecR;#P hidden newex 524 590 54 196617 pvar EmA;#P window linecount 2;#P hidden newex 497 616 371 196617 jmod.parameter.mxt $1 /material/light/emission @type msg_list @description "The material emission property as red\\\, green\\\, blue\\\, alpha (0.-1.).";#P objectname jmod.parameter[8];#P window linecount 1;#P hidden newex 346 616 144 196617 jmod.list2parameter.mxt 4;#P hidden newex 462 590 53 196617 pvar EmB;#P hidden newex 404 590 53 196617 pvar EmG;#P hidden newex 346 590 53 196617 pvar EmR;#P hidden newex 524 522 58 196617 pvar DiffA;#P window linecount 2;#P hidden newex 497 548 363 196617 jmod.parameter.mxt $1 /material/light/diffuse @type msg_list @description "The diffuse light material property as red\\\, green\\\, blue\\\, alpha (0.-1.).";#P objectname jmod.parameter[6];#P window linecount 1;#P hidden newex 346 548 144 196617 jmod.list2parameter.mxt 4;#P hidden newex 462 522 57 196617 pvar DiffB;#P hidden newex 404 522 57 196617 pvar DiffG;#P hidden newex 346 522 57 196617 pvar DiffR;#P hidden newex 532 454 61 196617 pvar AmbA;#P window linecount 2;#P hidden newex 497 480 367 196617 jmod.parameter.mxt $1 /material/light/ambient @type msg_list @description "The ambient light material property as red\\\, green\\\, blue\\\, alpha (0.-1.).";#P objectname jmod.parameter[7];#P window linecount 1;#P hidden newex 346 480 144 196617 jmod.list2parameter.mxt 4;#P hidden newex 470 454 60 196617 pvar AmbB;#P hidden newex 408 454 60 196617 pvar AmbG;#P hidden newex 346 454 60 196617 pvar AmbR;#P hidden newex 727 376 64 196617 pvar FogEnd;#P hidden newex 652 376 73 196617 pvar FogStart;#P hidden newex 580 376 70 196617 pvar FogDens;#P hidden newex 521 376 56 196617 pvar FogA;#P window linecount 2;#P hidden newex 497 409 276 196617 jmod.parameter.mxt $1 /fog/params @type msg_list @description "Fog color (RGBA)\\\, density\\\,start and end.";#P objectname jmod.parameter[5];#P window linecount 1;#P hidden newex 347 409 144 196617 jmod.list2parameter.mxt 7;#P hidden newex 463 376 55 196617 pvar FogB;#P hidden newex 405 376 55 196617 pvar FogG;#P hidden newex 347 376 55 196617 pvar FogR;#P window linecount 2;#P hidden newex 583 293 351 196617 jmod.parameter.mxt $1 /color/alpha @type msg_float @range 0. 1. @clipmode both @ramp 1 @description "Object alpha transparency (0.-1.).";#P objectname jmod.parameter[4];#P window linecount 1;#P hidden newex 524 301 55 196617 pvar ColA;#P window linecount 2;#P hidden newex 497 327 273 196617 jmod.parameter.mxt $1 /color/rgb @type msg_list @description "Object color as red\\\, green\\\, blue (0.-1.).";#P objectname jmod.parameter[3];#P window linecount 1;#P hidden newex 346 327 144 196617 jmod.list2parameter.mxt 3;#P hidden newex 462 301 54 196617 pvar ColB;#P hidden newex 404 301 54 196617 pvar ColG;#P hidden newex 346 301 54 196617 pvar ColR;#P window linecount 2;#P hidden newex 497 197 249 196617 jmod.parameter.mxt $1 /3D/scale @type msg_list @description "3D scaling factor as xyz coordinates.";#P objectname jmod.parameter[2];#P window linecount 1;#P hidden newex 347 197 144 196617 jmod.list2parameter.mxt 3;#P hidden newex 479 173 63 196617 pvar ScaleZ;#P hidden newex 413 173 64 196617 pvar ScaleY;#P hidden newex 347 173 64 196617 pvar ScaleX;#P hidden newex 547 108 54 196617 pvar RotZ;#P window linecount 2;#P hidden newex 497 134 315 196617 jmod.parameter.mxt $1 /3D/position @type msg_list @description "3D rotation as angle and xyz rotation axis coordinates.";#P objectname jmod.parameter[1];#P window linecount 1;#P hidden newex 347 134 144 196617 jmod.list2parameter.mxt 4;#P hidden newex 485 108 55 196617 pvar RotY;#P hidden newex 423 108 55 196617 pvar RotX;#P hidden newex 347 108 74 196617 pvar RotAngle;#P window linecount 2;#P hidden newex 497 62 254 196617 jmod.parameter.mxt $1 /3D/position @type msg_list @description "3D origin as xyz coordinates.";#P objectname jmod.parameter;#P window linecount 1;#P hidden newex 347 62 144 196617 jmod.list2parameter.mxt 3;#P hidden newex 470 38 55 196617 pvar PosZ;#P hidden newex 410 38 56 196617 pvar PosY;#P hidden newex 347 38 56 196617 pvar PosX;#P comment 111 660 56 196617 Automatic;#B frgb 255 255 255;#P user radiogroup 96 658 73 16;#X size 1;#X offset 16;#X inactive 0;#X itemtype 1;#X flagmode 0;#X set 1;#X done;#P objectname RenderAutomatic;#P comment 111 644 45 196617 Antialias;#B frgb 255 255 255;#P user radiogroup 96 642 73 16;#X size 1;#X offset 16;#X inactive 0;#X itemtype 1;#X flagmode 0;#X set 0;#X done;#P objectname Antialias;#P comment 111 676 45 196617 Enable;#B frgb 255 255 255;#P user radiogroup 96 674 73 16;#X size 1;#X offset 16;#X inactive 0;#X itemtype 1;#X flagmode 0;#X set 1;#X done;#P objectname RenderEnable;#P window setfont "Sans Serif" 12.;#P comment 7 636 64 196620 Render;#B frgb 255 255 255;#P window setfont "Sans Serif" 9.;#P flonum 94 550 40 9 0. 255. 8227 3 255 255 255 221 221 221 222 222 222 0 0 0;#P objectname Shininess;#P comment 7 552 76 196617 Shininess:;#B frgb 255 255 255;#P comment 112 603 45 196617 Inherit;#B frgb 255 255 255;#P user radiogroup 94 601 73 16;#X size 1;#X offset 16;#X inactive 0;#X itemtype 1;#X flagmode 0;#X set 0;#X done;#P objectname MaterialInherit;#P user radiogroup 94 585 118 16;#X size 1;#X offset 16;#X inactive 0;#X itemtype 1;#X flagmode 0;#X set 1;#X done;#P objectname MaterialAutomatic;#P comment 110 571 81 196617 Lighting enabled;#B frgb 255 255 255;#P user radiogroup 94 569 73 16;#X size 1;#X offset 16;#X inactive 0;#X itemtype 1;#X flagmode 0;#X set 0;#X done;#P objectname LightingEnable;#P flonum 94 533 40 9 0. 1. 8227 3 255 255 255 221 221 221 222 222 222 0 0 0;#P objectname SpecR;#P flonum 220 533 40 9 0. 1. 8227 3 255 255 255 221 221 221 222 222 222 0 0 0;#P objectname SpecA;#P flonum 178 533 40 9 0. 1. 8227 3 255 255 255 221 221 221 222 222 222 0 0 0;#P objectname SpecB;#P flonum 136 533 40 9 0. 1. 8227 3 255 255 255 221 221 221 222 222 222 0 0 0;#P objectname SpecG;#P comment 7 535 76 196617 Specular light:;#B frgb 255 255 255;#P flonum 94 515 40 9 0. 1. 8227 3 255 255 255 221 221 221 222 222 222 0 0 0;#P objectname EmR;#P flonum 220 515 40 9 0. 1. 8227 3 255 255 255 221 221 221 222 222 222 0 0 0;#P objectname EmA;#P flonum 178 515 40 9 0. 1. 8227 3 255 255 255 221 221 221 222 222 222 0 0 0;#P objectname EmB;#P flonum 136 515 40 9 0. 1. 8227 3 255 255 255 221 221 221 222 222 222 0 0 0;#P objectname EmG;#P comment 7 517 79 196617 Emmision light:;#B frgb 255 255 255;#P flonum 94 497 40 9 0. 1. 8227 3 255 255 255 221 221 221 222 222 222 0 0 0;#P objectname DiffR;#P flonum 220 497 40 9 0. 1. 8227 3 255 255 255 221 221 221 222 222 222 0 0 0;#P objectname DiffA;#P flonum 178 497 40 9 0. 1. 8227 3 255 255 255 221 221 221 222 222 222 0 0 0;#P objectname DiffB;#P flonum 136 497 40 9 0. 1. 8227 3 255 255 255 221 221 221 222 222 222 0 0 0;#P objectname DiffG;#P comment 7 499 70 196617 Diffuse light:;#B frgb 255 255 255;#P flonum 94 479 40 9 0. 1. 8227 3 255 255 255 221 221 221 222 222 222 0 0 0;#P objectname AmbR;#P flonum 220 479 40 9 0 0 8224 3 255 255 255 221 221 221 222 222 222 0 0 0;#P objectname AmbA;#P flonum 178 479 40 9 0. 1. 8227 3 255 255 255 221 221 221 222 222 222 0 0 0;#P objectname AmbB;#P flonum 136 479 40 9 0. 1. 8227 3 255 255 255 221 221 221 222 222 222 0 0 0;#P objectname AmbG;#P comment 220 462 38 196617 Alpha;#B frgb 255 255 255;#P comment 178 462 38 196617 Blue;#B frgb 255 255 255;#P comment 136 462 38 196617 Green;#B frgb 255 255 255;#P comment 94 462 38 196617 Red;#B frgb 255 255 255;#P comment 7 481 74 196617 Ambient light:;#B frgb 255 255 255;#P window setfont "Sans Serif" 12.;#P comment 7 460 64 196620 Material;#B frgb 255 255 255;#P window setfont "Sans Serif" 9.;#P flonum 94 403 40 9 0. 1. 8227 3 255 255 255 221 221 221 222 222 222 0 0 0;#P objectname FogDens;#P flonum 220 403 40 9 0. 1. 8227 3 255 255 255 221 221 221 222 222 222 0 0 0;#P objectname FogAmount;#P flonum 178 403 40 9 0. 0 8225 3 255 255 255 221 221 221 222 222 222 0 0 0;#P objectname FogEnd;#P flonum 136 403 40 9 0. 0 8225 3 255 255 255 221 221 221 222 222 222 0 0 0;#P objectname FogStart;#P comment 220 386 44 196617 Amount;#B frgb 255 255 255;#P comment 178 386 38 196617 End;#B frgb 255 255 255;#P comment 136 386 38 196617 Start;#B frgb 255 255 255;#P comment 94 386 44 196617 Density;#B frgb 255 255 255;#P comment 109 427 45 196617 Inherit;#B frgb 255 255 255;#P user radiogroup 94 425 73 16;#X size 1;#X offset 16;#X inactive 0;#X itemtype 1;#X flagmode 0;#X set 0;#X done;#P objectname FogInherit;#P flonum 94 362 40 9 0. 1. 8227 3 255 255 255 221 221 221 222 222 222 0 0 0;#P objectname FogR;#P flonum 220 362 40 9 0 0 8224 3 255 255 255 221 221 221 222 222 222 0 0 0;#P objectname FogA;#P flonum 178 362 40 9 0. 1. 8227 3 255 255 255 221 221 221 222 222 222 0 0 0;#P objectname FogB;#P flonum 136 362 40 9 0. 1. 8227 3 255 255 255 221 221 221 222 222 222 0 0 0;#P objectname FogG;#P comment 220 345 38 196617 Alpha;#B frgb 255 255 255;#P comment 178 345 38 196617 Blue;#B frgb 255 255 255;#P comment 136 345 38 196617 Green;#B frgb 255 255 255;#P comment 94 345 38 196617 Red;#B frgb 255 255 255;#P window setfont "Sans Serif" 12.;#P comment 7 342 64 196620 Fog;#B frgb 255 255 255;#P window setfont "Sans Serif" 9.;#P comment 109 292 45 196617 Enable;#B frgb 255 255 255;#P user radiogroup 94 290 73 16;#X size 1;#X offset 16;#X inactive 0;#X itemtype 1;#X flagmode 0;#X set 1;#X done;#P objectname DepthEnable;#P comment 109 276 45 196617 Clear;#B frgb 255 255 255;#P user radiogroup 94 274 73 16;#X size 1;#X offset 16;#X inactive 0;#X itemtype 1;#X flagmode 0;#X set 0;#X done;#P objectname DepthClear;#P comment 109 308 45 196617 Inherit;#B frgb 255 255 255;#P user radiogroup 94 306 73 16;#X size 1;#X offset 16;#X inactive 0;#X itemtype 1;#X flagmode 0;#X set 0;#X done;#P objectname DepthInherit;#P window setfont "Sans Serif" 12.;#P comment 7 271 64 196620 Depth;#B frgb 255 255 255;#P window setfont "Sans Serif" 9.;#P comment 109 237 45 196617 Inherit;#B frgb 255 255 255;#P user radiogroup 94 235 73 16;#X size 1;#X offset 16;#X inactive 0;#X itemtype 1;#X flagmode 0;#X set 0;#X done;#P objectname ColorInherit;#P flonum 94 217 40 9 0. 1. 8227 3 255 255 255 221 221 221 222 222 222 0 0 0;#P objectname ColR;#P flonum 220 217 40 9 0. 1. 8227 3 255 255 255 221 221 221 222 222 222 0 0 0;#P objectname ColA;#P flonum 178 217 40 9 0. 1. 8227 3 255 255 255 221 221 221 222 222 222 0 0 0;#P objectname ColB;#P flonum 136 217 40 9 0. 1. 8227 3 255 255 255 221 221 221 222 222 222 0 0 0;#P objectname ColG;#P comment 220 200 38 196617 Alpha;#B frgb 255 255 255;#P comment 178 200 38 196617 Blue;#B frgb 255 255 255;#P comment 136 200 38 196617 Green;#B frgb 255 255 255;#P comment 94 200 38 196617 Red;#B frgb 255 255 255;#P comment 7 219 64 196617 Position;#B frgb 255 255 255;#P window setfont "Sans Serif" 12.;#P comment 7 198 64 196620 Color;#B frgb 255 255 255;#P comment 7 98 64 196620 Blend;#B frgb 255 255 255;#P window setfont "Sans Serif" 9.;#P comment 7 124 70 196617 Mode source:;#B frgb 255 255 255;#P comment 109 167 45 196617 Enable;#B frgb 255 255 255;#P user radiogroup 94 165 73 16;#X size 1;#X offset 16;#X inactive 0;#X itemtype 1;#X flagmode 0;#X set 0;#X done;#P objectname BlendEnable;#P user umenu 94 124 158 196647 1 64 140 1;#X add 0: zero;#X add 1: one;#X add 2: destination color;#X add 3: source color;#X add 4: one minus destination color;#X add 5: one minus source color;#X add 6: source alpha;#X add 7: one minus source alpha;#X add 8: destination alpha;#X add 9: one minus destination alpha;#X add 10: source alpha saturate;#P objectname BlendModeSrc;#P flonum 94 48 40 9 0 0 8224 3 255 255 255 221 221 221 222 222 222 0 0 0;#P objectname RotAngle;#P flonum 220 48 40 9 0 0 8224 3 255 255 255 221 221 221 222 222 222 0 0 0;#P objectname RotZ;#P flonum 178 48 40 9 0 0 8224 3 255 255 255 221 221 221 222 222 222 0 0 0;#P objectname RotY;#P flonum 136 48 40 9 0 0 8224 3 255 255 255 221 221 221 222 222 222 0 0 0;#P objectname RotX;#P flonum 220 66 40 9 0. 0 8225 3 255 255 255 221 221 221 222 222 222 0 0 0;#P objectname ScaleZ;#P flonum 178 66 40 9 0. 0 8225 3 255 255 255 221 221 221 222 222 222 0 0 0;#P objectname ScaleY;#P flonum 136 66 40 9 0. 0 8225 3 255 255 255 221 221 221 222 222 222 0 0 0;#P objectname ScaleX;#P flonum 220 30 40 9 0 0 8224 3 255 255 255 221 221 221 222 222 222 0 0 0;#P objectname PosZ;#P flonum 178 30 40 9 0 0 8224 3 255 255 255 221 221 221 222 222 222 0 0 0;#P objectname PosY;#P flonum 136 30 40 9 0 0 8224 3 255 255 255 221 221 221 222 222 222 0 0 0;#P objectname PosX;#P comment 220 12 38 196617 Z;#B frgb 255 255 255;#P comment 178 12 38 196617 Y;#B frgb 255 255 255;#P comment 136 12 38 196617 X;#B frgb 255 255 255;#P comment 94 12 38 196617 Angle;#B frgb 255 255 255;#P comment 7 48 64 196617 Rotation:;#B frgb 255 255 255;#P comment 7 66 64 196617 Scale:;#B frgb 255 255 255;#P comment 7 30 64 196617 Position;#B frgb 255 255 255;#P hidden newex 158 734 106 196617 bgcolor 110 110 110;#P window setfont "Sans Serif" 12.;#P comment 7 8 81 196620 3D position;#B frgb 255 255 255;#P window setfont "Sans Serif" 9.;#P comment 7 362 64 196617 Color;#B frgb 255 255 255;#P user panel 1 1 265 86;#X brgb 110 110 110;#X frgb 255 255 255;#X border 1;#X rounded 0;#X shadow 0;#X done;#P user panel 1 92 265 95;#X brgb 110 110 110;#X frgb 255 255 255;#X border 1;#X rounded 0;#X shadow 0;#X done;#P user panel 1 192 265 66;#X brgb 110 110 110;#X frgb 255 255 255;#X border 1;#X rounded 0;#X shadow 0;#X done;#P user panel 1 264 265 64;#X brgb 110 110 110;#X frgb 255 255 255;#X border 1;#X rounded 0;#X shadow 0;#X done;#P user panel 1 335 265 112;#X brgb 110 110 110;#X frgb 255 255 255;#X border 1;#X rounded 0;#X shadow 0;#X done;#P user panel 1 629 265 67;#X brgb 110 110 110;#X frgb 255 255 255;#X border 1;#X rounded 0;#X shadow 0;#X done;#P comment 111 587 98 196617 Automatic material;#B frgb 255 255 255;#P user panel 1 454 265 168;#X brgb 110 110 110;#X frgb 255 255 255;#X border 1;#X rounded 0;#X shadow 0;#X done;#P hidden comment 635 238 133 196617 <- converting to list of ints;#P hidden connect 218 0 219 0;#P hidden fasten 130 0 127 0 351 343 340 343 340 298 351 298;#P hidden connect 127 0 130 0;#P hidden fasten 146 0 143 0 351 499 340 499 340 451 351 451;#P hidden connect 143 0 146 0;#P hidden fasten 152 0 149 0 351 567 340 567 340 519 351 519;#P hidden connect 149 0 152 0;#P hidden fasten 158 0 155 0 351 635 340 635 340 587 351 587;#P hidden connect 155 0 158 0;#P hidden fasten 164 0 161 0 351 703 340 703 340 655 351 655;#P hidden connect 161 0 164 0;#P hidden fasten 114 0 111 0 352 80 341 80 341 35 352 35;#P hidden connect 111 0 114 0;#P hidden fasten 119 0 116 0 352 150 341 150 341 105 352 105;#P hidden connect 116 0 119 0;#P hidden fasten 125 0 122 0 352 215 341 215 341 170 352 170;#P hidden connect 122 0 125 0;#P hidden fasten 200 0 198 0 352 277 341 277 341 232 352 232;#P hidden connect 198 0 200 0;#P hidden fasten 137 0 134 0 352 428 341 428 341 373 352 373;#P hidden connect 134 0 137 0;#P hidden fasten 128 0 130 1 409 319 364 319;#P hidden fasten 144 0 146 1 413 472 364 472;#P hidden fasten 150 0 152 1 409 540 364 540;#P hidden fasten 156 0 158 1 409 608 364 608;#P hidden fasten 162 0 164 1 414 676 364 676;#P hidden fasten 112 0 114 1 415 56 365 56;#P hidden fasten 117 0 119 1 428 126 365 126;#P hidden fasten 123 0 125 1 418 191 365 191;#P hidden fasten 199 0 200 1 452 253 365 253;#P hidden fasten 135 0 137 1 410 394 365 394;#P hidden fasten 129 0 130 2 467 321 377 321;#P hidden fasten 145 0 146 2 475 474 377 474;#P hidden fasten 151 0 152 2 467 542 377 542;#P hidden fasten 157 0 158 2 467 610 377 610;#P hidden fasten 163 0 164 2 477 678 377 678;#P hidden fasten 113 0 114 2 475 58 378 58;#P hidden fasten 118 0 119 2 490 128 378 128;#P hidden fasten 124 0 125 2 484 193 378 193;#P hidden fasten 136 0 137 2 468 396 378 396;#P hidden fasten 148 0 146 3 537 476 390 476;#P hidden fasten 154 0 152 3 529 544 390 544;#P hidden fasten 160 0 158 3 529 612 390 612;#P hidden fasten 166 0 164 3 540 680 390 680;#P hidden fasten 121 0 119 3 552 130 391 130;#P hidden fasten 139 0 137 3 526 398 391 398;#P hidden fasten 140 0 137 4 585 400 404 400;#P hidden fasten 130 1 128 0 364 345 337 345 337 296 409 296;#P hidden fasten 152 1 150 0 364 569 337 569 337 517 409 517;#P hidden fasten 158 1 156 0 364 637 337 637 337 585 409 585;#P hidden fasten 137 1 135 0 365 430 338 430 338 371 410 371;#P hidden fasten 146 1 144 0 364 501 337 501 337 449 413 449;#P hidden fasten 164 1 162 0 364 705 337 705 337 653 414 653;#P hidden fasten 114 1 112 0 365 82 338 82 338 33 415 33;#P hidden fasten 141 0 137 5 657 402 417 402;#P hidden fasten 125 1 123 0 365 217 338 217 338 168 418 168;#P hidden fasten 119 1 117 0 365 152 338 152 338 103 428 103;#P hidden fasten 142 0 137 6 732 404 430 404;#P hidden fasten 200 1 199 0 365 279 338 279 338 230 452 230;#P hidden fasten 130 2 129 0 377 347 334 347 334 294 467 294;#P hidden fasten 152 2 151 0 377 571 334 571 334 515 467 515;#P hidden fasten 158 2 157 0 377 639 334 639 334 583 467 583;#P hidden fasten 137 2 136 0 378 432 335 432 335 369 468 369;#P hidden fasten 114 2 113 0 378 84 335 84 335 31 475 31;#P hidden fasten 146 2 145 0 377 503 334 503 334 447 475 447;#P hidden fasten 164 2 163 0 377 707 334 707 334 651 477 651;#P hidden connect 131 0 130 10;#P hidden connect 147 0 146 10;#P hidden connect 153 0 152 10;#P hidden connect 159 0 158 10;#P hidden connect 165 0 164 10;#P hidden connect 115 0 114 10;#P hidden connect 120 0 119 10;#P hidden connect 126 0 125 10;#P hidden connect 201 0 200 10;#P hidden connect 138 0 137 10;#P hidden fasten 125 2 124 0 378 219 335 219 335 166 484 166;#P hidden fasten 119 2 118 0 378 154 335 154 335 101 490 101;#P hidden connect 202 0 115 0;#P lcolor 6;#P hidden connect 114 10 115 0;#P hidden connect 203 0 120 0;#P lcolor 6;#P hidden connect 119 10 120 0;#P hidden connect 204 0 126 0;#P lcolor 6;#P hidden connect 125 10 126 0;#P hidden connect 205 0 201 0;#P lcolor 6;#P hidden connect 197 0 201 0;#P hidden connect 207 0 131 0;#P lcolor 6;#P hidden connect 130 10 131 0;#P hidden connect 206 0 138 0;#P lcolor 6;#P hidden connect 137 10 138 0;#P hidden connect 209 0 147 0;#P lcolor 6;#P hidden connect 146 10 147 0;#P hidden connect 210 0 153 0;#P lcolor 6;#P hidden connect 152 10 153 0;#P hidden connect 211 0 159 0;#P lcolor 6;#P hidden connect 158 10 159 0;#P hidden connect 212 0 165 0;#P lcolor 6;#P hidden connect 164 10 165 0;#P hidden fasten 137 3 139 0 391 434 332 434 332 367 526 367;#P hidden connect 133 0 132 0;#P hidden fasten 152 3 154 0 390 573 331 573 331 513 529 513;#P hidden fasten 158 3 160 0 390 641 331 641 331 581 529 581;#P hidden fasten 146 3 148 0 390 505 331 505 331 445 537 445;#P hidden connect 213 0 202 0;#P lcolor 6;#P hidden fasten 164 3 166 0 390 709 331 709 331 649 540 649;#P hidden fasten 119 3 121 0 391 156 332 156 332 99 552 99;#P hidden connect 200 10 197 0;#P hidden connect 213 0 204 0;#P lcolor 6;#P hidden fasten 137 4 140 0 404 436 329 436 329 365 585 365;#P hidden connect 208 0 133 0;#P lcolor 6;#P hidden connect 132 0 133 0;#P hidden connect 213 0 211 0;#P lcolor 6;#P hidden connect 213 0 210 0;#P lcolor 6;#P hidden connect 213 0 209 0;#P lcolor 6;#P hidden connect 213 0 212 0;#P lcolor 6;#P hidden connect 213 0 203 0;#P lcolor 6;#P hidden connect 213 0 205 0;#P lcolor 6;#P hidden fasten 137 5 141 0 417 438 326 438 326 363 657 363;#P hidden fasten 137 6 142 0 430 440 323 440 323 361 732 361;#P hidden connect 213 0 208 0;#P lcolor 6;#P hidden connect 213 0 207 0;#P lcolor 6;#P hidden connect 213 0 206 0;#P lcolor 6;#P hidden connect 220 0 213 0;#P hidden connect 187 0 181 0;#P hidden connect 188 0 182 0;#P hidden connect 189 0 183 0;#P hidden connect 190 0 184 0;#P hidden connect 191 0 185 0;#P hidden connect 192 0 186 0;#P hidden connect 168 0 167 0;#P hidden connect 170 0 169 0;#P hidden connect 172 0 171 0;#P hidden connect 174 0 173 0;#P hidden connect 176 0 175 0;#P hidden connect 179 0 180 0;#P hidden connect 178 0 177 0;#P hidden connect 194 0 193 0;#P hidden connect 213 2 214 0;#P lcolor 7;#P hidden connect 213 2 215 0;#P lcolor 7;#P hidden connect 213 2 216 0;#P lcolor 7;#P hidden connect 213 2 217 0;#P lcolor 7;#P hidden connect 213 1 168 0;#P lcolor 6;#P hidden connect 167 0 168 0;#P hidden connect 213 1 170 0;#P lcolor 6;#P hidden connect 169 0 170 0;#P hidden connect 213 1 172 0;#P lcolor 6;#P hidden connect 171 0 172 0;#P hidden connect 215 0 174 0;#P lcolor 7;#P hidden connect 173 0 174 0;#P hidden connect 213 1 176 0;#P lcolor 6;#P hidden connect 175 0 176 0;#P hidden connect 213 1 179 0;#P lcolor 6;#P hidden connect 180 0 179 0;#P hidden connect 213 1 178 0;#P lcolor 6;#P hidden connect 177 0 178 0;#P hidden connect 214 0 194 0;#P lcolor 7;#P hidden connect 193 0 194 0;#P hidden connect 213 1 187 0;#P lcolor 6;#P hidden connect 181 0 187 0;#P hidden connect 182 0 188 0;#P hidden connect 217 0 188 0;#P lcolor 7;#P hidden connect 213 1 189 0;#P lcolor 6;#P hidden connect 183 0 189 0;#P hidden connect 213 1 190 0;#P lcolor 6;#P hidden connect 184 0 190 0;#P hidden connect 216 0 191 0;#P lcolor 7;#P hidden connect 185 0 191 0;#P hidden connect 216 0 192 0;#P lcolor 7;#P hidden connect 186 0 192 0;#P pop;