# Instructions for new users

* Download the scad files and keep them in the same directory.  
  * joints.scad is a library that creates the pins for connecting parts
  * standing_desk.scad contains the meat of the code
  * assembled.scad shows a 3D view of the assemlbed box
  * cutsheet.scad files are for generating the 2D output for actually cutting
* Open assembled.scad and optionally cutsheet.scad in OpenSCAD
* Make sure Design -> Automatic Reload and Compile is checked
* Edit plant_shelf.scad in a text editor.  After saving changes the OpenSCAD windows should update. 
* Play with the numbers to create the box you want.  A visual representation of what the different variables do is shown below.
* Once complete render the 2D files by pressing F6
* File -> Export DXF or SVG
* The cutsheets aren't smart enough to scale for all box sizes.  Some options to fix this:
  * Edit functions.scad
  * Try to drag the drawings in your CAM program.  Some will support this.
  * Open the DXF or SVG in Inkscape
  * Post a copy of variables.scad on the Maslow forums.  I *might* be able to post a fixed cutsheet module.  

# Variables

Below is a visual representation of changing some of the variables.

## curve_r_demo
![](https://raw.githubusercontent.com/AaronVerDow/StandingDesk/master/animations/output/curve_r_demo.gif)
## explode_demo
![](https://raw.githubusercontent.com/AaronVerDow/StandingDesk/master/animations/output/explode_demo.gif)
## slide_angle_demo
![](https://raw.githubusercontent.com/AaronVerDow/StandingDesk/master/animations/output/slide_angle_demo.gif)
## slide_demo
![](https://raw.githubusercontent.com/AaronVerDow/StandingDesk/master/animations/output/slide_demo.gif)
