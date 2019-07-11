Return-Path: <SRS0=Q5U9=VI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F55C74A5B
	for <iommu@archiver.kernel.org>; Thu, 11 Jul 2019 17:29:50 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39E4E20863
	for <iommu@archiver.kernel.org>; Thu, 11 Jul 2019 17:29:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PHeW2r43"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39E4E20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 735845498;
	Thu, 11 Jul 2019 17:28:56 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id C1647547A
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Jul 2019 17:20:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id E9AF9886
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Jul 2019 17:20:10 +0000 (UTC)
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa
	[217.169.31.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 6DC47216FD;
	Thu, 11 Jul 2019 17:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562865604;
	bh=vjurb9gASc7UQ1CM+sFuDlXOAychhDK4+6LHAFBppGs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PHeW2r43yRGbNN/e+vJvXzzodtzLJ4fyahLliQtr1PzxicBi9GVBaQMP1wjDqanh5
	6B2mY7/hioiwfry1O51xrWADVL9Y/1NzhD8WNi3nVh0qdm210LjjOhpUx1mVWvSIhG
	yH6u14TNapJzFuOeroLbPGorHEWjVDwa/5OBK3hg=
From: Will Deacon <will@kernel.org>
To: iommu@lists.linux-foundation.org
Subject: [RFC PATCH v2 11/19] iommu/io-pgtable: Remove unused ->tlb_sync()
	callback
Date: Thu, 11 Jul 2019 18:19:19 +0100
Message-Id: <20190711171927.28803-12-will@kernel.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190711171927.28803-1-will@kernel.org>
References: <20190711171927.28803-1-will@kernel.org>
Cc: Vijay Kilary <vkilari@codeaurora.org>,
	Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
	Will Deacon <will@kernel.org>, Jan Glauber <jglauber@marvell.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Jayachandran Chandrasekharan Nair <jnair@marvell.com>,
	Jon Masters <jcm@redhat.com>, Robin Murphy <robin.murphy@arm.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

The ->tlb_sync() callback is no longer used, so it can be removed.

Signed-off-by: Will Deacon <will@kernel.org>
---
 drivers/gpu/drm/panfrost/panfrost_mmu.c |  1 -
 drivers/iommu/arm-smmu-v3.c             |  8 --------
 drivers/iommu/arm-smmu.c                | 17 +++++++++--------
 drivers/iommu/io-pgtable-arm-v7s.c      |  6 ------
 drivers/iommu/io-pgtable-arm.c          |  6 ------
 drivers/iommu/ipmmu-vmsa.c              |  1 -
 drivers/iommu/msm_iommu.c               | 20 +++++++-------------
 drivers/iommu/mtk_iommu.c               |  1 -
 drivers/iommu/qcom_iommu.c              |  1 -
 include/linux/io-pgtable.h              |  9 ---------
 10 files changed, 16 insertions(+), 54 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
index d2cfa0ed32b8..8241656adc98 100644
--- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
@@ -261,7 +261,6 @@ static const struct iommu_flush_ops mmu_tlb_ops = {
 	.tlb_flush_all	= mmu_tlb_inv_context_s1,
 	.tlb_flush_walk = mmu_tlb_flush_walk,
 	.tlb_flush_leaf = mmu_tlb_flush_leaf,
-	.tlb_sync	= mmu_tlb_sync_context,
 };
 
 static const char *access_type_name(struct panfrost_device *pfdev,
diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index feea1b6ca127..a245c9e16077 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1539,13 +1539,6 @@ static int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain,
 }
 
 /* IO_PGTABLE API */
-static void arm_smmu_tlb_sync(void *cookie)
-{
-	struct arm_smmu_domain *smmu_domain = cookie;
-
-	arm_smmu_cmdq_issue_sync(smmu_domain->smmu);
-}
-
 static void arm_smmu_tlb_inv_context(void *cookie)
 {
 	struct arm_smmu_domain *smmu_domain = cookie;
@@ -1628,7 +1621,6 @@ static const struct iommu_flush_ops arm_smmu_flush_ops = {
 	.tlb_flush_walk = arm_smmu_tlb_inv_walk,
 	.tlb_flush_leaf = arm_smmu_tlb_inv_leaf,
 	.tlb_add_page	= arm_smmu_tlb_inv_page_nosync,
-	.tlb_sync	= arm_smmu_tlb_sync,
 };
 
 /* IOMMU API */
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 30ed97cd3993..28da70972b1b 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -254,7 +254,8 @@ enum arm_smmu_domain_stage {
 struct arm_smmu_flush_ops {
 	struct iommu_flush_ops		tlb;
 	void (*tlb_inv_range)(unsigned long iova, size_t size, size_t granule,
-			      bool leaf, void *cookie)
+			      bool leaf, void *cookie);
+	void (*tlb_sync)(void *cookie);
 };
 
 struct arm_smmu_domain {
@@ -542,7 +543,7 @@ static void arm_smmu_tlb_inv_range_nosync(unsigned long iova, size_t size,
  * On MMU-401 at least, the cost of firing off multiple TLBIVMIDs appears
  * almost negligible, but the benefit of getting the first one in as far ahead
  * of the sync as possible is significant, hence we don't just make this a
- * no-op and set .tlb_sync to arm_smmu_inv_context_s2() as you might think.
+ * no-op and set .tlb_sync to arm_smmu_tlb_inv_context_s2() as you might think.
  */
 static void arm_smmu_tlb_inv_vmid_nosync(unsigned long iova, size_t size,
 					 size_t granule, bool leaf, void *cookie)
@@ -563,7 +564,7 @@ static void arm_smmu_tlb_inv_walk(unsigned long iova, size_t size,
 	const struct arm_smmu_flush_ops *ops = smmu_domain->flush_ops;
 
 	ops->tlb_inv_range(iova, size, granule, false, cookie);
-	ops->tlb.tlb_sync(cookie);
+	ops->tlb_sync(cookie);
 }
 
 static void arm_smmu_tlb_inv_leaf(unsigned long iova, size_t size,
@@ -573,7 +574,7 @@ static void arm_smmu_tlb_inv_leaf(unsigned long iova, size_t size,
 	const struct arm_smmu_flush_ops *ops = smmu_domain->flush_ops;
 
 	ops->tlb_inv_range(iova, size, granule, true, cookie);
-	ops->tlb.tlb_sync(cookie);
+	ops->tlb_sync(cookie);
 }
 
 static void arm_smmu_tlb_add_page(unsigned long iova, size_t granule,
@@ -591,9 +592,9 @@ static const struct arm_smmu_flush_ops arm_smmu_s1_tlb_ops = {
 		.tlb_flush_walk	= arm_smmu_tlb_inv_walk,
 		.tlb_flush_leaf	= arm_smmu_tlb_inv_leaf,
 		.tlb_add_page	= arm_smmu_tlb_add_page,
-		.tlb_sync	= arm_smmu_tlb_sync_context,
 	},
 	.tlb_inv_range		= arm_smmu_tlb_inv_range_nosync,
+	.tlb_sync		= arm_smmu_tlb_sync_context,
 };
 
 static const struct arm_smmu_flush_ops arm_smmu_s2_tlb_ops_v2 = {
@@ -602,9 +603,9 @@ static const struct arm_smmu_flush_ops arm_smmu_s2_tlb_ops_v2 = {
 		.tlb_flush_walk	= arm_smmu_tlb_inv_walk,
 		.tlb_flush_leaf	= arm_smmu_tlb_inv_leaf,
 		.tlb_add_page	= arm_smmu_tlb_add_page,
-		.tlb_sync	= arm_smmu_tlb_sync_context,
 	},
 	.tlb_inv_range		= arm_smmu_tlb_inv_range_nosync,
+	.tlb_sync		= arm_smmu_tlb_sync_context,
 };
 
 static const struct arm_smmu_flush_ops arm_smmu_s2_tlb_ops_v1 = {
@@ -613,9 +614,9 @@ static const struct arm_smmu_flush_ops arm_smmu_s2_tlb_ops_v1 = {
 		.tlb_flush_walk	= arm_smmu_tlb_inv_walk,
 		.tlb_flush_leaf	= arm_smmu_tlb_inv_leaf,
 		.tlb_add_page	= arm_smmu_tlb_add_page,
-		.tlb_sync	= arm_smmu_tlb_sync_vmid,
 	},
 	.tlb_inv_range		= arm_smmu_tlb_inv_vmid_nosync,
+	.tlb_sync		= arm_smmu_tlb_sync_vmid,
 };
 
 static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
@@ -1390,7 +1391,7 @@ static void arm_smmu_iotlb_sync(struct iommu_domain *domain,
 
 	if (smmu_domain->flush_ops) {
 		arm_smmu_rpm_get(smmu);
-		smmu_domain->flush_ops->tlb.tlb_sync(smmu_domain);
+		smmu_domain->flush_ops->tlb_sync(smmu_domain);
 		arm_smmu_rpm_put(smmu);
 	}
 }
diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
index d94bcad49888..5a4a534c2782 100644
--- a/drivers/iommu/io-pgtable-arm-v7s.c
+++ b/drivers/iommu/io-pgtable-arm-v7s.c
@@ -824,17 +824,11 @@ static void dummy_tlb_add_page(unsigned long iova, size_t granule, void *cookie)
 	dummy_tlb_flush(iova, granule, granule, cookie);
 }
 
-static void dummy_tlb_sync(void *cookie)
-{
-	WARN_ON(cookie != cfg_cookie);
-}
-
 static const struct iommu_flush_ops dummy_tlb_ops = {
 	.tlb_flush_all	= dummy_tlb_flush_all,
 	.tlb_flush_walk	= dummy_tlb_flush,
 	.tlb_flush_leaf	= dummy_tlb_flush,
 	.tlb_add_page	= dummy_tlb_add_page,
-	.tlb_sync	= dummy_tlb_sync,
 };
 
 #define __FAIL(ops)	({				\
diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index b6be7686534b..6fb83910bac5 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -1091,17 +1091,11 @@ static void dummy_tlb_add_page(unsigned long iova, size_t granule, void *cookie)
 	dummy_tlb_flush(iova, granule, granule, cookie);
 }
 
-static void dummy_tlb_sync(void *cookie)
-{
-	WARN_ON(cookie != cfg_cookie);
-}
-
 static const struct iommu_flush_ops dummy_tlb_ops __initconst = {
 	.tlb_flush_all	= dummy_tlb_flush_all,
 	.tlb_flush_walk	= dummy_tlb_flush,
 	.tlb_flush_leaf	= dummy_tlb_flush,
 	.tlb_add_page	= dummy_tlb_add_page,
-	.tlb_sync	= dummy_tlb_sync,
 };
 
 static void __init arm_lpae_dump_ops(struct io_pgtable_ops *ops)
diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 9b961c4cd4c3..651c3cf7b124 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -364,7 +364,6 @@ static const struct iommu_flush_ops ipmmu_flush_ops = {
 	.tlb_flush_all = ipmmu_tlb_flush_all,
 	.tlb_flush_walk = ipmmu_tlb_flush,
 	.tlb_flush_leaf = ipmmu_tlb_flush,
-	.tlb_sync = ipmmu_tlb_flush_all,
 };
 
 /* -----------------------------------------------------------------------------
diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index b71485e98e76..d9c3d1816a29 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -181,28 +181,16 @@ static void __flush_iotlb_range(unsigned long iova, size_t size,
 	return;
 }
 
-static void __flush_iotlb_sync(void *cookie)
-{
-	/*
-	 * Nothing is needed here, the barrier to guarantee
-	 * completion of the tlb sync operation is implicitly
-	 * taken care when the iommu client does a writel before
-	 * kick starting the other master.
-	 */
-}
-
 static void __flush_iotlb_walk(unsigned long iova, size_t size,
 			       size_t granule, void *cookie)
 {
 	__flush_iotlb_range(iova, size, granule, false, cookie);
-	__flush_iotlb_sync(cookie);
 }
 
 static void __flush_iotlb_leaf(unsigned long iova, size_t size,
 			       size_t granule, void *cookie)
 {
 	__flush_iotlb_range(iova, size, granule, true, cookie);
-	__flush_iotlb_sync(cookie);
 }
 
 static void __flush_iotlb_page(unsigned long iova, size_t granule, void *cookie)
@@ -215,7 +203,6 @@ static const struct iommu_flush_ops msm_iommu_flush_ops = {
 	.tlb_flush_walk = __flush_iotlb_walk,
 	.tlb_flush_leaf = __flush_iotlb_leaf,
 	.tlb_add_page = __flush_iotlb_page,
-	.tlb_sync = __flush_iotlb_sync,
 };
 
 static int msm_iommu_alloc_ctx(unsigned long *map, int start, int end)
@@ -725,6 +712,13 @@ static struct iommu_ops msm_iommu_ops = {
 	.detach_dev = msm_iommu_detach_dev,
 	.map = msm_iommu_map,
 	.unmap = msm_iommu_unmap,
+	/*
+	 * Nothing is needed here, the barrier to guarantee
+	 * completion of the tlb sync operation is implicitly
+	 * taken care when the iommu client does a writel before
+	 * kick starting the other master.
+	 */
+	.iotlb_sync = NULL,
 	.iova_to_phys = msm_iommu_iova_to_phys,
 	.add_device = msm_iommu_add_device,
 	.remove_device = msm_iommu_remove_device,
diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 639c50420fc3..6dfb55014550 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -221,7 +221,6 @@ static const struct iommu_flush_ops mtk_iommu_flush_ops = {
 	.tlb_flush_walk = mtk_iommu_tlb_flush_walk,
 	.tlb_flush_leaf = mtk_iommu_tlb_flush_leaf,
 	.tlb_add_page = mtk_iommu_tlb_flush_page_nosync,
-	.tlb_sync = mtk_iommu_tlb_sync,
 };
 
 static irqreturn_t mtk_iommu_isr(int irq, void *dev_id)
diff --git a/drivers/iommu/qcom_iommu.c b/drivers/iommu/qcom_iommu.c
index ac37ced28156..fb5d6c4862b4 100644
--- a/drivers/iommu/qcom_iommu.c
+++ b/drivers/iommu/qcom_iommu.c
@@ -200,7 +200,6 @@ static const struct iommu_flush_ops qcom_flush_ops = {
 	.tlb_flush_walk = qcom_iommu_tlb_flush_walk,
 	.tlb_flush_leaf = qcom_iommu_tlb_flush_leaf,
 	.tlb_add_page	= qcom_iommu_tlb_add_page,
-	.tlb_sync	= qcom_iommu_tlb_sync,
 };
 
 static irqreturn_t qcom_iommu_fault(int irq, void *dev)
diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
index 99e04bd2baa1..843310484fe2 100644
--- a/include/linux/io-pgtable.h
+++ b/include/linux/io-pgtable.h
@@ -30,9 +30,6 @@ enum io_pgtable_fmt {
  *                  for IOMMUs that cannot batch TLB invalidation operations
  *                  efficiently and are therefore better suited to issuing them
  *                  early rather than deferring them until iommu_tlb_sync().
- * @tlb_sync:       Ensure any queued TLB invalidation has taken effect, and
- *                  any corresponding page table updates are visible to the
- *                  IOMMU.
  *
  * Note that these can all be called in atomic context and must therefore
  * not block.
@@ -44,7 +41,6 @@ struct iommu_flush_ops {
 	void (*tlb_flush_leaf)(unsigned long iova, size_t size, size_t granule,
 			       void *cookie);
 	void (*tlb_add_page)(unsigned long iova, size_t granule, void *cookie);
-	void (*tlb_sync)(void *cookie);
 };
 
 /**
@@ -218,11 +214,6 @@ io_pgtable_tlb_add_page(struct io_pgtable *iop, unsigned long iova,
 		iop->cfg.tlb->tlb_add_page(iova, granule, iop->cookie);
 }
 
-static inline void io_pgtable_tlb_sync(struct io_pgtable *iop)
-{
-	iop->cfg.tlb->tlb_sync(iop->cookie);
-}
-
 /**
  * struct io_pgtable_init_fns - Alloc/free a set of page tables for a
  *                              particular format.
-- 
2.11.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
