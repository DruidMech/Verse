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
  
    OnBeginSimulation<override>():void =
        (super:)OnBeginSimulation()

        Loc := Entity.GetGlobalTransform().Translation
        Rot := Entity.GetGlobalTransform().Rotation

        case(Shape):
            draw_shape.Sphere => DebugDraw.DrawSphere(Loc)
            draw_shape.Box => DebugDraw.DrawBox(Loc, Rot)