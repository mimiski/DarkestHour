//==============================================================================
// Darkest Hour: Europe '44-'45
// Darklight Games (c) 2008-2019
//==============================================================================

class DH_ShermanCannonShell extends DHCannonShell;

defaultproperties
{
    Speed=37358.0
    MaxSpeed=37358.0
    ShellDiameter=7.5
    BallisticCoefficient=1.735 //TODO: double check

    //Damage
    ImpactDamage=540
    ShellImpactDamage=class'DH_Vehicles.DH_ShermanCannonShellDamageAP'
    HullFireChance=0.37
    EngineFireChance=0.54

    //Penetration
    DHPenetrationTable(0)=8.8
    DHPenetrationTable(1)=8.5
    DHPenetrationTable(2)=8.1
    DHPenetrationTable(3)=7.7
    DHPenetrationTable(4)=7.3
    DHPenetrationTable(5)=6.9
    DHPenetrationTable(6)=6.5
    DHPenetrationTable(7)=6.2
    DHPenetrationTable(8)=5.9
    DHPenetrationTable(9)=5.3
    DHPenetrationTable(10)=4.7
}
