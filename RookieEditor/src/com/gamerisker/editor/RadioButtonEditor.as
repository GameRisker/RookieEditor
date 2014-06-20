package com.gamerisker.editor
{
	import com.gamerisker.controls.RadioButton;
	import com.gamerisker.controls.RadioButtonGroup;
	import com.gamerisker.event.ComponentEvent;
	import com.gamerisker.manager.SkinManager;
	import com.gamerisker.utils.GUI;
	
	import mx.collections.ArrayList;

	public class RadioButtonEditor extends Editor
	{
		protected static const RADIOBUTTONGROUP : RadioButtonGroup = new RadioButtonGroup;
		
		private var m_radio : RadioButton;
		private var m_skin : String;
		private var m_width : int;
		private var m_height : int;
		private var m_enabled : Boolean;
		private var m_group : String;
		private var m_label : String;
		private var m_isCreateLabel : Boolean;

		public function RadioButtonEditor()
		{
			m_type = "RadioButton";
			
			m_radio = new RadioButton;
			m_radio.addEventListener(ComponentEvent.CREATION_COMPLETE , onCreateComponent);
			addChild(m_radio);
			
			RADIOBUTTONGROUP.addButton(m_radio);
		}
		
		override public function create():void
		{
			id = GUI.getInstanteIdNew();
			label = "RadioButton";
			skin = "RadioButtonDefault";
			enabled = true;
			alpha = 1;
			group = "RadioButtonGroup";
			isCreateLabel = true;
		}
		/**
		 * 设置文本的偏移坐标 默认是按钮内部的0 
		 */
		public function get tfOffsetY():int{return m_radio.tfOffsetY;}
		public function set tfOffsetY(value:int):void{m_radio.tfOffsetY = value;}
		
		/**
		 * 设置文本的偏移坐标 默认是按钮内部的0
		 */
		public function get tfOffsetX():int{return m_radio.tfOffsetX;}
		public function set tfOffsetX(value:int):void{m_radio.tfOffsetX = value;}
		
		public function get isCreateLabel():Boolean{return m_isCreateLabel;}
		public function set isCreateLabel(value:Boolean):void
		{
			m_isCreateLabel = value;
			m_radio.isCreateLabel = value;
		}
		
		public function get skin():String{return m_skin;}
		public function set skin(value:String):void
		{
			m_skin = value;
			m_radio.skinInfo = SkinManager.GetRadioButton(value);
		}

		override public function get width():Number{return m_radio.width}
		override public function set width(value:Number):void{}
		
		override public function get height():Number{return m_radio.height}
		override public function set height(value:Number):void{}
		
		public function get label():String{return m_label;}
		public function set label(value:String):void
		{
			m_label = value;
			m_radio.label = value;
		}

		public function get enabled():Boolean{return m_enabled;}
		public function set enabled(value:Boolean):void
		{
			m_enabled = value;
			m_radio.enabled = value;
		}

		public function get group():String{return m_group;}
		public function set group(value:String):void
		{
			m_group = value;
			m_radio.group = value;
		}

		override public function toCopy():Editor
		{
			var _radio : RadioButtonEditor = new RadioButtonEditor();
			_radio.xmlToComponent(new XML(toXMLString()));
			_radio.id = GUI.getInstanteIdNew();
			return _radio;
		}
		
		override public function toXMLString():String
		{
			var xml : String = '<RadioButton id="'
				+id+
				'" x="'
				+x+
				'" y="'
				+y+
				'" label="'
				+label+
				'" skin="'
				+skin+
				'" enabled="'
				+enabled+
				'" group="'
				+group+
				'" alpha="'
				+alpha + 
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
			
			return xml += '</RadioButton>';
		}
		
		override public function toArrayList():ArrayList
		{
			var list : Array = new Array
			list[0] = {"Name" : "id" , "Value" : id};
			list[1] = {"Name" : "label" , "Value" : label};
			list[2] = {"Name" : "skin" , "Value" : skin};
			list[3] = {"Name" : "alpha" , "Value" : alpha};
			list[4] = {"Name" : "x" , "Value" : x};
			list[5] = {"Name" : "y" , "Value" : y};
			list[6] = {"Name" : "enabled" , "Value" : enabled};
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
			group = value.@group.toString();
			alpha = Number(value.@alpha);
			x = int(value.@x);
			y = int(value.@y);
			isCreateLabel = (value.@isCreateLabel.toString() == "true" ? true : false);
			tfOffsetX = int(value.@tfOffsetX);
			tfOffsetY = int(value.@tfOffsetY);
			return this;
		}
	}
}