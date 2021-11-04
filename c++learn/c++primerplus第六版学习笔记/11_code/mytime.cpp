#include "mytime.h"

Time::Time(){
    hours = minutes = 0;
}

Time::Time(int h,int m){
    hours = h;
    minutes = m;
}

void Time::addmin(int m){
    minutes += m;
    hours += minutes/60;
    minutes %= 60;
}

Time Time::operator+(const Time & t) const{
    Time sum;
    sum.minutes = minutes + t.minutes;
    sum.hours = hours + t.hours + sum.minutes/60;
    sum.minutes %= 60;
    return sum;
}

Time Time::operator*(double n) const{
    Time sum;
    long allminutes = (minutes + hours * 60) * n;
    sum.minutes = allminutes % 60;
    sum.hours = allminutes / 60;
    return sum;
}

std::ostream & operator<<(std::ostream & os,const Time & t) {
    os << t.hours << "hours" << t.minutes << "minutes";
    return os;
}