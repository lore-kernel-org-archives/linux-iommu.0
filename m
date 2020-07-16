Return-Path: <SRS0=k4B3=A3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AEC6C433E4
	for <iommu@archiver.kernel.org>; Thu, 16 Jul 2020 10:28:23 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7F68207FB
	for <iommu@archiver.kernel.org>; Thu, 16 Jul 2020 10:28:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="F/nn69Uf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7F68207FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id A60A38B051;
	Thu, 16 Jul 2020 10:28:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qiy7us73FZHz; Thu, 16 Jul 2020 10:28:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1F5E58B012;
	Thu, 16 Jul 2020 10:28:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E4BCCC07FF;
	Thu, 16 Jul 2020 10:28:21 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7BC6CC0733
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jul 2020 10:28:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 6B03A87397
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jul 2020 10:28:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OI7mGCA_NOsf for <iommu@lists.linux-foundation.org>;
 Thu, 16 Jul 2020 10:28:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id EF6E887376
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jul 2020 10:28:19 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 36C4B2064C;
 Thu, 16 Jul 2020 10:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1594895299;
 bh=eYZY3p1eKyNjvzHbExBQW3tIe2/9FAaYa2K3SPnlFl0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=F/nn69UfcCxvBslPTCah6YicyWe896CVxFyIGihJU1VsXSWrn2LlPESUnBLvUdfwn
 5GcbEOkPboM7odWFd9ZAKSda2AFUJ3J/VHjdug8hBqnATkjWQ3/oWKHVzqCgzcICvl
 Qkj9LbOIYubeLkuhuA583ZoYiIaYiolMFJA67R0c=
Date: Thu, 16 Jul 2020 11:28:15 +0100
From: Will Deacon <will@kernel.org>
To: John Garry <john.garry@huawei.com>
Subject: Re: [PATCH 0/4] iommu/arm-smmu-v3: Improve cmdq lock efficiency
Message-ID: <20200716102814.GD7036@willie-the-truck>
References: <1592846920-45338-1-git-send-email-john.garry@huawei.com>
 <20200716101940.GA7036@willie-the-truck>
 <20200716102233.GC7036@willie-the-truck>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200716102233.GC7036@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Thu, Jul 16, 2020 at 11:22:33AM +0100, Will Deacon wrote:
> On Thu, Jul 16, 2020 at 11:19:41AM +0100, Will Deacon wrote:
> > On Tue, Jun 23, 2020 at 01:28:36AM +0800, John Garry wrote:
> > > As mentioned in [0], the CPU may consume many cycles processing
> > > arm_smmu_cmdq_issue_cmdlist(). One issue we find is the cmpxchg() loop to
> > > get space on the queue takes approx 25% of the cycles for this function.
> > > 
> > > This series removes that cmpxchg().
> > 
> > How about something much simpler like the diff below?
> 
> Ah, scratch that, I don't drop the lock if we fail the cas with it held.
> Let me hack it some more (I have no hardware so I can only build-test this).

Right, second attempt...

Will

--->8

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index f578677a5c41..e6bcddd6ef69 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -560,6 +560,7 @@ struct arm_smmu_cmdq {
 	atomic_long_t			*valid_map;
 	atomic_t			owner_prod;
 	atomic_t			lock;
+	spinlock_t			slock;
 };
 
 struct arm_smmu_cmdq_batch {
@@ -1378,7 +1379,7 @@ static int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 	u64 cmd_sync[CMDQ_ENT_DWORDS];
 	u32 prod;
 	unsigned long flags;
-	bool owner;
+	bool owner, locked = false;
 	struct arm_smmu_cmdq *cmdq = &smmu->cmdq;
 	struct arm_smmu_ll_queue llq = {
 		.max_n_shift = cmdq->q.llq.max_n_shift,
@@ -1387,27 +1388,38 @@ static int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 
 	/* 1. Allocate some space in the queue */
 	local_irq_save(flags);
-	llq.val = READ_ONCE(cmdq->q.llq.val);
 	do {
 		u64 old;
+		llq.val = READ_ONCE(cmdq->q.llq.val);
 
-		while (!queue_has_space(&llq, n + sync)) {
+		if (queue_has_space(&llq, n + sync))
+			goto try_cas;
+
+		if (locked)
+			spin_unlock(&cmdq->slock);
+
+		do {
 			local_irq_restore(flags);
 			if (arm_smmu_cmdq_poll_until_not_full(smmu, &llq))
 				dev_err_ratelimited(smmu->dev, "CMDQ timeout\n");
 			local_irq_save(flags);
-		}
+		} while (!queue_has_space(&llq, n + sync));
 
+try_cas:
 		head.cons = llq.cons;
 		head.prod = queue_inc_prod_n(&llq, n + sync) |
 					     CMDQ_PROD_OWNED_FLAG;
 
 		old = cmpxchg_relaxed(&cmdq->q.llq.val, llq.val, head.val);
-		if (old == llq.val)
+		if (old != llq.val)
 			break;
 
-		llq.val = old;
+		if (!locked) {
+			spin_lock(&cmdq->slock);
+			locked = true;
+		}
 	} while (1);
+
 	owner = !(llq.prod & CMDQ_PROD_OWNED_FLAG);
 	head.prod &= ~CMDQ_PROD_OWNED_FLAG;
 	llq.prod &= ~CMDQ_PROD_OWNED_FLAG;
@@ -3192,6 +3204,7 @@ static int arm_smmu_cmdq_init(struct arm_smmu_device *smmu)
 
 	atomic_set(&cmdq->owner_prod, 0);
 	atomic_set(&cmdq->lock, 0);
+	spin_lock_init(&cmdq->slock);
 
 	bitmap = (atomic_long_t *)bitmap_zalloc(nents, GFP_KERNEL);
 	if (!bitmap) {
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
