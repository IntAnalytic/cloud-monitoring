import plotly
plotly.tools.set_credentials_file(username='ENTER YOUR PLOTLY USERNAME HERE', api_key='ENTER YOUR API KEY HERE')
import plotly.plotly as py
import plotly.graph_objs as go
import plotly.io as pio

def sendfunc(rows3):

    l = []

    for i in rows3:
        l.append(list(i))

    schema = [i[0] for i in l]

    nos = [i[1] for i in l]

    nos = [int(x) for x in nos]

    i = 0
    t = 0
    while i < len(nos):
        t += nos[i]
        i += 1

    P = [float(x/t*100) for x in nos]

    trace1 = go.Bar(
        y=[''],
        x=[P[0]], 
        name = (f"{schema[0]}"),
        text = (f"{nos[0]}"),
        textposition = 'auto',
        orientation = 'h',
        marker = dict(
            color = 'rgba(103, 240, 160, 0.75)',
            line = dict(
                color = '#43BD78',
                width = 3)
        )
    )
    trace2 = go.Bar(
        y=[''],
        x=[P[1]],
        name=(f"{schema[1]}"),
        text = (f"{nos[1]}"),
        textposition = 'auto',
        orientation = 'h',
        marker = dict(
            color = 'rgba(255, 172, 188, 0.75)',
            line = dict(
                color = '#E67188',
                width = 3)
        )
    )
    trace3 = go.Bar(
        y=[''],
        x=[P[2]],
        name=(f"{schema[2]}"),
        text = (f"{nos[2]}"),
        textposition = 'auto',
        orientation = 'h',
        marker = dict(
            color = 'rgba(177, 193, 216, 1.0)',
            line = dict(
                color = '#82A1D0',
                width = 3)
        )
    )
    trace4 = go.Bar(
        y=[''],
        x=[P[3]],
        name=(f"{schema[3]}"),
        text = (f"{nos[3]}"),
        textposition = 'auto',
        orientation = 'h',
        marker = dict(
            color = 'rgba(250, 184, 126, 0.75)',
            line = dict(
                color = '#DF8E47',
                width = 3)
        )
    )
    trace5 = go.Bar(
        y=[''],
        x=[P[4]],
        name=(f"{schema[4]}"),
        text = (f"{nos[4]}"),
        textposition = 'inside',
        orientation = 'h',
        marker = dict(
            color = '#C8A8CD',
            line = dict(
                color = '#9C7DA1',
                width = 3)
        )
    )
    data = [trace1, trace2, trace3, trace4, trace5]
    layout = go.Layout(
        autosize=False,
        width=700,
        height=110,
        barmode='stack',
        xaxis=dict(ticksuffix="%"),
        legend=dict(
            orientation="h", 
            x=0.06, 
            y=-0.27,
            font=dict(
                size=10.5
            )
        ),
        margin=go.layout.Margin(
            l=60,
            r=60,
            b=0,
            t=0,
            pad=0
        )
    )

    fig = go.Figure(data=data, layout=layout)
    py.iplot(fig, filename='marker-h-bar')

    pio.write_image(fig,'latesttablecapacity_uniccp.png')