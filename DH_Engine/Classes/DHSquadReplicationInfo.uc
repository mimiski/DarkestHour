//==============================================================================
// Darkest Hour: Europe '44-'45
// Darklight Games (c) 2008-2015
//==============================================================================

class DHSquadReplicationInfo extends ReplicationInfo;

const SQUAD_MEMBER_COUNT = 8;
const TEAM_SQUAD_COUNT = 8;

const SQUAD_NAME_LENGTH_MIN = 3;
const SQUAD_NAME_LENGTH_MAX = 16;

const DEBUG = true;

enum ESquadError
{
    SE_None,
    SE_AlreadyInSquad,
    SE_InvalidName,
    SE_TooManySquads,
    SE_MustBeOnTeam,
    SE_NotSquadLeader,
    SE_NotInSquad,
    SE_InvalidArgument,
    SE_BadSquad,
    SE_InvalidState
};

// This nightmare is necessary because UnrealScript cannot replicate structs.
var private DHPlayerReplicationInfo AxisMembers[64];
var private string                  AxisNames[TEAM_SQUAD_COUNT];
var private byte                    AxisLeaderMemberIndices[TEAM_SQUAD_COUNT];
var private byte                    AxisLocked[TEAM_SQUAD_COUNT];

var private DHPlayerReplicationInfo AlliesMembers[64];
var private string                  AlliesNames[TEAM_SQUAD_COUNT];
var private byte                    AlliesLeaderMemberIndices[TEAM_SQUAD_COUNT];
var private byte                    AlliesLocked[TEAM_SQUAD_COUNT];

var private array<string> AlliesDefaultSquadNames;
var private array<string> AxisDefaultSquadNames;

var class<LocalMessage> SquadMessageClass;

replication
{
    reliable if (bNetDirty && Role == ROLE_Authority)
        AxisMembers, AxisNames, AxisLeaderMemberIndices, AxisLocked,
        AlliesMembers, AlliesNames, AlliesLeaderMemberIndices, AlliesLocked;
}

simulated function bool IsSquadActive(byte TeamIndex, int SquadIndex)
{
    return GetMember(TeamIndex, SquadIndex, GetLeaderMemberIndex(TeamIndex, SquadIndex)) != none;
}

simulated function bool IsSquadLeader(DHPlayerReplicationInfo PRI, int TeamIndex, int SquadIndex)
{
    if (PRI == none || PRI.SquadIndex == -1 || PRI.Team.TeamIndex != TeamIndex || PRI.SquadIndex != SquadIndex)
    {
        return false;
    }

    return GetLeaderMemberIndex(TeamIndex, PRI.SquadIndex) == PRI.SquadMemberIndex;
}

// Will return true if passed two different players that are in the same squad.
simulated function bool IsInSameSquad(DHPlayerReplicationInfo A, DHPlayerReplicationInfo B)
{
    return A != none && B != none && A != B ||
          (A.Team.TeamIndex == AXIS_TEAM_INDEX || A.Team.TeamIndex == ALLIES_TEAM_INDEX) &&
           A.Team.TeamIndex == B.Team.TeamIndex &&
           A.SquadIndex == B.SquadIndex;
}

function bool SwapSquadMembers(DHPlayerReplicationInfo A, DHPlayerReplicationInfo B)
{
    local int T;

    if (!IsInSameSquad(A, B))
    {
        return false;
    }

    T = B.SquadMemberIndex;

    SetMember(A.Team.TeamIndex, A.SquadIndex, T, A);
    SetMember(A.Team.TeamIndex, A.SquadIndex, A.SquadMemberIndex, B);

    B.SquadMemberIndex = A.SquadMemberIndex;
    A.SquadMemberIndex = T;

    return true;
}

function DebugLog(string S)
{
    if (DEBUG)
    {
        Log(S);
    }
}

simulated function bool IsDefaultSquadName(string SquadName, int TeamIndex)
{
    switch (TeamIndex)
    {
        case AXIS_TEAM_INDEX:
            return class'UArray'.static.SIndexOf(AxisDefaultSquadNames, SquadName) >= 0;
        default:
            return class'UArray'.static.SIndexOf(AlliesDefaultSquadNames, SquadName) >= 0;
    }
}

simulated function string GetDefaultSquadName(int TeamIndex, int SquadIndex)
{
    if (SquadIndex < 0 || SquadIndex > TEAM_SQUAD_COUNT)
    {
        return "";
    }

    switch (TeamIndex)
    {
        case AXIS_TEAM_INDEX:
            return default.AxisDefaultSquadNames[SquadIndex];
        default:
            return default.AlliesDefaultSquadNames[SquadIndex];
    }
}

// Returns the index of the newly created squad, or -1 if there was an error.
function byte CreateSquad(DHPlayerReplicationInfo PRI, optional string Name)
{
    local int i;
    local int TeamIndex;
    local DHPlayer PC;
    local DHVoiceReplicationInfo VRI;

    if (PRI == none)
    {
        return -1;
    }

    PC = DHPlayer(PRI.Owner);

    if (PC == none)
    {
        return -1;
    }

    if (PRI.SquadIndex != -1)
    {
        PC.ClientCreateSquadResult(SE_AlreadyInSquad);

        DebugLog(PRI.PlayerName @ "is already in a squad (" $ PRI.SquadIndex $ ")");

        return -1;
    }

    TeamIndex = PC.GetTeamNum();

    if (Name != "" && (Len(Name) < SQUAD_NAME_LENGTH_MIN || Len(Name) > SQUAD_NAME_LENGTH_MAX || IsDefaultSquadName(Name, TeamIndex)))
    {
        PC.ClientCreateSquadResult(SE_InvalidName);

        DebugLog("Squad name is invalid (" $ Name $ ")");

        return -1;
    }

    for (i = 0; i < TEAM_SQUAD_COUNT; ++i)
    {
        if (!IsSquadActive(TeamIndex, i))
        {
            if (Name == "")
            {
                Name = GetDefaultSquadName(TeamIndex, i);
            }

            SetMember(TeamIndex, i, GetLeaderMemberIndex(TeamIndex, i), PRI);
            SetName(TeamIndex, i, Name);

            PRI.SquadIndex = i;
            PRI.SquadMemberIndex = GetLeaderMemberIndex(TeamIndex, i);

            PC.ClientCreateSquadResult(SE_None);

            VRI = DHVoiceReplicationInfo(PC.VoiceReplicationInfo);

            if (VRI != none)
            {
                VRI.JoinSquadChannel(PRI, TeamIndex, i);
            }

            DebugLog("Squad '" $ Name $ "' created successfully at index " $ i);

            return i;
        }
    }

    PC.ClientCreateSquadResult(SE_TooManySquads);

    return -1;
}

// Returns true if the squad leader was successfully changed.
function bool ChangeSquadLeader(DHPlayerReplicationInfo PRI, int TeamIndex, int SquadIndex, DHPlayerReplicationInfo NewSquadLeader)
{
    local DHPlayer PC;
    local DHPlayer OtherPC;

    if (PRI == none)
    {
        return false;
    }

    PC = DHPlayer(PRI.Owner);

    if (PC == none)
    {
        return false;
    }

    if (!IsSquadLeader(PRI, TeamIndex, SquadIndex))
    {
        // Player is not a squad leader.
        PC.ClientChangeSquadLeaderResult(SE_NotSquadLeader);
        return false;
    }

    if (!IsInSameSquad(PRI, NewSquadLeader))
    {
        PC.ClientChangeSquadLeaderResult(SE_InvalidArgument);

        return false;
    }

    // To change the squad leader, instead of changing the LeaderMemberIndex,
    // we simply swap the new leader with the old one. This preserves the
    // "leader inheritance" order.
    if (!SwapSquadMembers(PRI, NewSquadLeader))
    {
        PC.ClientChangeSquadLeaderResult(SE_InvalidArgument);

        return false;
    }

    // "You are no longer the squad leader"
    PC.ReceiveLocalizedMessage(MessageClass, 33);

    PC.ClientChangeSquadLeaderResult(SE_None);

    OtherPC = DHPlayer(NewSquadLeader.Owner);

    if (OtherPC != none)
    {
        // "You are now the squad leader"
        OtherPC.ReceiveLocalizedMessage(MessageClass, 34);
    }

    // "{0} has become the squad leader"
    BroadcastSquadLocalizedMessage(PRI.Team.TeamIndex, PRI.SquadIndex, MessageClass, 35, NewSquadLeader);

    return true;
}

// Returns true if player successfully leaves a squad. The player is guaranteed
// to not be a member of a squad after this call, regardless of the return value.
function bool LeaveSquad(DHPlayerReplicationInfo PRI)
{
    local int i, j;
    local int TeamIndex;
    local DHPlayer PC;
    local DHPlayerReplicationInfo NewSquadLeader;
    local DHPlayer NewSquadLeaderPC;
    local DHVoiceReplicationInfo VRI;

    if (PRI == none)
    {
        return false;
    }

    PC = DHPlayer(PRI.Owner);

    if (PC == none)
    {
        return false;
    }

    TeamIndex = PC.GetTeamNum();

    if (PRI.SquadIndex == -1)
    {
        PC.ClientLeaveSquadResult(SE_NotInSquad);

        return false;
    }

    if (GetMember(TeamIndex, PRI.SquadIndex, PRI.SquadMemberIndex) != PRI)
    {
        // Invalid state (should never happen)
        PC.ClientLeaveSquadResult(SE_InvalidState);

        return false;
    }

    SetMember(TeamIndex, PRI.SquadIndex, PRI.SquadMemberIndex, none);

    if (PRI.SquadMemberIndex == GetLeaderMemberIndex(TeamIndex, PRI.SquadMemberIndex))
    {
        // Player was squad leader, transfer leadership to next in the list
        for (i = 1; i < SQUAD_MEMBER_COUNT; ++i)
        {
            j = (GetLeaderMemberIndex(TeamIndex, PRI.SquadIndex) + i) % SQUAD_MEMBER_COUNT;

            if (GetMember(TeamIndex, PRI.SquadIndex, j) != none)
            {
                NewSquadLeader = GetMember(TeamIndex, PRI.SquadIndex, j);
                NewSquadLeaderPC = DHPlayer(NewSquadLeader.Owner);

                if (NewSquadLeaderPC != none)
                {
                    // "You are now the squad leader"
                    NewSquadLeaderPC.ReceiveLocalizedMessage(MessageClass, 34);
                }

                // "{0} has become the squad leader"
                BroadcastSquadLocalizedMessage(TeamIndex, PRI.SquadIndex, MessageClass, 35, NewSquadLeader);

                SetLeaderMemberIndex(TeamIndex, PRI.SquadIndex, j);

                break;
            }
        }
    }

    // voice replication info stuff
    VRI = DHVoiceReplicationInfo(PRI.VoiceInfo);

    if (VRI != none)
    {
        VRI.LeaveSquadChannel(PRI, PRI.SquadIndex, PRI.SquadMemberIndex);
    }

    PRI.SquadIndex = -1;
    PRI.SquadMemberIndex = -1;

    PC.ClientLeaveSquadResult(SE_None);

    return true;
}

simulated function bool IsInSquad(DHPlayerReplicationInfo PRI, byte TeamIndex, int SquadIndex)
{
    return PRI != none && PRI.Team.TeamIndex == TeamIndex && PRI.SquadIndex == SquadIndex;
}

// Returns the index of the new SquadMemberIndex of the player or -1 if
// joining a squad failed.
function int JoinSquad(DHPlayerReplicationInfo PRI, byte TeamIndex, int SquadIndex)
{
    local bool bDidJoinSquad;
    local int i, j;
    local DHPlayer PC;
    local DHVoiceReplicationInfo VRI;

    if (PRI == none)
    {
        return -1;
    }

    PC = DHPlayer(PRI.Owner);

    if (PC == none)
    {
        return -1;
    }

    if (!IsSquadActive(TeamIndex, SquadIndex))
    {
        PC.ClientJoinSquadResult(SE_BadSquad);

        return -1;
    }

    if (IsInSquad(PRI, TeamIndex, SquadIndex))
    {
        PC.ClientJoinSquadResult(SE_BadSquad);

        return -1;
    }

    for (i = 0; i < SQUAD_MEMBER_COUNT; ++i)
    {
        j = (GetLeaderMemberIndex(TeamIndex, SquadIndex) + i) % SQUAD_MEMBER_COUNT;

        if (GetMember(TeamIndex, SquadIndex, j) == none)
        {
            // We don't care about the result of ServerLeaveSquad;
            // whatever the result, the player is not in a squad and
            // can join another one.
            LeaveSquad(PRI);

            SetMember(TeamIndex, SquadIndex, j, PRI);

            bDidJoinSquad = true;

            break;
        }
    }

    if (bDidJoinSquad)
    {
        VRI = DHVoiceReplicationInfo(PC.VoiceReplicationInfo);

        if (VRI != none)
        {
            VRI.JoinSquadChannel(PRI, TeamIndex, SquadIndex);
        }

        // "{0} has joined the squad"
        BroadcastSquadLocalizedMessage(TeamIndex, SquadIndex, MessageClass, 30, PRI);

        PC.ClientJoinSquadResult(SE_None);
    }
}

// Returns true if the the player was successfully kicked from a squad.
function bool KickFromSquad(DHPlayerReplicationInfo PRI, byte TeamIndex, int SquadIndex, DHPlayerReplicationInfo MemberToKick)
{
    local DHPlayer PC, OtherPC;

    if (PRI == none)
    {
        return false;
    }

    PC = DHPlayer(PRI.Owner);

    if (PC != none)
    {
        return false;
    }

    if (!IsSquadLeader(PRI, TeamIndex, SquadIndex) || PRI == MemberToKick)
    {
        //PC.ClientKickFromSquadResult(SE_InvalidArgument);

        return false;
    }

    LeaveSquad(MemberToKick);

    OtherPC = DHPlayer(MemberToKick.Owner);

    if (OtherPC != none)
    {
        // "You have been kicked from your squad."
        OtherPC.ReceiveLocalizedMessage(MessageClass, 32);
    }

    return true;
}

function bool InviteToSquad(DHPlayerReplicationInfo PRI, byte TeamIndex, int SquadIndex, DHPlayerReplicationInfo Recipient)
{
    local DHPlayer PC;

    if (!IsSquadLeader(PRI, TeamIndex, SquadIndex))
    {
        return false;
    }

    PC = DHPlayer(PRI.Owner);

    if (PRI.IsInSquad())
    {
        if (PC != none)
        {
            // "{0} is already in a squad.";
            PC.ReceiveLocalizedMessage(MessageClass, 36, Recipient);
        }

        return false;
    }

    // TODO: Check that they're on the same team
    // TODO: Send invitation to recipient

    // There should be no need to store the invitation in SRI.
    // If the recipient tries to join a squad that has
    // since become invalid, the join command will fail gracefully.

    PC = DHPlayer(Recipient.Owner);

    if (PC != none)
    {
        PC.ClientSquadInvite(GetSquadName(TeamIndex, SquadIndex), PRI.PlayerName, TeamIndex, SquadIndex);
    }

    return true;
}

function bool SetSquadLocked(DHPlayerReplicationInfo PC, int TeamIndex, int SquadIndex, bool bLocked)
{
    if (!IsSquadLeader(PC, TeamIndex, SquadIndex))
    {
        return false;
    }

    switch (TeamIndex)
    {
        case AXIS_TEAM_INDEX:
            AxisLocked[SquadIndex] = byte(bLocked);
            break;
        case ALLIES_TEAM_INDEX:
            AlliesLocked[SquadIndex] = byte(bLocked);
            break;
        default:
            break;
    }

    return true;
}

function BroadcastSquadLocalizedMessage(byte TeamIndex, int SquadIndex, class<LocalMessage> MessageClass, int Switch, optional PlayerReplicationInfo RelatedPRI_1, optional PlayerReplicationInfo RelatedPRI_2, optional Object OptionalObject)
{
    local int i;
    local DHPlayerReplicationInfo PRI;
    local DHPlayer PC;

    if (!IsSquadActive(TeamIndex, SquadIndex))
    {
        return;
    }

    for (i = 0; i < SQUAD_MEMBER_COUNT; ++i)
    {
        PRI = GetMember(TeamIndex, SquadIndex, i);

        if (PRI == none)
        {
            continue;
        }

        PC = DHPlayer(PRI.Owner);

        if (PC != none)
        {
            PC.ReceiveLocalizedMessage(MessageClass, Switch, RelatedPRI_1, RelatedPRI_2, OptionalObject);
        }
    }
}

simulated function string GetSquadName(int TeamIndex, int SquadIndex)
{
    switch (TeamIndex)
    {
        case AXIS_TEAM_INDEX:
            return AxisNames[SquadIndex];
        case ALLIES_TEAM_INDEX:
            return AlliesNames[SquadIndex];
    }

    return "";
}

simulated function int GetLeaderMemberIndex(int TeamIndex, int SquadIndex)
{
    switch (TeamIndex)
    {
        case AXIS_TEAM_INDEX:
            return AxisLeaderMemberIndices[SquadIndex];
        case ALLIES_TEAM_INDEX:
            return AlliesLeaderMemberIndices[SquadIndex];
    }

    return 0;
}

function SetLeaderMemberIndex(int TeamIndex, int SquadIndex, int LeaderMemberIndex)
{
    switch (TeamIndex)
    {
        case AXIS_TEAM_INDEX:
            AxisLeaderMemberIndices[SquadIndex] = LeaderMemberIndex;
            break;
        case ALLIES_TEAM_INDEX:
            AlliesLeaderMemberIndices[SquadIndex] = LeaderMemberIndex;
            break;
        default:
            break;
    }
}

simulated function DHPlayerReplicationInfo GetMember(int TeamIndex, int SquadIndex, int MemberIndex)
{
    switch (TeamIndex)
    {
        case AXIS_TEAM_INDEX:
            return AxisMembers[SquadIndex * SQUAD_MEMBER_COUNT + MemberIndex];
        case ALLIES_TEAM_INDEX:
            return AlliesMembers[SquadIndex * SQUAD_MEMBER_COUNT + MemberIndex];
    }

    return none;
}

// Gets a list of all the members in a squad. The list is not guaranteed to be
// in any particular order. The list will not contain null entries.
simulated function GetMembers(int TeamIndex, int SquadIndex, out array<DHPlayerReplicationInfo> Members)
{
    local int i;
    local DHPlayerReplicationInfo PRI;

    for (i = 0; i < SQUAD_MEMBER_COUNT; ++i)
    {
        PRI = GetMember(TeamIndex, SquadIndex, i);

        if (PRI != none)
        {
            Members[Members.Length] = PRI;
        }
    }
}

function SetMember(int TeamIndex, int SquadIndex, int MemberIndex, DHPlayerReplicationInfo PRI)
{
    switch (TeamIndex)
    {
        case AXIS_TEAM_INDEX:
            AxisMembers[SquadIndex * SQUAD_MEMBER_COUNT + MemberIndex] = PRI;
            break;
        case ALLIES_TEAM_INDEX:
            AlliesMembers[SquadIndex * SQUAD_MEMBER_COUNT + MemberIndex] = PRI;
            break;
        default:
            return;
    }

    if (PRI != none)
    {
        PRI.SquadIndex = SquadIndex;
        PRI.SquadMemberIndex = MemberIndex;
    }
}

function SetName(int TeamIndex, int SquadIndex, string Name)
{
    switch (TeamIndex)
    {
        case AXIS_TEAM_INDEX:
            AxisNames[SquadIndex] = Name;
            break;
        case ALLIES_TEAM_INDEX:
            AlliesNames[SquadIndex] = Name;
            break;
        default:
            break;
    }
}

defaultproperties
{
    AlliesDefaultSquadNames(0)="ABLE"
    AlliesDefaultSquadNames(1)="BAKER"
    AlliesDefaultSquadNames(2)="CHARLIE"
    AlliesDefaultSquadNames(3)="DOG"
    AlliesDefaultSquadNames(4)="EASY"
    AlliesDefaultSquadNames(5)="FOX"
    AlliesDefaultSquadNames(6)="GEORGE"
    AlliesDefaultSquadNames(7)="HOW"
    AxisDefaultSquadNames(0)="ANTON"
    AxisDefaultSquadNames(1)="BERTA"
    AxisDefaultSquadNames(2)="CAESAR"
    AxisDefaultSquadNames(3)="DORA"
    AxisDefaultSquadNames(4)="EMIL"
    AxisDefaultSquadNames(5)="FRITZ"
    AxisDefaultSquadNames(6)="GUSTAV"
    AxisDefaultSquadNames(7)="HEINRICH"
    SquadMessageClass=class'DHGameMessage'
}
