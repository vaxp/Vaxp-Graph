import 'package:test/test.dart';
import 'package:vaxp_graph/vaxp_graph.dart';

void main() {
  group('Stoer-Wagner Minimum Cut', () {
    test('Minimum cut value', () {
      final graph = <int, Map<int, num>>{
        0: {1: 3, 2: 1},
        1: {0: 3, 2: 3},
        2: {0: 1, 1: 3},
      };
      final minCut = stoerWagnerMinCut(graph);
      expect(minCut, equals(4));
    });
    test('Single node returns null', () {
      final graph = <int, Map<int, num>>{0: {}};
      expect(stoerWagnerMinCut(graph), isNull);
    });
  });
}
