// POV-Ray 3.7  Scene File "Suman-Khadka.pov"
// author: Suman Khadka
// author-email: sk394@uakron.edu
// brief-description of the scene:  This will contain a city landscape with tall buildings in one side of the road
// and a canal with boats on the other side of the road. The scene will also contain trees and trucks on the road.

//--------------------------------------------------------------------------
#version 3.7; // 3.7; // 3.6
global_settings{ assumed_gamma 1.0 } 
#default{ finish{ ambient 0.1 diffuse 0.9 conserve_energy}}
//--------------------------------------------------------------------------
#include "colors.inc"
#include "textures.inc"
#include "glass.inc"
#include "metals.inc"
#include "golds.inc"
#include "stones.inc"
#include "woods.inc"
#include "shapes.inc"
#include "shapes2.inc"
#include "functions.inc"
#include "math.inc"
#include "transforms.inc"

// locals (these are included to reduce the redudancy and reusability the objects)
#include "canoe.inc"
#include "tree.inc"
#include "truck.inc"
#include "pool.inc"
#include "business_building.inc"

//Camera_Position, Camera_look_at, Camera_Angle - for animation for the trucks moving in the road
#declare Camera_Number = -1 ;
#declare Rapport = 3.00; // in z+  center lines

#declare Truck_Rapport = 12.00;  // truck distance

#declare Camera_Move = Rapport*clock;
#declare Truck_Move = -20.00 + Truck_Rapport*clock*2 - Camera_Move;

//--------------------------------------------------------------------------------------------------------<<<<
#switch ( Camera_Number )
#case (0)
  #declare Camera_Position = < 0.00, 1.00, -5.00> ;  // front view
  #declare Camera_Look_At  = < 0.00, 1.00,  0.00> ;
  #declare Camera_Angle    =  65 ;
#break
#case (1)
  #declare Camera_Position = <8.0 , 5.0 ,-0.0 + Camera_Move> ;  // left-diagonal view
  #declare Camera_Look_At  = <3.5 , 0.9 , 2.8+ Camera_Move> ;
  #declare Camera_Angle    =  35  ;
#break
#case (2)
  #declare Camera_Position = <7.0 , 7.0 ,-2.0> ;  // right-diagonal view
  #declare Camera_Look_At  = <3 , 0.9 , 2.8> ;
  #declare Camera_Angle    =  35  ;
#break
#case (3)
  #declare Camera_Position = < 0.00, 8.00,  0+0.000> ;  // top view
  #declare Camera_Look_At  = < 0.00, 0.00,  0+0.001> ;
  #declare Camera_Angle    =  65 ;
#break
#else
  #declare Camera_Position = < 0.00, 10,-20.00> ;  // front view
  #declare Camera_Look_At  = < 0.00, 3.00,  0.00> ;
  #declare Camera_Angle    =  60 ;
#break
#end 

//-----------------------------------------------
camera{ location Camera_Position
        right    x*image_width/image_height
        angle    Camera_Angle
        look_at  Camera_Look_At
      }
// sun ----------------------------------------------
light_source {
    <1500, 2500, -2500>
    color rgb <0.9, 0.9, 0.8>
    parallel
    point_at <0, 0, 0>
}
// sky ------------------------------------------------
sky_sphere{ pigment{ gradient <0,1,0>
                     color_map{ [0   color rgb<1,1,1>         ]//White
                                [0.4 color rgb<0.14,0.14,0.56>]//~Navy
                                [0.6 color rgb<0.14,0.14,0.56>]//~Navy
                                [1.0 color rgb<1,1,1>         ]//White
                              }
                     scale 2 }
           } 

// fog
fog{
    fog_type 2
    distance 50
    color White
    fog_offset 0.1
    fog_alt 2.0
    turbulence 0.8
}

// Ground plane
plane{
    <0,1,0>, 0
    texture{
        pigment{
            color rgb<0.35, 0.65, 0.0> * 0.9
        }
        normal {
            bumps 0.75
            scale 0.015
        }
        finish{
            phong 0.1
        }
    }
}

// Place big canal in the middle of the scene 
#declare  Canal_Border_Texture = 
       texture{ pigment{ color rgb <1.00, 1.00, 1.00>} 
                normal { agate 0.5 scale 0.15 }
                finish { phong 1 } 
                scale 0.25 translate<0,0,0>
              }  

#declare Canal_Water_Texture =
         texture { Polished_Chrome
                   normal { bumps 0.15 scale 0.25} 
                   finish { reflection 0.65 } 
                 } // end of texture 
 
#declare Canal = object{ Pool_00( 22.00, // width in x
                 6.00, // width in z 
                 0.50, // Pool_Border_Width,  
                 1, // Pool_Border_Height,
                 -1, // Pool_Depth_Y,   
                 Canal_Border_Texture, 
                 Canal_Water_Texture 
               ) 
    scale <1,0,1> 
    translate<-11,0,0>  
 } 

 // boats on the water surface
 #declare boat = object{
    Canoe
    scale 0.7
 }

 // union of pool and boat
 union{
    object{
        Canal
    }
    object{
        boat
        translate <1,0.5,2.9>
    }
    object{
        boat
        translate <-6, 0.5, 4>
        scale<1,1,1>
        rotate<0,60,0>
        translate <-6,0,-4.1>
    }
 }

 // canal bank (It sets the gap between canal and road)
 difference{
   box { <-22.6, -1, -1>, <0.5, 1, 1> }
  box { <0.5, 0, -1>, <0.5, 0, 1> }
    pigment {
        color rgb <0.6, 0.5, 0.4>
    }
    normal{
        bumps 0.5 
        scale 0.01
    }
    finish{
        ambient 0.1 
        diffuse 0.7
    }
    translate<11, 0.6, 8>  
    scale 1
 }

// roads along with trucks (animation will be applied to the trucks )
#declare Truck_Texture =  
    texture{ 
        pigment{ 
            color rgb<1,1,1>*1.1
        }
        finish {
            phong 1
            }
    }

#declare Wheel_Angle = 0;
// trucks going left to right
object{
    Truck_12(
        Wheel_Angle, // front wheel angle
        Truck_Texture
    )
    scale 0.6
    rotate<0,0,0> 
    translate<0+Truck_Move+Truck_Rapport,0,15.5>
}

object{
    Truck_12(
        Wheel_Angle, // front wheel angle
        Truck_Texture
    )
    scale 0.6
    rotate<0,0,0> 
    translate<6+Truck_Move+Truck_Rapport,0,15.5>
}

object{
    Truck_12(
        Wheel_Angle, // front wheel angle
        Truck_Texture
    )
    scale 0.6
    rotate<0,0,0> 
    translate<15+Truck_Move+Truck_Rapport*2,0,15.5>
}
// truck going right to left direction
object{
    Truck_12(
        Wheel_Angle, // front wheel angle
        Truck_Texture
    )
    scale 0.6
    rotate<0,180,0> 
    translate<-18-Truck_Move*2-Truck_Rapport,0,13>
}

// street union (road plus white lines)
union{
 // asphalt
 box{ <-3.00, 0.00,-500>,< 3.00, 0.0005, 500>
      texture{ pigment{ color rgb<1,1,1>*0.1}
               normal { bumps 0.5 scale 0.005}
               finish { phong 0.5}
             } // end of texture
    }// end box

 // street center lines
 union{ 
 #local Nr = -500;   // start
 #local EndNr = 500; // end
 #while (Nr< EndNr)

 box{ <-0.1, 0.00, 0>,< 0.1, 0.0015, 1.50>
      texture{ pigment{ color rgb<1,1,1>*1.1}
               finish { phong 0.5}
             } // end of texture

      translate<0,0,Nr*3.00>}

 #local Nr = Nr + 1;  // next Nr
 #end // --------------- end of loop
 }// end center lines
rotate<0,90,0>
translate<0,0,15>
} // end of union 

// Buildings on the road side
object{ BusinessBuilding_000( 
                    6, // Nx_Elements,  // number of elements in -x,  integer >= 1
                    1, // Ny_Floors,    // number of floors in    y,  integer >= 1
                    3, // Nz_Elements,  // number of elements in +z,  integer >= 1
                    3, // N_of_Windows_per_Element, // 

                   2.30, // Win_H,       // window height  
                   0.80, // Win_Tween_H, // windows tween height 
                   1.00, // Win_W,       // window width   
                   0.10, // Win_Frame_D, // window frame thickness 
                   0.35, // Wall_D,  // wall thickness 
                   0.50, // Floor_D, // floor thickness 
                 ) //------------------------------------------------------------------//
        // width in -x = Nx_Elements*( N_of_Windows_per_Element*Win_W+Wall_D)+Wall_D;   
        // width in +z = Nz_Elements*( N_of_Windows_per_Element*Win_W+Wall_D)+Wall_D;   
        // top level =  Ny_Floors*(Win_H + Floor_D) + Floor_D; 
        scale <1,1,1>*1
        rotate<0, 0,0> 
        translate<-12.00,0.00, 18.2> 
      } 
object{ BusinessBuilding_000( 4, 4,3, 2, 2.30,  0.80,1.00, 0.10, 0.35, 0.50,) 
        scale <1,1,1>*1
        rotate<0, 0,0> 
        translate<0.00,0.00, 18.2> 
      } 
object{ BusinessBuilding_000( 4, 2, 3, 2, 2.30, 0.80, 1.00, 0.10, 0.35,0.50, ) 
        scale <1,1,1>*1
        rotate<0, 0,0> 
        translate<10.0,0.00, 18.2> 
      }
object{ BusinessBuilding_000(  4,  8,  3,  4, 2.30,  0.80, 1.00, 0.10, 0.35,  0.50, ) 
        scale <1,1,1>*1
        rotate<0, 0,0> 
        translate<30,0.00, 18.2> 
      } 

// Trees by the canal
#declare tree = object{ Tree_00 
        scale <1,1,1>*1
        rotate<0,0,0> 
        translate<0.00,0.00, -4.9>
    }
object{ tree }
// trees on the left bank
object{ tree
        translate<-7,0.00, 3.7>
    }
object{ tree
    translate<-6.5,0.00, -1>
}
object{ tree
    translate<-10,0.00, 2>
}
//trees on the right bank
object{ tree
        translate<7,0.00, 2>
    }
    object{ tree
        translate<9,0.00, 1>
    }

// Name on the ground
    text {
      ttf "crystal.ttf" "Suman Khadka" 0.15, 0
      pigment { color rgb<1,0.8,0.0> }
      finish { reflection .25 specular 1 }
      translate <-2.4, 0.2,-6.6>
    }

