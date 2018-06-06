//TODO integrate this into the main file

// The {x, y, z, roll, pitch, yaw} that we want to end up at
//float pos[6] = {0, 0, 0, radians(0), radians(0), radians(0) };




/*void getmatrix(float pos[]) {
    float phi = pos[3];     // Roll
    float theta = pos[4];   // Pitch
    float psi = pos[5];     // Yaw
    M[0][0] = cos(psi)*cos(theta);
    M[1][0] = -sin(psi)*cos(phi)+cos(psi)*sin(theta)*sin(phi);
    M[2][0] = sin(psi)*sin(phi)+cos(psi)*cos(phi)*sin(theta);

    M[0][1] = sin(psi)*cos(theta);
    M[1][1] = cos(psi)*cos(phi)+sin(psi)*sin(theta)*sin(phi);
    M[2][1] = cos(theta)*sin(phi);

    M[0][2] = -sin(theta);
    M[1][2] = -cos(psi)*sin(phi)+sin(psi)*sin(theta)*cos(phi);
    M[2][2] = cos(theta)*cos(phi);
}
*/


float getAlpha() {
    // return arcsin(L / sqrt(M * M + N * N) ) ;
    return 0.1;
}
