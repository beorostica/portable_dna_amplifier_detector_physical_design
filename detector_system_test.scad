
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

essayTube();
detectionHoles();
