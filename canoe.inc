// canoe.inc
// Include file for canoe object/boat in POV-Ray

#ifndef(Canoe_Inc_Temp)
#declare Canoe_Inc_Temp = version;
#version 3.6;

#include "colors.inc"
#include "textures.inc"

// Canoe construction
#declare Canoe_outside = 
sphere {<0,0,0>, 1 scale <3,1.5,1> rotate<0,0,0> translate<0,0.5,0>}

#declare Canoe =
union{
    intersection{
        object{ Canoe_outside }
        object{ Canoe_outside scale <0.98,0.95,0.94> inverse}
        sphere {<0,0,0>,1 scale <2.5,1,20> rotate<0,0,0> translate<0,1.3,0> inverse}
        texture{ 
            pigment{ color White*1.1}
            finish { phong 1}
        }
    } // end of outside structure of the canoe

    intersection{  //seats design
        object{ 
            Canoe_outside
            texture{ 
                pigment{ color White*1.1}
                finish { phong 1}
            }
        }
        union{
            box {<-0.20,0,-1>,<0.20,0.05,1> rotate<0,0,  0> translate< 0.0,0.21,0>}
            box {<-0.20,0,-1>,<0.20,0.05,1> rotate<0,0,-10> translate<-2.0,0.40,0>}
            box {<-0.20,0,-1>,<0.20,0.05,1> rotate<0,0, 10> translate< 2.0,0.40,0>}
            texture{ 
                pigment{ color MediumWood}
                finish { phong 1}
            }
        }// end of inside union
    }//end of inside intersection
}// end of Canoe


#version Canoe_Inc_Temp;
#end