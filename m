Return-Path: <SRS0=Y/Kh=OV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFFA8C433F5
	for <iommu@archiver.kernel.org>; Fri,  1 Oct 2021 15:19:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8378761A6F
	for <iommu@archiver.kernel.org>; Fri,  1 Oct 2021 15:19:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8378761A6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4E7BA401F3;
	Fri,  1 Oct 2021 15:19:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dcVVY6ib1ZI8; Fri,  1 Oct 2021 15:19:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id ACE8F402C8;
	Fri,  1 Oct 2021 15:19:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 89D5CC000F;
	Fri,  1 Oct 2021 15:19:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6D066C000D
 for <iommu@lists.linux-foundation.org>; Fri,  1 Oct 2021 15:19:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4EE6F614EB
 for <iommu@lists.linux-foundation.org>; Fri,  1 Oct 2021 15:19:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ol4YqOs8bZj5 for <iommu@lists.linux-foundation.org>;
 Fri,  1 Oct 2021 15:19:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CC8CB614E9
 for <iommu@lists.linux-foundation.org>; Fri,  1 Oct 2021 15:19:47 +0000 (UTC)
Received: from fraeml702-chm.china.huawei.com (unknown [172.18.147.201])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HLYcH515jz67Prn;
 Fri,  1 Oct 2021 23:16:47 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Fri, 1 Oct 2021 17:19:44 +0200
Received: from [10.47.27.152] (10.47.27.152) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 1 Oct 2021
 16:19:43 +0100
Subject: Re: [PATCH v2] iommu/arm-smmu-v3: poll cmdq until it has space
To: Fernand Sieber <sieberf@amazon.com>, "will@kernel.org" <will@kernel.org>, 
 "robin.murphy@arm.com" <robin.murphy@arm.com>
References: <20210926185142.3379726-1-sieberf@amazon.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <1154985d-0337-6949-61c5-c310170809f2@huawei.com>
Date: Fri, 1 Oct 2021 16:22:34 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20210926185142.3379726-1-sieberf@amazon.com>
Content-Language: en-US
X-Originating-IP: [10.47.27.152]
X-ClientProxiedBy: lhreml731-chm.china.huawei.com (10.201.108.82) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 26/09/2021 19:51, Fernand Sieber wrote:
> When a thread sends commands to the SMMU, it needs to allocate some
> space to write its commands in a ring buffer.
> 
> The allocation algorithms works as follows: until enough free spaced is
> available in the queue, repeat the following outer loop. First, try to
> acquire an exclusive lock to read the consumer index from the SMMU
> register over MMIO. If that fails, it means that another thread holds
> the lock (or multiple threads, in shared mode, for sync commands). The
> current code guarantees that when a thread is holding the lock, the
> consumer index will be updated from the SMMU register. So then when the
> acquisition of the exclusive lock fails, we can safely assume that
> another thread will eventually update the consumer index and enter an
> inner waiting loop until that happens.
> 

You have written a lot in the commit message. I think that this 
paragraph can be dropped to try to make it more concise and readable.

> The problem that this patch fixes is that the waiting loop exits as soon
> as any space is available in the queue, so it is possible that it exits
> immediately if there's some space available but not enough to write the
> thread's commands.

To me, this seems strange. From my experience, I would expect that if 
the queue is full, and then some space comes available after updating 
the cons pointer from HW, then the cons pointer would have advanced so 
far such that we have more than enough space for the maximum amount of 
commands in a batch, 64.

> That means the cmdq allocation queue will fail (outer
> loop) and the thread will spin attempting to acquire the exclusive lock
> to update the consumer index from the SMMU register.
> 
> If a lot of threads are failing to allocate commands,

As above, what is special for your HW such that when the queue becomes 
not full that there is still not enough space? The cons pointer is only 
updated at 2x locations:
- in arm_smmu_cmdq_poll_until_not_full()
- the last CPU gathered unlocks the shared lock at the function exit

So it's not updated very regularly.

> this can cause
> heavy contention on the lock, to the point where the system slowdown or
> livelocks. The livelock is possible if some other threads are attempting
> to execute synchronous commands.

What are synchronous commands in this context? Do you mean we're issuing 
a CMD_SYNC?

> These threads need to ensure that they
> control updates to the consumer index so that they can correctly observe
> when their command is executed, they enforce that by acquiring the lock
> in shared mode. If there's too much contention, they never succeed to
> acquire the lock via the read+cmpxchg mechanism, and their progress
> stall.

Why is this? Why can they not get the lock? They spin waiting for it.

> But because they already hold allocated space in the command
> queue, their stall prevents progress from other threads attempting to
> allocate space in the cmdq. This causes a livelock.
> 
> This patch makes the waiting loop exit as soon as enough space is
> available, rather than as soon as any space is available. This means
> that when two threads are competing for the exclusive lock when
> allocating space in the queue, one of them will fail to acquiire the
> lock in exclusive lock and be knocked to the waiting loop and stay there
> until there's enough free space rather than exiting it immediately when
> any space is available. Threads in the waiting loop do not compete for
> the lock, reducing contention enough to enable synchronous threads to
> make progress, when applicable.
> 
> Note that we cannot afford to have all threads parked in the waiting
> loop unless there are synchronous threads executing concurrenty,

nit: I'd say CPU when describing this problem, rather than thread

> otherwise no thread is observing the SMMU register and updating the
> consumer index. Thus if we succeed to acquire the lock in exclusive
> mode, we cannot enter the waiting loop because we could be the last
> thread observing the SMMU. Similarly, if the producer index is updated,
> we need to exit the waiting loop because it could mean that the latest
> thread to observe the SMMU has succeeded to allocate commands and thus
> has moved on.
> 
> Signed-off-by: Fernand Sieber <sieberf@amazon.com>
> ---
> Changes in v2
>    - Fix inverted condition to break out the loop when queue_has_space
>    - Replace obsolete comment reference to llq->state->val by llq->val
> 
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 41 +++++++++++++++------
>   1 file changed, 29 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index a388e318f86e..a0a04cc9c57d 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -118,12 +118,6 @@ static bool queue_has_space(struct arm_smmu_ll_queue *q, u32 n)
>   	return space >= n;
>   }
> 
> -static bool queue_full(struct arm_smmu_ll_queue *q)
> -{
> -	return Q_IDX(q, q->prod) == Q_IDX(q, q->cons) &&
> -	       Q_WRP(q, q->prod) != Q_WRP(q, q->cons);
> -}
> -
>   static bool queue_empty(struct arm_smmu_ll_queue *q)
>   {
>   	return Q_IDX(q, q->prod) == Q_IDX(q, q->cons) &&
> @@ -582,14 +576,16 @@ static void arm_smmu_cmdq_poll_valid_map(struct arm_smmu_cmdq *cmdq,
>   	__arm_smmu_cmdq_poll_set_valid_map(cmdq, sprod, eprod, false);
>   }
> 
> -/* Wait for the command queue to become non-full */
> -static int arm_smmu_cmdq_poll_until_not_full(struct arm_smmu_device *smmu,
> -					     struct arm_smmu_ll_queue *llq)
> +/* Wait for the command queue to have enough space */
> +static int arm_smmu_cmdq_poll_until_has_space(struct arm_smmu_device *smmu,
> +					      struct arm_smmu_ll_queue *llq,
> +					      u32 n)
>   {
>   	unsigned long flags;
>   	struct arm_smmu_queue_poll qp;
>   	struct arm_smmu_cmdq *cmdq = arm_smmu_get_cmdq(smmu);
>   	int ret = 0;
> +	int prod;
> 
>   	/*
>   	 * Try to update our copy of cons by grabbing exclusive cmdq access. If
> @@ -599,15 +595,36 @@ static int arm_smmu_cmdq_poll_until_not_full(struct arm_smmu_device *smmu,
>   		WRITE_ONCE(cmdq->q.llq.cons, readl_relaxed(cmdq->q.cons_reg));
>   		arm_smmu_cmdq_exclusive_unlock_irqrestore(cmdq, flags);
>   		llq->val = READ_ONCE(cmdq->q.llq.val);
> -		return 0;
> +
> +		/*
> +		 * We must return here even if there's no space, because we could be
> +		 * the last thread observing the SMMU progress. Thus, we cannot enter
> +		 * the waiting loop below as it relies on another thread updating
> +		 * llq->val.
> +		 */
> +		if (queue_has_space(llq, n))
> +			return 0;
> +		else
> +			return -EAGAIN;
>   	}
> 
>   	queue_poll_init(smmu, &qp);
> +	prod = llq->prod;
>   	do {
>   		llq->val = READ_ONCE(cmdq->q.llq.val);
> -		if (!queue_full(llq))
> +		if (queue_has_space(llq, n))
>   			break;
> 
> +		/*
> +		 * We must return here even if there's no space, because the producer
> +		 * having moved forward could mean that the last thread observing the
> +		 * SMMU progress has allocated space in the cmdq and moved on, leaving
> +		 * us in this waiting loop with no other thread updating
> +		 * llq->val.
> +		 */
> +		if (llq->prod != prod)
> +			return -EAGAIN;
> +
>   		ret = queue_poll(&qp);
>   	} while (!ret);
> 
> @@ -755,7 +772,7 @@ static int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
> 
>   		while (!queue_has_space(&llq, n + sync)) {
>   			local_irq_restore(flags);
> -			if (arm_smmu_cmdq_poll_until_not_full(smmu, &llq))
> +			if (arm_smmu_cmdq_poll_until_has_space(smmu, &llq, n + sync) == -ETIMEDOUT)
>   				dev_err_ratelimited(smmu->dev, "CMDQ timeout\n");
>   			local_irq_save(flags);
>   		}
> --
> 2.25.1
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
