import 'swap.dart';

void bubbleSort<E extends Comparable<dynamic>>(List<E> lst) {
  for (int end = lst.length - 1; end >= 0; end--) {
    bool isSwapped = false;
    for (int current = 0; current < end; current++) {
      if (lst[current].compareTo(lst[current + 1]) > 0) {
        lst.swap(current, current + 1);
        isSwapped = true;
      }
    }

    if (!isSwapped) {
      return;
    }
  }
}

void main() {
  final list = [9, 4, 10, 3];
  print('Original: $list');
  bubbleSort(list);
  print('Bubble sorted: $list');
}
