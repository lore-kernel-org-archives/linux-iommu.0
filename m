Return-Path: <SRS0=8RI2=CG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 829D2C433E2
	for <iommu@archiver.kernel.org>; Fri, 28 Aug 2020 07:56:09 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 525D92078A
	for <iommu@archiver.kernel.org>; Fri, 28 Aug 2020 07:56:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 525D92078A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1DA0287D36;
	Fri, 28 Aug 2020 07:56:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6kt6ijS02v0P; Fri, 28 Aug 2020 07:56:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9D13C86A07;
	Fri, 28 Aug 2020 07:56:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 82520C07FF;
	Fri, 28 Aug 2020 07:56:06 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5223BC0051
 for <iommu@lists.linux-foundation.org>; Fri, 28 Aug 2020 07:56:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 3864385EEF
 for <iommu@lists.linux-foundation.org>; Fri, 28 Aug 2020 07:56:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ORoenEQ3KxpQ for <iommu@lists.linux-foundation.org>;
 Fri, 28 Aug 2020 07:56:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 4EF1685E98
 for <iommu@lists.linux-foundation.org>; Fri, 28 Aug 2020 07:56:03 +0000 (UTC)
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.55])
 by Forcepoint Email with ESMTP id A6DE51432BA0DFE4A7EE;
 Fri, 28 Aug 2020 15:55:55 +0800 (CST)
Received: from dggemi759-chm.china.huawei.com (10.1.198.145) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Fri, 28 Aug 2020 15:55:18 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggemi759-chm.china.huawei.com (10.1.198.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Fri, 28 Aug 2020 15:55:19 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.1913.007;
 Fri, 28 Aug 2020 15:55:18 +0800
From: "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: RE: [PATCH] iommu/arm-smmu-v3: add tracepoints for cmdq_issue_cmdlist
Thread-Topic: [PATCH] iommu/arm-smmu-v3: add tracepoints for cmdq_issue_cmdlist
Thread-Index: AQHWfFWUhbwMm9rWP0CSbrIWukW28qlMnmaAgACI9/A=
Date: Fri, 28 Aug 2020 07:55:18 +0000
Message-ID: <f8f00caacc774c79b7c0c7a39abf795f@hisilicon.com>
References: <20200827093351.15244-1-song.bao.hua@hisilicon.com>
 <20200828074107.GB3825485@myrica>
In-Reply-To: <20200828074107.GB3825485@myrica>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.200.243]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Cc: "will@kernel.org" <will@kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>, Linuxarm <linuxarm@huawei.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>



> -----Original Message-----
> From: Jean-Philippe Brucker [mailto:jean-philippe@linaro.org]
> Sent: Friday, August 28, 2020 7:41 PM
> To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>
> Cc: iommu@lists.linux-foundation.org; linux-arm-kernel@lists.infradead.org;
> robin.murphy@arm.com; will@kernel.org; Linuxarm <linuxarm@huawei.com>
> Subject: Re: [PATCH] iommu/arm-smmu-v3: add tracepoints for
> cmdq_issue_cmdlist
> 
> Hi,
> 
> On Thu, Aug 27, 2020 at 09:33:51PM +1200, Barry Song wrote:
> > cmdq_issue_cmdlist() is the hotspot that uses a lot of time. This
> > patch adds tracepoints for it to help debug.
> >
> > Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> > ---
> >  * can furthermore develop an eBPF program to benchmark using this
> > trace
> 
> Have you tried using kprobe and kretprobe instead of tracepoints?
> Any noticeable performance drop?

Yes. Pls read this email.
kprobe overhead and OPTPROBES implementation on ARM64
https://www.spinics.net/lists/arm-kernel/msg828788.html

> 
> Thanks,
> Jean
> 
> >
> >   cmdlistlat.c:
> > #include <uapi/linux/ptrace.h>
> >
> > BPF_HASH(start, u32);
> > BPF_HISTOGRAM(dist);
> >
> > TRACEPOINT_PROBE(arm_smmu_v3, issue_cmdlist_entry) {
> >         u32 pid;
> >         u64 ts, *val;
> >
> >         pid = bpf_get_current_pid_tgid();
> >         ts = bpf_ktime_get_ns();
> >         start.update(&pid, &ts);
> >         return 0;
> > }
> >
> > TRACEPOINT_PROBE(arm_smmu_v3, issue_cmdlist_exit) {
> >         u32 pid;
> >         u64 *tsp, delta;
> >
> >         pid = bpf_get_current_pid_tgid();
> >         tsp = start.lookup(&pid);
> >
> >         if (tsp != 0) {
> >                 delta = bpf_ktime_get_ns() - *tsp;
> >                 dist.increment(bpf_log2l(delta));
> >                 start.delete(&pid);
> >         }
> >
> >         return 0;
> > }
> >
> >  cmdlistlat.py:
> > #!/usr/bin/python3
> > #
> > from __future__ import print_function
> > from bcc import BPF
> > from ctypes import c_ushort, c_int, c_ulonglong from time import sleep
> > from sys import argv
> >
> > def usage():
> >         print("USAGE: %s [interval [count]]" % argv[0])
> >         exit()
> >
> > # arguments
> > interval = 5
> > count = -1
> > if len(argv) > 1:
> >         try:
> >                 interval = int(argv[1])
> >                 if interval == 0:
> >                         raise
> >                 if len(argv) > 2:
> >                         count = int(argv[2])
> >         except: # also catches -h, --help
> >                 usage()
> >
> > # load BPF program
> > b = BPF(src_file = "cmdlistlat.c")
> >
> > # header
> > print("Tracing... Hit Ctrl-C to end.")
> >
> > # output
> > loop = 0
> > do_exit = 0
> > while (1):
> >         if count > 0:
> >                 loop += 1
> >                 if loop > count:
> >                         exit()
> >         try:
> >                 sleep(interval)
> >         except KeyboardInterrupt:
> >                 pass; do_exit = 1
> >
> >         print()
> >         b["dist"].print_log2_hist("nsecs")
> >         b["dist"].clear()
> >         if do_exit:
> >                 exit()
> >
> >
> >  drivers/iommu/arm/arm-smmu-v3/Makefile        |  1 +
> >  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-trace.h | 48
> +++++++++++++++++++
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  8 ++++
> >  3 files changed, 57 insertions(+)
> >  create mode 100644
> drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-trace.h
> >
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/Makefile
> > b/drivers/iommu/arm/arm-smmu-v3/Makefile
> > index 569e24e9f162..dba1087f91f3 100644
> > --- a/drivers/iommu/arm/arm-smmu-v3/Makefile
> > +++ b/drivers/iommu/arm/arm-smmu-v3/Makefile
> > @@ -1,2 +1,3 @@
> >  # SPDX-License-Identifier: GPL-2.0
> > +ccflags-y += -I$(src)                   # needed for trace events
> >  obj-$(CONFIG_ARM_SMMU_V3) += arm-smmu-v3.o diff --git
> > a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-trace.h
> > b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-trace.h
> > new file mode 100644
> > index 000000000000..29ab96706124
> > --- /dev/null
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-trace.h
> > @@ -0,0 +1,48 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/*
> > + * Copyright (C) 2020 Hisilicon Limited.
> > + */
> > +
> > +#undef TRACE_SYSTEM
> > +#define TRACE_SYSTEM arm_smmu_v3
> > +
> > +#if !defined(_ARM_SMMU_V3_TRACE_H) ||
> > +defined(TRACE_HEADER_MULTI_READ) #define _ARM_SMMU_V3_TRACE_H
> > +
> > +#include <linux/tracepoint.h>
> > +
> > +struct device;
> > +
> > +DECLARE_EVENT_CLASS(issue_cmdlist_class,
> > +	TP_PROTO(struct device *dev, int n, bool sync),
> > +	TP_ARGS(dev, n, sync),
> > +
> > +	TP_STRUCT__entry(
> > +		__string(device, dev_name(dev))
> > +		__field(int, n)
> > +		__field(bool, sync)
> > +	),
> > +	TP_fast_assign(
> > +		__assign_str(device, dev_name(dev));
> > +		__entry->n = n;
> > +		__entry->sync = sync;
> > +	),
> > +	TP_printk("%s cmd number=%d sync=%d",
> > +			__get_str(device), __entry->n, __entry->sync) );
> > +
> > +#define DEFINE_ISSUE_CMDLIST_EVENT(name)       \
> > +DEFINE_EVENT(issue_cmdlist_class, name,        \
> > +	TP_PROTO(struct device *dev, int n, bool sync), \
> > +	TP_ARGS(dev, n, sync))
> > +
> > +DEFINE_ISSUE_CMDLIST_EVENT(issue_cmdlist_entry);
> > +DEFINE_ISSUE_CMDLIST_EVENT(issue_cmdlist_exit);
> > +
> > +#endif /* _ARM_SMMU_V3_TRACE_H */
> > +
> > +#undef TRACE_INCLUDE_PATH
> > +#undef TRACE_INCLUDE_FILE
> > +#define TRACE_INCLUDE_PATH .
> > +#define TRACE_INCLUDE_FILE arm-smmu-v3-trace #include
> > +<trace/define_trace.h>
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > index 7332251dd8cd..e2d7d5f1d234 100644
> > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > @@ -33,6 +33,8 @@
> >
> >  #include <linux/amba/bus.h>
> >
> > +#include "arm-smmu-v3-trace.h"
> > +
> >  /* MMIO registers */
> >  #define ARM_SMMU_IDR0			0x0
> >  #define IDR0_ST_LVL			GENMASK(28, 27)
> > @@ -1389,6 +1391,8 @@ static int arm_smmu_cmdq_issue_cmdlist(struct
> arm_smmu_device *smmu,
> >  	}, head = llq;
> >  	int ret = 0;
> >
> > +	trace_issue_cmdlist_entry(smmu->dev, n, sync);
> > +
> >  	/* 1. Allocate some space in the queue */
> >  	local_irq_save(flags);
> >  	llq.val = READ_ONCE(cmdq->q.llq.val); @@ -1493,6 +1497,7 @@ static
> > int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
> >  	}
> >
> >  	local_irq_restore(flags);
> > +	trace_issue_cmdlist_exit(smmu->dev, n, sync);
> >  	return ret;
> >  }
> >
> > @@ -4166,6 +4171,9 @@ static struct platform_driver arm_smmu_driver =
> > {  };  module_platform_driver(arm_smmu_driver);
> >
> > +#define CREATE_TRACE_POINTS
> > +#include "arm-smmu-v3-trace.h"
> > +
> >  MODULE_DESCRIPTION("IOMMU API for ARM architected SMMUv3
> > implementations");  MODULE_AUTHOR("Will Deacon <will@kernel.org>");
> > MODULE_ALIAS("platform:arm-smmu-v3");
> > --
> > 2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
