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
	console.assert(anchors.length === 2);

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

function _show(a){
	console.log(a);
	return;
}
function main(){
	var buffer = "";
	var img;
	var url = "";
	var thumbnails;
	
	thumbnails = _get_thumbnails();

	_click(_get_anchor(thumbnails[0]));
	for (var k = 0; k < thumbnails.length; k++){
		url = setTimeout(_get_source, 2000);
		buffer = setTimeout(_update_buffer, 2200, buffer, url);
		break;
		//_click(_get_anchor(thumbnails[1]));		
	}
}
