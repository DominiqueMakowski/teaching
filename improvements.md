

# Physiology

- Timing 2025: 2h topics: had to rush through HRV part
  - Remove ANS part
  - OR Focus on ECG + Cardiac phase (skip ANS + HRV)
- On Respiratory Cycles:
  - The respiratory cycle modulates distinct dynamics of affective and perceptual decision-making: https://www.researchgate.net/publication/379401636_The_respiratory_cycle_modulates_distinct_dynamics_of_affective_and_perceptual_decision-making
- HEPs:
- Pupil dilation and prediction error: https://www.researchgate.net/publication/385429455_Pupil_dilation_offers_a_time-window_on_prediction_error


# Bayesian

- 2025: did everything in 10 weeks, but semester is 11.
- Make R refresher either a full 2 hours / an online video pre-course
- Introduce Marginal distributions as part of the distribution lecture, with exercices on "guess the shape" (banana, doughnut, ...)
- Part on OLS vs. MLE very confusing. Revise OLS vs MLE
  - Introduce MLE first. Present the case where "y" is uniformly distributed (marginally), but when taking into account the effect of 'x', it is actually Normal (at each point of 'x').
  - Introduce the idea of the sliding Normal this way, and of sigma (mention that it is important to compute SE).
  - After introducing MLE, just say that the same result to find sigma is achievable via simple equations, and that is OLs.
  - Alternatively, Introduce OLS directly using formulas, make example for correlation / regression. Mention sigma, and only after present MLE idea and what this sigma represents.
- Assignment: Make TAP 1 in-person (during week 6) + final TAP (make it report) at the end (**AFTER** the last lecture, not week 9)
- https://github.com/benjamin-rosenbaum/bayesian-intro
- Lecture 8 is too much for one (need to introduce data grids, posterior predictive checks, intercept-only models etc)
- Lecture 8/9: change PP checks to use modelbased's estimate_predictions and estimate_relation()
- ROPEs don't like Defaults
- After the lecture on distirbutions, make a summary of data and make exercice with intercept-only models. Show that it predicts the mean.
  - Reframe linear models as models predicting a particular parameter of a distribution (Gaussian for linear models)
  - Show that is also computes sigma, and do a density plot of a variable vs. a pdf of the Normal distribution using the model parameters
  - Only introduces the difference between OLS later, saying that this is a simple equation-based approach to get the same results
- MCMC: read https://www.jeremykun.com/2015/04/06/markov-chain-monte-carlo-without-all-the-bullshit/