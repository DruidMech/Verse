using { /Verse.org }
using { /Verse.org/Native }
using { /Verse.org/SceneGraph }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /Verse.org/Colors }
using { /Verse.org/SpatialMath }

shape_drawer := class<abstract>:
    DebugDraw : debug_draw = debug_draw{}
    @editable var DrawColor<public> : color = color{}
    @editable DurationPolicy : debug_draw_duration_policy = debug_draw_duration_policy.Persistent
    Draw(Location:vector3, Rotation:rotation):void

sphere_drawer := class(shape_drawer):
    Draw<override>(Location:vector3, Rotation:rotation):void=
        DebugDraw.DrawSphere(Location, 
            ?DrawDurationPolicy := DurationPolicy, 
            ?Color := DrawColor,
            ?Duration := 1.0)

box_drawer := class(shape_drawer):
    Draw<override>(Location:vector3, Rotation:rotation):void=
        DebugDraw.DrawBox(
            Location, 
            Rotation, 
            ?DrawDurationPolicy := DurationPolicy,
            ?Color := DrawColor,
            ?Duration := 1.0)



debug_draw_component<public> := class<final_super>(component):

    DebugDraw : debug_draw = debug_draw{}

    @editable
    ShapeDrawer : shape_drawer = sphere_drawer{}

    GetLoc():vector3 = Entity.GetGlobalTransform().Translation
    GetRot():rotation = Entity.GetGlobalTransform().Rotation
    GetLocRot():tuple(vector3, rotation)=
        Loc is GetLoc()
        Rot is GetRot()
        (Loc, Rot)

    DrawShape<public>():void = DrawShape(GetLocRot())

    DrawShape(Location:vector3, Rotation:rotation):void=
        ShapeDrawer.Draw(Location, Rotation)

    OnBeginSimulation<override>():void=
        DrawShape(GetLocRot())




