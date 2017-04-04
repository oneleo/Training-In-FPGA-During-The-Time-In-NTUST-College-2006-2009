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
void T0_int(void)interrupt 1  /*���_�{�ǡA�Ҧ���1*/
{
  TH0=(65536-50000)/256;      /*�]�w�U�����_����ɶ��A�ɶ��@��A�A�׶i�J�����_�{��*/
  TL0=(65536-50000)%256;      /*�p���~�i���_���C�q��ܭp�ưʧ@�C*/
  de++;
  while(de==5)
  {
    de=0;
    switch(P1)
	{
      case 0x10:             /*�T�w�ƭ�5000*/ 
      {
        num_0to9999=5000;
        break;
      }
      case 0x20:             /*�T�w�ƭ�9999*/
      {
        num_0to9999=9999;
        break;
      }
      case 0x05:             /*���Ʃ��W�p��*/
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
      case 0x06	:           /*���Ʃ��U�p��*/
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
      case 0x09	:            /*�_�Ʃ��W�p��*/
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
      case 0x0a:            /*�_�Ʃ��U�p��*/
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
      case 0x01:             /*���W�p��*/
      {
        num_0to9999++;
        if(num_0to9999>9999)
        {
          num_0to9999=0;
        }
        break;
      }
      case 0x02:            /*���U�p��*/
      {
        if(num_0to9999<=0)
        {
          num_0to9999=10000;
        }
        num_0to9999--;
        break;
      }
      default:             /*�_�h�����{��*/
      {
        num_0to9999=num_0to9999; 
      }
    }
  }
}
int main(void)
{
  IE=0x82;                /*�]�w�p�ɤ��_*/
  TMOD=0x01;              /*�]�w���_�Ҧ�*/
  TH0=(65536-50000)/256;  /*�]�w���_����ɶ��A�]�w������A�Y�q���ɲִ�A���0�ɶi�J���_�{��*/
  TL0=(65536-50000)%256;  /*�]�w���_����ɶ��A�����G�]65536��x�^�At��x(us)*/
  TR0=1;                  /*�Ұʭp�ɾ��A��AT89S51�p�ɾ��Ұ�*/
  while(1)                /*�i�J���y�{��*/
  {
    delay(64);  	      /*���y����A�Y���y�L�֡A�|�ݤ�����ܵ��G�C*/
    P0=scan;              /*P0^4~P0^0���_��X00~11�����y�T���C*/
    P2=num_0to9999;       /*P2��X�p�ƧC�K�줸���ƭȡC*/
    x=num_0to9999;
    P3=x>>8;              /*P3��X�p�ư��K�줸���ƭȡC*/
	scan++;
	if(scan>3)
	{
	  scan=0;
    }
  }
}
