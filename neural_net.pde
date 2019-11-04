Trainer[] training = new Trainer[2000];
Perceptron ptron;

int count = 0;

void setup() {
    size(400, 400);
    ptron = new Perceptron(3);

    for (int i=0; i < training.length; i++) {
        float x = random(-width/2, width/2);
        float y = random(-height/2, height/2);

        int answer = y > f(x) ? 1 : -1;
        training[i] = new Trainer(x, y, answer);
    }
}

void draw() {
    background(255);
    translate(width/2, height/2);

    ptron.train(training[count].inputs, training[count].answer);
    count = (count + 1) % training.length;
    for (int i=0; i < count; i++) {
        stroke(0);
        int guess = ptron.feedForward(training[i].inputs);
        if (guess > 0) noFill();
        else fill(0);
        ellipse(training[i].inputs[0], training[i].inputs[1], 8, 8);
    }
}

class Perceptron {
    float [] weights;
    final float c = 0.01;

    Perceptron(int n) {
        weights = new float[n];
        
        for (int i = 0; i < weights.length; i++) {
            weights[i] = random(-1,1);
        }
    }

    int feedForward(float[] inputs) {
        float sum = 0;

        for (int i=0; i<inputs.length; i++) {
            sum += inputs[i] * weights[i];
        }

        return activate(sum);
    }

    int activate(float sum) {
        if (sum > 0) return 1;
        else return 0;
    }

    void train(float[] inputs, int desired) {
        int guess = feedForward(inputs);
        println("guess is " + guess + "\nanswer is " + desired);
        
        float err = desired - guess;
        
        // update weights
        for (int i=0; i < weights.length; i++) {
            weights[i] += c * err * inputs[i];
        }
    }
};


class Trainer {
    float[] inputs;
    int answer;

    Trainer(float x, float y, int ans) {
        inputs = new float[3];

        inputs[0] = x;
        inputs[1] = y;
        inputs[2] = ans;

        answer = ans;
    }
}

float f(float x) {
    return 2*x + 1;
}
