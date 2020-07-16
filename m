Return-Path: <SRS0=k4B3=A3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F41C433DF
	for <iommu@archiver.kernel.org>; Thu, 16 Jul 2020 10:19:48 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2478207F9
	for <iommu@archiver.kernel.org>; Thu, 16 Jul 2020 10:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="B4iWlTi9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2478207F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8C4598A844;
	Thu, 16 Jul 2020 10:19:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hOJjd+hKzocR; Thu, 16 Jul 2020 10:19:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id C5A4D8AD38;
	Thu, 16 Jul 2020 10:19:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B7EB6C07FF;
	Thu, 16 Jul 2020 10:19:47 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BACBEC0733
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jul 2020 10:19:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id B08CA8A844
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jul 2020 10:19:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1SeuQKvnB7kl for <iommu@lists.linux-foundation.org>;
 Thu, 16 Jul 2020 10:19:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 308F6899BE
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jul 2020 10:19:46 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 791782074B;
 Thu, 16 Jul 2020 10:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1594894786;
 bh=3Kfj2U0gvDfDloWASjQO57LR6xuFE6ghFAVQobdH6ks=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=B4iWlTi9n5/jNVzGiiyq/aD+XME5+rlz4gpt0p4upnXV/Im/YL7X+2qNX8fIrM5P0
 djtcRTQhlMZz05N6beqSbpgNlaFKKjDiqdb98e9mWioHJg2tt7hK8KPKx6t0kdlVSL
 ll7K9O4OpFj4wprqEokl/98nt+0WnI17uXg0TZHA=
Date: Thu, 16 Jul 2020 11:19:41 +0100
From: Will Deacon <will@kernel.org>
To: John Garry <john.garry@huawei.com>
Subject: Re: [PATCH 0/4] iommu/arm-smmu-v3: Improve cmdq lock efficiency
Message-ID: <20200716101940.GA7036@willie-the-truck>
References: <1592846920-45338-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1592846920-45338-1-git-send-email-john.garry@huawei.com>
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

On Tue, Jun 23, 2020 at 01:28:36AM +0800, John Garry wrote:
> As mentioned in [0], the CPU may consume many cycles processing
> arm_smmu_cmdq_issue_cmdlist(). One issue we find is the cmpxchg() loop to
> get space on the queue takes approx 25% of the cycles for this function.
> 
> This series removes that cmpxchg().

How about something much simpler like the diff below?

Will

--->8

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index f578677a5c41..705d99ec8219 100644
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
+	bool owner, cas_failed = false;
 	struct arm_smmu_cmdq *cmdq = &smmu->cmdq;
 	struct arm_smmu_ll_queue llq = {
 		.max_n_shift = cmdq->q.llq.max_n_shift,
@@ -1387,27 +1388,35 @@ static int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 
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
+		if (cas_failed)
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
-			break;
+		cas_failed = old != llq.val;
+
+		if (cas_failed)
+			spin_lock(&cmdq->slock);
+	} while (cas_failed);
 
-		llq.val = old;
-	} while (1);
 	owner = !(llq.prod & CMDQ_PROD_OWNED_FLAG);
 	head.prod &= ~CMDQ_PROD_OWNED_FLAG;
 	llq.prod &= ~CMDQ_PROD_OWNED_FLAG;
@@ -3192,6 +3201,7 @@ static int arm_smmu_cmdq_init(struct arm_smmu_device *smmu)
 
 	atomic_set(&cmdq->owner_prod, 0);
 	atomic_set(&cmdq->lock, 0);
+	spin_lock_init(&cmdq->slock);
 
 	bitmap = (atomic_long_t *)bitmap_zalloc(nents, GFP_KERNEL);
 	if (!bitmap) {
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
