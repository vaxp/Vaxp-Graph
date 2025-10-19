/// Transitive Closure of a directed graph using Floyd-Warshall algorithm.
///
/// This implementation is generic and works for any node type [T].
///
/// - Computes the transitive closure (reachability matrix) of the graph.
/// - Returns a map where closure[u][v] is true if v is reachable from u.
///
/// Time Complexity: O(V^3), where V is the number of vertices.
///
/// Example:
/// ```dart
/// final graph = {
///   0: [1],
///   1: [2],
///   2: [0, 3],
///   3: [],
/// };
/// final closure = transitiveClosure(graph);
/// print(closure[0][3]); // true if 3 is reachable from 0
/// ```
Map<T, Map<T, bool>> transitiveClosure<T>(Map<T, List<T>> graph) {
  final nodes = graph.keys.toList();
  final closure = <T, Map<T, bool>>{
    for (var u in nodes) u: {for (var v in nodes) v: false},
  };
  for (var u in nodes) {
    for (var v in graph[u]!) {
      closure[u]![v] = true;
    }
    closure[u]![u] = true;
  }
  for (var k in nodes) {
    for (var i in nodes) {
      for (var j in nodes) {
        if (closure[i]![k]! && closure[k]![j]!) {
          closure[i]![j] = true;
        }
      }
    }
  }
  return closure;
}
