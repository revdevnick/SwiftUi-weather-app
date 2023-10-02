//
//  Location.swift
//  SwiftUI-Weather
//
//  Created by Nick Perkins on 9/22/23.
//

import Foundation


struct Location: Codable {
    var cityName: String
    var region: String
    var country: String
    var latitude: Double
    var longitude: Double
    var timezoneId: String
    var localTimeSeconds: Int
    var localTimeString: String
    
    enum CodingKeys: String, CodingKey {
        case cityName = "name"
        case region
        case country
        case latitude = "lat"
        case longitude = "lon"
        case timezoneId = "tz_id"
        case localTimeSeconds = "localtime_epoch"
        case localTimeString = "localtime"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        cityName = try values.decode(String.self, forKey: .cityName)
        region = try values.decode(String.self, forKey: .region)
        country = try values.decode(String.self, forKey: .country)
        latitude = try values.decode(Double.self, forKey: .latitude)
        longitude = try values.decode(Double.self, forKey: .longitude)
        timezoneId = try values.decode(String.self, forKey: .timezoneId)
        localTimeSeconds = try values.decode(Int.self, forKey: .localTimeSeconds)
        localTimeString = try values.decode(String.self, forKey: .localTimeString)
    }
}

struct Condition: Codable, Equatable, Hashable {
    var text: String
    var icon: String
    var code: Int
    
    var sfSymbol: String {
        switch self.text.lowercased() {
        case "mist":
            return "cloud.rain.fill"
        case "overcast":
            return "cloud.fill"
        case "partly cloudy":
            return "cloud.sun.fill"
        case "sunny":
            return "sun.max.fill"
        default:
            return "exclamationmark.triangle.fill"
        }
    }
}

struct CurrentForecast: Codable {
    var lastUpdatedInSeconds: Int
    var lastUpdatedString: String
    var tempC: Int
    var tempF: Int
    var isDay: Bool
    var condition: Condition
    var windMph: Double
    var windKph: Double
    var windDegree: Int
    var windDirection: String
    var pressureMB: Double
    var pressureIn: Double
    var humidity: Int
    var cloud: Int
    var feelsLikeC: Double
    var feelsLikeF: Double
    var visibilityKm: Int
    var visibilityMiles: Int
    var uv: Int
    var windGustMph: Double
    var windGustKph: Double
    
    enum CodingKeys: String, CodingKey {
        case lastUpdatedInSeconds = "last_updated_epoch"
        case lastUpdatedString = "last_updated"
        case tempC = "temp_c"
        case tempF = "temp_f"
        case isDay = "is_day"
        case condition
        case windMph = "wind_mph"
        case windKph = "wind_kph"
        case windDegree = "wind_degree"
        case windDirection = "wind_dir"
        case pressureMB = "pressure_mb"
        case pressureIn = "pressure_in"
        case humidity
        case cloud
        case feelsLikeC = "feelslike_c"
        case feelsLikeF = "feelslike_f"
        case visibilityKm = "vis_km"
        case visibilityMiles = "vis_miles"
        case uv
        case windGustMph = "gust_mph"
        case windGustKph = "gust_kph"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        lastUpdatedInSeconds = try values.decode(Int.self, forKey: .lastUpdatedInSeconds)
        lastUpdatedString = try values.decode(String.self, forKey: .lastUpdatedString)
        let tempCValue = try values.decode(Double.self, forKey: .tempC)
        tempC = Int(tempCValue)
        let tempFValue = try values.decode(Double.self, forKey: .tempF)
        tempF = Int(tempFValue)
        let isDayValue = try values.decode(Int.self, forKey: .isDay)
        isDay = isDayValue != 0
        condition = try values.decode(Condition.self, forKey: .condition)
        windMph = try values.decode(Double.self, forKey: .windMph)
        windKph = try values.decode(Double.self, forKey: .windKph)
        windDegree = try values.decode(Int.self, forKey: .windDegree)
        windDirection = try values.decode(String.self, forKey: .windDirection)
        pressureMB = try values.decode(Double.self, forKey: .pressureMB)
        pressureIn = try values.decode(Double.self, forKey: .pressureIn)
        humidity = try values.decode(Int.self, forKey: .humidity)
        cloud = try values.decode(Int.self, forKey: .cloud)
        feelsLikeC = try values.decode(Double.self, forKey: .feelsLikeC)
        feelsLikeF = try values.decode(Double.self, forKey: .feelsLikeF)
        visibilityKm = try values.decode(Int.self, forKey: .visibilityKm)
        visibilityMiles = try values.decode(Int.self, forKey: .visibilityMiles)
        uv = try values.decode(Int.self, forKey: .uv)
        windGustMph = try values.decode(Double.self, forKey: .windGustMph)
        windGustKph = try values.decode(Double.self, forKey: .windGustKph)
    }
}


struct ForecastDay: Codable, Hashable {
    var date: String
    var dayOfWeekFormatted: String
    var dateEpoch: Int
    var day: Day
    var astro: Astro
    var hour: [Hour]
    
    enum CodingKeys: String, CodingKey {
        case date
        case dateEpoch = "date_epoch"
        case day
        case astro
        case hour
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.date = try container.decode(String.self, forKey: .date)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dayFromString = dateFormatter.date(from: self.date)
        self.dayOfWeekFormatted = dayFromString?.formatted(Date.FormatStyle().weekday(.abbreviated)) ?? "UNK"
        
        self.dateEpoch = try container.decode(Int.self, forKey: .dateEpoch)
        self.day = try container.decode(Day.self, forKey: .day)
        self.astro = try container.decode(Astro.self, forKey: .astro)
        self.hour = try container.decode([Hour].self, forKey: .hour)
    }
    
    static func == (lhs: ForecastDay, rhs: ForecastDay) -> Bool {
        return lhs.date == rhs.date &&
        lhs.dayOfWeekFormatted == rhs.dayOfWeekFormatted &&
        lhs.dateEpoch == rhs.dateEpoch &&
        lhs.day == rhs.day &&
        lhs.astro == rhs.astro &&
        lhs.hour == rhs.hour
    }
    
    func hash(into hasher: inout Hasher) {
        // Combine the hash values of all properties
        hasher.combine(date)
        hasher.combine(dayOfWeekFormatted)
        hasher.combine(dateEpoch)
        hasher.combine(day)
        hasher.combine(astro)
        hasher.combine(hour)
    }
}

struct Day: Codable, Hashable, Equatable {
    var maxTempC: Double
    var maxTempF: Int
    var minTempC: Double
    var minTempF: Double
    var avgTempC: Double
    var avgTempF: Double
    var maxWindMph: Double
    var maxWindKph: Double
    var totalPercipMM: Int
    var totalPercipIn: Int
    var totalSnowCm: Int
    var avgVisKm: Double
    var avgVisMiles: Int
    var avgHumidity: Int
    var dailyWillItRain: Bool
    var dailyChanceOfRain: Int
    var dailyWillItSnow: Bool
    var dailyChanceofSnow: Int
    var condition: Condition
    var uv: Int
    
    enum CodingKeys: String, CodingKey {
        case maxTempC = "maxtemp_c"
        case maxTempF = "maxtemp_f"
        case minTempC = "mintemp_c"
        case minTempF = "mintemp_f"
        case avgTempC = "avgtemp_c"
        case avgTempF = "avgtemp_f"
        case maxWindMph = "maxwind_mph"
        case maxWindKph = "maxwind_kph"
        case totalPercipMM = "totalprecip_mm"
        case totalPercipIn = "totalprecip_in"
        case totalSnowCm = "totalsnow_cm"
        case avgVisKm = "avgvis_km"
        case avgVisMiles = "avgvis_miles"
        case avgHumidity = "avghumidity"
        case dailyWillItRain = "daily_will_it_rain"
        case dailyChanceOfRain = "daily_chance_of_rain"
        case dailyWillItSnow = "daily_will_it_snow"
        case dailyChanceofSnow = "daily_chance_of_snow"
        case condition
        case uv
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.maxTempC = try container.decode(Double.self, forKey: .maxTempC)
        let maxTempValue = try container.decode(Double.self, forKey: .maxTempF)
        self.maxTempF = Int(maxTempValue)
        self.minTempC = try container.decode(Double.self, forKey: .minTempC)
        self.minTempF = try container.decode(Double.self, forKey: .minTempF)
        self.avgTempC = try container.decode(Double.self, forKey: .avgTempC)
        self.avgTempF = try container.decode(Double.self, forKey: .avgTempF)
        self.maxWindMph = try container.decode(Double.self, forKey: .maxWindMph)
        self.maxWindKph = try container.decode(Double.self, forKey: .maxWindKph)
        self.totalPercipMM = try container.decode(Int.self, forKey: .totalPercipMM)
        self.totalPercipIn = try container.decode(Int.self, forKey: .totalPercipIn)
        self.totalSnowCm = try container.decode(Int.self, forKey: .totalSnowCm)
        self.avgVisKm = try container.decode(Double.self, forKey: .avgVisKm)
        self.avgVisMiles = try container.decode(Int.self, forKey: .avgVisMiles)
        self.avgHumidity = try container.decode(Int.self, forKey: .avgHumidity)
        let dailyRainValue = try container.decode(Int.self, forKey: .dailyWillItRain)
        self.dailyWillItRain = dailyRainValue != 0
        self.dailyChanceOfRain = try container.decode(Int.self, forKey: .dailyChanceOfRain)
        let dailySnowValue = try container.decode(Int.self, forKey: .dailyWillItSnow)
        self.dailyWillItSnow = dailySnowValue != 0
        self.dailyChanceofSnow = try container.decode(Int.self, forKey: .dailyChanceofSnow)
        self.condition = try container.decode(Condition.self, forKey: .condition)
        self.uv = try container.decode(Int.self, forKey: .uv)
    }
    
    func hash(into hasher: inout Hasher) {
            hasher.combine(maxTempC)
            hasher.combine(maxTempF)
            hasher.combine(minTempC)
            hasher.combine(minTempF)
            hasher.combine(avgTempC)
            hasher.combine(avgTempF)
            hasher.combine(maxWindMph)
            hasher.combine(maxWindKph)
            hasher.combine(totalPercipMM)
            hasher.combine(totalPercipIn)
            hasher.combine(totalSnowCm)
            hasher.combine(avgVisKm)
            hasher.combine(avgVisMiles)
            hasher.combine(avgHumidity)
            hasher.combine(dailyWillItRain)
            hasher.combine(dailyChanceOfRain)
            hasher.combine(dailyWillItSnow)
            hasher.combine(dailyChanceofSnow)
            hasher.combine(condition)
            hasher.combine(uv)
        }
}

struct Astro: Codable, Hashable {
    var sunrise: String
    var sunset: String
    var moonrise: String
    var moonset: String
    var moonPhase: String
    var moonIllumination: String
    var isMoonUp: Bool
    var isSunUp: Bool
    
    enum CodingKeys: String, CodingKey {
        case sunrise
        case sunset
        case moonrise
        case moonset
        case moonPhase = "moon_phase"
        case moonIllumination = "moon_illumination"
        case isMoonUp = "is_moon_up"
        case isSunUp = "is_sun_up"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.sunrise = try container.decode(String.self, forKey: .sunrise)
        self.sunset = try container.decode(String.self, forKey: .sunset)
        self.moonrise = try container.decode(String.self, forKey: .moonrise)
        self.moonset = try container.decode(String.self, forKey: .moonset)
        self.moonPhase = try container.decode(String.self, forKey: .moonPhase)
        self.moonIllumination = try container.decode(String.self, forKey: .moonIllumination)
        let moonUpValue = try container.decode(Int.self, forKey: .isMoonUp)
        self.isMoonUp = moonUpValue != 0
        let sunUpValue = try container.decode(Int.self, forKey: .isSunUp)
        self.isSunUp = sunUpValue != 0
    }
    
    static func == (lhs: Astro, rhs: Astro) -> Bool {
        return lhs.sunrise == rhs.sunrise &&
        lhs.sunset == rhs.sunset &&
        lhs.moonrise == rhs.moonrise &&
        lhs.moonset == rhs.moonset &&
        lhs.moonPhase == rhs.moonPhase &&
        lhs.moonIllumination == rhs.moonIllumination &&
        lhs.isMoonUp == rhs.isMoonUp &&
        lhs.isSunUp == rhs.isSunUp
    }
    
    func hash(into hasher: inout Hasher) {
            hasher.combine(sunrise)
            hasher.combine(sunset)
            hasher.combine(moonrise)
            hasher.combine(moonset)
            hasher.combine(moonPhase)
            hasher.combine(moonIllumination)
            hasher.combine(isMoonUp)
            hasher.combine(isSunUp)
        }
}

struct Hour: Codable, Hashable {
    var timeEpoch: Int
    var time: String
    var tempC: Double
    var tempF: Double
    var isDay: Bool
    var condition: Condition
    var windMph: Double
    var windKph: Double
    var windDegree: Int
    var windDir: String
    var pressureMb: Int
    var pressureIn: Double
    var precipMm: Int
    var precipIn: Int
    var humidity: Int
    var cloud: Int
    var feelsLikeC: Double
    var feelsLikeF: Double
    var windChillC: Double
    var windChillF: Double
    var heatIndexC: Double
    var heatIndexF: Double
    var dewpointC: Double
    var dewpointF: Double
    var willItRain: Bool
    var chanceOfRain: Int
    var willItSnow: Bool
    var chanceofSnow: Int
    var visKm: Int
    var visMiles: Int
    var gustMph: Double
    var gustKph: Double
    var uv: Int
    
    enum CodingKeys: String, CodingKey {
        case timeEpoch = "time_epoch"
        case time
        case tempC = "temp_c"
        case tempF = "temp_f"
        case isDay = "is_day"
        case condition
        case windMph = "wind_mph"
        case windKph = "wind_kph"
        case windDegree = "wind_degree"
        case windDir = "wind_dir"
        case pressureMb = "pressure_mb"
        case pressureIn = "pressure_in"
        case precipMm = "precip_mm"
        case precipIn = "precip_in"
        case humidity
        case cloud
        case feelsLikeC = "feelslike_c"
        case feelsLikeF = "feelslike_f"
        case windChillC = "windchill_c"
        case windChillF = "windchill_f"
        case heatIndexC = "heatindex_c"
        case heatIndexF = "heatindex_f"
        case dewpointC = "dewpoint_c"
        case dewpointF = "dewpoint_f"
        case willItRain = "will_it_rain"
        case chanceOfRain = "chance_of_rain"
        case willItSnow = "will_it_snow"
        case chanceofSnow = "chance_of_snow"
        case visKm = "vis_km"
        case visMiles = "vis_miles"
        case gustMph = "gust_mph"
        case gustKph = "gust_kph"
        case uv
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.timeEpoch = try container.decode(Int.self, forKey: .timeEpoch)
        self.time = try container.decode(String.self, forKey: .time)
        self.tempC = try container.decode(Double.self, forKey: .tempC)
        self.tempF = try container.decode(Double.self, forKey: .tempF)
        let isDayValue = try container.decode(Int.self, forKey: .isDay)
        self.isDay = isDayValue != 0
        self.condition = try container.decode(Condition.self, forKey: .condition)
        self.windMph = try container.decode(Double.self, forKey: .windMph)
        self.windKph = try container.decode(Double.self, forKey: .windKph)
        self.windDegree = try container.decode(Int.self, forKey: .windDegree)
        self.windDir = try container.decode(String.self, forKey: .windDir)
        self.pressureMb = try container.decode(Int.self, forKey: .pressureMb)
        self.pressureIn = try container.decode(Double.self, forKey: .pressureIn)
        self.precipMm = try container.decode(Int.self, forKey: .precipMm)
        self.precipIn = try container.decode(Int.self, forKey: .precipIn)
        self.humidity = try container.decode(Int.self, forKey: .humidity)
        self.cloud = try container.decode(Int.self, forKey: .cloud)
        self.feelsLikeC = try container.decode(Double.self, forKey: .feelsLikeC)
        self.feelsLikeF = try container.decode(Double.self, forKey: .feelsLikeF)
        self.windChillC = try container.decode(Double.self, forKey: .windChillC)
        self.windChillF = try container.decode(Double.self, forKey: .windChillF)
        self.heatIndexC = try container.decode(Double.self, forKey: .heatIndexC)
        self.heatIndexF = try container.decode(Double.self, forKey: .heatIndexF)
        self.dewpointC = try container.decode(Double.self, forKey: .dewpointC)
        self.dewpointF = try container.decode(Double.self, forKey: .dewpointF)
        let willRainValue = try container.decode(Int.self, forKey: .willItRain)
        self.willItRain = willRainValue != 0
        self.chanceOfRain = try container.decode(Int.self, forKey: .chanceOfRain)
        let willSnowValue = try container.decode(Int.self, forKey: .willItSnow)
        self.willItSnow = willSnowValue != 0
        self.chanceofSnow = try container.decode(Int.self, forKey: .chanceofSnow)
        self.visKm = try container.decode(Int.self, forKey: .visKm)
        self.visMiles = try container.decode(Int.self, forKey: .visMiles)
        self.gustMph = try container.decode(Double.self, forKey: .gustMph)
        self.gustKph = try container.decode(Double.self, forKey: .gustKph)
        self.uv = try container.decode(Int.self, forKey: .uv)
    }
    
    static func == (lhs: Hour, rhs: Hour) -> Bool {
            return lhs.timeEpoch == rhs.timeEpoch &&
                lhs.time == rhs.time &&
                lhs.tempC == rhs.tempC &&
                lhs.tempF == rhs.tempF &&
                lhs.isDay == rhs.isDay &&
                lhs.condition == rhs.condition &&
                lhs.windMph == rhs.windMph &&
                lhs.windKph == rhs.windKph &&
                lhs.windDegree == rhs.windDegree &&
                lhs.windDir == rhs.windDir &&
                lhs.pressureMb == rhs.pressureMb &&
                lhs.pressureIn == rhs.pressureIn &&
                lhs.precipMm == rhs.precipMm &&
                lhs.precipIn == rhs.precipIn &&
                lhs.humidity == rhs.humidity &&
                lhs.cloud == rhs.cloud &&
                lhs.feelsLikeC == rhs.feelsLikeC &&
                lhs.feelsLikeF == rhs.feelsLikeF &&
                lhs.windChillC == rhs.windChillC &&
                lhs.windChillF == rhs.windChillF &&
                lhs.heatIndexC == rhs.heatIndexC &&
                lhs.heatIndexF == rhs.heatIndexF &&
                lhs.dewpointC == rhs.dewpointC &&
                lhs.dewpointF == rhs.dewpointF &&
                lhs.willItRain == rhs.willItRain &&
                lhs.chanceOfRain == rhs.chanceOfRain &&
                lhs.willItSnow == rhs.willItSnow &&
                lhs.chanceofSnow == rhs.chanceofSnow &&
                lhs.visKm == rhs.visKm &&
                lhs.visMiles == rhs.visMiles &&
                lhs.gustMph == rhs.gustMph &&
                lhs.gustKph == rhs.gustKph &&
                lhs.uv == rhs.uv
        }
        
        func hash(into hasher: inout Hasher) {
            // Combine the hash values of relevant properties
            hasher.combine(timeEpoch)
            hasher.combine(time)
            hasher.combine(tempC)
            hasher.combine(tempF)
            hasher.combine(isDay)
            hasher.combine(condition)
            hasher.combine(windMph)
            hasher.combine(windKph)
            hasher.combine(windDegree)
            hasher.combine(windDir)
            hasher.combine(pressureMb)
            hasher.combine(pressureIn)
            hasher.combine(precipMm)
            hasher.combine(precipIn)
            hasher.combine(humidity)
            hasher.combine(cloud)
            hasher.combine(feelsLikeC)
            hasher.combine(feelsLikeF)
            hasher.combine(windChillC)
            hasher.combine(windChillF)
            hasher.combine(heatIndexC)
            hasher.combine(heatIndexF)
            hasher.combine(dewpointC)
            hasher.combine(dewpointF)
            hasher.combine(willItRain)
            hasher.combine(chanceOfRain)
            hasher.combine(willItSnow)
            hasher.combine(chanceofSnow)
            hasher.combine(visKm)
            hasher.combine(visMiles)
            hasher.combine(gustMph)
            hasher.combine(gustKph)
            hasher.combine(uv)
        }
}


struct Forecast: Codable {
    
    enum CodingKeys: String, CodingKey {
        case location
        case current
        case forecast
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.location = try container.decode(Location.self, forKey: .location)
        self.current = try container.decodeIfPresent(CurrentForecast.self, forKey: .current)
        self.forecast = try container.decode(ForecastObject.self, forKey: .forecast)
    }
    
    var location: Location
    var current: CurrentForecast?
    var forecast: ForecastObject
}

struct ForecastObject: Codable {
    var forecastDay: [ForecastDay]?
    
    enum CodingKeys: String, CodingKey {
        case forecastDay = "forecastday"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.forecastDay = try container.decodeIfPresent([ForecastDay].self, forKey: .forecastDay)
    }
}
