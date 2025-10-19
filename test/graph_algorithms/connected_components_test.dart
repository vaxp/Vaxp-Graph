import 'package:test/test.dart';
import 'package:vaxp_graph/vaxp_graph.dart';

void main() {
  test('Connected components undirected', () {
    final graph = <String, List<String>>{
      'A': ['B'],
      'B': ['A'],
      'C': [],
    };

    final comps = connectedComponents(graph);
    expect(comps.length, equals(2));
    final compA = comps.firstWhere((c) => c.contains('A'));
    final compC = comps.firstWhere((c) => c.contains('C'));
    expect(compA.containsAll({'A', 'B'}), isTrue);
    expect(compC.contains('C'), isTrue);
  });
}
