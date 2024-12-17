// this is the include file for the canal object
//Inspired from: "Canal_00.inc" by Friedrich A. Lohmueller, 2013

#ifndef( Pool_00_Inc_Temp)
#declare Pool_00_Inc_Temp = version;
#version 3.6;

//---------------------------------------------------------//
#macro Pool_00 ( Pool_X, // width in x
                 Pool_Z, // width in z 
                 Pool_Border_Width, // >0
                 Pool_Border_Height, // >0
                 Pool_Depth_Y,       // negativ value!  
                 Pool_Border_Texture_, // 
                 Pool_Water_Texture_//
               ) 
//---------------------------------------------------------//
#local D = 0.0001; 
//---------------------------------------------------------//
union{ 
  // pool border
  difference{ 
  box { <       -Pool_Border_Width, Pool_Depth_Y-0.10,        -Pool_Border_Width>,
        < Pool_X+Pool_Border_Width, Pool_Border_Height, Pool_Z+Pool_Border_Width>}   
  box { <     -0, Pool_Depth_Y,            0>,
        < Pool_X, Pool_Border_Height+D, Pool_Z>}   
      scale <1,1,1> rotate<0,0,0> translate<0,0,0> 
      texture { Pool_Border_Texture_ }  
    } // end of difference --------------------------------------
  // pool water

  box { <     -0, Pool_Depth_Y-D,            0>,
        < Pool_X, D, Pool_Z>}   
      texture { Pool_Water_Texture_ }  


} // end of union
// --------------------------------------------------------------------------------------
#end// of macro ------------------------------------------------------// end of macro

#version Pool_00_Inc_Temp;
#end
//------------------------------------- end of include file
