import 'package:vaxp_graph/vaxp_graph.dart';

void main() {
  var awesome = Awesome();
  print('awesome: ${awesome.isAwesome}');
  // =========================
  // Graph Algorithms
  // =========================
  final gUnweighted = <String, List<String>>{
    'A': ['B', 'C'],
    'B': ['D', 'E'],
    'C': ['F'],
    'D': [],
    'E': ['F'],
    'F': [],
  };
  print('BFS: ${bfs(gUnweighted, 'A')}');
  print('DFS: ${dfs(gUnweighted, 'A')}');
  print(
    'Topological Sort (DAG): ${topologicalSort(<int, List<int>>{
          1: [2],
          2: [3],
          3: [4],
          4: [],
        })}',
  );
  print(
    'Connected Components: ${connectedComponents({
          'A': ['B'],
          'B': ['A'],
          'C': [],
        })}',
  );
  print(
    'Has Cycle Directed: ${hasCycleDirected(<int, List<int>>{
          1: [2],
          2: [3],
          3: [1],
        })}',
  );
  print(
    'Has Cycle Undirected: ${hasCycleUndirected({
          'A': ['B', 'C'],
          'B': ['A', 'C'],
          'C': ['A', 'B'],
        })}',
  );
  print(
    'Is Bipartite: ${isBipartite({
          1: [2, 4],
          2: [1, 3],
          3: [2, 4],
          4: [1, 3],
        })}',
  );
  print(
    'Shortest Path (unweighted): ${shortestPathUnweighted(gUnweighted, 'A', 'F')}',
  );

  final weighted = <String, List<WeightedEdge<String>>>{
    'A': [WeightedEdge('A', 'B', 1), WeightedEdge('A', 'C', 4)],
    'B': [WeightedEdge('B', 'C', 2), WeightedEdge('B', 'D', 5)],
    'C': [WeightedEdge('C', 'D', 1)],
    'D': [],
  };
  print('Dijkstra distances: ${dijkstra(weighted, 'A')}');

  final nodes = {'A', 'B', 'C', 'D'};
  final edges = <WeightedEdge<String>>[
    WeightedEdge('A', 'B', 1),
    WeightedEdge('B', 'C', 2),
    WeightedEdge('A', 'C', 4),
    WeightedEdge('C', 'D', 1),
  ];
  print('Bellman-Ford distances: ${bellmanFord(nodes, edges, 'A')}');
  print('Floyd-Warshall A->C: ${floydWarshall(nodes, edges)['A']!['C']}');

  final mstKruskal = kruskalMST(nodes, List.of(edges));
  print(
    'Kruskal MST edges: ${mstKruskal.map((e) => '(${e.source}-${e.target}:${e.weight})').toList()}',
  );
  print(
    'Prim MST weight: ${primMST(weighted).fold<num>(0, (s, e) => s + e.weight)}',
  );

  final sccs = kosarajuSCC(<int, List<int>>{
    1: [2],
    2: [3],
    3: [1, 4],
    4: [5],
    5: [6],
    6: [4],
  });
  print('Kosaraju SCC count: ${sccs.length}');
  print(
    'Articulation Points: ${articulationPoints(<int, List<int>>{
          1: [2],
          2: [1, 3, 4],
          3: [2],
          4: [2],
        })}',
  );
  // Johnson's Algorithm
  final johnsonGraph = {
    'A': {'B': 2, 'C': 4},
    'B': {'C': 1, 'D': 7},
    'C': {'D': 3},
    'D': {'A': 5},
  };
  final johnsonResult = johnsonsAlgorithm(johnsonGraph);
  print(
    'Johnson\'s Algorithm: Shortest path from A to D: ${johnsonResult['A']!['D']}',
  );

  // Edmonds-Karp
  final Map<String, Map<String, num>> ekGraph = {
    'S': {'A': 10, 'C': 10},
    'A': {'B': 4, 'C': 2, 'D': 8},
    'B': {'D': 10},
    'C': {'D': 9},
    'D': {},
  };
  final maxFlow = edmondsKarp(ekGraph, 'S', 'D');
  print('Edmonds-Karp: Max flow from S to D: $maxFlow');

  // Dinic's Algorithm
  final dinicFlow = dinicsAlgorithm(ekGraph, 'S', 'D');
  print('Dinic\'s Algorithm: Max flow from S to D: $dinicFlow');

  // Eulerian Path
  final eulerianGraph = {
    0: [1, 2],
    1: [2],
    2: [0, 1],
  };
  final eulerianPath = findEulerianPath(eulerianGraph);
  print('Eulerian Path: $eulerianPath');

  // Hamiltonian Path
  final hamiltonianGraph = {
    0: [1, 3],
    1: [0, 2, 3],
    2: [1, 3],
    3: [0, 1, 2],
  };
  final hamiltonianPath = findHamiltonianPath(hamiltonianGraph, cycle: true);
  print('Hamiltonian Path: $hamiltonianPath');

  // Chinese Postman
  final cppGraph = {
    0: {1: 1, 2: 1},
    1: {0: 1, 2: 1},
    2: {0: 1, 1: 1},
  };
  final cppCost = chinesePostman(cppGraph);
  print('Chinese Postman Problem: Min cost: $cppCost');

  // Stoer-Wagner Min Cut
  final swGraph = {
    0: {1: 3, 2: 1},
    1: {0: 3, 2: 3},
    2: {0: 1, 1: 3},
  };
  final minCut = stoerWagnerMinCut(swGraph);
  print('Stoer-Wagner Min Cut: $minCut');

  // Transitive Closure
  final tcGraph = {
    0: [1],
    1: [2],
    2: [0, 3],
    3: [],
  };
  final closure = transitiveClosure(tcGraph);
  print('Transitive Closure: 0->3 reachable? ${closure[0]![3]}');

  // Graph Coloring
  final coloringGraph = {
    0: [1, 2],
    1: [0, 2],
    2: [0, 1],
  };
  final coloring = graphColoring(coloringGraph, 3);
  print('Graph Coloring: $coloring');

  // SPFA
  final spfaGraph = {
    0: {1: 2, 2: 4},
    1: {2: 1, 3: 7},
    2: {3: 3},
    3: {0: 5},
  };
  final spfaDist = spfa(spfaGraph, 0);
  print('SPFA: Shortest path from 0 to 3: ${spfaDist[3]}');

  // Tarjan's SCC
  final sccGraph = {
    0: [1],
    1: [2],
    2: [0, 3],
    3: [],
  };
  tarjansSCC(sccGraph);
  print('Tarjan\'s SCCs: $sccs');

  // Bridge Finding
  final bridgeGraph = {
    0: [1, 2],
    1: [0, 2],
    2: [0, 1, 3],
    3: [2],
  };
  final bridges = findBridges(bridgeGraph);
  print('Bridges: $bridges');

  // Tree Diameter
  final tree = {
    0: [1, 2],
    1: [0, 3, 4],
    2: [0],
    3: [1],
    4: [1],
  };
  final diameter = treeDiameter(tree);
  print(
    'Tree Diameter: length=${diameter['length']}, path=${diameter['path']}',
  );

  // Hierholzer's Algorithm
  final hierholzerGraph = {
    0: [1, 2],
    1: [2],
    2: [0, 1],
  };
  final trail = hierholzer(hierholzerGraph);
  print('Hierholzer\'s Algorithm: $trail');

  // Yen's Algorithm
  final Map<int, Map<int, num>> yenGraph = {
    0: {1: 1, 2: 5},
    1: {2: 1, 3: 2},
    2: {3: 1},
    3: {},
  };
  final kPaths = yensAlgorithm(yenGraph, 0, 3, 3);
  print('Yen\'s Algorithm: Top-3 shortest paths from 0 to 3: $kPaths');
}
