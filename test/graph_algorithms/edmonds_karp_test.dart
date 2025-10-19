import 'package:test/test.dart';
import 'package:vaxp_graph/vaxp_graph.dart';

void main() {
  group('Edmonds-Karp Algorithm', () {
    test('Maximum flow (String nodes)', () {
      final graph = <String, Map<String, num>>{
        'S': {'A': 10, 'C': 10},
        'A': {'B': 4, 'C': 2, 'D': 8},
        'B': {'D': 10},
        'C': {'D': 9},
        'D': {},
      };
      final maxFlow = edmondsKarp(graph, 'S', 'D');
      expect(maxFlow, equals(19));
    });
    test('Zero flow if no path', () {
      final graph = <int, Map<int, num>>{
        0: {1: 5},
        1: {},
        2: {3: 7},
        3: {},
      };
      expect(edmondsKarp(graph, 0, 3), equals(0));
    });
  });
}
