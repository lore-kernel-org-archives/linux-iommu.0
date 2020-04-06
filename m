Return-Path: <SRS0=BbwH=5W=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB6AC2BA19
	for <iommu@archiver.kernel.org>; Mon,  6 Apr 2020 15:12:15 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E014523BCD
	for <iommu@archiver.kernel.org>; Mon,  6 Apr 2020 15:12:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E014523BCD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id A3AF288547;
	Mon,  6 Apr 2020 15:12:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4-RaN-AggPAs; Mon,  6 Apr 2020 15:12:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id B978288543;
	Mon,  6 Apr 2020 15:12:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A7268C1AE2;
	Mon,  6 Apr 2020 15:12:12 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1D28AC0177
 for <iommu@lists.linux-foundation.org>; Mon,  6 Apr 2020 15:12:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 0976C88541
 for <iommu@lists.linux-foundation.org>; Mon,  6 Apr 2020 15:12:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mgAT6hk-VdJe for <iommu@lists.linux-foundation.org>;
 Mon,  6 Apr 2020 15:12:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (lhrrgout.huawei.com [185.176.76.210])
 by hemlock.osuosl.org (Postfix) with ESMTPS id E0E418852A
 for <iommu@lists.linux-foundation.org>; Mon,  6 Apr 2020 15:12:09 +0000 (UTC)
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.107])
 by Forcepoint Email with ESMTP id 417AF622916C4E4CAAC9;
 Mon,  6 Apr 2020 16:12:06 +0100 (IST)
Received: from [127.0.0.1] (10.47.10.197) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 6 Apr 2020
 16:12:05 +0100
From: John Garry <john.garry@huawei.com>
Subject: Re: arm-smmu-v3 high cpu usage for NVMe
To: Will Deacon <will@kernel.org>
References: <20190821151749.23743-1-will@kernel.org>
 <b2a6e26d-6d0d-7f0d-f222-589812f701d2@huawei.com>
 <20200318205313.GB8094@willie-the-truck>
 <482c00d5-8e6d-1484-820e-1e89851ad5aa@huawei.com>
Message-ID: <30664ea8-548d-b0a4-81bc-e7f311f84b5f@huawei.com>
Date: Mon, 6 Apr 2020 16:11:43 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <482c00d5-8e6d-1484-820e-1e89851ad5aa@huawei.com>
Content-Language: en-US
X-Originating-IP: [10.47.10.197]
X-ClientProxiedBy: lhreml710-chm.china.huawei.com (10.201.108.61) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Marc Zyngier <maz@kernel.org>, Ming Lei <ming.lei@redhat.com>,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>
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

On 02/04/2020 13:10, John Garry wrote:
> On 18/03/2020 20:53, Will Deacon wrote:
>>> As for arm_smmu_cmdq_issue_cmdlist(), I do note that during the 
>>> testing our
>>> batch size is 1, so we're not seeing the real benefit of the batching. I
>>> can't help but think that we could improve this code to try to 
>>> combine CMD
>>> SYNCs for small batches.
>>>
>>> Anyway, let me know your thoughts or any questions. I'll have a look 
>>> if a
>>> get a chance for other possible bottlenecks.
>> Did you ever get any more information on this? I don't have any SMMUv3
>> hardware any more, so I can't really dig into this myself.
>>
> 

Hi Will,

JFYI, I added some debug in arm_smmu_cmdq_issue_cmdlist() to get some 
idea of what is going on. Perf annotate did not tell much.

I tested NVMe performance with and without Marc's patchset to spread 
LPIs for managed interrupts.

Average duration of arm_smmu_cmdq_issue_cmdlist() mainline [all results 
are approximations]:
owner: 6ms
non-owner: 4ms

mainline + LPI spreading patchset:
owner: 25ms
non-owner: 22ms

For this, a list would be a itlb+cmd_sync.

Please note that the LPI spreading patchset is still giving circa 25% 
NVMe throughput increase. What happens there would be that we get many 
more cpus involved, which creates more inter-cpu contention. But the 
performance increase comes from just alleviating pressure on those 
overloaded cpus.

I also notice that with the LPI spreading patchset, on average a cpu is 
an "owner" in arm_smmu_cmdq_issue_cmdlist() 1 in 8, as opposed to 1 in 3 
for mainline. This means that we're just creating longer chains of lists 
to be published.

But I found that for a non-owner, average msi cmd_sync polling time is 
12ms with the LPI spreading patchset. As such, it seems to be really 
taking approx (12*2/8-1=) ~3ms to consume a single list. This seems 
consistent with my finding that an owner polls consumption for 3ms also. 
Without the LPI speading patchset, polling time is approx 2 and 3ms for 
both owner and non-owner, respectively.

As an experiment, I did try to hack the code to use a spinlock again for 
protecting the command queue, instead of current solution - and always 
saw a performance drop there. To be expected. But maybe we can try to 
not use a spinlock, but still serialise production+consumption to 
alleviate the long polling periods.

Let me know your thoughts.

Cheers,
John

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
