# Copyright Epic Games, Inc. All Rights Reserved.

using { /Verse.org }
using { /Verse.org/Native }
using { /Verse.org/SceneGraph }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /Verse.org/Colors }
using { /Fortnite.com/Characters }

using. KontTags.Gameplay
using. KontUtils.ForGameplay

# Designed to cause damage to players when they enter the volume
damage_volume_component<public> := class<final_super>(component):

    DebugDraw : debug_draw = debug_draw{}

    var EnteredEntities : []entity = array{}

    @editable
    DamageParams : damage_params = damage_params{}

    GetFortCharacter(InEntity:entity)<decides><reads>:fort_character=
        FortChars :[]fort_character = for:
            Comp : InEntity.GetComponents()
            FortChar := fort_character[Comp]
        FortChars at 0

    CauseDamage(InEntity:entity, InDamage:float):void=
        if (FortChar := GetFortCharacter[InEntity]):
            FortChar.Damage(InDamage)
            DebugDraw.DrawSphere(
                InEntity.GetGlobalTransform().Translation,
                ?Color := NamedColors.Red,
                ?DrawDurationPolicy := debug_draw_duration_policy.FiniteDuration,
                ?Duration := 5.0,
                ?Radius := 50.0)

    OnEntityEntered(InEntity:entity):void=
        if (DamageParams.IsPeriodic?):
            if (GetFortCharacter[InEntity]):
                set EnteredEntities += array{InEntity}
        else:
            CauseDamage(InEntity, DamageParams.DamageAmount)

    OnEntityExited(InEntity:entity):void=
        if (not DamageParams.IsPeriodic?). return
        set EnteredEntities = for (EnteredEntity : EnteredEntities, EnteredEntity <> InEntity) do EnteredEntity

    DamageLoop()<suspends>:void=
        loop:
            for (EnteredEntity : EnteredEntities):
                CauseDamage(EnteredEntity, DamageParams.DamageAmount)
            
            Sleep(DamageParams.DamageInterval)

    OnSimulate<override>()<suspends>:void=
        DamageLoop()
        
    OnBeginSimulation<override>():void =
        (super:)OnBeginSimulation()

        for:
            Ent : Entity.FindDescendantEntitiesWithTag(overlap_volume)
            Comp := Ent.GetComponent[mesh_component]
        do:
            Comp.EntityEnteredEvent.Subscribe(OnEntityEntered)
            Comp.EntityExitedEvent.Subscribe(OnEntityExited)
