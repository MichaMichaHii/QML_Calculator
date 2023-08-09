#ifndef CALCULATING_H
#define CALCULATING_H

#include <QObject>
#include <QGuiApplication>
#include "math.h"
#include <iostream>
#include <iomanip>
#include <sstream>
#include <cmath>
class Calculating : public QObject
{
    Q_OBJECT
public:
    explicit Calculating(QObject *parent = nullptr);

signals:
    void sendResult(float result);
public slots:
    void normalCalculating(QString num1,QString num2);
    void square(QString num);
    void oneperx(QString num);
    void __sqrt(QString num);
    void percent(QString num);


};

#endif // CALCULATING_H
