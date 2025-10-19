/// 🧱 Weighted Edge
///
/// Represents a directed edge `source -> target` with a numeric [weight].
/// Useful for weighted graph algorithms like Dijkstra, Bellman-Ford, MSTs,
/// and Floyd-Warshall.
library;

class WeightedEdge<T> {
  final T source;
  final T target;
  final num weight;

  const WeightedEdge(this.source, this.target, this.weight);
}
