module mul(a,b,c,d,e,f,g,h,s,y);
  input [7:0]a,b,c,d,e,f,g,h;
  input [2:0]s;
  output[7:0]y;
  assign y=	(s==0)?	a:
			(s==1)?	b:
			(s==2)?	c:
			(s==3)?	d:
			(s==4)?	e:
			(s==5)?	f:
			(s==6)?	g:
			(s==7)?	h:0;
endmodule