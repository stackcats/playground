import "dart:math";

extension RadixSort on List<int> {
  void radixSort() {
    const base = 10;
    bool done = false;
    int place = 1;
    while (!done) {
      done = true;
      final buckets = List.generate(base, (_) => <int>[]);
      forEach((number) {
        final digit = number ~/ place % base;
        buckets[digit].add(number);
        if (number ~/ place ~/ base > 0) {
          done = false;
        }
      });
      place *= base;
      clear();
      addAll(buckets.expand((element) => element));
    }
  }
}

extension Digits on int {
  static const _base = 10;
  int digits() {
    int count = 0;
    int number = this;
    while (number != 0) {
      count += 1;
      number ~/= _base;
    }
    return count;
  }

  int? digitAt(int position) {
    if (position > digits()) {
      return null;
    }
    int number = this;
    while (number ~/ pow(_base, position + 1) != 0) {
      number ~/= _base;
    }
    return number % _base;
  }
}

extension MsdRadixSort on List<int> {
  int maxDigits() {
    if (isEmpty) return 0;
    return reduce(max).digits();
  }

  void lexicographicalSort() {
    final sorted = _msdRadixSort(this, 0);
    clear();
    addAll(sorted);
  }

  List<int> _msdRadixSort(List<int> lst, int position) {
    if (lst.length < 2 || position >= lst.maxDigits()) {
      return lst;
    }
    final buckets = List.generate(10, (_) => <int>[]);
    var priorityBucket = <int>[];

    for (int number in lst) {
      final digit = number.digitAt(position);
      if (digit == null) {
        priorityBucket.add(number);
      } else {
        buckets[digit].add(number);
      }
    }

    final bucketOrder = buckets.reduce((acc, bucket) {
      if (bucket.isEmpty) {
        return acc;
      }
      final sorted = _msdRadixSort(bucket, position + 1);
      return acc..addAll(sorted);
    });

    return priorityBucket..addAll(bucketOrder);
  }
}

void main() {
  final list = [88, 410, 1772, 20];
  print("Original list: $list");
  list.radixSort();
  print("Radix sorted: $list");
  final list2 = [46, 500, 459, 1345, 13, 999];
  list2.lexicographicalSort();
  print(list2);
}
