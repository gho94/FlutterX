class StringCompress {
  int minLength = 0;
  String shortString = '';
  int bestUnit = 1;

  int compareMinLength(String s) {
    int len = s.length;
    int count = 1;
    minLength = len + 1;
    StringBuffer result = StringBuffer();

    for (int i = 1; i <= len ~/ 2; i++) {
      result.clear();
      String currentString = s.substring(0, i);

      for (int j = i; j <= len - i; j += i) {
        String nextString = s.substring(j, j + i);
        if (currentString == nextString) {
          count++;
        } else {
          if (count > 1) {
            result.write(count);
          }
          result.write(currentString);
          currentString = nextString;
          count = 1;
        }
      }
      if (count > 1) {
        result.write(count);
      }
      result.write(currentString);

      if (len % i != 0) {
        result.write(s.substring(len - len % i));
      }
      if (result.length < minLength) {
        minLength = result.length;
        shortString = result.toString();
        bestUnit = i;
      }
    }
    return minLength == len + 1 ? len : minLength;
  }
}

void main() {
  // String s1 = 'aabbaccc';
  // String s2 = 'ababcdcdababcdcd';
  // String s3 = 'abcabcdede';
  String s4 = 'abcabcabcabcdededededede';
  // String s5 = 'xababcdcdababcdcd';
  StringCompress stringCompress = StringCompress();

  print(stringCompress.compareMinLength(s4));
  print(stringCompress.bestUnit);
  print(stringCompress.shortString);
}
