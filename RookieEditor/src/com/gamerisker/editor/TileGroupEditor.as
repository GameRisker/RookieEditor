package com.gamerisker.editor
{
	import com.gamerisker.controls.List;
	import com.gamerisker.controls.TileGroup;
	import com.gamerisker.event.ComponentEvent;
	import com.gamerisker.manager.ComponentManager;
	import com.gamerisker.manager.SkinManager;
	import com.gamerisker.manager.TexturesManager;
	import com.gamerisker.utils.GUI;
	
	import flash.display.Bitmap;
	
	import mx.collections.ArrayList;
	
	import starling.display.Image;
	import starling.events.Event;
	import starling.textures.Texture;

	public class TileGroupEditor extends Editor
	{
		private var m_tileGroup : TileGroup;
		private var m_count : int;
		private var m_row : int;
		private var m_col : int;
		private var m_rowSpacing : int;
		private var m_colSpacing : int;
		private var m_boxWidth : int;
		private var m_boxHeight : int;
		private var m_enabled : Boolean;
		
		public function TileGroupEditor()
		{
			m_type = "TileGroup";
			
			m_tileGroup = new TileGroup;
			m_tileGroup.addEventListener(ComponentEvent.CREATION_COMPLETE , onCreateComponent);
			addChild(m_tileGroup);			
		}

		override public function create():void
		{
			id = GUI.getInstanteIdNew();
			count = 16;
			row = 4;
			col = 4;
			rowSpacing = 2;
			colSpacing = 2;
			boxWidth = 64;
			boxHeight = 64;
			enabled = true;
			alpha = 1;
		}
		
		override public function set width(value:Number):void{}
		override public function get width():Number{return m_tileGroup.width}
		
		override public function set height(value:Number):void{}
		override public function get height():Number{return m_tileGroup.height}
		
		override public function set alpha(value:Number):void{m_tileGroup.alpha = value}
		override public function get alpha():Number{return m_tileGroup.alpha}
		
		public function get count():int{return m_count;}
		public function set count(value:int):void
		{
			m_count = value;
			m_tileGroup.count = value;
			m_tileGroup.setListTexture(createTile(value),"Icon");
		}

		public function get row():int{return m_row;}
		public function set row(value:int):void
		{
			m_row = value;
			m_tileGroup.row = value;
		}

		public function get col():int{return m_col;}
		public function set col(value:int):void
		{
			m_col = value;
			m_tileGroup.col = value;
		}

		public function get rowSpacing():int{return m_rowSpacing;}
		public function set rowSpacing(value:int):void
		{
			m_rowSpacing = value;
			m_tileGroup.rowSpacing = value;
		}

		public function get colSpacing():int{return m_colSpacing;}
		public function set colSpacing(value:int):void
		{
			m_colSpacing = value;
			m_tileGroup.colSpacing = value;
		}

		public function get boxWidth():int{return m_boxWidth;}
		public function set boxWidth(value:int):void
		{
			m_boxWidth = value;
			m_tileGroup.boxWidth = value;
		}

		public function get boxHeight():int{return m_boxHeight;	}
		public function set boxHeight(value:int):void
		{
			m_boxHeight = value;
			m_tileGroup.boxHeight = value;
		}

		public function get enabled():Boolean{return m_enabled;}
		public function set enabled(value:Boolean):void
		{
			m_enabled = value;
			m_tileGroup.enabled = value;
		}

		override public function toCopy():Editor
		{
			var _tile : TileGroupEditor = new TileGroupEditor();
			_tile.xmlToComponent(new XML(toXMLString()));
			_tile.id = GUI.getInstanteIdNew();
			return _tile;
		}
		
		override public function toXMLString():String
		{
			var xml : String = '<TileGroup id="'
				+id+
				'" x="'
				+x+
				'" y="'
				+y+
				'" count="'
				+count+
				'" row="'
				+row+
				'" col="'
				+col+
				'" rowSpacing="'
				+rowSpacing+
				'" colSpacing="'
				+colSpacing+
				'" boxWidth="'
				+boxWidth+
				'" boxHeight="'
				+boxHeight+
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
			
			return xml += '</TileGroup>';
		}
		
		override public function toArrayList():ArrayList
		{
			var list : Array = new Array
			list[0] = {"Name" : "id" , "Value" : id};
			list[1] = {"Name" : "count" , "Value" : count};
			list[2] = {"Name" : "row" , "Value" : row};
			list[3] = {"Name" : "col" , "Value" : col};
			list[4] = {"Name" : "rowSpacing" , "Value" : rowSpacing};
			list[5] = {"Name" : "colSpacing" , "Value" : colSpacing};
			list[6] = {"Name" : "alpha" , "Value" : alpha};
			list[7] = {"Name" : "x" , "Value" : x};
			list[8] = {"Name" : "y" , "Value" : y};
			list[9] = {"Name" : "boxWidth" , "Value" : boxWidth};
			list[10] = {"Name" : "boxHeight" , "Value" : boxHeight};
			list[11] = {"Name" : "enabled" , "Value" : enabled};
			
			return new ArrayList(list);
		}
		
		
		override public function xmlToComponent(value:XML):Editor
		{
			id = GUI.getInstanteId(value.@id.toString());
			count = int(value.@count);
			row = int(value.@row);
			col = int(value.@col);
			rowSpacing = int(value.@rowSpacing);
			colSpacing = int(value.@colSpacing);
			alpha = Number(value.@alpha);
			x = int(value.@x);
			y = int(value.@y);
			boxWidth = int(value.@boxWidth);
			boxHeight = int(value.@boxHeight);
			enabled = (value.@enabled.toString() == "true" ? true : false);
			
			return this;
		}
		
		private function createTile(count : int) : Array
		{
			var list : Array = new Array;
			while(list.length<count)
				list.push(GetIcon());
			
			return list;
		}
		
		private function GetIcon() : Object
		{
			var _class : Class = TexturesManager.TileIcon;
			var bitmap : Bitmap = new _class;
			var texture : Texture = Texture.fromBitmap(bitmap);
			var icon : Object = {"Icon":texture};
			
			return icon;
		}
	}
}