#ifndef CHRONO_H
#define CHRONO_H

#include <sys/time.h>
#include <chrono>
#include <ctime>
#include <iostream>
#include <sstream>

class Chrono {
  public:
    void Reset() {
        TotalTime = 0;
        N = 0;
    }

    void Start() {
        struct timeval tod;
        gettimeofday(&tod, nullptr);
        sec1 = ((double)tod.tv_sec);
        milli1 = ((double)tod.tv_usec) / 1000;
    }

    void Stop() {
        struct timeval tod;
        gettimeofday(&tod, nullptr);
        sec2 = ((double)tod.tv_sec);
        milli2 = ((double)tod.tv_usec) / 1000;
        double duration = 1000 * (sec2 - sec1) + milli2 - milli1;

        TotalTime += duration;
    }

    int operator++() { return N++; }

    double GetTime() const { return TotalTime; }

    double GetTimePerCount() const { return TotalTime / N; }

    int GetCount() const { return N; }

  private:
    // this is in milli seconds
    double sec1;
    double sec2;
    double milli1;
    double milli2;
    double TotalTime;
    int N;
};

#endif  // CHRONO_H
