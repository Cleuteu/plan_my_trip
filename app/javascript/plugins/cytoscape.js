import cytoscape from 'cytoscape';

const cy = cytoscape({
  container: document.getElementById('cy'),
    elements: [
  // nodes
  { data: { id: 'a' } },
  { data: { id: 'b' } },
  { data: { id: 'c' } },
  { data: { id: 'd' } },
  { data: { id: 'g' } },
  { data: { id: 'h' } },
  { data: { id: 'e' } },
  { data: { id: 'f' } },

  // edges
  {
    data: {
      id: 'ab',
      source: 'a',
      target: 'b'
    }
  },
  {
    data: {
      id: 'bc',
      source: 'b',
      target: 'c'
    }
  },
  {
    data: {
      id: 'cd',
      source: 'c',
      target: 'd'
    }
  },
  {
    data: {
      id: 'ce',
      source: 'c',
      target: 'e'
    }
  },
  {
    data: {
      id: 'ef',
      source: 'e',
      target: 'f'
    }
  },
    {
  data: {
      id: 'dg',
      source: 'd',
      target: 'g'
    }
  },
    {
  data: {
      id: 'gh',
      source: 'g',
      target: 'h',
    }
  },
    {
  data: {
      id: 'fh',
      source: 'f',
      target: 'h',
    }
  }
  ],

  layout: {
    name: 'breadthfirst',
    directed: true,
    roots: '#a',
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
        'border-color': '#4469B0'
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
        'border-color': '#4469B0'
      }
    },{
      selector: 'edge:unselected',
      style: {
        'width': 20,
        'line-color': '#ccc'
      }
    },{
      selector: 'edge:selected',
      style: {
        'width': 20,
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
