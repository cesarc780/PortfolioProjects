CREATE VIEW PercentPopulationVaccinated AS
    SELECT
        dea.continent AS Continent,
        dea.location AS Location,
        dea.date AS Date,
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
       dea.continent IS NOT NULL;
