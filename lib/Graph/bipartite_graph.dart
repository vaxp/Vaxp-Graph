/// 🎨 Bipartite Graph Check (Two-Coloring via BFS)
///
/// Determines if an undirected graph is bipartite by attempting to color
/// nodes with two colors such that no adjacent nodes share the same color.
///
/// - Time complexity: O(V + E)
/// - Space complexity: O(V)
///
/// Example:
/// ```dart
/// final square = {1: [2, 4], 2: [1, 3], 3: [2, 4], 4: [1, 3]};
/// final ok = isBipartite(square); // true
/// ```
library;

bool isBipartite<T>(Map<T, List<T>> graph) {
  final Map<T, int> color = <T, int>{};

  final Set<T> nodes = {...graph.keys};
  for (final neighbors in graph.values) {
    nodes.addAll(neighbors);
  }

  for (final T start in nodes) {
    if (color.containsKey(start)) continue;
    color[start] = 0;
    final List<T> queue = <T>[start];
    while (queue.isNotEmpty) {
      final T u = queue.removeAt(0);
      for (final T v in graph[u] ?? const []) {
        if (!color.containsKey(v)) {
          color[v] = 1 - (color[u] ?? 0);
          queue.add(v);
        } else if (color[v] == color[u]) {
          return false;
        }
      }
    }
  }
  return true;
}
