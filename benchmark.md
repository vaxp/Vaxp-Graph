# benchmark

# VAXP Graph Algorithms Benchmark 🚀

This document provides performance benchmarks for the algorithms included in the **vaxp_graph** library. The goal is to offer clear, transparent data on how each algorithm performs on various data sizes.

---

## How to Run the Benchmark 🧑‍💻

Any developer can replicate these results on their own machine to verify performance.


1. **Clone the Repository**

    ```bash
    git clone https://github.com/VAXP/vaxp_graph.git
    ```

2. **Navigate to the Project Directory**

    ```bash
    cd vaxp_graph
    ```

3. **Run the Benchmark Script**
    The project includes a dedicated script to test all algorithms. Run the following command from the project's root directory:

    ```bash
    dart run .benchmark/benchmark.dart
    ```
    

The script will run tests on graphs of 1,000, 10,000, and 100,000 elements (vertices/edges) and print the results to the console.

---

## Benchmark Results 📊

*Results below were generated on a standard development machine and are intended as a reference. Your exact results may vary depending on your hardware.*


### **Graph Size: 1,000 Elements**


--- SCENARIO 1: General Algorithms (150 Vertices, 400 Edges) ---
- **BFS**: 314.60 microseconds (avg of 10 runs)
- **DFS**: 81.70 microseconds (avg of 10 runs)
- **Connected Components**: 256.90 microseconds (avg of 10 runs)
- **Is Bipartite**: 89.00 microseconds (avg of 10 runs)
- **Dijkstra**: 825.80 microseconds (avg of 10 runs)
- **Prim MST**: 296.00 microseconds (avg of 10 runs)
- **Kruskal MST**: 671.10 microseconds (avg of 10 runs)
- **Bellman-Ford**: 599.20 microseconds (avg of 10 runs)
- **SPFA**: 319.00 microseconds (avg of 10 runs)
- **Bridge Finding**: 103.40 microseconds (avg of 10 runs)
- **Articulation Points**: 190.60 microseconds (avg of 10 runs)
- **Stoer-Wagner Min Cut**: 112557.80 microseconds (avg of 10 runs)


--- SCENARIO 2: Directed Graph Algorithms (100 Vertices, 300 Edges) ---
- **Topological Sort**: 62.10 microseconds (avg of 10 runs)
- **Kosaraju SCC**: 191.00 microseconds (avg of 10 runs)
- **Tarjan's SCC**: 56.10 microseconds (avg of 10 runs)
- **Transitive Closure**: 20847.90 microseconds (avg of 10 runs)
- **Floyd-Warshall**: 63904.30 microseconds (avg of 10 runs)
- **Johnson's Algorithm**: 8509.20 microseconds (avg of 10 runs)


--- SCENARIO 3: Tree Algorithms (200 Vertices) ---
- **Tree Diameter**: 76.60 microseconds (avg of 10 runs)


--- SCENARIO 4: Max Flow Algorithms (50 Vertices, 150 Edges) ---
- **Edmonds-Karp**: 827.80 microseconds (avg of 10 runs)
- **Dinic's Algorithm**: 777.20 microseconds (avg of 10 runs)


--- SCENARIO 5: NP-Complete Algorithms (10 Vertices, 25 Edges) ---
- **Hamiltonian Path**: 1.10 microseconds (avg of 10 runs)
- **Graph Coloring**: 7.50 microseconds (avg of 10 runs)
---

### **Analysis of Results**

The results clearly demonstrate the practical impact of algorithmic complexity (Big O notation) for graph algorithms.

- **O(V²)** or **O(VE)** algorithms (where V = vertices, E = edges) show a dramatic decrease in performance as the graph size grows by a factor of 10.
- **O(V log V)** or **O(E log V)** algorithms maintain excellent performance, showcasing their suitability for larger graphs.
- **O(V + E)** algorithms remain extremely fast across the board.