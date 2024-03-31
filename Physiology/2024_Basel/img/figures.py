ecg = nk.ecg_simulate(
    duration=10,
    sampling_rate=200,
    heart_rate=70,
    heart_rate_std=5,
)
xaxis = np.linspace(0, 10, len(ecg))
peaks = nk.ecg_findpeaks(ecg, sampling_rate=200)["ECG_R_Peaks"]
rri = np.diff(peaks) / 200
hr = 60 / rri
hr_1 = nk.ecg_rate(
    peaks,
    sampling_rate=200,
    desired_length=len(ecg),
    interpolation_method="linear",
)
hr_2 = nk.ecg_rate(
    peaks,
    sampling_rate=200,
    desired_length=len(ecg),
    interpolation_method="monotone_cubic",
)

# Make 3 subplots
fig, (ax1, ax2, ax3) = plt.subplots(3, 1, sharex=True, figsize=(10, 7))
for peak in peaks:
    ax1.axvline(x=xaxis[peak], color="#4CAF50", linestyle="--", label="R-Peaks")
ax1.plot(xaxis, ecg, color="red")
ax1.set_xlabel("Time (seconds)")
ax1.set_ylabel("ECG")
ax1.set_title("1. Peak Detection")

for x, y in enumerate(rri):
    ax2.vlines(
        x=xaxis[peaks[x + 1]],
        ymin=0.5,
        ymax=y,
        color="#4CAF50",
        label="RRi",
    )
    # Add point
    ax2.scatter(
        x=xaxis[peaks[x + 1]],
        y=y,
        color="#4CAF50",
    )
ax2.set_ylim([0.7, 1])
ax2.set_xlabel("Time (seconds)")
ax2.set_ylabel("R-R Interval (seconds)")
ax2.set_title("2. Signal Period")

for x, y in enumerate(hr):
    ax3.vlines(x=xaxis[peaks[x + 1]], ymin=60, ymax=y, color="#FF5722")
    # Add point
    ax3.scatter(
        x=xaxis[peaks[x + 1]],
        y=y,
        color="#FF5722",
    )
ax3.plot(xaxis, hr_1, color="#1E88E5", label="Interpolation: Linear")
ax3.plot(xaxis, hr_2, color="#8E24AA", label="Interpolation: Cubic")
ax3.set_ylabel("Heart Rate (bpm)")
ax3.set_xlabel("Time (seconds)")
ax3.set_title("3. Heart Rate")
plt.legend()
plt.tight_layout()
