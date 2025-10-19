import 'package:test/test.dart';
import 'package:vaxp_graph/vaxp_graph.dart';

void main() {
  test('Dijkstra shortest distances', () {
    final graph = <String, List<WeightedEdge<String>>>{
      'A': [WeightedEdge('A', 'B', 1), WeightedEdge('A', 'C', 4)],
      'B': [WeightedEdge('B', 'C', 2), WeightedEdge('B', 'D', 5)],
      'C': [WeightedEdge('C', 'D', 1)],
      'D': [],
    };

    final dist = dijkstra(graph, 'A');
    expect(dist['A'], equals(0));
    expect(dist['B'], equals(1));
    expect(dist['C'], equals(3));
    expect(dist['D'], equals(4));
  });
}
