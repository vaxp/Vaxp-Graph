import 'package:vaxp_graph/vaxp_graph.dart';
import 'package:test/test.dart';

void main() {
  group('SPFA', () {
    test('Shortest paths', () {
      final graph = <int, Map<int, num>>{
        0: {1: 2, 2: 4},
        1: {2: 1, 3: 7},
        2: {3: 3},
        3: {0: 5},
      };
      final dist = spfa(graph, 0);
      expect(dist[3], equals(6));
    });
  });
}
