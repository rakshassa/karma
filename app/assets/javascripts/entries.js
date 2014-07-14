angular.module("Raffler", 
	["ngResource", "infinite-scroll", 
	"eli.Resources", "eli.Controllers"]);

angular.module("eli.Resources", []);
angular.module("eli.Controllers", []);



angular.module("eli.Resources").factory("Entry", 
	["$resource", function ($resource) {

	return $resource("/api/entries/:id", {id: "@id"}, {update: {method: "PUT"}});
}]);



angular.module("eli.Controllers").controller("SampleCtrl", 
	["$scope", "Entry", function ($scope, Entry) {

	// move this object to a factory
	$scope.paging = {};
	$scope.paging.busy = false;	
	$scope.paging.items = Entry.query();
	$scope.paging.nextPage = function() {
		if ($scope.paging.busy) { 
			return; 
		};
		$scope.paging.busy = true;

		// asynchronous call - need to set the "page" attribute to get the subsequent pages 
		// instead of hardcoding page 2.
		var retVal = Entry.query({page: 2}, function() {
			for (var i=0; i < retVal.length; i++) {
				$scope.paging.items.push(retVal[i]);
			};
			console.log("Items = " + JSON.stringify($scope.paging.items));
			$scope.paging.busy = false;			
		});
	};

	$scope.addEntry = function() {
		entry = Entry.save($scope.newEntry);
		$scope.paging.items.push(entry);
		$scope.newEntry = {};
	};

	$scope.drawWinner = function() {

		pool = []
		angular.forEach ($scope.paging.items, function(entry) {
			if (!entry.winner) {
				pool.push(entry);
			};			
		});

		if (pool.length > 0) {
			entry = pool[Math.floor(Math.random()*pool.length)];
			entry.winner = true;
			entry.$update();
			$scope.lastWinner = entry;
		};
	};
}

]);

