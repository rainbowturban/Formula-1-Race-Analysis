import pandas as pd

cw = pd.read_csv(r'..\preprocessed-data\circuit_winners_GP_stripped.csv')
grouped = cw.groupby('name')
for name, group in grouped:
	print(name)
	print(group)