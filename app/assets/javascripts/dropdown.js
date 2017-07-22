
function dropdownFunction(dropdownList) {

  function dropdownAction(action, id){
    if (action == "remove"){
      document.getElementById(id).classList.remove("show");
    } else if (action == "toggle"){
      document.getElementById(id).classList.toggle("show");
    }
  }
  if (dropdownList == "flavor"){
    dropdownAction("remove", "accountDropdown")
    dropdownAction("toggle", "flavorDropdown")
  } else if (dropdownList == "account"){
    dropdownAction("remove", "flavorDropdown")
    dropdownAction("toggle", "accountDropdown")
  }
}

window.onclick = function(event) {
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
