function clickEdit(e){
    var id=e.target.getAttribute('data-reviewid');
    console.log("TEST");
    document.getElementById("modal").style.visibility="visible";
    
    document.getElementById("modal").editing.action="/id/edit"
}
function clickSubmit(){
    document.getElementById("modal").style.visibility="hidden";
}