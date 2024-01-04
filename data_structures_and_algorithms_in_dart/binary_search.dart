class Range {
  final int start;
  final int end;

  Range(this.start, this.end);
}

int? _startIndex(List<int> lst, int value) {
  if (lst.isEmpty) {
    return null;
  }
  if (lst[0] == value) {
    return 0;
  }
  var start = 1;
  var end = lst.length;
  while (start < end) {
    final middle = start + (end - start) ~/ 2;
    if (lst[middle] == value && lst[middle] - 1 != value) {
      return middle;
    }
    if (lst[middle] < value) {
      start = middle + 1;
    } else {
      end = middle;
    }
  }
  return null;
}

int? _endIndex(List<int> lst, int value) {
  if (lst.isEmpty) {
    return null;
  }

  if (lst.last == value) {
    return lst.length;
  }

  var start = 0;
  var end = lst.length - 1;
  while (start < end) {
    final middle = start + (end - start) ~/ 2;
    if (lst[middle] == value && lst[middle + 1] != value) {
      return middle;
    }
    if (lst[middle] > value) {
      end = middle;
    } else {
      start = middle + 1;
    }
  }
  return null;
}

Range? findRange(List<int> lst, int value) {
  if (lst.isEmpty) {
    return null;
  }
  final start = _startIndex(lst, value);
  final end = _endIndex(lst, value);
  if (start == null || end == null) {
    return null;
  }
  return Range(start, end);
}
