using { /Verse.org }
using { /Verse.org/Native }
using { /Verse.org/SceneGraph }
using { /Verse.org/Simulation }

# This component is for learning how to print messages to the log.
print_component<public> := class<final_super>(component):

    <# These are member variables.
        They belong to print_component. #>
    var Age : int = 29
    var Name : string = "Stephen"
    var Char : char = '\t'
    var Health : float = 100.0

    OnBeginSimulation<override>():void =
        (super:)OnBeginSimulation()

        Print("Name: {Name}, Age: {Age}, {Char} Health: {Health}")

        set Age = 35
        set Name = "Jack"
        set Char = '\n' 
        set Health = 200.0
        Print("Name: {Name}, Age: {Age}, {Char} Health: {Health} ")
        