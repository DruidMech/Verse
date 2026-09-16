using { /Verse.org/SceneGraph }
using { /Verse.org/Simulation }
using { /Fortnite.com/Game }
using { /Verse.org/Random }

using. KontUtils.Activatables

# Periodically loops over descendant activatables and calls Activate()
looping_activator_component<public> := class<final_super>(component):

    @editable
    LoopInterval:float = 2.0

    @editable
    InitialDelayMin:float = 1.0

    @editable
    InitialDelaymax:float = 3.0

    StartLoop()<suspends>:void=
        Sleep(GetRandomFloat(InitialDelayMin, InitialDelaymax))
        loop:
            for (Act : Entity.FindDescendantActivatables()):
                Act.Activate()
            Sleep(LoopInterval)

    OnBeginSimulation<override>():void=
        (super:)OnBeginSimulation()

        if (RoundMgr := Entity.GetFortRoundManager[]):
            RoundMgr.SubscribeRoundStarted(StartLoop)

