#ifndef _RESOURCES_H_CUDA
#define _RESOURCES_H_CUDA

#include <string>
#include "system.cuh"

class _Resource
{
public:
	__device__ __host__ _Resource(int ratio)
	{
		//_name = name;
		_ratio = ratio;
		_cycle = 0;
	}

	/*std::string get_name()
	{
		return _name;
	}*/

protected:
	//std::string _name;
	int _ratio;
	int _cycle;
};

class Processor : _Resource
{
public:
	__device__ __host__ Processor(int ratio, int overhead) : _Resource(ratio)
	{
		_usage = 0;
		_overhead_cycle = overhead;
		_overhead = 0;
	}

	__device__ __host__ bool is_idle();
	__device__ __host__ int overhead();
	__device__ __host__ void load(job *_job);
	__device__ __host__ job* preempt(job *_job);
	__device__ __host__ void unload();
	__device__ void run(int ticks);
	__device__ __host__ void stop();

private:
	int _usage;
	job *jb;
	int _overhead_cycle;
	int _overhead;


};

#endif //_RESOURCE_H_CUDA