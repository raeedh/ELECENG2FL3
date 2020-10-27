P = [2.80 3.70 4.60];
A1 = [0.40 0.70 0.00];
A2 = [0.30 0.10 0.10];

A1_dot_A2 = dot(A1,A2) % dot product of A1 and A2

proj_A1_on_A2 = (dot(A1,A2)/dot(A2,A2))*A2 % projection of A1 onto A2

COS_theta = dot(A1,A2)/(norm(A1)*norm(A2)); % the cosine value of thex` angle between A1 and A2
theta = acos(COS_theta) % the angle between A1 and A2

A1_cross_A2 = cross(A1,A2) % the cross product of A1 and A2

A1_O = P-A1;
dist_A1_O = norm(cross(A1_O,(-A1/norm(-A1)))) % the shortest distance from origin to the line defined by vector A1 at P

dist_plane_O = norm(dot(A1_O,cross(A1,A2)/norm(cross(A1,A2)))) % the shortest distance from origin to the plane defined by vectors A1 and A2 at P