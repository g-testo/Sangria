function dropdownFunction(dropdownList) {
  if (dropdownList == "flavor"){
    document.getElementById("accountDropdown").classList.remove("show");
    document.getElementById("flavorDropdown").classList.toggle("show");
  } else if (dropdownList == "account"){
    document.getElementById("flavorDropdown").classList.remove("show");
    document.getElementById("accountDropdown").classList.toggle("show");
  }
}

window.onclick = function(event) {
  // openDropdownList = document.querySelectorAll('[id$="Dropdown"]');
//   for (var i=0;i<openDropdownList.length;i++){
    // if (openDropdownList[i].classList.contains('show')) {
//       console.log("True")
//       // document.getElementById(openDropdownList[i].id).classList.remove('show')
//     // document.getElementsByClassName(openDropdownList[i]).classList.remove('show');
//     // console.log(openDropdownList[i].id);
//   //   if (openDropdownList[i].classList.contains('show')) {
//   //   }
//   }
// }

  if (!event.target.matches('.dropbtn')) {
    var dropdowns = document.getElementsByClassName("dropdown-content");
    for (var i=0; i<dropdowns.length;i++) {
      var openDropdown = dropdowns[i];
      if (openDropdown.classList.contains('show')) {
        openDropdown.classList.remove('show');
      }
    }
  }
}
