/// ♻️ Cycle Detection
///
/// Provides two utilities:
/// - [hasCycleDirected]: Detects cycles in a directed graph using DFS with
///   recursion stack (colors/visiting set).
/// - [hasCycleUndirected]: Detects cycles in an undirected graph using DFS
///   tracking parent pointers.
///
/// - Time complexity: O(V + E)
/// - Space complexity: O(V)
library;

bool hasCycleDirected<T>(Map<T, List<T>> graph) {
  final Set<T> visiting = <T>{};
  final Set<T> visited = <T>{};

  bool dfs(T node) {
    if (visiting.contains(node)) return true;
    if (visited.contains(node)) return false;
    visiting.add(node);
    for (final T neighbor in graph[node] ?? const []) {
      if (dfs(neighbor)) return true;
    }
    visiting.remove(node);
    visited.add(node);
    return false;
  }

  final Set<T> nodes = {...graph.keys};
  for (final neighbors in graph.values) {
    nodes.addAll(neighbors);
  }
  for (final T node in nodes) {
    if (!visited.contains(node)) {
      if (dfs(node)) return true;
    }
  }
  return false;
}

bool hasCycleUndirected<T>(Map<T, List<T>> graph) {
  final Set<T> visited = <T>{};

  bool dfs(T node, T? parent) {
    visited.add(node);
    for (final T neighbor in graph[node] ?? const []) {
      if (!visited.contains(neighbor)) {
        if (dfs(neighbor, node)) return true;
      } else if (neighbor != parent) {
        return true;
      }
    }
    return false;
  }

  final Set<T> nodes = {...graph.keys};
  for (final neighbors in graph.values) {
    nodes.addAll(neighbors);
  }
  for (final T node in nodes) {
    if (!visited.contains(node)) {
      if (dfs(node, null)) return true;
    }
  }
  return false;
}
