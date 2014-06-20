package com.gamerisker.editor
{
	import com.gamerisker.controls.Tile;
	import com.gamerisker.event.ComponentEvent;
	import com.gamerisker.manager.TexturesManager;
	import com.gamerisker.utils.GUI;
	
	import flash.display.Bitmap;
	
	import mx.collections.ArrayList;
	
	import starling.display.Image;
	import starling.textures.Texture;

	public class TileEditor extends Editor
	{
		private var m_tile : Tile;
		private var m_enabled : Boolean;
		
		public function TileEditor()
		{
			m_type = "Tile";
			
			m_tile = new Tile;
			m_tile.addEventListener(ComponentEvent.CREATION_COMPLETE , onCreateComponent);
			addChild(m_tile);
			
			var _class : Class = TexturesManager.TileIcon;
			var bitmap : Bitmap = new _class;
			var texture : Texture = Texture.fromBitmap(bitmap);
			m_tile.setImageObject({"Icon":texture},"Icon");
		}
		
		override public function create():void
		{
			id = GUI.getInstanteIdNew();
			width = 64;
			height = 64;
			alpha = 1;
			enabled = true
		}
		
		public function get enabled():Boolean{return m_enabled;}
		public function set enabled(value:Boolean):void
		{
			m_enabled = value;
			m_tile.enabled = value;
		}
		
		override public function set alpha(value:Number):void{m_tile.alpha = value;}
		override public function get alpha():Number{return m_tile.alpha}
		
		override public function set width(value:Number):void{m_tile.width = value}
		override public function get width():Number{return m_tile.width}
		
		override public function set height(value:Number):void{m_tile.height = value}
		override public function get height():Number{return m_tile.height}
		
		override public function toCopy():Editor
		{
			var _tile : TileEditor = new TileEditor();
			_tile.xmlToComponent(new XML(toXMLString()));
			_tile.id = GUI.getInstanteIdNew();
			return _tile;
		}
		
		override public function toXMLString():String
		{
			var xml : String = '<Tile id="'
				+id+
				'" x="'
				+x+
				'" y="'
				+y+
				'" width="'
				+width+
				'" height="'
				+height+
				'" alpha="'
				+alpha+
				'" enabled="'
				+enabled+
				'"';
			
			var leng : int = childList.length;
			
			if(leng > 0)
			{
				xml += ">";
			}
			else
			{
				return xml += "/>";
			}
			
			var editor : Editor;
			for(var i:int=0;i<leng;i++)
			{
				editor = childList[i];
				xml += editor.toXMLString();
			}
			
			return xml += '</Tile>';
		}
		
		override public function toArrayList():ArrayList
		{
			var list : Array = new Array
			list[0] = {"Name" : "id" , "Value" : id};
			list[1] = {"Name" : "width" , "Value" : width};
			list[2] = {"Name" : "height" , "Value" : height};
			list[3] = {"Name" : "alpha" , "Value" : alpha};
			list[4] = {"Name" : "x" , "Value" : x};
			list[5] = {"Name" : "y" , "Value" : y};
			list[6] = {"Name" : "enabled" , "Value" : enabled};
			
			return new ArrayList(list);
		}
		
		
		override public function xmlToComponent(value:XML):Editor
		{
			width = int(value.@width);
			height = int(value.@height);
			id = GUI.getInstanteId(value.@id.toString());
			enabled = (value.@enabled.toString() == "true" ? true : false);
			alpha = Number(value.@alpha);
			x = int(value.@x);
			y = int(value.@y);
			
			return this;
		}
	}
}