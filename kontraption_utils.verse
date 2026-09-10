
activatable<public> := interface:
    Activate<public>():void

KontUtils<public> := module:

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
