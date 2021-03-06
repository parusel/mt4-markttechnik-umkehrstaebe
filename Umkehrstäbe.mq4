#property copyright "Adam Parusel"
#property link      "https://adamparusel.com"
#property version   "1.00"
 
#property indicator_chart_window
#property indicator_buffers 2
#property indicator_color1 Green
#property indicator_color2 Red
 
double ExtUp[];
double ExtDown[];

void OnInit()
{
    SetIndexBuffer(0,ExtDown);
    SetIndexBuffer(1,ExtUp);   

    SetIndexStyle(0,DRAW_ARROW, NULL, 3);
    SetIndexArrow(0,233);
    SetIndexStyle(1,DRAW_ARROW, NULL, 3);
    SetIndexArrow(1,234);

    SetIndexEmptyValue(0,0.0);
    SetIndexEmptyValue(1,0.0);

    SetIndexLabel(0,"Long-Umkehrstab");
    SetIndexLabel(1,"Short-Umkehrstab");
}


int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
{
   for(int i=0; i<rates_total; i++)
   {
      if (Close[i+1] < Open[i+1] && Low[i] < Low[i+1] && Close[i] > Open[i])
         ExtDown[i] = Low[i];

      if (Close[i+1] > Open[i+1] && High[i] > High[i+1] && Close[i] < Open[i])
         ExtUp[i] = High[i];
   }
   return(rates_total);
}

