Text Prediction
========================================================
author: Sid M.
date: August 2015
font-import: http://fonts.googleapis.com/css?family=Istok+Web
font-family: 'Istok Web', sans-serif
css: finalReport.css
For Data Science Capstone

Introduction
========================================================
The goal of this project was to create an app where a user enters a sentence fragment,
and the app tries to guess what the next word ought to be.

The model was built from a corpus of text over 600 MB in size.

I used the Unix terminal, R and Scala to help produce the model.

The front end app was written in R (shiny).

Creating the Model : Part I
========================================================

First, I cleaned the corpus in the UNIX terminal using a series of commands, using sed, tr, split, etc. Operations included: Eliminating non-alphabet characters (keeping punctuation), removing hashtags, cleaning multiple punctuation marks, converting the text to lower case, and other small operations.

Second, I used the RWeka and tm libraries in R to Tokenise the corpus into bigrams, trigrams and tetragrams.

Third, I created TermDocumentMatrices of the n-grams and got the term frequencies.

You can read upto this stage in the [capstone milestone report](http://rpubs.com/Syd/capstonemilestone).

Creating the Model : Part II
========================================================

- I saved the term-frequencies calculated in the prior page as csvs (in R).
- I read the csvs in *Scala*, and split the terms into "search" and "predict" parts. 
- I applied a low-pass filter to the trigrams and tetragram, eliminating rare n-grams.
- I grouped by "search" terms, sorting each group in descending order by frequency.
- I took the top 3 terms for each "search" term.
- I write the "search" and "predict" terms back as csvs.
- I read the csvs in R, and saved it as RDS files to increase speed of access.


The App: How it works
========================================================
When the user enters a sentence in the app and hits "Predict", the app first cleans the text. Cleaning involves taking only text past the last hard punctuation mark. We grab the last 3 words (or less) from the sentence fragment, drop all non-alphabet characters from it, convert it to lowercase and other minor operations.

Now that we have the cleaned text to predict from, we first check the tetragrams for the predicted text. If nothing is found, we then check the trigrams. If nothing is still found, we check the text against with the bigrams.

Note: The algorithm I use is rather simple, mostly owing to work and real life getting in the way of exploring things like back-off models, etc. However, I find that my model predicts pretty well.

Using the App
========================================================
Using the app is ridiculously simple.

All you need to do is enter a sentence fragment in the text box to the left of the screen (example: "How are you"), and click the Predict button below it.

After you do so, you will be presented with the sentence fragment that my app is predicting from and predicted text below it with individual words in buttons. You can click those buttons to add the text to the sentence fragment to the left, if you wish.

Links
========================================================
You can check out the app [here](https://sidm.shinyapps.io/textPrediction).

You can view the source code on github [here](https://github.com/Syd-/dsscapstone-004).
