Return-Path: <SRS0=8RI2=CG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B7EC433E6
	for <iommu@archiver.kernel.org>; Fri, 28 Aug 2020 11:18:32 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 239BC207DF
	for <iommu@archiver.kernel.org>; Fri, 28 Aug 2020 11:18:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 239BC207DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E8823852F8;
	Fri, 28 Aug 2020 11:18:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uBcPX8leJYTL; Fri, 28 Aug 2020 11:18:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 11064852D5;
	Fri, 28 Aug 2020 11:18:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EAA19C016F;
	Fri, 28 Aug 2020 11:18:28 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1FD63C0051
 for <iommu@lists.linux-foundation.org>; Fri, 28 Aug 2020 11:18:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 11D35885D5
 for <iommu@lists.linux-foundation.org>; Fri, 28 Aug 2020 11:18:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tXqHG4AIX7XK for <iommu@lists.linux-foundation.org>;
 Fri, 28 Aug 2020 11:18:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by hemlock.osuosl.org (Postfix) with ESMTP id 7CA4E885D2
 for <iommu@lists.linux-foundation.org>; Fri, 28 Aug 2020 11:18:25 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6524631B;
 Fri, 28 Aug 2020 04:18:24 -0700 (PDT)
Received: from [10.57.40.122] (unknown [10.57.40.122])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 48BC73F66B;
 Fri, 28 Aug 2020 04:18:23 -0700 (PDT)
Subject: Re: [PATCH] iommu/arm-smmu-v3: add tracepoints for cmdq_issue_cmdlist
To: "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
 Will Deacon <will@kernel.org>
References: <20200827093351.15244-1-song.bao.hua@hisilicon.com>
 <20200828102927.GA30391@willie-the-truck>
 <b7e9394523d548af8a3afa40746cd568@hisilicon.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <9acf1acf-19fb-26db-e908-eb4d4c666bae@arm.com>
Date: Fri, 28 Aug 2020 12:18:17 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <b7e9394523d548af8a3afa40746cd568@hisilicon.com>
Content-Language: en-GB
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2020-08-28 12:02, Song Bao Hua (Barry Song) wrote:
> 
> 
>> -----Original Message-----
>> From: Will Deacon [mailto:will@kernel.org]
>> Sent: Friday, August 28, 2020 10:29 PM
>> To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>
>> Cc: iommu@lists.linux-foundation.org; linux-arm-kernel@lists.infradead.org;
>> robin.murphy@arm.com; joro@8bytes.org; Linuxarm <linuxarm@huawei.com>
>> Subject: Re: [PATCH] iommu/arm-smmu-v3: add tracepoints for
>> cmdq_issue_cmdlist
>>
>> On Thu, Aug 27, 2020 at 09:33:51PM +1200, Barry Song wrote:
>>> cmdq_issue_cmdlist() is the hotspot that uses a lot of time. This patch
>>> adds tracepoints for it to help debug.
>>>
>>> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
>>> ---
>>>   * can furthermore develop an eBPF program to benchmark using this trace
>>
>> Hmm, don't these things have a history of becoming ABI? If so, I don't
>> really want them in the driver at all, sorry. Do other drivers overcome
>> this somehow?
> 
> This kind of tracepoints mainly works as a low-overhead probe point for debug purpose. I don't think any
> application would depend on it. It is for debugging. And there are lots of tracepoints in other drivers
> even in iommu driver core and intel_iommu driver :-)
> 
> developers use it in one of the below ways:
> 
> 1. get trace print from the ring buffer by reading debugfs
> root@ubuntu:/sys/kernel/debug/tracing/events/arm_smmu_v3# echo 1 > enable
> # cat /sys/kernel/debug/tracing/trace_pipe
> <idle>-0     [058] ..s1 125444.768083: issue_cmdlist_exit: arm-smmu-v3.2.auto cmd number=1 sync=1
>            <idle>-0     [058] ..s1 125444.768084: issue_cmdlist_entry: arm-smmu-v3.2.auto cmd number=1 sync=1
>            <idle>-0     [058] ..s1 125444.768085: issue_cmdlist_exit: arm-smmu-v3.2.auto cmd number=1 sync=1
>            <idle>-0     [058] ..s1 125444.768165: issue_cmdlist_entry: arm-smmu-v3.2.auto cmd number=1 sync=1
>            <idle>-0     [058] ..s1 125444.768168: issue_cmdlist_exit: arm-smmu-v3.2.auto cmd number=1 sync=1
>            <idle>-0     [058] ..s1 125444.768169: issue_cmdlist_entry: arm-smmu-v3.2.auto cmd number=1 sync=1
>            <idle>-0     [058] ..s1 125444.768171: issue_cmdlist_exit: arm-smmu-v3.2.auto cmd number=1 sync=1
>            <idle>-0     [058] ..s1 125444.768259: issue_cmdlist_entry: arm-smmu-v3.2.auto cmd number=1 sync=1
>            ...
> 
> This can replace printk with much much lower overhead.
> 
> 2. add a hook function in tracepoint to do some latency measure and time statistics just like the eBPF example
> I gave after the commit log.
> 
> Using it, I can get the histogram of the execution time of cmdq_issue_cmdlist():
>     nsecs               : count     distribution
>           0 -> 1          : 0        |                                        |
>           2 -> 3          : 0        |                                        |
>           4 -> 7          : 0        |                                        |
>           8 -> 15         : 0        |                                        |
>          16 -> 31         : 0        |                                        |
>          32 -> 63         : 0        |                                        |
>          64 -> 127        : 0        |                                        |
>         128 -> 255        : 0        |                                        |
>         256 -> 511        : 0        |                                        |
>         512 -> 1023       : 58       |                                        |
>        1024 -> 2047       : 22763    |****************************************|
>        2048 -> 4095       : 13238    |***********************                 |
> 
> I feel it is very common to do this kind of things for analyzing the performance issue. For example, to easy the analysis
> of softirq latency, softirq.c has the below code:
> 
> asmlinkage __visible void __softirq_entry __do_softirq(void)
> {
> 	...
> 		trace_softirq_entry(vec_nr);
> 		h->action(h);
> 		trace_softirq_exit(vec_nr);
> 	...
> }

If you only want to measure entry and exit of one specific function, 
though, can't the function graph tracer already do that?

Otherwise, pursuing optprobes sounds like a worthwhile thing to do since 
that should benefit everyone, rather than just the 6 people on the 
planet who might care about arm_smmu_issue_cmdlist(). As long as it 
doesn't involve whole new ISA extensions like the RISC-V proposal ;)

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
