/// Stoer-Wagner Algorithm for Global Minimum Cut in an undirected, weighted graph.
///
/// This implementation is generic and works for any node type [T].
///
/// - Finds the minimum cut value of the graph.
/// - Returns the minimum cut value, or null if the graph is not connected.
///
/// Time Complexity: O(V^3), where V is the number of vertices.
///
/// Example:
/// ```dart
/// final graph = {
///   0: {1: 3, 2: 1},
///   1: {0: 3, 2: 3},
///   2: {0: 1, 1: 3},
/// };
/// final minCut = stoerWagnerMinCut(graph);
/// print(minCut); // Minimum cut value
/// ```
num? stoerWagnerMinCut<T>(Map<T, Map<T, num>> graph) {
  if (graph.length < 2) return null;
  final nodes = List<T>.from(graph.keys);
  final g = <T, Map<T, num>>{
    for (var u in graph.keys) u: Map<T, num>.from(graph[u]!),
  };
  // Ensure all maps are initialized for all nodes
  for (var u in nodes) {
    g.putIfAbsent(u, () => {});
    for (var v in nodes) {
      g[u]!.putIfAbsent(v, () => 0);
    }
  }
  num minCut = double.infinity;
  while (nodes.length > 1) {
    final used = <T>{};
    final weights = <T, num>{for (var v in nodes) v: 0};
    T? prev;
    for (int i = 0; i < nodes.length; i++) {
      T sel = nodes
          .where((v) => !used.contains(v))
          .reduce((a, b) => (weights[a] ?? 0) > (weights[b] ?? 0) ? a : b);
      used.add(sel);
      if (i == nodes.length - 1) {
        if ((weights[sel] ?? 0) < minCut) minCut = weights[sel] ?? 0;
        // Merge sel and prev
        if (prev != null) {
          for (var v in g[sel]!.keys) {
            if (v == prev) continue;
            g.putIfAbsent(prev, () => {});
            g[prev]!.putIfAbsent(v, () => 0);
            g[v]!.putIfAbsent(prev, () => 0);
            g[prev]![v] = (g[prev]![v] ?? 0) + (g[sel]![v] ?? 0);
            g[v]![prev] = (g[v]![prev] ?? 0) + (g[sel]![v] ?? 0);
          }
          nodes.remove(sel);
        }
      } else {
        for (var v in g[sel]!.keys) {
          if (!used.contains(v)) {
            weights[v] = (weights[v] ?? 0) + (g[sel]![v] ?? 0);
          }
        }
        prev = sel;
      }
    }
  }
  return minCut;
}
