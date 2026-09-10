
KontUtils<public> := module:

    # For Fortnite-specific utilities
    ForFortnite<public> := module:
        using { /Verse.org/SceneGraph }
        using { /Fortnite.com/Characters }

        (InEntity:entity).FindFortCharacter<public>()<decides><reads>:fort_character=
            first:
                Comp : InEntity.GetComponents()
                FortChar := fort_character[Comp]
            do:
                FortChar

    # Related to the activatable interface
    Activatables<public> := module:
        using { /Verse.org/SceneGraph }

        activatable<public> := interface:
            Activate<public>():void

        (InEntity:entity).FindDescendantActivatables<public>()<transacts>:[]activatable=
            for:
                Comp : InEntity.FindDescendantComponents(component)
                Activatable := activatable[Comp]
            do:
                Activatable

    # Related to gameplay mechanics
    ForGameplay<public> := module:
        using { /Verse.org/Simulation }

        damage_params<public> := struct<concrete>:
            @editable
            DamageInterval:float = 0.5

            @editable
            DamageAmount:float = 5.0

            @editable
            IsPeriodic:logic = true

KontTags<public> := module:
    using { /Verse.org/Simulation/Tags }

    kontraption_tag := class(tag) {}

    Gameplay<public> := module:
        overlap_volume<public> := class(kontraption_tag) {}
