Intro
* why matters
* apriori 

Method
* design diagram (excel
* put pilot inside results

Results
* don't conclude from plots
* histogram for normality
* QQPlot for residuals
* CI&Contrasts very important
* Through the pilots, a few post-hoc questions were formed
* Then do Scheffe, Tukey and shits

Latex:
$$
\begin{align}
\hat{L} &= \frac{1}{3} (\bar{y}_C + \bar{y}_{C++} + \bar{y}_{Java}) - \frac{1}{3}(\bar{y}_{Python} + \bar{y}_{Ruby} + \bar{y}_{R})\\
&= -0.9198 \\
\widehat{Var(\hat{L})} &= s^{2} \sum_{i=1}^{6} \frac{{h_i}^2}{n}\\
&= 0.0456\sum_{i=1}^{6}\frac{\frac{1}{9}}{7}\\
&= 0.004343\\
SE(\hat{L}) &= \sqrt{\hat{Var(\hat{L})}}\\
 &= \sqrt{0.004343}\\
 &= 0.0659\\

\end{align}
$$
$$
\hat{L}±SE(\hat{L})\times t_{0.025}^{30}
$$

$$
\begin{align*}

L &= \frac{1}{3} (\mu_C + \mu_{C++} + \mu_{Java}) - \frac{1}{3}(\mu_{Python} + \mu_{Ruby} + \mu_{R})\\
\intertext{We can estimate the values relevant to the contrast as follows:}\\
\hat{L} &= \frac{1}{3} (\bar{y}_C + \bar{y}_{C++} + \bar{y}_{Java}) - \frac{1}{3}(\bar{y}_{Python} + \bar{y}_{Ruby} + \bar{y}_{R})\\
&= -0.9198 \\
\widehat{Var(\hat{L})} &= s^{2} \sum_{i=1}^{6} \frac{{h_i}^2}{n}\\
&= 0.0456\sum_{i=1}^{6}\frac{\frac{1}{9}}{7}\\
&= 0.004343\\
SE(\hat{L}) &= \sqrt{\widehat{Var(\hat{L})}}\\
 &= \sqrt{0.004343}\\
 &= 0.0659\\
 
\intertext{We first note that $t_{0.025}^{30} = 2.0422$. We will then construct a 95\% confidence interval as follows:}\\
\hat{L} &\pm SE(\hat{L})\times t_{0.025}^{30}\\
-0.9198 &\pm 0.0659 \times 2.0422\\

\intertext{Thus, the 95\% Confidence interval is as follows: }\\

95\%C.I. &= (-1.0544 ,-0.7852)

\end{align*}
$$

$$
\begin{document}
 This is a list.
 \begin{itemize}
   \item First item.
  \begin{align*}
  f(x) &= \begin{cases} 0 & \text{now} \\ 1 & \text{then} \end{cases}
  \intertext{\item Second item.}
  g(x) &= \begin{cases} 0 & \text{here and there}  \\ 1 & \text{to and fro} \end{cases}
  \end{align*}
 \end{itemize}
 After the list.
\end{document}
$$