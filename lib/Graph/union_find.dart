/// 🔗 Union-Find (Disjoint Set Union, DSU)
///
/// Re-exports the shared [DisjointSet] as a convenient [UnionFind] typedef
/// for graph algorithms like Kruskal's MST and Connected Components.
library;

import 'package:vaxp_graph/Graph/disjoint_set.dart';

typedef UnionFind<T> = DisjointSet<T>;
