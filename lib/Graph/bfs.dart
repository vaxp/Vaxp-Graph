/// 🎯 Breadth-First Search (BFS)
///
/// Traverses an (unweighted) graph level-by-level starting from [start].
/// Returns the visitation order as a list of nodes of type [T].
///
/// - Input graph is represented as adjacency list: `Map<T, List<T>>`.
/// - If the graph is disconnected, BFS will only visit the component of [start].
/// - Time complexity: O(V + E)
/// - Space complexity: O(V)
///
/// Example:
/// ```dart
/// final graph = {
///   'A': ['B', 'C'],
///   'B': ['D', 'E'],
///   'C': ['F'],
///   'D': [], 'E': ['F'], 'F': []
/// };
/// final order = bfs(graph, 'A');
/// // order: ['A', 'B', 'C', 'D', 'E', 'F']
/// ```
library;

List<T> bfs<T>(Map<T, List<T>> graph, T start) {
  final List<T> order = [];
  final Set<T> visited = <T>{};
  final List<T> queue = <T>[];

  visited.add(start);
  queue.add(start);

  while (queue.isNotEmpty) {
    final T node = queue.removeAt(0);
    order.add(node);

    for (final T neighbor in graph[node] ?? const []) {
      if (!visited.contains(neighbor)) {
        visited.add(neighbor);
        queue.add(neighbor);
      }
    }
  }

  return order;
}
