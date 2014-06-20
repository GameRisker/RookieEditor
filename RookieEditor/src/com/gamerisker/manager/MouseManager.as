package com.gamerisker.manager
{
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	
	import starling.display.DisplayObject;
	import starling.display.Stage;
	import starling.events.Touch;
	import starling.events.TouchEvent;

	public class MouseManager
	{
		private static var FlashStage : flash.display.Stage;
		private static var StarlingStage : starling.display.Stage;
		
		private static var EventList : Dictionary;
		private static var FunctionList : Dictionary;
		
		private static var m_band : flash.display.DisplayObject;
		
		private static var m_name : String;
		public function MouseManager()
		{
			
		}
		
		public static function Init(stg : flash.display.Stage , starstg : starling.display.Stage) : void
		{
			EventList = new Dictionary;
			FunctionList = new Dictionary;
			
			FlashStage = stg;
			StarlingStage = starstg;
			
			FlashStage.addEventListener(MouseEvent.CLICK , OnStageEvent);
			FlashStage.addEventListener(MouseEvent.MOUSE_MOVE , OnStageEvent);
			FlashStage.addEventListener(MouseEvent.MOUSE_DOWN , OnStageEvent);
			FlashStage.addEventListener(MouseEvent.MOUSE_UP , OnStageEvent);
			StarlingStage.addEventListener(TouchEvent.TOUCH , OnStarlingClick);
		}
		
		/**
		 *	添加绑定 
		 * @param child
		 * @param name
		 * 
		 */		
		public static function AddBand(child : flash.display.DisplayObject,name : String) : void
		{
			if(m_band!=null)
			{
				RemoveBand();
			}
			m_band = child;
			m_name = name;
			FlashStage.addChild(child);
		}
		
		/**
		 *	移除绑定 
		 * 
		 */		
		public static function RemoveBand() : void
		{
			FlashStage.removeChild(m_band);
			m_band = null;
			m_name = null;
		}
		
		/**
		 *	获取鼠标跟随的对象实例名称 
		 * @return 
		 * 
		 */		
		public static function GetName() : String
		{
			return m_name;
		}
		
		/**
		 *	获取鼠标跟随的对象 
		 * @return 
		 * 
		 */		
		public static function GetBand() : flash.display.DisplayObject
		{
			return m_band;
		}
		
		/**
		 *	添加Starling事件 
		 * @param EventType
		 * @param child
		 * @param fun
		 * 
		 */		
		public static function AddTouch(EventType : String , child : starling.display.DisplayObject , fun : Function) : void
		{
			var list : Array = EventList[child];
			var funList : Array = FunctionList[child];
			
			if(list == null)
			{
				EventList[child] = [EventType];
				FunctionList[child] = [fun];
			}
			else if(list.indexOf(EventType) == -1)
			{
				list.push(EventType);
				funList.push(fun);
			}
			else
			{
				throw(new Error("添加TouchEvent出错:" + EventType + child));
			}
		}
		
		/**
		 *	检查是否已经监听 
		 * @param EventType
		 * @param child
		 * @return 
		 * 
		 */		
		public static function hasTouch(EventType : String , child : starling.display.DisplayObject) : Boolean
		{
			if(child != null)
			{
				var list : Array = EventList[child];
				var funList : Array = FunctionList[child];
				
				if(list == null)
				{
					return false;
				}
				else if(list.indexOf(EventType) == -1)
				{
					return false;
				}
				else
				{
					return true;
				}
			}
			
			return true;
		}
		
		/**
		 *	移除Staring事件 
		 * @param EventType
		 * @param child
		 * 
		 */		
		public static function RemoveTouch(EventType : String , child : starling.display.DisplayObject) : void
		{
			if(child == null)
				throw(new Error("RemoveTouch child is null"));
			
			var list : Array = EventList[child];
			var funList : Array = FunctionList[child];
			var index : int;
			
			if(list != null)
			{
				index = list.indexOf(EventType);
				list.splice(index,1);
				funList.splice(index,1);
				
				if(list.length == 0)
				{
					EventList[child] = null;
					delete EventList[child];
				}
				
				if(funList.length == 0)
				{
					FunctionList[child] = null;
					delete FunctionList[child];
				}
			}
		}
		
		public static function clear() : void
		{
			for(var child : * in EventList)
				delete EventList[child]
			for(child in FunctionList)
				delete FunctionList[child];
		}

		private static function OnStageEvent(event : MouseEvent) : void
		{
			var name : String = event.type + event.target.name;
			
			if(event.type == MouseEvent.MOUSE_MOVE && m_band != null)
			{
				m_band.x = event.stageX - m_band.width / 2;
				m_band.y = event.stageY - m_band.height / 2;
			}
		}
		
		private static function OnStarlingClick(event : starling.events.TouchEvent) : void
		{
			var touch : Touch;
			var eventType : String;
			
			var child : DisplayObject = getChildEvent(event.target as DisplayObject);
			
			if(child == null)
				return;
			
			var list : Array = EventList[child];
			var funList : Array = FunctionList[child];
			
			for(var i:int=0;i<list.length;i++)
			{
				eventType = list[i];
				touch = event.getTouch(child,eventType);
				if(touch==null)continue;
				funList[i](event,touch,child);
			}
//			for(var child : * in FunctionList)
//			{
//				list = EventList[child];
//				funList = FunctionList[child];
//
//				if(DisplayObject(child) == DisplayObject(event.target).parent)
//				{
//					for(var i:int=0;i<list.length;i++)
//					{
//						eventType = list[i];
//						touch = event.getTouch(child,eventType);
//						if(touch==null)continue;
//						funList[i](event,touch,child);
//					}
//				}
//			}
		}
		
		private static function getChildEvent(target : DisplayObject) : DisplayObject
		{
			if(target && target.parent!=null)
			{
				for(var child : * in FunctionList)
				{
					if(child == target)
					{
						return child;
					}
				}
				return getChildEvent(target.parent);
			}
			else
			{
				return null;
			}
			
			return null;
		}
		
	}
}