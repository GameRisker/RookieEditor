package com.gamerisker.manager
{
	import starling.display.Stage;
	import starling.events.KeyboardEvent;

	public class KeyboardManager
	{
		
		
		private static var StarlingStage : Stage;
		private static var EventList : Array;
		
		public static const A : int = 65;
		public static const D : int = 68;
		public static const W : int = 87;
		public static const F : int = 70;
		public static const R : int = 82;
		public static const Q : int = 81;
		public static const C : int = 67;
		public static const V : int = 86;
		public static const X : int = 88;
		public static const S : int = 83;
		public static const O : int = 79;
		public static const Z : int = 90;
		public static const Y : int = 89;
		
		public static const Del : int = 46;
		public static const Esc : int = 27;
		
		public static const UP : int = 38;
		public static const DOWN : int = 40;
		public static const LEFT : int = 37;
		public static const RIGHT : int = 39;
		
		private static var isEnabled : Boolean = false;
		public function KeyboardManager()
		{
			
		}
		
		public static function Init(stage : Stage) : void
		{
			StarlingStage = stage;
			StarlingStage.addEventListener(KeyboardEvent.KEY_DOWN , OnKeyEvent);
			StarlingStage.addEventListener(KeyboardEvent.KEY_UP , OnKeyEvent);
			
			EventList = new Array;
		}
	
		public static function Destroy() : void
		{
			EventList = null;
			StarlingStage.removeEventListener(KeyboardEvent.KEY_DOWN , OnKeyEvent);
			StarlingStage.removeEventListener(KeyboardEvent.KEY_UP , OnKeyEvent);
			StarlingStage = null;
		}
		
		/**
		 *	true ： 侦听	false ： 不侦听 
		 * @param value
		 * 
		 */		
		public static function SetEnabled(value : Boolean) : void
		{
			isEnabled = value;
		}
		
		/**
		 * true ： 侦听	false ： 不侦听 
		 * @return 
		 * 
		 */		
		public static function GetEnabled() : Boolean
		{
			return isEnabled;
		}
		
		public static function AddKeyEvent(EventType : String , fun : Function , key : int , ctrl : Boolean = false) : void
		{
			var obj : Object = new Object;
			obj["type"] = EventType;
			obj["fun"] = fun;
			obj["key"] = key;
			obj["ctrl"] = ctrl;
			EventList.push(obj);
		}
		
		public static function RemoveKeyEvent(EventType : String , fun : Function) : void
		{
			for(var i : int=0;i<EventList.length;i++)
			{
				if(EventList[i]["fun"] == fun)
				{
					EventList.splice(i,1);
				}
			}
		}
		
		private static function OnKeyEvent(event : KeyboardEvent) : void
		{
			if(isEnabled)return;
			var type : String;
			var key : int;
			var ctrl : Boolean;

			for(var i : int=0;i<EventList.length;i++)
			{
				type = EventList[i]["type"];
				key = EventList[i]["key"];
				ctrl = EventList[i]["ctrl"];
//				trace(event.keyCode)
				if(type == event.type && key == event.keyCode && ctrl == event.ctrlKey)
				{
					EventList[i]["fun"](event);
				}
			}
		}
	
	}
}