List<E> quicksortNaive<E extends Comparable<dynamic>>(
  List<E> list,
) {
  if (list.length < 2) {
    return list;
  }

  final pivot = list[0];

  final less = list.where((value) => value.compareTo(pivot) < 0);
  final equal = list.where((value) => value.compareTo(pivot) == 0);
  final greater = list.where((value) => value.compareTo(pivot) > 0);

  return [
    ...quicksortNaive(less.toList()),
    ...equal,
    ...quicksortNaive(greater.toList()),
  ];
}

extension Swappable<E> on List<E> {
  void swap(int i, int j) {
    if (i == j) {
      return;
    }

    final t = this[i];
    this[i] = this[j];
    this[j] = t;
  }
}

int _partitionLomuto<T extends Comparable<dynamic>>(
    List<T> list, int low, int high) {
  final pivot = list[high];
  int pivotIndex = low;
  for (int i = low; i < high; i++) {
    if (list[i].compareTo(pivot) <= 0) {
      list.swap(pivotIndex, i);
      pivotIndex += 1;
    }
  }
  list.swap(pivotIndex, high);
  return pivotIndex;
}

void quicksortLomute<E extends Comparable<dynamic>>(
  List<E> list,
  int low,
  int high,
) {
  if (low >= high) {
    return;
  }

  final pivotIndex = _partitionLomuto(list, low, high);
  quicksortLomute(list, low, pivotIndex - 1);
  quicksortLomute(list, pivotIndex + 1, high);
}

int _partitionHoare<T extends Comparable<dynamic>>(
    List<T> list, int low, int high) {
  final pivot = list[low];
  var left = low - 1;
  var right = high + 1;
  while (true) {
    do {
      left++;
    } while (list[left].compareTo(pivot) < 0);

    do {
      right--;
    } while (list[right].compareTo(pivot) > 0);
    if (left < right) {
      list.swap(left, right);
    } else {
      return right;
    }
  }
}

void quicksortHoare<E extends Comparable<dynamic>>(
  List<E> list,
  int low,
  int high,
) {
  if (low >= high) {
    return;
  }

  final leftHigh = _partitionHoare(list, low, high);
  quicksortHoare(list, low, leftHigh);
  quicksortHoare(list, leftHigh + 1, high);
}

class Range {
  const Range(this.low, this.high);
  final int low;
  final int high;
}

Range _partitionDutchFlag<T extends Comparable<dynamic>>(
  List<T> list,
  int low,
  int high,
) {
  final pivot = list[high];
  var smaller = low;
  var equal = low;
  var larger = high;
  while (equal <= larger) {
    if (list[equal].compareTo(pivot) < 0) {
      list.swap(smaller, equal);
      smaller += 1;
      equal += 1;
    } else if (list[equal] == pivot) {
      equal += 1;
    } else {
      list.swap(equal, larger);
      larger -= 1;
    }
  }
  return Range(smaller, larger);
}

void quicksortDutchFlag<E extends Comparable<dynamic>>(
  List<E> list,
  int low,
  int high,
) {
  if (low >= high) return;
  final middle = _partitionDutchFlag(list, low, high);
  quicksortDutchFlag(list, low, middle.low - 1);
  quicksortDutchFlag(list, middle.high + 1, high);
}

void main() {
  var list = [8, 2, 10, 0, 9, 18, 9, -1, 5];
  var sorted = quicksortNaive(list);
  print(sorted);

  list = [8, 2, 10, 0, 9, 18, 9, -1, 5];
  quicksortLomute(list, 0, list.length - 1);
  print(list);

  list = [8, 2, 10, 0, 9, 18, 9, -1, 5];
  quicksortHoare(list, 0, list.length - 1);
  print(list);

  list = [8, 2, 2, 8, 9, 5, 9, 2, 8];
  quicksortDutchFlag(list, 0, list.length - 1);
  print(list);
}
