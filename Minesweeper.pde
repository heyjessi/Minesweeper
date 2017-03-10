import de.bezier.guido.*;
public int NUM_ROWS = 20;
public int NUM_COLS = 20;
//Declare and initialize NUM_ROWS and NUM_COLS = 20

private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs; //ArrayList of just the minesweeper buttons that are mined


void setup ()
{
  size(400, 400);
  textAlign(CENTER, CENTER);

  // make the manager
  Interactive.make( this );
  buttons = new MSButton[NUM_ROWS][NUM_COLS];
  for (int i =0; i< NUM_ROWS; i++) {
    for (int j = 0; j < NUM_COLS; j++) {
      buttons[i][j] = new MSButton(i, j);
    }
  }
  //your code to declare and initialize buttons goes here
  setBombs();
}

//null pointer exception
public void setBombs()
{
  bombs = new ArrayList <MSButton>();
  //your code
  for(int i =0; i< (NUM_ROWS*NUM_COLS)/6; i++)
  {
      int row = (int)(Math.random()*NUM_ROWS);
      int col = (int)(Math.random()*NUM_COLS);
      if (bombs.contains(buttons[row][col])== false)
      {
        bombs.add(buttons[row][col]);
      }
      System.out.println(row);
      System.out.println(col);
}
}


public void draw ()
{
  background( 0 );
  if (isWon())
    displayWinningMessage();
}
public boolean isWon()
{
  //your code here
  return false;
}
public void displayLosingMessage()
{
  //your code here
  System.out.println("You lose!");
  buttons[10][6].setLabel("Y");
  buttons[10][7].setLabel("O");
  buttons[10][8].setLabel("U");
  buttons[10][9].setLabel(" ");
  buttons[10][10].setLabel("L");
  buttons[10][11].setLabel("O");
  buttons[10][12].setLabel("S");
  buttons[10][13].setLabel("E");
}
public void displayWinningMessage()
{
  //your code here
}

public class MSButton
{
  private int r, c;
  private float x, y, width, height;
  private boolean clicked, marked;
  private String label;

  public MSButton ( int rr, int cc )
  {
    width = 400/NUM_COLS;
    height = 400/NUM_ROWS;
    r = rr;
    c = cc; 
    x = c*width;
    y = r*height;
    label = "";
    marked = clicked = false;
    Interactive.add( this ); // register it with the manager
  }
  //Marked means that it hasn't been clicked on
  public boolean isMarked()
  {
    return marked;
  }
  public boolean isClicked()
  {
    return clicked;
  }
  // called by manager

  public void mousePressed () 
  {
    clicked = true;
    if (keyPressed ==true)
    {
      marked = !marked;
      if (marked == false)
      {
        clicked = false;
      }
    } else if (bombs.contains(this) && marked ==false)
    {
      displayLosingMessage();
    } else if (countBombs(r, c)>0)
    {
      setLabel(""+(countBombs(r, c)));
    } else
    {  

       //is Valid must be the first one not isClicked. If the first argument is false then the code will automatically crash without accessing any of the other functions
      if (isValid(r-1, c) && buttons[r-1][c].isClicked() == false)
      {
        buttons[r-1][c].mousePressed();
      }
      if (isValid(r, c+1) && buttons[r][c+1].isClicked() == false)
      {
        buttons[r][c+1].mousePressed();
      }
      if (isValid(r+1, c) && buttons[r+1][c].isClicked() == false)
      {
        buttons[r+1][c].mousePressed();
      }
      if (isValid(r, c-1) && buttons[r][c-1].isClicked() == false)
      {
        buttons[r][c-1].mousePressed();
      }
    }
  }

  public void draw () 
  {    
    if (marked)
      fill(0);
    else if ( clicked && bombs.contains(this) ) 
      fill(255, 0, 0);
    else if (clicked)
      fill( 200 );
    else 
    fill( 100 );

    rect(x, y, width, height);
    fill(0);
    text(label, x+width/2, y+height/2);
  }
  public void setLabel(String newLabel)
  {
    label = newLabel;
  }
  public boolean isValid(int r, int c)
  {
    //your code here
    if (r>=0 && r<NUM_ROWS && c >= 0 && c <NUM_COLS) {
      return true;
    }
    return false;
  }
  public int countBombs(int row, int col)
  {
    int numBombs = 0;
    //your code here
    //took out the isMarked() function bc it wont run when the button is unmarked (clicked on) and therefore not show the label
    if (isValid(row-1, col) && bombs.contains(buttons[row-1][col]))
    {
      numBombs++;
    }
    if (isValid(row-1, col+1) && bombs.contains(buttons[row-1][col+1]))
    {
      numBombs++;
    }
    if (isValid(row, col+1) && bombs.contains(buttons[row][col+1]))
    {
      numBombs++;
    }
    if (isValid(row+1, col+1)&& bombs.contains(buttons[row+1][col+1]))
    {
      numBombs++;
    }
    if (isValid(row+1, col) && bombs.contains(buttons[row+1][col]))
    {
      numBombs++;
    }
    if (isValid(row+1, col-1) && bombs.contains(buttons[row+1][col-1]))
    {
      numBombs++;
    }
    if (isValid(row, col-1) && bombs.contains(buttons[row][col-1]))
    {
      numBombs++;
    }
    if (isValid(row-1, col-1) && bombs.contains(buttons[row-1][col-1]))
    {
      numBombs++;
    }
    return numBombs;
  }
}

