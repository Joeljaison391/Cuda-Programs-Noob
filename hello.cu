#include <iostream>
#include <cuda_runtime.h>

__global__ void helloWorld() {
    printf("Hello, World from the GPU!\n");
}

int main() {
    // Launch the kernel with 1 block and 1 thread
    helloWorld<<<1, 1>>>();

    // Wait for GPU to finish
    cudaDeviceSynchronize();

    std::cout << "Hello, World from the CPU!" << std::endl;

    return 0;
}
