class Platform {
    // D is based off of anchor A
    private float d;
    private PVector v1 = new PVector(0, 0, 0);  //HEX_AX - HEX_BX, HEX_AY - HEX_BY, 0
    private PVector v2 = new PVector(0, 0, 0);  //HEX_CX - HEX_BX, HEX_CY - HEX_BY, 0
    private PVector v3 = new PVector(0, 0, 0);
    private int PLATFORM_LENGTH;
    private int PLATFORM_WIDTH;
    private int PLATFORM_HEIGHT;

    Platform(int l, int w, int h){
        PLATFORM_LENGTH = l;
        PLATFORM_WIDTH = w;
        PLATFORM_HEIGHT = h;
    }

    // Updates the plaftorm
    void update(PVector pA, PVector pB, PVector pC){
        // Creates the first vector
        v1.x = pA.x - pB.x;
        v1.y = pA.y - pB.y;
        // v1.z = pA.z - pB.z;
        v1.z = 130;

        // Creates the second vector
        v2.x = pC.x - pB.x;
        v2.y = pC.y - pB.y;
        v2.z = pC.z - pB.z;

        // Creates the normal vector and solves for d
        v3.x = (v1.y * v2.z - v1.z * v2.y);
        v3.y = (v1.z * v2.x - v1.x * v2.z);
        v3.z = (v1.x * v2.y - v1.y * v2.x);
        d = (pA.x * v3.x) + (pA.y * v3.y) + (pA.z * v3.z);  //TODO if pA doesnt work add a pR
    }

    PVector getPlaneVector() {
        return v3;
    }

    int getZ(int x, int y) {
        // z = (-a/c)x + (-b/c)y + d/c
        // a = v.x
        // b = v.y
        // c = v.z

        float z = (-v3.x / v3.z) * x + (-v3.y / v3.z) * y + (d / v3.z);
        return (int)z;
    }


    // dx/dz = -a/c
    float dxDZ() {
        return -v3.x / v3.z;
    }

    // dy/dz = -b/c
    float dyDZ() {
        return -v3.y / v3.z;
    }

    // Draws the platform
    void draw() {
        // Calculates the Z coordinates for each corner
        int z1_b = getZ(PLATFORM_LENGTH, PLATFORM_WIDTH);
        int z2_b = getZ(-PLATFORM_LENGTH, PLATFORM_WIDTH);
        int z3_b = getZ(-PLATFORM_LENGTH, -PLATFORM_WIDTH);
        int z4_b = getZ(PLATFORM_LENGTH, -PLATFORM_WIDTH);
        int z1_t = z1_b + PLATFORM_HEIGHT;
        int z2_t = z2_b + PLATFORM_HEIGHT;
        int z3_t = z3_b + PLATFORM_HEIGHT;
        int z4_t = z4_b + PLATFORM_HEIGHT;
        fill(0,100,100);
        stroke(255);

        beginShape(QUADS);
        // Bottom
        vertex(PLATFORM_LENGTH, PLATFORM_WIDTH, z1_b);
        vertex(-PLATFORM_LENGTH, PLATFORM_WIDTH, z2_b);
        vertex(-PLATFORM_LENGTH, -PLATFORM_WIDTH, z3_b);
        vertex(PLATFORM_LENGTH, -PLATFORM_WIDTH, z4_b);

        // Sides
        vertex(PLATFORM_LENGTH, PLATFORM_WIDTH, z1_b);
        vertex(PLATFORM_LENGTH, PLATFORM_WIDTH, z1_t);
        vertex(-PLATFORM_LENGTH, PLATFORM_WIDTH, z2_t);
        vertex(-PLATFORM_LENGTH, PLATFORM_WIDTH, z2_b);

        vertex(-PLATFORM_LENGTH, PLATFORM_WIDTH, z2_b);
        vertex(-PLATFORM_LENGTH, PLATFORM_WIDTH, z2_t);
        vertex(-PLATFORM_LENGTH, -PLATFORM_WIDTH, z3_t);
        vertex(-PLATFORM_LENGTH, -PLATFORM_WIDTH, z3_b);

        vertex(-PLATFORM_LENGTH, -PLATFORM_WIDTH, z3_b);
        vertex(-PLATFORM_LENGTH, -PLATFORM_WIDTH, z3_t);
        vertex(PLATFORM_LENGTH, -PLATFORM_WIDTH, z4_t);
        vertex(PLATFORM_LENGTH, -PLATFORM_WIDTH, z4_b);

        vertex(PLATFORM_LENGTH, -PLATFORM_WIDTH, z4_b);
        vertex(PLATFORM_LENGTH, -PLATFORM_WIDTH, z4_t);
        vertex(PLATFORM_LENGTH, PLATFORM_WIDTH, z1_t);
        vertex(PLATFORM_LENGTH, PLATFORM_WIDTH, z1_b);

        // Top
        vertex(PLATFORM_LENGTH, PLATFORM_WIDTH, z1_t);
        vertex(-PLATFORM_LENGTH, PLATFORM_WIDTH, z2_t);
        vertex(-PLATFORM_LENGTH, -PLATFORM_WIDTH, z3_t);
        vertex(PLATFORM_LENGTH, -PLATFORM_WIDTH, z4_t);
        endShape();
    }
}
