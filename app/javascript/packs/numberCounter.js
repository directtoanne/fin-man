import { CountUp } from 'countup.js';
const id = 'jsCounter';
window.onload = function() {
  const element = document.getElementById(id)
  const number = element.dataset.number
  const prefix = element.dataset.prefix
  const countUp = new CountUp(element, number, {
    decimalPlaces: 2,
    prefix: prefix,
  });

  if (!countUp.error) {
    countUp.start()
  } else {
    console.error(countUp.error);
  }
};

export { jsCounter };