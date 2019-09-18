Return-Path: <SRS0=JP6a=XN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED77C4CEC4
	for <iommu@archiver.kernel.org>; Wed, 18 Sep 2019 16:18:10 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A6E4218AF
	for <iommu@archiver.kernel.org>; Wed, 18 Sep 2019 16:18:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A6E4218AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id F0976D1A;
	Wed, 18 Sep 2019 16:18:05 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id CDDB1C86
	for <iommu@lists.linux-foundation.org>;
	Wed, 18 Sep 2019 16:18:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 2F644832
	for <iommu@lists.linux-foundation.org>;
	Wed, 18 Sep 2019 16:18:02 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BBCC71576;
	Wed, 18 Sep 2019 09:18:01 -0700 (PDT)
Received: from e110467-lin.cambridge.arm.com (e110467-lin.cambridge.arm.com
	[10.1.197.57])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E7C043F59C; 
	Wed, 18 Sep 2019 09:18:00 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org
Subject: [PATCH 2/4] iommu/arm-smmu: Remove "leaf" indirection
Date: Wed, 18 Sep 2019 17:17:49 +0100
Message-Id: <4d401834469adc87283a173143fa5c6ede2a960a.1568820087.git.robin.murphy@arm.com>
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

Now that the "leaf" flag is no longer part of an external interface,
there's no need to use it to infer a register offset at runtime when
we can just as easily encode the offset directly in its place.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/arm-smmu.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index f2b81b1ce224..b5b4cd4cae19 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -312,18 +312,16 @@ static void arm_smmu_tlb_inv_context_s2(void *cookie)
 }
 
 static void arm_smmu_tlb_inv_range_s1(unsigned long iova, size_t size,
-				      size_t granule, void *cookie, bool leaf)
+				      size_t granule, void *cookie, int reg)
 {
 	struct arm_smmu_domain *smmu_domain = cookie;
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
-	int reg, idx = cfg->cbndx;
+	int idx = cfg->cbndx;
 
 	if (smmu->features & ARM_SMMU_FEAT_COHERENT_WALK)
 		wmb();
 
-	reg = leaf ? ARM_SMMU_CB_S1_TLBIVAL : ARM_SMMU_CB_S1_TLBIVA;
-
 	if (cfg->fmt != ARM_SMMU_CTX_FMT_AARCH64) {
 		iova = (iova >> 12) << 12;
 		iova |= cfg->asid;
@@ -342,16 +340,15 @@ static void arm_smmu_tlb_inv_range_s1(unsigned long iova, size_t size,
 }
 
 static void arm_smmu_tlb_inv_range_s2(unsigned long iova, size_t size,
-				      size_t granule, void *cookie, bool leaf)
+				      size_t granule, void *cookie, int reg)
 {
 	struct arm_smmu_domain *smmu_domain = cookie;
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
-	int reg, idx = smmu_domain->cfg.cbndx;
+	int idx = smmu_domain->cfg.cbndx;
 
 	if (smmu->features & ARM_SMMU_FEAT_COHERENT_WALK)
 		wmb();
 
-	reg = leaf ? ARM_SMMU_CB_S2_TLBIIPAS2L : ARM_SMMU_CB_S2_TLBIIPAS2;
 	iova >>= 12;
 	do {
 		if (smmu_domain->cfg.fmt == ARM_SMMU_CTX_FMT_AARCH64)
@@ -365,14 +362,16 @@ static void arm_smmu_tlb_inv_range_s2(unsigned long iova, size_t size,
 static void arm_smmu_tlb_inv_walk_s1(unsigned long iova, size_t size,
 				     size_t granule, void *cookie)
 {
-	arm_smmu_tlb_inv_range_s1(iova, size, granule, cookie, false);
+	arm_smmu_tlb_inv_range_s1(iova, size, granule, cookie,
+				  ARM_SMMU_CB_S1_TLBIVA);
 	arm_smmu_tlb_sync_context(cookie);
 }
 
 static void arm_smmu_tlb_inv_leaf_s1(unsigned long iova, size_t size,
 				     size_t granule, void *cookie)
 {
-	arm_smmu_tlb_inv_range_s1(iova, size, granule, cookie, true);
+	arm_smmu_tlb_inv_range_s1(iova, size, granule, cookie,
+				  ARM_SMMU_CB_S1_TLBIVAL);
 	arm_smmu_tlb_sync_context(cookie);
 }
 
@@ -380,20 +379,23 @@ static void arm_smmu_tlb_add_page_s1(struct iommu_iotlb_gather *gather,
 				     unsigned long iova, size_t granule,
 				     void *cookie)
 {
-	arm_smmu_tlb_inv_range_s1(iova, granule, granule, cookie, true);
+	arm_smmu_tlb_inv_range_s1(iova, granule, granule, cookie,
+				  ARM_SMMU_CB_S1_TLBIVAL);
 }
 
 static void arm_smmu_tlb_inv_walk_s2(unsigned long iova, size_t size,
 				     size_t granule, void *cookie)
 {
-	arm_smmu_tlb_inv_range_s2(iova, size, granule, cookie, false);
+	arm_smmu_tlb_inv_range_s2(iova, size, granule, cookie,
+				  ARM_SMMU_CB_S2_TLBIIPAS2);
 	arm_smmu_tlb_sync_context(cookie);
 }
 
 static void arm_smmu_tlb_inv_leaf_s2(unsigned long iova, size_t size,
 				     size_t granule, void *cookie)
 {
-	arm_smmu_tlb_inv_range_s2(iova, size, granule, cookie, true);
+	arm_smmu_tlb_inv_range_s2(iova, size, granule, cookie,
+				  ARM_SMMU_CB_S2_TLBIIPAS2L);
 	arm_smmu_tlb_sync_context(cookie);
 }
 
@@ -401,7 +403,8 @@ static void arm_smmu_tlb_add_page_s2(struct iommu_iotlb_gather *gather,
 				     unsigned long iova, size_t granule,
 				     void *cookie)
 {
-	arm_smmu_tlb_inv_range_s2(iova, granule, granule, cookie, true);
+	arm_smmu_tlb_inv_range_s2(iova, granule, granule, cookie,
+				  ARM_SMMU_CB_S2_TLBIIPAS2L);
 }
 
 static void arm_smmu_tlb_inv_any_s2_v1(unsigned long iova, size_t size,
-- 
2.21.0.dirty

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
