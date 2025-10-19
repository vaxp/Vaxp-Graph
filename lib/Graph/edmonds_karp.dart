/// Edmonds-Karp Algorithm for Maximum Flow in a directed graph.
///
/// This implementation is generic and works for any node type [T].
///
/// - Computes the maximum flow from [source] to [sink] in a given capacity graph.
/// - Uses BFS to find augmenting paths (improves over Ford-Fulkerson).
///
/// Time Complexity: O(VE^2), where V is the number of vertices and E is the number of edges.
///
/// Example:
/// ```dart
/// final graph = {
///   'S': {'A': 10, 'C': 10},
///   'A': {'B': 4, 'C': 2, 'D': 8},
///   'B': {'D': 10},
///   'C': {'D': 9},
///   'D': {},
/// };
/// final maxFlow = edmondsKarp(graph, 'S', 'D');
/// print(maxFlow); // Maximum flow from S to D
/// ```
num edmondsKarp<T>(Map<T, Map<T, num>> capacity, T source, T sink) {
  // Build residual graph
  final residual = <T, Map<T, num>>{};
  // Initialize all nodes
  for (var u in capacity.keys) {
    residual[u] = Map<T, num>.from(capacity[u]!);
    for (var v in capacity[u]!.keys) {
      // Ensure reverse edge exists
      residual.putIfAbsent(v, () => {});
      residual[v]!.putIfAbsent(u, () => 0);
    }
  }
  // Ensure all possible edges are initialized
  for (var u in residual.keys) {
    for (var v in residual.keys) {
      residual[u]!.putIfAbsent(v, () => 0);
    }
  }
  num maxFlow = 0;
  while (true) {
    // BFS to find shortest augmenting path
    final parent = <T, T?>{};
    final queue = <T>[];
    queue.add(source);
    parent[source] = null;
    while (queue.isNotEmpty && !parent.containsKey(sink)) {
      final u = queue.removeAt(0);
      for (var v in residual[u]!.keys) {
        if (!parent.containsKey(v) && (residual[u]![v] ?? 0) > 0) {
          parent[v] = u;
          queue.add(v);
        }
      }
    }
    if (!parent.containsKey(sink)) break; // No more augmenting paths
    // Find bottleneck
    num pathFlow = double.infinity;
    for (T v = sink; parent[v] != null; v = parent[v] as T) {
      final u = parent[v] as T;
      final cap = residual[u]![v] ?? 0;
      pathFlow = pathFlow < cap ? pathFlow : cap;
    }
    // Update residual capacities
    for (T v = sink; parent[v] != null; v = parent[v] as T) {
      final u = parent[v] as T;
      residual[u]![v] = (residual[u]![v] ?? 0) - pathFlow;
      residual[v]![u] = (residual[v]![u] ?? 0) + pathFlow;
    }
    maxFlow += pathFlow;
  }
  return maxFlow;
}
