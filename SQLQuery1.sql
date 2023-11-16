---1 
Select SUM(new_cases) as total_cases, SUM(new_deaths ) as total_deaths, SUM(new_deaths )/SUM(New_Cases)*100 as DeathPercentage
From covid..CovidDeaths
--Where location like '%states%'
where continent is not null 
--Group By date
order by 1,2
---

SELECT
    ---date,
    SUM(new_cases) as Total_cases,
    SUM(new_deaths) as Total_deaths,
    CASE
        WHEN SUM(new_cases) <> 0 THEN (SUM(new_deaths) / SUM(new_cases)) * 100
        ELSE NULL -- or another default value or action
    END AS Death_percentage
FROM covid..CovidDeaths
WHERE continent IS NULL
---GROUP BY date
ORDER BY 1, 2;
----


---looking total population vs vaccination
 
 
 SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
 ,SUM(vac.new_vaccinations) OVER (Partition by dea.location ORDER BY dea.location ,dea.date) as Total_vac
FROM covid..CovidVaccinations vac
JOIN covid..CovidDeaths dea
On dea.location=vac.location
and dea.date=vac.date
where dea.continent is not null
ORDER BY 2,3
---

---
