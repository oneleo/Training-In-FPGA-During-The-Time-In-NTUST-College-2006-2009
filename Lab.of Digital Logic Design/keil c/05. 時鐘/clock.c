#include<reg51.h>	 
sbit led_dot=P1^7;
unsigned short act[4]={0xfe,0xfd,0xfb,0xf7};
unsigned short seg_num[16]={0xc0,0xf9,0xa4,0xb0,0x99,0x92,0x82,0xf8,0x80,0x90,0x88,0x83,0xc6,0xa1,0x86,0x8e};
unsigned short key,key15open=0,switch_sel=3,int_delay;
unsigned short seg[4]={0},scan_num=0,scan=0;/*seg用來儲存各個七段顯示器的數值，scan是掃描指定用，scan_num是指定scan哪畿個亮，當seg有數字才亮*/
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
    P0=act[scan];    /*設定AT89S51的P0.0、P0.1、P0.2、P0.3控制要讓哪個七段顯示器發光，因為四個七段顯示器的abcdefgh接腳同為一端，所以要用另四條控制線決定當個別七段顯示器所屬的訊號過來時，要讓該七段顯示器發光。*/
    P1=seg_num[seg[scan]];/*設定AT89S51的P1.0、P1.1、P1.2、P1.3、P1.4、P1.5、P1.6、P1.7分別接入七段顯示器的abcdefgh，因為四個七段顯示器的資料線均相同，所以僅七條就可完成，再籍由快速掃描，肉眼無法辨別的情況下，達成其目的。*/
    if(scan==2)
    {
      led_dot=0;
    }
    if(seg[1]!=0)         /*學長要求若左邊數值為0的話，則不讓其七段顯示器顯示。*/
    { 
      scan_num=1;         /*判別是否有資料，若沒有資料的話，略過掃描。*/
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
void T0_int(void)interrupt 1  /*中斷程序，模式為1*/
{
  TH0=(65536-2000)/256;      /*設定下次中斷執行時間，時間一到，再度進入此中斷程序*/
  TL0=(65536-2000)%256;      /*如此才可不斷做七段累加動作。*/
  scan_7seg();
  if(key15open!=1)
  {
    int_delay++;
    while(int_delay==500)
    {
      int_delay=0;
      seg[0]++;                   /*個位數累加1。*/
      if(seg[0]>=10)              /*如果個位數為9+1的瞬間，讓個位數歸0，讓十位數累加1，*/
      {
        seg[0]=0;
        seg[1]++;
        if(seg[1]>=6)            /*如果十位數為9+1的瞬間，讓十位數歸0，讓百位數累加1。*/
        {
          seg[1]=0;
          seg[2]++;
          if(seg[2]>=10)          /*如果百位數為9+1的瞬間，讓百位數歸0，讓千位數累加1。*/
          {
            seg[2]=0;
            seg[3]++;
            if(seg[3]>=6)        /*如果千位數為9+1的瞬間，讓千位數為歸0。*/
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
  IE=0x82;                /*設定計時中斷*/
  TMOD=0x01;              /*設定中斷模式*/
  TH0=(65536-2000)/256;  /*設定中斷執行時間，設定完成後，即從此時累減，減至0時進入中斷程序*/
  TL0=(65536-2000)%256;  /*設定中斷執行時間，公式：（65536－x），t＝x(us)*/
  TR0=1;                  /*啟動計時器，讓AT89S51計時器啟動*/
  P1=0;
  while(1)                /*進入掃描程序*/
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
