import neurokit2 as nk

data = nk.data("bio_eventrelated_100hz")
data


nk.signal_plot(data, subplots=True)

bio, info = nk.bio_process(
    ecg=data["ECG"],
    rsp=data["RSP"],
    eda=data["EDA"],
    keep=data["Photosensor"],
    sampling_rate=100,
)
bio


nk.signal_plot(bio["Photosensor"])
events = nk.events_find(bio["Photosensor"], threshold_keep="below")
events


epochs = nk.epochs_create(
    bio,
    events,
    sampling_rate=100,
    epochs_start=0,
    epochs_end=7,
)
epochs

nk.epochs_plot(epochs, columns=["ECG_Rate", "EDA_Phasic"])


df = nk.bio_analyze(epochs, sampling_rate=100)
df.to_csv("data_bio.csv", index=False)
df