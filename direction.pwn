// github tnsawrld

#include <a_samp>
#include <Pawn.CMD>
#include <sscanf2>

new Text:TDirection[3];

main()
{
	print("\n----------------------------------");
	print(" COMPASS");
	print("----------------------------------\n");
}

public OnGameModeInit()
{
	LoadTextdraw();
	SetGameModeText("Blank Script");
	AddPlayerClass(0, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	return 1;
}

public OnGameModeExit()
{
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	SetPlayerPos(playerid, 1958.3783, 1343.1572, 15.3746);
	SetPlayerCameraPos(playerid, 1958.3783, 1343.1572, 15.3746);
	SetPlayerCameraLookAt(playerid, 1958.3783, 1343.1572, 15.3746);
	return 1;
}

public OnPlayerSpawn(playerid)
{
    //Menampilkan textdraw saat player spawn
    for(new i = 0; i < 3; i++)
    {
        TextDrawShowForPlayer(playerid, TDirection[i]);
    }
    //Untuk mengupdate direction setiap 500 milidetik
    SetTimerEx("UpdateDirection", 500, true, "i", playerid);
	return 1;
}


forward UpdateDirection(playerid);
public UpdateDirection(playerid)
{
    //Variabel untuk menampung semua data angle sementara.
    new Float:DirectionAngle, Directions[3], DirectionsFull[10];

    //Kenapa mengunakan ini? saat kita naik kendaraan, textdraw akan terhenti terupdate karena tidak dapat kembali mendapatkan angle dari pemain.
    if(IsPlayerInAnyVehicle(playerid))
    {
        //Textdraw akan aktif dan tetap berjalan karena mendapatkan angle dari kendaraan yang dipakai.
        new vehicleid = GetPlayerVehicleID(playerid);
        GetVehicleZAngle(vehicleid, DirectionAngle);
    }
    else
    {
        //Akan berfungsi saat player tidak sedang menaiki kendaraan dalam artian berjalan.
        GetPlayerFacingAngle(playerid, DirectionAngle);
    }

    //Mendapatkan arah mata angin dari koordinat angle yang telah didapatkan lalu di tampilkan ke textdraw.
    GetDirection(DirectionAngle, Directions, sizeof(Directions));
    TextDrawSetString(TDirection[0], Directions);

    //Mendapatkan arah mata angin dari koordinat angle yang telah didapatkan lalu di tampilkan ke textdraw.
    GetDirectionFull(DirectionAngle, DirectionsFull, sizeof(DirectionsFull));
    TextDrawSetString(TDirection[1], DirectionsFull);

    //Untuk mengupdate textdraw arah derajat pemain.
    new str[128];
    format(str, sizeof(str), "%.01fo", DirectionAngle);
    TextDrawSetString(TDirection[2], str);
    return 1;
}

LoadTextdraw()
{
    TDirection[0] = TextDrawCreate(52.000000, 291.000000, "NW");
    TextDrawFont(TDirection[0], 1);
    TextDrawLetterSize(TDirection[0], 0.441666, 1.549998);
    TextDrawTextSize(TDirection[0], 400.000000, 17.000000);
    TextDrawSetOutline(TDirection[0], 1);
    TextDrawSetShadow(TDirection[0], 0);
    TextDrawAlignment(TDirection[0], 1);
    TextDrawColor(TDirection[0], -2686721);
    TextDrawBackgroundColor(TDirection[0], 255);
    TextDrawBoxColor(TDirection[0], 50);
    TextDrawUseBox(TDirection[0], 0);
    TextDrawSetProportional(TDirection[0], 1);
    TextDrawSetSelectable(TDirection[0], 0);

    TDirection[1] = TextDrawCreate(53.000000, 303.000000, "Northeast");
    TextDrawFont(TDirection[1], 1);
    TextDrawLetterSize(TDirection[1], 0.254166, 1.199998);
    TextDrawTextSize(TDirection[1], 400.000000, 17.000000);
    TextDrawSetOutline(TDirection[1], 1);
    TextDrawSetShadow(TDirection[1], 0);
    TextDrawAlignment(TDirection[1], 1);
    TextDrawColor(TDirection[1], -1094795521);
    TextDrawBackgroundColor(TDirection[1], 255);
    TextDrawBoxColor(TDirection[1], 50);
    TextDrawUseBox(TDirection[1], 0);
    TextDrawSetProportional(TDirection[1], 1);
    TextDrawSetSelectable(TDirection[1], 0);

    TDirection[2] = TextDrawCreate(54.000000, 313.000000, "360o");
    TextDrawFont(TDirection[2], 1);
    TextDrawLetterSize(TDirection[2], 0.254166, 1.199998);
    TextDrawTextSize(TDirection[2], 400.000000, 17.000000);
    TextDrawSetOutline(TDirection[2], 1);
    TextDrawSetShadow(TDirection[2], 0);
    TextDrawAlignment(TDirection[2], 1);
    TextDrawColor(TDirection[2], -1);
    TextDrawBackgroundColor(TDirection[2], 255);
    TextDrawBoxColor(TDirection[2], 50);
    TextDrawUseBox(TDirection[2], 0);
    TextDrawSetProportional(TDirection[2], 1);
    TextDrawSetSelectable(TDirection[2], 0);
}

stock GetDirection(Float:angle, dir[], len)
{
    if ((angle >= 337.5 || angle < 22.5))
        format(dir, len, "N");
    else if (angle >= 22.5 && angle < 67.5)
        format(dir, len, "NE");
    else if (angle >= 67.5 && angle < 112.5)
        format(dir, len, "E");
    else if (angle >= 112.5 && angle < 157.5)
        format(dir, len, "SE");
    else if (angle >= 157.5 && angle < 202.5)
        format(dir, len, "S");
    else if (angle >= 202.5 && angle < 247.5)
        format(dir, len, "SW");
    else if (angle >= 247.5 && angle < 292.5)
        format(dir, len, "W");
    else if (angle >= 292.5 && angle < 337.5)
        format(dir, len, "NW");
    else
        format(dir, len, "N"); 
}

stock GetDirectionFull(Float:angle, dir[], len)
{
    if ((angle >= 337.5 || angle < 22.5))
        format(dir, len, "North");
    else if (angle >= 22.5 && angle < 67.5)
        format(dir, len, "Northeast");
    else if (angle >= 67.5 && angle < 112.5)
        format(dir, len, "East");
    else if (angle >= 112.5 && angle < 157.5)
        format(dir, len, "Southeast");
    else if (angle >= 157.5 && angle < 202.5)
        format(dir, len, "South");
    else if (angle >= 202.5 && angle < 247.5)
        format(dir, len, "Southwest");
    else if (angle >= 247.5 && angle < 292.5)
        format(dir, len, "West");
    else if (angle >= 292.5 && angle < 337.5)
        format(dir, len, "Northwest");
    else
        format(dir, len, "North"); 
}

//Optional
CMD:veh(playerid, params[])
{
    new idveh, color1, color2;
    if(sscanf(params, "iii", idveh, color1, color2)) return SendClientMessage(playerid, -1, "/veh [id][color][color]");
    new Float:pX, Float:pY, Float:pZ, Float:pA;
    GetPlayerPos(playerid, pX, pY, pZ);
    GetPlayerFacingAngle(playerid, pA);
    CreateVehicle(idveh, pX, (pY+5), pZ, pA, color1, color2, -1, 0);
    return 1;
}