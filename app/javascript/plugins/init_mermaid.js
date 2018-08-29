import mermaid from 'mermaid'

function init_mermaid() {
  mermaid.initialize({startOnLoad:true});
}


function textCircle() {
  setTimeout(() => {
    const circles = document.querySelectorAll(".node")
    circles.forEach((circle) => {
        var id = circle.getAttribute('id').replace(/-/, ' ').replace(/-/, ' ');
        var text ="<text x=20 y=40 transform=translate(-8,-36)>"+id+"</text>"
        circle.insertAdjacentHTML("afterbegin", text)
    })
  }, 2000)
};


export { init_mermaid }
export { textCircle }
