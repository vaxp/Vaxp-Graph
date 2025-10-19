/// 🌐 Floyd-Warshall (All-Pairs Shortest Paths)
///
/// Computes the shortest distances between every pair of nodes.
/// Supports negative edge weights but not negative cycles.
///
/// - Input: [nodes] set and directed [edges]
/// - Time complexity: O(V^3)
/// - Space complexity: O(V^2)
///
/// Example:
/// ```dart
/// final nodes = {'A','B','C'};
/// final edges = [
///   WeightedEdge('A','B',3),
///   WeightedEdge('A','C',10),
///   WeightedEdge('B','C',1),
/// ];
/// final dist = floydWarshall(nodes, edges);
/// // dist['A']['C'] == 4
/// ```
library;

import 'weighted_edge.dart';

Map<T, Map<T, num>> floydWarshall<T>(
  Set<T> nodes,
  List<WeightedEdge<T>> edges,
) {
  final Map<T, Map<T, num>> dist = {
    for (final i in nodes)
      i: {for (final j in nodes) j: (i == j) ? 0 : double.infinity},
  };

  for (final e in edges) {
    dist[e.source]![e.target] =
        dist[e.source]![e.target]!.compareTo(e.weight) > 0
            ? e.weight
            : dist[e.source]![e.target]!;
  }

  for (final k in nodes) {
    for (final i in nodes) {
      for (final j in nodes) {
        final alt = dist[i]![k]! + dist[k]![j]!;
        if (alt < dist[i]![j]!) {
          dist[i]![j] = alt;
        }
      }
    }
  }

  return dist;
}
