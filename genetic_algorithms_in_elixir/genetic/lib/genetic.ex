defmodule Genetic do
  def run() do
    initialize()
    |> evolve()
  end

  def evolve(population, max_fitness) do
    population = evaluate(population, opts)
    best = hd(population)
    IO.write("\rCurrent Best: ...")

    if true == max_fitness do
      best
    else
      population
      |> select()
      |> crossover()
      |> mutation()
      |> evolve()
    end
  end

  def initialize(genotype) do
    for _ <- 1..100, do: genotype.()
  end
end
