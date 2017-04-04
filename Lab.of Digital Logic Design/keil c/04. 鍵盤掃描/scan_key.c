#include<reg51.h>
unsigned short act[4]={0xfe,0xfd,0xfb,0xf7};
unsigned short data_7seg[16]={0xc0,0xf9,0xa4,0xb0,0x99,0x92,0x82,0xf8,0x80,0x90,0x88,0x83,0xc6,0xa1,0x86,0x8e};
unsigned short key;
void delay(int delay)
{
  int d;
  for(d=0;d<(delay*100);d++)
  {
    ;
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
int main(void)
{
  P1=0;
  while(1)
  {
    if(scan_key()==1)
    {
      P1=data_7seg[key];
    }
  }
}
