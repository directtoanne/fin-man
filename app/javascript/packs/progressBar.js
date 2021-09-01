import { Circle } from "progressbar.js";
var goalsList = document.querySelectorAll("#avatar-progress");
goalsList.forEach(function (goal) {
  var circle = new Circle(goal, {
    color: "#068140",
    trailColor: "#eee",
    trailWidth: 2,
    duration: 2000,
    easing: "bounce",
    strokeWidth: 6,
    from: { color: "#FF0000", a: 0 },
    to: { color: "#068140", a: 1 },
    warnings: false,
    text: {
      value:
        '<div class="avatar-progress-text">' +
        Math.round(goal.dataset.percent * 100) +
        "%</div>",
      className: "progressbar__label " + goal.dataset.icon,
      style: {
        color: "#975B53",
        position: "absolute",
        left: "50%",
        top: "50%",
        padding: 0,
        margin: 0,
        transform: {
          prefix: true,
          value: "translate(-50%, -50%)",
        },
      },
      step: function (state, circle) {
        circle.path.setAttribute("stroke", state.color);
      },
    },
  });
  circle.animate(goal.dataset.percent);
});

export { goalsList };