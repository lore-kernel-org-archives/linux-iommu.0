Return-Path: <SRS0=k4B3=A3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7DBAC433E2
	for <iommu@archiver.kernel.org>; Thu, 16 Jul 2020 10:58:42 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA13D206C1
	for <iommu@archiver.kernel.org>; Thu, 16 Jul 2020 10:58:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA13D206C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7DAE08A66F;
	Thu, 16 Jul 2020 10:58:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C9KSUq+d5sXj; Thu, 16 Jul 2020 10:58:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 715888A662;
	Thu, 16 Jul 2020 10:58:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 576F5C07FF;
	Thu, 16 Jul 2020 10:58:40 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 89301C0733
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jul 2020 10:58:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 7787288C73
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jul 2020 10:58:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lLo1tUn9uoXK for <iommu@lists.linux-foundation.org>;
 Thu, 16 Jul 2020 10:58:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (lhrrgout.huawei.com [185.176.76.210])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 1F5B788C34
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jul 2020 10:58:36 +0000 (UTC)
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.108])
 by Forcepoint Email with ESMTP id 96ACCE408E172062829B;
 Thu, 16 Jul 2020 11:58:34 +0100 (IST)
Received: from [127.0.0.1] (10.210.168.254) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Thu, 16 Jul
 2020 11:58:33 +0100
Subject: Re: [PATCH 0/4] iommu/arm-smmu-v3: Improve cmdq lock efficiency
To: Will Deacon <will@kernel.org>
References: <1592846920-45338-1-git-send-email-john.garry@huawei.com>
 <20200716101940.GA7036@willie-the-truck>
 <20200716102233.GC7036@willie-the-truck>
 <20200716102814.GD7036@willie-the-truck>
From: John Garry <john.garry@huawei.com>
Message-ID: <bd302efa-20d8-e1b3-6a80-db65ab5ad752@huawei.com>
Date: Thu, 16 Jul 2020 11:56:45 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200716102814.GD7036@willie-the-truck>
Content-Language: en-US
X-Originating-IP: [10.210.168.254]
X-ClientProxiedBy: lhreml714-chm.china.huawei.com (10.201.108.65) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: trivial@kernel.org, maz@kernel.org, linux-kernel@vger.kernel.org,
 linuxarm@huawei.com, iommu@lists.linux-foundation.org, robin.murphy@arm.com,
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

On 16/07/2020 11:28, Will Deacon wrote:
> On Thu, Jul 16, 2020 at 11:22:33AM +0100, Will Deacon wrote:
>> On Thu, Jul 16, 2020 at 11:19:41AM +0100, Will Deacon wrote:
>>> On Tue, Jun 23, 2020 at 01:28:36AM +0800, John Garry wrote:
>>>> As mentioned in [0], the CPU may consume many cycles processing
>>>> arm_smmu_cmdq_issue_cmdlist(). One issue we find is the cmpxchg() loop to
>>>> get space on the queue takes approx 25% of the cycles for this function.
>>>>
>>>> This series removes that cmpxchg().
>>>
>>> How about something much simpler like the diff below? >>
>> Ah, scratch that, I don't drop the lock if we fail the cas with it held.
>> Let me hack it some more (I have no hardware so I can only build-test this).
> 
> Right, second attempt...

I can try it, but if performance if not as good, then please check mine 
further (patch 4/4 specifically) - performance is really good, IMHO.

Thanks,

> 
> Will
> 
> --->8
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index f578677a5c41..e6bcddd6ef69 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -560,6 +560,7 @@ struct arm_smmu_cmdq {
>   	atomic_long_t			*valid_map;
>   	atomic_t			owner_prod;
>   	atomic_t			lock;
> +	spinlock_t			slock;
>   };
>   
>   struct arm_smmu_cmdq_batch {
> @@ -1378,7 +1379,7 @@ static int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
>   	u64 cmd_sync[CMDQ_ENT_DWORDS];
>   	u32 prod;
>   	unsigned long flags;
> -	bool owner;
> +	bool owner, locked = false;
>   	struct arm_smmu_cmdq *cmdq = &smmu->cmdq;
>   	struct arm_smmu_ll_queue llq = {
>   		.max_n_shift = cmdq->q.llq.max_n_shift,
> @@ -1387,27 +1388,38 @@ static int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
>   
>   	/* 1. Allocate some space in the queue */
>   	local_irq_save(flags);
> -	llq.val = READ_ONCE(cmdq->q.llq.val);
>   	do {
>   		u64 old;
> +		llq.val = READ_ONCE(cmdq->q.llq.val);
>   
> -		while (!queue_has_space(&llq, n + sync)) {
> +		if (queue_has_space(&llq, n + sync))
> +			goto try_cas;
> +
> +		if (locked)
> +			spin_unlock(&cmdq->slock);
> +
> +		do {
>   			local_irq_restore(flags);
>   			if (arm_smmu_cmdq_poll_until_not_full(smmu, &llq))
>   				dev_err_ratelimited(smmu->dev, "CMDQ timeout\n");
>   			local_irq_save(flags);
> -		}
> +		} while (!queue_has_space(&llq, n + sync));
>   
> +try_cas:
>   		head.cons = llq.cons;
>   		head.prod = queue_inc_prod_n(&llq, n + sync) |
>   					     CMDQ_PROD_OWNED_FLAG;
>   
>   		old = cmpxchg_relaxed(&cmdq->q.llq.val, llq.val, head.val);
> -		if (old == llq.val)
> +		if (old != llq.val)
>   			break;
>   
> -		llq.val = old;
> +		if (!locked) {
> +			spin_lock(&cmdq->slock);
> +			locked = true;
> +		}
>   	} while (1);
> +
>   	owner = !(llq.prod & CMDQ_PROD_OWNED_FLAG);
>   	head.prod &= ~CMDQ_PROD_OWNED_FLAG;
>   	llq.prod &= ~CMDQ_PROD_OWNED_FLAG;
> @@ -3192,6 +3204,7 @@ static int arm_smmu_cmdq_init(struct arm_smmu_device *smmu)
>   
>   	atomic_set(&cmdq->owner_prod, 0);
>   	atomic_set(&cmdq->lock, 0);
> +	spin_lock_init(&cmdq->slock);
>   
>   	bitmap = (atomic_long_t *)bitmap_zalloc(nents, GFP_KERNEL);
>   	if (!bitmap) {
> .
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
