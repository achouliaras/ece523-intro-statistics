filename cdc url 
         'http://www.openintro.org/stat/data/cdc.csv';

proc import datafile=cdc
            out=work.cdc
            dbms=csv
            replace; 
            getnames=yes;
run;

proc contents data=work.cdc short;
run;

proc print data=work.cdc (obs=10);
run;

proc univariate data=work.cdc;
    var Weight;
run;

ods graphics;
proc univariate data=work.cdc plots;
    var Weight;
run;

proc freq data=work.cdc;
    tables Smoke100;
run;

proc freq data=work.cdc;
    tables Smoke100 / plots=freqplot(scale=percent);
run;

proc freq data=work.cdc;
    tables Gender*Smoke100;
run;

proc freq data=work.cdc;
    tables Gender*Smoke100 / plots=mosaicplot;
run;

data work.newcdc;
    set work.cdc;
    wtkilos=weight*0.453592;
    wtdiff=sum(weight,-wtdesire);
    genhlth=propcase(genhlth);
    now=today();
run;

proc print data=work.newcdc (obs=10);
run; 

data work.newcdc;
    set work.cdc;
    if gender="m" and age>30;
run;

proc print data=work.newcdc (obs=10);
run;

ods graphics;
proc univariate data=work.cdc plots;
    var Weight;
run;

ods graphics;
proc univariate data=work.cdc plots;
    class gender;
    var Weight;
run;

proc sort data=work.cdc;
    by gender;
run;

ods graphics;
proc univariate data=work.cdc plots;
    by gender;
    var Weight;
run;

data work.cdcbmi;
    set work.cdc;
    bmi = (weight / height**2) * 703;
run;

proc sgplot data=work.cdcbmi;
    vbox bmi / group=genhlth;
run;

ods graphics;
proc univariate data=work.cdcbmi;
    var bmi;
    histogram bmi;
run;

ods graphics;
proc univariate data=work.cdcbmi;
    var bmi;
    histogram bmi / nmidpoints=50;
    inset mean std median / position=NE;
run;

