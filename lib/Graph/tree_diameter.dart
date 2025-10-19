/// Computes the diameter of a tree (longest path between any two nodes).
///
/// This implementation is generic and works for any node type [T].
///
/// - Returns the length of the diameter and the path as a list of nodes.
///
/// Time Complexity: O(N), where N is the number of nodes.
///
/// Example:
/// ```dart
/// final tree = {
///   0: [1, 2],
///   1: [0, 3, 4],
///   2: [0],
///   3: [1],
///   4: [1],
/// };
/// final result = treeDiameter(tree);
/// print(result['length']); // Diameter length
/// print(result['path']);   // List of nodes in the diameter path
/// ```
Map<String, dynamic> treeDiameter<T>(Map<T, List<T>> tree) {
  T farthest(T start) {
    final visited = <T>{};
    T last = start;
    int maxDist = 0;
    void dfs(T u, int dist) {
      visited.add(u);
      if (dist > maxDist) {
        maxDist = dist;
        last = u;
      }
      for (var v in tree[u]!) {
        if (!visited.contains(v)) dfs(v, dist + 1);
      }
    }

    dfs(start, 0);
    return last;
  }

  // First DFS to find one end
  final u = tree.keys.first;
  final v = farthest(u);
  // Second DFS to find the path
  final visited = <T>{};
  final path = <T>[];
  bool dfs2(T curr, T target) {
    visited.add(curr);
    path.add(curr);
    if (curr == target) return true;
    for (var next in tree[curr]!) {
      if (!visited.contains(next) && dfs2(next, target)) return true;
    }
    path.removeLast();
    return false;
  }

  dfs2(v, farthest(v));
  return {'length': path.length - 1, 'path': path};
}
