Return-Path: <SRS0=oIyp=GY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC5CC433E0
	for <iommu@archiver.kernel.org>; Thu, 21 Jan 2021 14:09:54 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EA0F239A4
	for <iommu@archiver.kernel.org>; Thu, 21 Jan 2021 14:09:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EA0F239A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 11F51871C8;
	Thu, 21 Jan 2021 14:09:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id snOEI4HbVpWU; Thu, 21 Jan 2021 14:09:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1F52687010;
	Thu, 21 Jan 2021 14:09:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0E746C1E6F;
	Thu, 21 Jan 2021 14:09:52 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7EBB5C0FA7
 for <iommu@lists.linux-foundation.org>; Thu, 21 Jan 2021 14:09:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 35F2D204B5
 for <iommu@lists.linux-foundation.org>; Thu, 21 Jan 2021 14:09:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sTZMwAggQqo3 for <iommu@lists.linux-foundation.org>;
 Thu, 21 Jan 2021 14:09:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by silver.osuosl.org (Postfix) with ESMTP id 883C6204A6
 for <iommu@lists.linux-foundation.org>; Thu, 21 Jan 2021 14:09:49 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A31AD11D4;
 Thu, 21 Jan 2021 06:09:48 -0800 (PST)
Received: from DESKTOP-VLO843J.arm.com (unknown [10.57.39.58])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 942193F68F;
 Thu, 21 Jan 2021 06:09:47 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org
Subject: [PATCH] iommu/arm-smmu-v3: Remove the page 1 fixup
Date: Thu, 21 Jan 2021 14:09:42 +0000
Message-Id: <08d9bda570bb5681f11a2f250a31be9ef763b8c5.1611238182.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.17.1
Cc: jean-philippe@linaro.org, iommu@lists.linux-foundation.org,
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Since we now keep track of page 1 via a separate pointer that already
encapsulates aliasing to page 0 as necessary, we can remove the clunky
fixup routine and simply use the relevant bases directly. The current
architecture spec (IHI0070D.a) defines SMMU_{EVENTQ,PRIQ}_{PROD,CONS} as
offsets relative to page 1, so the cleanup represents a little bit of
convergence as well as just lines of code saved.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 42 ++++++++-------------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  8 ++--
 2 files changed, 20 insertions(+), 30 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 5a3492116bbc..15f4eea25148 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -90,15 +90,6 @@ static struct arm_smmu_option_prop arm_smmu_options[] = {
 	{ 0, NULL},
 };
 
-static inline void __iomem *arm_smmu_page1_fixup(unsigned long offset,
-						 struct arm_smmu_device *smmu)
-{
-	if (offset > SZ_64K)
-		return smmu->page1 + offset - SZ_64K;
-
-	return smmu->base + offset;
-}
-
 static void parse_driver_options(struct arm_smmu_device *smmu)
 {
 	int i = 0;
@@ -2613,6 +2604,7 @@ static struct iommu_ops arm_smmu_ops = {
 /* Probing and initialisation functions */
 static int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
 				   struct arm_smmu_queue *q,
+				   void __iomem *page,
 				   unsigned long prod_off,
 				   unsigned long cons_off,
 				   size_t dwords, const char *name)
@@ -2641,8 +2633,8 @@ static int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
 			 1 << q->llq.max_n_shift, name);
 	}
 
-	q->prod_reg	= arm_smmu_page1_fixup(prod_off, smmu);
-	q->cons_reg	= arm_smmu_page1_fixup(cons_off, smmu);
+	q->prod_reg	= page + prod_off;
+	q->cons_reg	= page + cons_off;
 	q->ent_dwords	= dwords;
 
 	q->q_base  = Q_BASE_RWA;
@@ -2686,9 +2678,9 @@ static int arm_smmu_init_queues(struct arm_smmu_device *smmu)
 	int ret;
 
 	/* cmdq */
-	ret = arm_smmu_init_one_queue(smmu, &smmu->cmdq.q, ARM_SMMU_CMDQ_PROD,
-				      ARM_SMMU_CMDQ_CONS, CMDQ_ENT_DWORDS,
-				      "cmdq");
+	ret = arm_smmu_init_one_queue(smmu, &smmu->cmdq.q, smmu->base,
+				      ARM_SMMU_CMDQ_PROD, ARM_SMMU_CMDQ_CONS,
+				      CMDQ_ENT_DWORDS, "cmdq");
 	if (ret)
 		return ret;
 
@@ -2697,9 +2689,9 @@ static int arm_smmu_init_queues(struct arm_smmu_device *smmu)
 		return ret;
 
 	/* evtq */
-	ret = arm_smmu_init_one_queue(smmu, &smmu->evtq.q, ARM_SMMU_EVTQ_PROD,
-				      ARM_SMMU_EVTQ_CONS, EVTQ_ENT_DWORDS,
-				      "evtq");
+	ret = arm_smmu_init_one_queue(smmu, &smmu->evtq.q, smmu->page1,
+				      ARM_SMMU_EVTQ_PROD, ARM_SMMU_EVTQ_CONS,
+				      EVTQ_ENT_DWORDS, "evtq");
 	if (ret)
 		return ret;
 
@@ -2707,9 +2699,9 @@ static int arm_smmu_init_queues(struct arm_smmu_device *smmu)
 	if (!(smmu->features & ARM_SMMU_FEAT_PRI))
 		return 0;
 
-	return arm_smmu_init_one_queue(smmu, &smmu->priq.q, ARM_SMMU_PRIQ_PROD,
-				       ARM_SMMU_PRIQ_CONS, PRIQ_ENT_DWORDS,
-				       "priq");
+	return arm_smmu_init_one_queue(smmu, &smmu->priq.q, smmu->page1,
+				       ARM_SMMU_PRIQ_PROD, ARM_SMMU_PRIQ_CONS,
+				       PRIQ_ENT_DWORDS, "priq");
 }
 
 static int arm_smmu_init_l1_strtab(struct arm_smmu_device *smmu)
@@ -3119,10 +3111,8 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
 
 	/* Event queue */
 	writeq_relaxed(smmu->evtq.q.q_base, smmu->base + ARM_SMMU_EVTQ_BASE);
-	writel_relaxed(smmu->evtq.q.llq.prod,
-		       arm_smmu_page1_fixup(ARM_SMMU_EVTQ_PROD, smmu));
-	writel_relaxed(smmu->evtq.q.llq.cons,
-		       arm_smmu_page1_fixup(ARM_SMMU_EVTQ_CONS, smmu));
+	writel_relaxed(smmu->evtq.q.llq.prod, smmu->page1 + ARM_SMMU_EVTQ_PROD);
+	writel_relaxed(smmu->evtq.q.llq.cons, smmu->page1 + ARM_SMMU_EVTQ_CONS);
 
 	enables |= CR0_EVTQEN;
 	ret = arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0,
@@ -3137,9 +3127,9 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
 		writeq_relaxed(smmu->priq.q.q_base,
 			       smmu->base + ARM_SMMU_PRIQ_BASE);
 		writel_relaxed(smmu->priq.q.llq.prod,
-			       arm_smmu_page1_fixup(ARM_SMMU_PRIQ_PROD, smmu));
+			       smmu->page1 + ARM_SMMU_PRIQ_PROD);
 		writel_relaxed(smmu->priq.q.llq.cons,
-			       arm_smmu_page1_fixup(ARM_SMMU_PRIQ_CONS, smmu));
+			       smmu->page1 + ARM_SMMU_PRIQ_CONS);
 
 		enables |= CR0_PRIQEN;
 		ret = arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0,
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index e094cd92df2d..63f1c114c810 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -139,15 +139,15 @@
 #define ARM_SMMU_CMDQ_CONS		0x9c
 
 #define ARM_SMMU_EVTQ_BASE		0xa0
-#define ARM_SMMU_EVTQ_PROD		0x100a8
-#define ARM_SMMU_EVTQ_CONS		0x100ac
+#define ARM_SMMU_EVTQ_PROD		0xa8
+#define ARM_SMMU_EVTQ_CONS		0xac
 #define ARM_SMMU_EVTQ_IRQ_CFG0		0xb0
 #define ARM_SMMU_EVTQ_IRQ_CFG1		0xb8
 #define ARM_SMMU_EVTQ_IRQ_CFG2		0xbc
 
 #define ARM_SMMU_PRIQ_BASE		0xc0
-#define ARM_SMMU_PRIQ_PROD		0x100c8
-#define ARM_SMMU_PRIQ_CONS		0x100cc
+#define ARM_SMMU_PRIQ_PROD		0xc8
+#define ARM_SMMU_PRIQ_CONS		0xcc
 #define ARM_SMMU_PRIQ_IRQ_CFG0		0xd0
 #define ARM_SMMU_PRIQ_IRQ_CFG1		0xd8
 #define ARM_SMMU_PRIQ_IRQ_CFG2		0xdc
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
