'''
import chart_studio.plotly as py
import plotly.tools as tls
import matplotlib.pyplot as plt
import pandas as pd
import numpy as np

distanceToCentroid = pd.read_csv('distance.csv')

x = distanceToCentroid['userID']
y = distanceToCentroid['distanceX1000']

index = np.arange(len(x))
plt.bar(x,y)
plt.xlabel('UserID', fontsize=5)
plt.ylabel('Distance', fontsize=5)
plt.xticks(index, x, fontsize=3, rotation=30)
plt.title('User Anomaly Detection')
plt.show()
'''

'''
import plotly.express as px
import pandas as pd

distanceToCentroid = pd.read_csv('distance.csv')
#data_canada = px.data.gapminder().query("country == 'Canada'")
fig = px.bar(distanceToCentroid, x='userID', y='distance', color='rgba(246, 78, 139, 0.6)')
fig.show()
'''

import plotly.graph_objects as go
import pandas as pd

distances = pd.read_csv('distance.csv')
fig = go.Figure()
fig.add_trace(go.Bar(
    y = distances['distance'],
    x = distances['userID'],
    name='User Anomaly Detection',
    orientation='v',
    marker=dict(
        #color='rgba(246, 78, 139, 0.6)',
        #line=dict(color='rgba(246, 78, 139, 1.0)')
        line=dict(color='rgba(0, 0, 255, 1.0)')
    )
))

fig.update_layout(barmode='stack')
fig.show()
