/// 🚦 Dijkstra's Algorithm (Single-Source Shortest Paths)
///
/// Computes shortest path distances from [start] to all nodes in a graph with
/// non-negative edge weights. Graph is represented as an adjacency list of
/// [WeightedEdge]s.
///
/// - Time complexity (simple implementation): O(V^2 + E)
/// - Space complexity: O(V)
/// - Throws [ArgumentError] if a negative edge weight is encountered.
///
/// Example:
/// ```dart
/// final graph = <String, List<WeightedEdge<String>>>{
///   'A': [WeightedEdge('A', 'B', 1), WeightedEdge('A', 'C', 4)],
///   'B': [WeightedEdge('B', 'C', 2), WeightedEdge('B', 'D', 5)],
///   'C': [WeightedEdge('C', 'D', 1)],
///   'D': [],
/// };
/// final dist = dijkstra(graph, 'A');
/// // dist: {'A':0, 'B':1, 'C':3, 'D':4}
/// ```
library;

import 'weighted_edge.dart';

Map<T, num> dijkstra<T>(Map<T, List<WeightedEdge<T>>> graph, T start) {
  final Set<T> nodes = {...graph.keys};
  for (final neighbors in graph.values) {
    for (final e in neighbors) {
      nodes.add(e.source);
      nodes.add(e.target);
    }
  }

  final Map<T, num> dist = {for (final n in nodes) n: double.infinity};
  dist[start] = 0;

  final Set<T> visited = <T>{};

  while (visited.length < nodes.length) {
    // pick unvisited node with smallest distance
    T? u;
    num best = double.infinity;
    for (final n in nodes) {
      if (!visited.contains(n) && dist[n]! < best) {
        best = dist[n]!;
        u = n;
      }
    }
    if (u == null || dist[u] == double.infinity) break;
    visited.add(u);

    final List<WeightedEdge<T>> edgesFromU = graph[u] ?? <WeightedEdge<T>>[];
    for (final edge in edgesFromU) {
      if (edge.weight < 0) {
        throw ArgumentError('Dijkstra requires non-negative edge weights');
      }
      final alt = dist[u]! + edge.weight;
      if (alt < dist[edge.target]!) {
        dist[edge.target] = alt;
      }
    }
  }

  return dist;
}
