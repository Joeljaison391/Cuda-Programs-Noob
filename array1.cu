#include <stdio.h>

__global__ void add(int *a, int *b, int *c) {
    int index = threadIdx.x;
    c[index] = a[index] + b[index];
}

int main() {
    const int ARRAY_SIZE = 5;
    const int ARRAY_BYTES = ARRAY_SIZE * sizeof(int);

    int h_a[ARRAY_SIZE] = {1, 2, 3, 4, 5};
    int h_b[ARRAY_SIZE] = {10, 20, 30, 40, 50};
    int h_c[ARRAY_SIZE];

    int *d_a, *d_b, *d_c;

    cudaMalloc((void**)&d_a, ARRAY_BYTES);
    cudaMalloc((void**)&d_b, ARRAY_BYTES);
    cudaMalloc((void**)&d_c, ARRAY_BYTES);

    cudaMemcpy(d_a, h_a, ARRAY_BYTES, cudaMemcpyHostToDevice);
    cudaMemcpy(d_b, h_b, ARRAY_BYTES, cudaMemcpyHostToDevice);

    add<<<1, ARRAY_SIZE>>>(d_a, d_b, d_c);

    cudaMemcpy(h_c, d_c, ARRAY_BYTES, cudaMemcpyDeviceToHost);

    for (int i = 0; i < ARRAY_SIZE; i++) {
        printf("%d + %d = %d\n", h_a[i], h_b[i], h_c[i]);
    }

    cudaFree(d_a);
    cudaFree(d_b);
    cudaFree(d_c);

    return 0;
}
