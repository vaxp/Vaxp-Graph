import 'package:test/test.dart';
import 'package:vaxp_graph/vaxp_graph.dart';

void main() {
  test('Kruskal and Prim MST weight match on connected graph', () {
    final nodes = {'A', 'B', 'C', 'D'};
    final edges = <WeightedEdge<String>>[
      WeightedEdge('A', 'B', 1),
      WeightedEdge('B', 'C', 2),
      WeightedEdge('C', 'D', 1),
      WeightedEdge('A', 'C', 2),
      WeightedEdge('B', 'D', 2),
    ];

    final kruskal = kruskalMST(nodes, List.of(edges));
    final graph = <String, List<WeightedEdge<String>>>{
      'A': [WeightedEdge('A', 'B', 1), WeightedEdge('A', 'C', 2)],
      'B': [
        WeightedEdge('B', 'A', 1),
        WeightedEdge('B', 'C', 2),
        WeightedEdge('B', 'D', 2),
      ],
      'C': [
        WeightedEdge('C', 'B', 2),
        WeightedEdge('C', 'A', 2),
        WeightedEdge('C', 'D', 1),
      ],
      'D': [WeightedEdge('D', 'C', 1), WeightedEdge('D', 'B', 2)],
    };
    final prim = primMST(graph);

    num weight(List<WeightedEdge<String>> es) =>
        es.fold<num>(0, (s, e) => s + e.weight);
    expect(weight(prim), equals(weight(kruskal)));
  });
}
