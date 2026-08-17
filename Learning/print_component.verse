using { /Verse.org }
using { /Verse.org/Native }
using { /Verse.org/SceneGraph }
using { /Verse.org/Simulation }

# This component is for learning how to print messages to the log.
print_component<public> := class<final_super>(component):

    <#>
        These are member constants.
        They belong to print_component
    MyInt:int = 3
    MyFloat:float = -47.8
    MyString:string = "Kaladin"
    MyChar:char = 'S'

    OnBeginSimulation<override>():void =
        (super:)OnBeginSimulation()

        Print("Value of MyInt: {MyInt}")
        Print("Value of MyFloat: {MyFloat}")
        Print("Value of MyString and MyChar: {MyString} {MyChar}")

        OwningEntDiagnostic := ToDiagnostic(Entity)
        Print(OwningEntDiagnostic)