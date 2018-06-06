class Arm {
    private int servoX;
    private int servoY;
    private int servoZ;
    private char letter;

    private int anchorX;
    private int anchorY;
    private int anchorZ;

    private int knobWidth = 11 * DIMENSION_SCALE;
    private int knobLength = 30 * DIMENSION_SCALE;
    private int leftRight;

    private int l;
    private PVector p = new PVector(0, 0, 0);
    private int b;
    private int t;
    private int q;

    Arm(char letter_, int servoX_, int servoY_, int servoZ_,
        int anchorX_, int anchorY_, int anchorZ_) {
        letter = letter_;
        servoX = servoX_;
        servoY = servoY_;
        servoZ = servoZ_;
        anchorX = anchorX_;
        anchorY = anchorY_;
        anchorZ = anchorZ_;

        leftRight = ((int)letter % 2 == 0) ? -1 : 1;
        t = anchorZ - servoZ;
        b = abs(servoX - anchorX);
        p.z = t;
        l = PLATFORM_BOTTOM;
    }

    void dot() {
        pushMatrix();
        stroke(225);
        fill(0, 0, 0);
        fixRotation();

        translate(servoX, servoY, servoZ);
        sphere(14);

        popMatrix();
    }

    void drawKnob() {
        pushMatrix();
        stroke(255);
        fill(255, 0, 0);
        fixRotation();

        translate(servoX, servoY-PLATFORM_HEIGHT, servoZ - (ceil(knobWidth/2.0)));
        rotateX(radians(90));
        rect(0, 0, leftRight * knobLength, knobWidth);

        popMatrix();
    }

    void drawArm() {
        pushMatrix();
        noFill();
        stroke(150);
        strokeWeight(3 * DIMENSION_SCALE);
        fixRotation();

        int knobCoordX = servoX + (leftRight * knobLength);
        int knobCoordY = servoY - PLATFORM_HEIGHT;
        int knobCoordZ = servoZ;
        line(anchorX, anchorY, anchorZ, knobCoordX, knobCoordY, knobCoordZ);

        int step1 = (anchorX - knobCoordX) * (anchorX - knobCoordX);
        int step2 = (anchorY - knobCoordY) * (anchorY - knobCoordY);
        //println(sqrt(step1 + step2));

        popMatrix();
    }

    void fixRotation() {
        if (letter == 'C' || letter == 'D') {
            rotateZ(radians(120));
        } else if (letter == 'E' || letter == 'F') {
            rotateZ(radians(240));
        }
    }

    void find_li() {

    }

    int getHeight() {
        return l;
    }

}
