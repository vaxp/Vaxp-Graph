/// 🔁 Kosaraju's Algorithm (Strongly Connected Components)
///
/// Computes SCCs in a directed graph using two DFS passes:
/// 1) DFS on original graph to compute finishing times (order)
/// 2) DFS on reversed graph in decreasing finish-time order to extract SCCs
///
/// - Time complexity: O(V + E)
/// - Space complexity: O(V)
library;

Map<T, List<T>> _reverseGraph<T>(Map<T, List<T>> g) {
  final Map<T, List<T>> rg = {};
  final Set<T> nodes = {...g.keys};
  for (final neighbors in g.values) {
    nodes.addAll(neighbors);
  }
  for (final n in nodes) {
    rg[n] = [];
  }
  g.forEach((u, vs) {
    for (final v in vs) {
      rg[v] = (rg[v] ?? []);
      rg[u] = (rg[u] ?? []);
      rg[v]!.add(u);
    }
  });
  return rg;
}

List<Set<T>> kosarajuSCC<T>(Map<T, List<T>> graph) {
  final Set<T> nodes = {...graph.keys};
  for (final neighbors in graph.values) {
    nodes.addAll(neighbors);
  }

  final Set<T> visited = <T>{};
  final List<T> order = <T>[];

  void dfs1(T u) {
    visited.add(u);
    for (final v in graph[u] ?? const []) {
      if (!visited.contains(v)) dfs1(v);
    }
    order.add(u);
  }

  for (final n in nodes) {
    if (!visited.contains(n)) dfs1(n);
  }

  final rg = _reverseGraph(graph);
  visited.clear();
  final List<Set<T>> components = [];

  void dfs2(T u, Set<T> comp) {
    visited.add(u);
    comp.add(u);
    for (final v in rg[u] ?? const []) {
      if (!visited.contains(v)) dfs2(v, comp);
    }
  }

  for (final u in order.reversed) {
    if (!visited.contains(u)) {
      final Set<T> comp = <T>{};
      dfs2(u, comp);
      components.add(comp);
    }
  }

  return components;
}
