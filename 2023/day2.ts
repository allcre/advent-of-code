const day2 = () => {
  const input =
    `Game 1: 1 green, 1 blue, 1 red; 1 green, 8 red, 7 blue; 6 blue, 10 red; 4 red, 9 blue, 2 green; 1 green, 3 blue; 4 red, 1 green, 10 blue
Game 2: 9 red, 7 green, 3 blue; 15 green, 2 blue, 5 red; 10 red, 3 blue, 13 green
Game 3: 3 red, 1 blue, 4 green; 6 red, 3 green, 2 blue; 6 red, 16 blue, 1 green
Game 4: 2 blue, 2 green, 19 red; 3 blue, 11 red, 16 green; 18 blue, 13 green, 20 red; 18 red, 12 blue, 16 green; 8 green, 16 blue, 16 red
Game 5: 8 green, 1 red, 12 blue; 10 green, 6 red, 13 blue; 1 red, 3 blue, 6 green; 14 blue, 2 red, 7 green
Game 6: 1 red; 1 blue; 2 green, 1 blue; 1 red, 3 blue; 1 red, 2 blue, 2 green; 1 green, 7 blue, 1 red
Game 7: 2 red, 1 blue, 5 green; 5 green, 1 red; 3 red, 7 blue; 8 blue, 1 red, 4 green
Game 8: 6 green, 4 blue; 10 green, 7 blue; 5 blue; 1 red, 7 blue; 11 green, 1 red
Game 9: 2 green, 2 blue; 8 red, 5 blue, 6 green; 11 green, 6 blue, 8 red; 4 blue, 3 green, 8 red; 2 green, 10 red, 5 blue
Game 10: 2 blue, 8 green, 2 red; 10 blue, 3 green; 12 blue, 1 green, 2 red; 9 green, 2 red; 3 green, 2 red, 5 blue`

  // split by games
  const games = input.split('\n');

  // make game info list
  // [id, max red, max green, max blue]
  let gameInfo = [];
  let gameNum = 1;
  for (const game of games) {
    let gameArr: any[] = [];
    gameArr.push(gameNum);

    const colours = ['red', 'green', 'blue'];
    // find all instances of green, get the quantity of greens, find the max
    for (const colour of colours) {
      let colourIndex = 0;
      let maxQuant = 0;
      while (colourIndex !== -1) {
        colourIndex = game.indexOf(colour, colourIndex + 5);
        const quant = game[colourIndex - 3] === ' ' ? Number(game[colourIndex - 2]) : Number(game[colourIndex - 3]) * 10 + Number(game[colourIndex - 2]);
        if (quant > maxQuant) {
          maxQuant = quant;
        }
      }
      gameArr.push(maxQuant);
    }
    gameNum++;

    gameInfo.push(gameArr);
  }

  // const possibleGames = gameInfo.filter((arr) => {
  //   return arr[1] <= 12 && arr[2] <= 13 && arr[3] <= 14;
  // });

  // let sum = 0;
  // for (let game of possibleGames) {
  //   sum += game[0];
  // }
  // console.log(sum);

  // part 2

  let sum = 0;
  for (let game of gameInfo) {
    const square = game[1] * game[2] * game[3];
    sum += square;
  }

  console.log(sum);
}

day2();
