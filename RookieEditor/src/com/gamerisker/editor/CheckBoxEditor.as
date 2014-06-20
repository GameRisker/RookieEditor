package com.gamerisker.editor
{
	import com.gamerisker.controls.CheckBox;
	import com.gamerisker.controls.CheckBoxGroup;
	import com.gamerisker.event.ComponentEvent;
	import com.gamerisker.manager.SkinManager;
	import com.gamerisker.utils.GUI;
	
	import mx.collections.ArrayList;

	public class CheckBoxEditor extends Editor
	{		
		private var m_label : String;
		private var m_skin : String;
		private var m_width : int;
		private var m_height : int;
		private var m_enabled : Boolean;
		private var m_group : String;
		private var m_isCreateLabel : Boolean;
		private var m_checkBox : CheckBox;
		
		public function CheckBoxEditor()
		{
			m_type = "CheckBox";
			
			m_checkBox = new CheckBox();
			m_checkBox.addEventListener(ComponentEvent.CREATION_COMPLETE , onCreateComponent);
			addChild(m_checkBox);
			CheckBoxGroup.getInstance().addButton(m_checkBox);
		}

		override public function create():void
		{
			id = GUI.getInstanteIdNew();
			label = "CheckBox";
			skin = "default_yinxiao";
			enabled = true;
			alpha = 1;
			group = "checkboxGroup";
			m_isCreateLabel = false;
		}
		
		/**
		 * 设置文本的偏移坐标 默认是按钮内部的0 
		 */
		public function get tfOffsetY():int{return m_checkBox.tfOffsetY;}
		public function set tfOffsetY(value:int):void{m_checkBox.tfOffsetY = value;}
		
		/**
		 * 设置文本的偏移坐标 默认是按钮内部的0
		 */
		public function get tfOffsetX():int{return m_checkBox.tfOffsetX;}
		public function set tfOffsetX(value:int):void{m_checkBox.tfOffsetX = value;}

		
		public function get isCreateLabel():Boolean{return m_isCreateLabel;}
		public function set isCreateLabel(value:Boolean):void
		{
			m_isCreateLabel = value;
			m_checkBox.isCreateLabel = value;
		}
		
		public function get label():String{return m_label;}
		public function set label(value:String):void
		{
			m_label = value;
			m_checkBox.label = value;
		}

		public function get skin():String{return m_skin;}
		public function set skin(value:String):void
		{
			m_skin = value;
			m_checkBox.skinInfo = SkinManager.GetCheckBox(value);
		}
		
		override public function setStyleName(name:String, value:*):void{m_checkBox[name] = value;	}
		
		override public function set height(value : Number) : void{}
		override public function get height():Number{return m_checkBox.height;}
		
		override public function set width(value:Number):void{};
		override public function get width():Number{	return m_checkBox.width;}
				
		public function get enabled():Boolean{return m_enabled;}
		public function set enabled(value:Boolean):void
		{
			m_enabled = value;
			m_checkBox.enabled = value;
		}

		public function get group():String{return m_group;}
		public function set group(value:String):void
		{
			m_group = value;
			m_checkBox.group = value;
		}

		override public function toCopy():Editor
		{
			var _check : CheckBoxEditor = new CheckBoxEditor();
			_check.xmlToComponent(new XML(toXMLString()));
			_check.id = GUI.getInstanteIdNew();
			return _check;
		}

		override public function toXMLString() : String
		{
			var xml : String = '<CheckBox id="'
				+id+
				'" label="'
				+label+
				'" skin="'
				+skin+
				'" x="'
				+x+
				'" y="'
				+y+
				'" width="'
				+width+
				'" height="'
				+height+
				'" enabled="'
				+enabled+
				'" alpha="'
				+alpha + 
				'" group="'
				+group+
				'" isCreateLabel="'
				+isCreateLabel + 
				'" tfOffsetX="'
				+tfOffsetX + 
				'" tfOffsetY="'
				+tfOffsetY + 
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
			
			return xml += '</CheckBox>';
		}
		
		override public function toArrayList():ArrayList
		{
			var list : Array = new Array;
			list[0] = {"Name" : "id" , "Value" : id};
			list[1] = {"Name" : "label" , "Value" : label};
			list[2] = {"Name" : "skin" , "Value" : skin};
			list[3] = {"Name" : "enabled" , "Value" : enabled};
			list[4] = {"Name" : "alpha" , "Value" : alpha};
			list[5] = {"Name" : "x" , "Value" : x};
			list[6] = {"Name" : "y" , "Value" : y};
			list[7] = {"Name" : "group" , "Value" : group};
			list[8] = {"Name" : "isCreateLabel" , "Value" : isCreateLabel};
			list[9] = {"Name" : "tfOffsetX" , "Value" : tfOffsetX};
			list[10] = {"Name" : "tfOffsetY" , "Value" : tfOffsetY};
			return new ArrayList(list);
		}
		
		override public function xmlToComponent(value:XML):Editor
		{
			id = GUI.getInstanteId(value.@id.toString());
			label = value.@label.toString();
			skin = value.@skin.toString();
			enabled = (value.@enabled.toString() == "true" ? true : false);
			alpha = Number(value.@alpha);
			x = int(value.@x);
			y = int(value.@y);
			group = value.@group.toString();
			isCreateLabel = (value.@isCreateLabel.toString() == "true" ? true : false);
			tfOffsetX = int(value.@tfOffsetX);
			tfOffsetY = int(value.@tfOffsetY);
			
			return this;
		}
	}
}