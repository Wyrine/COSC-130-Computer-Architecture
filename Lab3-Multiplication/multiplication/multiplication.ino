short multiply(byte left, byte right)
{
  short result = 0;
  bool leftNeg, rightNeg;
  leftNeg = isNegative(left);
  rightNeg = isNegative(right);

  for(int i = 0; i < 8; i++)
    if((right >> i) & 1) result += left << i;

  if (leftNeg ^ rightNeg) result = ~result + 1;
  return result;
}

bool isNegative(byte &num){
  bool neg = ((num >> 7) & 0b00000001) ? true : false;
  if(neg) num = ~num + 1;
  return neg;
}

void setup() {
  // put your setup code here, to run once:
  Serial.begin(115200);
  Serial.println("Enter left right to multiply: ");
}

void loop() {
  // put your main code here, to run repeatedly:
  if (Serial && (Serial.available() > 0)) {
    String input = Serial.readString();
    int left;
    int right;
    int i;

    for (i = 0;i < input.length();i++) {
      if (input.charAt(i) == ' ') {
        break;
      }
    }
    left = input.substring(0, i).toInt();
    right = input.substring(i+1).toInt();

    Serial.println("Result = " + String(multiply((byte)left, (byte)right), DEC));
    Serial.print("\n");
    Serial.println("Enter left right to multiply: ");
  }
  else {
    delay(115);
  }
}
