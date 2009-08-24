/*    
 *    Copyright (c) 2009 Open Video Ads - Option 3 Ventures Limited
 *
 *    This file is part of the Open Video Ads VAST framework.
 *
 *    The VAST framework is free software: you can redistribute it 
 *    and/or modify it under the terms of the GNU General Public License 
 *    as published by the Free Software Foundation, either version 3 of 
 *    the License, or (at your option) any later version.
 *
 *    The VAST framework is distributed in the hope that it will be 
 *    useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
 *    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *    GNU General Public License for more details.
 *
 *    You should have received a copy of the GNU General Public License
 *    along with the framework.  If not, see <http://www.gnu.org/licenses/>.
 */
package org.openvideoads.vast.model {
	import org.openvideoads.util.NetworkResource;
	import org.openvideoads.vast.events.VideoAdDisplayEvent;
	import org.openvideoads.vast.events.OverlayAdDisplayEvent;

	/**
	 * @author Paul Schulz
	 */
	public class NonLinearVideoAd extends TrackedVideoAd {
		protected var _width:int=-1;
		protected var _height:int=-1;
		protected var _resourceType:String;
		protected var _creativeType:String;
		protected var _apiFramework:String;
		protected var _url:NetworkResource;
		protected var _codeBlock:String;
		
		public function NonLinearVideoAd() {
			super();
		}
		
		public function set width(width:*):void {
			if(typeof width == 'string') {
				_width = parseInt(width);
			}
			else _width = width;
		}
		
		public function get width():int {
			return _width;
		}
		
		public function set height(height:*):void {
			if(typeof height == 'string') {
				_height = parseInt(height);
			}
			else _height = height;
		}
		
		public function get height():int {
			return _height;
		}
		
		public function set resourceType(resourceType:String):void {
			_resourceType = resourceType.toUpperCase();
		}
		
		public function get resourceType():String {
			return _resourceType;
		}
		
		public function set creativeType(creativeType:String):void {
			_creativeType = creativeType.toUpperCase();
		}
		
		public function get creativeType():String {
			return _creativeType;
		}
		
		public function set apiFramework(apiFramework:String):void {
			_apiFramework = apiFramework;
		}
		
		public function get apiFramework():String {
			return apiFramework;
		}
		
		public function set url(url:NetworkResource):void {
			_url = url;
		}
		
		public function get url():NetworkResource {
			return _url;
		}
		
		public function set codeBlock(codeBlock:String):void {
			_codeBlock = codeBlock;
		}
		
		public function get codeBlock():String {
			return _codeBlock;
		}
		
		public function isHtml():Boolean {
			return isHtmlResourceType();
		}
		
		public function isFlash():Boolean {
			return isStaticResourceType() && isSWFCreativeType();
		}
		
		public function isImage():Boolean {
			return isStaticResourceType() && isImageCreativeType();
		}
		
		public function isHtmlResourceType():Boolean {
			if(_resourceType != null) {
				return (_resourceType.toUpperCase()	== "HTML");		
			}
			else return false;
		}
		
		public function isStaticResourceType():Boolean {
			if(_resourceType != null) {
				return (_resourceType.toUpperCase()	== "STATIC");		
			}
			else return false;			
		}

		public function isSWFCreativeType():Boolean {
			if(_creativeType != null) {
				return (_creativeType.toUpperCase() == "SWF");
			}	
			return false;
		}

		public function isTextCreativeType():Boolean {
			if(_creativeType != null) {
				return (_creativeType.toUpperCase() == "TEXT");
			}	
			return false;
		}
		
		public function isImageCreativeType():Boolean {
			return (creativeType == "JPEG" || creativeType == "GIF" || creativeType == "PNG");
		}
		
		public function hasAccompanyingVideoAd():Boolean {
			if(parentAdContainer != null) {
				return parentAdContainer.hasLinearAd();
			}
			return false;
		}
		
		public function matchesSize(width:int, height:int):Boolean {
			if(width == -1 && height == -1) {
				return true;
			}
			else {
				if(width == -1) { // just check the height
					return (height == _height);
				}
				else {
					if(width == _width) {
						return (height == _height);						
					}
					else return false;
				}
			}
		}
		
		public function start(displayEvent:VideoAdDisplayEvent):void {
			displayEvent.controller.onDisplayNonLinearOverlayAd(
			           new OverlayAdDisplayEvent(
			                     OverlayAdDisplayEvent.DISPLAY, 
			                     this,
		 						 displayEvent.customData.adSlotPosition,
		 						 displayEvent.customData.adSlotKey,
		 					 	 displayEvent.customData.adSlotAssociatedStreamIndex
			           ));
		}
		
		public function stop(displayEvent:VideoAdDisplayEvent):void {
			displayEvent.controller.onHideNonLinearOverlayAd(
			           new OverlayAdDisplayEvent(
			                     OverlayAdDisplayEvent.HIDE, 
			                     this,
		 						 displayEvent.customData.adSlotPosition,
		 						 displayEvent.customData.adSlotKey,
		 					 	 displayEvent.customData.adSlotAssociatedStreamIndex
			           ));
		}
	}
}