import 'package:test/test.dart';
import 'package:vaxp_graph/vaxp_graph.dart';

void main() {
  group('Johnson\'s Algorithm', () {
    test('All-pairs shortest paths (String nodes)', () {
      final graph = {
        'A': {'B': 2, 'C': 4},
        'B': {'C': 1, 'D': 7},
        'C': {'D': 3},
        'D': {'A': 5},
      };
      final result = johnsonsAlgorithm(graph);
      expect(result['A']!['D'], equals(6));
      expect(result['B']!['A'], equals(9));
      expect(result['C']!['A'], equals(8));
      expect(result['D']!['B'], equals(7));
    });
    test('Negative cycle throws', () {
      final graph = {
        'A': {'B': 1},
        'B': {'C': -2},
        'C': {'A': -2},
      };
      expect(() => johnsonsAlgorithm(graph), throwsException);
    });
  });
}
