proc import datafile="C:\Users\Kim Ji Won\Desktop\myfolders\gh.xlsx" dbms=xlsx 
     out=lib.survey_xlsx replace;
	 sheet="data";
run; 


proc format ;
         value aW 1='있다' 2='없다' ;

		 value rW 1='1' 2='2' 3='3' 4='4' 5='5';
         
         value b3W 1='등 전시' 
                          2='빛 포토존'
                          3='체험' 
                          4='공연' 
                          5='먹거리' 
                          6='살거리';

        value b6W 1='반드시 방문한다' 
                         2='가능하면 방문한다'
                         3='그저 그렇다' 
                         4='별로 방문하고 싶지 않다' 
                         5='절대 방문하지 않는다';

         value b10W 1='탈 퍼레이드 경연대회' 
                            2='공연 '
                            3='체험 ' 
                            4='전시' 
                            5='어린이 대상' 
                            6='먹거리'
                            7='살거리';
   
		 value r2W 1='전혀 아니다' 
                         2='조금 아니다'
                         3='보통이다' 
                         4='조금 그렇다' 
                         5='매우 그렇다';			

         value b17W 1='지역주민의 축제 참여기회를 확대한다' 
                            2='축제기간동안 방문객 대상 할인을 진행한다' 
                            3='축제 체험프로그램을 확충한다 '
                            4='숙박-음식-축제 등을 엮은 관광상품을 개발한다' 
                             5='구 전체지역으로 축제 공간을 확대한다' 6='기타';

          value c1W 1='남성' 2='여성';
         value c2W 1='만15-19세' 
                          2='20대'
                          3='30대' 
                          4='40대' 
                          5='50대' 
                          6='60대';
         value c3W 1='공릉1동' 
                          2='공릉2동'  
                          3='상계1동' 
                          4='상계2동' 
                          5='상계3,4동' 
                          6='상계5동'
                          7='상계6,7동' 
                          8='상계8동' 
                          9='상계9동' 
                          10='상계10동' 
                          11='월계1동'
                           12='월계2동'
                           13='월계3동' 
                           14='중계본동' 
                           15='중계1동' 
                           16='중계2,3동'
                           17='중계4동'
                           18='하계1동'
                           19='하계2동';

	
 
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
r51="성별"
r52="연령"
r53="거주지"
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

*--------------------참석여부------------------;
data lib.attention;
set lib.sur;
if r2=1 then output;
run;

data lib.unattention;
set lib.sur;
if r2=2 then output;
run;

*-----------------참석 동별---------------;
data lib.gong lib.sang lib.wel lib.jung lib.ha;
set lib.attention;
if r53=1 or r53=2 then output lib.gong;
else if  r53=3 or r53=4 or r53=5 or r53=6 or r53=7 
             or r53=8 or r53=9 or 53=10 then output lib.sang;
else if  r53=11 or r53=12 or r53=13  then output lib.wel;
else if  r53=14 or r53=15 or r53=16 or r53=17  then output lib.jung;
else if  r53=18 or r53=19 then output lib.ha;
run;

*-----------미참석 동별-------------;
data lib.ungong lib.unsang lib.unwel lib.unjung lib.unha;
set lib.unattention;
if r53=1 or r53=2 then output lib.ungong;
else if  r53=3 or r53=4 or r53=5 or r53=6 or r53=7 
             or r53=8 or r53=9 or 53=10 then output lib.unsang;
else if  r53=11 or r53=12 or r53=13  then output lib.unwel;
else if  r53=14 or r53=15 or r53=16 or r53=17  then output lib.unjung;
else if  r53=18 or r53=19 then output lib.unha;
run;

*-----------------------개별 동별--------------------------;
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

*----------------참석----------------;
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
               (r53=' ' ALL='전체' )*wgt=' '*SUM=' '*F=7.0
               / BOX='등 축제 기대요소';
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
               (r53=' ' ALL='전체' )*wgt=' '*SUM=' '*F=7.0
               / BOX='탈 축제 기대요소';
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

*----------------미참---------------;
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
               (r53=' ' ALL='전체' )*wgt=' '*SUM=' '*F=7.0
               / BOX='등 축제 기대요소';
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
               (r53=' ' ALL='전체' )*wgt=' '*SUM=' '*F=7.0
               / BOX='탈 축제 기대요소';
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


