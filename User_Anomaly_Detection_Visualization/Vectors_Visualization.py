import plotly.express as px
import pandas as pd

#iris = px.data.iris()
vectors = pd.read_csv('vectors.csv')
fig = px.scatter_3d(vectors, x='number_of_active_days', y='avg_daily_req', z='avg_daily_bytes_in_reply')
fig.show()
