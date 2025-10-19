import 'package:test/test.dart';
import 'package:vaxp_graph/vaxp_graph.dart';

void main() {
  group('Yen\'s Algorithm', () {
    test('Top-K shortest paths', () {
      final graph = <int, Map<int, num>>{
        0: {1: 1, 2: 5},
        1: {2: 1, 3: 2},
        2: {3: 1},
        3: {},
      };
      final paths = yensAlgorithm(graph, 0, 3, 3);
      expect(paths.length, greaterThanOrEqualTo(1));
      expect(paths.first, equals([0, 1, 2, 3]));
    });
  });
}
