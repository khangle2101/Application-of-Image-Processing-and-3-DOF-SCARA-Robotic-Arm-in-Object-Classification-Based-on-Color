// Define pin connections
const int dirPin1 = 5;
const int dirPin2 = 6;
const int dirPin3 = 7;
const int stepPin1 = 2;
const int stepPin2 = 3;
const int stepPin3 = 4;
const int Enable = 8;

int Theta1 = 0;
int Theta2 = 0;
int Theta3 = 0;

int steps1 = 0;
int steps2 = 0;
int steps3 = 0;

int ratio1 = 1280/9;
int ratio2 = 1280/9;
int ratio3 = 124.513;

int temp;
int temp2 = 0;
int temp3 = 0;
String content = "";

int data[10];

void setup() {
  // put your setup code here, to run once:
    Serial.begin(9600);
  pinMode(stepPin1, OUTPUT);
  pinMode(dirPin1, OUTPUT);
  pinMode(stepPin2, OUTPUT);
  pinMode(dirPin2, OUTPUT);
  pinMode(stepPin3, OUTPUT);
  pinMode(dirPin3, OUTPUT);
  pinMode(Enable,OUTPUT);
  digitalWrite(Enable,HIGH);
}

void Step_motor_1() {
  if (data[1] > Theta1){
	// Set motor direction clockwise
	digitalWrite(dirPin1, HIGH);
  digitalWrite(Enable,LOW);

  steps1 = (data[1] - Theta1)*ratio1;
  // Serial.print("Steps1: ");
  // Serial.println(steps1);
	// Spin motor clockwise
	for(int x = 0; x < steps1; x++)
	{
		digitalWrite(stepPin1, HIGH);
		delayMicroseconds(200);
		digitalWrite(stepPin1, LOW);
		delayMicroseconds(200);
	}
  }
	else if (Theta1 > data[1]) {
	// Set motor direction counterclockwise
	digitalWrite(dirPin1, LOW);
  digitalWrite(Enable,LOW);

  steps1 = (Theta1 - data[1])*ratio1;
  // Serial.print("Steps1: ");
  // Serial.println(steps1);
	// Spin motor counterclockwise
	for(int x = 0; x < steps1; x++)
	{
		digitalWrite(stepPin1, HIGH);
		delayMicroseconds(200);
		digitalWrite(stepPin1, LOW);
		delayMicroseconds(200);
	}
  }
  Theta1 = data[1];
  steps1 = 0;
}

void Step_motor_2() {
  if (data[2] > Theta2){
	// Set motor direction clockwise
	digitalWrite(dirPin2, HIGH);
  digitalWrite(Enable,LOW);

  steps2 = (data[2] - Theta2)*ratio2;
  // Serial.print("Steps2: ");
  // Serial.println(steps2);
	// Spin motor clockwise
	for(int x = 0; x < steps2; x++)
	{
		digitalWrite(stepPin2, HIGH);
		delayMicroseconds(200);
		digitalWrite(stepPin2, LOW);
		delayMicroseconds(200);
	}
  }
	else if (Theta2 > data[2]) {
	// Set motor direction counterclockwise
	digitalWrite(dirPin2, LOW);
  digitalWrite(Enable,LOW);

  steps2 = (Theta2 - data[2])*ratio2;
  // Serial.print("Steps2: ");
  // Serial.println(steps2);
	// Spin motor counterclockwise
	for(int x = 0; x < steps2; x++)
	{
		digitalWrite(stepPin2, HIGH);
		delayMicroseconds(200);
		digitalWrite(stepPin2, LOW);
		delayMicroseconds(200);
	}
  }
  Theta2 = data[2];
  steps2 = 0;
}

void Step_motor_3() {
  if (data[3] > Theta3){
	// Set motor direction clockwise
	digitalWrite(dirPin3, HIGH);
  digitalWrite(Enable,LOW);

  steps3 = (data[3] - Theta3)*ratio3;
  // Serial.print("Steps3: ");
  // Serial.println(steps3);
	// Spin motor clockwise
	for(int x = 0; x < steps3; x++)
	{
		digitalWrite(stepPin3, HIGH);
		delayMicroseconds(200);
		digitalWrite(stepPin3, LOW);
		delayMicroseconds(200);
	}
  }
	else if (Theta3 > data[3]) {
	// Set motor direction counterclockwise
	digitalWrite(dirPin3, LOW);
  digitalWrite(Enable,LOW);

  steps3 = (Theta3 - data[3])*ratio3;
  // Serial.print("Steps3: ");
  // Serial.println(steps3);
	// Spin motor counterclockwise
	for(int x = 0; x < steps3; x++)
	{
		digitalWrite(stepPin3, HIGH);
		delayMicroseconds(200);
		digitalWrite(stepPin3, LOW);
		delayMicroseconds(200);
	}
  }
  Theta3 = data[3];
  steps3 = 0;
}

void loop() {
  //put your main code here, to run repeatedly:
  if (Serial.available()) {
    content = Serial.readString(); // Read the incomding data from Processing
    // Serial.println(content);
    // Extract the data from the string and put into separate integer variables (data[] array)
    for (int i = 1; i < 4; i++) {
      int index = content.indexOf(";"); // locate the first ";"
      data[i] = atol(content.substring(0, index).c_str()); //Extract the number from start to the ";"
      content = content.substring(index + 1); //Remove the number from the string
    }
    temp=1;
  }

  if (((data[1]<=0)&&(data[1]>-91)&&(data[2]<146)
  &&(data[2]>-91))||((data[1]>=0)&&(data[1]<91)&&(data[2]>-146)
  &&(data[2]<91)))
  {
    if ((temp==1)&&((data[2]*temp3)<0))
    {
      temp2=data[2];
      data[2]=0;
      Step_motor_2();
      data[2]=temp2;
    }
    Step_motor_1();
    Step_motor_2();
    Step_motor_3();
    if (temp==1)
    {
      Serial.println("1");
      temp=0;
    }
  }
  temp3 = data[2];
  digitalWrite(Enable,HIGH);
}

