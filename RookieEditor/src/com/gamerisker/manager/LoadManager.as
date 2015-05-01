package com.gamerisker.manager
{
	import com.gamerisker.core.Define;
	import com.gamerisker.view.SetSystemWindow;
	
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	
	import spark.components.Alert;

	/**
	 *	资源管理类、提供加载服务。 目前支持0：图片，1：xml,2：二进制文件 
	 * @author GameRisker
	 * 
	 */	
	public class LoadManager
	{
		private static var file : File = new File;
		
		/**
		 *	资源路径集合 
		 */
		private static var urlGroup : Vector.<String> = new Vector.<String>;
		
		/**
		 *	回调函数集合 
		 */		
		private static var funGroup : Object = new Object;	
		
		/**
		 *	所有加载完成后回调函数 
		 */		
		private static var callFunction : Function;
		
		/**
		 *	加载完成数据的集合 
		 */		
		private static var dataGroup : Object = new Object;
		
		/**
		 *	文件类型 
		 */
		private static var typeGroup : Object = new Object;
		
		/**
		 *	当前正在加载的文件路径 
		 */
		private static var curUrl : String;
		
		/**
		 *	当前加载文件的类型 
		 */		
		private static var curType : int;
		
		/**
		 *	加载文件的总数 
		 */
		private static var loadTotal : int;
		
		/**
		 *	进度值 
		 */
		private static var progressTotal : int;

		private static var m_param : *;
		
		public function LoadManager(){}
		
		public static function Init() : void{}
		
		public static function Destory() : void
		{		
			file = null;
			dataGroup = null;
			callFunction = null;
			funGroup = null;
			urlGroup = null;
		}
		
		/**
		 *	获取指定资源 
		 * @param name
		 * @return 
		 * 
		 */		
		public static function GetSource(name : String) : *
		{
			if(dataGroup.hasOwnProperty(name))
			{
				return dataGroup[name];
			}
			return null;
		}
		
		/**
		 * 开始加载资源
		 * @param fun	所有加载完成后调用
		 * 
		 */
		public static function Start(fun : Function = null,param : * = null) : void
		{
			callFunction = fun;
			
			m_param = param;
			
			curUrl = "";
			curType = -1;
			
			loadTotal = urlGroup.length;
			
			if(loadTotal<=0)
				return;
			
			OnLoader(urlGroup.shift());
		}
		
		/**
		 *	开始加载资源 
		 * @param value				当前场景需要加载的资源总合
		 * @param fun				资源加载完成回调函数
		 * @param param				回调函数参数
		 * 
		 */		
		public static function StartScene(value : Array , fun : Function,param : Object) : void
		{
			for each(var item : Object in value)
			{
				Add(item["url"],item["type"]);
			}
			
			Start(fun,param);
		}

		/**
		 *	添加加载资源 
		 * @param url	资源路径
		 * @param type	资源类型	0:图片 1： xml 2:二进制
		 * @param id	资源ID
		 * @param callfunction	资源回调函数
		 * 
		 */
		public static function Add(url : String , type : int , callfunction : Function = null) : void
		{
			if(!dataGroup.hasOwnProperty(url))
			{
				urlGroup.push(url);
				typeGroup[url] = type;
				if(callfunction!=null)
				{
					funGroup[url] = callfunction;
				}
			}
		}
		
		/**
		 *	加载资源 
		 * @param url
		 * 
		 */
		private static function OnLoader(url : String) : void
		{
			curType = typeGroup[url];
			
			curUrl = url;
			
			var file : File = new File(url);
			
			var bytes : ByteArray = new ByteArray;
			
			var files : FileStream = new FileStream();
			
			try
			{
				files.open(file,FileMode.READ);
			}
			catch(e : Error)
			{
				Alert.show(url+"\n加载不成功!","",4,RookieEditor.getInstante().LoadBar,OpenSystemSet);
				return;
			}
			
			files.readBytes(bytes,0,files.bytesAvailable);
			
			setComplete(bytes,curType);
		}
		
		private static function OpenSystemSet(event : Event) : void
		{
			var sys : SetSystemWindow = RookieEditor.getInstante().System;
			var _x : int = (Define.fullScreenWidth - sys.width ) >> 1;
			var _y : int = (Define.fullScreenHeight - sys.height) >> 1;
			
			sys.open();
			sys.move(_x , _y);
		}
		
		protected static function setComplete(bytes : ByteArray , type : int) : void
		{
			if(type == 0 || type == 2)//图片文件 二进制文件
				dataGroup[curUrl] = bytes;
			else if(type == 1)
				dataGroup[curUrl] = bytes.readUTFBytes(bytes.length);
			
			var fun : Function = funGroup[curUrl];
			
			if(fun!=null)
			{
				fun(dataGroup[curUrl]);
			}
			
			curUrl = "";
			curType = -1;
			
			if(urlGroup.length > 0)
			{
				OnLoader(urlGroup.shift());
			}
			else
			{
				if(callFunction !=null)
					callFunction(m_param);
			}
		}
		
		
		/**
		 * 加载进度 
		 * @param event
		 * 
		 */
		private static function onProgress(event : ProgressEvent) : void
		{
			var radio : Number = 100 / loadTotal; 
			var curRadio : Number = (event.bytesLoaded / event.bytesTotal)*radio;
			
			progressTotal += curRadio;
			
		}
	}
}
