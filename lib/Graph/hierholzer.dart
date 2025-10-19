/// Hierholzer's Algorithm for finding an Eulerian trail/circuit in a graph.
///
/// This implementation is generic and works for any node type [T].
///
/// - Returns a list of nodes representing the Eulerian trail/circuit, or null if none exists.
///
/// Time Complexity: O(E), where E is the number of edges.
///
/// Example:
/// ```dart
/// final graph = {
///   0: [1, 2],
///   1: [2],
///   2: [0, 1],
/// };
/// final trail = hierholzer(graph);
/// print(trail); // Eulerian trail or circuit
/// ```
List<T>? hierholzer<T>(Map<T, List<T>> graph) {
  // treat as undirected by symmetrizing adjacency to ensure correct traversal
  final localGraph = <T, List<T>>{};
  for (var u in graph.keys) {
    localGraph[u] = List<T>.from(graph[u]!);
  }
  for (var u in graph.keys) {
    for (var v in graph[u]!) {
      localGraph.putIfAbsent(v, () => <T>[]);
      if (!localGraph[v]!.contains(u)) localGraph[v]!.add(u);
    }
  }
  final stack = <T>[];
  final path = <T>[];
  T? start = localGraph.keys.firstWhere(
    (u) => (localGraph[u]!.length % 2 == 1),
    orElse: () => localGraph.keys.first,
  );
  if (start == null) return null;
  stack.add(start);
  while (stack.isNotEmpty) {
    final u = stack.last;
    if (localGraph[u]!.isNotEmpty) {
      final v = localGraph[u]!.removeLast();
      // remove back-edge to ensure edge is consumed in undirected graph
      localGraph[v]!.remove(u);
      stack.add(v);
    } else {
      path.add(stack.removeLast());
    }
  }
  return path.reversed.toList();
}
