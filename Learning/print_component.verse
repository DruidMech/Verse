using { /Verse.org }
using { /Verse.org/Native }
using { /Verse.org/SceneGraph }
using { /Verse.org/Simulation }

# This component is for learning how to print messages to the log.
print_component<public> := class<final_super>(component):

    var Descendants : []entity = array{}
    var Ancestors : []entity = array{}
    IntArray : []int = array{ 1, 2, 3, 4, 5 }

    OnBeginSimulation<override>():void =
        (super:)OnBeginSimulation()

        for (Desc : Entity.FindDescendantEntities(entity)):
            set Descendants += array{Desc}

        for (Anc : Entity.FindAncestorEntities(entity)):
            set Ancestors += array{Anc}

        Print("Printing Descendants: ")

        for (Desc : Descendants):
            Print("Descendant: " + ToDiagnostic(Desc))

        Print("Printing Ancestors: ")

        for (Anc : Ancestors):
            Print("Ancestor: " + ToDiagnostic(Anc))

        for (I -> Elem : IntArray):
            Print("IntArray[{I}]: {Elem}")