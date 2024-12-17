// this is the include file for the tree object
// Multiple trees can be created by using this include file

#ifndef( Tree_00_Inc_Temp)
#declare Tree_00_Inc_Temp = version;
#version 3.6;


#ifndef(Colors_Inc_Temp)
#include "colors.inc"                                             
#end
#ifndef(Textures_Inc_Temp)
#include "textures.inc"                                             
#end
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
#ifndef(  Tree_00_Texture)
#declare Tree_00_Texture = 
         texture { 
              pigment{ gradient <0,1,0> turbulence 1.5
                       color_map{
                          [0.0 color rgb<0.07,0.5,0.0>]
                          [0.2 color rgb<0.10,0.7,0.0>]
                          [0.4 color rgb<0.16,0.5,0.1>]
                          [0.6 color rgb<0.20,0.8,0.1>]
                          [0.7 color rgb<0.10,0.3,0.0>]
                          [0.9 color rgb<0.02,0.4,0.0>]
                          [1.0 color rgb<0.06,0.5,0.0>]
                         } // end of color_map                            
                        scale 0.1 
                      } // end of pigment                                     
              normal { bumps 0.5 scale 0.015} 
              finish { ambient 0.1 diffuse 0.85  phong 0.6}
            } // end of texture
#end


#ifndef(  Trunk_00_Texture)
#declare Trunk_00_Texture = 
         texture { pigment { color rgb<0.40,0.25,0.15>}
                   normal  { bumps 0.5 scale <0.005,0.25,0.005>}
                   finish  { ambient 0.15 diffuse 0.85 phong 0.5}
                 } // end of texture
#end

//-----------------------------------------------------------------------------/////////  
#declare Tree_00 =
union{
  
 isosurface {

    function{ sqrt(abs( x*x + y*y+ z*z - 1))  
              - f_noise3d( x*7, y*7, z*7 )*1.05 
             }

    contained_by { box { -1.25, 1.25 } }
    accuracy 0.001
    max_gradient 155

    texture{ Tree_00_Texture }  
    scale 0.9
    translate <0,2.5,0> 
  } // end of isosurface -----------------------


 cylinder{ <0,0,0>,<0,2.0,0>,0.2 
           texture{ Trunk_00_Texture }  

  } // end of cylinder ------------------------- 
} // end of union -------------------------------------- end of Tree ------------////////



#version Tree_00_Inc_Temp;
#end
//------------------------------------- end of include file

