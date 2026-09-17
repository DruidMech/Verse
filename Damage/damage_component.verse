using { /Verse.org/SceneGraph }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /Verse.org/Colors }

using. KontUtils.ForEvents
using. KontUtils.ForFortnite

damage_component<public> := class<final_super>(component):

    DebugDraw:debug_draw = debug_draw{}

    @editable
    DamageAmount:float = 20.0

    OnReceive<override>(E:scene_event):logic=
        if:
            QueryHitEvent := query_hit_event[E]
            Hit := QueryHitEvent.Hit?
            HitComp := Hit.TargetComponent
            HitEntity := HitComp.Entity
            HitLoc := HitEntity.GetGlobalTransform().Translation
            FortChar := HitEntity.FindFortCharacter[]
        then:
            FortChar.Damage(DamageAmount)

            DebugDraw.DrawSphere(
                HitLoc,
                ?Radius := 35.0,
                ?Color := NamedColors.DarkRed,
                ?DrawDurationPolicy := debug_draw_duration_policy.FiniteDuration,
                ?Duration := 1.0
            )

        <#>
            Returning true consumes the event 
                * It will not propagate further.
            Returning false allows the event to propagate
            Calling super returns false if our parent is component
        true