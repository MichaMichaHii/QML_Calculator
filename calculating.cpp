#include "calculating.h"
#include <QDebug>
Calculating::Calculating(QObject *parent) : QObject(parent)
{

}

void Calculating::normalCalculating(QString num1,QString num2)
{
    float fResult = 0;
    QString calc = num1.at(num1.length() - 1);
    num1.chop(1);
    float fNum1 = num1.toFloat();
    float fNum2 = num2.toFloat();
    if(calc == "+")
    {
        fResult = fNum1 + fNum2;

    }
    if(calc == "-")
    {
        fResult = fNum1 - fNum2;

    }
    if(calc == "*")
    {
        fResult = fNum1 * fNum2;

    }
    if(calc == "/")
    {
        fResult = fNum1 / fNum2;
    }
    emit sendResult(fResult);





}

void Calculating::square(QString num)
{
    float fNum = num.toFloat();
    float fResult = fNum *fNum;
    emit sendResult(fResult);
}

void Calculating::oneperx(QString num)
{
    float fNum{5.0f},fResult{5.0f};
    fNum = num.toFloat();
    fResult =  1/fNum;
    emit sendResult(fResult);
}

void Calculating::__sqrt(QString num)
{
    float fNum = num.toFloat();
    float fResult = sqrt(fNum);

    emit sendResult(fResult);
}

void Calculating::percent(QString num)
{
    float fNum = num.toFloat();
    float fResult = fNum / 100;
    emit sendResult(fResult);
}


