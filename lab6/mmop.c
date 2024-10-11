#include <stdio.h>
#include <string.h>
#include <arm_neon.h>
#include <stdlib.h>
#include <pthread.h>
#include <omp.h>

#define N (2048)
#define BLOCK_SIZE (16)

float sum = 0.0;
float a[N][N] __attribute__((aligned(64))); // Ensure data is aligned for SIMD
float b[N][N] __attribute__((aligned(64)));
float c[N][N] __attribute__((aligned(64)));


void matmul()
{
omp_set_num_threads(8);
int i, j, k, ii, jj, kk;

#pragma omp parallel for private(i, j)
	for (i = 0; i < N; i++)
	{
		for (j = 0; j < N; j++)
		{
			a[i][j] = 0.0;
		}
	}

#pragma omp parallel for private(i, j, k, ii, jj, kk) schedule(guided)
	for (ii = 0; ii < N; ii += BLOCK_SIZE)
	{
		for (jj = 0; jj < N; jj += BLOCK_SIZE)
		{
			for (kk = 0; kk < N; kk += BLOCK_SIZE)
			{
				for (i = ii; i < ii + BLOCK_SIZE && i < N; ++i)
				{
					for (j = jj; j < jj + BLOCK_SIZE && j < N; ++j)
					{
						float32x4_t sum_vec = vdupq_n_f32(0.0);
						
						#pragma unroll
						for (k = kk; k < kk + BLOCK_SIZE && k < N; k += 8)
						{

							float32x4_t b_vec1 = vld1q_f32(&b[i][k]);
							float32x4_t b_vec2 = vld1q_f32(&b[i][k + 4]);
							float32x4_t c_vec1 = vld1q_f32(&c[k][j]);
							float32x4_t c_vec2 = vld1q_f32(&c[k + 4][j]);

							sum_vec = vmlaq_f32(sum_vec, b_vec1, c_vec1);
							sum_vec = vmlaq_f32(sum_vec, b_vec2, c_vec2);

						}

						// Horizontally add the elements of sum_vec and store in a[i][j]
						a[i][j] += vaddvq_f32(sum_vec); // Sum all elements of sum_vec
					}
				}
			}
		}
	}
}

void init()
{
int i, j;
#pragma omp parallel for collapse(2)
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
