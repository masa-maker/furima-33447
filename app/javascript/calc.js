function calc () {
  const itemPrice = document.getElementById("item-price");
  itemPrice.addEventListener("keyup", () => {
    const countPrice = itemPrice.value;
    const addTaxPrice = document.getElementById("add-tax-price");
    const profit = document.getElementById("profit");
    addTaxPrice.innerHTML = `${Math.round(countPrice*0.1)}`
    profit.innerHTML =`${countPrice-addTaxPrice.innerHTML}`
    window.onload = function () {
      itemPrice = "";
    };
  });
}

setInterval(calc, 1000);