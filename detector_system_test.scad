
$fn = 30;

module essayTube(){
  r1    = 0.14;
  r2    = 0.30;
  alpha = 17.5;
  h     = (r2-r1)/tan(alpha/2);
  translate([0,0,r1]){
    cylinder(h,r1,r2);
    sphere(r1);
  }
  
  h = 0.50;
  r = r2;
  z = h + r1;
  translate([0,0,z]){
    cylinder(h,r,r);    
  }
  
}

module detectionHoles(){
  h = 4;
  r = 0.25;

  translate([0,0,r]){
    rotate( 90,[0,1,0]){cylinder(h,r,r);}
    rotate(-90,[1,0,0]){cylinder(h,r,r);}
    sphere(r);
  }
}

module objectTubeHoles(a,x,y,z){
  translate([x,y,z]){
    rotate(a,[0,0,1]){
      essayTube(); 
      detectionHoles();
    }
  }
}

difference(){

  heightOffset = 0.4;
  
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
