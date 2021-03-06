require( GetScriptDirectory().."/item_purchase_generic" )

local tableItemsToBuy = { 
	"item_tango",
	"item_tango",
	"item_stout_shield",
	"item_enchanted_mango",
	"item_boots",
	"item_belt_of_strength",
	"item_gloves",
	"item_cloak",
	"item_ring_of_health",
	"item_ring_of_regen",
	"item_blink",
	"item_chainmail",
	"item_robe",
	"item_broadsword",
	"item_ring_of_regen",
	"item_branches",
	"item_recipe_headdress",
	"item_recipe_pipe",
	"item_ogre_axe",
	"item_mithril_hammer",
	"item_recipe_black_king_bar",
	"item_recipe_travel_boots",
	"item_boots",
	"item_recipe_sange",
	"item_ogre_axe",
	"item_belt_of_strength",
	"item_blade_of_alacrity",
	"item_boots_of_elves",
	"item_recipe_yasha",
	"item_recipe_travel_boots",
};

function ItemPurchaseThink()

	local npcBot = GetBot();
	
	if ( #tableItemsToBuy == 0 ) then
		npcBot:SetNextItemPurchaseValue( 0 );
		return;
	end

	local sNextItem = tableItemsToBuy[1];
	npcBot:SetNextItemPurchaseValue( GetItemCost( sNextItem ) );

	if ( npcBot:GetGold() >= GetItemCost( sNextItem ) ) then
		if ( sNextItem == "item_boots" ) then
			if ( BootsProtocol() ) then
				npcBot:Action_PurchaseItem( sNextItem );
				table.remove( tableItemsToBuy, 1 );
			else
--				print("awaiting boots protocol");
--				print(npcBot:GetUnitName());
			end
		elseif ( sNextItem == "item_recipe_sange" ) then
			if ( TravelsDone() ) then
				npcBot:Action_PurchaseItem( sNextItem );
				table.remove( tableItemsToBuy, 1 );
			else
--				print("awaiting travels");
--				print(npcBot:GetUnitName());
			end
		else
			npcBot:Action_PurchaseItem( sNextItem );
			table.remove( tableItemsToBuy, 1 );
		end
	end
	
	DoStuff();
	
end
