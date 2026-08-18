using { /Verse.org }
using { /Verse.org/Native }
using { /Verse.org/SceneGraph }
using { /Verse.org/Simulation }

# This component is for learning how to print messages to the log.
print_component<public> := class<final_super>(component):

    var Descendants : []entity = array{}
    var Ancestors : []entity = array{}
    var IntArray : []int = array{}

    OnBeginSimulation<override>():void =
        (super:)OnBeginSimulation()

        set Descendants = for (Desc : Entity.FindDescendantEntities(entity)):
            Desc

        set Ancestors = for (Anc : Entity.FindAncestorEntities(entity)) do Anc

        Print("Printing Descendants and their parents: ")

        for:
            Desc : Descendants
            Parent := Desc.GetParent[]
        do:
            Print("Descendant: " + ToDiagnostic(Desc) + " Parent: " + ToDiagnostic(Parent))

        Print("Printing Ancestors and their parents: ")

        for:
            Anc : Ancestors
            Parent := Anc.GetParent[]
        do:
            Print("Ancestor: " + ToDiagnostic(Anc) + " Parent: " + ToDiagnostic(Parent))

        set IntArray = for (I := 1..10) do I

        for (I -> Elem : IntArray):
            Print("IntArray[{I}]: {Elem}")