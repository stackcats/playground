import 'dart:collection';
import 'dart:io';

class TreeNode<T> {
  T value;
  List<TreeNode<T>> children = [];

  TreeNode(this.value);

  void add(TreeNode<T> child) {
    children.add(child);
  }

  void forEachDepthFirst(void Function(TreeNode<T> node) performAction) {
    performAction(this);
    for (final child in children) {
      child.forEachDepthFirst(performAction);
    }
  }
}

void printLevelOrder<T>(TreeNode<T> tree) {
  var q = Queue<TreeNode<T>>();

  q.add(tree);
  while (true) {
    final cq = Queue<TreeNode<T>>();
    while (q.isNotEmpty) {
      final curr = q.removeFirst();
      stdout.write('${curr.value} ');
      for (final child in curr.children) {
        cq.add(child);
      }
    }
    if (cq.isEmpty) {
      break;
    }
    print('');
    q = cq;
  }
}

class Widget {}

class Column extends Widget {
  List<Widget>? children;
  Column({this.children});
}

class Padding extends Widget {
  double value;
  Widget? child;
  Padding({
    this.value = 0.0,
    this.child,
  });
}

class Text extends Widget {
  String value;
  Text([this.value = '']);
}

void main(List<String> args) {
  final t1 = TreeNode<int>(1);
  t1.add(TreeNode<int>(1));
  t1.add(TreeNode<int>(5));
  t1.add(TreeNode<int>(0));

  final t17 = TreeNode<int>(17);
  t17.add(TreeNode<int>(2));

  final t20 = TreeNode<int>(20);
  t20.add(TreeNode<int>(5));
  t20.add(TreeNode<int>(7));

  final t = TreeNode<int>(15);
  t.add(t1);
  t.add(t17);
  t.add(t20);

  printLevelOrder(t);
}
