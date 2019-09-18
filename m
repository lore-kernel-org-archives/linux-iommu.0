Return-Path: <SRS0=JP6a=XN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00CD0C4CEC9
	for <iommu@archiver.kernel.org>; Wed, 18 Sep 2019 16:18:06 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5145218AF
	for <iommu@archiver.kernel.org>; Wed, 18 Sep 2019 16:18:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5145218AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id BE0A4CD9;
	Wed, 18 Sep 2019 16:18:05 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 27917C7D
	for <iommu@lists.linux-foundation.org>;
	Wed, 18 Sep 2019 16:18:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 7C787832
	for <iommu@lists.linux-foundation.org>;
	Wed, 18 Sep 2019 16:18:01 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B33F3142F;
	Wed, 18 Sep 2019 09:18:00 -0700 (PDT)
Received: from e110467-lin.cambridge.arm.com (e110467-lin.cambridge.arm.com
	[10.1.197.57])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E696C3F59C; 
	Wed, 18 Sep 2019 09:17:59 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org
Subject: [PATCH 1/4] iommu/arm-smmu: Remove .tlb_inv_range indirection
Date: Wed, 18 Sep 2019 17:17:48 +0100
Message-Id: <b53e35945c72bfeb6aab6b7bc8993ebff70c91cb.1568820087.git.robin.murphy@arm.com>
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

Fill in 'native' iommu_flush_ops callbacks for all the
arm_smmu_flush_ops variants, and clear up the remains of the previous
.tlb_inv_range abstraction.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/arm-smmu.c | 110 ++++++++++++++++++++++-----------------
 drivers/iommu/arm-smmu.h |   2 -
 2 files changed, 63 insertions(+), 49 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index c3ef0cc8f764..f2b81b1ce224 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -312,7 +312,7 @@ static void arm_smmu_tlb_inv_context_s2(void *cookie)
 }
 
 static void arm_smmu_tlb_inv_range_s1(unsigned long iova, size_t size,
-				      size_t granule, bool leaf, void *cookie)
+				      size_t granule, void *cookie, bool leaf)
 {
 	struct arm_smmu_domain *smmu_domain = cookie;
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
@@ -342,7 +342,7 @@ static void arm_smmu_tlb_inv_range_s1(unsigned long iova, size_t size,
 }
 
 static void arm_smmu_tlb_inv_range_s2(unsigned long iova, size_t size,
-				      size_t granule, bool leaf, void *cookie)
+				      size_t granule, void *cookie, bool leaf)
 {
 	struct arm_smmu_domain *smmu_domain = cookie;
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
@@ -362,14 +362,63 @@ static void arm_smmu_tlb_inv_range_s2(unsigned long iova, size_t size,
 	} while (size -= granule);
 }
 
+static void arm_smmu_tlb_inv_walk_s1(unsigned long iova, size_t size,
+				     size_t granule, void *cookie)
+{
+	arm_smmu_tlb_inv_range_s1(iova, size, granule, cookie, false);
+	arm_smmu_tlb_sync_context(cookie);
+}
+
+static void arm_smmu_tlb_inv_leaf_s1(unsigned long iova, size_t size,
+				     size_t granule, void *cookie)
+{
+	arm_smmu_tlb_inv_range_s1(iova, size, granule, cookie, true);
+	arm_smmu_tlb_sync_context(cookie);
+}
+
+static void arm_smmu_tlb_add_page_s1(struct iommu_iotlb_gather *gather,
+				     unsigned long iova, size_t granule,
+				     void *cookie)
+{
+	arm_smmu_tlb_inv_range_s1(iova, granule, granule, cookie, true);
+}
+
+static void arm_smmu_tlb_inv_walk_s2(unsigned long iova, size_t size,
+				     size_t granule, void *cookie)
+{
+	arm_smmu_tlb_inv_range_s2(iova, size, granule, cookie, false);
+	arm_smmu_tlb_sync_context(cookie);
+}
+
+static void arm_smmu_tlb_inv_leaf_s2(unsigned long iova, size_t size,
+				     size_t granule, void *cookie)
+{
+	arm_smmu_tlb_inv_range_s2(iova, size, granule, cookie, true);
+	arm_smmu_tlb_sync_context(cookie);
+}
+
+static void arm_smmu_tlb_add_page_s2(struct iommu_iotlb_gather *gather,
+				     unsigned long iova, size_t granule,
+				     void *cookie)
+{
+	arm_smmu_tlb_inv_range_s2(iova, granule, granule, cookie, true);
+}
+
+static void arm_smmu_tlb_inv_any_s2_v1(unsigned long iova, size_t size,
+				       size_t granule, void *cookie)
+{
+	arm_smmu_tlb_inv_context_s2(cookie);
+}
 /*
  * On MMU-401 at least, the cost of firing off multiple TLBIVMIDs appears
  * almost negligible, but the benefit of getting the first one in as far ahead
  * of the sync as possible is significant, hence we don't just make this a
- * no-op and set .tlb_sync to arm_smmu_tlb_inv_context_s2() as you might think.
+ * no-op and call arm_smmu_tlb_inv_context_s2() from .iotlb_sync as you might
+ * think.
  */
-static void arm_smmu_tlb_inv_vmid_nosync(unsigned long iova, size_t size,
-					 size_t granule, bool leaf, void *cookie)
+static void arm_smmu_tlb_add_page_s2_v1(struct iommu_iotlb_gather *gather,
+					unsigned long iova, size_t granule,
+					void *cookie)
 {
 	struct arm_smmu_domain *smmu_domain = cookie;
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
@@ -380,66 +429,33 @@ static void arm_smmu_tlb_inv_vmid_nosync(unsigned long iova, size_t size,
 	arm_smmu_gr0_write(smmu, ARM_SMMU_GR0_TLBIVMID, smmu_domain->cfg.vmid);
 }
 
-static void arm_smmu_tlb_inv_walk(unsigned long iova, size_t size,
-				  size_t granule, void *cookie)
-{
-	struct arm_smmu_domain *smmu_domain = cookie;
-	const struct arm_smmu_flush_ops *ops = smmu_domain->flush_ops;
-
-	ops->tlb_inv_range(iova, size, granule, false, cookie);
-	ops->tlb_sync(cookie);
-}
-
-static void arm_smmu_tlb_inv_leaf(unsigned long iova, size_t size,
-				  size_t granule, void *cookie)
-{
-	struct arm_smmu_domain *smmu_domain = cookie;
-	const struct arm_smmu_flush_ops *ops = smmu_domain->flush_ops;
-
-	ops->tlb_inv_range(iova, size, granule, true, cookie);
-	ops->tlb_sync(cookie);
-}
-
-static void arm_smmu_tlb_add_page(struct iommu_iotlb_gather *gather,
-				  unsigned long iova, size_t granule,
-				  void *cookie)
-{
-	struct arm_smmu_domain *smmu_domain = cookie;
-	const struct arm_smmu_flush_ops *ops = smmu_domain->flush_ops;
-
-	ops->tlb_inv_range(iova, granule, granule, true, cookie);
-}
-
 static const struct arm_smmu_flush_ops arm_smmu_s1_tlb_ops = {
 	.tlb = {
 		.tlb_flush_all	= arm_smmu_tlb_inv_context_s1,
-		.tlb_flush_walk	= arm_smmu_tlb_inv_walk,
-		.tlb_flush_leaf	= arm_smmu_tlb_inv_leaf,
-		.tlb_add_page	= arm_smmu_tlb_add_page,
+		.tlb_flush_walk	= arm_smmu_tlb_inv_walk_s1,
+		.tlb_flush_leaf	= arm_smmu_tlb_inv_leaf_s1,
+		.tlb_add_page	= arm_smmu_tlb_add_page_s1,
 	},
-	.tlb_inv_range		= arm_smmu_tlb_inv_range_s1,
 	.tlb_sync		= arm_smmu_tlb_sync_context,
 };
 
 static const struct arm_smmu_flush_ops arm_smmu_s2_tlb_ops_v2 = {
 	.tlb = {
 		.tlb_flush_all	= arm_smmu_tlb_inv_context_s2,
-		.tlb_flush_walk	= arm_smmu_tlb_inv_walk,
-		.tlb_flush_leaf	= arm_smmu_tlb_inv_leaf,
-		.tlb_add_page	= arm_smmu_tlb_add_page,
+		.tlb_flush_walk	= arm_smmu_tlb_inv_walk_s2,
+		.tlb_flush_leaf	= arm_smmu_tlb_inv_leaf_s2,
+		.tlb_add_page	= arm_smmu_tlb_add_page_s2,
 	},
-	.tlb_inv_range		= arm_smmu_tlb_inv_range_s2,
 	.tlb_sync		= arm_smmu_tlb_sync_context,
 };
 
 static const struct arm_smmu_flush_ops arm_smmu_s2_tlb_ops_v1 = {
 	.tlb = {
 		.tlb_flush_all	= arm_smmu_tlb_inv_context_s2,
-		.tlb_flush_walk	= arm_smmu_tlb_inv_walk,
-		.tlb_flush_leaf	= arm_smmu_tlb_inv_leaf,
-		.tlb_add_page	= arm_smmu_tlb_add_page,
+		.tlb_flush_walk	= arm_smmu_tlb_inv_any_s2_v1,
+		.tlb_flush_leaf	= arm_smmu_tlb_inv_any_s2_v1,
+		.tlb_add_page	= arm_smmu_tlb_add_page_s2_v1,
 	},
-	.tlb_inv_range		= arm_smmu_tlb_inv_vmid_nosync,
 	.tlb_sync		= arm_smmu_tlb_sync_vmid,
 };
 
diff --git a/drivers/iommu/arm-smmu.h b/drivers/iommu/arm-smmu.h
index b19b6cae9b5e..6edd35ca983c 100644
--- a/drivers/iommu/arm-smmu.h
+++ b/drivers/iommu/arm-smmu.h
@@ -306,8 +306,6 @@ enum arm_smmu_domain_stage {
 
 struct arm_smmu_flush_ops {
 	struct iommu_flush_ops		tlb;
-	void (*tlb_inv_range)(unsigned long iova, size_t size, size_t granule,
-			      bool leaf, void *cookie);
 	void (*tlb_sync)(void *cookie);
 };
 
-- 
2.21.0.dirty

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
