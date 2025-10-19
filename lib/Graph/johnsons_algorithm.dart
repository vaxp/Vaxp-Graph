/// Johnson's Algorithm for All-Pairs Shortest Paths in a weighted, directed graph.
///
/// This implementation is generic and works for any node type [T].
///
/// - Finds shortest paths between all pairs of nodes, even with negative edge weights (no negative cycles).
/// - Uses Bellman-Ford and Dijkstra's algorithms internally.
///
/// Time Complexity: O(V^2 log V + VE), where V is the number of vertices and E is the number of edges.
///
/// Example:
/// ```dart
/// final graph = {
///   'A': {'B': 2, 'C': 4},
///   'B': {'C': 1, 'D': 7},
///   'C': {'D': 3},
///   'D': {'A': 5},
/// };
/// final result = johnsonsAlgorithm(graph);
/// print(result['A']['D']); // Shortest path from A to D
/// ```
Map<T, Map<T, num>> johnsonsAlgorithm<T>(Map<T, Map<T, num>> graph) {
  // Step 1: Add a new node 'Q' connected to all nodes with 0-weight edges
  final nodes = Set<T>.from(graph.keys);
  final originalNodes = Set<T>.from(graph.keys);
  // Use a unique string key for the extra node, cast to T if T is String, otherwise throw if T is not nullable
  late final T q;
  if (T == String) {
    q = '__Q__' as T;
  } else if (T == int) {
    q = -999999999 as T;
  } else {
    throw Exception(
      'Johnson\'s Algorithm: T must be String or int for node type.',
    );
  }
  final extendedGraph = Map<T, Map<T, num>>.from(graph);
  extendedGraph[q] = {for (var v in nodes) v: 0};
  for (var v in nodes) {
    extendedGraph.putIfAbsent(v, () => {});
  }

  // Step 2: Run Bellman-Ford from 'Q' to get h(v) potentials
  final h = _bellmanFord(extendedGraph, q);
  if (h == null) {
    throw Exception('Graph contains a negative-weight cycle');
  }

  // Step 3: Reweight edges
  final reweighted = <T, Map<T, num>>{};
  // Exclude the extra node 'q' from reweighting
  for (var u in originalNodes) {
    reweighted[u] = {};
    for (var v in (graph[u]?.keys.where((k) => originalNodes.contains(k)) ?? {})
        .cast<T>()) {
      reweighted[u]![v] = graph[u]![v]! + h[u]! - h[v]!;
    }
  }

  // Step 4: For each node, run Dijkstra
  final result = <T, Map<T, num>>{};
  for (var u in originalNodes) {
    final d = _dijkstra(reweighted, u);
    result[u] = {};
    for (var v in originalNodes) {
      if (d[v] != null) {
        // Undo reweighting
        result[u]![v] = d[v]! - h[u]! + h[v]!;
      }
    }
  }
  return result;
}

/// Bellman-Ford algorithm for shortest paths from [source]. Returns a map of distances or null if negative cycle.
Map<T, num>? _bellmanFord<T>(Map<T, Map<T, num>> graph, T source) {
  final dist = <T, num>{for (var v in graph.keys) v: double.infinity};
  dist[source] = 0;
  final vertices = graph.keys.toList();
  for (int i = 0; i < vertices.length - 1; i++) {
    for (var u in graph.keys) {
      for (var v in graph[u]!.keys) {
        final weight = graph[u]![v]!;
        if (dist[u]! + weight < dist[v]!) {
          dist[v] = dist[u]! + weight;
        }
      }
    }
  }
  // Check for negative-weight cycles
  for (var u in graph.keys) {
    for (var v in graph[u]!.keys) {
      final weight = graph[u]![v]!;
      if (dist[u]! + weight < dist[v]!) {
        return null;
      }
    }
  }
  return dist;
}

/// Dijkstra's algorithm for shortest paths from [source]. Returns a map of distances.
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
