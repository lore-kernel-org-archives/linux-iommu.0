Return-Path: <SRS0=WqUy=VV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2093EC7618B
	for <iommu@archiver.kernel.org>; Wed, 24 Jul 2019 14:03:42 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 040BD22BF5
	for <iommu@archiver.kernel.org>; Wed, 24 Jul 2019 14:03:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 040BD22BF5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id CD6C0E18;
	Wed, 24 Jul 2019 14:03:40 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 9D1B4CC4
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Jul 2019 14:03:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id EE9A6224
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Jul 2019 14:03:38 +0000 (UTC)
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
	by Forcepoint Email with ESMTP id 018EC599644F5AA83E29;
	Wed, 24 Jul 2019 22:03:37 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS410-HUB.china.huawei.com
	(10.3.19.210) with Microsoft SMTP Server id 14.3.439.0;
	Wed, 24 Jul 2019 22:03:27 +0800
Subject: Re: [RFC PATCH v2 18/19] iommu/arm-smmu-v3: Reduce contention during
	command-queue insertion
To: Will Deacon <will@kernel.org>
References: <20190711171927.28803-1-will@kernel.org>
	<20190711171927.28803-19-will@kernel.org>
	<8a1be404-f22a-1f96-2f0d-4cf35ca99d2d@huawei.com>
	<20190724121548.j5tekad45kwlobvs@willie-the-truck>
From: John Garry <john.garry@huawei.com>
Message-ID: <fa90f89b-77f4-f983-52be-69bb40d17901@huawei.com>
Date: Wed, 24 Jul 2019 15:03:20 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
	Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190724121548.j5tekad45kwlobvs@willie-the-truck>
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Cc: Vijay Kilary <vkilari@codeaurora.org>,
	Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
	Jon Masters <jcm@redhat.com>, Jan Glauber <jglauber@marvell.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	iommu@lists.linux-foundation.org,
	Jayachandran Chandrasekharan Nair <jnair@marvell.com>,
	Robin Murphy <robin.murphy@arm.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On 24/07/2019 13:15, Will Deacon wrote:
> Hi John,
>
> Thanks for reading the code!
>
> On Fri, Jul 19, 2019 at 12:04:15PM +0100, John Garry wrote:
>>> +static int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
>>> +				       u64 *cmds, int n, bool sync)
>>> +{
>>> +	u64 cmd_sync[CMDQ_ENT_DWORDS];
>>> +	u32 prod;
>>>  	unsigned long flags;
>>> -	bool wfe = !!(smmu->features & ARM_SMMU_FEAT_SEV);
>>> -	struct arm_smmu_cmdq_ent ent = { .opcode = CMDQ_OP_CMD_SYNC };
>>> -	int ret;
>>> +	bool owner;
>>> +	struct arm_smmu_cmdq *cmdq = &smmu->cmdq;
>>> +	struct arm_smmu_ll_queue llq = {
>>> +		.max_n_shift = cmdq->q.llq.max_n_shift,
>>> +	}, head = llq;
>>> +	int ret = 0;
>>>
>>> -	arm_smmu_cmdq_build_cmd(cmd, &ent);
>>> +	/* 1. Allocate some space in the queue */
>>> +	local_irq_save(flags);
>>> +	llq.val = READ_ONCE(cmdq->q.llq.val);
>>> +	do {
>>> +		u64 old;
>>> +
>>> +		while (!queue_has_space(&llq, n + sync)) {
>>> +			local_irq_restore(flags);
>>> +			if (arm_smmu_cmdq_poll_until_not_full(smmu, &llq))
>>> +				dev_err_ratelimited(smmu->dev, "CMDQ timeout\n");
>>> +			local_irq_save(flags);
>>> +		}
>>> +
>>> +		head.cons = llq.cons;
>>> +		head.prod = queue_inc_prod_n(&llq, n + sync) |
>>> +					     CMDQ_PROD_OWNED_FLAG;
>>> +
>>> +		old = cmpxchg_relaxed(&cmdq->q.llq.val, llq.val, head.val);
>>> +		if (old == llq.val)
>>> +			break;
>>> +
>>> +		llq.val = old;
>>> +	} while (1);
>>> +	owner = !(llq.prod & CMDQ_PROD_OWNED_FLAG);
>>> +
>>> +	/*
>>> +	 * 2. Write our commands into the queue
>>> +	 * Dependency ordering from the cmpxchg() loop above.
>>> +	 */
>>> +	arm_smmu_cmdq_write_entries(cmdq, cmds, llq.prod, n);
>>> +	if (sync) {
>>> +		prod = queue_inc_prod_n(&llq, n);
>>> +		arm_smmu_cmdq_build_sync_cmd(cmd_sync, smmu, prod);
>>> +		queue_write(Q_ENT(&cmdq->q, prod), cmd_sync, CMDQ_ENT_DWORDS);
>>> +
>>> +		/*
>>> +		 * In order to determine completion of our CMD_SYNC, we must
>>> +		 * ensure that the queue can't wrap twice without us noticing.
>>> +		 * We achieve that by taking the cmdq lock as shared before
>>> +		 * marking our slot as valid.
>>> +		 */
>>> +		arm_smmu_cmdq_shared_lock(cmdq);
>>> +	}
>>> +
>>> +	/* 3. Mark our slots as valid, ensuring commands are visible first */
>>> +	dma_wmb();
>>> +	prod = queue_inc_prod_n(&llq, n + sync);
>>> +	arm_smmu_cmdq_set_valid_map(cmdq, llq.prod, prod);
>>> +
>>> +	/* 4. If we are the owner, take control of the SMMU hardware */
>>> +	if (owner) {
>>> +		/* a. Wait for previous owner to finish */
>>> +		atomic_cond_read_relaxed(&cmdq->owner_prod, VAL == llq.prod);
>>> +
>>> +		/* b. Stop gathering work by clearing the owned flag */
>>> +		prod = atomic_fetch_andnot_relaxed(CMDQ_PROD_OWNED_FLAG,
>>> +						   &cmdq->q.llq.atomic.prod);
>>> +		prod &= ~CMDQ_PROD_OWNED_FLAG;
>>> +		head.prod &= ~CMDQ_PROD_OWNED_FLAG;
>>> +
>>
>> Could it be a minor optimisation to advance the HW producer pointer at this
>> stage for the owner only? We know that its entries are written, and it
>> should be first in the new batch of commands (right?), so we could advance
>> the pointer to at least get the HW started.
>
> I think that would be a valid thing to do, but it depends on the relative
> cost of writing to prod compared to how long we're likely to wait. Given
> that everybody has irqs disabled when writing out their commands, I wouldn't
> expect the waiting to be a big issue,

For sure, but I'm thinking of the possible scenario where the the guy(s) 
we're waiting on have many more commands. Or they just joined the 
current gathering quite late, just prior to clearing the owner flag.

  although we could probably optimise
> arm_smmu_cmdq_write_entries() into a memcpy() if we needed to.
>
> In other words, I think we need numbers to justify that change.

Anyway, this is quite minor, and I will see if the change could be 
justified by numbers.

Cheers,
John

>
> Thanks,
>
> Will
>
> .
>


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
