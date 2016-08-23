近期工作中遇到多起上游系统数据异常影响到下游的情况。比如说这些：

问题：

1. 上游交易系统/分析系统出现问题，数据异常。影响所有下游系统数据的准确性。
2. 下游系统管理员在不明所以的情况下，问题率先被用户发现，然后才反馈给系统管理员。
3. 下游系统管理人员没有收到上游系统异常的预警，在接到反馈后，只能按常规流程进行各种问题分析核查，最后发现问题不是出在自己的系统上，而是上游系统的问题。但是时间也花了,吃力不讨好。
4. 定位问题后，上游也同样需要花大量的时间分析解决问题。再一次消耗上游人力资源。下游干等，同样也是浪费。同时问题的出现容易破坏心情，破坏团队稳定。
5. 数据重处理涉及各种数据重跑，需要找上下游协调，下游推动上游还不好推动。
6. 上下游花了不少力气，终于把问题处理完了，而用户也等到菜都凉了。
6. 用户并不关心问题的根源，纵然你给他解释是那那那的问题，时间长了，次数多了，他也只会认为是(下游)系统出了问题，下游系统人员只能啃这个死猫。
7. 久而久之，影响用户体验;影响上下游系统管理员的心情；影响团队稳定、信誉。

分析：
归根结底，还是系统监控机制、消息机制不够完善。而消息机制的建立，有赖于各种数据监控。
上游的问题，越早解决越有利。问题出现了，早点解决，那么只是上游的事情。解决晚了，就变成所有人的事情。

而发现、捕捉问题，则需要建立良好的监控机制。

以前做电信行业BI时，会对重要指标做波动性和一致性监控。而目前所服务的银行系统，只对系统层面的指标做监控，比如内存、cpu等，并无对数据指标如kpi相关指标做监控。结果就是出现了问题没有第一时间发现，而是由用户反馈。试想如果一个手机App动不动就出现各种问题，还会有人用吗？

从事电信行业数据分析时，有两个重要的数据质量方面的校验,波动性校验和一致性校验：
有一些指标，来自不同的源，或者经过不同的处理过程，但是结果要求严格一致的，就做一致性校验。
有一些指标，每天，每周，每月，每年都会有不同的程度的变化，但应该有一个合理范围，一旦超出这个范围，就会被当作异常捕捉,并触发告警，通知系统负责人需要及时核实数据异常的原因，然后采取相应的行动。

所谓建立上下游的消息机制，就是当上游出了问题，在发现问题之后，能够尽早停止下游作业，把影响范围缩小。在问题解决之后，能够触发下游自动重跑受影响的作业。降低沟通成本。

同时作业依赖关系一定要准确，作业调度尽可能自动化，减少手工维护的情况，减少例外的情况。

另外，通常情况下，波动性校验是需要人工参与分析判断数据是否正常的。以前做一级经营分析系统（一经）的时候，由于阈值设置得太小，常常导致数据频繁告警。每天都要被三更半夜吵醒的节奏。所以这就涉及告警分级的问题，把告警分成一级二级三级...比如 波动 5% 为 三级，10%为二级，20%为三级... 等等。不同级别的告警采取不同的响应策略。

总之，系统监控机制能够为解决系统问题争取时间，最小化问题的影响面。而上下游的消息处理机制能够降低沟通成本，同时一个好的作业调度系统能够降低运维工作量，提高效率。如果大家工作起来都很顺畅，没有太多压力和阻力，这样的团队才稳定，维护的系统才稳定。
