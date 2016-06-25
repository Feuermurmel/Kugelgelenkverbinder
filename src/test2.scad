$fn = 32;

length = 20;
diameter = 15;
stud_width = 10;
gap = 0.1;

wall_thickness = 2;


module inner_joint_part() {
	cylinder(d = stud_width, h = length);
	
	sphere(d = diameter - wall_thickness - gap);
}


module assembly() {
	difference() {
		union() {
			translate([0, 0, diameter / 2]) {
				cylinder(d = diameter, h = length);
			}
			
			inner_joint_part();
		}
		
		translate([0, 0, length]) {
			for (i = [-2:2]) {
				rotate([0, i * 90 / 2, 0]) {
					inner_joint_part();
				}
			}
		}
	}
}
	
difference() {
	assembly();
	
	translate([0, 0, 1 + wall_thickness / 2 - diameter / 2 - 50]) {
		cube(100, center = true);
	}
}