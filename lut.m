function B = lut(new_cell_species, A, species_number)
for i = 1:species_number
    new_cell_species(new_cell_species == i) = A(i);
end
B = new_cell_species;
end
