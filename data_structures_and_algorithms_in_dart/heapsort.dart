extension Heapsort<E extends Comparable<dynamic>> on List<E> {
  int _leftChildIndex(int index) => 2 * index + 1;
  int _rightChildIndex(int index) => 2 * index + 2;
  void _swapValues(int i, int j) {
    final t = this[i];
    this[i] = this[j];
    this[j] = t;
  }

  void _siftDown({required int start, required int end}) {
    int parent = start;
    while (_leftChildIndex(parent) < end) {
      int child = _leftChildIndex(parent);
      if (child + 1 < end && this[child].compareTo(this[child + 1]) < 0) {
        child = child + 1;
      }
      if (this[parent].compareTo(this[child]) >= 0) {
        return;
      }
      _swapValues(parent, child);
      parent = child;
    }
  }

  void heapSort() {
    if (isEmpty) {
      return;
    }

    final start = (length - 1) ~/ 2;

    for (int i = start; i >= 0; i--) {
      _siftDown(start: i, end: length);
    }

    for (int end = length - 1; end > 0; end--) {
      _swapValues(end, 0);
      _siftDown(start: 0, end: end);
    }
  }
}

void main() {
  final list = [6, 12, 2, 26, 8, 18, 21, 9, 5];
  print(list);
  list.heapSort();
  print(list);
}
