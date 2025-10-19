/// Shortest Path Faster Algorithm (SPFA) for single-source shortest paths in a weighted, directed graph.
///
/// This implementation is generic and works for any node type [T].
///
/// - Computes shortest paths from [source] to all other nodes, even with negative weights (no negative cycles).
/// - Returns a map of shortest distances from [source].
///
/// Time Complexity: O(kE), where k is a small constant (average case), E is the number of edges.
///
/// Example:
/// ```dart
/// final graph = {
///   0: {1: 2, 2: 4},
///   1: {2: 1, 3: 7},
///   2: {3: 3},
///   3: {0: 5},
/// };
/// final dist = spfa(graph, 0);
/// print(dist[3]); // Shortest path from 0 to 3
/// ```
Map<T, num> spfa<T>(Map<T, Map<T, num>> graph, T source) {
  final dist = <T, num>{for (var v in graph.keys) v: double.infinity};
  final inQueue = <T>{};
  final queue = <T>[];
  dist[source] = 0;
  queue.add(source);
  inQueue.add(source);
  while (queue.isNotEmpty) {
    final u = queue.removeAt(0);
    inQueue.remove(u);
    for (var v in graph[u]!.keys) {
      final weight = graph[u]![v]!;
      if (dist[u]! + weight < dist[v]!) {
        dist[v] = dist[u]! + weight;
        if (!inQueue.contains(v)) {
          queue.add(v);
          inQueue.add(v);
        }
      }
    }
  }
  return dist;
}
