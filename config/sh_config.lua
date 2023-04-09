RDEV_SH = {
    ESX_1_1 = true,
    Logo = 'assets/svg/logo.svg', -- you can also put a link in here
    Server_Name1 = 'RARE2',
    Server_Name2 = 'ROLEPLAY',
    AllowedGroups = {
        'superadmin',
        'projektleitung',
        'admin'
    },
    StringReplaces = { -- for press E
        {
            replace = '~INPUT_CONTEXT~', -- what to replace
            string = 'E' -- with what it gets replaced
        },
        {
            replace = '~INPUT_PICKUP~', -- what to replace
            string = 'E' -- with what it gets replaced
        },
    },
    Voice = {
        Handler = 'salty', -- salty, mumble or pma
        Ranges = {
            [1] = 4.0,
            [2] = 8.0,
            [3] = 16.0,
        }
    },
    WeaponMap = json.decode([[
        {
            "melee": {
                "Dolch": "-1834847097",
                "Baseball Schhläger": "-1786099057",
                "Flasche": "-102323637",
                "Brecheisen": "-2067956739",
                "Unbewaffnet": "0xA2719263",
                "Taschenlampe": "-1951375401",
                "Golfschläger": "1141786504",
                "Hammer": "1317494643",
                "Axt": "-102973651",
                "Schlagring": "-656458692",
                "Messer": "-1716189206",
                "Machete": "-581044007",
                "Klappmesser": "-538741184",
                "Schlagstock": "1737195953",
                "Schraubenschlüssel": "419712736",
                "Kampf Axt ": "-853065399",
                "Billard Kö": "-1810795771",
                "Stein Beil": "0x3813FC08"
            },
            "handguns": {
                "Pistole": "453432689",
                "Pistole MK2": "3219281620",
                "Gefechtspistole": "1593441988",
                "Ap Pistole": "584646201",
                "Tazer": "911657153",
                ".50 Kaliber": "-1716589765",
                "Sns Pistole": "-1076751822",
                "Sns Pistole MK2": "0x88374054",
                "Schwere Pistole": "-771403250",
                "Klassische Pistole": "137902532",
                "Leuchtpistole": "1198879012",
                "Marksman Pistole": "-598887786",
                "Revolver": "-1045183535",
                "Revolver MK2": "0xCB96392F",
                "Revolver Doubleaction": "0x97EA20B8",
                "Strahlen Pistole": "0xAF3696A1"
            },
            "smg": {
                "Uzi": "324215364",
                "Smg": "736523883",
                "Smg MK2": "2024373456",
                "P90 MG": "-1660422300",
                "Gefechts PDW": "171789620",
                "Maschinen Pistole": "-619010992",
                "Mini SMG": "-1121678507",
                "Raycarbine": "0x476BF155"
            },
            "shotguns": {
                "Pumpgun": "487013001",
                "Pumpgun MK2": "0x555AF99A",
                "Abgesägte Schrotflinte": "2017895192",
                "Angriffsschrotflinte": "0xE284C527",
                "Bullpup Pumpgun": "-1654528753",
                "Muskete": "-1466123874",
                "Schwere Pumpgun": "984333226",
                "Doppelte Schrotflinte": "-275439685",
                "Automatische Schrotflinte": "317205821"
            },
            "assaultrifle": {
                "AK-47": "-1074790547",
                "AK47 MK2": "961495388",
                "Karabiner": "-2084633992",
                "Karabiner MK2": "4208062921",
                "Kampfgewehr": "-1357824103",
                "Spezialkarabiner": "-1063057011",
                "Spezialkarabiner MK2": "-1768145561",
                "Bullpup Gewehr": "2132975508",
                "Bullpup Gewehr MK2": "0x84D6FAFD",
                "Kompaktes Gewehr": "1649403952"
            },
            "machine_guns": {
                "MG": "-1660422300",
                "GefechtsMG": "2144741730",
                "GefechtsMG MK2": "3686625920",
                "Gusenberg": "1627465347"
            },
            "Sniper": {
                "Scharfschützengewehr": "100416529",
                "Schweres Scharfschützengewehr": "205991906",
                "Schweres Scharfschützengewehr MK2": "177293209",
                "Präzisionsgewehr": "-952879014",
                "Marksmangewehr MK2": "0x6A6C02E0"
            },
            "heavy_weapons": {
                "RPG": "0xB1CA77B1",
                "Granatenwerfer": "0xA284510B",
                "Granatenwerfer Rauch": "0x4DD2DC56",
                "Minigun": "0x42BF8A85",
                "Feuerwerk": "0x7F7497E5",
                "Railgun": "0x6D544C99",
                "hominglauncher": "0x63AB0442",
                "compactlauncher": "0x781FE4A",
                "rayminigun": "0xB62D1F67"
            },
            "throwables": {
                "Granate": "0x93E220BD",
                "Tränengas": "0xA0973D5E",
                "Rauchgranate": "0xFDBC8A50",
                "Flaer": "0x497FACC3",
                "Molotov": "0x24B17070",
                "Haftbombe": "0x2C3731D9",
                "Proxmine": "0xAB564B93",
                "Schneeball": "0x787F0BB",
                "Pipebombe": "0xBA45E8B8",
                "Baseball": "0x23C9F95C"
            },
            "misc": {
                "Bezinkanister": "883325847",
                "Feuerlöscher": "0x60EC506",
                "Fallschirm": "0xFBAB5776"
            }
        }
    ]])
}