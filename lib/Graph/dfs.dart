/// 🧭 Depth-First Search (DFS)
///
/// Traverses an (unweighted) graph by exploring as far as possible along each
/// branch before backtracking. Returns the visitation order starting at [start].
///
/// - Recursive implementation
/// - Time complexity: O(V + E)
/// - Space complexity: O(V) due to recursion stack and visited set
///
/// Example:
/// ```dart
/// final graph = {
///   'A': ['B', 'C'],
///   'B': ['D', 'E'],
///   'C': ['F'],
///   'D': [], 'E': ['F'], 'F': []
/// };
/// final order = dfs(graph, 'A');
/// // order: ['A', 'B', 'D', 'E', 'F', 'C']
/// ```
library;

List<T> dfs<T>(Map<T, List<T>> graph, T start) {
  final List<T> order = [];
  final Set<T> visited = <T>{};

  void visit(T node) {
    if (visited.contains(node)) return;
    visited.add(node);
    order.add(node);
    for (final T neighbor in graph[node] ?? const []) {
      visit(neighbor);
    }
  }

  visit(start);
  return order;
}
