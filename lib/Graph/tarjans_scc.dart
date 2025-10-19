/// Tarjan's Algorithm for finding Strongly Connected Components (SCC) in a directed graph.
///
/// This implementation is generic and works for any node type [T].
///
/// - Returns a list of SCCs, each as a list of nodes.
///
/// Time Complexity: O(V + E), where V is the number of vertices and E is the number of edges.
///
/// Example:
/// ```dart
/// final graph = {
///   0: [1],
///   1: [2],
///   2: [0, 3],
///   3: [],
/// };
/// final sccs = tarjansSCC(graph);
/// print(sccs); // List of SCCs
/// ```
List<List<T>> tarjansSCC<T>(Map<T, List<T>> graph) {
  final index = <T, int>{};
  final lowlink = <T, int>{};
  final stack = <T>[];
  final onStack = <T, bool>{};
  final sccs = <List<T>>[];
  int idx = 0;
  void strongConnect(T v) {
    index[v] = idx;
    lowlink[v] = idx;
    idx++;
    stack.add(v);
    onStack[v] = true;
    for (var w in graph[v]!) {
      if (!index.containsKey(w)) {
        strongConnect(w);
        lowlink[v] =
            lowlink[v]!.compareTo(lowlink[w]!) < 0 ? lowlink[v]! : lowlink[w]!;
      } else if (onStack[w] == true) {
        lowlink[v] =
            lowlink[v]!.compareTo(index[w]!) < 0 ? lowlink[v]! : index[w]!;
      }
    }
    if (lowlink[v] == index[v]) {
      final scc = <T>[];
      T w;
      do {
        w = stack.removeLast();
        onStack[w] = false;
        scc.add(w);
      } while (w != v);
      sccs.add(scc);
    }
  }

  for (var v in graph.keys) {
    if (!index.containsKey(v)) strongConnect(v);
  }
  return sccs;
}
