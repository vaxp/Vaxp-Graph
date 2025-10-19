import 'dart:math';
import 'package:vaxp_graph/vaxp_graph.dart';
import 'dart:core';

// ===================================================================
// 1. الكلاس المساعد لإنشاء الرسوم البيانية (نسخة موسعة)
// ===================================================================
class GraphGenerator {
  // يولد رسوم بيانية عامة (موجهة أو غير موجهة)
  static Map<int, List<int>> generateUnweighted({
    required int numVertices,
    required int numEdges,
    bool isDirected = false,
    bool isConnected = true,
  }) {
    final random = Random();
    final graph = <int, List<int>>{for (var i = 0; i < numVertices; i++) i: []};
    int edgesCount = 0;

    if (isConnected && numVertices > 1) {
      final vertices = List.generate(numVertices, (i) => i)..shuffle(random);
      for (int i = 0; i < numVertices - 1; i++) {
        final u = vertices[i];
        final v = vertices[i + 1];
        if (!graph[u]!.contains(v)) {
          graph[u]!.add(v);
          if (!isDirected) graph[v]!.add(u);
          edgesCount++;
        }
      }
    }

    while (edgesCount < numEdges) {
      int u = random.nextInt(numVertices);
      int v = random.nextInt(numVertices);
      if (u != v && !graph[u]!.contains(v)) {
        graph[u]!.add(v);
        if (!isDirected) graph[v]!.add(u);
        edgesCount++;
      }
    }
    return graph;
  }
  
  // يولد رسمًا بيانيًا موجّهًا بلا حلقات (DAG)
  static Map<int, List<int>> generateDAG(int numVertices, int numEdges) {
      final graph = <int, List<int>>{for (var i = 0; i < numVertices; i++) i: []};
      final random = Random();
      int edgesCount = 0;
      while (edgesCount < numEdges) {
          int u = random.nextInt(numVertices);
          int v = random.nextInt(numVertices);
          // ضمان عدم وجود حلقات عن طريق جعل الحافة تتجه من الأصغر للأكبر
          if (u < v && !graph[u]!.contains(v)) {
              graph[u]!.add(v);
              edgesCount++;
          }
      }
      return graph;
  }

  // يولد شجرة (رسم بياني متصل بـ V-1 حافة)
  static Map<int, List<int>> generateTree(int numVertices) {
    return generateUnweighted(
      numVertices: numVertices,
      numEdges: numVertices - 1,
      isConnected: true,
      isDirected: false
    );
  }

  // يولد بيانات موزونة من بيانات غير موزونة
  static Map<int, Map<int, num>> generateWeightedFrom(Map<int, List<int>> unweighted) {
    final random = Random();
    final weighted = <int, Map<int, num>>{};
    unweighted.forEach((u, neighbors) {
      weighted[u] = { for (var v in neighbors) v: random.nextInt(100) + 1 };
    });
    return weighted;
  }
}

// ===================================================================
// 2. دالة البنشمارك المحسّنة (لا تغيير هنا)
// ===================================================================
void benchmark(String name, Function computation, {int warmup = 5, int runs = 10}) {
  for (int i = 0; i < warmup; i++) computation();
  final timings = <int>[];
  final stopwatch = Stopwatch();
  for (int i = 0; i < runs; i++) {
    stopwatch.start();
    computation();
    stopwatch.stop();
    timings.add(stopwatch.elapsedMicroseconds);
    stopwatch.reset();
  }
  final average = timings.reduce((a, b) => a + b) / runs;
  print('${name.padRight(28)}: ${average.toStringAsFixed(2).padLeft(10)} microseconds (avg of $runs runs)');
}

// ===================================================================
// 3. سيناريوهات الاختبار
// ===================================================================

/// السيناريو الأول: خوارزميات عامة على رسم بياني متوسط الحجم
void runGeneralBenchmarks() {
  print('--- SCENARIO 1: General Algorithms (150 Vertices, 400 Edges) ---');
  final unweighted = GraphGenerator.generateUnweighted(numVertices: 150, numEdges: 400);
  final weightedMap = GraphGenerator.generateWeightedFrom(unweighted);
  final weightedAdjList = <int, List<WeightedEdge<int>>>{};
  weightedMap.forEach((u, neighbors) {
    weightedAdjList[u] = neighbors.entries.map((e) => WeightedEdge(u, e.key, e.value)).toList();
  });
  final nodes = unweighted.keys.toSet();
  final edges = weightedAdjList.values.expand((e) => e).toList();
  
  benchmark('BFS', () => bfs(unweighted, 0));
  benchmark('DFS', () => dfs(unweighted, 0));
  benchmark('Connected Components', () => connectedComponents(unweighted));
  benchmark('Is Bipartite', () => isBipartite(unweighted));
  benchmark('Dijkstra', () => dijkstra(weightedAdjList, 0));
  benchmark('Prim MST', () => primMST(weightedAdjList));
  benchmark('Kruskal MST', () => kruskalMST(nodes, edges));
  benchmark('Bellman-Ford', () => bellmanFord(nodes, edges, 0));
  benchmark('SPFA', () => spfa(weightedMap, 0));
  benchmark('Bridge Finding', () => findBridges(unweighted));
  benchmark('Articulation Points', () => articulationPoints(unweighted));
  benchmark('Stoer-Wagner Min Cut', () => stoerWagnerMinCut(weightedMap));
}

/// السيناريو الثاني: خوارزميات تتطلب رسومًا بيانية موجهة (Directed)
void runDirectedBenchmarks() {
    print('\n--- SCENARIO 2: Directed Graph Algorithms (100 Vertices, 300 Edges) ---');
    final dag = GraphGenerator.generateDAG(100, 300);
    final weightedDag = GraphGenerator.generateWeightedFrom(dag);
    final nodes = dag.keys.toSet();
    final edges = <WeightedEdge<int>>[];
    weightedDag.forEach((u, neighbors) {
        neighbors.forEach((v, w) => edges.add(WeightedEdge(u, v, w)));
    });

    benchmark('Topological Sort', () => topologicalSort(dag));
    benchmark('Kosaraju SCC', () => kosarajuSCC(dag));
    benchmark('Tarjan\'s SCC', () => tarjansSCC(dag));
    benchmark('Transitive Closure', () => transitiveClosure(dag));
    benchmark('Floyd-Warshall', () => floydWarshall(nodes, edges));
    benchmark('Johnson\'s Algorithm', () => johnsonsAlgorithm(weightedDag));
}

/// السيناريو الثالث: خوارزميات خاصة بالأشجار (Trees)
void runTreeBenchmarks() {
    print('\n--- SCENARIO 3: Tree Algorithms (200 Vertices) ---');
    final tree = GraphGenerator.generateTree(200);
    benchmark('Tree Diameter', () => treeDiameter(tree));
}

/// السيناريو الرابع: خوارزميات التدفق (Max Flow)
void runFlowNetworkBenchmarks() {
    print('\n--- SCENARIO 4: Max Flow Algorithms (50 Vertices, 150 Edges) ---');
    // نعتبر 0 هو المصدر و 49 هو الحوض
    final flowNetwork = GraphGenerator.generateWeightedFrom(
        GraphGenerator.generateDAG(50, 150)
    );
    benchmark('Edmonds-Karp', () => edmondsKarp(flowNetwork, 0, 49));
    benchmark('Dinic\'s Algorithm', () => dinicsAlgorithm(flowNetwork, 0, 49));
}

/// السيناريو الخامس: خوارزميات NP-Complete (بيانات صغيرة جدًا)
void runNpCompleteBenchmarks() {
    print('\n--- SCENARIO 5: NP-Complete Algorithms (10 Vertices, 25 Edges) ---');
    // تحذير: هذه الخوارزميات بطيئة جدًا بطبيعتها
    final smallGraph = GraphGenerator.generateUnweighted(numVertices: 10, numEdges: 25);
    benchmark('Hamiltonian Path', () => findHamiltonianPath(smallGraph));
    benchmark('Graph Coloring', () => graphColoring(smallGraph, 4));
}


void main() {
  runGeneralBenchmarks();
  runDirectedBenchmarks();
  runTreeBenchmarks();
  runFlowNetworkBenchmarks();
  runNpCompleteBenchmarks();
}