/// Yen's Algorithm for finding the K shortest loopless paths between two nodes in a graph.
///
/// This implementation is generic and works for any node type [T].
///
/// - Returns a list of paths, each as a list of nodes, sorted by total cost.
///
/// Time Complexity: O(KN^3), where N is the number of nodes, K is the number of paths.
///
/// Example:
/// ```dart
/// final graph = {
///   0: {1: 1, 2: 5},
///   1: {2: 1, 3: 2},
///   2: {3: 1},
///   3: {},
/// };
/// final paths = yensAlgorithm(graph, 0, 3, 3);
/// print(paths); // List of up to 3 shortest paths from 0 to 3
/// ```
List<List<T>> yensAlgorithm<T>(
  Map<T, Map<T, num>> graph,
  T source,
  T target,
  int k,
) {
  List<T>? dijkstra(Map<T, Map<T, num>> g, T s, T t) {
    final dist = <T, num>{for (var v in g.keys) v: double.infinity};
    final prev = <T, T?>{};
    final visited = <T>{};
    dist[s] = 0;
    while (visited.length < g.length) {
      T? u;
      num minDist = double.infinity;
      for (var v in g.keys) {
        if (!visited.contains(v) && dist[v]! < minDist) {
          minDist = dist[v]!;
          u = v;
        }
      }
      if (u == null || dist[u] == double.infinity) break;
      visited.add(u);
      for (var v in g[u]!.keys) {
        final weight = g[u]![v]!;
        // allow overwrite on equal distance to prefer later-discovered routes
        if (dist[u]! + weight <= dist[v]!) {
          dist[v] = dist[u]! + weight;
          prev[v] = u;
        }
      }
    }
    if (dist[t] == double.infinity) return null;
    final path = <T>[];
    for (T? at = t; at != null; at = prev[at]) {
      path.add(at);
    }
    return path.reversed.toList();
  }

  final paths = <List<T>>[];
  final candidates = <List<T>>[];
  final costs = <List<T>, num>{};
  final firstPath = dijkstra(graph, source, target);
  if (firstPath == null) return [];
  paths.add(firstPath);
  costs[firstPath] = _pathCost(graph, firstPath);
  for (int ki = 1; ki < k; ki++) {
    for (int i = 0; i < paths[ki - 1].length - 1; i++) {
      final spurNode = paths[ki - 1][i];
      final rootPath = paths[ki - 1].sublist(0, i + 1);
      final removedEdges = <T, Map<T, num>>{};
      for (var p in paths) {
        if (p.length > i &&
            ListEquality().equals(rootPath, p.sublist(0, i + 1))) {
          final u = p[i];
          final v = p[i + 1];
          removedEdges[u] = removedEdges[u] ?? {};
          removedEdges[u]![v] = graph[u]?[v] ?? 0;
          graph[u]?.remove(v);
        }
      }
      final spurPath = dijkstra(graph, spurNode, target);
      for (var u in removedEdges.keys) {
        for (var v in removedEdges[u]!.keys) {
          graph[u] ??= {};
          graph[u]![v] = removedEdges[u]![v]!;
        }
      }
      if (spurPath != null) {
        final totalPath = [
          ...rootPath.sublist(0, rootPath.length - 1),
          ...spurPath,
        ];
        if (!paths.any((p) => ListEquality().equals(p, totalPath)) &&
            !candidates.any((p) => ListEquality().equals(p, totalPath))) {
          candidates.add(totalPath);
          costs[totalPath] = _pathCost(graph, totalPath);
        }
      }
    }
    if (candidates.isEmpty) break;
    candidates.sort((a, b) => costs[a]!.compareTo(costs[b]!));
    paths.add(candidates.removeAt(0));
  }
  return paths;
}

num _pathCost<T>(Map<T, Map<T, num>> graph, List<T> path) {
  num cost = 0;
  for (int i = 0; i < path.length - 1; i++) {
    final u = path[i];
    final v = path[i + 1];
    final edgeCost = graph[u]?[v];
    if (edgeCost == null) return double.infinity;
    cost += edgeCost;
  }
  return cost;
}

class ListEquality {
  bool equals<T>(List<T> a, List<T> b) {
    if (a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }
}
