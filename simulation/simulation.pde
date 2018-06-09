// Physics constants
final int DIMENSION_SCALE = 3;  // All units are in mm and are scaled up by x3
final float GRAVITY = 7.85;

// Camera settings
float rotX = radians(270);
float rotY = radians(0);
float rotZ = radians(0);
float zoom = 0.5;
float xTrans = 0;
float yTrans = -200;
float rotX_saved = radians(270);
float rotY_saved = radians(0);
float rotZ_saved = radians(0);
float zoom_saved = 0.5;
float xTrans_saved = 0;
float yTrans_saved = -200;
boolean zEnabled = false;

// Platform dimensions
final int PLATFORM_LENGTH = (165 * DIMENSION_SCALE);
final int PLATFORM_WIDTH = (105 * DIMENSION_SCALE);
final int PLATFORM_HEIGHT = 4 * DIMENSION_SCALE;
final int PLATFORM_BOTTOM = (150 * DIMENSION_SCALE);
final int PLATFORM_TOP = PLATFORM_BOTTOM + PLATFORM_HEIGHT;

// Hexagon plate dimensions
final int HEXPLATE_BOTTOM = PLATFORM_BOTTOM - PLATFORM_HEIGHT;
final int HEXPLATE_TOP = PLATFORM_BOTTOM;
final int HEXPLATE_MID = HEXPLATE_BOTTOM + (int)(abs(HEXPLATE_TOP - HEXPLATE_BOTTOM) / 2.0);
final int HEXPLATE_HEIGHT = (4 * DIMENSION_SCALE);

// Hexagon constants
final int HEX_R = (100 * DIMENSION_SCALE);  // Radius of the circle the hexagon is circumscribed in
final int HEX_S = (150 * DIMENSION_SCALE);  // Length of the larger side
final int HEX_H = (int) sqrt((HEX_R * HEX_R) - ((HEX_S * HEX_S) / 4.0));
final int HEX_Z = (50 * DIMENSION_SCALE);  // Thickness of the hexagon
final int HEX_M = (15 * DIMENSION_SCALE);   // Motor offset from the sides

// Hexagon points
final int HEX_AX = (int)-(HEX_S / 2.0);
final int HEX_AY = -HEX_H;
final int HEX_BX = (int)(HEX_S / 2.0);
final int HEX_BY = -HEX_H;
final int HEX_CX = (int)((HEX_H * cos(PI/6)) + (HEX_S / 2.0 * cos(-PI/3)));
final int HEX_CY = (int)((HEX_H * sin(PI/6)) + (HEX_S / 2.0 * sin(-PI/3)));
final int HEX_DX = (int)((HEX_H * cos(PI/6)) + (HEX_S / 2.0 * cos(TWO_PI/3)));
final int HEX_DY = (int)((HEX_H * sin(PI/6)) + (HEX_S / 2.0 * sin(TWO_PI/3)));
final int HEX_EX = (int)-((HEX_H * cos(PI/6)) + (HEX_S / 2.0 * cos(TWO_PI/3)));
final int HEX_EY = (int)((HEX_H * sin(PI/6)) + (HEX_S / 2.0 * sin(TWO_PI/3)));
final int HEX_FX = (int)-((HEX_H * cos(PI/6)) + (HEX_S / 2.0 * cos(-PI/3)));
final int HEX_FY = (int)((HEX_H * sin(PI/6)) + (HEX_S / 2.0 * sin(-PI/3)));

// Anchor points
final int ANCHOR_OFFSET = (3 * DIMENSION_SCALE);
final int ANCHOR_FX = (int)(((HEX_FX + (HEX_AX + HEX_FX) / 2.0)) / 2.0) - ANCHOR_OFFSET;
final int ANCHOR_FY = (int)(((HEX_FY + (HEX_AY + HEX_FY) / 2.0)) / 2.0) - ANCHOR_OFFSET;
final int ANCHOR_AX = (int)(((HEX_AX + (HEX_AX + HEX_FX) / 2.0)) / 2.0) - ANCHOR_OFFSET;
final int ANCHOR_AY = (int)(((HEX_AY + (HEX_AY + HEX_FY) / 2.0)) / 2.0) - ANCHOR_OFFSET;
final int ANCHOR_BX = (int)(((HEX_BX + (HEX_BX + HEX_CX) / 2.0)) / 2.0) + ANCHOR_OFFSET;
final int ANCHOR_BY = (int)(((HEX_BY + (HEX_BY + HEX_CY) / 2.0)) / 2.0) - ANCHOR_OFFSET;
final int ANCHOR_CX = (int)(((HEX_CX + (HEX_BX + HEX_CX) / 2.0)) / 2.0) + ANCHOR_OFFSET;
final int ANCHOR_CY = (int)(((HEX_CY + (HEX_BY + HEX_CY) / 2.0)) / 2.0) - ANCHOR_OFFSET;
final int ANCHOR_DX = (int)(((HEX_DX + (HEX_DX + HEX_EX) / 2.0)) / 2.0);
final int ANCHOR_DY = (int)(((HEX_DY + (HEX_DY + HEX_EY) / 2.0)) / 2.0) + ANCHOR_OFFSET;
final int ANCHOR_EX = (int)(((HEX_EX + (HEX_DX + HEX_EX) / 2.0)) / 2.0);
final int ANCHOR_EY = (int)(((HEX_EY + (HEX_DY + HEX_EY) / 2.0)) / 2.0) + ANCHOR_OFFSET;
final int ANCHOR_Z = HEXPLATE_MID;

// Points for motors
final int MOTOR_AX = HEX_AX + HEX_M;
final int MOTOR_AY = HEX_AY;
final int MOTOR_BX = HEX_BX - HEX_M;
final int MOTOR_BY = HEX_BY;

// final int MOTOR_CX = HEX_CX - (int)(HEX_M * cos(PI/3));
// final int MOTOR_CY = HEX_CY + (int)(HEX_M * sin(PI/3));
// final int MOTOR_DX = HEX_DX + (int)(HEX_M * cos(PI/3));
// final int MOTOR_DY = HEX_DY - (int)(HEX_M * sin(PI/3));
//
// final int MOTOR_EX = HEX_EX - (int)(HEX_M * cos(PI/3));
// final int MOTOR_EY = HEX_EY - (int)(HEX_M * sin(PI/3));
// final int MOTOR_FX = HEX_FX + (int)(HEX_M * cos(PI/3));
// final int MOTOR_FY = HEX_FY + (int)(HEX_M * sin(PI/3));

//              |       |     |
//              |   O   |     |
//              |       |     | <-- edge of the hex wall
//              |       |     |
//                   5mm  5mm
// To center = wall.x - 10mm
// Height = 35mm?

//TODO Add a comment here
final int SERVO_HEIGHT = 35 * DIMENSION_SCALE;
Arm arms[];
Ball ball;

// Platform variables
Platform platform;
Hexagon hexagons;
PVector pA = new PVector(HEX_AX, HEX_AY, 0);
PVector pB = new PVector(HEX_BX, HEX_BY, 0);
PVector pC = new PVector(HEX_CX, HEX_CY, 0);

// 3D grid variables
final int GRID_WIDTH = 10*100;
final int GRID_HEIGHT = 10*100;
final int START_X = -GRID_WIDTH/2;
final int START_Y = -GRID_HEIGHT/2;

void setup() {
    size(1024, 1024, P3D);
    frameRate(60);
    background(0);
    lights();

    // Initialize the arms
    arms = new Arm[6];
    arms[0] = new Arm('A', MOTOR_AX, MOTOR_AY, SERVO_HEIGHT, ANCHOR_AX, ANCHOR_AY, ANCHOR_Z);
    arms[1] = new Arm('B', MOTOR_BX, MOTOR_BY, SERVO_HEIGHT, ANCHOR_BX, ANCHOR_BY, ANCHOR_Z);
    arms[2] = new Arm('C', MOTOR_AX, MOTOR_AY, SERVO_HEIGHT, ANCHOR_AX, ANCHOR_AY, ANCHOR_Z);
    arms[3] = new Arm('D', MOTOR_BX, MOTOR_BY, SERVO_HEIGHT, ANCHOR_BX, ANCHOR_BY, ANCHOR_Z);
    arms[4] = new Arm('E', MOTOR_AX, MOTOR_AY, SERVO_HEIGHT, ANCHOR_AX, ANCHOR_AY, ANCHOR_Z);
    arms[5] = new Arm('F', MOTOR_BX, MOTOR_BY, SERVO_HEIGHT, ANCHOR_BX, ANCHOR_BY, ANCHOR_Z);

    // Initialize the Platform, ball, and hexagons
    platform = new Platform(PLATFORM_LENGTH, PLATFORM_WIDTH, PLATFORM_HEIGHT);
    ball = new Ball(15 * DIMENSION_SCALE);
    hexagons = new Hexagon();
}

void draw() {
    background(0);
    lights();

    // Sets up the environment
    translate(width / 2, height / 2);
    scale(1, -1);

    // Allows movement of the camera in 3D space
    translate(xTrans, yTrans);
    scale(zoom);
    rotateX(rotX);
    rotateY(rotY);
    rotateZ(rotZ);

    // Draws the bottom grid reference plane
    fill(75, 0, 130);
    stroke(255);
    strokeWeight(2);
    pushMatrix();
    translate(0, 0, -1);

    rect(START_X, START_Y, GRID_WIDTH, GRID_HEIGHT);
    for (int x = 0; x < GRID_HEIGHT; x += 100) {
        line(START_X + x, START_Y, START_X + x, START_Y + GRID_HEIGHT);
    }
    for (int y = 0; y < GRID_WIDTH; y += 100) {
        line(START_X, START_Y + y, START_X + GRID_WIDTH, START_Y + y);
    }
    popMatrix();
    strokeWeight(1);
    stroke(255);

    // Updates the plaform
    pA.z = arms[0].getHeight();
    pB.z = arms[1].getHeight();
    pC.z = arms[2].getHeight();
    platform.update(pA, pB, pC);
    platform.draw();

    // Updates the ball
    ball.move();
    ball.draw();

    // Updates the hexagons
    hexagons.drawBase(HEX_Z, 0);
    hexagons.drawPlate();

    // Draws the anchors
    anchors();

    // Draws the arms, motors, and connectors
    arms[0].dot();
    arms[1].dot();
    arms[2].dot();
    arms[3].dot();
    arms[4].dot();
    arms[5].dot();
    arms[0].drawKnob();
    arms[1].drawKnob();
    arms[2].drawKnob();
    arms[3].drawKnob();
    arms[4].drawKnob();
    arms[5].drawKnob();
    arms[0].drawArm();
    arms[1].drawArm();
    arms[2].drawArm();
    arms[3].drawArm();
    arms[4].drawArm();
    arms[5].drawArm();
}


// Draws colored dots for the anchors
void anchors() {
    stroke(0);

    // 1 top
    pushMatrix();
    translate(ANCHOR_AX, ANCHOR_AY, ANCHOR_Z);
    fill(255, 0, 0);
    ellipse(0, 0, 25, 25);
    popMatrix();

    // 2 top
    pushMatrix();
    translate(ANCHOR_BX, ANCHOR_BY, ANCHOR_Z);
    fill(255, 127, 0);
    ellipse(0, 0, 25, 25);
    popMatrix();

    // 3 top
    pushMatrix();
    translate(ANCHOR_CX, ANCHOR_CY, ANCHOR_Z);
    fill(255, 255, 0);
    ellipse(0, 0, 25, 25);
    popMatrix();

    // 4 top
    pushMatrix();
    translate(ANCHOR_DX, ANCHOR_DY, ANCHOR_Z);
    fill(0, 255, 0);
    ellipse(0, 0, 25, 25);
    popMatrix();

    // 5 top
    pushMatrix();
    translate(ANCHOR_EX, ANCHOR_EY, ANCHOR_Z);
    fill(0, 0, 255);
    ellipse(0, 0, 25, 25);
    popMatrix();

    // 6 top
    pushMatrix();
    translate(ANCHOR_FX, ANCHOR_FY, ANCHOR_Z);
    fill(75, 0, 130);
    ellipse(0, 0, 25, 25);
    popMatrix();
}

// Rotates and moves the sketch
void mouseDragged() {
    if (mouseButton == LEFT && zEnabled) {
        float rate = 0.01;
        rotZ += (mouseX - pmouseX) * rate;
    }
    else if (mouseButton == LEFT) {
        float rate = 0.01;
        rotX += (mouseY - pmouseY) * rate;
        rotY += (mouseX - pmouseX) * rate;

    } else if (mouseButton == RIGHT) {
        yTrans += (pmouseY - mouseY);
        xTrans += (mouseX - pmouseX);
    }
}

// Zoom in and out with the scroll wheel
void mouseWheel(MouseEvent event) {
    float e = event.getCount();
    zoom += e / 100.0;
}

// Key press logic
void keyPressed() {
    // Reset the camera
    if (key == 'x' || key == 'X') {
        rotX = radians(270);
        rotY = radians(0);
        rotZ = radians(0);
        zoom = 0.5;
        xTrans = 0;
        yTrans = -200;
    // Save the current camera position
    } else if (key == 'c' || key == 'C') {
        rotX_saved = rotX;
        rotY_saved = rotY;
        rotZ_saved = rotZ;
        zoom_saved = zoom;
        xTrans_saved = xTrans;
        yTrans_saved = yTrans;
    // Jump back to the saved position
    } else if (key == 'v' || key == 'V') {
        rotX = rotX_saved;
        rotY = rotY_saved;
        rotZ = rotZ_saved;
        zoom = zoom_saved;
        xTrans = xTrans_saved;
        yTrans = yTrans_saved;
    } else if (key == 'z' || key == 'Z') {
        zEnabled = !zEnabled;

    } else if (key == 'b' || key == 'B') {
        ball.reset();
    }
}
