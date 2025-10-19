/// 🧩 Articulation Points (Cut Vertices)
///
/// Finds articulation points in an undirected graph using DFS discovery times
/// and low-link values (Tarjan-style). A node is an articulation point if:
/// - It is the root of DFS and has more than one child, or
/// - It is not a root and has a child v with low[v] >= disc[u].
///
/// - Time complexity: O(V + E)
/// - Space complexity: O(V)
library;

Set<T> articulationPoints<T>(Map<T, List<T>> graph) {
  final Set<T> nodes = {...graph.keys};
  for (final neighbors in graph.values) {
    nodes.addAll(neighbors);
  }

  final Map<T, int> disc = <T, int>{};
  final Map<T, int> low = <T, int>{};
  final Map<T, T?> parent = <T, T?>{};
  final Set<T> ap = <T>{};
  int time = 0;

  void dfs(T u) {
    disc[u] = low[u] = ++time;
    int childCount = 0;
    for (final v in graph[u] ?? const []) {
      if (!disc.containsKey(v)) {
        parent[v] = u;
        childCount++;
        dfs(v);
        low[u] = (low[u]!.compareTo(low[v]!) < 0) ? low[u]! : low[v]!;
        if (parent[u] != null && low[v]! >= disc[u]!) {
          ap.add(u);
        }
      } else if (v != parent[u]) {
        low[u] = (low[u]!.compareTo(disc[v]!) < 0) ? low[u]! : disc[v]!;
      }
    }
    if (parent[u] == null && childCount > 1) {
      ap.add(u);
    }
  }

  for (final n in nodes) {
    if (!disc.containsKey(n)) {
      parent[n] = null;
      dfs(n);
    }
  }
  return ap;
}
