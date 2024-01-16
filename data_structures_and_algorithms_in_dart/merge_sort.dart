List<E> _merge<E extends Comparable<dynamic>>(List<E> lstA, List<E> lstB) {
  int i = 0;
  int j = 0;
  final result = <E>[];
  while (i < lstA.length && j < lstB.length) {
    final a = lstA[i];
    final b = lstB[j];
    if (a.compareTo(b) < 0) {
      result.add(a);
      i++;
    } else if (a.compareTo(b) > 0) {
      result.add(b);
      j++;
    } else {
      result.add(a);
      result.add(b);
      i++;
      j++;
    }
  }

  if (i < lstA.length) {
    result.addAll(lstA.getRange(i, lstA.length));
  }

  if (j < lstB.length) {
    result.addAll(lstB.getRange(j, lstB.length));
  }

  return result;
}

List<E> mergeSort<E extends Comparable<dynamic>>(List<E> lst) {
  if (lst.length < 2) {
    return lst;
  }

  final middle = lst.length ~/ 2;
  final left = mergeSort(lst.sublist(0, middle));
  final right = mergeSort(lst.sublist(middle));

  return _merge(left, right);
}

void main() {
  final list = [7, 2, 6, 3, 9];
  final sorted = mergeSort(list);
  print('Original: $list');
  print('Merge sorted: $sorted');
}
