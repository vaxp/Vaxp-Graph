/// 🌲 Kruskal's Algorithm (Minimum Spanning Tree/Forest)
///
/// Finds a minimum spanning forest by sorting edges by weight and adding them
/// greedily while avoiding cycles using a Union-Find (Disjoint Set).
///
/// - Input: [nodes] set and undirected [edges]
/// - Time complexity: O(E log E)
/// - Space complexity: O(V)
///
/// Returns the list of edges in the MST (or MSF if graph is disconnected).
library;

import 'package:vaxp_graph/Graph/disjoint_set.dart';
import 'weighted_edge.dart';

List<WeightedEdge<T>> kruskalMST<T>(Set<T> nodes, List<WeightedEdge<T>> edges) {
  final DisjointSet<T> ds = DisjointSet<T>();
  for (final n in nodes) {
    ds.add(n);
  }

  edges.sort((a, b) => a.weight.compareTo(b.weight));

  final List<WeightedEdge<T>> result = [];
  for (final e in edges) {
    if (ds.find(e.source) != ds.find(e.target)) {
      ds.union(e.source, e.target);
      result.add(e);
    }
  }
  return result;
}
