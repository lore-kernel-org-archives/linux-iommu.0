Return-Path: <SRS0=8RI2=CG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A561C433E2
	for <iommu@archiver.kernel.org>; Fri, 28 Aug 2020 11:58:46 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FA812078A
	for <iommu@archiver.kernel.org>; Fri, 28 Aug 2020 11:58:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FA812078A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 365C420377;
	Fri, 28 Aug 2020 11:58:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BxBX-T1XHv6G; Fri, 28 Aug 2020 11:58:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 4801C2279B;
	Fri, 28 Aug 2020 11:58:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1DB9AC016F;
	Fri, 28 Aug 2020 11:58:44 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8F161C0051
 for <iommu@lists.linux-foundation.org>; Fri, 28 Aug 2020 11:58:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 778452279B
 for <iommu@lists.linux-foundation.org>; Fri, 28 Aug 2020 11:58:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Q1DPqB8WNK3h for <iommu@lists.linux-foundation.org>;
 Fri, 28 Aug 2020 11:58:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (szxga08-in.huawei.com [45.249.212.255])
 by silver.osuosl.org (Postfix) with ESMTPS id 0439620439
 for <iommu@lists.linux-foundation.org>; Fri, 28 Aug 2020 11:58:38 +0000 (UTC)
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.55])
 by Forcepoint Email with ESMTP id 6D71EEE2B8A16D8D8A05;
 Fri, 28 Aug 2020 19:58:35 +0800 (CST)
Received: from dggemi709-chm.china.huawei.com (10.3.20.108) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Fri, 28 Aug 2020 19:58:35 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggemi709-chm.china.huawei.com (10.3.20.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Fri, 28 Aug 2020 19:58:34 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.1913.007;
 Fri, 28 Aug 2020 19:58:35 +0800
From: "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>
Subject: RE: [PATCH] iommu/arm-smmu-v3: add tracepoints for cmdq_issue_cmdlist
Thread-Topic: [PATCH] iommu/arm-smmu-v3: add tracepoints for cmdq_issue_cmdlist
Thread-Index: AQHWfFWUhbwMm9rWP0CSbrIWukW28qlMzW6AgACF0hD//4fTgIAAiAqQ
Date: Fri, 28 Aug 2020 11:58:35 +0000
Message-ID: <ef589be2578e45fea72e59811485c0aa@hisilicon.com>
References: <20200827093351.15244-1-song.bao.hua@hisilicon.com>
 <20200828102927.GA30391@willie-the-truck>
 <b7e9394523d548af8a3afa40746cd568@hisilicon.com>
 <9acf1acf-19fb-26db-e908-eb4d4c666bae@arm.com>
In-Reply-To: <9acf1acf-19fb-26db-e908-eb4d4c666bae@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.200.243]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, Linuxarm <linuxarm@huawei.com>
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
> From: Robin Murphy [mailto:robin.murphy@arm.com]
> Sent: Friday, August 28, 2020 11:18 PM
> To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>; Will Deacon
> <will@kernel.org>
> Cc: iommu@lists.linux-foundation.org; linux-arm-kernel@lists.infradead.org;
> joro@8bytes.org; Linuxarm <linuxarm@huawei.com>
> Subject: Re: [PATCH] iommu/arm-smmu-v3: add tracepoints for
> cmdq_issue_cmdlist
> 
> On 2020-08-28 12:02, Song Bao Hua (Barry Song) wrote:
> >
> >
> >> -----Original Message-----
> >> From: Will Deacon [mailto:will@kernel.org]
> >> Sent: Friday, August 28, 2020 10:29 PM
> >> To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>
> >> Cc: iommu@lists.linux-foundation.org;
> linux-arm-kernel@lists.infradead.org;
> >> robin.murphy@arm.com; joro@8bytes.org; Linuxarm
> <linuxarm@huawei.com>
> >> Subject: Re: [PATCH] iommu/arm-smmu-v3: add tracepoints for
> >> cmdq_issue_cmdlist
> >>
> >> On Thu, Aug 27, 2020 at 09:33:51PM +1200, Barry Song wrote:
> >>> cmdq_issue_cmdlist() is the hotspot that uses a lot of time. This patch
> >>> adds tracepoints for it to help debug.
> >>>
> >>> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> >>> ---
> >>>   * can furthermore develop an eBPF program to benchmark using this
> trace
> >>
> >> Hmm, don't these things have a history of becoming ABI? If so, I don't
> >> really want them in the driver at all, sorry. Do other drivers overcome
> >> this somehow?
> >
> > This kind of tracepoints mainly works as a low-overhead probe point for
> debug purpose. I don't think any
> > application would depend on it. It is for debugging. And there are lots of
> tracepoints in other drivers
> > even in iommu driver core and intel_iommu driver :-)
> >
> > developers use it in one of the below ways:
> >
> > 1. get trace print from the ring buffer by reading debugfs
> > root@ubuntu:/sys/kernel/debug/tracing/events/arm_smmu_v3# echo 1 >
> enable
> > # cat /sys/kernel/debug/tracing/trace_pipe
> > <idle>-0     [058] ..s1 125444.768083: issue_cmdlist_exit:
> arm-smmu-v3.2.auto cmd number=1 sync=1
> >            <idle>-0     [058] ..s1 125444.768084: issue_cmdlist_entry:
> arm-smmu-v3.2.auto cmd number=1 sync=1
> >            <idle>-0     [058] ..s1 125444.768085: issue_cmdlist_exit:
> arm-smmu-v3.2.auto cmd number=1 sync=1
> >            <idle>-0     [058] ..s1 125444.768165: issue_cmdlist_entry:
> arm-smmu-v3.2.auto cmd number=1 sync=1
> >            <idle>-0     [058] ..s1 125444.768168: issue_cmdlist_exit:
> arm-smmu-v3.2.auto cmd number=1 sync=1
> >            <idle>-0     [058] ..s1 125444.768169: issue_cmdlist_entry:
> arm-smmu-v3.2.auto cmd number=1 sync=1
> >            <idle>-0     [058] ..s1 125444.768171: issue_cmdlist_exit:
> arm-smmu-v3.2.auto cmd number=1 sync=1
> >            <idle>-0     [058] ..s1 125444.768259: issue_cmdlist_entry:
> arm-smmu-v3.2.auto cmd number=1 sync=1
> >            ...
> >
> > This can replace printk with much much lower overhead.
> >
> > 2. add a hook function in tracepoint to do some latency measure and time
> statistics just like the eBPF example
> > I gave after the commit log.
> >
> > Using it, I can get the histogram of the execution time of
> cmdq_issue_cmdlist():
> >     nsecs               : count     distribution
> >           0 -> 1          : 0        |
> |
> >           2 -> 3          : 0        |
> |
> >           4 -> 7          : 0        |
> |
> >           8 -> 15         : 0        |
> |
> >          16 -> 31         : 0        |
> |
> >          32 -> 63         : 0        |
> |
> >          64 -> 127        : 0        |
> |
> >         128 -> 255        : 0        |
> |
> >         256 -> 511        : 0        |
> |
> >         512 -> 1023       : 58       |
> |
> >        1024 -> 2047       : 22763
> |****************************************|
> >        2048 -> 4095       : 13238    |***********************
> |
> >
> > I feel it is very common to do this kind of things for analyzing the
> performance issue. For example, to easy the analysis
> > of softirq latency, softirq.c has the below code:
> >
> > asmlinkage __visible void __softirq_entry __do_softirq(void)
> > {
> > 	...
> > 		trace_softirq_entry(vec_nr);
> > 		h->action(h);
> > 		trace_softirq_exit(vec_nr);
> > 	...
> > }
> 
> If you only want to measure entry and exit of one specific function,
> though, can't the function graph tracer already do that?

Function graph is able to do this specific thing while it is not good to support developers
to use BPF code to do various analysis in various fancy ways. Another disadvanrage of
functiongraph is that it will add the overhead of ftrace of child functions to the parent
function:
a()
{
	b();
	c();
}
b()
{
	d();
}
We have some overhead of ftrace for b(), c(), d(), and all overhead will be added into a(). That can makes
the execution time of a() much longer.

On the other hand, in my original plan, the tracepoints in smmu-v3 driver would not be only in the entry and
exit of this function, it would be in some other places like
before and after the step 1, lock contention
before and after the step 5, wait for the completion of cmd_sync

and some other critical code path which can help analyze the latency of arm-smmu-v3.

I was using the two tracepoints to start the discussion. It happens these two can somehow be implemented
by function graph.
> 
> Otherwise, pursuing optprobes sounds like a worthwhile thing to do since
> that should benefit everyone, rather than just the 6 people on the
> planet who might care about arm_smmu_issue_cmdlist(). As long as it
> doesn't involve whole new ISA extensions like the RISC-V proposal ;)
>

It is a bit sad that only 6 people are caring about the function. Don't know where other
ARM64 server guys go :-)

It seems optprobes/kprobe and tracepoints will work side by side. They are not trying
to replace each other since they both have their own advantages and disadvantages.

If both you and Jean think optprobes is a good direction to go for arm64, I am happy to
start some feasibility study.

> Robin.

Thanks
Barry
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
