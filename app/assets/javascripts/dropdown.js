// function for preventing multiple dropdowns being open at once
function dropdownFunction(dropdownList) {
  function dropdownAction(action, id){
    if (action == "remove"){
      document.getElementById(id).classList.remove("show");
    } else if (action == "toggle"){
      document.getElementById(id).classList.toggle("show");
    }
  }
  dropdownListName = dropdownList + "Dropdown"
  dropdownArr = document.querySelectorAll("[id$=Dropdown]")
  dropdownArr = [].slice.call(dropdownArr)
  dropdownArr = dropdownArr.map(function(item){return item.id})

  for (var i=0; i<dropdownArr.length; i++){
    if (dropdownArr[i] == dropdownListName){
      dropdownAction("toggle", dropdownArr[i])
    } else {
      dropdownAction("remove", dropdownArr[i])
    }
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
