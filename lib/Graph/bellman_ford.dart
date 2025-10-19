/// 🧮 Bellman-Ford Algorithm (Single-Source Shortest Paths)
///
/// Computes shortest path distances from [start] to all nodes for graphs with
/// possibly negative edge weights. Detects negative weight cycles and throws
/// [StateError] in that case.
///
/// - Input: [nodes] set and [edges] list
/// - Time complexity: O(V·E)
/// - Space complexity: O(V)
///
/// Example:
/// ```dart
/// final nodes = {'A','B','C','D'};
/// final edges = [
///   WeightedEdge('A','B',1), WeightedEdge('B','C',2),
///   WeightedEdge('A','C',4), WeightedEdge('C','D',1),
/// ];
/// final dist = bellmanFord(nodes, edges, 'A');
/// // dist: {'A':0, 'B':1, 'C':3, 'D':4}
/// ```
library;

import 'weighted_edge.dart';

Map<T, num> bellmanFord<T>(Set<T> nodes, List<WeightedEdge<T>> edges, T start) {
  final Map<T, num> dist = {for (final n in nodes) n: double.infinity};
  dist[start] = 0;

  for (var i = 0; i < nodes.length - 1; i++) {
    var updated = false;
    for (final e in edges) {
      if (dist[e.source] != double.infinity) {
        final alt = dist[e.source]! + e.weight;
        if (alt < dist[e.target]!) {
          dist[e.target] = alt;
          updated = true;
        }
      }
    }
    if (!updated) break;
  }

  for (final e in edges) {
    if (dist[e.source] != double.infinity &&
        dist[e.source]! + e.weight < dist[e.target]!) {
      throw StateError('Graph contains a negative weight cycle');
    }
  }

  return dist;
}
