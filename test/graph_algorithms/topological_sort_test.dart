import 'package:test/test.dart';
import 'package:vaxp_graph/vaxp_graph.dart';

void main() {
  test('Topological sort of a simple chain', () {
    final graph = <int, List<int>>{
      1: [2],
      2: [3],
      3: [4],
      4: [],
    };
    expect(topologicalSort(graph), equals([1, 2, 3, 4]));
  });

  test('Topological sort throws on cycle', () {
    final graph = <int, List<int>>{
      1: [2],
      2: [3],
      3: [1],
    };
    expect(() => topologicalSort(graph), throwsStateError);
  });
}
