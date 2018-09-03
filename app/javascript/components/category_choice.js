$(document).ready(function(){
  $(".category-choice").click(function(){
    let buttons = document.querySelectorAll(".active");
    buttons.forEach((button) => {
    button.classList.remove("active");
    });
    $(this).toggleClass("active");
  });
});

