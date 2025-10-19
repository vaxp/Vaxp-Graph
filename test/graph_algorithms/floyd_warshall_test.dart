import 'package:test/test.dart';
import 'package:vaxp_graph/vaxp_graph.dart';

void main() {
  test('Floyd-Warshall all pairs', () {
    final nodes = {'A', 'B', 'C'};
    final edges = <WeightedEdge<String>>[
      WeightedEdge('A', 'B', 3),
      WeightedEdge('A', 'C', 10),
      WeightedEdge('B', 'C', 1),
    ];

    final dist = floydWarshall(nodes, edges);
    expect(dist['A']!['A'], equals(0));
    expect(dist['A']!['B'], equals(3));
    expect(dist['A']!['C'], equals(4));
    expect(dist['B']!['C'], equals(1));
  });
}
