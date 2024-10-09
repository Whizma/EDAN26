#include <stdio.h>
#include <string.h>
#include <omp.h>

#define N (2048)

float sum;
float a[N][N];
float b[N][N];
float c[N][N];

void matmul()
{
	int	i, j, k;
	#pragma omp parallel for private(i, j)
	for (int i = 0; i < N; i++)
	{
		for (int j = 0; j < N; j++)
		{
			a[i][j] = 0.0F;
		}
		
	}
	
	#pragma omp parallel for
	for (i = 0; i < N; i += 1) {
		for (k = 0; k < N; k += 1) {
			float temp = b[i][k];
			for (j = 0; j < N; j += 1) {
				a[i][j] += temp * c[k][j];
				
			}
		}
	}
}


void init()
{
	int	i, j;

	for (i = 0; i < N; i += 1) {
		for (j = 0; j < N; j += 1) {
			b[i][j] = 12 + i * j * 13;
			c[i][j] = -13 + i + j * 21;
		}
	}
}

void check()
{
	int	i, j;

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
