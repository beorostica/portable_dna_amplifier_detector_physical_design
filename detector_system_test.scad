
$fn = 30;

/**
 * Add global parameters
 */

HEIGHT_OFFSET    = 0;
tubeSeparation   = 1.00;
largeDetectors   = 0.80;
widthFilter      = 0.32;
widthInsideCube  = 2.40;
heightInsideCube = 1.00;


/**
 * Modules for Individual Tube and Holes
 */

module objectTube(){
  r1    = 0.14;
  r2    = 0.30;
  alpha = 17.5;
  h     = (r2-r1)/tan(alpha/2);
  translate([0,0,r1]){
    cylinder(h,r1,r2);
    sphere(r1);
  }
  
  h = 2.00;        //Just a large length
  r = r2;
  z = h + r1;
  translate([0,0,z]){
    cylinder(h,r,r);    
  }
  
}

module objectHoles(){
  h = 4;        //Just a large length
  r = 0.25;
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
  a = widthInsideCube + widthFilter + largeDetectors + 1;    //Just a large length 
  b = widthFilter;
  c = heightInsideCube + 1;   //Just a large length;
  translate([x,y,z]){
    rotate(angle,[0,0,1]){
      cube([a,b,c]);
    }
  }
}


/**
 * Modules for adding four elements
 */

module objectFourTubesHoles(){
  angle = 90;
  d     = tubeSeparation/2;
  z     = 0 + HEIGHT_OFFSET;
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




//Display the result
objectFourTubesHoles();
objectFourFilters();



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