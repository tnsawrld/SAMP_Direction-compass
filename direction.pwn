// github tnsawrld

#include <a_samp>
#include <Pawn.CMD>
#include <sscanf2>

new PlayerText:TDirection[MAX_PLAYERS][3];

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
        PlayerTextDrawShow(playerid, TDirection[playerid][i]);
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
    PlayerTextDrawSetString(playerid, TDirection[0], Directions);

    //Mendapatkan arah mata angin dari koordinat angle yang telah didapatkan lalu di tampilkan ke textdraw.
    GetDirectionFull(DirectionAngle, DirectionsFull, sizeof(DirectionsFull));
    PlayerTextDrawSetString(playerid, TDirection[1], DirectionsFull);

    //Untuk mengupdate textdraw arah derajat pemain.
    new str[128];
    format(str, sizeof(str), "%.01fo", DirectionAngle);
    TextDrawSetString(TDirection[2], str);
    PlayerTextDrawSetString(playerid, TDirection[2], str);
    return 1;
}

LoadTextdraw()
{
    TDirection[playerid][0] = CreatePlayerTextDraw(playerid, 53.000000, 290.000000, "NW");
    PlayerTextDrawFont(playerid, TDirection[playerid][0], 1);
    PlayerTextDrawLetterSize(playerid, TDirection[playerid][0], 0.441666, 1.549998);
    PlayerTextDrawTextSize(playerid, TDirection[playerid][0], 400.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, TDirection[playerid][0], 1);
    PlayerTextDrawSetShadow(playerid, TDirection[playerid][0], 0);
    PlayerTextDrawAlignment(playerid, TDirection[playerid][0], 1);
    PlayerTextDrawColor(playerid, TDirection[playerid][0], -2686721);
    PlayerTextDrawBackgroundColor(playerid, TDirection[playerid][0], 255);
    PlayerTextDrawBoxColor(playerid, TDirection[playerid][0], 50);
    PlayerTextDrawUseBox(playerid, TDirection[playerid][0], 0);
    PlayerTextDrawSetProportional(playerid, TDirection[playerid][0], 1);
    PlayerTextDrawSetSelectable(playerid, TDirection[playerid][0], 0);

    TDirection[playerid][1] = CreatePlayerTextDraw(playerid, 53.000000, 303.000000, "Northeast");
    PlayerTextDrawFont(playerid, TDirection[playerid][1], 1);
    PlayerTextDrawLetterSize(playerid, TDirection[playerid][1], 0.254166, 1.199998);
    PlayerTextDrawTextSize(playerid, TDirection[playerid][1], 400.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, TDirection[playerid][1], 1);
    PlayerTextDrawSetShadow(playerid, TDirection[playerid][1], 0);
    PlayerTextDrawAlignment(playerid, TDirection[playerid][1], 1);
    PlayerTextDrawColor(playerid, TDirection[playerid][1], -1094795521);
    PlayerTextDrawBackgroundColor(playerid, TDirection[playerid][1], 255);
    PlayerTextDrawBoxColor(playerid, TDirection[playerid][1], 50);
    PlayerTextDrawUseBox(playerid, TDirection[playerid][1], 0);
    PlayerTextDrawSetProportional(playerid, TDirection[playerid][1], 1);
    PlayerTextDrawSetSelectable(playerid, TDirection[playerid][1], 0);

    TDirection[playerid][2] = CreatePlayerTextDraw(playerid, 54.000000, 313.000000, "360o");
    PlayerTextDrawFont(playerid, TDirection[playerid][2], 1);
    PlayerTextDrawLetterSize(playerid, TDirection[playerid][2], 0.254166, 1.199998);
    PlayerTextDrawTextSize(playerid, TDirection[playerid][2], 400.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, TDirection[playerid][2], 1);
    PlayerTextDrawSetShadow(playerid, TDirection[playerid][2], 0);
    PlayerTextDrawAlignment(playerid, TDirection[playerid][2], 1);
    PlayerTextDrawColor(playerid, TDirection[playerid][2], -1);
    PlayerTextDrawBackgroundColor(playerid, TDirection[playerid][2], 255);
    PlayerTextDrawBoxColor(playerid, TDirection[playerid][2], 50);
    PlayerTextDrawUseBox(playerid, TDirection[playerid][2], 0);
    PlayerTextDrawSetProportional(playerid, TDirection[playerid][2], 1);
    PlayerTextDrawSetSelectable(playerid, TDirection[playerid][2], 0);
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