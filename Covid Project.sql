SELECT * FROM covid.coviddeaths
where continent is not null
order by 3,4;

SELECT * from covid.covidvaccinations
order by 3,4;

SELECT Location, date, total_cases, new_cases, total_deaths, population
FROM covid.coviddeaths
order by 1,2;

/* Showing the total cases vs population with locations that have af*/
Select location, date, total_cases, population, (total_cases/population)*100 as DeathPercentage
from covid.coviddeaths
where location like '%states%'
order by 1,2;


/*Looking at Total Cases vs Total Deaths*/
/* Shows likelihood of dying if you contract covid in your country*/
SELECT Location, date, total_cases, new_cases, (total_deaths/total_cases)*100 as DeathPercentage
FROM covid.coviddeaths
order by 1,2;


/* Looking at the Maximum total deaths*/
SELECT location, MAX(CAST(total_deaths AS UNSIGNED)) AS maximum
FROM covid.coviddeaths
GROUP BY location
ORDER BY maximum DESC
LIMIT 1;

/* Looking at Total cases vs Population*/
/* shows what percentage of population got covid*/

Select location, date, population, total_cases, format((total_cases/population)*100,4) as PercentPopulation
from covid.coviddeaths
where location like '%states%'
order by 1,2;

/* Looking at Countries with Highest Infection rate compared to population */
Select location, population, max(total_cases) as HighestInfectionCount, format(max((total_cases/population)*100),4) as PercentPopulationInfected
from covid.coviddeaths
group by location,population
order by PercentPopulationInfected desc;

/* Showing Countries with Highest Death per Population*/
SELECT location, MAX(CAST(NULLIF(total_deaths, '') AS SIGNED)) AS TotalDeathCount
FROM covid.coviddeaths
where continent is not null
GROUP BY location
ORDER BY TotalDeathCount DESC;


/* Lets break things down by continent*/
SELECT continent, MAX(CAST(NULLIF(total_deaths, '') AS SIGNED)) AS TotalDeathCount
FROM covid.coviddeaths
where continent is not null and continent <> ''
GROUP BY continent
ORDER BY TotalDeathCount DESC;


/* Showing the continents with the highest death count per population*/
SELECT continent, MAX(CAST(NULLIF(total_deaths, '') AS SIGNED)) AS TotalDeathCount
FROM covid.coviddeaths
WHERE continent is not null or ''
GROUP BY continent
ORDER BY TotalDeathCount desc;

/* Global numbers*/

SELECT 
    SUM(new_cases) AS total_cases, 
    SUM(CAST(new_deaths AS UNSIGNED)) AS total_deaths, 
    (SUM(CAST(new_deaths AS UNSIGNED)) * 100.0 / NULLIF(SUM(new_cases), 0)) AS DeathPercentage
FROM covid.coviddeaths
WHERE continent IS NOT NULL
ORDER BY 1,2;


/*Looking at Total Population vs Vaccinations using CTE*/

With PopVsVac(Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated)
as 
(
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(new_vaccinations) OVER (Partition by  dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
From covid.coviddeaths dea
join covid.covidvacs vac
on dea.location = vac.location 
and dea.date = vac.date
where dea.continent is not null
)

Select *, (RollingPeopleVaccinated/Population)*100
from PopVsVac