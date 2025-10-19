/// ⛓️ Topological Sort (Kahn's Algorithm)
///
/// Produces a linear ordering of vertices of a Directed Acyclic Graph (DAG)
/// such that for every directed edge u -> v, u comes before v in the ordering.
/// Throws [StateError] if the graph contains a cycle.
///
/// - Time complexity: O(V + E)
/// - Space complexity: O(V)
///
/// Example:
/// ```dart
/// final dag = {
///   1: [2], 2: [3], 3: [4], 4: []
/// };
/// final order = topologicalSort(dag); // [1, 2, 3, 4]
/// ```
library;

List<T> topologicalSort<T>(Map<T, List<T>> graph) {
  final Map<T, int> inDegree = {};
  final Set<T> nodes = {...graph.keys};
  for (final neighbors in graph.values) {
    nodes.addAll(neighbors);
  }

  for (final node in nodes) {
    inDegree[node] = 0;
  }
  graph.forEach((u, neighbors) {
    for (final v in neighbors) {
      inDegree[v] = (inDegree[v] ?? 0) + 1;
    }
  });

  final List<T> queue = [
    for (final n in nodes)
      if ((inDegree[n] ?? 0) == 0) n,
  ];

  final List<T> order = [];

  while (queue.isNotEmpty) {
    final T u = queue.removeAt(0);
    order.add(u);
    for (final v in graph[u] ?? const []) {
      final deg = (inDegree[v] ?? 0) - 1;
      inDegree[v] = deg;
      if (deg == 0) queue.add(v);
    }
  }

  if (order.length != nodes.length) {
    throw StateError(
      'Graph has at least one cycle; topological sort not possible.',
    );
  }

  return order;
}
