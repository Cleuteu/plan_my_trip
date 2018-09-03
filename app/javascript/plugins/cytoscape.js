import cytoscape from 'cytoscape';
import tippy from 'tippy.js'
import popper from 'cytoscape-popper';

cytoscape.use( popper );


const graph = document.getElementById('cy');

const nodes = JSON.parse(graph.dataset.nodes);
const relationships = JSON.parse(graph.dataset.relationships);
var elements = [];

// console.log(nodes)
// console.log(relationships)


var y = 0;
nodes.forEach((node) => {
  elements.push({ data:
                  { id: nodes[y].id,
                    name: nodes[y].name,
                    category: nodes[y].category,
                    master: nodes[y].master
                  },
                  position: { x: nodes[y].position_x, y: nodes[y].position_y }
                },
                );
  y += 1;
  });

 // data: { id: 'n3', parent: 'nparent' },
 //      position: { x: 123, y: 234 }

var i = 0;
relationships.forEach((relationship) => {
  elements.push({ data:
                  { id: `${relationships[i].parent_id}-${relationships[i].child_id}`,
                    source: relationships[i].parent_id,
                    target: relationships[i].child_id
                  }
                },
                )
  i += 1;
  });

console.log(elements)

const cy = cytoscape({
  container: document.getElementById('cy'),
    elements:
      elements,

  layout: {
    name: 'preset',
    // directed: true,
    // roots: `#${nodes[0].id}`,
    // padding: 20,
    // fit: true,
    // spacingFactor: 1.75,
    // height: undefined,
    },

  style: [
    {
      selector: 'node:unselected',
      style: {
        label: 'data(name)',
        // 'min-zoomed-font-size': 46,
        'text-events': 'yes',
        'text-halign': 'right',
        'text-valign': 'center',
        'text-margin-x': 8,
        'font-size': 23,
        'text-transform': 'uppercase',
        'color': 'grey',
        'width': 60,
        'height': 60,
        'background-color': 'white',
        'background-fit': 'contain',
        'background-image-opacity': 0.9,
        'background-repeat': 'no-repeat',
        'border-width': 3,
        'border-color': '#106BA5',
        'overlay-opacity': 0,
        'ghost': 'yes',
        'ghost-offset-x': 0,
        'ghost-offset-y': 2,
        'ghost-opacity': 0.1,
      }
    },{
    selector: 'node:selected',
      style: {
        label: 'data(name)',
        // 'min-zoomed-font-size': 46,
        'text-events': 'yes',
        'text-halign': 'right',
        'text-valign': 'center',
        'text-margin-x': 8,
        'font-size': 23,
        'text-transform': 'uppercase',
        'color': 'gray',
        'width': 60,
        'height': 60,
        'background-color': 'white',
        'background-fit': 'contain',
        'background-image-opacity': 0.9,
        'background-repeat': 'no-repeat',
        'border-width': 3,
        'border-color': '#106BA5',
        'overlay-opacity': 0,
        'ghost': 'yes',
        'ghost-offset-x': 0,
        'ghost-offset-y': 2,
        'ghost-opacity': 0.1,
      }
    },{
    selector: "node[category = 'Accommodation']",
      style: {
        label: 'data(name)',
        'background-image': [
          'http://res.cloudinary.com/dnddzhvyj/image/upload/v1535965592/home-solid-padded.png'
        ],
        'border-color': '#E65158',
        'transition-property': 'background-color',
        'transition-duration': 200
      }
    },{
    selector: "node[category = 'Travel']",
      style: {
        label: 'data(name)',
        'background-image': [
          'http://res.cloudinary.com/dnddzhvyj/image/upload/v1535965554/car-solid-padded.png'
        ],
        'border-color': '#106BA5',
        'transition-property': 'background-color',
        'transition-duration': 200
      }
    },{
    selector: "node[category = 'Activity']",
      style: {
        label: 'data(name)',
        'background-image': [
          'http://res.cloudinary.com/dnddzhvyj/image/upload/v1535965516/camera-retro-solid-padded.png'
        ],
        'border-color': '#F3B548',
        'transition-property': 'background-color',
        'transition-duration': 200
      }
    },{
    selector: "node[category = 'Activity'][master = 'true']",
      style: {
        label: 'data(name)',
        'text-halign': 'right',
        'text-valign': 'center',
        'text-margin-x': 8,
        'font-size': 23,
        'text-transform': 'uppercase',
        'color': 'black',
        'width': 60,
        'height': 60,
        'background-image': [
          'http://res.cloudinary.com/dnddzhvyj/image/upload/v1535965516/camera-retro-solid-padded.png'
        ],
        'background-color': '#54B589',
        'background-fit': 'contain',
        'background-image-opacity': 0.9,
        'background-repeat': 'no-repeat',
        'border-width': 3,
        'border-color': '#54B589',
        'ghost': 'yes',
        'ghost-offset-x': 0,
        'ghost-offset-y': 2,
        'ghost-opacity': 0.1,
      }
    },{
    selector: "node[category = 'Travel'][master = 'true']",
      style: {
        label: 'data(name)',
        'text-halign': 'right',
        'text-valign': 'center',
        'text-margin-x': 8,
        'font-size': 23,
        'text-transform': 'uppercase',
        'color': 'black',
        'width': 60,
        'height': 60,
        'background-image': [
          'http://res.cloudinary.com/dnddzhvyj/image/upload/v1535965554/car-solid-padded.png'
        ],
        'background-color': '#54B589',
        'background-fit': 'contain',
        'background-image-opacity': 0.9,
        'background-repeat': 'no-repeat',
        'border-width': 3,
        'border-color': '#54B589',
        'ghost': 'yes',
        'ghost-offset-x': 0,
        'ghost-offset-y': 2,
        'ghost-opacity': 0.1,
      }
    },{
    selector: "node[category = 'Accommodation'][master = 'true']",
      style: {
        label: 'data(name)',
        'text-halign': 'right',
        'text-valign': 'center',
        'text-margin-x': 8,
        'font-size': 23,
        'text-transform': 'uppercase',
        'color': 'black',
        'width': 60,
        'height': 60,
        'background-image': [
          'http://res.cloudinary.com/dnddzhvyj/image/upload/v1535965592/home-solid-padded.png'
        ],
        'background-color': '#54B589',
        'background-fit': 'contain',
        'background-image-opacity': 0.9,
        'background-repeat': 'no-repeat',
        'border-width': 3,
        'border-color': '#54B589',
        'ghost': 'yes',
        'ghost-offset-x': 0,
        'ghost-offset-y': 2,
        'ghost-opacity': 0.1,
      }
    },{
      selector: 'edge:unselected',
      style: {
        label: '',
        // 'font-family': 'Font Awesome Free 5',
        // 'label': '\uf055',
        'font-weight': '900',
        'font-size': '50',
        'color': 'gray',
        'width': 3,
        'line-color': 'gray',
        'line-style': 'dashed',
        'overlay-color': 'gray',
        // 'overlay-padding': 14,
        'curve-style': 'haystack',
        // 'target-arrow-color': 'gray',
        // 'target-arrow-shape': 'vee',
        'arrow-scale': 1,
        'ghost': 'yes',
        'ghost-offset-x': 0,
        'ghost-offset-y': 1,
        'ghost-opacity': 0.1,
        'transition-property': 'line-color, target-arrow-color, overlay-opacity',
        'transition-duration': 100
      }
    },{
      selector: 'edge:selected',
      style: {
        label: '',
        'font-weight': '900',
        'font-size': '50',
        'color': 'gray',
        'width': 3,
        'line-color': 'gray',
        'line-style': 'dashed',
        // 'overlay-padding': 14,
        'overlay-color': 'gray',
        'overlay-opacity': 0,
        'curve-style': 'haystack',
        // 'target-arrow-color': '#BABABA',
        // 'target-arrow-shape': 'vee',
        'arrow-scale': 1,
        'ghost': 'yes',
        'ghost-offset-x': 0,
        'ghost-offset-y': 1,
        'ghost-opacity': 0.1,
        'transition-property': 'line-color, target-arrow-color, overlay-opacity',
        // 'transition-timing-function': 'ease',
        'transition-duration': 100
      }
    },{
      selector: 'node.hover',
      style: {
        'color': 'black',
        'text-margin-x': 6,
        'width': 64,
        'height': 64,
        // 'background-color': '#24A2B7',
        'background-color': '#E2E6EA',
        'background-fit': 'contain',
        'background-image-opacity': 1,
        'transition-property': 'color, text-margin-x, width, height, background-color, background-image-opacity',
        'transition-timing-function': 'ease',
        'transition-duration': 150
      }
    },{
      selector: 'edge.hover',
      style: {
        label: '+',
        // 'text-halign': 'right',
        // 'text-valign': 'center',
        // 'text-margin-x': 8,
        // 'text-margin-y': 8,
        'color': 'black',
        // 'line-color': 'green',
        'line-color': '#5A6268',
        'width': 4,
        'transition-property': 'color, width',
        // 'transition-timing-function': 'ease',
        'transition-duration': 150
      }
    },{
      selector: 'core',
      style: {
        'active-bg-opacity': 0
      }
    }],

  // interaction options:
  userZoomingEnabled: false,
  zoomingEnabled: true,
  userPanningEnabled: false,
  boxSelectionEnabled: false,
  autoungrabify: true,
  maximalAdjustments: 100,
  });

cy.on('mouseover', 'node', () =>$('html,body').css('cursor', 'pointer'));
cy.on('mouseout', 'node', () =>$('html,body').css('cursor', 'default'));
cy.on('mouseover', 'edge', () =>$('html,body').css('cursor', 'pointer'));
cy.on('mouseout', 'edge', () =>$('html,body').css('cursor', 'default'));
cy.on('mouseover', 'node', (e) => { e.target.addClass('hover'); });
cy.on('mouseout', 'node', (e) => { e.target.removeClass('hover'); });
cy.on('mouseover', 'edge', (e) => { e.target.addClass('hover'); });
cy.on('mouseout', 'edge', (e) => { e.target.removeClass('hover'); });

// cy.on('click', 'node', (evt) => { document.getElementById('show-node'+ evt.target.id()).click() });

// Trigger la modal d'ajout d'un event
cy.on('click', 'edge', () => { document.getElementById('add-node').click(); });

// Recupérer les events parent et enfant quand on ajoute un event
cy.on('click', 'edge', (evt) => {
  let event_node_id = evt.target.id();
  event_node_id = event_node_id.split("-");
  let event_parent_id = event_node_id[0];
  let event_child_id = event_node_id[1];
  let child_id_form = document.getElementById('event_child_id');
  let parent_id_form = document.getElementById('event_parent_id');
  child_id_form.value = event_child_id
  parent_id_form.value = event_parent_id
} );

// Recupérer l'event parent quand on ajoute un event sur une nouvelle branche
cy.on('click', 'node', (evt) => {
  let event_node_id = evt.target.id();
  let branch_parent_id_form = document.getElementById('branch_event_parent_id');
  branch_parent_id_form.value = event_node_id
} );

// TIPPY TOOLTIPS SECTION

// Tippy function
var makeTippy = function(node, text){
  return tippy( node.popperRef(), {
    html: (function(){
      const myTemplate = document.createElement('div');

      myTemplate.innerHTML = text;

      return myTemplate;
    })(),
    trigger: 'manual',
    arrow: true,
    placement: 'top',
    distance: 0,
    sticky: true,
    hideOnClick: true,
    maxWidth: 300,
    theme: 'treep',
    interactive: true,
    multiple: true,
    zIndex: 1000,
  } ).tooltips[0];
};

// Tippy trigger via mouserover / mouseout
let tippy_var = null;

cy.on('mouseover', 'node', (e) => {
  tippy_var = makeTippy(e.target, document.getElementById('show-tippy'+ e.target.id()).innerHTML)
  tippy_var.show();
});
cy.on('mouseout', 'node', (e) => { tippy_var.hide(); });



