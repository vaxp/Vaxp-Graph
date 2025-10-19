import 'package:test/test.dart';
import 'package:vaxp_graph/vaxp_graph.dart';

void main() {
  group('Tree Diameter', () {
    test('Diameter and path', () {
      final tree = <int, List<int>>{
        0: [1, 2],
        1: [0, 3, 4],
        2: [0],
        3: [1],
        4: [1],
      };
      final result = treeDiameter(tree);
      expect(result['length'], equals(3));
      expect(result['path'], containsAll([3, 1, 0, 2]));
    });
  });
}
