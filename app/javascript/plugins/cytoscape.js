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
    padding: 20,
    fit: true,
    // spacingFactor: 1.75,
    // height: undefined,
    },

  style: [
    {
      selector: 'node:unselected',
      style: {
        label: 'data(name)',
        'text-halign': 'right',
        'text-valign': 'center',
        'text-margin-x': 8,
        'font-size': 23,
        'text-transform': 'uppercase',
        'color': 'grey',
        'width': 60,
        'height': 60,
        'background-color': 'white',
        'background-width': 30,
        'background-height': 30,
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
        'text-halign': 'right',
        'text-valign': 'center',
        'text-margin-x': 8,
        'font-size': 23,
        'text-transform': 'uppercase',
        'color': 'gray',
        'width': 60,
        'height': 60,
        'background-color': 'white',
        'background-width': 30,
        'background-height': 30,
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
          'https://res.cloudinary.com/dnddzhvyj/image/upload/v1535720564/home-solid.svg'
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
          'https://res.cloudinary.com/dnddzhvyj/image/upload/v1535720962/car-solid.svg'
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
          'https://res.cloudinary.com/dnddzhvyj/image/upload/v1535721084/camera-retro-solid.svg'
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
          'https://res.cloudinary.com/dnddzhvyj/image/upload/v1535721084/camera-retro-solid.svg'
        ],
        'background-color': '#54B589',
        'background-width': 30,
        'background-height': 30,
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
          'https://res.cloudinary.com/dnddzhvyj/image/upload/v1535720962/car-solid.svg'
        ],
        'background-color': '#54B589',
        'background-width': 30,
        'background-height': 30,
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
          'https://res.cloudinary.com/dnddzhvyj/image/upload/v1535720564/home-solid.svg'
        ],
        'background-color': '#54B589',
        'background-width': 30,
        'background-height': 30,
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
        'background-width': 32,
        'background-height': 32,
        'background-image-opacity': 1,
        'transition-property': 'color, text-margin-x, width, height, background-color, background-width, background-height, background-image-opacity',
        'transition-timing-function': 'ease',
        'transition-duration': 150
      }
    },{
      selector: 'edge.hover',
      style: {
        label: '+',
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

cy.on('click', 'node', (evt) => { document.getElementById('show-node'+ evt.target.id()).click() });
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

cy.on('click', 'node', (evt) => {
  console.log(evt.target.id())
  let event_node_id = evt.target.id();
  let branch_parent_id_form = document.getElementById('branch_event_parent_id');
  console.log(event_node_id)
  console.log(branch_parent_id_form)
  branch_parent_id_form.value = event_node_id
} );
cy.on('click', 'edge', () => { document.getElementById('add-node').click(); });

cy.on('click', 'node', (evt) => { console.log(evt.target) });

var collection = cy.elements('node[master = "true"]');
console.log(collection);
