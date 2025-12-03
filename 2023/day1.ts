let input = `sq5fivetwothree1
six5gc
txb3qfzsbzbxlzslfourone1vqxgfive`

const inputList = input.split('\n');
const numbers = ['one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine'];
let reversedNumbers = numbers.map(item => item.split('').reverse().join(''));

let totalSum = 0;

for (const line of inputList) {
  let firstNum = -1;
  let lastNum = -1;

  let firstNumString = '';
  let firstNumIndex = 10000;
  let lastNumString = '';
  let lastNumIndex = 10000;

  for (const number of numbers) {
    const i = line.indexOf(number);
    if (i < firstNumIndex && i !== -1) {
      firstNumIndex = i;
      firstNumString = number;
    }
  }

  if (firstNumString !== '') {
    firstNum = numbers.indexOf(firstNumString) + 1;
  }

  // find first num
  for (let i = 0; i < line.length; i++) {
    if (!isNaN(Number(line[i]))) {
      if (i < firstNumIndex) {
        firstNumIndex = i;
        firstNum = Number(line[i]);
        break;
      }
    }
  }

  const reversedLine = line.split('').reverse().join('');
  for (const number of reversedNumbers) {
    const i = reversedLine.indexOf(number);
    if (i < lastNumIndex && i !== -1) {
      lastNumIndex = i;
      lastNumString = number;
    }
  }

  if (lastNumString !== '') {
    lastNum = reversedNumbers.indexOf(lastNumString) + 1;
  }

  // find last num
  for (let i = 0; i < reversedLine.length; i++) {
    if (!isNaN(Number(reversedLine[i]))) {
      if (i < lastNumIndex) {
        lastNumIndex = i;
        lastNum = Number(reversedLine[i]);
        break;
      }
    }
  }

  console.log(line, firstNum, lastNum);
  totalSum += firstNum * 10 + lastNum;
}

console.log(totalSum);
