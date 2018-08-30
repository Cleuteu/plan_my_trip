import cytoscape from 'cytoscape';

const graph = document.getElementById('cy');

const nodes = JSON.parse(graph.dataset.nodes);
const relationships = JSON.parse(graph.dataset.relationships);
var elements = [];

nodes.forEach((node) => {
  elements.push({ data: { id: node } },)
  });

var i = 0;
relationships.forEach((relationship) => {
  elements.push({ data:
                  { id: `${relationships[i].parent_name}` + `${relationships[i].child_name}`,
                    source: `${relationships[i].parent_name}`,
                    target: `${relationships[i].child_name}`
                  }
                },
                )
  i += 1;
  });

console.log(elements)


const cy = cytoscape({
  container: document.getElementById('cy'),
    elements:
      elements
  // [
  // // nodes
  // { data: { id: 'a' } },
  // { data: { id: 'b' } },
  // { data: { id: 'c' } },
  // { data: { id: 'd' } },
  // { data: { id: 'g' } },
  // { data: { id: 'h' } },
  // { data: { id: 'e' } },
  // { data: { id: 'f' } },

  // // edges
  // {
  //   data: {
  //     id: 'ab',
  //     source: 'a',
  //     target: 'b'
  //   }
  // },
  // {
  //   data: {
  //     id: 'bc',
  //     source: 'b',
  //     target: 'c'
  //   }
  // },
  // {
  //   data: {
  //     id: 'cd',
  //     source: 'c',
  //     target: 'd'
  //   }
  // },
  // {
  //   data: {
  //     id: 'ce',
  //     source: 'c',
  //     target: 'e'
  //   }
  // },
  // {
  //   data: {
  //     id: 'ef',
  //     source: 'e',
  //     target: 'f'
  //   }
  // },
  //   {
  // data: {
  //     id: 'dg',
  //     source: 'd',
  //     target: 'g'
  //   }
  // },
  //   {
  // data: {
  //     id: 'gh',
  //     source: 'g',
  //     target: 'h',
  //   }
  // },
  //   {
  // data: {
  //     id: 'fh',
  //     source: 'f',
  //     target: 'h',
  //   }
  // }]
,

  layout: {
    name: 'breadthfirst',
    directed: true,
    roots: '#Avion-Montreal',
    padding: 20
    },

  style: [
    {
      selector: 'node:unselected',
      style: {
        label: 'data(id)',
        'text-halign': 'right',
        'text-valign': 'center',
        'text-margin-x': 8,
        'text-transform': 'uppercase',
        'color': 'gray',
        'width': 60,
        'height': 60,
        'background-color': 'white',
        'border-width': 5,
        'border-color': '#4469B0',
        'overlay-color': '#4469B0',
        'overlay-opacity': 2,
      }
    },{
    selector: 'node:selected',
      style: {
        label: 'data(id)',
        'text-halign': 'right',
        'text-valign': 'center',
        'text-margin-x': 8,
        'text-transform': 'uppercase',
        'color': 'gray',
        'width': 60,
        'height': 60,
        'background-color': '#4469B0',
        'border-width': 5,
        'border-color': '#4469B0',
        'overlay-color': '#4469B0',
        'overlay-opacity': 2,
        'border-style': 'double'
      }
    },{
      selector: 'edge:unselected',
      style: {
        label: '+',
        // 'font-family': 'FontAwesome 5 Free',
        // 'label': '\uf055 User',
        'font-size': '32',
        'color': 'black',
        'width': 19,
        'line-color': '#ccc'
      }
    },{
      selector: 'edge:selected',
      style: {
        label: '+',
        'font-size': '32',
        'color': 'black',
        'width': 19,
        'line-color': 'lightgray'
      }
    },{
      selector: 'core',
      style: {
        'active-bg-opacity': 0
      }
    }],

  // interaction options:
  userZoomingEnabled: false,
  userPanningEnabled: false,
  boxSelectionEnabled: false,
  autoungrabify: true,

  });

  // for (var i = 0; i < 3; i++) {
  //     cy.add({
  //         data: { id: 'node' + i }
  //         }
  //     );
  //     var source = 'node' + i;
  //     cy.add({
  //         data: {
  //             id: 'edge' + i,
  //             source: source,
  //             target: (i % 2 == 0 ? 'a' : 'b')
  //         }
  //     });
  // }
  //  cy.layout({
  //      name: 'breadthfirst'
  //  }).run();

cy.on('mouseover', 'node', function (evt) {
                        $('html,body').css('cursor', 'pointer');
                    } );
cy.on('mouseout', 'node', function (evt) {
                        $('html,body').css('cursor', 'default');
                    });
cy.on('mouseover', 'edge', function (evt) {
                        $('html,body').css('cursor', 'pointer');
                    } );
cy.on('mouseout', 'edge', function (evt) {
                        $('html,body').css('cursor', 'default');
                    });
