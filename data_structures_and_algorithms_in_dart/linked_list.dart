class Node<T> {
  T value;
  Node<T>? next;

  Node({
    required this.value,
    this.next,
  });

  @override
  String toString() {
    if (next == null) {
      return '$value';
    }
    return '$value -> ${next.toString()}';
  }
}

class LinkedListIterator<E> implements Iterator<E> {
  final LinkedList<E> list;
  Node<E>? _currentNode;
  bool _firstPass = true;

  LinkedListIterator(this.list);

  @override
  E get current => _currentNode!.value;

  @override
  bool moveNext() {
    if (list.isEmpty) {
      return false;
    }

    if (_firstPass) {
      _currentNode = list.head;
      _firstPass = false;
    } else {
      _currentNode = _currentNode!.next;
    }

    return _currentNode != null;
  }
}

class LinkedList<E> extends Iterable<E> {
  Node<E>? head;
  Node<E>? tail;

  @override
  bool get isEmpty => head == null;

  @override
  String toString() {
    if (isEmpty) {
      return 'Empty list';
    }

    return head.toString();
  }

  void append(E element) {
    Node<E> node = Node(value: element);
    if (isEmpty) {
      head = node;
      tail = node;
      return;
    }

    tail!.next = node;
    tail = node;
  }

  void reverse() {
    tail = head;
    Node<E>? prev = null;
    Node<E>? curr = head;
    while (curr != null) {
      final next = curr.next;
      curr.next = prev;
      prev = curr;
      curr = next;
    }
    head = prev;
  }

  void removeAll(E elem) {
    if (isEmpty) {
      return;
    }

    Node<E>? prev = null;
    Node<E>? curr = head;
    while (curr != null) {
      if (curr.value != elem) {
        prev = curr;
        curr = curr.next;
        continue;
      }

      if (prev == null) {
        curr = curr.next;
        head = curr;
      } else {
        curr = curr.next;
        prev.next = curr;
      }
    }

    if (isEmpty) {
      tail = null;
    }
  }

  @override
  Iterator<E> get iterator => LinkedListIterator(this);
}

void reversePrint<E>(LinkedList<E> list) {
  final stack = <E>[];
  for (final e in list) {
    stack.add(e);
  }

  while (stack.isNotEmpty) {
    print(stack.removeLast());
  }
}

E? findMiddle<E>(LinkedList<E> list) {
  if (list.isEmpty) {
    return null;
  }

  Node<E>? slow = list.head;
  Node<E>? fast = list.head;
  while (fast != null && fast.next != null) {
    fast = fast.next!.next;
    slow = slow!.next;
  }
  return slow!.value;
}

void main(List<String> args) {
  final ll = LinkedList<int>();
  ll.append(1);
  ll.append(2);
  ll.append(3);
  print(ll);

  print('the reverse order');
  reversePrint(ll);

  int? m = findMiddle(ll);
  print('the middle is $m');

  ll.append(4);
  m = findMiddle(ll);
  print('the middle is $m');

  print('original list $ll');
  ll.reverse();
  print('reversed list $ll');

  ll.append(2);
  ll.append(2);

  print('before removed: $ll');

  ll.removeAll(2);
  print('after removed 2: $ll');

  ll.removeAll(4);
  print('after removed 4: $ll');

  ll.removeAll(3);
  print('after removed 3: $ll');

  ll.removeAll(10);
  print('after removed 10: $ll');

  ll.removeAll(1);
  print('after removed 1: $ll');

  ll.removeAll(1);
  print('after removed 1: $ll');
}
