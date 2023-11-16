WITH PopvsVac AS
(
    SELECT
        dea.continent AS Continent,
        dea.location AS Location,
        dea.date As Date,
        dea.population AS Population,
        vac.new_vaccinations AS New_Vac,
        SUM(vac.new_vaccinations) OVER (PARTITION BY dea.location ORDER BY dea.date) AS Total_vac
    FROM
        covid..CovidVaccinations vac
    JOIN
        covid..CovidDeaths dea
    ON
        dea.location = vac.location
        AND dea.date = vac.date
    WHERE
        dea.continent IS NOT NULL
)

SELECT *, (Total_vac/Population)*100 
FROM PopvsVac;
---
----TEMP TABLE
DROP TABLE IF EXISTS #PercentPopulationVaccinated
CREATE TABLE #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_Vac numeric,
Total_vac numeric
)
INSERT INTO #PercentPopulationVaccinated
SELECT
        dea.continent AS Continent,
        dea.location AS Location,
        dea.date As Date,
        dea.population AS Population,
        vac.new_vaccinations AS New_Vac,
        SUM(vac.new_vaccinations) OVER (PARTITION BY dea.location ORDER BY dea.date) AS Total_vac
    FROM
        covid..CovidVaccinations vac
    JOIN
        covid..CovidDeaths dea
    ON
        dea.location = vac.location
        AND dea.date = vac.date
   -- WHERE
    --    dea.continent IS NOT NULL

	Select * From #PercentPopulationVaccinated

	--- creating view to store data

	Create view #PercentPopulationVaccinated as
	SELECT
        dea.continent AS Continent,
        dea.location AS Location,
        dea.date As Date,
        dea.population AS Population,
        vac.new_vaccinations AS New_Vac,
        SUM(vac.new_vaccinations) OVER (PARTITION BY dea.location ORDER BY dea.date) AS Total_vac
    FROM
        covid..CovidVaccinations vac
    JOIN
        covid..CovidDeaths dea
    ON
        dea.location = vac.location
        AND dea.date = vac.date
    WHERE
       dea.continent IS NOT NULL