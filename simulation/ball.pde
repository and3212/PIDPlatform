class Ball {
    private PVector position = new PVector(0, 0, 1000);
    private PVector velocity = new PVector(0, 0, 0);
    private int radius;
    private final float FRICTION = 0.8;    //TODO Ask Elijah about this


    Ball(int r) {
        radius = r;
    }

    // Moves the ball to a specific location
    void update(PVector p) {
        position = p;
        velocity.x = 0;
        velocity.y = 0;
        velocity.z = 0;
    }

    // Resets the ball to the default state
    private void reset() {
        position.x = 0;
        position.y = 0;
        position.z = PLATFORM_TOP + 500;
        velocity.x = 0;
        velocity.y = 0;
        velocity.z = 0;
    }

    // Updates the position of the ball
    void move() {
        int platformTop = platform.getZ((int)position.x, (int)position.y);  // The ball cannot go lower than this point
        PVector v = platform.getPlaneVector();
        float theta = acos(v.z / sqrt(v.x * v.x + v.y * v.y + v.z * v.z));

        // Updates Z direction
        velocity.z -= GRAVITY;
        position.z += velocity.z;

        // If we are on the platform
        if (position.z <= platformTop + radius + PLATFORM_HEIGHT) {
            position.z = platformTop + radius + PLATFORM_HEIGHT;

            velocity.x -= GRAVITY * platform.dxDZ();
            position.x += velocity.x * FRICTION;

            velocity.y -= GRAVITY * platform.dyDZ();
            position.y += velocity.y * FRICTION;

            // Resets the ball if it rolls off of the platform
            if (position.x > platform.getLength() || position.x < -platform.getLength() ||
                position.y > platform.getWidth()  || position.y < -platform.getWidth()) {
                reset();
            }

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
