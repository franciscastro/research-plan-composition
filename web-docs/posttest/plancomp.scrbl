#lang scribble/base
@(define pyin tt)

@(define (pydisp . t)
  (nested #:style 'inset
    (apply verbatim t)))

@(define imgdisp image)

@title{Plan Composition}

For each problem, write @bold{two} solutions, where each solution
solves the problem using a different approach. You should also 
determine which solution structure you prefer. Use
@(hyperlink "http://goo.gl/forms/n9VBTkpLOK" "this form")
(logged in with your Brown Google ID) to provide your answers. 
Specify your preference with a brief discussion of why.

@section[#:tag "prog-prob"]{Programming Problems}

A personal health record (PHR) contains four pieces of information 
on a patient: their name, height (in meters), weight (in kilograms), 
and last recorded heart rate (as beats-per-minute). A doctor's 
office maintains a list of the personal health records of all its 
patients.

@pydisp{
  data PHR:
    | phr(name :: String, 
          height :: Number, 
          weight :: Number, 
          heart-rate :: Number)
  end
}

@subsection{The BMI Sorter}

Body mass index (BMI) is a measure that attempts to quantify an
individual's tissue mass. It is commonly collected during annual 
checkups or clinic visits. It is defined as:
@pydisp{
BMI = weight / ( height * height )
}
A simplified BMI scale classifies a value below 18.5 as ``underweight'',
a value at least 18.5 but under 25 as ``healthy'', a value at least 25 
but under 30 as ``overweight'', and a value at least 30 as ``obese''.

Design a program called @pyin{bmi-report}---
@pydisp{bmi-report :: List<PHR> -> Report}
---that consumes a list of 
personal health records (defined above) and produces a report 
containing a list of names (not the entire records) of patients 
in each BMI classification category. The names can be in any order. 
Use the following datatype for the report:

@pydisp{
  data Report:
    | bmi-summary(under :: List<String>, 
                  healthy :: List<String>, 
                  over :: List<String>, 
                  obese :: List<String>)
  end
}

@subsection{Data Smoothing}

In data analysis, @italic{smoothing} a data set means approximating it
to capture important patterns in the data while eliding noise or other
fine-scale structures and phenomena. One simple smoothing technique is
to replace each (internal) element of a sequence of values with the
average of that element and its predecessor and successor. Assuming
that extreme outlier values are an abberation caused, perhaps, through
poor measurement, this averaging process replaces them with a more
plausible value in the context of that sequence.

For example, consider this sequence of @pyin{heart-rate} values taken 
from a list of personal health records (defined above):

@pydisp{
95 102 98 88 105
}

The resulting smoothed sequence should be

@pydisp{
95 98.33 96 97 105
}

where:
@itemlist[@item{@tt{102} was substituted by @tt{98.33: (95 + 102 + 98) / 3}}
          @item{@tt{98} was substituted by @tt{96: (102 + 98 + 88) / 3}}
          @item{@tt{88} was substituted by @tt{97: (98 + 88 + 105) / 3}}]

This information can be plotted in a graph such as below, with the 
smoothed graph superimposed over the original values.

@centered{@image["data-smooth.png"]}

Design a program @pyin{data-smooth}---
@pydisp{data-smooth :: List<PHR> -> List<Number>}
---that consumes a list of PHRs and produces a 
list of the smoothed @pyin{heart-rate} values (not the entire records).

@subsection{Most Frequent Words}

Given a list of strings, design a program @pyin{frequent-words}---
@pydisp{frequent-words :: List<String> -> List<String>}
---that 
produces a list containing the three strings that occur most frequently
in the input list. The output list should contain the most frequent 
word first, followed by the second most frequent, then the third most 
frequent. Break ties by putting the shorter word (by length in 
characters) first. You may assume that the three most frequent words 
will have different length. You may also assume that the input will 
have at least three different words.

@subsection{Earthquake Monitoring}

Geologists want to monitor a local mountain for potential earthquake 
activity. They have installed a sensor to track seismic (vibration of 
the earth) activity. The sensor sends measurements one at a time over 
the network to a computer at a research lab. The sensor inserts markers
among the measurements to indicate the date of the measurement. The
sequence of values coming from the sensor looks as follows:

@pydisp{
20151004 200 150 175 20151005 0.002 0.03 20151007 ...
}

The 8-digit numbers are dates (in year-month-day format). Numbers between 0
and 500 are vibration frequencies (in Hz). This example shows readings
of 200, 150, and 175 on October 4th, 2015 and readings of 0.002 and 0.03 on
October 5th, 2015. There are no data for October 6th (sometimes there are 
problems with the network, so data go missing). Assume that the data 
are in order by dates (so a later date never appears before an earlier one
in the sequence).

Design a program @pyin{daily-max-for-month}---
@pydisp{daily-max-for-month :: List<Number> -> List<Report>}
---that consumes a list of sensor 
data and a month (represented by a number between @pyin{1} and @pyin{12}) and produces a list of 
reports indicating the highest frequency reading for each day in that month. 
Only include entries for dates that are part of the data provided (so don't 
report anything for October 6th in the example shown). Ignore data for months 
other than the given one. Each entry in your report should be an instance of 
the following datatype:

@pydisp{
  data Report:
    | max-hz(day :: Number, max-reading :: Number)
  end
}

@section{Submission Guidelines}

Please create eight files, two per problem. Name them @tt{bmi-1.arr},
@tt{bmi-2.arr}, @tt{datasmooth-1.arr}, @tt{datasmooth-2.arr},
@tt{frequentwords-1.arr}, @tt{frequentwords-2.arr},
@tt{earthquake-1.arr}, and @tt{earthquake-2.arr}. Create a zip file of
these and upload them to Captain Teach.

Remember to provide your ranking preferences, too!