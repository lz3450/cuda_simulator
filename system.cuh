#ifndef _SYSTEM_H_CUDA
#define _SYSTEM_H_CUDA

#include <iostream>
#include <string>
#include <assert.h>

using namespace std;


enum STATE { Created, Ready, Running, Waiting, Completed };


__device__ struct task {
	__device__ __host__ task() {}
	__device__ __host__ task(int phase, int period, int relative_deadline, int execution_time) : _phase(phase), _period(period), _relative_deadline(relative_deadline), _execution_time(execution_time) {}
	int _phase;
	int _period;
	int _relative_deadline;
	int _execution_time;
};


class Taskset {

};

class job
{
public:
	__device__ __host__ job(task* tsk)
	{
		_task = tsk; // TODO: check if copy works
		_executed_cycle = 0;
		_state = Created;
	}

	__device__ __host__ void job_release(int time);
	__device__ __host__ void activate();
	__device__ __host__ int get_deadline();
	__device__ __host__ int get_remain();
	__device__ __host__ bool completed();
	__device__ __host__ bool missed();
	__device__ __host__ void preempt();
	__device__ __host__ void terminate(int time);
	__device__ void run();
	STATE get_state();

private:
	task* _task;
	int _executed_cycle;
	int _release_time;
	int _response_time;
	STATE _state;
};

#endif // _SYSTEM_H_CUDA