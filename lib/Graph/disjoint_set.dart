/// A generic implementation of the Disjoint Set (Union-Find) data structure
/// with path compression and union by rank optimization.
///
/// It works with any type [T] that can be compared using equality.
class DisjointSet<T> {
  final Map<T, T> _parent = {};
  final Map<T, int> _rank = {};

  /// Adds a new element to the disjoint set.
  void add(T item) {
    if (!_parent.containsKey(item)) {
      _parent[item] = item;
      _rank[item] = 0;
    }
  }

  /// Finds the representative (root) of the set that contains [item],
  /// applying path compression for efficiency.
  T find(T item) {
    if (_parent[item] != item) {
      _parent[item] = find(_parent[item] as T);
    }
    return _parent[item]!;
  }

  /// Unites the sets containing [x] and [y] using union by rank.
  void union(T x, T y) {
    add(x);
    add(y);

    final rootX = find(x);
    final rootY = find(y);

    if (rootX == rootY) return;

    final rankX = _rank[rootX]!;
    final rankY = _rank[rootY]!;

    if (rankX < rankY) {
      _parent[rootX] = rootY;
    } else if (rankX > rankY) {
      _parent[rootY] = rootX;
    } else {
      _parent[rootY] = rootX;
      _rank[rootX] = rankX + 1;
    }
  }

  /// Returns the current set representative for each element.
  Map<T, T> get sets => {
        for (var element in _parent.keys) element: find(element),
      };
}
