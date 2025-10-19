import 'package:test/test.dart';
import 'package:vaxp_graph/vaxp_graph.dart';

void main() {
  group('Transitive Closure', () {
    test('Reachability matrix', () {
      final graph = <int, List<int>>{
        0: [1],
        1: [2],
        2: [0, 3],
        3: [],
      };
      final closure = transitiveClosure(graph);
      expect(closure[0]![3], isTrue);
      expect(closure[3]![0], isFalse);
    });
  });
}
