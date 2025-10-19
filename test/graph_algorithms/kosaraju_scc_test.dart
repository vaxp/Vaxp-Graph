import 'package:test/test.dart';
import 'package:vaxp_graph/vaxp_graph.dart';

void main() {
  test('Kosaraju SCC count', () {
    final graph = <int, List<int>>{
      1: [2],
      2: [3],
      3: [1, 4],
      4: [5],
      5: [6],
      6: [4],
    };
    final comps = kosarajuSCC(graph);
    expect(comps.length, equals(2));
  });
}
