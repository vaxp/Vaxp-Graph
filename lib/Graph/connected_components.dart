/// 🔗 Connected Components (Undirected)
///
/// Finds all connected components in an undirected graph represented as an
/// adjacency list. Returns a list of sets where each set contains the nodes
/// of one component.
///
/// - Time complexity: O(V + E)
/// - Space complexity: O(V)
///
/// Example:
/// ```dart
/// final graph = {'A': ['B'], 'B': ['A'], 'C': []};
/// final comps = connectedComponents(graph); // [{A, B}, {C}]
/// ```
library;

List<Set<T>> connectedComponents<T>(Map<T, List<T>> graph) {
  final Set<T> visited = <T>{};
  final List<Set<T>> components = [];

  final Set<T> nodes = {...graph.keys};
  for (final neighbors in graph.values) {
    nodes.addAll(neighbors);
  }

  for (final T start in nodes) {
    if (visited.contains(start)) continue;
    final Set<T> component = <T>{};
    final List<T> stack = <T>[start];
    visited.add(start);

    while (stack.isNotEmpty) {
      final T node = stack.removeLast();
      component.add(node);
      for (final T neighbor in graph[node] ?? const []) {
        if (!visited.contains(neighbor)) {
          visited.add(neighbor);
          stack.add(neighbor);
        }
      }
    }

    components.add(component);
  }

  return components;
}
