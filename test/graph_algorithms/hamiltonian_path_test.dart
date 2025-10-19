import 'package:test/test.dart';
import 'package:vaxp_graph/vaxp_graph.dart';

void main() {
  group('Hamiltonian Path/Cycle', () {
    test('Find Hamiltonian cycle', () {
      final graph = <int, List<int>>{
        0: [1, 3],
        1: [0, 2, 3],
        2: [1, 3],
        3: [0, 1, 2],
      };
      final path = findHamiltonianPath(graph, cycle: true);
      expect(path, isNotNull);
      expect(path!.length, equals(4));
      expect(graph[path.first]!.contains(path.last), isTrue);
    });
    test('No Hamiltonian path', () {
      // disconnected graph (node 2 isolated) -> no Hamiltonian path covering all nodes
      final graph = <int, List<int>>{
        0: [1],
        1: [0],
        2: [],
      };
      expect(findHamiltonianPath(graph), isNull);
    });
  });
}
