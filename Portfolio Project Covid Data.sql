SELECT *
FROM CovidDeaths
WHERE continent is not null
ORDER BY 3,4 



SELECT *
FROM CovidVaccinations
ORDER BY 3,4 

--SELECT DATA I AM ABOUT TO USE 

SELECT Location, date,total_cases,new_cases,total_deaths,population_density
FROM CovidDeaths
WHERE continent is not null
ORDER BY 1,2

--Looking at Total Cases vs Total Deaths
--Shows likelihood of dying if you contract covid in your country

SELECT Location, date,total_cases,total_deaths,(total_deaths/total_cases)*100 as DeathPercentage
FROM CovidDeaths
WHERE location like '%states%'
WHERE continent is not null
ORDER BY 1,2



--Looking at Total Cases vs Population 
--Shows what percentage of population got covid 

SELECT Location,date,total_cases,population,(total_cases/population)*100 as PercentPopulationInfected
FROM CovidDeaths 
WHERE location like '%ukraine'
WHERE continent is not null
ORDER BY 1,2



--Looking at Countries with Highest Infection Rate compared to Population 

SELECT Location,Population,MAX(total_cases) as HighestInfectionCount,MAX((total_cases/population))*100 as PercentPopulationInfected
FROM CovidDeaths 
--WHERE location like '%ukraine'
WHERE continent is not null
GROUP BY Location,Population 
ORDER BY PercentPopulationInfected desc




--Showing Countries with Highest Death Count per Population 

SELECT Location,MAX(cast(Total_deaths as int )) as TotalDeathCount 
FROM CovidDeaths 
--WHERE location like '%ukraine'
WHERE continent is not null
GROUP BY Location
ORDER BY TotalDeathCount desc



--BREAKING DATA DOWN BY CONTINENT

SELECT continent,MAX(cast(Total_deaths as int )) as TotalDeathCount 
FROM CovidDeaths 
--WHERE location like '%ukraine'
WHERE continent is not null
GROUP BY continent 
ORDER BY TotalDeathCount desc



--GLOBAL NUMBERS 


SELECT  SUM(new_cases) as TotalCases, SUM(CAST(new_deaths as int)) as TotalDeaths,SUM(new_cases)*100 as DeathPercentage --total_deaths,(total_deaths/total_cases)*100 as DeathPercentage
FROM CovidDeaths
--WHERE location like '%states%'
WHERE continent is not null
--GROUP BY date 
ORDER BY 1,2



--Looking at Total population vs Vaccinations

SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(Cast(vac.new_vaccinations as bigint)) OVER (Partition  by dea.location ORDER BY dea.location,dea.date)as PeopleVaccinated
--(PeopleVaccinated/population)*100
FROM CovidDeaths dea
JOIN CovidVaccinations vac
ON dea.location = vac.location
and dea.date = vac.date
WHERE dea.continent is not null
ORDER BY 2,3


--USE CTE

With PopvsVac (Continent,Location,DATE,Population,new_vaccinations,PeopleVaccinated)
as
(
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(Cast(vac.new_vaccinations as bigint)) OVER (Partition  by dea.location ORDER BY dea.location,dea.date)as PeopleVaccinated
--(PeopleVaccinated/population)*100
FROM CovidDeaths dea
JOIN CovidVaccinations vac
ON dea.location = vac.location
and dea.date = vac.date
WHERE dea.continent is not null
--ORDER BY 2,3
)

SELECT*,(PeopleVaccinated/Population)*100
FROM PopvsVac 






--TEMP TABLE

DROP TABLE IF EXISTS #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
PeopleVaccinated numeric
)



Insert into #PercentPopulationVaccinated
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(Cast(vac.new_vaccinations as bigint)) OVER (Partition  by dea.location ORDER BY dea.location,dea.date)as PeopleVaccinated
--(PeopleVaccinated/population)*100
FROM CovidDeaths dea
JOIN CovidVaccinations vac
ON dea.location = vac.location
and dea.date = vac.date
WHERE dea.continent is not null
--ORDER BY 2,3


SELECT*,(PeopleVaccinated/Population)*100
FROM #PercentPopulationVaccinated


-- Creating view to store data for later visualizations 

CREATE View PercentPopulationVaccinated as 
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(Cast(vac.new_vaccinations as bigint)) OVER (Partition  by dea.location ORDER BY dea.location,dea.date)as PeopleVaccinated
--(PeopleVaccinated/population)*100
FROM CovidDeaths dea
JOIN CovidVaccinations vac
ON dea.location = vac.location
and dea.date = vac.date
WHERE dea.continent is not null
--ORDER BY 2,3


