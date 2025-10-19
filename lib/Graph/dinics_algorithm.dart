/// Dinic's Algorithm for Maximum Flow in a directed graph.
///
/// This implementation is generic and works for any node type [T].
///
/// - Computes the maximum flow from [source] to [sink] in a given capacity graph.
/// - Uses level graphs and blocking flows for efficiency.
///
/// Time Complexity: O(V^2 E), where V is the number of vertices and E is the number of edges (for general graphs).
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
/// final maxFlow = dinicsAlgorithm(graph, 'S', 'D');
/// print(maxFlow); // Maximum flow from S to D
/// ```
num dinicsAlgorithm<T>(Map<T, Map<T, num>> capacity, T source, T sink) {
  final residual = <T, Map<T, num>>{};
  for (var u in capacity.keys) {
    residual[u] = Map<T, num>.from(capacity[u]!);
    for (var v in capacity[u]!.keys) {
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
    // Build level graph using BFS
    final level = <T, int>{};
    final queue = <T>[];
    queue.add(source);
    level[source] = 0;
    while (queue.isNotEmpty) {
      final u = queue.removeAt(0);
      for (var v in residual[u]!.keys) {
        if (!level.containsKey(v) && (residual[u]![v] ?? 0) > 0) {
          level[v] = level[u]! + 1;
          queue.add(v);
        }
      }
    }
    if (!level.containsKey(sink)) break;
    // DFS to send flow
    num sendFlow(T u, num flow) {
      if (u == sink) return flow;
      for (var v in residual[u]!.keys) {
        if (level[v] == level[u]! + 1 && (residual[u]![v] ?? 0) > 0) {
          final available = residual[u]![v] ?? 0;
          final currFlow = sendFlow(v, flow < available ? flow : available);
          if (currFlow > 0) {
            residual[u]![v] = available - currFlow;
            residual[v]![u] = (residual[v]![u] ?? 0) + currFlow;
            return currFlow;
          }
        }
      }
      return 0;
    }

    while (true) {
      final flow = sendFlow(source, double.infinity);
      if (flow == 0) break;
      maxFlow += flow;
    }
  }
  return maxFlow;
}
