
$fn = 30;

/**
 * Add global parameters
 */

HEIGHT_OFFSET = 2.0;

radiusHoles  = 2.5;
radiusLeds   = 2.7;   
radiusDiodes = 4.1;
HEIGHT_ADDITIONAL = max(radiusDiodes,radiusLeds) - radiusHoles;

tubeSeparation   = 10.0;
largeDetectors   =  8.0;
widthFilter      =  3.2;
widthInsideCube  = 24.0;
heightInsideCube = 14.0;


/**
 * Modules for Individual Tube and Holes
 */

module objectTube(){ 
  //Inferior Part:
  r1    = 1.5;
  r2    = 3.1;
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



/**
 * Display the result
 */

difference(){
  
  b = widthInsideCube + 2*(widthFilter + largeDetectors);
  c = heightInsideCube;
  translate([-b/2,-b/2,0]){cube([b,b,c]);}

  objectFourTubesHoles();
  objectFourFilters();
  objectAllExternalHoles();
}


