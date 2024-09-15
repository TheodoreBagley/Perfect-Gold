.include "asm/include/battle_commands.inc"

.data

_000:
    UpdateVarFromVar OPCODE_SET, BSCRIPT_VAR_HP_CALC, BSCRIPT_VAR_HIT_DAMAGE
    CompareVarToValue OPCODE_EQU, BSCRIPT_VAR_HP_CALC, 0, _011
    DivideVarByValue BSCRIPT_VAR_HP_CALC, 2

_011:
    CheckItemHoldEffect CHECK_OPCODE_NOT_HAVE, BATTLER_CATEGORY_ATTACKER, HOLD_EFFECT_LEECH_BOOST, _031
    GetItemEffectParam BATTLER_CATEGORY_ATTACKER, BSCRIPT_VAR_CALC_TEMP
    UpdateVar OPCODE_ADD, BSCRIPT_VAR_CALC_TEMP, 0x00000064
    UpdateVarFromVar OPCODE_MUL, BSCRIPT_VAR_HP_CALC, BSCRIPT_VAR_CALC_TEMP
    UpdateVar OPCODE_DIV, BSCRIPT_VAR_HP_CALC, 100

_031:
    UpdateVarFromVar OPCODE_SET, BSCRIPT_VAR_MSG_BATTLER_TEMP, BSCRIPT_VAR_BATTLER_ATTACKER
    UpdateVar OPCODE_FLAG_ON, BSCRIPT_VAR_BATTLE_STATUS, BATTLE_STATUS_NO_BLINK
    CheckAbility CHECK_OPCODE_HAVE, BATTLER_CATEGORY_DEFENDER, ABILITY_LIQUID_OOZE, _077
    CompareMonDataToValue OPCODE_NEQ, BATTLER_CATEGORY_ATTACKER, BMON_DATA_HEAL_BLOCK_TURNS, 0, _064
    UpdateVar OPCODE_MUL, BSCRIPT_VAR_HP_CALC, -1
    Call BATTLE_SUBSCRIPT_UPDATE_HP
    // {0} had its energy drained!
    PrintMessage 82, TAG_NICKNAME, BATTLER_CATEGORY_DEFENDER
    Wait 
    WaitButtonABTime 30
    End 

_064:
    UpdateVar OPCODE_SET, BSCRIPT_VAR_MSG_MOVE_TEMP, MOVE_HEAL_BLOCK
    // {0} was prevented from healing due to {1}!
    PrintMessage 1054, TAG_NICKNAME_MOVE, BATTLER_CATEGORY_ATTACKER, BATTLER_CATEGORY_MSG_TEMP
    Wait 
    WaitButtonABTime 30
    End 

_077:
    CheckAbility CHECK_OPCODE_HAVE, BATTLER_CATEGORY_ATTACKER, ABILITY_MAGIC_GUARD, _090
    Call BATTLE_SUBSCRIPT_UPDATE_HP
    // It sucked up the liquid ooze!
    PrintMessage 720, TAG_NONE
    Wait 
    WaitButtonABTime 30

_090:
    End 
