using { /Verse.org }
using { /Verse.org/Native }
using { /Verse.org/SceneGraph }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /Verse.org/Colors }
using { /Verse.org/SpatialMath }

draw_shape := enum:
    Sphere
    Box

debug_draw_component<public> := class<final_super>(component):

    DebugDraw : debug_draw = debug_draw{}

    @editable
    DrawColor : color = color{}

    @editable
    Shape : draw_shape = draw_shape.Box

    @editable
    DurationPolicy : debug_draw_duration_policy = debug_draw_duration_policy.Persistent
  
    OnBeginSimulation<override>():void =
        (super:)OnBeginSimulation()

        DrawShape()

        Loc := Entity.GetGlobalTransform().Translation
        Rot := Entity.GetGlobalTransform().Rotation

        NewLocation := vector3:
            Left := Loc.Left
            Up := Loc.Up + 500.0
            Forward := Loc.Forward

        DrawShape(NewLocation, Rot)

    # DRY - Don't Repeat Yourself
    # Refactoring

    DrawShape():void=
        Loc := Entity.GetGlobalTransform().Translation
        Rot := Entity.GetGlobalTransform().Rotation

        DrawShape(Loc, Rot, DurationPolicy)

    DrawShape(Location:vector3, Rotation:rotation):void=
        DrawShape(Location, Rotation, DurationPolicy)

    DrawShape(Location:vector3, Rotation:rotation, Policy:debug_draw_duration_policy):void=
        case(Shape):
            draw_shape.Sphere => DebugDraw.DrawSphere(Location, ?DrawDurationPolicy := Policy)
            draw_shape.Box => DebugDraw.DrawBox(Location, Rotation, ?DrawDurationPolicy := Policy)
