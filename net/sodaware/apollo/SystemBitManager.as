package net.sodaware.apollo
{
    
    import flash.utils.Dictionary;

    /**
     * Manages the System bit lookup system.
     */
    public class SystemBitManager
    {
        /**
         * @var The next available System bit.
         */
        private static var nextAvailableBit:Number = 1;
        
        /**
         * @var Dictionary of System class => bit
         */
        private static var systemBits:Dictionary = new Dictionary();
        
        
        // ----------------------------------------------------------------------
        // -- Fetching bits
        // ----------------------------------------------------------------------
        
        /**
         * Get the bit for a System class. If no bit is set, assign one.
         *
         * @param esType The System class to lookup.
         * @return The retrieved bit.
         */
        public static function getBitFor(esType:Class) : Number
        {
            // Get bit for this system
            var bit:Number = SystemBitManager.systemBits[esType];
            
            // If not set, generate a bit and set it
            if (!bit) {
                bit = nextAvailableBit;
                SystemBitManager.nextAvailableBit = SystemBitManager.nextAvailableBit << 1;
                SystemBitManager.systemBits[esType] = bit;
            }
            
            return bit;
        }
        
    }

}