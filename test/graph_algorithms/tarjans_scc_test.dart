import 'package:test/test.dart';
import 'package:vaxp_graph/vaxp_graph.dart';

void main() {
  group('Tarjan\'s SCC', () {
    test('Find SCCs', () {
      final graph = <int, List<int>>{
        0: [1],
        1: [2],
        2: [0, 3],
        3: [],
      };
      final sccs = tarjansSCC(graph);
      expect(sccs.length, equals(2));
      expect(
        sccs.any(
          (scc) => scc.contains(0) && scc.contains(1) && scc.contains(2),
        ),
        isTrue,
      );
      expect(sccs.any((scc) => scc.contains(3)), isTrue);
    });
  });
}
