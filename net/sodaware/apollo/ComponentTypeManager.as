package net.sodaware.apollo
{
    
    import flash.utils.Dictionary;
    import flash.utils.describeType;
	import flash.utils.getQualifiedClassName;
	
	
    /**
     * Manages relationships between a Class and the related ComponentType
     * object.
     */
    public class ComponentTypeManager
    {
        
        /**
         * @var A dictionary of Class => ComponentType objects.
         */
        private static var componentTypes:Dictionary = new Dictionary();
        
        
        // ----------------------------------------------------------------------
        // -- Fetching ComponentType objects
        // ----------------------------------------------------------------------

        /**
         * Gets the ComponentType for a class.
         *
         * @param c The Class to lookup. 
         * @return ComponentType for the class, or null if not a valid or registered Component.
         */
        public static function getTypeFor(c:Class) : ComponentType
        {
			/*
            // TODO: Check the class extends from Component
			var _typeXML:XML = describeType(c);
			var _result:Boolean = false;
			for each (var _extClass:XML in _typeXML.factory.elements('extendsClass')) {
				if (_extClass.@type == getQualifiedClassName(Component)) {
					_result = true;
					break;
				}
			}
			if (!_result) {
				return null;
			}
			*/
            var type:ComponentType = ComponentTypeManager.componentTypes[c];
            
            if (!type) {
                type = new ComponentType();
                ComponentTypeManager.componentTypes[c] = type;
            }

            return type;
        }
        
        /**
         * Get the bit for a class's ComponentType.
         *
         * @param c The class to lookup.
         * @return The bit for this class's ComponentType, or 0 if not found.
         */
        public static function getBit(c:Class) : Number
        {
            var type:ComponentType = ComponentTypeManager.getTypeFor(c);
            return (type) ? type.getBit() : 0;
        }
        
        /**
         * Get the id for a class's ComponentType.
         *
         * @param c The class to lookup.
         * @return The id for this class's ComponentType, or 0 if not found.
         */
        public static function getId(c:Class) : int
        {
            var type:ComponentType = ComponentTypeManager.getTypeFor(c);
            return (type) ? type.getId() : 0;
        }
        
    }

}