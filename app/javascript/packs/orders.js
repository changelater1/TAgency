document.addEventListener("DOMContentLoaded", () => {
  const completeOrderButton = document.getElementById("complete-order-button");
  const completeOrderForm = document.getElementById("complete-order-form");

  if (completeOrderButton && completeOrderForm) {
    completeOrderButton.addEventListener("click", () => {
      completeOrderForm.style.display = "block";
      completeOrderButton.style.display = "none";
    });
  }
});