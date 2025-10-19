import 'package:vaxp_graph/vaxp_graph.dart';
import 'package:test/test.dart';

void main() {
  test('Bellman-Ford shortest distances and negative cycle detection', () {
    final nodes = {'A', 'B', 'C', 'D'};
    final edges = <WeightedEdge<String>>[
      WeightedEdge('A', 'B', 1),
      WeightedEdge('B', 'C', 2),
      WeightedEdge('A', 'C', 4),
      WeightedEdge('C', 'D', 1),
    ];

    final dist = bellmanFord(nodes, edges, 'A');
    expect(dist['A'], equals(0));
    expect(dist['B'], equals(1));
    expect(dist['C'], equals(3));
    expect(dist['D'], equals(4));

    final negCycleEdges = <WeightedEdge<String>>[
      WeightedEdge('A', 'B', 1),
      WeightedEdge('B', 'C', -2),
      WeightedEdge('C', 'A', -2),
    ];
    expect(
      () => bellmanFord({'A', 'B', 'C'}, negCycleEdges, 'A'),
      throwsStateError,
    );
  });
}
