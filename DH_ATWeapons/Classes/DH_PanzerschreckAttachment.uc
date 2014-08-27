//=============================================================================
// DH_PanzerschreckAttachment
//=============================================================================


class DH_PanzerschreckAttachment extends DHWeaponAttachment;

var()   name            ExhaustBoneName;
var     class<Emitter>          mExhFlashClass;
var     Emitter                 mExhFlash3rd;


// Overridden because the 3rd person effects are handled differently for the panzerfaust
simulated function PostBeginPlay()
{
    if (Role == ROLE_Authority)
    {
        bOldBayonetAttached = bBayonetAttached;
        bOldBarrelSteamActive = bBarrelSteamActive;
        bUpdated = true;
    }
}

// Overridden because the 3rd person effects are handled differently for the panzerfaust
simulated event ThirdPersonEffects()
{

    if (Level.NetMode == NM_DedicatedServer || ROPawn(Instigator) == none)
        return;

    if (FlashCount > 0 && ((FiringMode == 0) || bAltFireFlash))
    {
        if ((Level.TimeSeconds - LastRenderTime > 0.2) && (PlayerController(Instigator.Controller) == none))
            return;

        WeaponLight();

        mMuzFlash3rd = Spawn(mMuzFlashClass);
        AttachToBone(mMuzFlash3rd, MuzzleBoneName);

        mExhFlash3rd = Spawn(mExhFlashClass);
        AttachToBone(mExhFlash3rd, ExhaustBoneName);

    }

        if (FlashCount == 0)
        {
                ROPawn(Instigator).StopFiring();
        }
        else if (FiringMode == 0)
        {
                ROPawn(Instigator).StartFiring(false, bRapidFire);
        }
        else
        {
                ROPawn(Instigator).StartFiring(true, bAltRapidFire);
        }

}

defaultproperties
{
     ExhaustBoneName="ejector"
     mExhFlashClass=Class'DH_ATWeapons.DH_Bazooka3rdPersonExhaustFX'
     PA_AssistedReloadAnim="crouch_reloadA_bazooka"
     mMuzFlashClass=Class'DH_ATWeapons.DH_Bazooka3rdPersonMuzzleFX'
     MuzzleBoneName="Muzzle"
     PA_MovementAnims(0)="stand_jogF_kar"
     PA_MovementAnims(1)="stand_jogB_kar"
     PA_MovementAnims(2)="stand_jogL_kar"
     PA_MovementAnims(3)="stand_jogR_kar"
     PA_MovementAnims(4)="stand_jogFL_kar"
     PA_MovementAnims(5)="stand_jogFR_kar"
     PA_MovementAnims(6)="stand_jogBL_kar"
     PA_MovementAnims(7)="stand_jogBR_kar"
     PA_CrouchAnims(0)="crouch_walkF_kar"
     PA_CrouchAnims(1)="crouch_walkB_kar"
     PA_CrouchAnims(2)="crouch_walkL_kar"
     PA_CrouchAnims(3)="crouch_walkR_kar"
     PA_CrouchAnims(4)="crouch_walkFL_kar"
     PA_CrouchAnims(5)="crouch_walkFR_kar"
     PA_CrouchAnims(6)="crouch_walkBL_kar"
     PA_CrouchAnims(7)="crouch_walkBR_kar"
     PA_WalkAnims(0)="stand_walkFhip_kar"
     PA_WalkAnims(1)="stand_walkBhip_kar"
     PA_WalkAnims(2)="stand_walkLhip_kar"
     PA_WalkAnims(3)="stand_walkRhip_kar"
     PA_WalkAnims(4)="stand_walkFLhip_kar"
     PA_WalkAnims(5)="stand_walkFRhip_kar"
     PA_WalkAnims(6)="stand_walkBLhip_kar"
     PA_WalkAnims(7)="stand_walkBRhip_kar"
     PA_WalkIronAnims(0)="stand_walkFiron_bazooka"
     PA_WalkIronAnims(1)="stand_walkBiron_kar"
     PA_WalkIronAnims(2)="stand_walkLiron_kar"
     PA_WalkIronAnims(3)="stand_walkRiron_kar"
     PA_WalkIronAnims(4)="stand_walkFLiron_bazooka"
     PA_WalkIronAnims(5)="stand_walkFRiron_bazooka"
     PA_WalkIronAnims(6)="stand_walkBLiron_kar"
     PA_WalkIronAnims(7)="stand_walkBRiron_kar"
     PA_SprintAnims(0)="stand_sprintF_kar"
     PA_SprintAnims(1)="stand_sprintB_kar"
     PA_SprintAnims(2)="stand_sprintL_kar"
     PA_SprintAnims(3)="stand_sprintR_kar"
     PA_SprintAnims(4)="stand_sprintFL_kar"
     PA_SprintAnims(5)="stand_sprintFR_kar"
     PA_SprintAnims(6)="stand_sprintBL_kar"
     PA_SprintAnims(7)="stand_sprintBR_kar"
     PA_SprintCrouchAnims(0)="crouch_sprintF_kar"
     PA_SprintCrouchAnims(1)="crouch_sprintB_kar"
     PA_SprintCrouchAnims(2)="crouch_sprintL_kar"
     PA_SprintCrouchAnims(3)="crouch_sprintR_kar"
     PA_SprintCrouchAnims(4)="crouch_sprintFL_kar"
     PA_SprintCrouchAnims(5)="crouch_sprintFR_kar"
     PA_SprintCrouchAnims(6)="crouch_sprintBL_kar"
     PA_SprintCrouchAnims(7)="crouch_sprintBR_kar"
     PA_TurnRightAnim="stand_turnRhip_kar"
     PA_TurnLeftAnim="stand_turnLhip_kar"
     PA_TurnIronRightAnim="stand_turnRiron_kar"
     PA_TurnIronLeftAnim="stand_turnLiron_kar"
     PA_CrouchTurnIronRightAnim="crouch_turnRiron_bazooka"
     PA_CrouchTurnIronLeftAnim="crouch_turnRiron_bazooka"
     PA_StandToProneAnim="StandtoProne_kar"
     PA_CrouchToProneAnim="CrouchtoProne_kar"
     PA_ProneToStandAnim="PronetoStand_kar"
     PA_ProneToCrouchAnim="PronetoCrouch_kar"
     PA_DiveToProneStartAnim="prone_diveF_kar"
     PA_DiveToProneEndAnim="prone_diveend_kar"
     PA_CrouchIdleRestAnim="crouch_idle_bazooka"
     PA_IdleCrouchAnim="crouch_idle_bazooka"
     PA_IdleRestAnim="stand_idlehip_bazooka"
     PA_IdleWeaponAnim="stand_idlehip_bazooka"
     PA_IdleIronRestAnim="stand_idleiron_bazooka"
     PA_IdleIronWeaponAnim="stand_idleiron_bazooka"
     PA_IdleCrouchIronWeaponAnim="crouch_ironidle_bazooka"
     PA_ReloadAnim="crouch_reloadS_Panzerschreck"
     PA_ReloadEmptyAnim="crouch_reloadS_Panzerschreck"
     PA_ProneReloadEmptyAnim="prone_reload_kar"
     PA_ProneIdleRestAnim="prone_idle_kar"
     PA_BayonetAttachAnim="bayattach_kar"
     PA_ProneBayonetAttachAnim="prone_Bayattach_kar"
     PA_BayonetDetachAnim="bayremove_kar"
     PA_ProneBayonetDetachAnim="prone_Bayremove_kar"
     PA_Fire="stand_shootiron_kar"
     PA_IronFire="stand_shootiron_kar"
     PA_CrouchFire="crouch_shoot_kar"
     PA_CrouchIronFire="crouch_ironshoot_bazooka"
     PA_ProneFire="prone_shoot_kar"
     PA_MoveStandFire(0)="stand_shootiron_kar"
     PA_MoveStandFire(1)="stand_shootiron_kar"
     PA_MoveStandFire(2)="stand_shootLRiron_kar"
     PA_MoveStandFire(3)="stand_shootLRiron_kar"
     PA_MoveStandFire(4)="stand_shootFLiron_kar"
     PA_MoveStandFire(5)="stand_shootFRiron_kar"
     PA_MoveStandFire(6)="stand_shootFRiron_kar"
     PA_MoveStandFire(7)="stand_shootFLiron_kar"
     PA_MoveCrouchFire(0)="crouch_shootF_kar"
     PA_MoveCrouchFire(1)="crouch_shootF_kar"
     PA_MoveCrouchFire(2)="crouch_shootLR_kar"
     PA_MoveCrouchFire(3)="crouch_shootLR_kar"
     PA_MoveCrouchFire(4)="crouch_shootF_kar"
     PA_MoveCrouchFire(5)="crouch_shootF_kar"
     PA_MoveCrouchFire(6)="crouch_shootF_kar"
     PA_MoveCrouchFire(7)="crouch_shootF_kar"
     PA_MoveWalkFire(0)="stand_shootFwalk_kar"
     PA_MoveWalkFire(1)="stand_shootFwalk_kar"
     PA_MoveWalkFire(2)="stand_shootLRwalk_kar"
     PA_MoveWalkFire(3)="stand_shootLRwalk_kar"
     PA_MoveWalkFire(4)="stand_shootFLwalk_kar"
     PA_MoveWalkFire(5)="stand_shootFRwalk_kar"
     PA_MoveWalkFire(6)="stand_shootFRwalk_kar"
     PA_MoveWalkFire(7)="stand_shootFLwalk_kar"
     PA_MoveStandIronFire(0)="stand_shootiron_kar"
     PA_MoveStandIronFire(1)="stand_shootiron_fausr"
     PA_MoveStandIronFire(2)="stand_shootLRiron_kar"
     PA_MoveStandIronFire(3)="stand_shootLRiron_kar"
     PA_MoveStandIronFire(4)="stand_shootFLiron_kar"
     PA_MoveStandIronFire(5)="stand_shootFRiron_kar"
     PA_MoveStandIronFire(6)="stand_shootFRiron_kar"
     PA_MoveStandIronFire(7)="stand_shootFLiron_kar"
     PA_AltFire="stand_idlestrike_kar"
     PA_CrouchAltFire="stand_idlestrike_kar"
     PA_ProneAltFire="prone_idlestrike_bayo"
     PA_BayonetAltFire="baystrike_kar"
     PA_CrouchBayonetAltFire="baystrike_kar"
     PA_ProneBayonetAltFire="baystrike_kar"
     PA_FireLastShot="stand_shoothip_kar"
     PA_IronFireLastShot="crouch_ironshoot_bazooka"
     PA_CrouchFireLastShot="crouch_ironshoot_bazooka"
     PA_ProneFireLastShot="prone_shoot_kar"
     WA_Idle="idle_panzerschreck"
     WA_Fire="idle_panzerschreck"
     WA_Reload="reloadS_panzerschreck"
     MenuImage=Texture'DH_InterfaceArt_tex.weapon_icons.Panzerschreck_icon'
     MenuDescription="RPzB.54 Panzerschreck 'Tank Terror': German recoiless anti-tank weapon patterned after the American 'Bazooka'. Fires a 8.8cm rocket-assisted HEAT warhead up to 700 meters, but officially recommended engagement ranges were 150-250 meters. Armor penetration: 175mm of effective armor. Sights are calibrated at 100, 150, and 200 meters."
     bRapidFire=false
     Mesh=SkeletalMesh'DH_Weapons3rd_anm.Panzerschreck_3rd'
}
