import 'package:test/test.dart';
import 'package:vaxp_graph/vaxp_graph.dart';

void main() {
  group('Chinese Postman Problem', () {
    test('Minimum cost for Eulerian graph', () {
      final graph = <int, Map<int, num>>{
        0: {1: 1, 2: 1},
        1: {0: 1, 2: 1},
        2: {0: 1, 1: 1},
      };
      final cost = chinesePostman(graph);
      expect(cost, equals(3));
    });
    test('Disconnected graph returns null', () {
      final graph = <int, Map<int, num>>{
        0: {1: 1},
        1: {0: 1},
        2: {},
      };
      expect(chinesePostman(graph), isNull);
    });
  });
}
