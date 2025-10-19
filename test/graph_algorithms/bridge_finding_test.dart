import 'package:vaxp_graph/vaxp_graph.dart';
import 'package:test/test.dart';

void main() {
  group('Bridge Finding', () {
    test('Find bridges', () {
      final graph = <int, List<int>>{
        0: [1, 2],
        1: [0, 2],
        2: [0, 1, 3],
        3: [2],
      };
      final bridges = findBridges(graph);
      // match by value rather than list identity
      expect(
        bridges.any((b) => b.length == 2 && b[0] == 2 && b[1] == 3),
        isTrue,
      );
    });
  });
}
