import mermaid from 'mermaid'

function init_mermaid() {
  mermaid.initialize({startOnLoad:true});
}


function textCircle() {
  setTimeout(() => {
    const circles = document.querySelectorAll(".node")
    console.log(circles)
    circles.forEach((circle) => {
        var id = circle.getAttribute('id');
        var text ="<text x=20 y=40 transform=translate(10,35)>"+id+"</text>"
        console.log(text)
        circle.insertAdjacentHTML("afterbegin", text)
    })
  }, 2000)
};


export { init_mermaid }
export { textCircle }
