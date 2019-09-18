Return-Path: <SRS0=JP6a=XN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B256C4CEC4
	for <iommu@archiver.kernel.org>; Wed, 18 Sep 2019 16:18:15 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 065E1218AF
	for <iommu@archiver.kernel.org>; Wed, 18 Sep 2019 16:18:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 065E1218AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 33CE8D3B;
	Wed, 18 Sep 2019 16:18:06 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 7CFC1C84
	for <iommu@lists.linux-foundation.org>;
	Wed, 18 Sep 2019 16:18:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id EBEA3832
	for <iommu@lists.linux-foundation.org>;
	Wed, 18 Sep 2019 16:18:02 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BCA731596;
	Wed, 18 Sep 2019 09:18:02 -0700 (PDT)
Received: from e110467-lin.cambridge.arm.com (e110467-lin.cambridge.arm.com
	[10.1.197.57])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F05893F59C; 
	Wed, 18 Sep 2019 09:18:01 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org
Subject: [PATCH 3/4] iommu/arm-smmu: Move .tlb_sync method to implementation
Date: Wed, 18 Sep 2019 17:17:50 +0100
Message-Id: <0cb3380f9a6d60b3301acf977fd4455208c9035b.1568820087.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.21.0.dirty
In-Reply-To: <cover.1568820087.git.robin.murphy@arm.com>
References: <cover.1568820087.git.robin.murphy@arm.com>
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
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

With the .tlb_sync interface no longer exposed directly to io-pgtable,
strip away the remains of that abstraction layer. Retain the callback
in spirit, though, by transforming it into an implementation override
for the low-level sync routine itself, for which we will have at least
one user.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/arm-smmu.c | 33 +++++++++++++++------------------
 drivers/iommu/arm-smmu.h |  3 ++-
 2 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index b5b4cd4cae19..cc3b7517458d 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -244,6 +244,9 @@ static void __arm_smmu_tlb_sync(struct arm_smmu_device *smmu, int page,
 	unsigned int spin_cnt, delay;
 	u32 reg;
 
+	if (smmu->impl && unlikely(smmu->impl->tlb_sync))
+		return smmu->impl->tlb_sync(smmu, page, sync, status);
+
 	arm_smmu_writel(smmu, page, sync, QCOM_DUMMY_VAL);
 	for (delay = 1; delay < TLB_LOOP_TIMEOUT; delay *= 2) {
 		for (spin_cnt = TLB_SPIN_COUNT; spin_cnt > 0; spin_cnt--) {
@@ -268,9 +271,8 @@ static void arm_smmu_tlb_sync_global(struct arm_smmu_device *smmu)
 	spin_unlock_irqrestore(&smmu->global_sync_lock, flags);
 }
 
-static void arm_smmu_tlb_sync_context(void *cookie)
+static void arm_smmu_tlb_sync_context(struct arm_smmu_domain *smmu_domain)
 {
-	struct arm_smmu_domain *smmu_domain = cookie;
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	unsigned long flags;
 
@@ -280,13 +282,6 @@ static void arm_smmu_tlb_sync_context(void *cookie)
 	spin_unlock_irqrestore(&smmu_domain->cb_lock, flags);
 }
 
-static void arm_smmu_tlb_sync_vmid(void *cookie)
-{
-	struct arm_smmu_domain *smmu_domain = cookie;
-
-	arm_smmu_tlb_sync_global(smmu_domain->smmu);
-}
-
 static void arm_smmu_tlb_inv_context_s1(void *cookie)
 {
 	struct arm_smmu_domain *smmu_domain = cookie;
@@ -297,7 +292,7 @@ static void arm_smmu_tlb_inv_context_s1(void *cookie)
 	wmb();
 	arm_smmu_cb_write(smmu_domain->smmu, smmu_domain->cfg.cbndx,
 			  ARM_SMMU_CB_S1_TLBIASID, smmu_domain->cfg.asid);
-	arm_smmu_tlb_sync_context(cookie);
+	arm_smmu_tlb_sync_context(smmu_domain);
 }
 
 static void arm_smmu_tlb_inv_context_s2(void *cookie)
@@ -439,7 +434,6 @@ static const struct arm_smmu_flush_ops arm_smmu_s1_tlb_ops = {
 		.tlb_flush_leaf	= arm_smmu_tlb_inv_leaf_s1,
 		.tlb_add_page	= arm_smmu_tlb_add_page_s1,
 	},
-	.tlb_sync		= arm_smmu_tlb_sync_context,
 };
 
 static const struct arm_smmu_flush_ops arm_smmu_s2_tlb_ops_v2 = {
@@ -449,7 +443,6 @@ static const struct arm_smmu_flush_ops arm_smmu_s2_tlb_ops_v2 = {
 		.tlb_flush_leaf	= arm_smmu_tlb_inv_leaf_s2,
 		.tlb_add_page	= arm_smmu_tlb_add_page_s2,
 	},
-	.tlb_sync		= arm_smmu_tlb_sync_context,
 };
 
 static const struct arm_smmu_flush_ops arm_smmu_s2_tlb_ops_v1 = {
@@ -459,7 +452,6 @@ static const struct arm_smmu_flush_ops arm_smmu_s2_tlb_ops_v1 = {
 		.tlb_flush_leaf	= arm_smmu_tlb_inv_any_s2_v1,
 		.tlb_add_page	= arm_smmu_tlb_add_page_s2_v1,
 	},
-	.tlb_sync		= arm_smmu_tlb_sync_vmid,
 };
 
 static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
@@ -1229,11 +1221,16 @@ static void arm_smmu_iotlb_sync(struct iommu_domain *domain,
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
 
-	if (smmu_domain->flush_ops) {
-		arm_smmu_rpm_get(smmu);
-		smmu_domain->flush_ops->tlb_sync(smmu_domain);
-		arm_smmu_rpm_put(smmu);
-	}
+	if (!smmu)
+		return;
+
+	arm_smmu_rpm_get(smmu);
+	if (smmu->version == ARM_SMMU_V2 ||
+	    smmu_domain->stage == ARM_SMMU_DOMAIN_S1)
+		arm_smmu_tlb_sync_context(smmu_domain);
+	else
+		arm_smmu_tlb_sync_global(smmu);
+	arm_smmu_rpm_put(smmu);
 }
 
 static phys_addr_t arm_smmu_iova_to_phys_hard(struct iommu_domain *domain,
diff --git a/drivers/iommu/arm-smmu.h b/drivers/iommu/arm-smmu.h
index 6edd35ca983c..5032102f05b7 100644
--- a/drivers/iommu/arm-smmu.h
+++ b/drivers/iommu/arm-smmu.h
@@ -306,7 +306,6 @@ enum arm_smmu_domain_stage {
 
 struct arm_smmu_flush_ops {
 	struct iommu_flush_ops		tlb;
-	void (*tlb_sync)(void *cookie);
 };
 
 struct arm_smmu_domain {
@@ -333,6 +332,8 @@ struct arm_smmu_impl {
 	int (*cfg_probe)(struct arm_smmu_device *smmu);
 	int (*reset)(struct arm_smmu_device *smmu);
 	int (*init_context)(struct arm_smmu_domain *smmu_domain);
+	void (*tlb_sync)(struct arm_smmu_device *smmu, int page, int sync,
+			 int status);
 };
 
 static inline void __iomem *arm_smmu_page(struct arm_smmu_device *smmu, int n)
-- 
2.21.0.dirty

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
