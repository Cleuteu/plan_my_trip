import cytoscape from 'cytoscape';
import tippy from 'tippy.js'
import popper from 'cytoscape-popper';
import '@fortawesome/fontawesome-free/css/all.min.css';

cytoscape.use( popper );


const graph = document.getElementById('cy');

const nodes = JSON.parse(graph.dataset.nodes);
const relationships = JSON.parse(graph.dataset.relationships);
var elements = [];

// elements.push({ data:
//                   { id: "-1",
//                     name: "Start",
//                     category: "admin",
//                     master: true
//                   },
//                   position: { x: 0, y: 0 }
//                 },
//                 );

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
                    target: relationships[i].child_id,
                    master: relationships[i].master
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
        'width': 80,
        'height': 80,
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
        'width': 80,
        'height': 80,
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
          // 'http://res.cloudinary.com/dnddzhvyj/image/upload/v1535965554/car-solid-padded.png'
          'https://res.cloudinary.com/dnddzhvyj/image/upload/v1536010981/plane-solid-padded.png'
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
        // 'color': 'black',
        'width': 80,
        'height': 80,
        'background-image': [
          'http://res.cloudinary.com/dnddzhvyj/image/upload/v1535996217/camera-retro-solid-padded-white.svg'
        ],
        'background-color': '#54B589',
        'background-fit': 'contain',
        'background-image-opacity': 0.9,
        'background-repeat': 'no-repeat',
        'border-width': 3,
        // 'border-color': '#27873C',
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
        // 'color': 'black',
        'width': 80,
        'height': 80,
        'background-image': [
          // 'http://res.cloudinary.com/dnddzhvyj/image/upload/v1535996660/car-solid-padded-white.svg'
          'https://res.cloudinary.com/dnddzhvyj/image/upload/v1536058617/plane-solid-padded-white.png'
        ],
        'background-color': '#54B589',
        'background-fit': 'contain',
        'background-image-opacity': 0.9,
        'background-repeat': 'no-repeat',
        'border-width': 3,
        // 'border-color': '#27873C',
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
        // 'color': 'black',
        'width': 80,
        'height': 80,
        'background-image': [
          'http://res.cloudinary.com/dnddzhvyj/image/upload/v1535996593/home-solid-padded-white.svg'
        ],
        'background-color': '#54B589',
        'background-fit': 'contain',
        'background-image-opacity': 0.9,
        'background-repeat': 'no-repeat',
        'border-width': 3,
        // 'border-color': '#27873C',
        'border-color': '#54B589',
        'ghost': 'yes',
        'ghost-offset-x': 0,
        'ghost-offset-y': 2,
        'ghost-opacity': 0.1,
      }
    },{
    selector: "node[category = 'Accommodation'][master = 'true'].hover",
      style: {
        'background-image': [
          'http://res.cloudinary.com/dnddzhvyj/image/upload/v1535965592/home-solid-padded.png'
        ],
      }
    },{
    selector: "node[category = 'Travel'][master = 'true'].hover",
      style: {
        'background-image': [
          // 'http://res.cloudinary.com/dnddzhvyj/image/upload/v1535965554/car-solid-padded.png'
          'https://res.cloudinary.com/dnddzhvyj/image/upload/v1536010981/plane-solid-padded.png'
        ],
      }
    },{
    selector: "node[category = 'Activity'][master = 'true'].hover",
      style: {
        'background-image': [
          'http://res.cloudinary.com/dnddzhvyj/image/upload/v1535965516/camera-retro-solid-padded.png'
        ],
      }
    },{
      selector: 'edge:unselected',
      style: {
        // label: '+',
        // 'font-family': 'FontAwesome !important',
        // 'label': '\uf00d',
        // 'font-family': 'FontAwesome',
          // 'label': '\uF007 User',
        'font-weight': '900',
        'font-size': '48',
        'color': '#F5F5F5',
        'width': 6,
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
        'font-size': '48',
        'color': '#F5F5F5',
        'width': 6,
        'line-color': 'gray',
        'line-style': 'dashed',
        'overlay-color': 'gray',
        // 'overlay-padding': 14,
        'curve-style': 'haystack',
        // 'target-arrow-color': '#BABABA',
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
      selector: 'node.hover',
      style: {
        'color': 'black',
        'text-margin-x': 6,
        'width': 88,
        'height': 88,
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
        'color': 'black',
        'text-background-color': '#FFFFFF',
        'text-background-opacity': 1,
        'text-background-padding': 7,
        'line-style': 'dotted',
        'line-color': '#5A6268',
        'width': 7,
        'transition-property': 'color, text-background-padding, line-color, width',
        'transition-duration': 150
      }
    },{
      selector: "edge[master = 'true']",
      style: {
        'color': '#F5F5F5',
        'line-color': '#6DB28C',
        'width': 7,
        'text-background-padding': 1,
        'line-style': 'solid',
      }
    },{
      selector: "edge[master = 'true'].hover",
      style: {
        'color': 'black',
        'text-background-color': '#FFFFFF',
        'text-background-opacity': 1,
        'text-background-padding': 7,
        'width': 8,
        'line-style': 'solid',
        'transition-property': 'color, text-background-padding, width',
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

// UNCOMMENT TO CONSOLE LOG A SPECIFIC NODE
cy.on('click', 'node', (e) => {
 console.log(e.target.id())
 console.log(e.target.data());
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
// cy.on('click', 'edge', () => { document.getElementById('add-node').click(); });

// Recupérer les events parent et enfant quand on ajoute un event
cy.on('mouseover', 'edge', (evt) => {
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
cy.on('mouseover', 'node', (evt) => {
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
    placement: 'left-end',
    distance: 10,
    sticky: true,
    hideOnClick: false,
    maxWidth: 300,
    theme: 'treep',
    interactive: true,
    multiple: true,
    zIndex: 1000,
    animateFill: true,
    animation: 'fade',
    arrowTransform: 'scaleX(0)',
  } ).tooltips[0];
};

// Tippy trigger via mouserover / mouseout
let tippy_var = null;

cy.on('mouseover', 'node', (e) => {
  tippy_var = makeTippy(e.target, document.getElementById('show-tippy'+ e.target.id()).innerHTML)
  tippy_var.show();
});
cy.on('mouseout', 'node', (e) => { tippy_var.hide(); });


// ADD EVENT VIA TIPPY BUTTON
var makeTippyEdge = function(edge, text){
  return tippy( edge.popperRef(), {
    html: (function(){
      const myTemplate = document.createElement('div');

      myTemplate.innerHTML = text;

      return myTemplate;
    })(),
    trigger: 'manual',
    placement: 'left',
    distance: 10,
    arrow: true,
    sticky: true,
    hideOnClick: false,
    minHeight: 60,
    maxWidth: 30,
    interactive: true,
    multiple: true,
    offset: '10, 0',
    zIndex: 1000,
    animateFill: true,
    animation: 'fade',
  } ).tooltips[0];
};

let tippy_edge = null;
cy.on('mouseover', 'edge', (e) => {
  tippy_edge = makeTippyEdge(e.target, '<p id="add-node" data-toggle="modal" data-target="#addEvent"> +</p>')
  tippy_edge.show();
});
cy.on('mouseout', 'edge', (e) => { tippy_edge.hide(); });

// CLICK ON EDGE TO SWITCH EDGE TO MASTER
cy.on('click', 'edge', (evt) => {
  let event_node_id_master = evt.target.id();
  event_node_id_master = event_node_id_master.split("-");
  let event_parent_id_master = event_node_id_master[0];
  let event_child_id_master = event_node_id_master[1];
  let parent_node = cy.elements(`node#${event_parent_id_master}`);
  let child_node = cy.elements(`node#${event_child_id_master}`);
  if (parent_node.data("master") === "true" && child_node.data("master") === "true" ) {
    // Both nodes are master = true. Do nothing
  } else if (parent_node.connectedEdges().length > child_node.connectedEdges().length) {
    // Give child node because he has less edges
    document.getElementById('switch_master'+child_node.data("id")).click();
  } else if (parent_node.connectedEdges().length < child_node.connectedEdges().length) {
    // Give parent node because he has less edges
    document.getElementById('switch_master'+parent_node.data("id")).click();
  } else {
    // Both nodes are master = false and have the same number of edges. Give parent or child node
    document.getElementById('switch_master'+child_node.data("id")).click();
  }
});

// TEST AIGUILLAGE POUR SWITCH MASTER

let node_test = cy.elements("node#121")
console.log(node_test)

let ref = node_test.popperRef();

var makeTippySwitch = function(text){
  return tippy( ref, {
    html: (function(){
      const myTemplate = document.createElement('div');

      myTemplate.innerHTML = text;

      return myTemplate;
    })(),
    trigger: 'manual',
    placement: 'bottom',
    arrow: true,
    arrowTransform: 'scaleX(0)',
    distance: 16,
    sticky: true,
    hideOnClick: false,
    minHeight: 60,
    maxWidth: 30,
    theme: 'switch',
    interactive: true,
    multiple: true,
    zIndex: 1000,
  } ).tooltips[0];
};

let tippy_switch = makeTippySwitch('<div class="arrow-container"><i class="fa fa-arrow-left"></i></div>')
// let tippy_switch = makeTippySwitch('<div class="arrow-container"><i class="fa fa-arrow-right"></i></div>')

tippy_switch.show();
