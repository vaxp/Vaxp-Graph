import 'package:test/test.dart';
import 'package:vaxp_graph/vaxp_graph.dart';

void main() {
  group('Graph Coloring', () {
    test('3-colorable graph', () {
      final graph = <int, List<int>>{
        0: [1, 2],
        1: [0, 2],
        2: [0, 1],
      };
      final coloring = graphColoring(graph, 3);
      expect(coloring, isNotNull);
      expect(coloring!.length, equals(3));
    });
    test('Not 2-colorable', () {
      final graph = <int, List<int>>{
        0: [1, 2],
        1: [0, 2],
        2: [0, 1],
      };
      expect(graphColoring(graph, 2), isNull);
    });
  });
}
