/* global Vue */
document.addEventListener("DOMContentLoaded", function(event) { 
  var app = new Vue({
    el: '#app',
    data: { 
      games: [],
      search: '',
      selectedOrderAttr: 'popularity',
      orderAscending: false

    },
    mounted: function() {
      $.get('http://localhost:3000/api/games', function(response) {
        this.games = response;
      }.bind(this));
    },
    methods: {
      changeOrderAttr: function(attribute) {
        this.selectedOrderAttr = attribute;
      }
    },
    computed: {
      filteredGames: function() {
        result = []
        if (this.search == '') result = this.games;
        else {
          for (var i = 0; i < this.games.length; i++) {
            if (this.games[i].title.toLowerCase().indexOf(this.search.toLowerCase()) > -1) {
              result.push(this.games[i]);
            }
          }
        }
        return result.sort(function(game1, game2) {
          if (this.selectedOrderAttr == 'title') {
            if (this.orderAscending) {
              return game2[this.selectedOrderAttr].localeCompare(game1[this.selectedOrderAttr]);
            } else {
              return game1[this.selectedOrderAttr].localeCompare(game2[this.selectedOrderAttr]);
            }
          } else {
            if (this.orderAscending) {
              return game1[this.selectedOrderAttr] - game2[this.selectedOrderAttr];
            } else {
              return game2[this.selectedOrderAttr] - game1[this.selectedOrderAttr];
            }
          }
        }.bind(this));
      }
    }
  });
});