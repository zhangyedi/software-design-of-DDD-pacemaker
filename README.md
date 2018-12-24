# software-design-of-DDD-pacemaker

In this project, I designed a safe and efficacy DDD pacemaker with UPPAAL and Matlab following 4 steps:
- 1: Create some simple heart models to model the coresponding heart condition, including NSR(Normal Sinus Rhythm), Sinus Bradycadia, Sinus Tachycardia and AV Block.
- 2: Design a DDD pacemaker in UPPAAL, which needs satisfying some basic requirement, like no deadlock, keep the heart beat in the range of 60~150bpm.
- 3: Translate UPPAAL model into Matlab Code, and maintain traceability between physiological requirements to code implementation.
- 4: Design testing cases to make sure that the verified UPPPAAL model is correctly transltated into code implementation.
