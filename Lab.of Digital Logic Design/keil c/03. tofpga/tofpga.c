#include "reg51.h"
unsigned short num_0to9999=0,scan=0,x,de=0;	 
void delay(int del)
{
  long d;
  for(d=0;d<del;d++)
  {
    ; 
  } 
}
void T0_int(void)interrupt 1  /*中斷程序，模式為1*/
{
  TH0=(65536-50000)/256;      /*設定下次中斷執行時間，時間一到，再度進入此中斷程序*/
  TL0=(65536-50000)%256;      /*如此才可不斷做七段顯示計數動作。*/
  de++;
  while(de==5)
  {
    de=0;
    switch(P1)
	{
      case 0x10:             /*固定數值5000*/ 
      {
        num_0to9999=5000;
        break;
      }
      case 0x20:             /*固定數值9999*/
      {
        num_0to9999=9999;
        break;
      }
      case 0x05:             /*偶數往上計數*/
      {
        if(num_0to9999%2==1)
        {
          num_0to9999=num_0to9999+1;
        }
        else if(num_0to9999%2==0)
        {
          num_0to9999=num_0to9999+2;
        }
        if(num_0to9999>9998)
        {
          num_0to9999=0;
        }
        break;
      }
      case 0x06	:           /*偶數往下計數*/
      {
        if(num_0to9999<=0)
        {
          num_0to9999=10000;
        }
        if(num_0to9999%2==1)
        {
          num_0to9999=num_0to9999-1;
        }
        else if(num_0to9999%2==0)
        {
          num_0to9999=num_0to9999-2;
        }
        break;
      }
      case 0x09	:            /*奇數往上計數*/
      {
        if(num_0to9999%2==0)
        {
          num_0to9999=num_0to9999+1;
        }
        else if(num_0to9999%2==1)
        {
          num_0to9999=num_0to9999+2;
        }
        if(num_0to9999>9999)
        {
          num_0to9999=1;
        }
        break;
      }
      case 0x0a:            /*奇數往下計數*/
      {
        if(num_0to9999<=1)
        {
          num_0to9999=10001;
        }
        if(num_0to9999%2==0)
        {
          num_0to9999=num_0to9999-1;
        }
        else if(num_0to9999%2==1)
        {
          num_0to9999=num_0to9999-2;
        }
        break;
      }
      case 0x01:             /*往上計數*/
      {
        num_0to9999++;
        if(num_0to9999>9999)
        {
          num_0to9999=0;
        }
        break;
      }
      case 0x02:            /*往下計數*/
      {
        if(num_0to9999<=0)
        {
          num_0to9999=10000;
        }
        num_0to9999--;
        break;
      }
      default:             /*否則維持現狀*/
      {
        num_0to9999=num_0to9999; 
      }
    }
  }
}
int main(void)
{
  IE=0x82;                /*設定計時中斷*/
  TMOD=0x01;              /*設定中斷模式*/
  TH0=(65536-50000)/256;  /*設定中斷執行時間，設定完成後，即從此時累減，減至0時進入中斷程序*/
  TL0=(65536-50000)%256;  /*設定中斷執行時間，公式：（65536－x），t＝x(us)*/
  TR0=1;                  /*啟動計時器，讓AT89S51計時器啟動*/
  while(1)                /*進入掃描程序*/
  {
    delay(64);  	      /*掃描延遲，若掃描過快，會看不到顯示結果。*/
    P0=scan;              /*P0^4~P0^0不斷輸出00~11的掃描訊號。*/
    P2=num_0to9999;       /*P2輸出計數低八位元的數值。*/
    x=num_0to9999;
    P3=x>>8;              /*P3輸出計數高八位元的數值。*/
	scan++;
	if(scan>3)
	{
	  scan=0;
    }
  }
}
