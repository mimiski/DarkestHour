//==============================================================================
// Darkest Hour: Europe '44-'45
// Darklight Games (c) 2008-2019
//==============================================================================

class DH_ShermanCannonShellHE extends DHCannonShellHE;

defaultproperties
{
    Speed=27943.0
    MaxSpeed=27943.0
    ShellDiameter=7.5
    BallisticCoefficient=1.686 //TODO: double check

    //Damage
    ImpactDamage=475
    PenetrationMag=1000.0
    Damage=415.0
    DamageRadius=1550.0
    HullFireChance=0.34
    EngineFireChance=0.48

    //Penetration
    DHPenetrationTable(0)=3.3
    DHPenetrationTable(1)=3.1
    DHPenetrationTable(2)=2.8
    DHPenetrationTable(3)=2.4
    DHPenetrationTable(4)=2.0
    DHPenetrationTable(5)=1.7
    DHPenetrationTable(6)=1.3
    DHPenetrationTable(7)=1.1
    DHPenetrationTable(8)=0.9
    DHPenetrationTable(9)=0.5
    DHPenetrationTable(10)=0.3
}
