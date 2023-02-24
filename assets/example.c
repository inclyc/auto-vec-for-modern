
void example(int U[], int V[], int W[]) {
  for (int i = 0; i < 100; i++) {
    int k = i;
    for (int j = 0; j < 300; j += 3) {
      k += 2;
      U[j] = U[j] * W[k];
      V[j + 3] = V[j] + W[k];
    }
  }
}
