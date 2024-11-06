class Solution {
  void merge(List<int> nums1, int m, List<int> nums2, int n) {
    List<int> mergeList = [];

    for (int index = 0; index < m; index++) {
      mergeList.add(nums1[index]);
    }

    for (int index = 0; index < n; index++) {
      mergeList.add(nums2[index]);
    }
    mergeList.sort();

    for (int index = 0; index < mergeList.length; index++) {
      nums1[index] = mergeList[index];
    }
  }
}

void main() {
  List<int> nums1 = [-1, 0, 0, 3, 3, 3, 0, 0, 0];
  int m = 6;
  List<int> nums2 = [1, 2, 2];
  int n = 3;

  Solution solution = Solution();
  solution.merge(nums1, m, nums2, n);
}
