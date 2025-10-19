/// Chinese Postman Problem (Route Inspection) for undirected graphs.
///
/// This implementation is generic and works for any node type [T].
///
/// - Finds the minimum cost closed walk that visits every edge at least once.
/// - Returns the total cost of the optimal route, or null if the graph is not connected.
///
/// Time Complexity: O(N^3), where N is the number of nodes (due to matching).
///
/// Example:
/// ```dart
/// final graph = {
///   0: {1: 1, 2: 1},
///   1: {0: 1, 2: 1},
///   2: {0: 1, 1: 1},
/// };
/// final cost = chinesePostman(graph);
/// print(cost); // Minimum cost to traverse all edges
/// ```
num? chinesePostman<T>(Map<T, Map<T, num>> graph) {
  // Check if graph is connected
  void dfs(T u, Set<T> visited) {
    visited.add(u);
    for (var v in graph[u]!.keys) {
      if (!visited.contains(v)) dfs(v, visited);
    }
  }

  final visited = <T>{};
  dfs(graph.keys.first, visited);
  if (visited.length != graph.length) return null;
  // Find nodes with odd degree
  final odd = <T>[];
  for (var u in graph.keys) {
    if ((graph[u]!.length) % 2 == 1) odd.add(u);
  }
  // If all degrees are even, just sum all edge weights
  num total = 0;
  for (var u in graph.keys) {
    for (var v in graph[u]!.keys) {
      total += graph[u]![v]!;
    }
  }
  total ~/= 2; // Each edge counted twice
  if (odd.isEmpty) return total;
  // Otherwise, pair up odd degree nodes (minimum weight perfect matching)
  // Brute-force for small graphs
  num minExtra = double.infinity;
  void match(List<T> left, num cost) {
    if (left.isEmpty) {
      if (cost < minExtra) minExtra = cost;
      return;
    }
    for (int i = 1; i < left.length; i++) {
      final u = left[0], v = left[i];
      // Use Dijkstra for shortest path
      final dists = _dijkstra(graph, u);
      match([...left.sublist(1, i), ...left.sublist(i + 1)], cost + dists[v]!);
    }
  }

  match(odd, 0);
  return total + minExtra;
}

// Dijkstra's algorithm for shortest paths from [source]. Returns a map of distances.
Map<T, num> _dijkstra<T>(Map<T, Map<T, num>> graph, T source) {
  final dist = <T, num>{for (var v in graph.keys) v: double.infinity};
  final visited = <T>{};
  dist[source] = 0;
  while (visited.length < graph.length) {
    T? u;
    num minDist = double.infinity;
    for (var v in graph.keys) {
      if (!visited.contains(v) && dist[v]! < minDist) {
        minDist = dist[v]!;
        u = v;
      }
    }
    if (u == null) break;
    visited.add(u);
    for (var v in graph[u]!.keys) {
      final weight = graph[u]![v]!;
      if (dist[u]! + weight < dist[v]!) {
        dist[v] = dist[u]! + weight;
      }
    }
  }
  return dist;
}
