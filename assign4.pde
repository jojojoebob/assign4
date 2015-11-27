PImage start1,start2,img1,img2,enemy,fighter,hp,treasure,end1,end2,shoot;
PImage flame[]=new PImage[5];
boolean up=false,down=false,left=false,right=false,space=false;
final int GAMESTART=0,GAMERUN=1,GAMELOSE=2;
int g1,g2,fx,fy,tx,ty,lift,gameState,boo,shoots,rn0,rn1,rn2,ex,shootSP;
int enemyboolean[]=new int[18];
int enemyX[]=new int[18];
int enemyY[]=new int[18];
int enemybreak[]=new int[18];
int enemytime[]=new int[18];
int shootX[]=new int[5];
int shootY[]=new int[5];
int shootboolean[]=new int[5];
void setup ()
{
  size(640,480);
  start1=loadImage("img/start1.png");
  start2=loadImage("img/start2.png");
  img1=loadImage("img/bg1.png");
  img2=loadImage("img/bg2.png");
  enemy=loadImage("img/enemy.png");
  fighter=loadImage("img/fighter.png");
  hp=loadImage("img/hp.png");
  treasure=loadImage("img/treasure.png");
  end1=loadImage("img/end1.png");
  end2=loadImage("img/end2.png");
  flame[0]=loadImage("img/flame1.png");
  flame[1]=loadImage("img/flame2.png");
  flame[2]=loadImage("img/flame3.png");
  flame[3]=loadImage("img/flame4.png");
  flame[4]=loadImage("img/flame5.png");
  shoot=loadImage("img/shoot.png");
  gameState=GAMESTART;
  g1=0;
  g2=640;
  fx=width-50; 
  fy=height/2-25;
  tx=floor(random(550));
  ty=floor(random(440));
  ex=-60;
  rn0=floor(random(420));
  rn1=floor(random(180));
  rn2=floor(random(180));
  lift=40;
  shoots=0;
  shootSP=0;
  for(int i=0;i<18;i++)
  {
    enemyboolean[i]=1;
    enemytime[i]=0;
    switch(i)
    {
      case 0:
      case 1:
      case 2:
      case 3:
      case 4:
      enemyX[i]=-60*(i+1);
      enemyY[i]=rn0;
      break;
      case 5:
      case 6:
      case 7:
      case 8:
      case 9:
      enemyX[i]=-60*(i+1)-640;
      enemyY[i]=rn1+60*(i-5);      
      break;
    }
  }
  enemyX[10]=-60-640*3;
  enemyX[11]=-120-640*3;
  enemyX[12]=-120-640*3;
  enemyX[13]=-180-640*3;
  enemyX[14]=-180-640*3;
  enemyX[15]=-240-640*3;
  enemyX[16]=-240-640*3;
  enemyX[17]=-300-640*3;
  enemyY[10]=rn2+120;
  enemyY[11]=rn2+60;
  enemyY[12]=rn2+180;
  enemyY[13]=rn2;
  enemyY[14]=rn2+240;
  enemyY[15]=rn2+60;
  enemyY[16]=rn2+180;
  enemyY[17]=rn2+120;
  for(int i=0;i<5;i++)
  {
    shootY[i]=-60;
    shootboolean[i]=0;
  }
}
void draw()
{
switch(gameState)
  {
    case GAMESTART:
    if(mouseX>205&&mouseX<460&&mouseY>375&&mouseY<420)
    {
      image(start1,0,0);
      if(mousePressed)
        gameState=GAMERUN;      
    }
    else
      image(start2,0,0);
    break;
    case GAMERUN:
    if(ex==640*4+300||ex==-60)
      for(int i=0;i<18;i++)
        enemyboolean[i]=1;
    ex%=640*4+300;
    g1%=1280;
    g2%=1280;
    shootSP%=640;
    shootSP=5;
    image(img1,-640+g1,0);
    image(img2,-640+g2,0);
    ex+=2;
    if(up&&fy>=0)
      fy-=3;
    if(down&&fy<height-50)
      fy+=3;
    if(left&&fx>=0)
      fx-=3;
    if(right&&fx<width-50)
      fx+=3;
    for(int i=0;i<5;i++)
    {
      image(shoot,shootX[i],shootY[i]);
      if(shootX[i]>-60)
        shootX[i]-=shootSP;
      else
      {
        shootY[i]=-60;
        shootboolean[i]=0;
      }
    }
    if(space&&shoots<5)
    {
      if(shootboolean[shoots]==0)
      {
        shootX[shoots]=fx;
        shootY[shoots]=fy+12;
        space=false;
        shootboolean[shoots]=1;
        shoots++;
      }
      if(shoots>4)
        shoots=0;
    }
    for(int i=0;i<18;i++)
    {
      if(((enemyX[i]+ex<=fx   &&fx   <=enemyX[i]+60+ex&&enemyY[i]<=fy   &&fy   <=enemyY[i]+60)||(enemyX[i]+ex<=fx+50&&fx+50<=enemyX[i]+60+ex&&enemyY[i]<=fy   &&fy   <=enemyY[i]+60)||(enemyX[i]+ex<=fx   &&fx   <=enemyX[i]+60+ex&&enemyY[i]<=fy+50&&fy+50<=enemyY[i]+60)||(enemyX[i]+ex<=fx+50&&fx+50<=enemyX[i]+60+ex&&enemyY[i]<=fy+50&&fy+50<=enemyY[i]+60))&&enemyboolean[i]==1)
      {
        enemyboolean[i]=-60;
        enemybreak[i]=enemyX[i]+ex;
        lift-=40;
      }
      if(lift<=0)
      {
        gameState=GAMELOSE;
        break;
      }
      for(int j=0;j<5;j++)
      {
        if(((enemyX[i]+ex<=shootX[j]   &&shootX[j]   <=enemyX[i]+60+ex&&enemyY[i]<=shootY[j]   &&shootY[j]   <=enemyY[i]+60)||(enemyX[i]+ex<=shootX[j]+25&&shootX[j]+25<=enemyX[i]+60+ex&&enemyY[i]<=shootY[j]   &&shootY[j]   <=enemyY[i]+60)||(enemyX[i]+ex<=shootX[j]   &&shootX[j]   <=enemyX[i]+60+ex&&enemyY[i]<=shootY[j]+25&&shootY[j]+25<=enemyY[i]+60)||(enemyX[i]+ex<=shootX[j]+25&&shootX[j]+25<=enemyX[i]+60+ex&&enemyY[i]<=shootY[j]+25&&shootY[j]+25<=enemyY[i]+60))&&enemyboolean[i]==1)
        {
          enemyboolean[i]=-60;
          enemybreak[i]=enemyX[i]+ex;
          shootY[j]=-90;
        }
      }
      if(enemyboolean[i]==-60)
      {
        image(flame[floor(enemytime[i]/10]),enemybreak[i],enemyY[i]);
        if(enemytime[i]<49)
          enemytime[i]++;
        else
        {
          enemyboolean[i]=-70;
          enemytime[i]=0;
        }
      }
    }
    image(fighter,fx,fy);
    g1+=1;
    g2+=1;
    if(fx<tx+40&&tx<fx+50&&fy<ty+40&&ty<fy+50)
    {
      tx=floor(random(550));
      ty=floor(random(400));
      if(lift<200)
        lift+=20;
    }
    image(treasure,tx,ty);
    fill(250,0,0);
    rect(5,5,lift+5,20);
    image(hp,2,2);
    for(int i=0;i<18;i++)
      image(enemy,enemyX[i]+ex,enemyY[i]*enemyboolean[i]);
    break;
    case GAMELOSE:
    if(205<mouseX&&mouseX<440&&305<mouseY&&mouseY<350)
    {
      image(end1,0,0);
      if(mousePressed)
      {
        fx=width-50;
        fy=height/2-25;
        tx=floor(random(600));  
        ty=floor(random(440));
        lift=40;
        rn0=floor(random(420));
        rn1=floor(random(180));
        rn2=floor(random(180));
        ex=-60;
        for(int i=0;i<5;i++)
        {
          shootY[i]=-60;
          shootboolean[i]=0;
        }
        gameState=GAMERUN;
      }
    }
    else
      image(end2,0,0);
    break;
  }
}
void keyPressed()
{
  if(key==32)
  {
    space=true;
  }
  if(key==CODED)
  {
    switch(keyCode)
    {
      case UP:
      up=true;
      break;
      case DOWN:
      down=true;
      break;
      case LEFT:
      left=true;
      break;
      case RIGHT:
      right=true;
      break;
    }
  }
}
void keyReleased()
{
  if(key==32)
    space=false;
  if(key==CODED)
  {
    switch(keyCode)
    {
      case UP:
      up=false;
      break;
      case DOWN:
      down=false;
      break;
      case LEFT:
      left=false;
      break;
      case RIGHT:
      right=false;
      break;
    }
  }
}
