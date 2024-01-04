class BinaryNode<T> {
  BinaryNode(this.value);
  T value;
  BinaryNode<T>? leftChild;
  BinaryNode<T>? rightChild;

  void traverseInOrder(void Function(T value) action) {
    leftChild?.traverseInOrder(action);
    action(value);
    rightChild?.traverseInOrder(action);
  }

  void traversePreOrder(void Function(T value) action) {
    action(value);
    leftChild?.traversePreOrder(action);
    rightChild?.traversePreOrder(action);
  }

  void traversePostOrder(void Function(T value) action) {
    leftChild?.traversePostOrder(action);
    rightChild?.traversePostOrder(action);
    action(value);
  }

  @override
  String toString() {
    return _diagram(this);
  }

  String _diagram(
    BinaryNode<T>? node, [
    String top = '',
    String root = '',
    String bottom = '',
  ]) {
    if (node == null) {
      return '$root null\n';
    }
    if (node.leftChild == null && node.rightChild == null) {
      return '$root ${node.value}\n';
    }
    final a = _diagram(node.rightChild, '$top ', '$top┌──', '$top│ ');
    final b = '$root${node.value}\n';
    final c = _diagram(node.leftChild, '$bottom│ ', '$bottom└──', '$bottom ');
    return '$a$b$c';
  }

  BinaryNode<T> get min => leftChild?.min ?? this;
}

class BinarySearchTree<E extends Comparable<dynamic>> {
  BinaryNode<E>? root;

  @override
  String toString() {
    return root.toString();
  }

  void insert(E value) {
    root = _insert(root, value);
  }

  BinaryNode<E> _insert(BinaryNode<E>? node, E value) {
    if (node == null) {
      return BinaryNode(value);
    }

    if (value.compareTo(node.value) < 0) {
      node.leftChild = _insert(node.leftChild, value);
    } else {
      node.rightChild = _insert(node.rightChild, value);
    }
    return node;
  }

  bool contains(E value) {
    var curr = root;
    while (curr != null) {
      if (curr.value == value) {
        return true;
      }
      if (curr.value.compareTo(value) < 0) {
        curr = curr.rightChild;
      } else {
        curr = curr.leftChild;
      }
    }

    return false;
  }

  void remove(E value) {
    root = _remove(root, value);
  }

  BinaryNode<E>? _remove(BinaryNode<E>? node, E value) {
    if (node == null) {
      return null;
    }

    if (value == node.value) {
      if (node.leftChild == null && node.rightChild == null) {
        return null;
      }

      if (node.leftChild == null) {
        return node.rightChild;
      }

      if (node.rightChild == null) {
        return node.leftChild;
      }
      node.value = node.rightChild!.min.value;
      node.rightChild = _remove(node.rightChild, node.value);
    } else if (value.compareTo(node.value) < 0) {
      node.leftChild = _remove(node.leftChild, value);
    } else {
      node.rightChild = _remove(node.rightChild, value);
    }

    return node;
  }
}

extension Checker<E extends Comparable<dynamic>> on BinaryNode<E> {
  bool isBinarySearchTree() {
    return _isBST(this, min: null, max: null);
  }

  bool _isBST(BinaryNode<E>? tree, {E? min, E? max}) {
    if (tree == null) {
      return true;
    }

    if (min != null && tree.value.compareTo(min) < 0) {
      return false;
    }

    if (max != null && tree.value.compareTo(max) >= 0) {
      return false;
    }

    return _isBST(tree.leftChild, min: min, max: tree.value) &&
        _isBST(tree.rightChild, min: tree.value, max: max);
  }
}

void main() {
  final tree = BinarySearchTree<int>();
  for (var i = 0; i < 5; i++) {
    tree.insert(i);
  }
  print(tree);
}
