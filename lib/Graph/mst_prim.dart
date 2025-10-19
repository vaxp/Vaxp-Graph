/// 🌿 Prim's Algorithm (Minimum Spanning Tree/Forest)
///
/// Builds an MST using a Min-Heap for efficient frontier management.
///
/// - Input: undirected weighted graph adjacency list
/// - Time complexity (with Min-Heap): O(E log V)
/// - Space complexity: O(V + E)
///
/// Returns a list of edges in the MST (or MSF for disconnected graphs).
library;

import 'weighted_edge.dart';

// ===================================================================
// 1. Min-Heap Implementation (Custom Priority Queue)
// A helper class to efficiently find the minimum weight edge.
// ===================================================================
class _MinHeap<E> {
  final List<E> _list = [];
  final int Function(E, E) _compare;

  _MinHeap(this._compare);

  bool get isNotEmpty => _list.isNotEmpty;

  void add(E element) {
    _list.add(element);
    _siftUp(_list.length - 1);
  }

  E removeMin() {
    if (_list.isEmpty) throw StateError('Heap is empty');
    final first = _list.first;
    final last = _list.removeLast();
    if (_list.isNotEmpty) {
      _list[0] = last;
      _siftDown(0);
    }
    return first;
  }

  void _siftUp(int index) {
    if (index == 0) return;
    final parentIndex = (index - 1) ~/ 2;
    if (_compare(_list[index], _list[parentIndex]) < 0) {
      _swap(index, parentIndex);
      _siftUp(parentIndex);
    }
  }

  void _siftDown(int index) {
    int minChildIndex = index;
    final leftChildIndex = 2 * index + 1;
    final rightChildIndex = 2 * index + 2;

    if (leftChildIndex < _list.length &&
        _compare(_list[leftChildIndex], _list[minChildIndex]) < 0) {
      minChildIndex = leftChildIndex;
    }
    if (rightChildIndex < _list.length &&
        _compare(_list[rightChildIndex], _list[minChildIndex]) < 0) {
      minChildIndex = rightChildIndex;
    }

    if (index != minChildIndex) {
      _swap(index, minChildIndex);
      _siftDown(minChildIndex);
    }
  }

  void _swap(int i, int j) {
    final temp = _list[i];
    _list[i] = _list[j];
    _list[j] = temp;
  }
}

// ===================================================================
// 2. Improved Prim's Algorithm using the Min-Heap
// ===================================================================
List<WeightedEdge<T>> primMST<T>(Map<T, List<WeightedEdge<T>>> graph) {
  final Set<T> allNodes = {...graph.keys};
  for (final edges in graph.values) {
    for (final e in edges) {
      allNodes.add(e.source);
      allNodes.add(e.target);
    }
  }

  final Set<T> visited = <T>{};
  final List<WeightedEdge<T>> mst = [];

  // This function processes one connected component of the graph
  void processComponent(T start) {
    visited.add(start);

    // Use the Min-Heap as our frontier instead of a List
    // It will automatically keep the lowest-weight edge at the top
    final frontier = _MinHeap<WeightedEdge<T>>(
      (a, b) => a.weight.compareTo(b.weight),
    );
    (graph[start] ?? <WeightedEdge<T>>[]).forEach(frontier.add);

    while (frontier.isNotEmpty) {
      // No more sorting! Just get the minimum element efficiently.
      final edge = frontier.removeMin();

      final T v = visited.contains(edge.source) ? edge.target : edge.source;
      if (visited.contains(v)) continue;

      visited.add(v);
      mst.add(edge);

      for (final e in graph[v] ?? <WeightedEdge<T>>[]) {
        final T next = visited.contains(e.source) ? e.target : e.source;
        if (!visited.contains(next)) frontier.add(e);
      }
    }
  }

  // Process all components to handle disconnected graphs (forests)
  for (final n in allNodes) {
    if (!visited.contains(n)) {
      processComponent(n);
    }
  }
  return mst;
}
