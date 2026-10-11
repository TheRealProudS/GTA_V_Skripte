Config = {}

Config.Core = 'qbx'
Config.InstructorJob = 'driving_school'

Config.BrakeKey = 'SPACE'

Config.SchoolLocation = vector3(215.12, -1399.85, 30.58)

Config.PracticalVehicles = {
    'blista',
    'dilettante'
}

Config.TheoryQuestions = {
    {
        question = 'Welche Hoechstgeschwindigkeit gilt innerorts in San Andreas?',
        options = { '50 km/h', '80 km/h', '120 km/h' },
        answer = 0
    },
    {
        question = 'Was ist an einer roten Ampel mit gruenem Abbiegepfeil zu beachten?',
        options = { 'Einfach durchfahren', 'Vor dem Abbiegen anhalten und Vorrang gewaehren', 'Sofort wenden' },
        answer = 1
    },
    {
        question = 'Welche Seite gilt grundsaetzlich bei rechts vor links?',
        options = { 'Links', 'Rechts', 'Der Schnellere faehrt zuerst' },
        answer = 1
    }
}
