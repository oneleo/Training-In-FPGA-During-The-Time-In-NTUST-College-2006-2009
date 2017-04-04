#include<reg51.h>	 
sbit led_dot=P1^7;
unsigned short act[4]={0xfe,0xfd,0xfb,0xf7};
unsigned short seg_num[16]={0xc0,0xf9,0xa4,0xb0,0x99,0x92,0x82,0xf8,0x80,0x90,0x88,0x83,0xc6,0xa1,0x86,0x8e};
unsigned short key,key15open=0,switch_sel=3,int_delay;
unsigned short seg[4]={0},scan_num=0,scan=0;/*seg�Ψ��x�s�U�ӤC�q��ܾ����ƭȡAscan�O���y���w�ΡAscan_num�O���wscan���B�ӫG�A��seg���Ʀr�~�G*/
void delay(int delay)
{
  int d;
  for(d=0;d<(delay*100);d++)
  {
    ;
  }
}
void scan_7seg(void)
{
    P0=act[scan];    /*�]�wAT89S51��P0.0�BP0.1�BP0.2�BP0.3����n�����ӤC�q��ܾ��o���A�]���|�ӤC�q��ܾ���abcdefgh���}�P���@�ݡA�ҥH�n�Υt�|������u�M�w��ӧO�C�q��ܾ����ݪ��T���L�ӮɡA�n���ӤC�q��ܾ��o���C*/
    P1=seg_num[seg[scan]];/*�]�wAT89S51��P1.0�BP1.1�BP1.2�BP1.3�BP1.4�BP1.5�BP1.6�BP1.7���O���J�C�q��ܾ���abcdefgh�A�]���|�ӤC�q��ܾ�����ƽu���ۦP�A�ҥH�ȤC���N�i�����A�A�y�ѧֳt���y�A�ײ��L�k��O�����p�U�A�F����ت��C*/
    if(scan==2)
    {
      led_dot=0;
    }
    if(seg[1]!=0)         /*�Ǫ��n�D�Y����ƭȬ�0���ܡA�h������C�q��ܾ���ܡC*/
    { 
      scan_num=1;         /*�P�O�O�_����ơA�Y�S����ƪ��ܡA���L���y�C*/
    }
    if(seg[2]!=0)
    {
      scan_num=2;
    }
    if(seg[3]!=0)
    {
      scan_num=3;
    }
    if((seg[3]==0)&&(seg[2]!=0)&&(seg[1]==0))
    {
      scan_num=2;
      scan++;
    }
    scan++;
    if(scan>scan_num)
    { 
      scan=0;
    } 
}
void T0_int(void)interrupt 1  /*���_�{�ǡA�Ҧ���1*/
{
  TH0=(65536-2000)/256;      /*�]�w�U�����_����ɶ��A�ɶ��@��A�A�׶i�J�����_�{��*/
  TL0=(65536-2000)%256;      /*�p���~�i���_���C�q�֥[�ʧ@�C*/
  scan_7seg();
  if(key15open!=1)
  {
    int_delay++;
    while(int_delay==500)
    {
      int_delay=0;
      seg[0]++;                   /*�Ӧ�Ʋ֥[1�C*/
      if(seg[0]>=10)              /*�p�G�Ӧ�Ƭ�9+1�������A���Ӧ���k0�A���Q��Ʋ֥[1�A*/
      {
        seg[0]=0;
        seg[1]++;
        if(seg[1]>=6)            /*�p�G�Q��Ƭ�9+1�������A���Q����k0�A���ʦ�Ʋ֥[1�C*/
        {
          seg[1]=0;
          seg[2]++;
          if(seg[2]>=10)          /*�p�G�ʦ�Ƭ�9+1�������A���ʦ���k0�A���d��Ʋ֥[1�C*/
          {
            seg[2]=0;
            seg[3]++;
            if(seg[3]>=6)        /*�p�G�d��Ƭ�9+1�������A���d��Ƭ��k0�C*/
            { 
              seg[3]=0;
            }
          }
        }
      }
    }
  }
}
unsigned short scan_key(void)
{
  unsigned short i,j,find=0,ini,inj,in;
  for(i=0;i<4;i++)
  {
    P2=act[i];
    delay(3);
    in=P2;
    in=in>>4;
    in=in|0xf0;
    for(j=0;j<4;j++)
    {
      if(act[j]==in)
      {
        find=1;
        ini=i;
        inj=j;
      }
    }
  }
  if(find==0)
  {
    return 0;
  }
    key=ini*4+inj;
    return 1;
}
void give_key(void)
{
  unsigned short getnum_witesc;
  getnum_witesc=scan_key();
  if(getnum_witesc==1)
  {
    while(getnum_witesc==1)
    {
      getnum_witesc=scan_key();
    }
  }
}
void key_15open(void)
{
    switch(switch_sel)
    {
      case 3:
      {
        if(key<6)
        {
          seg[3]=key;
          switch_sel=2;
          key=16;
        }
        break;
      }
      case 2:
      {
        if(key<=9)
        {
          seg[2]=key;
          switch_sel=1;
          key=16;
        }
        break;
      }
      case 1:
      {
        if(key<6)
        {
          seg[1]=key;
          switch_sel=0;
          key=16;
        }
        break;
      }
      case 0:
      {
        if(key<=9)
        {
          seg[0]=key;
          switch_sel=3;
          key=16;
        }
        break;
      }
    }
    if(key==14)
    {
      key15open=0;
      switch_sel=3;
    }
}
int main(void)
{
  IE=0x82;                /*�]�w�p�ɤ��_*/
  TMOD=0x01;              /*�]�w���_�Ҧ�*/
  TH0=(65536-2000)/256;  /*�]�w���_����ɶ��A�]�w������A�Y�q���ɲִ�A���0�ɶi�J���_�{��*/
  TL0=(65536-2000)%256;  /*�]�w���_����ɶ��A�����G�]65536��x�^�At��x(us)*/
  TR0=1;                  /*�Ұʭp�ɾ��A��AT89S51�p�ɾ��Ұ�*/
  P1=0;
  while(1)                /*�i�J���y�{��*/
  {
    give_key();
    if(key==15)
    {
      key15open=1;
    }
    if(key15open==1)
    {
      key_15open();
    }
  }
}
