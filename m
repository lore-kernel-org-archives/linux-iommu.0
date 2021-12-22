Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF53CC433EF
	for <iommu@archiver.kernel.org>; Wed, 22 Dec 2021 11:57:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6AC3E40132;
	Wed, 22 Dec 2021 11:57:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IpJBimz5_RBc; Wed, 22 Dec 2021 11:57:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id ECD9F4017A;
	Wed, 22 Dec 2021 11:57:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C0A79C001E;
	Wed, 22 Dec 2021 11:57:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C2763C0012
 for <iommu@lists.linux-foundation.org>; Wed, 22 Dec 2021 11:57:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A1EED60F7E
 for <iommu@lists.linux-foundation.org>; Wed, 22 Dec 2021 11:57:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ALQb5hvm1-Xs for <iommu@lists.linux-foundation.org>;
 Wed, 22 Dec 2021 11:57:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id C98A360EB9
 for <iommu@lists.linux-foundation.org>; Wed, 22 Dec 2021 11:57:14 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D6E241FB;
 Wed, 22 Dec 2021 03:57:13 -0800 (PST)
Received: from [10.57.34.58] (unknown [10.57.34.58])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 98CCF3F5A1;
 Wed, 22 Dec 2021 03:57:10 -0800 (PST)
Message-ID: <2fbc6a98-6569-0a06-c901-9a37e40ccb7c@arm.com>
Date: Wed, 22 Dec 2021 11:57:05 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v3 4/5] iommu/arm-smmu-v3: Add host support for NVIDIA
 Grace CMDQ-V
Content-Language: en-GB
To: Nicolin Chen <nicolinc@nvidia.com>
References: <20211119071959.16706-1-nicolinc@nvidia.com>
 <20211119071959.16706-5-nicolinc@nvidia.com>
 <b05183b4-e08a-77ff-219c-009a4e42a32b@arm.com>
 <20211220192714.GA27303@Asurada-Nvidia>
 <7e68fa19-90b1-bbb5-9991-36b5d35278fa@arm.com>
 <20211221220037.GA6292@Asurada-Nvidia>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20211221220037.GA6292@Asurada-Nvidia>
Cc: jean-philippe@linaro.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org,
 thierry.reding@gmail.com, jgg@nvidia.com, will@kernel.org,
 linux-arm-kernel@lists.infradead.org
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

On 2021-12-21 22:00, Nicolin Chen wrote:
[...]
>>>> The challenge to make ECMDQ useful to Linux is how to make sure that all
>>>> the commands expected to be within scope of a future CMND_SYNC plus that
>>>> sync itself all get issued on the same queue, so I'd be mildly surprised
>>>> if you didn't have the same problem.
>>>
>>> PATCH-3 in this series actually helps align the command queues,
>>> between issued commands and SYNC, if bool sync == true. Yet, if
>>> doing something like issue->issue->issue_with_sync, it could be
>>> tricker.
>>
>> Indeed between the iommu_iotlb_gather mechanism and low-level command
>> batching things are already a lot more concentrated than they could be,
>> but arm_smmu_cmdq_batch_add() and its callers stand out as examples of
>> where we'd still be vulnerable to preemption. What I haven't even tried
>> to reason about yet is assumptions in the higher-level APIs, e.g. if
>> io-pgtable might chuck out a TLBI during an iommu_unmap() which we
>> implicitly expect a later iommu_iotlb_sync() to cover.
> 
> Though I might have oversimplified the situation here, I see
> the arm_smmu_cmdq_batch_add() calls are typically followed by
> arm_smmu_cmdq_batch_submit(). Could we just add a SYNC in the
> _batch_submit() to all the queues that it previously touched
> in the _batch_add()?

Keeping track of which queues a batch has touched is certainly possible, 
but it's yet more overhead to impose across the board when intra-batch 
preemption should (hopefully) be very rare in practice. I was thinking 
more along the lines of disabling preemption/migration for the lifetime 
of a batch, or more pragmatically just hoisting the queue selection all 
the way out to the scope of the batch itself (which also conveniently 
seems about the right shape for potentially forking off a whole other 
dedicated command submission flow from that point later).

We still can't mitigate inter-batch preemption, though, so we'll just 
have to audit everything very carefully to make sure we don't have (or 
inadvertently introduce in future) any places where that could be 
problematic. We really want to avoid over-syncing as that's liable to 
end up being just as bad for performance as the contention that we're 
nominally avoiding.

>> I've been thinking that in many ways per-domain queues make quite a bit
>> of sense and would be easier to manage than per-CPU ones - plus that's
>> pretty much the usage model once we get to VMs anyway - but that fails
>> to help the significant cases like networking and storage where many
>> CPUs are servicing a big monolithic device in a single domain :(
> 
> Yea, and it's hard to assume which client would use CMDQ more
> frequently, in order to balance or assign more queues to that
> client, which feels like a QoS conundrum.

Indeed, plus once we start assigning queues to VMs we're going to want 
to remove them from the general pool for host usage, so we definitely 
want to plan ahead here.

Cheers,
Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
