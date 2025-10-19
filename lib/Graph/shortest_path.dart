/// 🛤️ Shortest Path (Unweighted) via BFS
///
/// Computes a shortest path between [start] and [target] in an unweighted
/// graph using BFS, returning the path as a list from start to target.
/// Returns an empty list if no path exists.
///
/// - Time complexity: O(V + E)
/// - Space complexity: O(V)
///
/// Example:
/// ```dart
/// final graph = {
///   'A': ['B', 'C'], 'B': ['D', 'E'], 'C': ['F'], 'E': ['F']
/// };
/// final path = shortestPathUnweighted(graph, 'A', 'F');
/// // path: ['A', 'C', 'F']
/// ```
library;

List<T> shortestPathUnweighted<T>(Map<T, List<T>> graph, T start, T target) {
  if (start == target) return [start];
  final Map<T, T?> parent = <T, T?>{};
  final Set<T> visited = <T>{start};
  final List<T> queue = <T>[start];

  while (queue.isNotEmpty) {
    final T u = queue.removeAt(0);
    for (final T v in graph[u] ?? const []) {
      if (!visited.contains(v)) {
        visited.add(v);
        parent[v] = u;
        if (v == target) {
          final List<T> pathReversed = <T>[];
          T? cur = v;
          while (cur != null) {
            pathReversed.add(cur);
            cur = parent[cur];
          }
          return pathReversed.reversed.toList();
        }
        queue.add(v);
      }
    }
  }
  return <T>[];
}
