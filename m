Return-Path: <SRS0=WqUy=VV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D760C7618B
	for <iommu@archiver.kernel.org>; Wed, 24 Jul 2019 14:34:03 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6153521926
	for <iommu@archiver.kernel.org>; Wed, 24 Jul 2019 14:34:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="j6sWGwVw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6153521926
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 47045E7F;
	Wed, 24 Jul 2019 14:34:03 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id EE951E50
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Jul 2019 14:34:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 92522701
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Jul 2019 14:34:01 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
	bits)) (No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 3363E2070B;
	Wed, 24 Jul 2019 14:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563978841;
	bh=W78Am0+E7OKsX9PmdodjQkRPcPu8JeBGSy9ubqXb/cU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j6sWGwVwWNL9jkaCck9z4SnmDEDGU6H1DzMsf2o4v32ZF/mBL05Ghjojs4KCbG6KK
	e5oMvPzP0OuS0Do7hlcZ4LlYau/uuFE/abR6RAhGGmrVP0lLPZvtFmTIMc6ya45rhm
	aYGmPXjFWUBQf1mXjn/LaICSfdV/1ULFNYgLtlRc=
Date: Wed, 24 Jul 2019 15:33:56 +0100
From: Will Deacon <will@kernel.org>
To: John Garry <john.garry@huawei.com>
Subject: Re: [RFC PATCH v2 18/19] iommu/arm-smmu-v3: Reduce contention during
	command-queue insertion
Message-ID: <20190724143355.r2zw6z37igwav2ki@willie-the-truck>
References: <20190711171927.28803-1-will@kernel.org>
	<20190711171927.28803-19-will@kernel.org>
	<b6302fdf-29ef-0aa2-ae7a-ed21c506c6ec@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b6302fdf-29ef-0aa2-ae7a-ed21c506c6ec@huawei.com>
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

Hi again, John,

On Wed, Jul 24, 2019 at 09:20:49AM +0100, John Garry wrote:
> On 11/07/2019 18:19, Will Deacon wrote:
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
> 
> I added some basic debug to the stress test on your branch, and this cmpxchg
> was failing ~10 times on average on my D06.
> 
> So we're not using the spinlock now, but this cmpxchg may lack fairness.

It definitely lacks fairness, although that's going to be the case in many
other places where locking is elided as well. If it shows up as an issue, we
should try to address it, but queueing means serialisation and that largely
defeats the point of this patch. I also don't expect it to be a problem
unless the cmpxchg() is heavily contended, which shouldn't be the case if
we're batching.

> Since we're batching commands, I wonder if it's better to restore the
> spinlock and send batched commands + CMD_SYNC under the lock, and then wait
> for the CMD_SYNC completion outside the lock.

Again, we'd need some numbers, but my concern with that approach is that
we're serialising CPUs which is what I've been trying hard to avoid. It
also doesn't let you straightforwardly remove the cmpxchg() loop, since
the owner clears the OWNED flag and you probably wouldn't want to hold
the lock for that.

> I don't know if it improves the queue contetion, but at least the prod
> pointer would be more closely track the issued commands, such that we're not
> waiting to kick off many gathered batches of commands, while the SMMU HW may
> be idle (in terms of command processing).

Again, probably going to need some numbers to change this, although it
sounds like your other suggestion about having the owner move prod twice
would largely address your concerns. Reintroducing the lock, on the other
hand, feels like a big step backwards to me, and the whole reason I started
down the current route was because of vague claims that the locking was a
problem for large systems.

Thanks,

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
