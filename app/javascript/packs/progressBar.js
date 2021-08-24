var ProgressBar = require('progressbar.js')
var goalsList = document.querySelectorAll("#avatar-progress")
goalsList.forEach(function(goal){
  var circle = new ProgressBar.Circle(goal, {
    color: '#068140',
    trailColor: '#eee',
    trailWidth: 1,
    duration: 1400,
    easing: 'bounce',
    strokeWidth: 6,
    from: {color: '#068140', a:0},
    to: {color: '#068140', a:1},
    text: {
      value: '',
      className: 'progressbar__label fas fa-umbrella-beach',
      style: {
        color: '#f00',
        position: 'absolute',
        left: '50%',
        top: '50%',
        padding: 0,
        margin: 0,
        transform: {
            prefix: true,
            value: 'translate(-50%, -50%)',
        }
    },
    // Set default step function for all animate calls
    step: function(state, circle) {
      circle.path.setAttribute('stroke', state.color);
    }
  }});
  
  circle.animate(0.80);
});