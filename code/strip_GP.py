import pandas as pd

''' Removes the "grand Prix" from tha names of the circuits '''
cw = pd.read_csv(r'..\preprocessed-data\circuit_winners.csv')
cw['name'] = cw['name'].map(lambda x: x.rsplit(' Grand Prix')[0])
cw.to_csv(r'..\preprocessed-data\circuit_winners_GP_stripped.csv', index=False)
