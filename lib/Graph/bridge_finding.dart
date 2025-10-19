/// Bridge Finding Algorithm (Tarjan's) for undirected graphs.
///
/// This implementation is generic and works for any node type [T].
///
/// - Finds all bridges (critical edges) in the graph.
/// - Returns a list of pairs representing the bridges.
///
/// Time Complexity: O(V + E), where V is the number of vertices and E is the number of edges.
///
/// Example:
/// ```dart
/// final graph = {
///   0: [1, 2],
///   1: [0, 2],
///   2: [0, 1, 3],
///   3: [2],
/// };
/// final bridges = findBridges(graph);
/// print(bridges); // List of pairs (u, v)
/// ```
List<List<T>> findBridges<T>(Map<T, List<T>> graph) {
  final visited = <T>{};
  final tin = <T, int>{};
  final low = <T, int>{};
  final bridges = <List<T>>[];
  int timer = 0;
  void dfs(T u, T? parent) {
    visited.add(u);
    tin[u] = low[u] = timer++;
    for (var v in graph[u]!) {
      if (v == parent) continue;
      if (visited.contains(v)) {
        low[u] = low[u]!.compareTo(tin[v]!) < 0 ? low[u]! : tin[v]!;
      } else {
        dfs(v, u);
        low[u] = low[u]!.compareTo(low[v]!) < 0 ? low[u]! : low[v]!;
        if (low[v]! > tin[u]!) {
          bridges.add([u, v]);
        }
      }
    }
  }

  for (var u in graph.keys) {
    if (!visited.contains(u)) dfs(u, null);
  }
  return bridges;
}
