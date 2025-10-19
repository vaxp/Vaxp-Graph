import 'package:vaxp_graph/vaxp_graph.dart';
import 'package:test/test.dart';

void main() {
  test('BFS traversal order', () {
    final graph = <String, List<String>>{
      'A': ['B', 'C'],
      'B': ['D', 'E'],
      'C': ['F'],
      'D': [],
      'E': ['F'],
      'F': [],
    };
    expect(bfs(graph, 'A'), equals(['A', 'B', 'C', 'D', 'E', 'F']));
  });
}
