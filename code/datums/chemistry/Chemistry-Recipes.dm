///////////////////////////////////////////////////////////////////////////////////
#define get_fucked_clarks if (istype(my_atom, /obj/critter/domestic_bee)) return my_atom.visible_message("<span style=\"color:red\">[my_atom] burps.</span>"); if (istype(my_atom, /obj/item/reagent_containers/food/snacks/ingredient/honey)) return
#define CRITTER_REACTION_LIMIT 50
#define fucking_critter_bullshit_fuckcrap_limiter(x) if (x > CRITTER_REACTION_LIMIT) return; else x += 1

datum
	chemical_reaction
		var/name = null
		var/id = null
		var/result = null
		var/list/required_reagents = new/list()
		var/list/inhibitors = list()
		var/instant = 1

		var/min_temperature = -INFINITY		//Will not react if below this
		var/required_temperature = -1 //Not used by default. -1 = not used. //Positive values for reaction to take place when hotter than value, negative to take place when cooler than abs(value)
		var/max_temperature = INFINITY //Will not react if above this


		var/reaction_speed = 5 // units produced per second
		var/base_reaction_temp = T20C
		var/reaction_temp_divider = 10

		// Logs the contents of the reagent holder's container in addition to the reaction itself.
		// Used for foam and smoke (Convair880).
		var/special_log_handling = 0

		var/result_amount = 0
		var/mix_phrase = "The solution begins to bubble."
		var/mix_sound = 'sound/effects/bubbles.ogg'
		var/drinkrecipe = 0
		var/consume_all = 0 //If set to 1, the recipe will consume ALL of its components instead of just proportional parts.

		proc/on_reaction(var/datum/reagents/holder, var/created_volume)
			return

		//I recommend you set the result amount to the total volume of all components.

		// the following three recipes should stop most of the nonsense with pyrosium lagging things to shit, hopefully??
		// if not yell at me to code better - haine

		no_pyrosium_foam
			name = "no pyrosium foam"
			id = "no_pyrosium_foam"
			instant = 1
			required_reagents = list("thalmerite" = 1, "fluorosurfactant" = 1, "water" = 1)
			mix_phrase = "The mixture burns away into nothing!"
			on_reaction(var/datum/reagents/holder, var/created_volume)
				if (holder)
					holder.del_reagent("thalmerite")
					holder.del_reagent("fluorosurfactant")
					holder.del_reagent("water")
				return
/*
		no_lumen_foam // Lumen reagent was removed.
			name = "no lumen foam"
			id = "no_lumen_foam"
			instant = 1
			required_reagents = list("lumen" = 1, "fluorosurfactant" = 1, "water" = 1)
			mix_phrase = "The mixture burns away into nothing!"
			on_reaction(var/datum/reagents/holder, var/created_volume)
				if (holder)
					holder.del_reagent("lumen")
					holder.del_reagent("fluorosurfactant")
					holder.del_reagent("water")
				return
*/
		no_pyrosium_smoke
			name = "no pyrosium smoke"
			id = "no_pyrosium_smoke"
			instant = 1
			required_reagents = list("thalmerite" = 1, "sugar" = 1, "phosphorus" = 1, "potassium" = 1)
			mix_phrase = "The mixture burns away into nothing!"
			on_reaction(var/datum/reagents/holder, var/created_volume)
				if (holder)
					holder.del_reagent("thalmerite")
					holder.del_reagent("sugar")
					holder.del_reagent("phosphorus")
					holder.del_reagent("potassium")
				return

		no_pyrosium_smoke2
			name = "no pyrosium smoke 2"
			id = "no_pyrosium_smoke2"
			instant = 1
			required_reagents = list("thalmerite" = 1, "smokepowder" = 1)
			mix_phrase = "The mixture burns away into nothing!"
			on_reaction(var/datum/reagents/holder, var/created_volume)
				if (holder)
					holder.del_reagent("thalmerite")
					holder.del_reagent("smokepowder")
				return

		nitroglycerin_violent_reaction
			name = "Nitroglycerin Foam"
			id = "nitroglycerin_foam"
			result = "nitroglycerin_foam"
			required_reagents = list("nitroglycerin" = 1, "fluorosurfactant" = 1)
			instant = 1
			mix_phrase = "The substance violently detonates!"
			mix_sound = 'sound/effects/bang.ogg'
			on_reaction(var/datum/reagents/holder, var/created_volume)
				var/atom/my_atom = holder.my_atom
				get_fucked_clarks
				explosion(my_atom, get_turf(my_atom), 0, 1, 4, 5)
				return

		nitroglycerin_violent_reaction2
			name = "Nitroglycerin Smoke"
			id = "nitroglycerin_smoke"
			result = "nitroglycerin_smoke"
			required_reagents = list("nitroglycerin" = 1, "potassium" = 1, "phosphorus" = 1, "sugar" = 1)
			instant = 1
			mix_phrase = "The substance violently detonates!"
			mix_sound = 'sound/effects/bang.ogg'
			on_reaction(var/datum/reagents/holder, var/created_volume)
				var/atom/my_atom = holder.my_atom
				get_fucked_clarks
				explosion(my_atom, get_turf(my_atom), 0, 1, 4, 5)
				return

		nitroglycerin_violent_reaction3
			name = "Nitroglycerin Smoke (powder)"
			id = "nitroglycerin_smoke"
			result = "nitroglycerin_smoke"
			required_reagents = list("nitroglycerin" = 1, "smokepowder" = 1)
			instant = 1
			mix_phrase = "The substance violently detonates!"
			mix_sound = 'sound/effects/bang.ogg'
			on_reaction(var/datum/reagents/holder, var/created_volume)
				var/atom/my_atom = holder.my_atom
				get_fucked_clarks
				explosion(my_atom, get_turf(my_atom), 0, 1, 4, 5)
				return

		// also no more fermid foams, fu nerds tOt

		no_fermid_foam
			name = "no fermid foam"
			id = "no_fermid_foam"
			instant = 1
			required_reagents = list("ants" = 1, "mutagen" = 1, "aranesp" = 1, "booster_enzyme" = 1, "fluorosurfactant" = 1, "water" = 1)
			mix_phrase = "A single fermid leg reaches out of the container. It flips you off. Somehow."
			mix_sound = 'sound/misc/trombone.ogg'
			on_reaction(var/datum/reagents/holder, var/created_volume)
				if (holder)
					holder.del_reagent("ants")
					holder.del_reagent("mutagen")
					holder.del_reagent("aranesp")
					holder.del_reagent("booster_enzyme")
					holder.del_reagent("fluorosurfactant")
					holder.del_reagent("water")
				return

		booster_enzyme
			name = "Booster Enzyme"
			id = "booster_enzyme"
			result = "booster_enzyme"
			required_reagents = list("diethylamine" = 1, "ethanol" = 1, "sulfur" = 1, "carbon" = 1, "hydrogen" = 1, "oxygen" = 1, "strange_reagent" = 1)
			required_temperature = T0C + 100
			result_amount = 4
			mix_phrase = "The solution shows signs of life, forming shapes!"

		denatured_enzyme
			name = "Denatured Enzyme"
			id = "denatured_enzyme"
			result = "denatured_enzyme"
			required_reagents = list("booster_enzyme" = 1)
			required_temperature = T0C + 150
			result_amount = 1
			mix_phrase = "The solution burns, leaving behind a lifeless mass!"

		water_holy
			name = "Holy Water"
			id = "water_holy"
			result = "water_holy"
			required_reagents = list("water" = 1, "mercury" = 1, "wine" = 1)
			result_amount = 3
			mix_phrase = "The water somehow seems purified. Or maybe defiled."

		calomel
			name = "Calomel"
			id = "calomel"
			result = "calomel"
			required_reagents = list("mercury" = 1, "chlorine" = 1)
			required_temperature = T0C + 100
			result_amount = 1
			mix_phrase = "Stinging vapors rise from the solution."

		/*tricalomel
			name = "Pentetic Acid"
			id = "tricalomel"
			result = "tricalomel"
			required_reagents = list("ethanol" = 1, "diethylamine" = 1, "ammonia" = 1, "cyanide" = 1)
			result_amount = 3
			mix_phrase = "The mixture bubbles slightly before settling down."*/

		synthflesh
			name = "Synthetic Flesh"
			id = "synthflesh"
			result = "synthflesh"
			required_reagents = list("blood" = 1, "carbon" = 1, "stypic_powder" = 1)
			result_amount = 3
			mix_phrase = "The mixture knits together into a fibrous, bloody mass."
			mix_sound = 'sound/effects/blobattack.ogg'

		meat_slurry
			name = "Meat Slurry"
			id = "meat_slurry"
			result = "meat_slurry"
			required_reagents = list("blood" = 1, "cornstarch" = 1)
			result_amount = 2
			mix_phrase = "The mixture congeals into a bloody mass."
			mix_sound = 'sound/effects/blobattack.ogg'

		beff
			name = "Beff"
			id = "beff"
			result = "beff"
			required_reagents = list("meat_slurry" = 1, "badgrease" = 2, "plasma" = 1)
			result_amount = 4
			mix_phrase = "The mixture solidifies, taking a crystalline appearance."
			mix_sound = 'sound/effects/blobattack.ogg'

		enriched_msg
			name = "Enriched MSG"
			id = "enriched_msg"
			result = "enriched_msg"
			required_reagents = list("msg" = 1, "milk" = 1, "salt" = 1, "chickensoup" = 1, "sugar" = 1,\
			"cheese" = 1,/* "anima" = 1, */"grease" = 1, "water_holy" = 1, "pepperoni" = 1, "beff" = 1,\
			"juice_tomato" = 1, "ectocooler" = 1)
			//required_temperature = T0C + 400 // commenting out for now so you can actually make this, maybe
			result_amount = 12
			mix_phrase = "The mixture reduces into a fine crystalline powder and an unbelievably delicious smell wafts upwards."

/*		argine
			name = "Argine"
			id = "argine"
			result = "argine"
			required_temperature = -25
			required_reagents = list("ethanol" = 1, "silicon" = 1, "water" = 1)
			result_amount = 3 */

		infernite
			name = "Chlorine Triflouride"
			id = "infernite"
			result = "infernite"
			required_temperature = T0C + 150
			required_reagents = list("chlorine" = 1, "fluorine" = 3)
			result_amount = 2
			mix_phrase = "The mixture gives off significant heat."

			on_reaction(var/datum/reagents/holder, var/created_volume)
				tfireflash(holder.my_atom, 1, 7000)
				return

		/*foof
			name = "FOOF"
			id = "foof"
			result = "foof"
			required_temperature = 600
			required_reagents = list("oxygen" = 1, "flourine" = 1, "stabiliser" = 1)
			result_amount = 1
			mix_phrase = "The mixture violently erupts and seethes with fire."

			on_reaction(var/datum/reagents/holder, var/created_volume)
				fireflash(holder.my_atom, 3)
				return*/


		thalmerite
			name = "Pyrosium"
			id = "thalmerite"
			result = "thalmerite"
			required_reagents = list("plasma" = 1, "radium" = 1, "phosphorus" = 1)
			result_amount = 3
			mix_phrase = "The resultant gel begins to emit significant heat."


		aranesp
			name = "Aranesp"
			id = "aranesp"
			result = "aranesp"
			required_reagents = list("atropine" = 1, "epinephrine" = 1, "insulin" = 1)
			result_amount = 3

		soriumstable
			name = "Stable Sorium"
			id = "soriumstable"
			result = "sorium"
			required_reagents = list("mercury" = 1, "carbon" = 1, "nitrogen" = 1,"oxygen" = 1, "stabiliser" = 1)
			result_amount = 4
			mix_phrase = "The mixture pops and crackles before settling down."

		ldmatterstable
			name = "Stable Liquid Dark Matter"
			id = "ldmatterstable"
			result = "ldmatter"
			required_reagents = list("plasma" = 1, "radium" = 1, "carbon" = 1, "stabiliser" = 1)
			result_amount = 4
			mix_phrase = "The begins to glow in a dark purple."

		sorium
			name = "Sorium"
			id = "sorium"
			required_reagents = list("mercury" = 1, "carbon" = 1, "nitrogen" = 1,"oxygen" = 1)
			inhibitors = list("stabiliser")
			instant = 1
			mix_phrase = "The mixture explodes with a big bang."
			on_reaction(var/datum/reagents/holder, var/created_volume)
				var/atom/source = get_turf(holder.my_atom)
				new/obj/decal/shockwave(source)
				playsound(source, 'sound/weapons/flashbang.ogg', 25, 1)
				for(var/atom/movable/M in view(2+ (created_volume > 30 ? 1:0), source))
					if(M.anchored || M == source || M.throwing) continue
					spawn(0) M.throw_at(get_edge_cheap(source, get_dir(source, M)),  20 + round(created_volume * 2), 1 + round(created_volume / 10))
				return

		ldmatter
			name = "Liquid Dark Matter"
			id = "ldmatter"
			required_reagents = list("plasma" = 1, "radium" = 1, "carbon" = 1)
			inhibitors = list("stabiliser")
			instant = 1
			mix_phrase = "The mixture implodes suddenly."
			on_reaction(var/datum/reagents/holder, var/created_volume)
				ldmatter_reaction(holder, created_volume)
				return

/*
		merculite
			name = "Merculite"
			id = "merculite"
			result = "laffo"
			required_temperature = 303
			required_reagents = list("napalm" = 1, "thermite" = 1, "fuel" = 1)
			result_amount = 1 */

		bilk
			name = "Bilk"
			id = "bilk"
			result = "bilk"
			required_reagents = list("milk" = 1, "beer" = 1)
			result_amount = 2
			mix_phrase = "The mixture turns an offensive brown colour and begins fizzing."
			mix_sound = 'sound/misc/drinkfizz.ogg'
			drinkrecipe = 1

		chocolate_milk
			name = "Chocolate Milk"
			id = "chocolate milk"
			result = "chocolate_milk"
			required_reagents = list("milk" = 1, "chocolate" = 1)
			result_amount = 2
			mix_phrase = "The mixture turns a nice brown color."
			mix_sound = 'sound/misc/drinkfizz.ogg'
			drinkrecipe = 1

		strawberry_milk
			name = "Strawberry Milk"
			id = "strawberry milk"
			result = "strawberry_milk"
			required_reagents = list("milk" = 1, "juice_strawberry" = 1)
			result_amount = 2
			mix_phrase = "The mixture turns a nice pink color."
			mix_sound = 'sound/misc/drinkfizz.ogg'
			drinkrecipe = 1

		lipolicide // COGWERKS REPLACEMENT NOTES: FEN-PHEN? EPHEDRINE?
			name = "Lipolicide"
			id = "lipolicide"
			result = "lipolicide"
			required_reagents = list("ephedrine"=1,"diethylamine"=1,"mercury"=1)
			result_amount = 2
			mix_phrase = "A vague smell similar to tofu rises from the mixture."

		cheese
			name = "Cheese"
			id = "cheese"
			result = "cheese"
			required_reagents = list("milk" = 1, "vomit" = 1)
			result_amount = 1
			mix_phrase = "The mixture curdles up."
			on_reaction(var/datum/reagents/holder)
				var/location = get_turf(holder.my_atom)
				for(var/mob/M in all_viewers(8, location))
					boutput(M, "<span style=\"color:blue\">A faint cheesy smell drifts through the air...</span>")
				return

		gcheese
			name = "Weird Cheese"
			id = "gcheese"
			result = "gcheese"
			required_reagents = list("milk" = 1, "gvomit" = 1)
			result_amount = 1
			mix_phrase = "The disgusting mixture sloughs together horribly, emitting a foul stench."
			mix_sound = 'sound/misc/diarrhea.ogg'
			on_reaction(var/datum/reagents/holder)
				var/location = get_turf(holder.my_atom)
				for(var/mob/M in all_viewers(8, location))
					boutput(M, "<span style=\"color:red\">A horrible smell assaults your nose! What in space is it?</span>")
				return

		lemonade
			name = "Lemonade"
			id = "lemonade"
			result = "lemonade"
			required_reagents = list("juice_lemon" = 3, "sugar" = 1)
			result_amount = 4
			mix_phrase = "The sugar dissolves into the lemon juice."
			mix_sound = 'sound/misc/drinkfizz.ogg'
			drinkrecipe = 1

		halfandhalf
			name = "Half and Half"
			id = "halfandhalf"
			result = "halfandhalf"
			required_reagents = list("lemonade" = 1, "tea" = 1)
			result_amount = 2
			mix_phrase = "The tea and lemonade combine without much fuss."
			mix_sound = 'sound/misc/drinkfizz.ogg'
			drinkrecipe = 1

		halfandhalf/halfandhalf2
			id = "halfandhalf2"
			required_reagents = list("juice_lemon" = 1, "sweet_tea" = 1)
			result_amount = 2

		halfandhalf/halfandhalf3
			id = "halfandhalf3"
			required_reagents = list("lemonade" = 1, "sweet_tea" = 1)
			result_amount = 2

		eggnog
			name = "Eggnog"
			id = "eggnog"
			result = "eggnog"
			required_reagents = list("egg" = 1, "milk" = 1, "sugar" = 1)
			result_amount = 3
			mix_phrase = "The eggs nog together. Pretend that \"nog\" is a verb."
			drinkrecipe = 1

		sweet_tea
			name = "Sweet Tea"
			id = "sweet_tea"
			result = "sweet_tea"
			required_reagents = list("sugar" = 1, "tea" = 1)
			result_amount = 2
			mix_phrase = "The tea sweetens. Visually. Somehow."
			mix_sound = 'sound/misc/drinkfizz.ogg'
			drinkrecipe = 1

		honey_tea
			name = "tea"
			id = "honey_tea"
			result = "honey_tea"
			required_reagents = list("honey" = 1, "tea" = 1)
			result_amount = 2
			mix_phrase = "The tea somehow smells even nicer than before."
			mix_sound = 'sound/misc/drinkfizz.ogg'
			drinkrecipe = 1

		cocktail_citrus
			name = "Triple Citrus"
			id = "cocktail_citrus"
			result = "cocktail_citrus"
			required_reagents = list("juice_orange" = 1, "juice_lemon" = 1, "juice_lime" = 1)
			result_amount = 3
			mix_phrase = "The citrus juices begin to blend together."
			mix_sound = 'sound/misc/drinkfizz.ogg'
			drinkrecipe = 1

		cocktail_beach
			name = "Sex on the Beach"
			id = "beach"
			result = "beach"
			required_reagents = list("vodka" = 1, "juice_cran" = 1, "juice_orange" = 1)
			result_amount = 3
			mix_phrase = "You die a little inside after making that."
			mix_sound = 'sound/misc/poo2.ogg'

		cocktail_beach/beach2
			id = "beach2"
			required_reagents = list("screwdriver" = 2, "juice_cran" = 1)
			result_amount = 2

		cocktail_screwdriver
			name = "Screwdriver"
			id = "screwdriver"
			result = "screwdriver"
			required_reagents = list("vodka" = 1, "juice_orange" = 1)
			result_amount = 2
			mix_phrase = "The vodka and orange juice mix together nicely."
			mix_sound = 'sound/misc/drinkfizz.ogg'
			drinkrecipe = 1

		cocktail_bloodymary
			name = "Bloody Mary"
			id = "bloody_mary"
			result = "bloody_mary"
			required_reagents = list("vodka" = 1, "juice_tomato" = 1)
			result_amount = 2
			mix_phrase = "The vodka and tomato juice mix together nicely."
			mix_sound = 'sound/misc/drinkfizz.ogg'
			drinkrecipe = 1

		cocktail_bloodyscary
			name = "Bloody Scary"
			id = "bloody_scary"
			result = "bloody_scary"
			required_reagents = list("vodka" = 1, "bloodc" = 1)
			result_amount = 2
			mix_phrase = "The blood feverishly tries to escape the burn of the vodka, but eventually succumbs."
			mix_sound = 'sound/effects/fleshbr1.ogg'
			drinkrecipe = 1

		cocktail_suicider
			name = "Suicider"
			id = "suicider"
			result = "suicider"
			required_reagents = list("cider" = 1, "vodka" = 1, "epinephrine" = 1, "fuel" = 1)
			result_amount = 4
			mix_phrase = "The drinks and chemicals mix together, emitting a potent smell."
			mix_sound = 'sound/misc/drinkfizz.ogg'
			drinkrecipe = 1

		cocktail_boorbon
			name = "BOOrbon"
			id = "boorbon"
			result = "boorbon"
			required_reagents = list("bourbon" = 1, "ectoplasm" = 1)
			result_amount = 2
			mix_phrase = "The bourbon and ectoplasm mix together, forming a HORRIFYING BLEND."
			mix_sound = 'sound/effects/ghostlaugh.ogg'
			drinkrecipe = 1

		cocktail_grog
			name = "Grog"
			id = "grog"
			result = "grog"
			required_reagents = list("fuel" = 1, "cleaner" = 1, "sugar" = 1, "acid" = 1, "rum" = 1, "acetone" = 1, "juice_tomato" = 1, "gvomit" = 1, "lube" = 1, "pacid" = 1, "pepperoni" = 1)
			result_amount = 10
			mix_phrase = "The substance mixes together, emitting a rank piratey odor and seemingly dissolving some of the container..."
			mix_sound = 'sound/misc/drinkfizz.ogg'
			drinkrecipe = 1

		cocktail_beepskybeer
			name = "Beepskybräu Security Schwarzbier"
			id = "beepskybeer"
			result = "beepskybeer"
			required_reagents = list("beer" = 1, "nanites" = 1)
			result_amount = 2
			mix_phrase = "The beer is filled briefly by thousands of brilliant, tiny electrical arcs before growing calm and dark."
			mix_sound = 'sound/effects/sparks6.ogg'
			drinkrecipe = 1

		cocktail_whiskey_sour
			name = "Whiskey Sour"
			id = "whiskey_sour"
			result = "whiskey_sour"
			required_reagents = list("bourbon" = 1, "juice_lemon" = 1, "sugar" = 1)
			result_amount = 3
			mix_phrase = "The alcohol burn sneakily disguises itself in the sweet and sour mix."
			mix_sound = 'sound/misc/drinkfizz.ogg'

		cocktail_whiskey_sour/whiskey_sour2
			id = "whiskey_sour2"
			required_reagents = list("bourbon" = 1, "lemonade" = 2)
			result_amount = 2

		cocktail_daiquiri
			name = "Daiquiri"
			id = "daiquiri"
			result = "daiquiri"
			required_reagents = list("rum" = 1, "juice_lime" = 1, "sugar" = 1)
			result_amount = 3
			mix_phrase = "The rum pairs nicely with the sugar and lime."
			mix_sound = 'sound/misc/drinkfizz.ogg'

		cocktail_martini
			name = "Martini"
			id = "martini"
			result = "martini"
			required_reagents = list("gin" = 1, "vermouth" = 1)
			result_amount = 2
			mix_phrase = "James Bond would be proud."
			mix_sound = 'sound/misc/drinkfizz.ogg'

		cocktail_v_martini
			name = "Vodka Martini"
			id = "v_martini"
			result = "v_martini"
			required_reagents = list("vodka" = 1, "vermouth" = 1)
			result_amount = 2
			mix_phrase = "James Bond would be ashamed."
			mix_sound = 'sound/misc/drinkfizz.ogg'

		cocktail_manhattan
			name = "Manhattan"
			id = "manhattan"
			result = "manhattan"
			required_reagents = list("bourbon" = 1, "vermouth" = 1, "bitters" = 1)
			result_amount = 3
			mix_phrase = "The unmistakable smell of a power lunch wafts from the container."
			mix_sound = 'sound/misc/drinkfizz.ogg'

		cocktail_libre
			name = "Space-Cuba Libre"
			id = "libre"
			result = "libre"
			required_reagents = list("cola" = 1, "rum" = 1, "juice_lime" = 1)
			result_amount = 3
			mix_phrase = "You shed a single patriotic tear as the drink comes together."
			mix_sound = 'sound/misc/drinkfizz.ogg'

		cocktail_ginfizz
			name = "Gin Fizz"
			id = "ginfizz"
			result = "ginfizz"
			required_reagents = list("gin" = 1, "juice_lemon" = 1, "water" = 1)
			result_amount = 3
			mix_phrase = "The mixed drink starts fizzing on its own. Somehow."
			mix_sound = 'sound/misc/drinkfizz.ogg'

		cocktail_gimlet
			name = "Gimlet"
			id = "gimlet"
			result = "gimlet"
			required_reagents = list("gin" = 1, "juice_lime" = 1)
			result_amount = 2
			mix_phrase = "The gin attempts to hide its pine cone flavor in the lime juice."
			mix_sound = 'sound/misc/drinkfizz.ogg'

		cocktail_cosmo
			name = "Cosmopolitan"
			id = "cosmo"
			result = "cosmo"
			required_reagents = list("vodka" = 1, "juice_cran" = 1, "juice_lime" = 1)
			result_amount = 3
			mix_phrase = "The drink turns a bright pink."
			mix_sound = 'sound/misc/drinkfizz.ogg'

		cocktail_cosmo/cosmo2
			id = "cosmo2"
			required_reagents = list("v_gimlet" = 2, "juice_cran" = 1)
			result_amount = 3

		cocktail_v_gimlet
			name = "Vodka Gimlet"
			id = "v_gimlet"
			result = "v_gimlet"
			required_reagents = list("vodka" = 1, "juice_lime" = 1)
			result_amount = 2
			mix_phrase = "The drink comes together and swiftly infuriates cocktail nerds."
			mix_sound = 'sound/misc/drinkfizz.ogg'

		cocktail_b_russian
			name = "Black Russian"
			id = "b_russian"
			result = "b_russian"
			required_reagents = list("vodka" = 1, "coffee" = 1)
			result_amount = 2
			mix_phrase = "The drink turns a deep brown as the coffee settles in."
			mix_sound = 'sound/misc/drinkfizz.ogg'

		cocktail_w_russian
			name = "White Russian"
			id = "w_russian"
			result = "w_russian"
			required_reagents = list("vodka" = 1, "coffee" = 1, "milk" = 1)
			result_amount = 3
			mix_phrase = "The drink abides."
			mix_sound = 'sound/misc/drinkfizz.ogg'

		cocktail_w_russian/w_russian2
			id = "w_russian2"
			required_reagents = list("b_russian" = 2, "milk" = 1)
			result_amount = 3

		cocktail_irishcoffee
			name = "Irish Coffee"
			id = "irishcoffee"
			result = "irishcoffee"
			required_reagents = list("coffee" = 1, "bourbon" = 1, "milk" = 1, "sugar" = 1)
			result_amount = 4
			mix_phrase = "The drink turns a rich brown and smells like a hangover."
			mix_sound = 'sound/misc/drinkfizz.ogg'

		cocktail_dbreath
			name = "Dragon's Breath"
			id = "dbreath"
			result = "dbreath"
			required_reagents = list("bourbon" = 1, "napalm" = 1, "thalmerite" = 1, "fuel" = 1, "ghostchilijuice"= 1)
			result_amount = 1
			mix_phrase = "A tiny mushroom cloud erupts from the container. That's not worrying at all!"
			mix_sound = 'sound/misc/meteorimpact.ogg'

		cocktail_gtonic
			name = "Gin and Tonic"
			id = "gtonic"
			result = "gtonic"
			required_reagents = list("gin" = 1, "tonic" = 1)
			result_amount = 2
			mix_phrase = "The tonic water and gin mix together perfectly."
			mix_sound = 'sound/misc/drinkfizz.ogg'

		cocktail_vtonic
			name = "Vodka Tonic"
			id = "vtonic"
			result = "vtonic"
			required_reagents = list("vodka" = 1, "tonic" = 1)
			result_amount = 2
			mix_phrase = "The tonic water and vodka mix together perfectly."
			mix_sound = 'sound/misc/drinkfizz.ogg'

		cocktail_sonic
			name = "Gin and Sonic"
			id = "sonic"
			result = "sonic"
			required_reagents = list("gtonic" = 1, "methamphetamine" = 1)
			result_amount = 2
			mix_phrase = "The drink turns electric blue and starts quivering violently."
			mix_sound = 'sound/misc/drinkfizz.ogg'

		cocktail_gpink
			name = "Pink Gin and Tonic"
			id = "gpink"
			result = "gpink"
			required_reagents = list("gtonic" = 1, "bitters" = 1)
			result_amount = 2
			mix_phrase = "The gin and tonic gets even more bitter. Way to go!"
			mix_sound = 'sound/misc/drinkfizz.ogg'

		cocktail_eraser
			name = "Mind Eraser"
			id = "eraser"
			result = "eraser"
			required_reagents = list("vtonic" = 1, "coffee" = 1)
			result_amount = 2
			mix_phrase = "The coffee, tonic, and vodka separate into dangerously drinkable layers."
			mix_sound = 'sound/misc/drinkfizz.ogg'

		cocktail_madmen
			name = "Old Fashioned"
			id = "madmen"
			result = "madmen"
			required_reagents = list("bourbon" = 1, "bitters" = 1, "water" = 1, "sugar" = 1)
			result_amount = 4
			mix_phrase = "The cocktail gets back to basics."
			mix_sound = 'sound/misc/drinkfizz.ogg'

		cocktail_planter
			name = "Planter's Punch"
			id = "planter"
			result = "planter"
			required_reagents = list("rum" = 1, "lemonade" = 1)
			result_amount = 2
			mix_phrase = "A nicely Jamaican smell wafts out of the container."
			mix_sound = 'sound/misc/drinkfizz.ogg'

		cocktail_maitai
			name = "Mai Tai"
			id = "maitai"
			result = "maitai"
			required_reagents = list("rum" = 1, "juice_lime" = 1, "juice_orange" = 1)
			result_amount = 4
			mix_phrase = "A little pink umbrella magically appears in the drink."
			mix_sound = 'sound/misc/drinkfizz.ogg'

		cocktail_harlow
			name = "Jean Harlow"
			id = "harlow"
			result = "harlow"
			required_reagents = list("rum" = 1, "vermouth" = 1)
			result_amount = 2
			mix_phrase = "The ghosts of starlets past waft by."
			mix_sound = 'sound/misc/drinkfizz.ogg'

		cocktail_gchronic
			name = "Gin and Chronic"
			id = "gchronic"
			result = "gchronic"
			required_reagents = list("gtonic" = 1, "THC" = 1)
			result_amount = 2
			mix_phrase = "Dude. Dude. You're, like, a genius."
			mix_sound = 'sound/misc/drinkfizz.ogg'

		cocktail_margarita
			name = "Margarita"
			id = "margarita"
			result = "margarita"
			required_reagents = list("tequila" = 1, "juice_orange" = 1, "juice_lime" = 1)
			result_amount = 3
			mix_phrase = "The tequila and citrus pair together like old, alcoholic friends."
			mix_sound = 'sound/misc/drinkfizz.ogg'

		cocktail_tequini
			name = "Tequini"
			id = "tequini"
			result = "tequini"
			required_reagents = list("tequila" = 1, "vermouth" = 1)
			result_amount = 2
			mix_phrase = "James Bond would be deeply confused."
			mix_sound = 'sound/misc/drinkfizz.ogg'

		cocktail_pfire
			name = "Prairie Fire"
			id = "pfire"
			result = "pfire"
			required_reagents = list("tequila" = 1, "capsaicin" = 1)
			result_amount = 2
			mix_phrase = "The hot sauce and tequila mix to create a frat boy's worst nightmare."
			mix_sound = 'sound/misc/drinkfizz.ogg'

		cocktail_bull
			name = "Brave Bull"
			id = "bull"
			result = "bull"
			required_reagents = list("tequila" = 1, "coffee" = 1)
			result_amount = 2
			mix_phrase = "The coffee and tequila mix together. Liqueur? Who needs it?"
			mix_sound = 'sound/misc/drinkfizz.ogg'

		cocktail_longisland
			name = "Long Island Iced Tea"
			id = "longisland"
			result = "longisland"
			required_reagents = list("tequila" = 1, "screwdriver" = 1, "rum" = 1, "gin" = 1, "juice_lemon" = 1, "cola" = 1)
			result_amount = 6
			mix_phrase = "The frightening amount of liquor in the container balances out with the cola and sours."
			mix_sound = 'sound/misc/drinkfizz.ogg'

		cocktail_longbeach
			name = "Long Beach Iced Tea"
			id = "longbeach"
			result = "longbeach"
			required_reagents = list("tequila" = 1, "beach" = 1, "rum" = 1, "gin" = 1, "juice_lemon" = 1)
			result_amount = 5
			mix_phrase = "The frightening amount of liquor in the container balances out with the lemon juice and sours."
			mix_sound = 'sound/misc/drinkfizz.ogg'

		cocktail_hunchback
			name = "Hunchback"
			id = "hunchback"
			result = "hunchback"
			required_reagents = list("bourbon" = 1, "cola" = 1, "juice_tomato" = 1)
			result_amount = 3
			mix_phrase = "The chunks of tomato paste hang in the bourbon and cola as an emulsion. It looks as horrible as that sounds."
			mix_sound = 'sound/effects/blobattack.ogg'

		cocktail_pinacolada
			name = "Piña Colada"
			id = "pinacolada"
			result = "pinacolada"
			required_reagents = list("juice_pineapple" = 1, "rum" = 1, "coconut_milk" = 1)
			result_amount = 4
			mix_phrase = "The drink gives off the smell of a rainy beach."
			mix_sound = 'sound/misc/drinkfizz.ogg'

		cocktail_mimosa
			name = "Mimosa"
			id = "mimosa"
			result = "mimosa"
			required_reagents = list("juice_orange" = 1, "champagne" = 1)
			result_amount = 1
			mix_phrase = "The drink fizzes as the pulp settles to the top."
			mix_sound = 'sound/misc/drinkfizz.ogg'

		cocktail_french75
			name = "French 75"
			id = "french75"
			result = "french75"
			required_reagents = list("lemonade" = 1, "gin" = 1, "champagne" = 1)
			result_amount = 3
			mix_phrase = "The drink fizzes and turns a dark gold."
			mix_sound = 'sound/misc/drinkfizz.ogg'

		cocktail_negroni
			name = "Negroni"
			id = "negroni"
			result = "negroni"
			required_reagents = list("gin" = 1, "vermouth" = 1, "bitters" = 1)
			result_amount = 3
			mix_phrase = "The drink turns a deep red and gives off a hit of sweetness."
			mix_sound = 'sound/misc/drinkfizz.ogg'

		cocktail_negroni/negroni2
			id = "negroni2"
			required_reagents = list("martini" = 2, "bitters" = 1)
			result_amount = 3

		cocktail_necroni
			name = "Necroni"
			id = "necroni"
			result = "necroni"
			required_reagents = list("gin" = 1, "vermouth" = 1, "bitters" = 1, "ectoplasm" = 1)
			result_amount = 4
			mix_phrase = "The drink gives off a haunting stench! What did you make?"
			mix_sound = 'sound/effects/ghostbreath.ogg'

		cocktail_necroni/necroni2
			id = "necroni2"
			required_reagents = list("negroni" = 2, "ectoplasm" = 1)
			result_amount = 3

		squeeze
			name = "Squeeze"
			id = "squeeze"
			result = "squeeze"
			required_reagents = list("bread" = 3, "fuel" = 2)
			result_amount = 2
			mix_phrase = "The fuel is filtered through the bread and makes something vaguely consumable."

		antihol
			name = "Antihol"
			id = "antihol"
			result = "antihol"
			required_reagents = list("ethanol" = 1, "charcoal" = 1)
			result_amount = 2
			mix_phrase = "A minty and refreshing smell drifts from the effervescent mixture."
			mix_sound = 'sound/misc/drinkfizz.ogg'

		ectocooler
			name = "Ecto Cooler"
			id = "ectocooler"
			result = "ectocooler"
			required_reagents = list("juice_orange" = 1, "ectoplasm" = 1, "uranium" = 1)
			result_amount = 3
			mix_phrase = "The orange juice turns an unsettlingly vibrant shade of green."
			mix_sound = 'sound/misc/drinkfizz.ogg'


		explosion_potassium // get in
			name = "Potassium Explosion"
			id = "explosion_potassium"
			required_reagents = list("water" = 1, "potassium" = 1)
			instant = 1
			mix_phrase = "The mixture explodes!"
			on_reaction(var/datum/reagents/holder, var/created_volume)
				if (holder.last_basic_explosion >= ticker.round_elapsed_ticks - 3)
					return
				holder.last_basic_explosion = ticker.round_elapsed_ticks
				var/atom/my_atom = holder.my_atom
				get_fucked_clarks
				var/location = get_turf(my_atom)
				explosion(my_atom, location, -1,-1,0,1)
				fireflash(location, 0)
				return

		explosion_barium // get in
			name = "Barium Explosion"
			id = "explosion_barium"
			required_reagents = list("water" = 1, "barium" = 1)
			instant = 1
			mix_phrase = "The mixture explodes!"
			on_reaction(var/datum/reagents/holder, var/created_volume)
				if (holder.last_basic_explosion >= ticker.round_elapsed_ticks - 3)
					return
				holder.last_basic_explosion = ticker.round_elapsed_ticks
				var/atom/my_atom = holder.my_atom
				get_fucked_clarks
				var/location = get_turf(my_atom)
				explosion(my_atom, location, -1,-1,0,1)
				fireflash(location, 0)
				return

		explosion_magnesium // get in
			name = "Magnesium Explosion"
			id = "explosion_magnesium"
			required_reagents = list("magnesium" = 1, "copper" = 1, "oxygen" = 1)
			instant = 1
			mix_phrase = "The mixture explodes!"
			on_reaction(var/datum/reagents/holder, var/created_volume)
				if (holder.last_basic_explosion >= ticker.round_elapsed_ticks - 3)
					return
				holder.last_basic_explosion = ticker.round_elapsed_ticks
				var/atom/my_atom = holder.my_atom
				get_fucked_clarks
				var/location = get_turf(my_atom)
				explosion(my_atom, location, -1,-1,0,1)
				fireflash(location, 0)
				return

		magnesium_chloride
			name = "Magnesium Chloride"
			id = "magnesium_chloride"
			required_reagents = list("magnesium" = 1, "clacid" = 2)
			result = "magnesium_chloride"
			mix_phrase = "The mixture settles into a white powder."
			result_amount = 1
			on_reaction(var/datum/reagents/holder, var/created_volume)
				holder.add_reagent("hydrogen", created_volume * 2)

		mg_nh3_cl
			name = "Magnesium-Ammonium Chloride"
			id = "mg_nh3_cl"
			required_reagents = list("magnesium_chloride" = 1, "ammonia" = 6)
			result = "magnesium_chloride"
			result_amount = 1
			required_temperature = -(T0C + 40)

		mg_nh3_cl_breakdown
			name = "Magnesium Chloride (+ Ammonia)"
			id = "mg_nh3_cl_breakdown"
			result = "magnesium_chloride"
			required_reagents = list("mg_nh3_cl" = 1)
			result_amount = 1
			required_temperature = T0C + 150
			on_reaction(var/datum/reagents/holder, var/created_volume)
				holder.add_reagent("ammonia", created_volume * 6)

		silicate
			name = "Silicate"
			id = "silicate"
			result = "silicate"
			required_reagents = list("aluminium" = 1, "silicon" = 1, "oxygen" = 1)
			result_amount = 3
			mix_phrase = "The substance mixes into a clear, viscous liquid."

		oil
			name = "Oil"
			id = "oil"
			result = "oil"
			required_reagents = list("carbon" = 1, "hydrogen" = 1, "fuel" = 1)
			result_amount = 3
			mix_phrase = "An iridescent black chemical forms in the container."

		mutagen
			name = "Unstable mutagen"
			id = "mutagen"
			result = "mutagen"
			required_reagents = list("radium" = 1, "plasma" = 1, "chlorine" = 1)
			result_amount = 3
			mix_phrase = "The substance turns neon green and bubbles unnervingly."

		dna_mutagen
			name = "Stable mutagen"
			id = "dna_mutagen"
			result = "dna_mutagen"
			required_reagents = list("mutagen" = 1, "lithium" = 1, "acetone" = 1, "bromine" = 1)
			result_amount = 3
			mix_phrase = "The substance turns a drab green and begins to bubble."
		//  required_temperature = 170

		dna_mutagen/dna_mutagen2
			id = "dna_mutagen2"
			required_reagents = list("mutadone" = 3, "lithium" = 1)
			result_amount = 4

		cyanide
			name = "Cyanide"
			id = "cyanide"
			result = "cyanide"
			required_reagents = list("oil" = 1, "ammonia" = 1, "oxygen" = 1) // more or less the industrial route to cyanide
			required_temperature = T0C + 100
			result_amount = 1 // let's not make it too easy to mass produce
			mix_phrase = "The mixture gives off a faint scent of almonds."
			mix_sound = 'sound/misc/drinkfizz.ogg'

			on_reaction(var/datum/reagents/holder)
				var/location = get_turf(holder.my_atom)
				for(var/mob/M in all_viewers(null, location))
					boutput(M, "<span style=\"color:red\">The solution generates a strong vapor!</span>")
				for(var/mob/living/carbon/human/H in range(location, 1))
					if(ishuman(H))
						if(!H.wear_mask)
							H.reagents.add_reagent("cyanide",7) // BAHAHAHAHA
				return

		sarin // oh god why am i adding this
			name = "Sarin"
			id = "sarin"
			result = "sarin"
			required_reagents = list("chlorine" = 1, "fuel" = 1, "oxygen" = 1, "phosphorus" = 1, "fluorine" = 1, "hydrogen" = 1, "acetone" = 1, "weedkiller" = 1)
			required_temperature = T0C + 100
			result_amount = 3 // it is super potent
			mix_phrase = "The mixture yields a colorless, odorless liquid."
			mix_sound = 'sound/misc/drinkfizz.ogg'

			on_reaction(var/datum/reagents/holder)
				var/location = get_turf(holder.my_atom)
				for(var/mob/M in all_viewers(null, location))
					boutput(M, "<span style=\"color:red\">The solution generates a strong vapor!</span>")
				for(var/mob/living/carbon/human/H in range(location, 2)) // nurfed.
					if(ishuman(H))
						if(!H.wear_mask)
							H.reagents.add_reagent("sarin",4) // griff
				return



		phenol
			name = "Phenol"
			id = "phenol"
			result = "phenol"
			required_reagents = list("oil" = 1, "chlorine" = 1, "water" = 1) // hydrolysis of chlorobenzene
			result_amount = 3
			mix_phrase = "The mixture bubbles and gives off an unpleasant medicinal odor."
			mix_sound = 'sound/misc/drinkfizz.ogg'

		salicylic_acid
			name = "Salicylic Acid"
			id = "salicylic_acid"
			result = "salicylic_acid"
			required_reagents = list("sodium" = 1, "phenol" = 1, "carbon" = 1, "oxygen" = 1, "acid" = 1)
			//required_temperature = 390
			result_amount = 5
			mix_phrase = "The mixture crystallizes."
			mix_sound = 'sound/misc/drinkfizz.ogg'

		thermite
			name = "Thermite"
			id = "thermite"
			result = "thermite"
			required_reagents = list("aluminium" = 1, "iron" = 1, "oxygen" = 1)
			result_amount = 3
			mix_phrase = "The solution mixes into a reddish-brown powder."

/*		lexorin
			name = "Lexorin"
			id = "lexorin"
			result = "lexorin"
			required_reagents = list("plasma" = 1, "hydrogen" = 1, "nitrogen" = 1)
			result_amount = 3
			mix_phrase = "A faint yet nostril-burning scent drifts from the mixture."*/

		space_drugs
			name = "Space Drugs"
			id = "space_drugs"
			result = "space_drugs"
			required_reagents = list("mercury" = 1, "sugar" = 1, "lithium" = 1)
			result_amount = 3
			mix_phrase = "Slightly dizzying fumes drift from the solution."
			mix_sound = 'sound/misc/drinkfizz.ogg'

		lube
			name = "Space Lube"
			id = "lube"
			result = "lube"
			required_reagents = list("water" = 1, "silicon" = 1, "oxygen" = 1)
			result_amount = 3
			mix_phrase = "The substance turns a striking cyan and becomes oily."

		acid
			name = "Sulfuric Acid" // COGWERKS CHEM REVISION PROJECT: This could be Fluorosulfuric Acid instead
			id = "acid"
			result = "acid"
			required_reagents = list("sulfur" = 1, "hydrogen" = 1, "oxygen" = 1) // tobba chem revision: change to SO3 + H2O
			result_amount = 2
			//required_temperature = -160
			mix_phrase = "The mixture gives off a sharp acidic tang."
			on_reaction(var/datum/reagents/holder, created_volume)
				var/location = get_turf(holder.my_atom)
				for (var/mob/living/carbon/human/H in location)
					if (ishuman(H))
						if (!H.wear_mask)
							boutput(H, "<span style=\"color:red\">The acidic vapors burn you!</span>")
							H.TakeDamage("head", 0, created_volume, 0, DAMAGE_BURN) // why are the acids doing brute????
							H.emote("scream")
				return

		clacid
			name = "Hydrochloric Acid"
			id = "clacid"
			result = "clacid"
			required_reagents = list("hydrogen" = 1, "chlorine" = 1, "water" = 1)
			result_amount = 3
			mix_phrase = "The mixture gives off a sharp acidic tang."

			on_reaction(var/datum/reagents/holder, created_volume)
				var/location = get_turf(holder.my_atom)
				for(var/mob/living/carbon/human/H in location)
					if(ishuman(H))
						if(!H.wear_mask)
							boutput(H, "<span style=\"color:red\">The acidic vapors burn you!</span>")
							H.TakeDamage("head", 0, created_volume, 0, DAMAGE_BURN) // WHY??
							H.emote("scream")
				return

		pacid
			name = "Fluorosulfuric Acid" // COGWERKS CHEM REVISION PROJECT: This could be Fluorosulfuric Acid instead
			id = "pacid"
			result = "pacid"
			required_reagents = list("acid" = 1, "fluorine" = 1, "hydrogen" = 1, "potassium" = 1) // tobba chem revision: change to SO3 + HF
			result_amount = 3
			required_temperature = T0C + 100
			mix_phrase = "The mixture deepens to a dark blue, and slowly begins to corrode its container."
			on_reaction(var/datum/reagents/holder, created_volume)
				var/location = get_turf(holder.my_atom)
				for(var/mob/living/carbon/human/H in location)
					if(ishuman(H))
						if(!H.wear_mask)
							boutput(H, "<span style=\"color:red\">Your face comes into contact with the acidic vapors!</span>")
							H.TakeDamage("head", 0, created_volume * 3, 0, DAMAGE_BURN) // IT'S ACID IT BURNS
							H.emote("scream")
							boutput(H, "<span style=\"color:red\">Your face has become disfigured!</span>")
							H.real_name = "Unknown"
							H.weakened = 8
							H:unlock_medal("Red Hood", 1)
				return

		anti_rad // COGWERKS CHEM REVISION PROJECT: marked for revision. Potassium iodide? Prussian Blue?
			name = "Potassium Iodide"
			id = "anti_rad"
			result = "anti_rad"
			required_reagents = list("potassium" = 1, "iodine" = 1)
			result_amount = 2
			mix_phrase = "The solution settles calmly and emits gentle fumes."

		penteticacid // COGWERKS CHEM REVISION PROJECT: marked for revision. Pentetic Acid?
			name = "Pentetic Acid"
			id = "penteticacid"
			result = "penteticacid"
			required_reagents = list("fuel" = 1, "chlorine" = 1, "ammonia" = 1, "formaldehyde" = 1, "sodium" = 1, "cyanide" = 1)
			// (dichloroethane + ammonia) + formaldehyde (maybe that should be implemented?) + (sodium cyanide) yields EDTA which is almost DPTA
			//required_temperature = 310
			result_amount = 6
			mix_phrase = "The substance becomes very still, emitting a curious haze."

		acetaldehyde
			name = "Acetaldehyde"
			id = "acetaldehyde"
			result = "acetaldehyde"
			required_reagents = list("chromium" = 1, "oxygen" = 1, "copper" = 1, "ethanol" = 1)
			result_amount = 3
			required_temperature = T0C + 275
			mix_phrase = "It smells like a bad hangover in here."

		acetic_acid
			name = "Acetic Acid"
			id = "acetic_acid"
			result = "acetic_acid"
			required_reagents = list("acetaldehyde" = 1, "oxygen" = 1, "nitrogen" = 4)
			result_amount = 3
			mix_phrase = "It smells like vinegar and a bad hangover in here."

		ether
			name = "Ether"
			id = "ether"
			result = "ether"
			required_reagents = list("ethanol" = 1, "clacid" = 1, "oxygen" = 1)
			result_amount = 1
			max_temperature = T0C + 150
			mix_phrase = "The mixture yields a pungent odor, which makes you tired."

		cyclopentanol
			name = "Cyclopentanol"
			id = "cyclopentanol"
			result = "cyclopentanol"
			required_temperature = T0C + 275
			required_reagents = list("acetic_acid" = 1, "ether" = 1, "barium" = 1, "hydrogen" = 1, "oxygen" = 1)
			result_amount = 3
			mix_phrase = "The mixture fizzles into a colorless liquid."

		kerosene
			name = "Kerosene"
			id = "kerosene"
			result = "kerosene"
			required_temperature = T0C + 600
			required_reagents = list("cyclopentanol" = 1, "oxygen" = 3, "acetone" = 1, "hydrogen" = 1, "aluminium" = 1, "nickel" = 1)
			result_amount = 3
			mix_phrase = "This pungent odor could probably melt steel."

		formaldehyde
			name = "Embalming fluid"
			id = "formaldehyde"
			result = "formaldehyde"
			required_reagents = list("ethanol" = 1, "oxygen" = 1, "silver" = 1)
			//ethanol as methanol, oxidized with a silver catalyst
			required_temperature = T0C + 150 // really more like 620 but fuck it
			result_amount = 2
			mix_phrase = "Ugh, it smells like the morgue in here."

		haloperidol // COGWERKS CHEM REVISION PROJECT: marked for revision - antipsychotic
			name = "Haloperidol"
			id = "haloperidol"
			result = "haloperidol"
			required_reagents = list("chlorine" = 1, "fluorine" = 1, "aluminium" = 1, "anti_rad" = 1, "oil" = 1)
			//required_temperature = 320
			result_amount = 4
			mix_phrase = "The chemicals mix into an odd pink slush."

		silver_sulfadiazine // COGWERKS CHEM REVISION PROJECT: marked for revision. maybe something like Silvadene?
			name = "Burn Medication"
			id = "silver_sulfadiazine"
			result = "silver_sulfadiazine"
			required_reagents = list("silver" = 1, "sulfur" = 1, "oxygen" = 1, "chlorine" = 1, "ammonia" = 1) // oil as benzene, sulfur oxygen chlorine as a sulfonyl group
			// removed oil from the recipe so that this can be made without leaving a chem dispenser like styptic
			result_amount = 5
			mix_phrase = "A strong and cloying odor begins to bubble from the mixture."
			mix_sound = 'sound/misc/drinkfizz.ogg'

		/*
		silver_sulfadiazine/silver_sulfadiazine2
			id = "silver_sulfadiazine2"
			required_reagents = list("silver" = 1, "sulfur" = 1, "oxygen" = 1, "weedkiller" = 3)
			result_amount = 5
		*/
		charcoal // antitoxin
			name = "Activated Charcoal"
			id = "charcoal"
			result = "charcoal"
			required_reagents = list("ash" = 1, "salt" = 1)
			required_temperature = T0C + 100
			result_amount = 2
			mix_phrase = "The mixture yields a fine black powder."
			mix_sound = 'sound/misc/fuse.ogg'

		teporone // COGWERKS CHEM REVISION PROJECT: marked for revision - magic drug
			name = "Teporone"
			id = "teporone"
			result = "teporone"
			required_reagents = list("silicon" = 1, "acetone" = 1, "plasma" = 1)
			result_amount = 2
			mix_phrase = "The mixture turns an odd lavender color."
			mix_sound = 'sound/misc/drinkfizz.ogg'

		epinephrine
			name = "Epinephrine"
			id = "epinephrine"
			result = "epinephrine"
			required_reagents = list("phenol" = 1, "hydrogen" = 1, "oxygen" = 1, "chlorine" = 1, "acetone" = 1, "diethylamine" = 1)
			result_amount = 4
			mix_phrase = "Tiny white crystals precipitate out of the solution."
			mix_sound = 'sound/misc/drinkfizz.ogg'


		atropine // COGWERKS CHEM REVISION PROJECT: maybe atropine, and give it a useful function in medbay?
			name = "Atropine"
			id = "atropine"
			result = "atropine"
			required_reagents = list("ethanol" = 1, "diethylamine" = 1, "acetone" = 1, "phenol" = 1, "acid" = 1)
			result_amount = 4
			mix_phrase = "A horrid smell like something died drifts from the mixture."

		/*omnizine // COGWERKS CHEM REVISION PROJECT: magic bullshit drug, ought to involve plasma. far too easy to make right now
			name = "omnizine"
			id = "omnizine"
			result = "omnizine"
			required_reagents = list("epinephrine" = 1, "charcoal" = 1)
			result_amount = 2
			mix_phrase = "The mixture seems to slosh around on its own, fizzing violently."*/

		oculine
			name = "Oculine"
			id = "oculine"
			result = "oculine"
			required_reagents = list("atropine" = 1, "saline" = 1, "spaceacillin" = 1)
			result_amount = 4
			mix_phrase = "The mixture settles, becoming a milky white."

		mannitol // COGWERKS CHEM REVISION PROJECT: maybe this could be Mannitol, side effect: makes u pee?
			name = "Mannitol"
			id = "mannitol"
			result = "mannitol"
			required_reagents = list("sugar" = 1, "hydrogen" = 1, "water" = 1)
			//required_temperature = T0C + 150
			result_amount = 2
			mix_phrase = "The mixture bubbles slowly, making a slightly sweet odor."

		salbutamol // COGWERKS CHEM REVISION PROJECT: possibly dexamesothone, anti-edema medication
			name = "Salbutamol"
			id = "salbutamol"
			result = "salbutamol"
			required_reagents = list("salicylic_acid" = 1, "lithium" = 1, "ammonia" = 1, "aluminium" = 1, "bromine" = 1)
			result_amount = 5
			mix_phrase = "The solution bubbles freely, creating a head of bluish foam."
			mix_sound = 'sound/misc/drinkfizz.ogg'

		perfluorodecalin // COGWERKS CHEM REVISION PROJECT:marked for revision
			name = "Perfluorodecalin"
			id = "perfluorodecalin"
			result = "perfluorodecalin"
			required_reagents = list("hydrogen" = 1, "fluorine" = 1, "oil" = 1)
			required_temperature = T0C + 100
			// hydrogenate napthalene, then fluorinate
			result_amount = 2 // lowered because the recipe is very easy
			mix_phrase = "The mixture rapidly turns into a dense pink liquid."
			mix_sound = 'sound/misc/drinkfizz.ogg'

		stypic_powder // COGWERKS CHEM REVISION PROJECT: no idea, probably a magic drug
			name = "Styptic Powder"
			id = "stypic_powder"
			result = "stypic_powder"
			required_reagents = list("aluminium" = 1, "oxygen" = 1, "hydrogen" = 1, "acid" = 1)
			//required_temperature = 325
			result_amount = 4
			mix_phrase = "The solution yields an astringent powder."

		ephedrine
			name = "Ephedrine"
			id = "ephedrine"
			result = "ephedrine"
			required_reagents = list("sugar" = 1, "oil" = 1, "hydrogen" = 1, "diethylamine" = 1)
			result_amount = 3
			mix_phrase = "The solution fizzes and gives off toxic fumes."

		methamphetamine // COGWERKS CHEM REVISION PROJECT: some sort of potent stimulant, could combine with teporone?
			name = "Methamphetamine"
			id = "methamphetamine"
			result = "methamphetamine"
			required_reagents = list("ephedrine" = 1, "phosphorus" = 1, "hydrogen" = 1, "iodine" = 1) // tobba chem revision: change the hydrogen and iodine for hydroiodic acid
			required_temperature = T0C + 100
			result_amount = 3
			mix_phrase = "The solution fizzes and gives off toxic fumes."

			on_reaction(var/datum/reagents/holder)
				var/location = get_turf(holder.my_atom)
				for(var/mob/M in all_viewers(null, location))
					boutput(M, "<span style=\"color:red\">The solution generates a strong vapor!</span>")
				for(var/mob/living/carbon/human/H in range(location, 1))
					if(ishuman(H))
						if(!H.wear_mask)
							H.emote("gasp")
							H.losebreath++
							H.reagents.add_reagent("toxin",10)
							H.reagents.add_reagent("neurotoxin",20) // ~HEH~
				return

		mutadone // // COGWERKS CHEM REVISION PROJECT: magic bullshit drug, make it involve mutagen
			name = "Mutadone"
			id = "mutadone"
			result = "mutadone"
			required_reagents = list("mutagen" = 1, "acetone" = 1, "bromine" = 1)
			result_amount = 3
			mix_phrase = "A foul astringent liquid emerges from the reaction."

		cryoxadone
			name = "Cryoxadone" // leaving this name alone
			id = "cryoxadone"
			result = "cryoxadone"
			required_reagents = list("cryostylane" = 1, "mutagen" = 1, "plasma" = 1, "acetone" = 1)
			result_amount = 3
			mix_phrase = "The solution bubbles softly."
			mix_sound = 'sound/misc/drinkfizz.ogg'

		cryostylane
			name = "Cryostylane"
			id = "cryostylane"
			result = "cryostylane"
			required_reagents = list("nitrogen" = 1, "plasma" = 1, "water" = 1) // had a conflict with ammonia recipe
			result_amount = 3
			mix_phrase = "A light layer of frost forms on top of the mixture."
			mix_sound = 'sound/misc/drinkfizz.ogg'

		spaceacillin
			name = "spaceacillin"
			id = "spaceacillin"
			result = "spaceacillin"
			required_reagents = list("space_fungus" = 1, "ethanol" = 1)
			result_amount = 2
			mix_phrase = "The solvent extracts an antibiotic compound from the fungus."

		mutagen2
			name = "Strange Toxin"
			id = "mutagen2"
			result = "mutagen"
			required_reagents = list("neurotoxin" = 1, "epinephrine" = 1)
			result_amount = 2
			mix_phrase = "An unpleasant, shifting green mass of liquid forms from the reaction."
			mix_sound = 'sound/misc/drinkfizz.ogg'

		initropidril
			name = "initropidril"
			id = "initropidril"
			result = "initropidril"
			required_reagents = list("crank" = 1, "histamine" = 1, "krokodil" = 1, "bathsalts" = 1, "atropine" = 1, "nicotine" = 1, "morphine" = 1)
			result_amount = 4 // lowered slightly
			mix_phrase = "A sweet and sugary scent drifts from the unpleasant milky substance."

/*
		initrobeedril_old
			name = "initrobeedril"
			id = "initrobeedril_old"
			result = "initrobeedril_old"
			required_reagents = list("initropidril" = 1, "bee" = 1, "honey" = 1, "dna_mutagen" = 1)
			result_amount = 5
			mix_phrase = "A sweet and sugary scent drifts from the golden substance."
*/
		royal_initrobeedril
			name = "royal initrobeedril"
			id = "royal_initrobeedril"
			result = "royal_initrobeedril"
			required_reagents = list("initropidril" = 1, "bee" = 1, "honey" = 1, "dna_mutagen" = 1, "royal_jelly" = 1)
			result_amount = 5
			required_temperature = T0C + 200
			mix_phrase = "A sweet and sugary scent drifts from the royal purple substance."

		initrobeedril
			name = "initrobeedril"
			id = "initrobeedril"
			result = "initrobeedril"
			required_reagents = list("initropidril" = 1, "bee" = 1, "honey" = 1, "dna_mutagen" = 1)
			result_amount = 5
			mix_phrase = "A sweet and sugary scent drifts from the golden substance."

		fake_initropidril
			name = "initropidril"
			id = "fake_initropidril"
			result = "fake_initropidril"
			required_reagents = list("methamphetamine" = 1, "water_holy" = 1, "pacid" = 1, "neurotoxin" = 1, "formaldehyde" = 1)
			result_amount = 2
			mix_phrase = "A sweet and sugary scent drifts from the unpleasant milky substance."
			on_reaction(var/datum/reagents/holder)
				if(prob(80))		// high chance of not working to piss them off
					var/location = get_turf(holder.my_atom)
					for(var/mob/M in AIviewers(null, location))
						boutput(M, "<span style=\"color:red\">The solution bubbles rapidly but dissipates into nothing!</span>")
					holder.clear_reagents()
				return

		cola
			name = "cola"
			id = "cola"
			result = "cola"
			required_reagents = list("water" = 1, "carbon" = 1, "oxygen" = 1, "sugar" = 1)
			result_amount = 4
			mix_phrase = "The mixture begins to fizz."
			mix_sound = 'sound/misc/drinkfizz.ogg'
			drinkrecipe = 1

		anti_fart
			name = "Simethicone"
			id = "anti_fart"
			result = "anti_fart"
			required_reagents = list("oxygen" = 1, "chlorine" = 1, "hydrogen" = 1, "silicon" = 1)
			result_amount = 3

		flash_powder
			name = "Flash Powder"
			id = "flashpowder"
			result = "flashpowder"
			required_reagents = list("aluminium" = 1, "potassium" = 1, "sulfur" = 1, "chlorine" = 1, "stabiliser" = 1)
			result_amount = 5
			mix_phrase = "The chemicals hiss and fizz briefly before falling still."

		flash
			name = "Flash"
			id = "flash"
			required_reagents = list("aluminium" = 1, "potassium" = 1, "sulfur" = 1, "chlorine" = 1 )
			inhibitors = list("stabiliser")
			instant = 1
			mix_phrase = "The chemicals catch fire, burning brightly and violently!"
			mix_sound = 'sound/weapons/flashbang.ogg'

			on_reaction(var/datum/reagents/holder, var/created_volume)
				var/location = get_turf(holder.my_atom)
				var/datum/effects/system/spark_spread/s = unpool(/datum/effects/system/spark_spread)
				s.set_up(2, 1, location)
				s.start()

				for (var/mob/living/M in all_viewers(5, location))
					if (issilicon(M) || isintangible(M))
						continue

					var/dist = get_dist(M, location)
					M.apply_flash(60, 0, (3 - dist), 0, ((5 - dist) * 2), (2 - dist))

				for (var/mob/living/silicon/M in all_viewers(world.view, location))
					var/checkdist = get_dist(M, location)

					M.apply_flash(30, max(2 * (3 - checkdist), 0), max(2 * (5 - checkdist), 0))

// Don't forget to update Reagents-ExplosiveFire.dm too, we have duplicate code for sonic and flash powder there (Convair880).

		sonic_powder
			name = "Hootingium"
			id = "sonicpowder"
			result = "sonicpowder"
			required_reagents = list("oxygen" = 1, "cola" = 1, "phosphorus" = 1, "stabiliser" = 1)
			result_amount = 2
			mix_phrase = "The mixture begins to bubble slighly!"

		sonic_boom //The "bang" part of "flashbang"
			name = "Hootingium"
			id = "sonic_boom"
			required_reagents = list("oxygen" = 1, "cola" = 1, "phosphorus" = 1)
			inhibitors = list("stabiliser")
			instant = 1
			mix_phrase = "The mixture begins to bubble furiously!"
			mix_sound = 'sound/weapons/flashbang.ogg'

			on_reaction(var/datum/reagents/holder, var/created_volume)
				var/location = get_turf(holder.my_atom)
				var/hootmode = prob(5)

				if (hootmode)
					playsound(location, 'sound/misc/hoot.ogg', 100, 1)
				else
					playsound(location, 'sound/weapons/flashbang.ogg', 25, 1)

				for (var/mob/living/M in all_hearers(world.view, location))
					if (issilicon(M) || isintangible(M))
						continue
					if (!M.ears_protected_from_sound())
						boutput(M, "<span style=\"color:red\"><b>[hootmode ? "HOOT" : "BANG"]</b></span>")
					else
						continue

					var/checkdist = get_dist(M, location)
					var/weak = max(0, 2 * (3 - checkdist))
					var/misstep = 40
					var/ear_damage = max(0, 2 * (3 - checkdist))
					var/ear_tempdeaf = max(0, 2 * (5 - checkdist)) //annoying and unfun so reduced dramatically

					M.apply_sonic_stun(weak, 0, misstep, 0, 0, ear_damage, ear_tempdeaf)

				for (var/mob/living/silicon/S in all_hearers(world.view, location))
					if (!S.ears_protected_from_sound())
						boutput(S, "<span style=\"color:red\"><b>[hootmode ? "HOOT" : "BANG"]</b></span>")
					else
						continue

					var/checkdist = get_dist(S, location)
					var/C_weak = max(0, 2 * (3 - checkdist))

					S.apply_sonic_stun(C_weak, 0)

		chlorine_azide  // death 2 chemists
			name = "Chlorine Azide"
			id = "chlorine_azide"
			result = "chlorine_azide"
			required_reagents = list("sodium" = 1, "ammonia" = 1, "nitrogen" = 1, "oxygen" = 1, "silver" = 1, "chlorine" = 1)
			instant = 1
			mix_phrase = "The substance violently detonates!"
			mix_sound = 'sound/effects/bang.ogg'
			on_reaction(var/datum/reagents/holder, var/created_volume)
				var/atom/my_atom = holder.my_atom
				get_fucked_clarks
				explosion(my_atom, get_turf(my_atom), 0, 1, 4, 5)
				return

		clf3_firefoam
			name = "CLF3 + FF Explosion"
			id = "clf3_firefoam"
			result = "clf3_firefoam"
			required_reagents = list("infernite" = 1, "ff-foam" = 1)
			instant = 1
			mix_phrase = "The substance violently detonates!"
			mix_sound = 'sound/effects/bang.ogg'
			on_reaction(var/datum/reagents/holder, var/created_volume)
				var/atom/my_atom = holder.my_atom
				get_fucked_clarks
				explosion(my_atom, get_turf(my_atom), -1, 0, 2, 3)
				return

		anima //Consume max health on nearby people. also stamina. also requires alchemy circle and stone.
			name = "Anima"
			id = "anima"
			required_reagents = list("strange_reagent" = 1, "blood" = 1, "ldmatter" = 1, "ectoplasm" = 1)
			instant = 1
			mix_phrase = null
			mix_sound = 'sound/effects/ghostbreath.ogg'
			on_reaction(var/datum/reagents/holder, var/created_volume)
				var/my_atom = holder.my_atom
				if(!my_atom) return
				var/turf/reaction_loc = get_turf(my_atom)
				if(!reaction_loc) return

				if( (locate(/obj/alchemy/circle) in range(3,reaction_loc)) )
					reaction_loc.visible_message("<span style=\"color:red\">[bicon(my_atom)] The mixture turns into pure energy which promptly flows into the alchemy circle.</span>")
					var/gathered = 0
					for(var/mob/living/M in view(5,reaction_loc))
						boutput(M, "<span style=\"color:red\">You feel a wracking pain as some of your life is ripped out.</span>")
						gathered += M.max_health - round(M.max_health / 2)
						M.max_health = round(M.max_health / 2)
						if(hascall(M,"add_stam_mod_max"))
							M:add_stam_mod_max("anima_drain", -25)
					if(gathered >= 80)
						reaction_loc.visible_message("<span style=\"color:red\">[bicon(my_atom)] As the alchemy circle rips the life out of everyone close to it, energies escape it and settle in the [my_atom].</span>")
						holder.add_reagent("anima",50)
						if (!particleMaster.CheckSystemExists(/datum/particleSystem/swoosh, my_atom))
							particleMaster.SpawnSystem(new /datum/particleSystem/swoosh(my_atom))
					else
						reaction_loc.visible_message("<span style=\"color:red\">[bicon(my_atom)] The alchemy circle briefly glows before fading back to normal. It seems like it couldn't gather enough energy.</span>")
				else
					reaction_loc.visible_message("<span style=\"color:red\">[bicon(my_atom)] The mixture turns into pure energy which quickly disperses. It needs to be channeled somehow.</span>")
				return

		napalm
			name = "Phlogiston"
			id = "napalm"
			result = "napalm"
			required_reagents = list("phosphorus" = 1, "plasma" = 1, "acid" = 1, "stabiliser" = 1 )
			result_amount = 4
			mix_phrase = "The substance becomes sticky and extremely warm."

		firedust
			name = "Phlogiston Dust"
			id = "firedust"
			result = "firedust"
			required_reagents = list("napalm" = 1, "charcoal" = 1, "phosphorus" = 1, "sulfur" = 1)
			result_amount = 2
			mix_phrase = "The substance becomes a pile of burning dust."

		napalmfire //This MUST be above the smoke recipe. Trust me on that one. IT affects the internal order of the recipes.
			name = "Phlogiston Fire"
			id = "napalm"
			result = "napalm"
			required_reagents = list("phosphorus" = 1, "plasma" = 1, "acid" = 1 )
			inhibitors = list("stabiliser")
			instant = 1
			mix_phrase = "The substance erupts into wild flames."
			on_reaction(var/datum/reagents/holder, var/created_volume)
				fireflash(get_turf(holder.my_atom), min(max(2,round(created_volume/10)),8)) // This reaction didn't have an upper cap, uh-oh (Convair880).
				return

		napalm_goo
			name = "Napalm"
			id = "napalm_goo"
			result = "napalm_goo"
			required_reagents = list("fuel" = 1, "sugar" = 1, "ethanol" = 1)
			result_amount = 3
			mix_phrase = "The mixture congeals into a sticky gel."

		smokepowder
			name = "Smoke Powder"
			id = "smokepowder"
			result = "smokepowder"
			required_reagents = list("potassium" = 1, "sugar" = 1, "phosphorus" = 1, "stabiliser" = 1)
			result_amount = 3
			mix_phrase = "The mixture sets into a greyish powder!"

		smoke
			name = "Smoke"
			id = "smoke"
			required_reagents = list("potassium" = 1, "sugar" = 1, "phosphorus" = 1)
			inhibitors = list("stabiliser")
			instant = 1
			special_log_handling = 1
			consume_all = 1
			mix_phrase = "The mixture quickly turns into a pall of smoke!"
			on_reaction(var/datum/reagents/holder, var/created_volume)
				smoke_reaction(holder, min(round(created_volume / 5) + 1, 4), get_turf(holder.my_atom))

		blackpowder // oh no
			name = "Black Powder"
			id = "blackpowder"
			result = "blackpowder"
			required_reagents = list("charcoal" = 1, "sulfur" = 1, "saltpetre" = 1)
			result_amount = 3
			mix_phrase = "The mixture yields a granular black powder."
			mix_sound = 'sound/misc/fuse.ogg'


		stabiliser
			name = "Stabilising Agent"
			id = "stabiliser"
			result = "stabiliser"
			required_reagents = list("iron" = 1, "hydrogen" = 1, "oxygen" = 1)
			result_amount = 2
			mix_phrase = "The mixture becomes a yellow liquid!"

///////////////////////////////////////////////////////////////////////////////////

		potash1
			name = "potash"
			id = "potash1"
			result = "potash"
			required_reagents = list("ash" = 1, "water" = 1)
			required_temperature = T0C + 80
			result_amount = 1
			mix_phrase = "A white crystalline residue forms as the water boils off."

		potash2
			name = "potash"
			id = "potash2"
			result = "potash"
			required_reagents = list("potassium" = 1, "chlorine" = 1, "acid" = 1)
			result_amount = 2
			mix_phrase = "The mixture yields a white crystalline compound."

		plant_nutrients
			name = "saltpetre"
			id = "saltpetre"
			result = "saltpetre"
			required_reagents = list("urine" = 1, "poo" = 1, "potash" = 1)
			result_amount = 3
			mix_phrase = "A white crystalline substance condenses out of the mixture."
			mix_sound = 'sound/misc/fuse.ogg'

		jenkem // moved this down so improperly mixed nutrients yield jenkem instead
			name = "Jenkem"
			id = "jenkem"
			result = "jenkem"
			required_reagents = list("urine" = 1, "poo" = 1)
			result_amount = 2
			mix_phrase = "The mixture ferments into a filthy morass."
			mix_sound = 'sound/effects/blobattack.ogg'

			on_reaction(var/datum/reagents/holder)
				var/location = get_turf(holder.my_atom)
				for(var/mob/M in all_viewers(null, location))
					boutput(M, "<span style=\"color:red\">The solution generates a strong vapor!</span>")
				for(var/mob/living/carbon/human/H in range(location, 1))
					if(ishuman(H))
						if(!H.wear_mask)
							H.reagents.add_reagent("jenkem",25) // this is going to make people so, so angry
				return

		/*plant_nutrients_mutagenic
			name = "Mutriant Plant Formula"
			id = "plant_nutrients_muta"
			result = "plant_nutrients_muta"
			required_reagents = list("saltpetre" = 1, "anti_rad" = 1, "radium" = 1)
			result_amount = 3
			mix_phrase = "A strange odor comes from the resultant greenish goo."
			mix_sound = 'sound/effects/blobattack.ogg'

		plant_nutrients_quickgrow
			name = "Gro-Boost Plant Formula"
			id = "plant_nutrients_grow"
			result = "plant_nutrients_grow"
			required_reagents = list("saltpetre" = 1, "stypic_powder" = 1, "salbutamol" = 1)
			result_amount = 3
			mix_phrase = "The mixture smells earthy and yet strange."
			mix_sound = 'sound/effects/blobattack.ogg'

		plant_nutrients_cropyield
			name = "Top Crop Plant Formula"
			id = "plant_nutrients_crop"
			result = "plant_nutrients_crop"
			required_reagents = list("saltpetre" = 1, "charcoal" = 1, "antihol" = 1)
			result_amount = 3
			mix_phrase = "The substance dissolves into a thick silty soup."
			mix_sound = 'sound/effects/blobattack.ogg'

		plant_nutrients_potency
			name = "Powerplant Plant Formula"
			id = "plant_nutrients_potency"
			result = "plant_nutrients_potency"
			required_reagents = list("saltpetre" = 1, "silver_sulfadiazine" = 1, "methamphetamine" = 1)
			result_amount = 3
			mix_phrase = "A pungent and powerful earthy odor comes from the mixture."
			mix_sound = 'sound/effects/blobattack.ogg'

		plant_nutrients_balance
			name = "Fruitful Farming Plant Formula"
			id = "plant_nutrients_balance"
			result = "plant_nutrients_balance"
			required_reagents = list("saltpetre" = 1, "epinephrine" = 1, "teporone" = 1)
			result_amount = 3
			mix_phrase = "A calming, coffee-like scent comes from the dirt-like mixture."
			mix_sound = 'sound/effects/blobattack.ogg' */

		weedkiller
			name = "Atrazine"
			id = "weedkiller"
			result = "weedkiller"
			required_reagents = list("chlorine" = 1, "nitrogen" = 1, "hydrogen" = 1)
			result_amount = 3
			mix_phrase = "The mixture gives off a harsh odor."

		copper_nitrate
			name = "Copper Nitrate"
			id = "copper_nitrate"
			result = "copper_nitrate"
			required_reagents = list("copper" = 1, "nitrogen" = 1, "oxygen" = 3)
			result_amount = 1
			mix_phrase = "The mixture forms into a blue crystalline solid."

		nitrogen_dioxide
			name = "Nitrogen Dioxide"
			id = "nitrogen_dioxide"
			result = "nitrogen_dioxide"
			required_reagents = list("copper_nitrate" = 1)
			required_temperature = T0C + 180
			result_amount = 2
			mix_phrase = "The mixture gives off a biting odor."
			on_reaction(var/datum/reagents/holder, created_volume)
				holder.add_reagent("oxygen", created_volume,, holder.total_temperature)

		nitric_acid
			name = "Nitric Acid"
			id = "nitric_acid"
			result = "nitric_acid"
			required_reagents = list("water" = 1, "nitrogen_dioxide" = 3)
			result_amount = 2
			mix_phrase = "The mixture gives off a sharp acidic tang."
			on_reaction(var/datum/reagents/holder, created_volume)
				var/location = get_turf(holder.my_atom)
				for (var/mob/living/carbon/human/H in location)
					if (ishuman(H))
						if (!H.wear_mask)
							boutput(H, "<span style=\"color:red\">The acidic vapors burn you!</span>")
							H.TakeDamage("head", 0, created_volume, 0, DAMAGE_BURN) // why are the acids doing brute????
							H.emote("scream")
				return

		allyl_chloride
			name = "Allyl chloride"
			id = "allyl_chloride"
			result = "allyl_chloride"
			required_reagents = list("oil" = 1, "chlorine" = 2)
			required_temperature = T0C + 500
			result_amount = 1
			mix_phrase = "The mixture becomes colorless."
			on_reaction(var/datum/reagents/holder, created_volume)
				holder.add_reagent("clacid", created_volume,,holder.total_temperature)

		epichlorohydrin
			name = "Epichlorohydrin"
			id = "epichlorohydrin"
			result = "epichlorohydrin"
			required_reagents = list("allyl_chloride" = 1, "clacid" = 1, "sodium" = 1, "oxygen" = 2, "hydrogen" = 1)
			result_amount = 1
			mix_phrase = "The mixture gives of a garlic-like odor."
			on_reaction(var/datum/reagents/holder, created_volume)
				holder.add_reagent("salt", created_volume,,holder.total_temperature)

		glycerol
			name = "Glycerol"
			id = "glycerol"
			result = "glycerol"
			required_reagents = list("epichlorohydrin" = 1, "water" = 1)
			result_amount = 1
			mix_phrase = "The mixture bubbles."
			on_reaction(var/datum/reagents/holder, created_volume)
				holder.add_reagent("clacid", created_volume,,holder.total_temperature)

		nitroglycerin
			name = "Nitroglycerin"
			id = "nitroglycerin"
			result = "nitroglycerin"
			required_reagents = list("glycerol" = 1, "nitric_acid" = 1, "acid" = 1)
			result_amount = 1
			mix_phrase = "The mixture becomes seemingly heavy and viscous."

		/*
		weedkiller/weedkiller2
			id = "weedkiller2"
			required_reagents = list("chlorine" = 1, "ammonia" = 2)
			result_amount = 3
		*/
// foam and foam precursor

		surfactant
			name = "Foam surfactant"
			id = "foam surfactant"
			result = "fluorosurfactant"
			required_reagents = list("fluorine" = 2, "carbon" = 2, "acid" = 1)
			result_amount = 5
			mix_phrase = "A head of foam results from the mixture's constant fizzing."
			mix_sound = 'sound/misc/drinkfizz.ogg'

		firefoam
			name = "Firefighting foam"
			id = "ff-foam"
			result = "ff-foam"
			required_reagents = list("chlorine" = 1, "carbon" = 1, "sulfur" = 1)
			result_amount = 3
			mix_phrase = "The mixture bubbles gently."
			mix_sound = 'sound/misc/drinkfizz.ogg'

		foam
			name = "Foam"
			id = "foam"
			required_reagents = list("fluorosurfactant" = 1, "water" = 1)
			result_amount = 2
			instant = 1
			special_log_handling = 1
			mix_phrase = "The mixture quickly and violently erupts into bubbles!"
			on_reaction(var/datum/reagents/holder, var/created_volume)
				var/location = get_turf(holder.my_atom)
				for(var/mob/M in AIviewers(5, location))
					boutput(M, "<span style=\"color:red\">The solution violently bubbles!</span>")

				location = get_turf(holder.my_atom)

				for(var/mob/M in AIviewers(5, location))
					boutput(M, "<span style=\"color:red\">The solution spews out foam!</span>")

				var/datum/effects/system/foam_spread/s = new()
				s.set_up(created_volume, location, holder, 0)
				s.start()
				holder.clear_reagents()
				return

		metalfoam
			name = "Metal Foam"
			id = "metalfoam"
			required_reagents = list("aluminium" = 3, "fluorosurfactant" = 1, "acid" = 1)
			instant = 1
			result_amount = 5
			mix_phrase = "The metal begins to foam up!"

			on_reaction(var/datum/reagents/holder, var/created_volume)


				var/location = get_turf(holder.my_atom)

				for(var/mob/M in AIviewers(5, location))
					boutput(M, "<span style=\"color:red\">The solution spews out a metalic foam!</span>")

				var/datum/effects/system/foam_spread/s = new()
				s.set_up(created_volume/2, location, holder, 1)
				s.start()
				return

		ironfoam
			name = "Iron Foam"
			id = "ironlfoam"
			required_reagents = list("iron" = 3, "fluorosurfactant" = 1, "acid" = 1)
			instant = 1
			result_amount = 5
			mix_phrase = "The metal begins to foam up, becoming rigid and tough!"

			on_reaction(var/datum/reagents/holder, var/created_volume)


				var/location = get_turf(holder.my_atom)

				for(var/mob/M in AIviewers(5, location))
					boutput(M, "<span style=\"color:red\">The solution spews out a metalic foam!</span>")

				var/datum/effects/system/foam_spread/s = new()
				s.set_up(created_volume/2, location, holder, 2)
				s.start()
				return

/*		fuckthisshit
			name = "fuck this shit"
			id = "fuckthisshit"
			result = null
			required_reagents = list("carbon" = 5, "flourine" = 5, "acid" = 5, "sugar" = 5,  "phosphorus" = 5, "potassium" = 5, "water" = 15)
			result_amount = 5
			mix_phrase = "The chemicals mix into a shade of brown and begin to bubble."
			mix_sound = 'poo2.ogg'

			on_reaction(var/datum/reagents/holder, var/created_volume)
				holder.clear_reagents()
				message_admins("[] attempted to make infinifoam what a piece of shit", usr) */

		// Synthesizing these three chemicals is pretty complex in real life, but fuck it, it's just a game!
		ammonia
			name = "Ammonia"
			id = "ammonia"
			result = "ammonia"
			required_reagents = list("hydrogen" = 3, "nitrogen" = 1)
			result_amount = 3
			mix_phrase = "The mixture bubbles, emitting an acrid reek."

		diethylamine // COGWERKS CHEM REVISION PROJECT: change this so cleaner involves ammonia, ethanol and water
			name = "Diethylamine"
			id = "diethylamine"
			result = "diethylamine"
			required_reagents = list("ammonia" = 1, "ethanol" = 1)
			required_temperature = T0C + 100
			result_amount = 2
			mix_phrase = "A horrible smell pours forth from the mixture."

		LSD
			name = "Lysergic acid diethylamide"
			id = "LSD"
			result = "LSD"
			required_reagents = list("diethylamine" = 1, "space_fungus" = 1)
			result_amount = 3
			mix_phrase = "The mixture turns a rather unassuming color and settles."

		bathsalts // cogwerks' dumb first drug attempt, delete if bad
			name = "Bath Salts"
			id= "bathsalts"
			result = "bathsalts"
			required_reagents = list("msg" = 1, "yuck" = 1, "denatured_enzyme" = 1, "saltpetre" = 1, "cleaner" = 1, "mercury" = 1, "mugwort" = 1)
			required_temperature = T0C + 100
			result_amount = 6
			mix_phrase = "Tiny cubic crystals precipitate out of the mixture. Huh."
			mix_sound = 'sound/misc/fuse.ogg'

		itching // cogwerks
			name = "Itching Powder"
			id = "itching"
			result = "itching"
			required_reagents = list("ammonia" = 1, "fuel" = 1, "space_fungus" = 1)
			result_amount = 4
			mix_phrase = "The mixture congeals and dries up, leaving behind an abrasive powder."
			mix_sound = 'sound/effects/blobattack.ogg'

		antihistamine // cogwerks - basic sedatives could fill this role, or just put it in the medbay vendor?
			name = "Diphenhydramine"
			id = "diphenhydramine"
			result = "antihistamine"
			//required_temperature = 320
			result_amount = 4
			required_reagents = list("oil" = 1, "carbon" = 1, "bromine" = 1, "diethylamine" = 1, "ethanol" = 1)
			// benzhydryl(benzene+carbon) bromide + 2-dimethylaminoethanol
			mix_phrase = "The mixture fizzes gently."
			mix_sound = 'sound/misc/drinkfizz.ogg'

		sulfonal
			name = "Sulfonal"
			id = "sulfonal"
			result = "sulfonal"
			//required_temperature = 320
			result_amount = 2
			required_reagents = list("acetone" = 1, "diethylamine" = 1, "sulfur" = 1)
			mix_phrase = "The mixture gives off quite a stench."
			mix_sound = 'sound/misc/drinkfizz.ogg'

		salt
			name = "Salt"
			id = "salt"
			result = "salt"
			required_reagents = list("chlorine" = 1, "sodium" = 1, "water" = 1)
			result_amount = 2
			mix_phrase = "The solution crystallizes with a brief flare of light."

		saline
			name = "Saline-Glucose Solution"
			id = "saline"
			result = "saline"
			required_reagents = list("salt" = 1, "water" = 1, "sugar" = 1)
			result_amount = 3

		catdrugs
			name = "Cat Drugs"
			id = "catdrugs"
			result = "catdrugs"
			required_temperature = T0C + 100
			result_amount = 3
			required_reagents = list("catonium" = 1, "psilocybin" = 1, "ammonia" = 1, "fuel" = 1)
			mix_phrase = "The mixture hisses oddly."
			mix_sound = 'sound/effects/cat_hiss.ogg'

		boilpee // a shameful cogwerks. hobo chemistry, assistant-sourcable source of ammonia for various other reactions.
			name = "Boiled Pee"
			id = "boilpee"
			result = "ammonia"
			required_temperature = T0C + 80
			result_amount = 1
			required_reagents = list("urine" = 1, "water" = 1)
			mix_phrase = "The mixture bubbles and gives off a sharp odor."
			mix_sound = 'sound/misc/drinkfizz.ogg'

		crank // cogwerks - awful hobo drug that can be made by pissing in a bunch of vending machine stuff and then boiling it all with a welder
			name = "Crank"
			id = "crank"
			result = "crank"
			required_temperature = T0C + 100
			result_amount = 5
			instant = 1
			required_reagents = list("antihistamine" = 1, "ammonia" = 1, "lithium" = 1, "fuel" = 1, "acid" = 1)
			mix_phrase = "The mixture violently reacts, leaving behind a few crystalline shards."
			mix_sound = 'sound/effects/crystalshatter.ogg'
			on_reaction(var/datum/reagents/holder, var/created_volume)
				var/atom/my_atom = holder.my_atom // if you heat this stuff in your hand, you'll die! heh!
				get_fucked_clarks
				fireflash(holder.my_atom, 1)
				explosion(my_atom, get_turf(my_atom), -1, -1, 1, 2)
				return

		krokodil
			name = "Krokodil"
			id = "krokodil"
			result = "krokodil"
			required_temperature = T0C + 100
			result_amount = 5
			required_reagents = list("morphine" = 1, "antihistamine" = 1, "cleaner" = 1, "phosphorus" = 1, "potassium" = 1, "fuel" = 1)
			mix_phrase = "The mixture dries into a pale blue powder."
			mix_sound = 'sound/misc/fuse.ogg'

	/*	helldrug // the worst thing. if splashed on floor, create void turf. if ingested, replace mob with crunch critter and teleport user to hell
			name = "Cthonium"
			id = "cthonium"
			result = "cthonium"
			//required_temperature = 666
			result_amount = 2
			//required_reagents = list("el_diablo" = 1, "salts1" = 1,"mugwort" = 1, "catonium" = 1, "bloodc" = 1, "sulfur" = 1, "liquid spacetime" = 1, "strange_reagent" = 1)
			required_reagents = list("blood" = 1, "sulfur" = 1, "plasma" = 1)
			mix_phrase = "The mixture seems to have corrupted the very fabric of reality."
			mix_sound = 'airraid_loop.ogg'
			on_reaction(var/datum/reagents/holder, var/created_volume)
				bust_lights()
				creepify_station()
				return

		bleach
			name = "Bleach" // cogwerks WIP: could be useful for hobo chemistry, hair bleaching, stubborn stains, being a jerk and turning stuff white
			id = "bleach"
			result = "bleach"
			result_amount = 1
			required_reagents = list("sodium" = 1, "chlorine" = 1, "hydrogen" = 1)
			mix_phrase = "The mixture gives off a sharp odor much like bleach. Probably because it's bleach."
			mix_sound = 'sound/misc/drinkfizz.ogg'

		chlorine // cogwerks, more hobo chemistry
			name = "Chlorine"
			id = "chlorine"
			result = "chlorine"
			required_reagents = list("ammonia" = 1, "bleach" = 1 )
			result_amount = 1
			mix_phrase = "The mixture starts bubbling violently!"
			mix_sound = 'sound/misc/fuse.ogg'

			on_reaction(var/datum/reagents/holder, var/created_volume)
				var/location = get_turf(holder.my_atom)
				for(var/mob/M in AIviewers(5, location))
					boutput(M, "<span style=\"color:red\">The solution boils up into a choking cloud!</span>")
				src.mustard_gas = new /datum/effects/system/mustard_gas_spread/
				src.mustard_gas.attach(src)
				src.mustard_gas.set_up(5, 0, usr.loc)
				return */

		space_cleaner // COGWERKS CHEM REVISION PROJECT: add ethanol to this recipe
			name = "Space cleaner"
			id = "cleaner"
			result = "cleaner"
			required_reagents = list("ammonia" = 1, "ethanol" = 1, "water" = 1)
			result_amount = 3
			//mix_phrase = "The mixture begins to emit a distinct smell of bleach." -AMMONIA IS NOT BLEACH!!!!!!!!!! - grumpwerks
			mix_phrase = "Ick, this stuff really stinks. Sure does make the container sparkle though!"

		strange_reagent
			id = "strange_reagent"
			result = "strange_reagent"
			required_reagents = list("omnizine" = 1, "mutagen" = 1, "water_holy" = 1)
			result_amount = 2
			mix_phrase = "The substance begins moving on its own somehow."

		carpet
			name = "Carpet"
			id = "carpet"
			result = "carpet"
			required_reagents = list("space_fungus" = 1, "blood" = 1)
			result_amount = 2
			mix_phrase = "The substance turns thick and stiff, yet soft."

		badgrease
			name = "Partially Hydrogenated Space-Soybean Oil"
			id = "badgrease"
			result = "badgrease"
			required_reagents = list("grease" = 1, "hydrogen" = 1)
			required_temperature = T0C + 250
			result_amount = 2
			mix_phrase = "The mixture emits a burnt, oily smell."

		cornsyrup
			name = "Corn Syrup"
			id = "cornsyrup"
			result = "cornsyrup"
			required_reagents = list("cornstarch" = 1, "acid" = 1)
			required_temperature = T0C + 100
			result_amount = 2
			mix_phrase = "The mixture forms a viscous, clear fluid!"

		VHFCS
			name = "Very-High-Fructose Corn Syrup"
			id = "VHFCS"
			result = "VHFCS"
			required_reagents = list("cornsyrup" = 1, "denatured_enzyme" = 0)
			result_amount = 1
			mix_phrase = "The mixture emits a sickly-sweet smell."

		gravy
			name = "Gravy"
			id = "gravy"
			result = "gravy"
			required_reagents = list("porktonium" = 1, "milk" = 1, "cornstarch" = 1)
			result_amount = 3
			required_temperature = T0C + 100
			mix_phrase = "The substance thickens and takes on a meaty odor."

		pepperoni
			name = "Pepperoni"
			id = "pepperoni"
			result = "pepperoni"
			required_reagents = list("beff" = 1, "synthflesh" = 1, "saltpetre" = 1)
			result_amount = 2
			mix_phrase = "The beff and the synthflesh combine to form a smoky red log."
			mix_sound = 'sound/effects/blobattack.ogg'

		acetone
			name = "Acetone"
			id = "acetone"
			result = "acetone"
			required_reagents = list("oil" = 1, "fuel" = 1, "oxygen" = 1)
			result_amount = 3
			mix_phrase = "The smell of paint thinner assaults you as the solution bubbles."

		hairgrownium
			name = "Hairgrownium"
			id = "hairgrownium"
			result = "hairgrownium"
			required_reagents = list("synthflesh" = 1,"ephedrine" = 1,"carpet" = 1)
			result_amount = 3
			mix_phrase = "The liquid becomes slightly hairy."

		super_hairgrownium
			name = "Super Hairgrownium"
			id = "super_hairgrownium"
			result = "super_hairgrownium"
			required_reagents = list("hairgrownium" = 1, "methamphetamine" = 1, "iron" = 1)
			result_amount = 3
			mix_phrase = "The liquid becomes disgustingly furry and smells terrible."

		port
			name = "Port"
			id = "port"
			result = "port"
			required_reagents = list("wine" = 1, "sugar" = 1, "iron" = 1, "vodka" = 1)
			result_amount = 2
			mix_phrase = "The liquid darkens and emits a strong smell of alcohol."

		capulettium
			name = "Capulettium"
			id = "capulettium"
			result = "capulettium"
			required_reagents = list("neurotoxin" = 1, "chlorine" = 1, "hydrogen" = 1)
			result_amount = 1
			mix_phrase = "The smell of death wafts from the solution."

		capulettium_plus
			name = "Capulettium Plus"
			id = "capulettium_plus"
			result = "capulettium_plus"
			required_reagents = list("capulettium" = 1, "ephedrine" = 1, "methamphetamine" = 1)
			result_amount = 3
			mix_phrase = "The solution begins to slosh about violently by itself."

		something
			name = "Something"
			id = "something"
			result = "something"
			required_reagents = list("sorium" = 1, "ldmatter" = 1)
			result_amount = 2
			mix_phrase = "The solution swirls violently and forms...something."

		voltagen
			name = "Voltagen"
			id = "voltagen"
			result = "voltagen"
			required_reagents = list("ldmatter" = 1, "plasma" = 5, "uranium" = 1, "oil" = 1, "stabiliser" = 1)
			result_amount = 5
			mix_phrase = "The solution settles into a liquid form of electricity."
			mix_sound = 'sound/effects/elec_bigzap.ogg'

		energydrink
			name = "Energy Drink"
			id = "energydrink"
			result = "energydrink"
			required_reagents = list("voltagen" = 1, "coffee" = 1, "cola" = 3)
			result_amount = 5
			mix_phrase = "The solution emits a tutti frutti stench."

		voltagen_arc
			name = "Voltagen Arc"
			id = "voltagen_arc"
			required_reagents = list("ldmatter" = 1, "plasma" = 5, "uranium" = 1, "oil" = 1)
			instant = 1
			inhibitors = list("stabiliser")
			mix_phrase = "The solution settles into a liquid form of electricity but violently destabilizes!"
			mix_sound = 'sound/effects/elec_bigzap.ogg'
			on_reaction(var/datum/reagents/holder, var/created_volume)
				var/mob/living/target = usr
				if (!istype(target))
					target = locate() in view(5)
				if (!istype(target))
					return
				arcFlash(holder.my_atom, target, 500000)

/*
		montaguone
			name = "Montaguone"
			id = "montaguone"
			result = "montaguone"
			required_reagents = list("omnizine" = 1, "stypic_powder" = 1, "salbutamol" = 1)
			result_amount = 1
			mix_phrase = "The smell of spring drifts from the solution."

		montaguone_extra
			name = "Montaguone Extra"
			id = "montaguone_extra"
			result = "montaguone_extra"
			required_reagents = list("montaguone" = 1, "silver_sulfadiazine" = 1, "charcoal" = 1)
			result_amount = 3
			mix_phrase = "The solution starts to glow white slightly."
*/

		fermid
			name = "Fermid"
			id = "fermid"
			required_reagents = list("ants" = 1, "mutagen" = 1, "aranesp" = 1, "booster_enzyme" = 1 )
			instant = 1
			mix_phrase = "The ants begin to rapidly mutate!"
			var/static/reaction_count = 0

			on_reaction(var/datum/reagents/holder, var/created_volume)
				fucking_critter_bullshit_fuckcrap_limiter(reaction_count)
				new /obj/critter/fermid(get_turf(holder.my_atom))
				return

		life
			name = "Life"
			id = "life"
			result = "life"
			required_reagents = list("synthflesh" = 5, "blood" = 2, "strange_reagent" = 1 )
			result_amount = 8
			required_temperature = T0C + 100
			mix_phrase = "The substance begins to wriggle disgustingly and climbs out of its container!"
			var/static/reaction_count = 0

			on_reaction(var/datum/reagents/holder, var/created_volume)
				fucking_critter_bullshit_fuckcrap_limiter(reaction_count)
				var/result = 0
				var/roll = rand(1,100)
				if(roll + created_volume > 100) result = rand(95,100)
				else result = roll + created_volume

				switch(result)
					if(0) return
					if(1 to 70)
						new /mob/living/carbon/wall/meatcube(get_turf(holder.my_atom))
					if(71 to 94)
						var/critter = pick(/obj/critter/roach,/obj/critter/pig,/obj/critter/cat,/obj/critter/mouse,/obj/critter/spacebee,/obj/critter/owl,/obj/critter/goose,/obj/critter/domestic_bee,/obj/critter/walrus,/obj/critter/sealpup)
						new critter(get_turf(holder.my_atom))
					if(95 to 97)
						var/human = pick(/mob/living/carbon/human/normal/male,/mob/living/carbon/human/normal/female)
						new human(get_turf(holder.my_atom))
					if(98 to 100)
						new /mob/living/carbon/human/npc(get_turf(holder.my_atom))

				holder.remove_reagent("life",created_volume + 1) //+1 to prevent any of those weird errors where you get 5.423E-09 of something or whatever.
				return

		//Hello, here are some fake werewolf serum precursors
		werewolf_serum_fake1
			name = "Werewolf Serum Precursor Alpha"
			id = "werewolf_part1"
			result = "werewolf_part1"
			required_reagents = list("wolfsbane" = 1, "grog" = 1, "denatured_enzyme" = 0, "super_hairgrownium" = 1)
			result_amount = 4
			mix_phrase = "The substance burbles distressingly and takes a metallic shine."


		werewolf_serum_fake2
			name = "Werewolf Serum Precursor Beta"
			id = "werewolf_part2"
			result = "werewolf_part2"
			required_reagents = list("tongueofdog" = 1, "dna_mutagen" = 1, "omega_mutagen" = 1)
			result_amount = 3
			mix_phrase = "The substance flashes brilliantly, but quickly subsides."

		werewolf_serum_fake3
			name = "Werewolf Serum Precursor Gamma"
			id = "werewolf_part3"
			result = "werewolf_part3"
			required_reagents = list("werewolf_part1" = 1, "werewolf_part2" = 1)
			result_amount = 2
			required_temperature = T0C + 150

		werewolf_serum_fake4
			name = "Imperfect Werewolf Serum"
			id = "werewolf_part4"
			//result = "werewolf_part4"
			result = "lemonade"
			required_reagents = list("werewolf_part3" = 1, "tea" = 1)
			result_amount = 2
			mix_phrase = "The substance gives off a putrid stench!"

		werewolf_serum
			name = "Werewolf Serum"
			id = "werewolf_serum"
			result = "werewolf_serum"
			required_reagents = list("werewolf_part4" = 1, "badgrease" = 1, "stabiliser" = 1)
			result_amount = 3
			mix_phrase = "The substance bubbles and gives off an almost lupine howl."
			var/static/list/full_moon_days_2053 = list("Jan 04", "Feb 03", "Mar 04", "Apr 03", "May 02", "Jun 01", "Jul 01", "Jul 30", "Aug 29", "Sep 27", "Oct 27", "Nov 25", "Dec 25")

			on_reaction(var/datum/reagents/holder, var/created_volume)

				if (!(time2text(world.realtime, "MMM DD") in full_moon_days_2053))
					holder.my_atom.visible_message("<span style=\"color:red\">The solution bubbles even more rapidly and dissipates into nothing!</span>")
					holder.remove_reagent("werewolf_serum",created_volume + 1)
				return

		//Going to classif the preceding space (before vampire_serum, was removed in new version) an error, because two spaces causes a compile error.
		vampire_serum
		 	name = "Vampire Serum Omega"
		 	id = "vampire_serum"
		 	result =  "vampire_serum"
		 	required_reagents = list("bloodc" = 1, "water_holy" = 1, "werewolf_serum" = 1)
		 	result_amount = 3
		 	mix_phrase = "The substance gives off a coppery stink."

			//Super hairgrownium + Tongue of dog + Stable mutagen + Grog + Glowing Slurry + Aconitum

		colors
			name = "colorful reagent"
			id = "colors"
			result = "colors"
			required_reagents = list("plasma" = 1, "radium" = 1, "stabiliser" = 1, "space_drugs" = 1, "cryoxadone" = 1, "cocktail_citrus" = 1)
			result_amount = 6
			mix_phrase = "The substance flashes multiple colors and emits the smell of a pocket protector."

		fliptonium
			name = "fliptonium"
			id = "fliptonium"
			result = "fliptonium"
			required_reagents = list("sonic" = 1, "ldmatter" = 1, "chocolate" = 1, "ephedrine" = 1)
			result_amount = 4
			mix_phrase = "The mixture swirls around excitedly!"

		glowing_fliptonium
			name = "glowing fliptonium"
			id = "glowing_fliptonium"
			result = "glowing_fliptonium"
			required_reagents = list("fliptonium" = 1, "anima" = 1, "uranium" = 1, "space_drugs" = 1/*, "lumen" = 1*/) // Lumen reagent was removed.
			result_amount = 1
			mix_phrase = "The mixture swirls around and begins to glow strangely!"

		diluted_fliptonium
			name = "diluted fliptonium"
			id = "diluted_fliptonium"
			result = "diluted_fliptonium"
			required_reagents = list("fliptonium" = 1, "water" = 2)
			result_amount = 3
			mix_phrase = "The mixture swirls around in a kinda lackluster way. You feel pretty unimpressed."

		fartonium
			name = "fartonium"
			id = "fartonium"
			result = "fartonium"
			required_reagents = list("egg" = 1, "refried_beans" = 1, "yuck" = 1, "fakecheese" = 1)
			result_amount = 2
			mix_phrase = "The substance makes a little 'toot' noise and starts to smell pretty bad."
			mix_sound = 'sound/misc/poo2.ogg'

		flaptonium
			name = "flaptonium"
			id = "flaptonium"
			result = null //"flaptonium"
			required_reagents = list("egg" = 1, "colors" = 1, "chickensoup" = 1, "strange_reagent" = 1, "blood" = 1)
			instant = 1
			required_temperature = T0C + 100
			mix_phrase = "The substance turns an airy sky-blue and foams up into a new shape." // heh get it, get it, birds, sky, airy??? heh im the master of humor
			mix_sound = 'sound/misc/burp.ogg'
			var/static/reaction_count = 0

			on_reaction(var/datum/reagents/holder, var/created_volume)
				fucking_critter_bullshit_fuckcrap_limiter(reaction_count)
				var/turf/T = get_turf(holder.my_atom)
				var/obj/critter/parrot/P

				if (prob(1) && !already_a_dominic)
					P = new /obj/critter/parrot/eclectus/male(T)
					P.name = "Dominic"
					P.desc = "Who's a green chicken? It's him, the stinkosaurous rex, he's the green chicken! He's kissin', that bird is. He thought he could get away with it, but he was wrong."
					P.health = 100000
					already_a_dominic = 1
					return

				else
					P = new /obj/critter/parrot/random(T)

				holder.remove_reagent("egg")
				holder.remove_reagent("colors")
				holder.remove_reagent("chickensoup")
				holder.remove_reagent("strange_reagent")
				holder.remove_reagent("blood")
				return

		glitter
			name = "glitter"
			id = "glitter"
			result = "glitter"
			required_reagents = list("itching" = 1, "colors" = 1, "paper" = 1, "silver" = 1)
			result_amount = 4
			mix_phrase = "The mixture becomes far more fabulous!"

		rotting
			name = "rotting"
			id = "rotting"
			result = "rotting"
			required_reagents = list("yuck" = 1, "denatured_enzyme" = 1, "something" = 1)
			result_amount = 3
			mix_phrase = "The substance gives off a terrible stench. Are those maggots?"

		love
			name = "pure love"
			id = "love"
			result = "love"
			required_reagents = list("hugs" = 1, "chocolate" = 1)
			result_amount = 2
			mix_phrase = "The substance gives off a lovely scent!"

		big_bang_precursor
			name = "stable bose-einstein macro-condensate"
			id = "big_bang_precursor"
			result = "big_bang_precursor"
			required_reagents = list("ldmatter" = 1, "voltagen" = 12, "something" = 3)
			result_amount = 1
			mix_phrase = "The solution settles and congeals into a strange viscous fluid that seems to have the properties of both a liquid and a gas."
			required_temperature = T0C - 277

		big_bang
			name = "quark-gluon plasma"
			id = "big_bang"
			result = "big_bang"
			required_reagents = list("big_bang_precursor" = 1)
			result_amount = 50
			// This should really require a closed container and an extreme phase change... or some other pseudo-science thing
			mix_phrase = "A tiny point of light blooms within the material, and quickly grows to envelop the entire container. Your life flashes before your eyes."
			required_temperature = T0C + 6344 // IMPOSSIBRUUUU
			on_reaction(var/datum/reagents/holder, var/created_volume)
				var/location = get_turf(holder.my_atom)
				for(var/mob/M in AIviewers(5, location))
					boutput(M, "<span style=\"color:red\">You feel the air around you spark with electricity!</span>")

				location = get_turf(holder.my_atom)

				var/datum/effects/system/foam_spread/s = new()
				s.set_up(created_volume, location, holder, 0)
				s.start()
				holder.clear_reagents()
				return

		/* It's me. I'm the new merculite.
		nitrogen_triiodide
			name = "Nitrogen Triiodide"
			id = "nitrogentriiodide"
			result = "nitrotri_wet"
			required_reagents = list("lube" = 1, "iodine" = 2, "silver" = 1, "fluorine" = 1, "cryostylane" = 1) //, "perfluorodecalin" = 1, "oil" = 1, "chlorine" = 1)
			required_temperature = - 233 // -30 degrees celsius
			min_temperature = 200 //Will not react below 200 K

			/*
			Boron nitride: lube because boron nitride is a lubricant
			Iodine, silver and fluorine for I_2 + AgF -> IF + AgI
			Trichlorofluoromethane = cryostylane because it's a refrigerating agent
			Fallback:
			Trichlorofluoromethane  = perfluorodecalin, oil and chlorine
				In case nerds are being too nerdy.
			*/
			result_amount = 3
			mix_phrase = "The solution settles into a viscous paste."
		*/

		nitro_tri_explosion //This will just straight-up explode
			name = "NI3 Explosion"
			id = "nitrotri_explosion"
			result = "nitrotri_parent"
			required_reagents = list("nitrotri_dry" = 1)
			result_amount = 1
			mix_phrase = null
			mix_sound = null
/*
		lumen // Lumen reagent was removed.
			name = "lumen"
			id = "lumen"
			result = "lumen"
			required_reagents = list("voltagen" = 1, "fluorine" = 1, "phosphorus" = 1, "radium" = 1, "flashpowder" = 1)
			result_amount = 6
			mix_phrase = "The substance begins to glow intensively."
*/
		madness_toxin
			name = "Rajaijah"
			id = "madness_toxin"
			result = "madness_toxin"
			required_reagents = list("curare" = 1, "prions" = 1, "sarin" = 1, "methamphetamine" = 1, "mercury" = 1, "haloperidol" = 1, "sulfonal" = 1, "plasma" = 1)
			//required_temperature = 100 - T0C
			result_amount = 6
			mix_phrase = "The mixture forms a clear greenish liquid, emitting a nauseating smell reminiscent of chlorophyll and rubbing alcohol."
			mix_sound = 'sound/misc/drinkfizz.ogg'

		spiders // can also be made by eating unstable mutagen and ants and dancing - see human.dm
			name = "spiders"
			id = "spiders"
			result = "spiders"
			required_reagents = list("hugs" = 1, "ants" = 1)
			result_amount = 2
			mix_phrase = "The ants arachnify. What?"

		thalmerite_heat
			name = "thalmerite heating"
			id = "thalmerite_heat"
			required_reagents = list("thalmerite" = 1, "oxygen" = 1)
			result_amount = 1
			reaction_speed = 1
			reaction_temp_divider = 25
			instant = 0 //This one should actually not be instant
			mix_phrase = "The mixture starts to rapidly fizzle and heat up."

			on_reaction(var/datum/reagents/holder, var/created_volume)
				holder.temperature_reagents(holder.total_temperature + created_volume*200)

		cryostylane_cold
			name = "cryostylane chilling"
			id = "cryostylane_cold"
			required_reagents = list("cryostylane" = 1, "oxygen" = 1)
			result_amount = 1
			reaction_speed = 1
			reaction_temp_divider = 15
			instant = 0 //This one should actually not be instant
			mix_phrase = "The mixture begins to rapidly freeze."

			on_reaction(var/datum/reagents/holder, var/created_volume)
				holder.temperature_reagents(holder.total_temperature - created_volume*200)

		reversium
			name = "Reversium"
			id = "reversium"
			result = "reversium"
			required_reagents = list("fliptonium" = 1, "hugs" = 1, "dna_mutagen", )
			//required_temperature = 100 - T0C
			result_amount = 1
			mix_phrase = ".ylegnarts dnuora lriws ot snigeb erutxim ehT"
			mix_sound = 'sound/misc/drinkfizz.ogg'
#undef get_fucked_clarks