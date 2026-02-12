import numpy as np
import pandas as pd
from Orange.data import Table, Domain, ContinuousVariable

# Convertimos los datos de entrada a DataFrame
df = pd.DataFrame(in_data.X, columns=[var.name for var in in_data.domain.attributes])

# Lista de variables que no se deben transformar
exclude_vars = ['chas']

# Creamos una copia del DataFrame y aplicamos log(x+1) excepto a CHAS
df_log = df.copy()
vars_to_transform = [col for col in df.columns if col not in exclude_vars]
df_log[vars_to_transform] = np.log1p(df[vars_to_transform])

# Creamos nuevas variables con nombres modificados para las transformadas
new_vars = []
for col in df.columns:
    if col in exclude_vars:
        new_vars.append(ContinuousVariable(col))  # sin cambio
    else:
        new_vars.append(ContinuousVariable(col + "_log"))  # renombrado

# Crear dominio nuevo y tabla con clase si existe
if in_data.domain.class_var is not None:
    domain = Domain(new_vars, in_data.domain.class_var)
    new_table = Table(domain, df_log.values, in_data.Y)
else:
    domain = Domain(new_vars)
    new_table = Table(domain, df_log.values)

# Salida
out_data = new_table
