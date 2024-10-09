#include <stdio.h>
#include <string.h>

#define N (2048)
#define BLOCK_SIZE (32)

float sum;
float a[N][N];
float b[N][N];
float c[N][N];

void matmul()
{
	int i, j, k, ii, jj, kk;

#pragma omp parallel for private(i, j)
	for (i = 0; i < N; i++)
	{
		for (j = 0; j < N; j++)
		{
			a[i][j] = 0.0; 
		}
	}

#pragma omp parallel for private(i, j, k, ii, jj, kk) schedule(static)
    for (ii = 0; ii < N; ii += BLOCK_SIZE) {
        for (jj = 0; jj < N; jj += BLOCK_SIZE) {
            for (kk = 0; kk < N; kk += BLOCK_SIZE) {
                // Multiply the blocks
                for (i = ii; i < ii + BLOCK_SIZE && i < N; i++) {
                    for (j = jj; j < jj + BLOCK_SIZE && j < N; j++) {
                        float sum = 0.0;
                        for (k = kk; k < kk + BLOCK_SIZE && k < N; k++) {
                            sum += b[i][k] * c[k][j];
                        }
                        a[i][j] += sum;
                    }
                }
            }
        }
    }
}

void init()
{
	int i, j;

	for (i = 0; i < N; i += 1)
	{
		for (j = 0; j < N; j += 1)
		{
			b[i][j] = 12 + i * j * 13;
			c[i][j] = -13 + i + j * 21;
		}
	}
}

void check()
{
	int i, j;

	for (i = 0; i < N; i += 1)
		for (j = 0; j < N; j += 1)
			sum += a[i][j];
	printf("sum = %lf\n", sum);
}

int main()
{
	init();
	matmul();
	check();

	return 0;
}
