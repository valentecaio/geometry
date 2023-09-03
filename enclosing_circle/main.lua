-- TODO: why does this not work?
-- local Plot = require("../matplotlua.matplotlua")
-- local Utils = require("../utils.utils")

-- hotfix for the issue above:
package.path = package.path .. ";../?/?.lua"

local Plot = require("matplotlua")
local Utils = require("utils")
local EnclosingCircle = require("enclosing_circle")

-- generate N random points within a given rectangle
function generateRandomPoints(N, minX, minY, maxX, maxY)
  local points = {}
  for i = 1, N do
    local x = math.random(minX, maxX)
    local y = math.random(minY, maxY)
    table.insert(points, {x = x, y = y})
  end
  return points
end

-- generate N random points contained in a given circle
function generateRandomPointsInCircle(N, centerX, centerY, radius)
  local points = {}
  for i = 1, N do
    local angle = math.random() * 2 * math.pi
    local distance = math.sqrt(math.random()) * radius
    local x = centerX + distance * math.cos(angle)
    local y = centerY + distance * math.sin(angle)
    table.insert(points, {x = x, y = y})
  end
  return points
end

-- add points to the plot
function addPoints(points)
  for _, point in ipairs(points) do
    Plot.addPoint(point.x, point.y)
  end
end

circle = {x = 0, y = 0, r = 100}
Utils.printTable(circle, "Circle")
points = generateRandomPointsInCircle(40, circle.x, circle.y, circle.r)
addPoints(points)
print(EnclosingCircle.validateCircle(circle, points))

circle = EnclosingCircle.dumb(points)
Plot.addCircle(circle.x, circle.y, circle.r, "Dumb", "red")
Utils.printTable(circle, "Dumb")
print(EnclosingCircle.validateCircle(circle, points))

circle = EnclosingCircle.heuristic(points)
Plot.addCircle(circle.x, circle.y, circle.r, "Heuristic", "blue")
Utils.printTable(circle, "Heuristic")
print(EnclosingCircle.validateCircle(circle, points))

-- circle = EnclosingCircle.bruteForce(points)
-- Plot.addCircle(circle.x, circle.y, circle.r, "Brute Force", "yellow")
-- Utils.printTable(circle, "Brute Force")
-- print(EnclosingCircle.validateCircle(circle, points))

circle, boundary = EnclosingCircle.welzl(points)
Plot.addCircle(circle.x, circle.y, circle.r, "Welzl", "green")
Utils.printTable(circle, "Welzl")
print(EnclosingCircle.validateCircle(circle, points))

Plot.plot()