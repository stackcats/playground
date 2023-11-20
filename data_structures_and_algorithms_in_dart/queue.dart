abstract class Queue<E> {
  bool enqueue(E element);
  E? dequeue();
  bool get isEmpty;
  E? get peek;
}

class QueueList<E> implements Queue<E> {
  final _list = <E>[];

  @override
  E? dequeue() {
    if (isEmpty) {
      return null;
    }
    return _list.removeAt(0);
  }

  @override
  bool enqueue(E element) {
    _list.add(element);
    return true;
  }

  @override
  bool get isEmpty => _list.isEmpty;

  @override
  E? get peek => _list.firstOrNull;

  @override
  String toString() {
    return _list.toString();
  }
}

class QueueRingBuffer<E> implements Queue<E> {
  final List<E?> _list;
  int _front = 0;
  int _rear = 0;
  int _size = 0;

  QueueRingBuffer(int length)
      : _list = List.filled(length, null, growable: false);

  int _bump(int i) => (i + 1) % _list.length;

  @override
  E? dequeue() {
    if (isEmpty) {
      return null;
    }
    final element = _list[_front];
    _front = _bump(_front);
    _size--;
    return element;
  }

  @override
  bool enqueue(E element) {
    if (isFull) {
      return false;
    }

    _list[_rear] = element;
    _rear = _bump(_rear);
    _size++;
    return true;
  }

  @override
  bool get isEmpty => _size == 0;

  bool get isFull => _size == _list.length;

  @override
  E? get peek => isEmpty ? null : _list[_front];

  @override
  String toString() {
    List<E> arr = [];
    for (int i = _front; i != _rear; i = _bump(i)) {
      arr.add(_list[i]!);
    }
    return '[${arr.join(",")}]';
  }
}

class QueueStack<E> implements Queue<E> {
  final _leftStack = <E>[];
  final _rightStack = <E>[];

  @override
  E? dequeue() {
    if (_leftStack.isEmpty) {
      _leftStack.addAll(_rightStack.reversed);
      _rightStack.clear();
    }
    if (_leftStack.isEmpty) {
      return null;
    }

    return _leftStack.removeLast();
  }

  @override
  bool enqueue(E element) {
    _rightStack.add(element);
    return true;
  }

  @override
  bool get isEmpty => _leftStack.isEmpty && _rightStack.isEmpty;

  @override
  E? get peek => _leftStack.isNotEmpty ? _leftStack.last : _rightStack.first;

  @override
  String toString() {
    final combined = [
      ..._leftStack.reversed,
      ..._rightStack,
    ].join(', ');
    return '[$combined]';
  }
}

void main(List<String> args) {
  print('List:');
  {
    final queue = QueueList<String>();
    queue.enqueue('Ray');
    queue.enqueue('Brian');
    queue.enqueue('Eric');
    print(queue);
    queue.dequeue();
    print(queue);
    queue.peek;
    print(queue);
  }

  print('RingBuffer:');
  {
    final queue = QueueRingBuffer<String>(10);
    queue.enqueue("Ray");
    queue.enqueue("Brian");
    queue.enqueue("Eric");
    print(queue); // [Ray, Brian, Eric]
    queue.dequeue();
    print(queue); // [Brian, Eric]
    queue.peek;
    print(queue); // [Brian, Eric]
  }
}
