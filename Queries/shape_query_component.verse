using { /Verse.org/SceneGraph }
using { /Verse.org/Simulation }
using { /Verse.org/SpatialMath }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /Verse.org/Colors }

using. KontUtils.Activatables
using. KontUtils.ForEvents

shape_query_component<public> := class<final_super>(component, activatable):

    DebugDraw:debug_draw = debug_draw{}

    @editable
    CollisionBox:collision_box = collision_box:
        Extents := vector3:
            Left := 50.0
            Up := 50.0
            Forward := 50.0

    Activate<override>():void=
        for:
            Hit : Entity.FindOverlapHits(Entity.GetGlobalTransform(), CollisionBox)
            HitComp := Hit.TargetComponent
            HitEntity := HitComp.Entity
            HitLoc := HitEntity.GetGlobalTransform().Translation
        do:
            QueryHitEvent:query_hit_event = query_hit_event:
                Hit := option{ Hit }

            Entity.SendUp(QueryHitEvent)

            DebugDraw.DrawBox(
                Entity.GetGlobalTransform().Translation,
                Entity.GetGlobalTransform().Rotation,
                ?Extent := CollisionBox.Extents,
                ?Color := NamedColors.Red,
                ?Thickness := 1.0,
                ?DrawDurationPolicy := debug_draw_duration_policy.FiniteDuration,
                ?Duration := 1.0
            )



        



