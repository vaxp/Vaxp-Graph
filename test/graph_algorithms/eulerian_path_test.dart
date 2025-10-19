import 'package:test/test.dart';
import 'package:vaxp_graph/vaxp_graph.dart';

void main() {
  group('Eulerian Path/Circuit', () {
    test('Find Eulerian circuit (undirected)', () {
      final graph = <int, List<int>>{
        0: [1, 2],
        1: [0, 2],
        2: [0, 1],
      };
      final path = findEulerianPath(graph);
      expect(path, isNotNull);
      expect(path!.length, equals(4));
    });
    test('Eulerian trail in simple chain', () {
      final graph = <int, List<int>>{
        0: [1],
        1: [0, 2],
        2: [1],
      };
      final path = findEulerianPath(graph);
      expect(path, isNotNull);
      expect(path!.length, equals(3));
    });
  });
}
