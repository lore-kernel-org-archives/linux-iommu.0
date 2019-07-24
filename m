Return-Path: <SRS0=WqUy=VV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC226C7618B
	for <iommu@archiver.kernel.org>; Wed, 24 Jul 2019 12:15:56 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DECB229ED
	for <iommu@archiver.kernel.org>; Wed, 24 Jul 2019 12:15:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="aUHwjUoh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DECB229ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 62C36E28;
	Wed, 24 Jul 2019 12:15:56 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id F2243E1F
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Jul 2019 12:15:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 8D1F1FE
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Jul 2019 12:15:54 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
	bits)) (No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 20F5E21850;
	Wed, 24 Jul 2019 12:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563970554;
	bh=SHjKrTkPghbMozoTZ2WRCkhZTgW7uYTjnfwHsx2VFGA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aUHwjUohvNgTv7sLq+3t5Q0oQlDBDT82wtyZICPxr4IL6QBj0Yio/tYQqAzbIZNMW
	QQo7aJkhebX46KOue7NL5d8+aan9ATLzlAEw1tM0YyGEE8/fRJt71L6HaRovDxFwJ2
	c/7bKIn4w4k40FAXYrfWnWEzPFDOZxZgIhIdv244=
Date: Wed, 24 Jul 2019 13:15:48 +0100
From: Will Deacon <will@kernel.org>
To: John Garry <john.garry@huawei.com>
Subject: Re: [RFC PATCH v2 18/19] iommu/arm-smmu-v3: Reduce contention during
	command-queue insertion
Message-ID: <20190724121548.j5tekad45kwlobvs@willie-the-truck>
References: <20190711171927.28803-1-will@kernel.org>
	<20190711171927.28803-19-will@kernel.org>
	<8a1be404-f22a-1f96-2f0d-4cf35ca99d2d@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8a1be404-f22a-1f96-2f0d-4cf35ca99d2d@huawei.com>
User-Agent: NeoMutt/20170113 (1.7.2)
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Hi John,

Thanks for reading the code!

On Fri, Jul 19, 2019 at 12:04:15PM +0100, John Garry wrote:
> > +static int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
> > +				       u64 *cmds, int n, bool sync)
> > +{
> > +	u64 cmd_sync[CMDQ_ENT_DWORDS];
> > +	u32 prod;
> >  	unsigned long flags;
> > -	bool wfe = !!(smmu->features & ARM_SMMU_FEAT_SEV);
> > -	struct arm_smmu_cmdq_ent ent = { .opcode = CMDQ_OP_CMD_SYNC };
> > -	int ret;
> > +	bool owner;
> > +	struct arm_smmu_cmdq *cmdq = &smmu->cmdq;
> > +	struct arm_smmu_ll_queue llq = {
> > +		.max_n_shift = cmdq->q.llq.max_n_shift,
> > +	}, head = llq;
> > +	int ret = 0;
> > 
> > -	arm_smmu_cmdq_build_cmd(cmd, &ent);
> > +	/* 1. Allocate some space in the queue */
> > +	local_irq_save(flags);
> > +	llq.val = READ_ONCE(cmdq->q.llq.val);
> > +	do {
> > +		u64 old;
> > +
> > +		while (!queue_has_space(&llq, n + sync)) {
> > +			local_irq_restore(flags);
> > +			if (arm_smmu_cmdq_poll_until_not_full(smmu, &llq))
> > +				dev_err_ratelimited(smmu->dev, "CMDQ timeout\n");
> > +			local_irq_save(flags);
> > +		}
> > +
> > +		head.cons = llq.cons;
> > +		head.prod = queue_inc_prod_n(&llq, n + sync) |
> > +					     CMDQ_PROD_OWNED_FLAG;
> > +
> > +		old = cmpxchg_relaxed(&cmdq->q.llq.val, llq.val, head.val);
> > +		if (old == llq.val)
> > +			break;
> > +
> > +		llq.val = old;
> > +	} while (1);
> > +	owner = !(llq.prod & CMDQ_PROD_OWNED_FLAG);
> > +
> > +	/*
> > +	 * 2. Write our commands into the queue
> > +	 * Dependency ordering from the cmpxchg() loop above.
> > +	 */
> > +	arm_smmu_cmdq_write_entries(cmdq, cmds, llq.prod, n);
> > +	if (sync) {
> > +		prod = queue_inc_prod_n(&llq, n);
> > +		arm_smmu_cmdq_build_sync_cmd(cmd_sync, smmu, prod);
> > +		queue_write(Q_ENT(&cmdq->q, prod), cmd_sync, CMDQ_ENT_DWORDS);
> > +
> > +		/*
> > +		 * In order to determine completion of our CMD_SYNC, we must
> > +		 * ensure that the queue can't wrap twice without us noticing.
> > +		 * We achieve that by taking the cmdq lock as shared before
> > +		 * marking our slot as valid.
> > +		 */
> > +		arm_smmu_cmdq_shared_lock(cmdq);
> > +	}
> > +
> > +	/* 3. Mark our slots as valid, ensuring commands are visible first */
> > +	dma_wmb();
> > +	prod = queue_inc_prod_n(&llq, n + sync);
> > +	arm_smmu_cmdq_set_valid_map(cmdq, llq.prod, prod);
> > +
> > +	/* 4. If we are the owner, take control of the SMMU hardware */
> > +	if (owner) {
> > +		/* a. Wait for previous owner to finish */
> > +		atomic_cond_read_relaxed(&cmdq->owner_prod, VAL == llq.prod);
> > +
> > +		/* b. Stop gathering work by clearing the owned flag */
> > +		prod = atomic_fetch_andnot_relaxed(CMDQ_PROD_OWNED_FLAG,
> > +						   &cmdq->q.llq.atomic.prod);
> > +		prod &= ~CMDQ_PROD_OWNED_FLAG;
> > +		head.prod &= ~CMDQ_PROD_OWNED_FLAG;
> > +
> 
> Could it be a minor optimisation to advance the HW producer pointer at this
> stage for the owner only? We know that its entries are written, and it
> should be first in the new batch of commands (right?), so we could advance
> the pointer to at least get the HW started.

I think that would be a valid thing to do, but it depends on the relative
cost of writing to prod compared to how long we're likely to wait. Given
that everybody has irqs disabled when writing out their commands, I wouldn't
expect the waiting to be a big issue, although we could probably optimise
arm_smmu_cmdq_write_entries() into a memcpy() if we needed to.

In other words, I think we need numbers to justify that change.

Thanks,

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
