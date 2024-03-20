import json

import numpy as np
import pandas as pd


# Get files from OSF ======================================================
def osf_listfiles(data_subproject="", token="", after_date=None):
    try:
        import osfclient
    except ImportError:
        raise ImportError("Please install 'osfclient' (`pip install osfclient`)")
    osf = osfclient.OSF(token=token).project(data_subproject)  # Connect to project
    storage = [s for s in osf.storages][0]  # Access storage component
    files = [
        {
            "name": file.name.replace(".csv", ""),
            "date": pd.to_datetime(file.date_created),
            "url": file._download_url,
            "size": file.size,
            "file": file,
        }
        for file in storage.files
    ]
    file = [f for f in storage.files][0]
    file.__dict__

    if after_date is not None:
        date = pd.to_datetime(after_date, format="%d/%m/%Y", utc=True)
        files = [f for f, d in zip(files, [f["date"] > date for f in files]) if d]
    return files


token = "zYboMoukFI8HKabenQ35DH6tESHJo6oZll5BvOPma6Dppjqc2jnIB6sPCERCuaqO0UrHAa"  # Paste OSF token here to access private repositories
files = osf_listfiles(
    token=token,
    data_subproject="wzxhm",  # Data subproject ID
    after_date="13/03/2023",
)


# Loop through files ======================================================
alldata = pd.DataFrame()  # Initialize empty dataframe

for i, file in enumerate(files):
    print(f"File N°{i+1}/{len(files)}")

    data = pd.read_csv(file["file"]._get(file["url"], stream=True).raw)
    dat = pd.DataFrame({"Participant": [file["name"]], "Date": [file["date"]]})

    freetext = json.loads(data.loc[data.screen == "freetext", "response"][0])

    if dat["Date"].values[0] < pd.to_datetime("2024-03-20"):
        dat["Module"] = "Bayesian Statistics"
        dat["When"] = "Midterm"
        occ = freetext["Occupation"]
        occ = "MRes (Psychology)" if "MRes" in occ else occ
        occ = "PhD (Neuroscience)" if "PhD Sussex Neuroscience" in occ else occ
        occ = "PhD (Psychology)" if occ in ["PhD psych", "Technician and PhD in Psychology", "phd student "] else occ
        occ = "Postdoc" if occ in ["Postdoctoral research fellow"] else occ
        dat["Occupation"] = occ

    for k in ["WhatDidYouLike", "WhatWouldYouChange"]:
        dat[k] = freetext[k]
    likert1 = json.loads(data.loc[data.screen == "likert1", "response"][1])
    for k in likert1.keys():
        dat[k] = likert1[k]
    likert2 = json.loads(data.loc[data.screen == "likert2", "response"][2])
    for k in likert2.keys():
        dat[k] = likert2[k]
    feedback = json.loads(data.loc[data.screen == "feedback", "response"][3])
    for k in feedback.keys():
        dat[k] = feedback[k]

    alldata = pd.concat([alldata, dat], axis=0, ignore_index=True)


alldata.to_csv("../data/data.csv", index=False)
print("Done!")
alldata["Occupation"][0]
