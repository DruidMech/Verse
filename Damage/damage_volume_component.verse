# Copyright Epic Games, Inc. All Rights Reserved.

using { /Verse.org }
using { /Verse.org/Native }
using { /Verse.org/SceneGraph }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /Verse.org/Colors }

# Designed to cause damage to players when they enter the volume
damage_volume_component<public> := class<final_super>(component):

    DebugDraw : debug_draw = debug_draw{}

    var EnteredEntities : []entity = array{}

    @editable
    DamageInterval : float = 0.5

    @editable
    IsPeriodic : logic = true

    OnEntityEntered(InEntity:entity):void=
        if (IsPeriodic?):
            set EnteredEntities += array{InEntity}
        else:
            DebugDraw.DrawSphere(
                InEntity.GetGlobalTransform().Translation,
                ?Color := NamedColors.Red,
                ?DrawDurationPolicy := debug_draw_duration_policy.FiniteDuration,
                ?Duration := 5.0,
                ?Radius := 50.0)

    OnEntityExited(InEntity:entity):void=
        if (not IsPeriodic?). return
        set EnteredEntities = for (EnteredEntity : EnteredEntities, EnteredEntity <> InEntity) do EnteredEntity

    DamageLoop()<suspends>:void=
        loop:
            for (EnteredEntity : EnteredEntities):
                DebugDraw.DrawSphere(
                    EnteredEntity.GetGlobalTransform().Translation,
                    ?Color := NamedColors.Red,
                    ?DrawDurationPolicy := debug_draw_duration_policy.FiniteDuration,
                    ?Duration := 5.0,
                    ?Radius := 50.0)
            
            Sleep(DamageInterval)

    OnSimulate<override>()<suspends>:void=
        DamageLoop()
        
    OnBeginSimulation<override>():void =
        (super:)OnBeginSimulation()

        for (Comp : Entity.FindDescendantComponents(mesh_component)):
            Comp.EntityEnteredEvent.Subscribe(OnEntityEntered)
            Comp.EntityExitedEvent.Subscribe(OnEntityExited)
