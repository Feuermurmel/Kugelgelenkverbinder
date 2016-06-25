$fn = 64;

ball_diameter = 15;
gap = 0.1;
thickness = 1.5;

distance = 18;

joint_teeth_width = 9;
joint_teeth_height = 12;
joint_teeth_positive_offset = -0.8;
joint_teeth_negative_offset = 0;
joint_teeth_count = 3;


module teeth_cylinder(offset) {
	translate([0, 1, offset]) {
		rotate([90, 0, 0]) {
			scale([joint_teeth_width, joint_teeth_height, 1]) {
				cylinder(d = 1, h = 100);
			}
		}
	}
}

module join_negative_shape() {
	for (i = [0:joint_teeth_count - 1]) {
		rotate([0, 0, 360 * i / joint_teeth_count]) {
			scale([1, 1, -1]) {
				teeth_cylinder(joint_teeth_negative_offset);
			}
		}
	}
}

module join_positive_shape() {
	for (i = [0:joint_teeth_count - 1]) {
		rotate([0, 0, 360 * (i + 1 / 2) / joint_teeth_count]) {
			teeth_cylinder(joint_teeth_positive_offset);
		}
	}
}


intersection() {
	difference() {
		union() {
			translate([0, 0, distance]) {
				sphere(d = ball_diameter + thickness * 2);
			}
			
			cylinder(d = ball_diameter / 2, h = distance);
		}
		
		translate([0, 0, distance]) {
			sphere(d = ball_diameter + gap);
			
			join_negative_shape();
		}
	}

	translate([0, 0, distance]) {
		join_positive_shape();
		
		translate([0, 0, -50]) {
			cube(100, center = true);
		}
	}
}

difference() {
	sphere(d = ball_diameter - gap);
	
	translate([0, 0, -50 - ball_diameter / 2 + 1]) {
		cube(100, center = true);
	}
}
