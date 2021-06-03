function _get_thumbnails(){
	var nodes = $("#islrg").childNodes; //should be 2
	console.assert(nodes.length === 2);

	var node;
	for (var k = 0; k < 2; k++){
		node = nodes[k];
		if (node.className === "islrc"){
			return node.childNodes;
		}
	}
}

function _get_anchor(thumbnail){
	var anchors = thumbnail.childNodes;

	var anchor;
	var attributesNames;

	for (var k=0; k<anchors.length; k++){
		anchor = anchors[k];
		console.assert(anchor.getAttributeNames().includes("jsname"));
		if (anchor.getAttribute("jsname") === "sTFXNd"){
			return anchor;
		}
	}
}

function _click(anchor){
	anchor.click();
}

function _get_source(){
	var image;
	image = $("img[jsname='HiaYvf']");
	return image.getAttribute("src");
}

function _update_buffer(buffer, url){
	return buffer.concat(url).concat("\n");
}

function _unclick(){
	return;
}

function _ret(a){
	return a;
}

function _get_image(){
	myPromise = new Promise(function (resolve, reject){
		setTimeout(() => resolve(_get_source()), 3000);
	});

	myPromise.then(function(value){
		console.log(value);
		console.log(2);
	});
}

function main(){
	var buffer = "";
	var img;
	var url = "";
	var thumbnails;
	var myPromise;
	
	thumbnails = _get_thumbnails();

	_click(_get_anchor(thumbnails[0]));
}
