class Solution {
  void merge(List<int> nums1, int m, List<int> nums2, int n) {
    List<int> result = (nums1 + nums2).where((num) => num != 0).toList()..sort();

    for (int index = 0; index < result.length; index++) {
      nums1[index] = result[index];
    }
    nums1.sort();

    print(nums1);
  }
}

// class Solution {
//   void merge(List<int> nums1, int m, List<int> nums2, int n) {
//     List<int> merged = [];

//     for (int i = 0; i < m; i++) {
//       merged.add(nums1[i]);
//     }

//     for (int j = 0; j < n; j++) {
//       merged.add(nums2[j]);
//     }

//     merged.sort();

//     for (int i = 0; i < merged.length; i++) {
//       nums1[i] = merged[i];
//     }

//     print(nums1);
//   }
// }

void main() {
  List<int> nums1 = [-1, 0, 0, 3, 3, 3, 0, 0, 0];
  int m = 6;
  List<int> nums2 = [1, 2, 2];
  int n = 3;

  Solution solution = Solution();
  solution.merge(nums1, m, nums2, n);
}
