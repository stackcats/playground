import 'swap.dart';

void insertionSort<E extends Comparable<dynamic>>(List<E> lst) {
  for (int current = 1; current < lst.length; current++) {
    for (int shifting = current; shifting > 0; shifting--) {
      if (lst[shifting].compareTo(lst[shifting - 1]) < 0) {
        lst.swap(shifting, shifting - 1);
      } else {
        break;
      }
    }
  }
}

void main() {
  var list = [9, 4, 10, 3];
  print('Original: $list');
  insertionSort(list);
  print('Insertion sorted: $list');
}
