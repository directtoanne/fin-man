function hideShowElement(element_args) {
  console.log(element_args)
  var element = document.getElementById(element_args)
  if (element.style.display === "none") {
    element.style.display = "block";
  } else {
    element.style.display = "none";
  }
}

export { hideShowElement }