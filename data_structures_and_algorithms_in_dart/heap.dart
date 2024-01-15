enum Priority { max, min }

class Heap<E extends Comparable<dynamic>> {
  late final List<E> elements;
  final Priority priority;

  Heap({List<E>? elements, this.priority = Priority.max}) {
    this.elements = elements ?? [];
    _buildHeap();
  }

  void _buildHeap() {
    if (isEmpty) return;
    final start = elements.length ~/ 2 - 1;
    for (int i = start; i >= 0; i--) {
      _siftUp(i);
    }
  }

  bool get isEmpty => elements.isEmpty;
  int get size => elements.length;
  E? get peek => (isEmpty) ? null : elements.first;

  int _leftChildIndex(int index) => 2 * index + 1;
  int _rightChildIndex(int index) => 2 * index + 2;
  int _parentIndex(int index) => (index - 1) ~/ 2;

  bool _firstHasHigherPriority(E v1, E v2) {
    if (priority == Priority.max) {
      return v1.compareTo(v2) > 0;
    }
    return v1.compareTo(v2) < 0;
  }

  int _higherPriority(int i, int j) {
    if (i >= elements.length) return j;
    final v1 = elements[i];
    final v2 = elements[j];
    final isFirst = _firstHasHigherPriority(v1, v2);
    return isFirst ? i : j;
  }

  void _swapValues(int i, int j) {
    final temp = elements[i];
    elements[i] = elements[j];
    elements[j] = temp;
  }

  void insert(E value) {
    elements.add(value);
    _siftUp(elements.length - 1);
  }

  E? remove() {
    if (isEmpty) {
      return null;
    }

    _swapValues(0, elements.length - 1);
    final value = elements.removeLast();
    _siftDown(0);
    return value;
  }

  E? removeAt(int index) {
    final lastIndex = elements.length - 1;
    if (index < 0 || index > lastIndex) {
      return null;
    }

    if (index == lastIndex) {
      return elements.removeLast();
    }

    _swapValues(index, lastIndex);

    final value = elements.removeLast();
    _siftDown(index);
    _siftUp(index);
    return value;
  }

  int indexOf(E value, {int index = 0}) {
    if (index >= elements.length) {
      return -1;
    }
    if (_firstHasHigherPriority(value, elements[index])) {
      return -1;
    }

    if (value == elements[index]) {
      return index;
    }

    final left = indexOf(value, index: _leftChildIndex(index));
    if (left != -1) {
      return left;
    }

    return indexOf(value, index: _rightChildIndex(index));
  }

  void _siftUp(int index) {
    var child = index;
    var parent = _parentIndex(child);
    while (child > 0 && child == _higherPriority(parent, child)) {
      _swapValues(child, parent);
      child = parent;
      parent = _parentIndex(child);
    }
  }

  void _siftDown(int index) {
    var parent = index;
    print(parent);
    while (parent < elements.length) {
      final left = _leftChildIndex(parent);
      final right = _rightChildIndex(parent);
      var chosen = _higherPriority(left, parent);
      chosen = _higherPriority(right, chosen);
      if (chosen == parent) {
        return;
      }
      _swapValues(parent, chosen);
      parent = chosen;
    }
  }

  @override
  String toString() => elements.toString();
}

void main() {
  final heap = Heap<int>();
  heap.insert(8);
  heap.insert(6);
  heap.insert(5);
  heap.insert(4);
  heap.insert(3);
  heap.insert(2);
  heap.insert(1);
  print(heap);
  final root = heap.remove();
  print(root);
  print(heap);
}
