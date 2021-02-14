proc import datafile="C:\Users\Kim Ji Won\Desktop\myfolders\gh.xlsx" dbms=xlsx 
     out=lib.survey_xlsx replace;
	 sheet="data";
run; 


proc format ;
         value aW 1='�ִ�' 2='����' ;

		 value rW 1='1' 2='2' 3='3' 4='4' 5='5';
         
         value b3W 1='�� ����' 
                          2='�� ������'
                          3='ü��' 
                          4='����' 
                          5='�԰Ÿ�' 
                          6='��Ÿ�';

        value b6W 1='�ݵ�� �湮�Ѵ�' 
                         2='�����ϸ� �湮�Ѵ�'
                         3='���� �׷���' 
                         4='���� �湮�ϰ� ���� �ʴ�' 
                         5='���� �湮���� �ʴ´�';

         value b10W 1='Ż �۷��̵� �濬��ȸ' 
                            2='���� '
                            3='ü�� ' 
                            4='����' 
                            5='��� ���' 
                            6='�԰Ÿ�'
                            7='��Ÿ�';
   
		 value r2W 1='���� �ƴϴ�' 
                         2='���� �ƴϴ�'
                         3='�����̴�' 
                         4='���� �׷���' 
                         5='�ſ� �׷���';			

         value b17W 1='�����ֹ��� ���� ������ȸ�� Ȯ���Ѵ�' 
                            2='�����Ⱓ���� �湮�� ��� ������ �����Ѵ�' 
                            3='���� ü�����α׷��� Ȯ���Ѵ� '
                            4='����-����-���� ���� ���� ������ǰ�� �����Ѵ�' 
                             5='�� ��ü�������� ���� ������ Ȯ���Ѵ�' 6='��Ÿ';

          value c1W 1='����' 2='����';
         value c2W 1='��15-19��' 
                          2='20��'
                          3='30��' 
                          4='40��' 
                          5='50��' 
                          6='60��';
         value c3W 1='����1��' 
                          2='����2��'  
                          3='���1��' 
                          4='���2��' 
                          5='���3,4��' 
                          6='���5��'
                          7='���6,7��' 
                          8='���8��' 
                          9='���9��' 
                          10='���10��' 
                          11='����1��'
                           12='����2��'
                           13='����3��' 
                           14='�߰躻��' 
                           15='�߰�1��' 
                           16='�߰�2,3��'
                           17='�߰�4��'
                           18='�ϰ�1��'
                           19='�ϰ�2��';

	
 
        run;

DATA lib.sur ;
SET LIB.survey_xlsx;
FORMAT
r1-r4 aW.
r5 aW.
r6-r10 rW.
r11-r12 b3W.
r20 b6w.
r22 aw.
r23-r27 rw.
r28-r29 b10w.

r37 b6w.
r39-r43 r2w.
r44-r48 r2w.
r49 b17w.
r51 c1w.
r52 c2w.
r53 c3w.;

LABEL
r51="����"
r52="����"
r53="������"
;
RUN;

data lib.nodistriatt lib.nodistriunatt;
set lib.sur;
if r2=1 then output lib.nodistriatt;
else  output lib.nodistriunatt;
run;

proc freq data=lib.nodistriatt;

run;
proc means data=lib.nodistriatt;
var r6-r10 r13-r19 r23-r27 r30-r36;
run;

proc freq data=lib.nodistriunatt;

run;
proc means data=lib.nodistriunatt;
var r6-r10 r13-r19 r23-r27 r30-r36;
run;

*--------------------��������------------------;
data lib.attention;
set lib.sur;
if r2=1 then output;
run;

data lib.unattention;
set lib.sur;
if r2=2 then output;
run;

*-----------------���� ����---------------;
data lib.gong lib.sang lib.wel lib.jung lib.ha;
set lib.attention;
if r53=1 or r53=2 then output lib.gong;
else if  r53=3 or r53=4 or r53=5 or r53=6 or r53=7 
             or r53=8 or r53=9 or 53=10 then output lib.sang;
else if  r53=11 or r53=12 or r53=13  then output lib.wel;
else if  r53=14 or r53=15 or r53=16 or r53=17  then output lib.jung;
else if  r53=18 or r53=19 then output lib.ha;
run;

*-----------������ ����-------------;
data lib.ungong lib.unsang lib.unwel lib.unjung lib.unha;
set lib.unattention;
if r53=1 or r53=2 then output lib.ungong;
else if  r53=3 or r53=4 or r53=5 or r53=6 or r53=7 
             or r53=8 or r53=9 or 53=10 then output lib.unsang;
else if  r53=11 or r53=12 or r53=13  then output lib.unwel;
else if  r53=14 or r53=15 or r53=16 or r53=17  then output lib.unjung;
else if  r53=18 or r53=19 then output lib.unha;
run;

*-----------------------���� ����--------------------------;
data lib.attgong1 lib.attgong2 lib.attsang1 lib.attsang2 lib.attsang3 lib.attsang5 
            lib.attsang6 lib.attsang8 lib.attsang9 lib.attsang10 
              lib.attwel1 lib.attwel2 lib.attwel3
			    lib.attjung lib.attjung1 lib.attjung2 lib.attjung4
				 lib.attha1 lib.attha2;
set lib.attention;
if r53=1 then output lib.attgong1;
else if r53=2 then output lib.attgong2;
else if r53=3 then output lib.attsang1;
else if r53=4 then output lib.attsang2;
else if r53=5 then output lib.attsang3;
else if r53=6 then output lib.attsang5;
else if r53=7 then output lib.attsang6;
else if r53=8 then output lib.attsang8;
else if r53=9 then output lib.attsang9;
else if r53=10 then output lib.attsang10;
else if r53=11 then output lib.attwel1;
else if r53=12 then output lib.attwel2;
else if r53=13 then output lib.attwel3;
else if r53=14 then output lib.attjung;
else if r53=15 then output lib.attjung1;
else if r53=16 then output lib.attjung2;
else if r53=17 then output lib.attjung4;
else if r53=18 then output lib.attha1;
else if r53=19 then output lib.attha2;
run;


data lib.unattgong1 lib.unattgong2 lib.unattsang1 lib.unattsang2 lib.unattsang3 lib.unattsang5 
            lib.unattsang6 lib.unattsang8 lib.unattsang9 lib.unattsang10 
              lib.unattwel1 lib.unattwel2 lib.unattwel3
			    lib.unattjung lib.unattjung1 lib.unattjung2 lib.unattjung4
				 lib.unattha1 lib.unattha2;
set lib.unattention;
if r53=1 then output lib.unattgong1;
else if r53=2 then output lib.unattgong2;
else if r53=3 then output lib.unattsang1;
else if r53=4 then output lib.unattsang2;
else if r53=5 then output lib.unattsang3;
else if r53=6 then output lib.unattsang5;
else if r53=7 then output lib.unattsang6;
else if r53=8 then output lib.unattsang8;
else if r53=9 then output lib.unattsang9;
else if r53=10 then output lib.unattsang10;
else if r53=11 then output lib.unattwel1;
else if r53=12 then output lib.unattwel2;
else if r53=13 then output lib.unattwel3;
else if r53=14 then output lib.unattjung;
else if r53=15 then output lib.unattjung1;
else if r53=16 then output lib.unattjung2;
else if r53=17 then output lib.unattjung4;
else if r53=18 then output lib.unattha1;
else if r53=19 then output lib.unattha2;
run;

*----------------����----------------;
%macro attention(lib,name);
proc freq data=&lib..att&name;
run;

proc means data=&lib..att&name;
var r6-r10 r13-r19 r23-r27 r30-r36;
run;

proc means data=&lib..att&name;
var r13;
where r13>0;
run;

proc means data=&lib..att&name;
var r14;
where r14>0;
run;

proc means data=&lib..att&name;
var r15;
where r15>0;
run;

proc means data=&lib..att&name;
var r16;
where r16>0;
run;

proc means data=&lib..att&name;
var r17;
where r17>0;
run;

proc means data=&lib..att&name;
var r18;
where r18>0;
run;

proc means data=&lib..att&name;
var r19;
where r19>0;
run;

proc means data=&lib..att&name;
var r30;
where r30>0;
run;

proc means data=&lib..att&name;
var r31;
where r31>0;
run;

proc means data=&lib..att&name;
var r32;
where r32>0;
run;

proc means data=&lib..att&name;
var r33;
where r33>0;
run;

proc means data=&lib..att&name;
var r34;
where r34>0;
run;

proc means data=&lib..att&name;
var r35;
where r35>0;
run;

proc means data=&lib..att&name;
var r36;
where r36>0;
run;

DATA &lib..att1&name;
set &lib..att&name ;
    ARRAY q{2} r11-r12 ;
    DO n=1 TO 2 ;
      IF q{n} <7;
      IF q{n} ^= . THEN DO;
         b=q{n} ;   
         wgt =1;    OUTPUT ;
       END;
   END ;
   DROP n r11-r12 ;
    RUN; 
proc tabulate ;
      CLASS r53  b;
      VAR wgt ;
      TABLES b=' ' ,
               (r53=' ' ALL='��ü' )*wgt=' '*SUM=' '*F=7.0
               / BOX='�� ���� �����';
     RUN;

DATA &lib..att1&name;
set &lib..att&name ;
    ARRAY q{2} r28-r29 ;
    DO n=1 TO 2 ;
      IF q{n} <8;
      IF q{n} ^= . THEN DO;
         b=q{n} ;   
         wgt =1;    OUTPUT ;
       END;
   END ;
   DROP n r28-r29 ;
    RUN;
proc tabulate ;
      CLASS r53  b;
      VAR wgt ;
      TABLES b=' ' ,
               (r53=' ' ALL='��ü' )*wgt=' '*SUM=' '*F=7.0
               / BOX='Ż ���� �����';
     RUN;

%mend attention;
%attention(lib, gong1)
%attention(lib,gong2)
%attention(lib,sang1)
%attention(lib,sang2 )
%attention(lib,sang3 )
%attention(lib,sang5)
%attention(lib,sang6)
%attention(lib,sang8)
%attention(lib,sang9 )
%attention(lib,sang10 )
%attention(lib,wel1)
%attention(lib,wel2 )
%attention(lib,wel3)
%attention(lib,jung)
%attention(lib,jung1)
%attention(lib,jung2 )
%attention(lib,jung4 )
%attention(lib,ha1)
%attention(lib,ha2)

*----------------����---------------;
%macro unattention(lib,name);
proc freq data=&lib..unatt&name;
run;

proc means data=&lib..unatt&name;
var r6-r10 r13-r19 r23-r27 r30-r36;
run;

proc means data=&lib..unatt&name;
var r13;
where r13>0;
run;

proc means data=&lib..unatt&name;
var r14;
where r14>0;
run;

proc means data=&lib..unatt&name;
var r15;
where r15>0;
run;

proc means data=&lib..unatt&name;
var r16;
where r16>0;
run;

proc means data=&lib..unatt&name;
var r17;
where r17>0;
run;

proc means data=&lib..unatt&name;
var r18;
where r18>0;
run;

proc means data=&lib..unatt&name;
var r19;
where r19>0;
run;

proc means data=&lib..unatt&name;
var r30;
where r30>0;
run;

proc means data=&lib..unatt&name;
var r31;
where r31>0;
run;

proc means data=&lib..unatt&name;
var r32;
where r32>0;
run;

proc means data=&lib..unatt&name;
var r33;
where r33>0;
run;

proc means data=&lib..unatt&name;
var r34;
where r34>0;
run;

proc means data=&lib..unatt&name;
var r35;
where r35>0;
run;

proc means data=&lib..unatt&name;
var r36;
where r36>0;
run;

DATA &lib..unatt1&name;
set &lib..unatt&name ;
    ARRAY q{2} r11-r12 ;
    DO n=1 TO 2 ;
      IF q{n} <7;
      IF q{n} ^= . THEN DO;
         b=q{n} ;   
         wgt =1;    OUTPUT ;
       END;
   END ;
   DROP n r11-r12 ;
    RUN; 
proc tabulate ;
      CLASS r53  b;
      VAR wgt ;
      TABLES b=' ' ,
               (r53=' ' ALL='��ü' )*wgt=' '*SUM=' '*F=7.0
               / BOX='�� ���� �����';
     RUN;

DATA &lib..unatt1&name;
set &lib..unatt&name ;
    ARRAY q{2} r28-r29 ;
    DO n=1 TO 2 ;
      IF q{n} <8;
      IF q{n} ^= . THEN DO;
         b=q{n} ;   
         wgt =1;    OUTPUT ;
       END;
   END ;
   DROP n r28-r29 ;
    RUN;
proc tabulate ;
      CLASS r53  b;
      VAR wgt ;
      TABLES b=' ' ,
               (r53=' ' ALL='��ü' )*wgt=' '*SUM=' '*F=7.0
               / BOX='Ż ���� �����';
     RUN;

%mend unattention;
*%unattention(lib, gong1 )
%unattention(lib,gong2)
%unattention(lib,sang1)
%unattention(lib,sang2 )
%unattention(lib,sang3 )
%unattention(lib,sang5) 
%unattention(lib,sang6)
%unattention(lib,sang8)
*%unattention(lib,sang9 )
%unattention(lib,sang10 )
%unattention(lib,wel1)
%unattention(lib,wel2 );
%unattention(lib,wel3)
%unattention(lib,jung)
%unattention(lib,jung1)
%unattention(lib,jung2 )
%unattention(lib,jung4 )
*%unattention(lib,ha1)
%unattention(lib,ha2);


