
$fn = 30;

/**
 * Add global parameters
 */

HEIGHT_OFFSET = 0.2;

radiusHoles  = 0.25;
radiusLeds   = 0.30;   
radiusDiodes = 0.40;
HEIGHT_ADDITIONAL = max(radiusDiodes,radiusLeds) - radiusHoles;

tubeSeparation   = 1.00;
largeDetectors   = 0.80;
widthFilter      = 0.32;
widthInsideCube  = 2.40;
heightInsideCube = 1.00;


/**
 * Modules for Individual Tube and Holes
 */

module objectTube(){ 
  //Inferior Part:
  r1    = 0.14;
  r2    = 0.30;
  alpha = 17.5;
  dh    = (r2-r1)/tan(alpha/2);
  translate([0,0,r1]){
    cylinder(dh,r1,r2);
    sphere(r1);
  }
  //Superior Part:
  h = heightInsideCube - HEIGHT_ADDITIONAL - dh - r1 + 1; 
  r = r2;                           //"h" is just a large length
  z = dh + r1;
  translate([0,0,z]){
    cylinder(h,r,r);    
  }
}

module objectHoles(){
  h = 0.5*(widthInsideCube-tubeSeparation) + widthFilter + largeDetectors + 1;  
  r = radiusHoles;                  //"h" is just a large length
  translate([0,0,r]){
    rotate( 90,[0,1,0]){cylinder(h,r,r);}
    rotate(-90,[1,0,0]){cylinder(h,r,r);}
    sphere(r);
  }
}

module objectTubeHoles(angle,x,y,z){
  translate([x,y,z]){
    rotate(angle,[0,0,1]){
      objectTube(); 
      objectHoles();
    }
  }
}


/**
 * Modules for Individual Optical Filters
 */

module objectFilter(angle,x,y,z){
  a = widthInsideCube + widthFilter + largeDetectors + 1;     
  b = widthFilter;                  //"a" and "c" are just large lengths
  c = heightInsideCube + 1;         
  translate([x,y,z]){
    rotate(angle,[0,0,1]){
      cube([a,b,c]);
    }
  }
}

/**
 * Modules for Individual External Holes
 */

module objectExternalHole(radius){
  h = 0.5*widthFilter + largeDetectors + 1;
  r = radius;
  translate([0,0,radiusHoles]){
    rotate(90,[0,1,0]){
      cylinder(h,r,r);
    }
  }
}


/**
 * Modules for adding multiple elements
 */

module objectFourTubesHoles(){
  angle = 90;
  d     = tubeSeparation/2;
  z     = HEIGHT_ADDITIONAL + HEIGHT_OFFSET;
  objectTubeHoles(0*angle, d, d, z);
  objectTubeHoles(1*angle,-d, d, z);
  objectTubeHoles(2*angle,-d,-d, z);
  objectTubeHoles(3*angle, d,-d, z);
}

module objectFourFilters(){
  angle = 90;
  d     = widthInsideCube/2;
  z     = 0 + HEIGHT_OFFSET;
  objectFilter(0*angle,-d, d, z);
  objectFilter(1*angle,-d,-d, z);
  objectFilter(2*angle, d,-d, z);
  objectFilter(3*angle, d, d, z);
}

module objectAllExternalHoles(){
  angle = 90;
  p = 0.5*(widthInsideCube + widthFilter);
  q = tubeSeparation/2;
  z = HEIGHT_ADDITIONAL + HEIGHT_OFFSET;
  translate([ p, q, z]){rotate(0*angle,[0,0,1]){objectExternalHole(radiusLeds);}}
  translate([ p,-q, z]){rotate(0*angle,[0,0,1]){objectExternalHole(radiusLeds);}}
  translate([-q, p, z]){rotate(1*angle,[0,0,1]){objectExternalHole(radiusDiodes);}}
  translate([ q, p, z]){rotate(1*angle,[0,0,1]){objectExternalHole(radiusDiodes);}}
  translate([-p,-q, z]){rotate(2*angle,[0,0,1]){objectExternalHole(radiusLeds);}}
  translate([-p, q, z]){rotate(2*angle,[0,0,1]){objectExternalHole(radiusLeds);}}
  translate([-q,-p, z]){rotate(3*angle,[0,0,1]){objectExternalHole(radiusDiodes);}}
  translate([ q,-p, z]){rotate(3*angle,[0,0,1]){objectExternalHole(radiusDiodes);}}  
}



//Display the result:
objectFourTubesHoles();
objectFourFilters();
objectAllExternalHoles();




/*
module insideCube(){
  b = widthInsideCube;
  c = heightInsideCube;
  translate([-b/2,-b/2,0]){cube([b,b,c]);}
}
*/

/*
heightOffset = 0.4;

difference(){
  
  b = 2.4;
  c = 1 + heightOffset;
  translate([-b/2,-b/2,0]){cube([b,b,c]);}
    
  a = 90;
  d = 0.5;
  z = 0 + heightOffset;
  objectTubeHoles(0*a, d, d, z);
  objectTubeHoles(1*a,-d, d, z);
  objectTubeHoles(2*a,-d,-d, z);
  objectTubeHoles(3*a, d,-d, z);
    
}
*/