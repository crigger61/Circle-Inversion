ArrayList<Point> pts=new ArrayList<Point>();
Point[] temps = new Point[200];
float[] mp = new float[2];
boolean md= false;
float circleRadius=0.5;
float minS=0;
float maxS=0.75;
void setup(){
  size(500,500);
  
}
void draw(){
  background(255);
  float cx=map(0,minS,maxS,0,width);
  float cy=map(0,minS,maxS,height,0);
  float cr=map(circleRadius+minS,minS,maxS,0,width)*2;
  stroke(0);
  strokeWeight(4);
  fill(0,0);
  ellipse(cx,cy,cr,cr);
  
  for(Point p: pts)
    p.draw();
  if(mousePressed && mouseButton==LEFT){
    float x=map(mouseX,0,width,minS,maxS);
    float y=map(mouseY,height,0,minS,maxS);
    pts.add(new Point(x,y));
  }else if(mousePressed && mouseButton==RIGHT){
    if(!md){
      md=true;
      mp=new float[]{map(mouseX,0,width,minS,maxS),map(mouseY,height,0,minS,maxS)};
    }
    for(int i=0;i<temps.length;i++){
      float x=map(mouseX,0,width,minS,maxS);
      float y=map(mouseY,height,0,minS,maxS);
      temps[i]=new Point((x-mp[0])/temps.length*i+mp[0],(y-mp[1])/temps.length*i+mp[1]);
      temps[i].draw();
    }
  }
  else if(md){
    for(Point p:temps){
      pts.add(p);
      p.draw();
    }
    md=false;
  }else{
    md=false;
  }
  if(frameCount%10==0)
    println(frameRate);
}

class Point{
  public float rawX;
  public float rawY;
  public float pixX;
  public float pixY;
  public float refX;
  public float refY;
  public float repX;
  public float repY;
  
  Point(float x,float y){
    this.rawX=x;
    this.rawY=y;
    
    updatePoints();
    
    
  }
  void updatePoints(){
    float x=rawX;
    float y=rawY;
    this.pixX=map(x,minS,maxS,0,width);
    this.pixY=map(y,minS,maxS,height,0);
    
    float a=circleRadius*circleRadius/(x*x+y*y);
    refX=a*rawX;
    refY=a*rawY;
    repX=map(refX,minS,maxS,0,width);
    repY=map(refY,minS,maxS,height,0);
    
  }
  
  void draw(){
    noStroke();
    fill(255,0,0);
    ellipse(pixX,pixY,4,4);
    
    fill(0,0,255);
    ellipse(repX,repY,4,4);
  }
}
void keyPressed(){
  if(key==' ')
    pts=new ArrayList<Point>();
}
