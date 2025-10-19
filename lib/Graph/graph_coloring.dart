/// Graph Coloring (m-coloring problem) using backtracking.
///
/// This implementation is generic and works for any node type [T].
///
/// - Attempts to color the graph with at most [m] colors so that no adjacent nodes share a color.
/// - Returns a map from node to color index (0-based), or null if not possible.
///
/// Time Complexity: O(m^N), where N is the number of nodes.
///
/// Example:
/// ```dart
/// final graph = {
///   0: [1, 2],
///   1: [0, 2],
///   2: [0, 1],
/// };
/// final coloring = graphColoring(graph, 3);
/// print(coloring); // Map of node to color index
/// ```
Map<T, int>? graphColoring<T>(Map<T, List<T>> graph, int m) {
  final nodes = graph.keys.toList();
  final color = <T, int>{};
  bool isSafe(T node, int c) {
    for (var neighbor in graph[node]!) {
      if (color[neighbor] == c) return false;
    }
    return true;
  }

  bool solve(int idx) {
    if (idx == nodes.length) return true;
    final node = nodes[idx];
    for (int c = 0; c < m; c++) {
      if (isSafe(node, c)) {
        color[node] = c;
        if (solve(idx + 1)) return true;
        color.remove(node);
      }
    }
    return false;
  }

  if (solve(0)) return color;
  return null;
}
