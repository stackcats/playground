import 'swap.dart';

void selectionSort<E extends Comparable<dynamic>>(List<E> lst) {
  for (int i = 0; i < lst.length - 1; i++) {
    int lowest = i;
    for (int j = i + 1; j < lst.length; j++) {
      if (lst[i].compareTo(lst[j]) > 0) {
        lowest = j;
      }
    }
    if (lowest != i) {
      lst.swap(lowest, i);
    }
  }
}

void main() {
  final list = [9, 4, 10, 3];
  print('Original: $list');
  selectionSort(list);
  print('Selection sorted: $list');
}
