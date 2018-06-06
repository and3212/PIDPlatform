class Ball {
    private PVector position = new PVector(0, 0, 1000);
    private PVector velocity = new PVector(0, 0, 0);
    private int radius;

    Ball(int radius_) {
        radius = radius_;
    }

    void update(PVector p) {
        position = p;
        velocity.x = 0;
        velocity.y = 0;
        velocity.z = 0;
    }

    // Updates the position of the ball
    void move() {
        int platformTop = platform.getZ((int)position.x, (int)position.y);
        PVector v = platform.getPlaneVector();
        float theta = acos(v.z / sqrt(v.x * v.x + v.y * v.y + v.z * v.z));

        // Updates Z direction
        velocity.z -= GRAVITY;
        position.z += velocity.z;

        // If we are on the platform
        if (position.z <= platformTop + radius + PLATFORM_HEIGHT) {
            position.z = platformTop + radius + PLATFORM_HEIGHT;

            velocity.x -= GRAVITY * platform.dxDZ();
            println(platform.dxDZ());
            position.x += velocity.x;

            velocity.y -= GRAVITY * platform.dyDZ();
            position.y += velocity.y;
        } else {
            velocity.x = 0;
            velocity.y = 0;
        }

    }

    // Draws the ball to the screen
    void draw() {
        fill(150);
        noStroke();

        pushMatrix();
        translate(position.x, position.y, position.z);
        sphere(radius);
        popMatrix();
    }
}
