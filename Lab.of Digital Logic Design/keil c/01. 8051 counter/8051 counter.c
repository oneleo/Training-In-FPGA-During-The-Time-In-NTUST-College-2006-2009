#include "reg51.h"
char seg4[4] = {0} ; // 儲存七段數值 
int  seg[4]  = {0x0e,0x0d,0x0b,0x07} ; // 1 ~ 4 顆 致能
char display[11] = {0xc0,0xf9,0xa4,0xb0,0x99,0x92,0x82,0xf8,0x80,0x90,0xc0}; //亮0 ~ dot
int k,a,x=1,j=0;
void delay(int);
int main(void)
{
  IE = 0x82 ;             // 設定 計時中斷
  TMOD=0x01;              // 設定 模式
  TH0=(65536-20000)/256;  // 設定時間
  TL0=(65536-20000)%256;  // 設定時間 (65536-x), t =  x us
  TR0=1;                  // 啟動計時器 讓51計時器動
  while(1)
    {
      delay(299) ;  	  // 延遲
	  
      if(seg4[1]!=0) x=2;
       if(seg4[2]!=0) x=3;
       if(seg4[3]!=0) x=4;   	
      P1=display[seg4[j]];	
      P0=seg[j];
      j++;

       if(j==x)
	     j=0;
    }
}
void T0_int(void)interrupt 1
{
  TH0=(65536-20000)/256; 
  TL0=(65536-20000)%256;
  k++;
  while(k==1)
  {
    seg4[0] ++ ;
    for(a=10;a==seg4[0];seg4[0]=0,seg4[1]++);
    for(a=10;a==seg4[1];seg4[1]=0,seg4[2]++);
    for(a=10;a==seg4[2];seg4[2]=0,seg4[3]++);
	if(seg4[3]==10) {seg4[3] =0; x=1;j=0;}

	if(k==1)	
	  k=0;	

  }								 

}
void delay(int n)
{
  int s ;
  for(s=0;s<n;s++);
}