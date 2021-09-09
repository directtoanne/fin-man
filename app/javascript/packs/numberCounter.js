import { CountUp } from 'countup.js';
export const goalsTotal = () => {
  const counterMain = document.querySelector('.counter-main')

  if (counterMain) {
    const elements = document.querySelectorAll('.jsCounter')
    if (elements) {
      elements.forEach(element => {
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
      });
    };
  };
}