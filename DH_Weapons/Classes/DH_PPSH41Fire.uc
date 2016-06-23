//==============================================================================
// Darkest Hour: Europe '44-'45
// Darklight Games (c) 2008-2016
//==============================================================================

class DH_PPSH41Fire extends DHFastAutoFire;


simulated function HandleRecoil()
{
    local rotator NewRecoilRotation;
    local ROPlayer ROP;
    local ROPawn ROPwn;

    if( Instigator != none )
    {
        ROP = ROPlayer(Instigator.Controller);
        ROPwn = ROPawn(Instigator);
    }

    if( ROP == none || ROPwn == none )
        return;

    if( !ROP.bFreeCamera )
    {
        NewRecoilRotation.Pitch = RandRange( maxVerticalRecoilAngle * 0.75, maxVerticalRecoilAngle );
        NewRecoilRotation.Yaw = RandRange( maxHorizontalRecoilAngle * 0.75, maxHorizontalRecoilAngle );

        if( Rand( 2 ) == 1 )
            NewRecoilRotation.Yaw *= -1;

        if( Instigator.Physics == PHYS_Falling )
        {
            NewRecoilRotation *= 3;
        }

        // WeaponTODO: Put bipod and resting modifiers in here
        if( Instigator.bIsCrouched )
        {
            NewRecoilRotation *= PctCrouchRecoil;

            // player is crouched and in iron sights
            if( Weapon.bUsingSights )
            {
                NewRecoilRotation *= PctCrouchIronRecoil;
            }
        }
        else if( Instigator.bIsCrawling )
        {
            NewRecoilRotation *= PctProneRecoil;

            // player is prone and in iron sights
            if( Weapon.bUsingSights )
            {
                NewRecoilRotation *= PctProneIronRecoil;
            }
        }
        else if( Weapon.bUsingSights )
        {
            NewRecoilRotation *= PctStandIronRecoil;
        }

        if( ROPwn.bRestingWeapon )
            NewRecoilRotation *= PctRestDeployRecoil;

        if( Instigator.bBipodDeployed )
        {
            NewRecoilRotation *= PctBipodDeployRecoil;
        }

        if( ROPwn.LeanAmount != 0 )
        {
            NewRecoilRotation *= PctLeanPenalty;
        }

        // Need to set this value per weapon
        ROP.SetRecoil(NewRecoilRotation,RecoilRate);
    }

// Add Fire Blur
    if( Level.NetMode != NM_DedicatedServer )
    {
        if( Instigator != None )
        {
            if( ROPlayer( Instigator.Controller ) != None )
            {
                if( Weapon.bUsingSights )
                {
                    ROPlayer( Instigator.Controller ).AddBlur( 0.1, 0.1 );
                }
                else
                {
                    ROPlayer( Instigator.Controller ).AddBlur( 0.01, 0.1 );
                }
            }
        }
    }
}

defaultproperties
{
     FireEndSound=SoundGroup'Inf_Weapons.ppsh41.ppsh41_fire_end'
     AmbientFireSoundRadius=750.000000
     AmbientFireSound=SoundGroup'Inf_Weapons.ppsh41.ppsh41_fire_loop'
     AmbientFireVolume=255
     //compile error  ServerProjectileClass=Class'DH_Weapons.DH_PPSh41Bullet_S'
     ProjSpawnOffset=(X=25.000000)
     FAProjSpawnOffset=(X=-20.000000)
     FireIronAnim="Iron_Shoot_Loop"
     FireIronLoopAnim="Iron_Shoot_Loop"
     FireIronEndAnim="Iron_Shoot_End"
     maxVerticalRecoilAngle=600
     maxHorizontalRecoilAngle=110
     RecoilRate=0.050000
     ShellEjectClass=Class'ROAmmo.ShellEject1st762x25mm'
     ShellIronSightOffset=(X=15.000000)
     ShellRotOffsetIron=(Pitch=11000)
     PreFireAnim="Shoot1_start"
     FireAnim="Shoot_Loop"
     FireLoopAnim="Shoot_Loop"
     FireEndAnim="Shoot_End"
     TweenTime=0.000000
     FireRate=0.066700
     AmmoClass=Class'ROAmmo.SMG71Rd762x25Ammo'
     ShakeRotMag=(X=50.000000,Y=50.000000,Z=150.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=0.500000
     ShakeOffsetMag=(X=3.000000,Y=1.000000,Z=3.000000)
     ShakeOffsetRate=(X=1000.000000,Y=1000.000000,Z=1000.000000)
     ShakeOffsetTime=1.000000
     ProjectileClass=Class'DH_Weapons.DH_PPSH41Bullet'
     BotRefireRate=0.990000
     WarnTargetPct=0.900000
     FlashEmitterClass=Class'ROEffects.MuzzleFlash1stPPSH'
     SmokeEmitterClass=Class'ROEffects.ROMuzzleSmoke'
     aimerror=1800.000000
     Spread=320.000000
     SpreadStyle=SS_Random
}
