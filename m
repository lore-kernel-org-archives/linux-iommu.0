Return-Path: <SRS0=8RI2=CG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91AEEC433E6
	for <iommu@archiver.kernel.org>; Fri, 28 Aug 2020 07:41:31 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BCEA20776
	for <iommu@archiver.kernel.org>; Fri, 28 Aug 2020 07:41:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vBZFpUuk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BCEA20776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4058686D95;
	Fri, 28 Aug 2020 07:41:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SRnmkGLOliEG; Fri, 28 Aug 2020 07:41:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 029CF86C40;
	Fri, 28 Aug 2020 07:41:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DA6ECC07FF;
	Fri, 28 Aug 2020 07:41:28 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1A632C0051
 for <iommu@lists.linux-foundation.org>; Fri, 28 Aug 2020 07:41:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 0A054873DC
 for <iommu@lists.linux-foundation.org>; Fri, 28 Aug 2020 07:41:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id B1RND6G+KAlE for <iommu@lists.linux-foundation.org>;
 Fri, 28 Aug 2020 07:41:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com
 [209.85.208.67])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 63806869FE
 for <iommu@lists.linux-foundation.org>; Fri, 28 Aug 2020 07:41:26 +0000 (UTC)
Received: by mail-ed1-f67.google.com with SMTP id ba12so303684edb.2
 for <iommu@lists.linux-foundation.org>; Fri, 28 Aug 2020 00:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=+uNUuIw8xqYINfgXO90RD0KNG+EszSjrlv8fkPgSuXg=;
 b=vBZFpUukS9ej8HnUWumNJXv1d/NcuKguyLH6tyukCTnn66A5hCqhEj1HZBurteF5dk
 hJH6TGNAVoNfosSuexj0tZWBlKn/hMxw46/0zXuAQNzfjVEHGqgJATgmgB9+c/XX3uwi
 o+m+EU2SydcLI4q/zUeL7sUtjH8wo76OdiOA/pUNMW0qyoKBq358Nh+IhpEqZGvrd2Ep
 wfBV1V32klCYpLDoZ1oQMUanScI8OYEFolWEuK/PM3etCFvvtdaeus4LO1YzKNE/7t19
 QQGaC4tgb2buRHSCpSbCl0qyuGdSO3xsBumTg9VYmF6nFe1sVzaaocM27/FISfvSNzZf
 0VBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=+uNUuIw8xqYINfgXO90RD0KNG+EszSjrlv8fkPgSuXg=;
 b=cHlS9T9dgYsjnMinZgGxWjic9pof2SWhnXVPEXZIdV6Um23dWmHDFLUMDs5CqE5GcK
 7+1CbT3PlFFaV10iwasfpr6bMxS1a7dQF2rwWKvUK20QajzVZ1QweyD5kfyAXpdpBuHr
 WtIuzrjR00rt6Qcqf+8os57G+OAMEP8r66411AWZf4YuwdzdMT56YY+A6gDlkyNEnBY+
 Pvaqswpn7RRuN66oL2h3JH27rcKPic+uSuhVwYnj4JZVfWJRyJsCpusMB1xvYtLRfvWv
 KLImSsE/260gDGqQo97AdBrf5KfPaUCUIQd4eVagG69R0OlDh1AZ1sCMTTiKy4JQx8a1
 dtkQ==
X-Gm-Message-State: AOAM530BmdFiZX5k83H/3qKwI9sPdEOIj8fNhZQJzQCkC2R45aTVijY8
 /ggtsyz0S9G/D41A3KMpjA0qcQ==
X-Google-Smtp-Source: ABdhPJx3/yoe1p4Ow8ICSkcmM5UJFAesUhgiZyccb3voOeeF/U3xni4PTgZ0pOj/DnQUJ1c19Zertg==
X-Received: by 2002:aa7:d353:: with SMTP id m19mr514238edr.275.1598600484733; 
 Fri, 28 Aug 2020 00:41:24 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id b24sm300728edn.33.2020.08.28.00.41.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 00:41:23 -0700 (PDT)
Date: Fri, 28 Aug 2020 09:41:07 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Barry Song <song.bao.hua@hisilicon.com>
Subject: Re: [PATCH] iommu/arm-smmu-v3: add tracepoints for cmdq_issue_cmdlist
Message-ID: <20200828074107.GB3825485@myrica>
References: <20200827093351.15244-1-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200827093351.15244-1-song.bao.hua@hisilicon.com>
Cc: will@kernel.org, iommu@lists.linux-foundation.org, robin.murphy@arm.com,
 linuxarm@huawei.com, linux-arm-kernel@lists.infradead.org
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

Hi,

On Thu, Aug 27, 2020 at 09:33:51PM +1200, Barry Song wrote:
> cmdq_issue_cmdlist() is the hotspot that uses a lot of time. This patch
> adds tracepoints for it to help debug.
> 
> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> ---
>  * can furthermore develop an eBPF program to benchmark using this trace

Have you tried using kprobe and kretprobe instead of tracepoints?
Any noticeable performance drop?

Thanks,
Jean

> 
>   cmdlistlat.c:
> #include <uapi/linux/ptrace.h>
> 
> BPF_HASH(start, u32);
> BPF_HISTOGRAM(dist);
> 
> TRACEPOINT_PROBE(arm_smmu_v3, issue_cmdlist_entry)
> {
>         u32 pid;
>         u64 ts, *val;
> 
>         pid = bpf_get_current_pid_tgid();
>         ts = bpf_ktime_get_ns();
>         start.update(&pid, &ts);
>         return 0;
> }
> 
> TRACEPOINT_PROBE(arm_smmu_v3, issue_cmdlist_exit)
> {
>         u32 pid;
>         u64 *tsp, delta;
> 
>         pid = bpf_get_current_pid_tgid();
>         tsp = start.lookup(&pid);
> 
>         if (tsp != 0) {
>                 delta = bpf_ktime_get_ns() - *tsp;
>                 dist.increment(bpf_log2l(delta));
>                 start.delete(&pid);
>         }
> 
>         return 0;
> }
> 
>  cmdlistlat.py:
> #!/usr/bin/python3
> #
> from __future__ import print_function
> from bcc import BPF
> from ctypes import c_ushort, c_int, c_ulonglong
> from time import sleep
> from sys import argv
> 
> def usage():
>         print("USAGE: %s [interval [count]]" % argv[0])
>         exit()
> 
> # arguments
> interval = 5
> count = -1
> if len(argv) > 1:
>         try:
>                 interval = int(argv[1])
>                 if interval == 0:
>                         raise
>                 if len(argv) > 2:
>                         count = int(argv[2])
>         except: # also catches -h, --help
>                 usage()
> 
> # load BPF program
> b = BPF(src_file = "cmdlistlat.c")
> 
> # header
> print("Tracing... Hit Ctrl-C to end.")
> 
> # output
> loop = 0
> do_exit = 0
> while (1):
>         if count > 0:
>                 loop += 1
>                 if loop > count:
>                         exit()
>         try:
>                 sleep(interval)
>         except KeyboardInterrupt:
>                 pass; do_exit = 1
> 
>         print()
>         b["dist"].print_log2_hist("nsecs")
>         b["dist"].clear()
>         if do_exit:
>                 exit()
> 
> 
>  drivers/iommu/arm/arm-smmu-v3/Makefile        |  1 +
>  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-trace.h | 48 +++++++++++++++++++
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  8 ++++
>  3 files changed, 57 insertions(+)
>  create mode 100644 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-trace.h
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/Makefile b/drivers/iommu/arm/arm-smmu-v3/Makefile
> index 569e24e9f162..dba1087f91f3 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/Makefile
> +++ b/drivers/iommu/arm/arm-smmu-v3/Makefile
> @@ -1,2 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0
> +ccflags-y += -I$(src)                   # needed for trace events
>  obj-$(CONFIG_ARM_SMMU_V3) += arm-smmu-v3.o
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-trace.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-trace.h
> new file mode 100644
> index 000000000000..29ab96706124
> --- /dev/null
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-trace.h
> @@ -0,0 +1,48 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2020 Hisilicon Limited.
> + */
> +
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM arm_smmu_v3
> +
> +#if !defined(_ARM_SMMU_V3_TRACE_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _ARM_SMMU_V3_TRACE_H
> +
> +#include <linux/tracepoint.h>
> +
> +struct device;
> +
> +DECLARE_EVENT_CLASS(issue_cmdlist_class,
> +	TP_PROTO(struct device *dev, int n, bool sync),
> +	TP_ARGS(dev, n, sync),
> +
> +	TP_STRUCT__entry(
> +		__string(device, dev_name(dev))
> +		__field(int, n)
> +		__field(bool, sync)
> +	),
> +	TP_fast_assign(
> +		__assign_str(device, dev_name(dev));
> +		__entry->n = n;
> +		__entry->sync = sync;
> +	),
> +	TP_printk("%s cmd number=%d sync=%d",
> +			__get_str(device), __entry->n, __entry->sync)
> +);
> +
> +#define DEFINE_ISSUE_CMDLIST_EVENT(name)       \
> +DEFINE_EVENT(issue_cmdlist_class, name,        \
> +	TP_PROTO(struct device *dev, int n, bool sync), \
> +	TP_ARGS(dev, n, sync))
> +
> +DEFINE_ISSUE_CMDLIST_EVENT(issue_cmdlist_entry);
> +DEFINE_ISSUE_CMDLIST_EVENT(issue_cmdlist_exit);
> +
> +#endif /* _ARM_SMMU_V3_TRACE_H */
> +
> +#undef TRACE_INCLUDE_PATH
> +#undef TRACE_INCLUDE_FILE
> +#define TRACE_INCLUDE_PATH .
> +#define TRACE_INCLUDE_FILE arm-smmu-v3-trace
> +#include <trace/define_trace.h>
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 7332251dd8cd..e2d7d5f1d234 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -33,6 +33,8 @@
>  
>  #include <linux/amba/bus.h>
>  
> +#include "arm-smmu-v3-trace.h"
> +
>  /* MMIO registers */
>  #define ARM_SMMU_IDR0			0x0
>  #define IDR0_ST_LVL			GENMASK(28, 27)
> @@ -1389,6 +1391,8 @@ static int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
>  	}, head = llq;
>  	int ret = 0;
>  
> +	trace_issue_cmdlist_entry(smmu->dev, n, sync);
> +
>  	/* 1. Allocate some space in the queue */
>  	local_irq_save(flags);
>  	llq.val = READ_ONCE(cmdq->q.llq.val);
> @@ -1493,6 +1497,7 @@ static int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
>  	}
>  
>  	local_irq_restore(flags);
> +	trace_issue_cmdlist_exit(smmu->dev, n, sync);
>  	return ret;
>  }
>  
> @@ -4166,6 +4171,9 @@ static struct platform_driver arm_smmu_driver = {
>  };
>  module_platform_driver(arm_smmu_driver);
>  
> +#define CREATE_TRACE_POINTS
> +#include "arm-smmu-v3-trace.h"
> +
>  MODULE_DESCRIPTION("IOMMU API for ARM architected SMMUv3 implementations");
>  MODULE_AUTHOR("Will Deacon <will@kernel.org>");
>  MODULE_ALIAS("platform:arm-smmu-v3");
> -- 
> 2.27.0
> 
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
