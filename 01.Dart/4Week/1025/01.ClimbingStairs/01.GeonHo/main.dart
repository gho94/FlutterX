class Solution {
  int climbStairs(int n) {
    /// 1 => 1
    /// 2 => 2  (1,1) (2)
    /// 3 => 3  (1,1,1) (1,2) (2,1)
    /// 4 => 5   1 (1,1,1,1)
    ///          3 (1,1,2) (1,2,1) (2,1,1)
    ///          1(2,2)
    ///
    /// 5 => 8   1 (1,1,1,1,1)
    ///          4 (1,1,1,2) (1,1,2,1) (1,2,1,1) (2,1,1,1)
    ///          3 (1,2,2) (2,1,2) (2,2,1)
    ///
    /// 6 => 13  1 (1,1,1,1,1,1)
    ///          5 (1,1,1,1,2) (1,1,1,2,1) (1,1,2,1,1) (1,2,1,1,1) (2,1,1,1,1)
    ///          6 (1,1,2,2) (1,2,1,2) (1,2,2,1) (2,1,1,2) (2,1,2,1) (2,2,1,1)
    ///          1 (2,2,2)
    ///
    /// 7 => 21  1 (1,1,1,1,1,1,1)
    ///          6 (1,1,1,1,1,2) (1,1,1,1,2,1) (1,1,1,2,1,1) (1,1,2,1,1,1) (1,2,1,1,1,1) (2,1,1,1,1,1)
    ///         10 (1,1,1,2,2) (1,1,2,1,2) (1,1,2,2,1) (1,2,1,1,2) (1,2,1,2,1) (1,2,2,1,2) (2,1,1,1,2) (2,1,1,2,1) (2,1,2,1,1) (2,2,1,1,1)
    ///          4 (1,2,2,2) (2,1,2,2) (2,2,1,2) (2,2,2,1)
    ///
    /// 8 => 34  1 (1,1,1,1,1,1,1,1)
    ///          7 (1,1,1,1,1,1,2) (1,1,1,1,1,2,1) (1,1,1,1,2,1,1) (1,1,1,2,1,1,1) (1,1,2,1,1,1,1) (1,2,1,1,1,1,1) (2,1,1,1,1,1,1)
    ///         15 (1,1,1,1,2,2) (1,1,1,2,1,2) (1,1,1,2,2,1) (1,1,2,1,1,2) (1,1,2,2,1,1) (1,2,1,1,1,2) (1,2,1,2,1,1) (1,2,2,1,1,1) (2,1,1,1,1,2) (2,1,1,1,2,1) (2,1,1,2,1,1) (2,1,2,1,1,1) (2,2,1,1,1,1,1) (1,1,1,2,1,2) (1,1,2,1,1,2)
    ///         10 (1,1,2,2,2) (1,2,1,2,2) (1,2,2,1,2) (1,2,2,2,1) (2,1,1,2,2) (2,1,2,1,2) (2,1,2,2,1) (2,2,1,1,2) (2,2,1,2,1) (2,2,2,1,1)
    ///          1 (2,2,2,2)

    if (n == 0) return 1;
    if (n == 1) return 1;

    // 스택오버플로우가 발생할 수 있음
    // int answer = 0;
    // answer = climbStairs(n - 1) + (climbStairs(n - 2));

    // return answer;

    int first = 1, second = 1;

    for (int i = 2; i <= n; i++) {
      int current = first + second;
      first = second;
      second = current;
    }

    return second;
  }
}
