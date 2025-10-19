/// Hamiltonian Path and Cycle Finder using backtracking.
///
/// This implementation is generic and works for any node type [T].
///
/// - Finds a Hamiltonian path or cycle in a graph if one exists.
/// - Returns a list of nodes representing the path/cycle, or null if none exists.
///
/// Time Complexity: O(N!), where N is the number of nodes (NP-complete problem).
///
/// Example:
/// ```dart
/// final graph = {
///   0: [1, 3],
///   1: [0, 2, 3],
///   2: [1, 3],
///   3: [0, 1, 2],
/// };
/// final path = findHamiltonianPath(graph);
/// print(path); // Hamiltonian path or cycle
/// ```
List<T>? findHamiltonianPath<T>(Map<T, List<T>> graph, {bool cycle = false}) {
  final n = graph.length;
  for (var start in graph.keys) {
    final path = <T>[start];
    final visited = <T>{start};
    bool backtrack(T u) {
      if (path.length == n) {
        if (!cycle || (graph[u]?.contains(start) ?? false)) return true;
        return false;
      }
      for (var v in graph[u]!) {
        if (!visited.contains(v)) {
          visited.add(v);
          path.add(v);
          if (backtrack(v)) return true;
          visited.remove(v);
          path.removeLast();
        }
      }
      return false;
    }

    if (backtrack(start)) return path;
  }
  return null;
}
