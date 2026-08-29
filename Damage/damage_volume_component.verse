# Copyright Epic Games, Inc. All Rights Reserved.

using { /Verse.org }
using { /Verse.org/Native }
using { /Verse.org/SceneGraph }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /Verse.org/Colors }
using { /Fortnite.com/Characters }

# Designed to cause damage to players when they enter the volume
damage_volume_component<public> := class<final_super>(component):

    DebugDraw : debug_draw = debug_draw{}

    var EnteredEntities : []entity = array{}

    @editable
    DamageInterval : float = 0.5

    @editable
    DamageAmount : float = 5.0

    @editable
    IsPeriodic : logic = true

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
        if (IsPeriodic?):
            if (GetFortCharacter[InEntity]):
                set EnteredEntities += array{InEntity}
        else:
            CauseDamage(InEntity, DamageAmount)

    OnEntityExited(InEntity:entity):void=
        if (not IsPeriodic?). return
        set EnteredEntities = for (EnteredEntity : EnteredEntities, EnteredEntity <> InEntity) do EnteredEntity

    DamageLoop()<suspends>:void=
        loop:
            for (EnteredEntity : EnteredEntities):
                CauseDamage(EnteredEntity, DamageAmount)
            
            Sleep(DamageInterval)

    OnSimulate<override>()<suspends>:void=
        DamageLoop()
        
    OnBeginSimulation<override>():void =
        (super:)OnBeginSimulation()

        for (Comp : Entity.FindDescendantComponents(mesh_component)):
            Comp.EntityEnteredEvent.Subscribe(OnEntityEntered)
            Comp.EntityExitedEvent.Subscribe(OnEntityExited)
