-- queries.sql (analytics examples)

-- 1) Cuisines with more than one recipe
SELECT Cuisine_Type, COUNT(*) AS RecipeCount
FROM RECIPES
GROUP BY Cuisine_Type
HAVING COUNT(*) > 1
ORDER BY RecipeCount DESC;

-- 2) All recipes by cooking time
SELECT RecipeID, Name, Cooking_Time
FROM RECIPES
ORDER BY Cooking_Time ASC, Name;

-- 3) Recipes with the fewest ingredients (ties)
WITH counts AS (
  SELECT RecipeID, COUNT(*) AS n
  FROM INGREDIENTS
  GROUP BY RecipeID
)
SELECT r.RecipeID, r.Name, c.n AS IngredientCount
FROM counts c
JOIN RECIPES r ON r.RecipeID = c.RecipeID
WHERE c.n = (SELECT MIN(n) FROM counts);

-- 4) Step counts per recipe
SELECT r.RecipeID, r.Name, r.Cooking_Time, COUNT(i.Step_Number) AS StepCount
FROM RECIPES r
JOIN INSTRUCTIONS i ON r.RecipeID = i.RecipeID
GROUP BY r.RecipeID, r.Name, r.Cooking_Time
ORDER BY StepCount ASC, r.Name;

-- 5) Full ingredient list per recipe
SELECT r.Name AS Recipe_Name,
       ing.Name AS Ingredient_Name,
       ing.Quantity, ing.Unit, ing.Special_Notes
FROM INGREDIENTS ing
JOIN RECIPES r ON ing.RecipeID = r.RecipeID
ORDER BY r.Name, ing.Name;
