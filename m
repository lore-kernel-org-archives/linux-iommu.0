Return-Path: <SRS0=B4OP=WL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF3A5C3A589
	for <iommu@archiver.kernel.org>; Thu, 15 Aug 2019 18:38:19 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC5902083B
	for <iommu@archiver.kernel.org>; Thu, 15 Aug 2019 18:38:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC5902083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id D3F0B10C0;
	Thu, 15 Aug 2019 18:37:54 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 1B1C3107D
	for <iommu@lists.linux-foundation.org>;
	Thu, 15 Aug 2019 18:37:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 92BB3CF
	for <iommu@lists.linux-foundation.org>;
	Thu, 15 Aug 2019 18:37:53 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B01D1596;
	Thu, 15 Aug 2019 11:37:53 -0700 (PDT)
Received: from e110467-lin.cambridge.arm.com (e110467-lin.cambridge.arm.com
	[10.1.197.57])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EAC843F694; 
	Thu, 15 Aug 2019 11:37:51 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org
Subject: [PATCH v2 07/17] iommu/arm-smmu: Split arm_smmu_tlb_inv_range_nosync()
Date: Thu, 15 Aug 2019 19:37:27 +0100
Message-Id: <087400cdf15908066aa7813ecbdc57254529ad79.1565892337.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.21.0.dirty
In-Reply-To: <cover.1565892337.git.robin.murphy@arm.com>
References: <cover.1565892337.git.robin.murphy@arm.com>
MIME-Version: 1.0
Cc: bjorn.andersson@linaro.org, iommu@lists.linux-foundation.org,
	gregory.clement@bootlin.com, linux-arm-kernel@lists.infradead.org
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

Since we now use separate iommu_gather_ops for stage 1 and stage 2
contexts, we may as well divide up the monolithic callback into its
respective stage 1 and stage 2 parts.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/arm-smmu.c | 66 ++++++++++++++++++++++------------------
 1 file changed, 37 insertions(+), 29 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 19126230c780..5b12e96d7878 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -490,46 +490,54 @@ static void arm_smmu_tlb_inv_context_s2(void *cookie)
 	arm_smmu_tlb_sync_global(smmu);
 }
 
-static void arm_smmu_tlb_inv_range_nosync(unsigned long iova, size_t size,
-					  size_t granule, bool leaf, void *cookie)
+static void arm_smmu_tlb_inv_range_s1(unsigned long iova, size_t size,
+				      size_t granule, bool leaf, void *cookie)
 {
 	struct arm_smmu_domain *smmu_domain = cookie;
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
-	bool stage1 = cfg->cbar != CBAR_TYPE_S2_TRANS;
-	void __iomem *reg = ARM_SMMU_CB(smmu_domain->smmu, cfg->cbndx);
+	void __iomem *reg = ARM_SMMU_CB(smmu, cfg->cbndx);
 
-	if (smmu_domain->smmu->features & ARM_SMMU_FEAT_COHERENT_WALK)
+	if (smmu->features & ARM_SMMU_FEAT_COHERENT_WALK)
 		wmb();
 
-	if (stage1) {
-		reg += leaf ? ARM_SMMU_CB_S1_TLBIVAL : ARM_SMMU_CB_S1_TLBIVA;
+	reg += leaf ? ARM_SMMU_CB_S1_TLBIVAL : ARM_SMMU_CB_S1_TLBIVA;
 
-		if (cfg->fmt != ARM_SMMU_CTX_FMT_AARCH64) {
-			iova = (iova >> 12) << 12;
-			iova |= cfg->asid;
-			do {
-				writel_relaxed(iova, reg);
-				iova += granule;
-			} while (size -= granule);
-		} else {
-			iova >>= 12;
-			iova |= (u64)cfg->asid << 48;
-			do {
-				writeq_relaxed(iova, reg);
-				iova += granule >> 12;
-			} while (size -= granule);
-		}
-	} else {
-		reg += leaf ? ARM_SMMU_CB_S2_TLBIIPAS2L :
-			      ARM_SMMU_CB_S2_TLBIIPAS2;
-		iova >>= 12;
+	if (cfg->fmt != ARM_SMMU_CTX_FMT_AARCH64) {
+		iova = (iova >> 12) << 12;
+		iova |= cfg->asid;
 		do {
-			smmu_write_atomic_lq(iova, reg);
+			writel_relaxed(iova, reg);
+			iova += granule;
+		} while (size -= granule);
+	} else {
+		iova >>= 12;
+		iova |= (u64)cfg->asid << 48;
+		do {
+			writeq_relaxed(iova, reg);
 			iova += granule >> 12;
 		} while (size -= granule);
 	}
 }
 
+static void arm_smmu_tlb_inv_range_s2(unsigned long iova, size_t size,
+				      size_t granule, bool leaf, void *cookie)
+{
+	struct arm_smmu_domain *smmu_domain = cookie;
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
+	void __iomem *reg = ARM_SMMU_CB(smmu, smmu_domain->cfg.cbndx);
+
+	if (smmu->features & ARM_SMMU_FEAT_COHERENT_WALK)
+		wmb();
+
+	reg += leaf ? ARM_SMMU_CB_S2_TLBIIPAS2L : ARM_SMMU_CB_S2_TLBIIPAS2;
+	iova >>= 12;
+	do {
+		smmu_write_atomic_lq(iova, reg);
+		iova += granule >> 12;
+	} while (size -= granule);
+}
+
 /*
  * On MMU-401 at least, the cost of firing off multiple TLBIVMIDs appears
  * almost negligible, but the benefit of getting the first one in as far ahead
@@ -550,13 +558,13 @@ static void arm_smmu_tlb_inv_vmid_nosync(unsigned long iova, size_t size,
 
 static const struct iommu_gather_ops arm_smmu_s1_tlb_ops = {
 	.tlb_flush_all	= arm_smmu_tlb_inv_context_s1,
-	.tlb_add_flush	= arm_smmu_tlb_inv_range_nosync,
+	.tlb_add_flush	= arm_smmu_tlb_inv_range_s1,
 	.tlb_sync	= arm_smmu_tlb_sync_context,
 };
 
 static const struct iommu_gather_ops arm_smmu_s2_tlb_ops_v2 = {
 	.tlb_flush_all	= arm_smmu_tlb_inv_context_s2,
-	.tlb_add_flush	= arm_smmu_tlb_inv_range_nosync,
+	.tlb_add_flush	= arm_smmu_tlb_inv_range_s2,
 	.tlb_sync	= arm_smmu_tlb_sync_context,
 };
 
-- 
2.21.0.dirty

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
