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
        'width': 56,
        'height': 56,
        'background-color': '#4DABE4',
        'border-width': 4,
        'border-color': 'gray',
        'border-style': 'double',
        'overlay-color': 'gray',
        'overlay-opacity': 2,
        'ghost': 'yes',
        'ghost-offset-x': 0,
        'ghost-offset-y': 1,
        'ghost-opacity': 0.1,
        'transition-property': 'overlay-opacity, background-color',
        'transition-duration': 100
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
        'width': 56,
        'height': 56,
        'background-color': '#2696DD',
        'border-width': 4,
        'border-color': 'gray',
        // 'border-style': 'double'
        'overlay-color': 'gray',
        'overlay-opacity': 0,
        'ghost': 'yes',
        'ghost-offset-x': 0,
        'ghost-offset-y': 1,
        'ghost-opacity': 0.1,
        'transition-property': 'overlay-opacity, background-color',
        'transition-duration': 200
      }
    },{
      selector: 'edge:unselected',
      style: {
        label: '+',
        // 'font-family': 'Font Awesome Free 5',
        // 'font-weight': '900',
        // 'label': '\uf055',
        'font-size': '30',
        'color': 'black',
        'width': 13,
        'line-color': 'lightgray',
        'overlay-color': 'gray',
        'overlay-padding': 14,
        'overlay-opacity': 2,
        'curve-style': 'bezier',
        'target-arrow-color': 'lightgray',
        'target-arrow-shape': 'vee',
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
        label: '+',
        'font-size': '30',
        'color': 'black',
        'width': 13,
        'line-color': '#BABABA',
        'overlay-padding': 14,
        'overlay-color': 'gray',
        'overlay-opacity': 0,
        'curve-style': 'bezier',
        'target-arrow-color': '#BABABA',
        'target-arrow-shape': 'vee',
        'arrow-scale': 1,
        'ghost': 'yes',
        'ghost-offset-x': 0,
        'ghost-offset-y': 1,
        'ghost-opacity': 0.1,
        'transition-property': 'line-color, target-arrow-color, overlay-opacity',
        'transition-duration': 100
      },
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

cy.on('mouseover', 'node', () =>$('html,body').css('cursor', 'pointer'));
cy.on('mouseout', 'node', () =>$('html,body').css('cursor', 'default'));

cy.on('mouseover', 'edge', function (evt) {
                        $('html,body').css('cursor', 'pointer');
                    } );
cy.on('mouseout', 'edge', function (evt) {
                        $('html,body').css('cursor', 'default');
                    });

cy.on('click', 'node', function(evt){
  // alert("");
});
cy.on('click', 'edge', function(evt){
  const modalBtn = document.getElementById('modal-btn');
  modalBtn.click();
});


