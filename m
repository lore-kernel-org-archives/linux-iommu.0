Return-Path: <SRS0=hcXW=7Z=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C02CCC433E1
	for <iommu@archiver.kernel.org>; Fri, 12 Jun 2020 03:40:27 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C23920884
	for <iommu@archiver.kernel.org>; Fri, 12 Jun 2020 03:40:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C23920884
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7FAA088647;
	Fri, 12 Jun 2020 03:40:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5eJRk-94vUzB; Fri, 12 Jun 2020 03:40:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 198C1885F7;
	Fri, 12 Jun 2020 03:40:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E5970C08A5;
	Fri, 12 Jun 2020 03:40:25 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 53AA2C016F
 for <iommu@lists.linux-foundation.org>; Fri, 12 Jun 2020 03:40:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 41D4A88423
 for <iommu@lists.linux-foundation.org>; Fri, 12 Jun 2020 03:40:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id n+51HECAa9VD for <iommu@lists.linux-foundation.org>;
 Fri, 12 Jun 2020 03:40:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from out30-44.freemail.mail.aliyun.com
 (out30-44.freemail.mail.aliyun.com [115.124.30.44])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 6C0568852D
 for <iommu@lists.linux-foundation.org>; Fri, 12 Jun 2020 03:40:20 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R151e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01f04427;
 MF=baolin.wang@linux.alibaba.com; NM=1; PH=DS; RN=21; SR=0;
 TI=SMTPD_---0U.K0.DD_1591933215; 
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com
 fp:SMTPD_---0U.K0.DD_1591933215) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 12 Jun 2020 11:40:15 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, agross@kernel.org,
 bjorn.andersson@linaro.org, matthias.bgg@gmail.com, robdclark@gmail.com,
 robh@kernel.org, tomeu.vizoso@collabora.com, steven.price@arm.com,
 alyssa.rosenzweig@collabora.com, airlied@linux.ie, daniel@ffwll.ch
Subject: [PATCH v2 2/2] iommu: Add gfp parameter to io_pgtable_ops->map()
Date: Fri, 12 Jun 2020 11:39:55 +0800
Message-Id: <3093df4cb95497aaf713fca623ce4ecebb197c2e.1591930156.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1591930156.git.baolin.wang@linux.alibaba.com>
References: <cover.1591930156.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <cover.1591930156.git.baolin.wang@linux.alibaba.com>
References: <cover.1591930156.git.baolin.wang@linux.alibaba.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linux-mediatek@lists.infradead.org, baolin.wang@linux.alibaba.com,
 baolin.wang7@gmail.com, linux-arm-kernel@lists.infradead.org
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

Now the ARM page tables are always allocated by GFP_ATOMIC parameter,
but the iommu_ops->map() function has been added a gfp_t parameter by
commit 781ca2de89ba ("iommu: Add gfp parameter to iommu_ops::map"),
thus io_pgtable_ops->map() should use the gfp parameter passed from
iommu_ops->map() to allocate page pages, which can avoid wasting the
memory allocators atomic pools for some non-atomic contexts.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 drivers/gpu/drm/panfrost/panfrost_mmu.c |  2 +-
 drivers/iommu/arm-smmu-v3.c             |  2 +-
 drivers/iommu/arm-smmu.c                |  2 +-
 drivers/iommu/io-pgtable-arm-v7s.c      | 18 +++++++++---------
 drivers/iommu/io-pgtable-arm.c          | 18 +++++++++---------
 drivers/iommu/ipmmu-vmsa.c              |  2 +-
 drivers/iommu/msm_iommu.c               |  2 +-
 drivers/iommu/mtk_iommu.c               |  2 +-
 drivers/iommu/qcom_iommu.c              |  2 +-
 include/linux/io-pgtable.h              |  2 +-
 10 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
index ed28aeb..5a39eee 100644
--- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
@@ -262,7 +262,7 @@ static int mmu_map_sg(struct panfrost_device *pfdev, struct panfrost_mmu *mmu,
 		while (len) {
 			size_t pgsize = get_pgsize(iova | paddr, len);
 
-			ops->map(ops, iova, paddr, pgsize, prot);
+			ops->map(ops, iova, paddr, pgsize, prot, GFP_KERNEL);
 			iova += pgsize;
 			paddr += pgsize;
 			len -= pgsize;
diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index f578677..7b59f06 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2850,7 +2850,7 @@ static int arm_smmu_map(struct iommu_domain *domain, unsigned long iova,
 	if (!ops)
 		return -ENODEV;
 
-	return ops->map(ops, iova, paddr, size, prot);
+	return ops->map(ops, iova, paddr, size, prot, gfp);
 }
 
 static size_t arm_smmu_unmap(struct iommu_domain *domain, unsigned long iova,
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 243bc4c..dc1d253 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1227,7 +1227,7 @@ static int arm_smmu_map(struct iommu_domain *domain, unsigned long iova,
 		return -ENODEV;
 
 	arm_smmu_rpm_get(smmu);
-	ret = ops->map(ops, iova, paddr, size, prot);
+	ret = ops->map(ops, iova, paddr, size, prot, gfp);
 	arm_smmu_rpm_put(smmu);
 
 	return ret;
diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
index 4272fe4..a688f22 100644
--- a/drivers/iommu/io-pgtable-arm-v7s.c
+++ b/drivers/iommu/io-pgtable-arm-v7s.c
@@ -470,7 +470,7 @@ static arm_v7s_iopte arm_v7s_install_table(arm_v7s_iopte *table,
 
 static int __arm_v7s_map(struct arm_v7s_io_pgtable *data, unsigned long iova,
 			 phys_addr_t paddr, size_t size, int prot,
-			 int lvl, arm_v7s_iopte *ptep)
+			 int lvl, arm_v7s_iopte *ptep, gfp_t gfp)
 {
 	struct io_pgtable_cfg *cfg = &data->iop.cfg;
 	arm_v7s_iopte pte, *cptep;
@@ -491,7 +491,7 @@ static int __arm_v7s_map(struct arm_v7s_io_pgtable *data, unsigned long iova,
 	/* Grab a pointer to the next level */
 	pte = READ_ONCE(*ptep);
 	if (!pte) {
-		cptep = __arm_v7s_alloc_table(lvl + 1, GFP_ATOMIC, data);
+		cptep = __arm_v7s_alloc_table(lvl + 1, gfp, data);
 		if (!cptep)
 			return -ENOMEM;
 
@@ -512,11 +512,11 @@ static int __arm_v7s_map(struct arm_v7s_io_pgtable *data, unsigned long iova,
 	}
 
 	/* Rinse, repeat */
-	return __arm_v7s_map(data, iova, paddr, size, prot, lvl + 1, cptep);
+	return __arm_v7s_map(data, iova, paddr, size, prot, lvl + 1, cptep, gfp);
 }
 
 static int arm_v7s_map(struct io_pgtable_ops *ops, unsigned long iova,
-			phys_addr_t paddr, size_t size, int prot)
+			phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
 {
 	struct arm_v7s_io_pgtable *data = io_pgtable_ops_to_data(ops);
 	struct io_pgtable *iop = &data->iop;
@@ -530,7 +530,7 @@ static int arm_v7s_map(struct io_pgtable_ops *ops, unsigned long iova,
 		    paddr >= (1ULL << data->iop.cfg.oas)))
 		return -ERANGE;
 
-	ret = __arm_v7s_map(data, iova, paddr, size, prot, 1, data->pgd);
+	ret = __arm_v7s_map(data, iova, paddr, size, prot, 1, data->pgd, gfp);
 	/*
 	 * Synchronise all PTE updates for the new mapping before there's
 	 * a chance for anything to kick off a table walk for the new iova.
@@ -922,12 +922,12 @@ static int __init arm_v7s_do_selftests(void)
 		if (ops->map(ops, iova, iova, size, IOMMU_READ |
 						    IOMMU_WRITE |
 						    IOMMU_NOEXEC |
-						    IOMMU_CACHE))
+						    IOMMU_CACHE, GFP_KERNEL))
 			return __FAIL(ops);
 
 		/* Overlapping mappings */
 		if (!ops->map(ops, iova, iova + size, size,
-			      IOMMU_READ | IOMMU_NOEXEC))
+			      IOMMU_READ | IOMMU_NOEXEC, GFP_KERNEL))
 			return __FAIL(ops);
 
 		if (ops->iova_to_phys(ops, iova + 42) != (iova + 42))
@@ -946,7 +946,7 @@ static int __init arm_v7s_do_selftests(void)
 			return __FAIL(ops);
 
 		/* Remap of partial unmap */
-		if (ops->map(ops, iova_start + size, size, size, IOMMU_READ))
+		if (ops->map(ops, iova_start + size, size, size, IOMMU_READ, GFP_KERNEL))
 			return __FAIL(ops);
 
 		if (ops->iova_to_phys(ops, iova_start + size + 42)
@@ -967,7 +967,7 @@ static int __init arm_v7s_do_selftests(void)
 			return __FAIL(ops);
 
 		/* Remap full block */
-		if (ops->map(ops, iova, iova, size, IOMMU_WRITE))
+		if (ops->map(ops, iova, iova, size, IOMMU_WRITE, GFP_KERNEL))
 			return __FAIL(ops);
 
 		if (ops->iova_to_phys(ops, iova + 42) != (iova + 42))
diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 04fbd4b..4a5a7b0 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -355,7 +355,7 @@ static arm_lpae_iopte arm_lpae_install_table(arm_lpae_iopte *table,
 
 static int __arm_lpae_map(struct arm_lpae_io_pgtable *data, unsigned long iova,
 			  phys_addr_t paddr, size_t size, arm_lpae_iopte prot,
-			  int lvl, arm_lpae_iopte *ptep)
+			  int lvl, arm_lpae_iopte *ptep, gfp_t gfp)
 {
 	arm_lpae_iopte *cptep, pte;
 	size_t block_size = ARM_LPAE_BLOCK_SIZE(lvl, data);
@@ -376,7 +376,7 @@ static int __arm_lpae_map(struct arm_lpae_io_pgtable *data, unsigned long iova,
 	/* Grab a pointer to the next level */
 	pte = READ_ONCE(*ptep);
 	if (!pte) {
-		cptep = __arm_lpae_alloc_pages(tblsz, GFP_ATOMIC, cfg);
+		cptep = __arm_lpae_alloc_pages(tblsz, gfp, cfg);
 		if (!cptep)
 			return -ENOMEM;
 
@@ -396,7 +396,7 @@ static int __arm_lpae_map(struct arm_lpae_io_pgtable *data, unsigned long iova,
 	}
 
 	/* Rinse, repeat */
-	return __arm_lpae_map(data, iova, paddr, size, prot, lvl + 1, cptep);
+	return __arm_lpae_map(data, iova, paddr, size, prot, lvl + 1, cptep, gfp);
 }
 
 static arm_lpae_iopte arm_lpae_prot_to_pte(struct arm_lpae_io_pgtable *data,
@@ -461,7 +461,7 @@ static arm_lpae_iopte arm_lpae_prot_to_pte(struct arm_lpae_io_pgtable *data,
 }
 
 static int arm_lpae_map(struct io_pgtable_ops *ops, unsigned long iova,
-			phys_addr_t paddr, size_t size, int iommu_prot)
+			phys_addr_t paddr, size_t size, int iommu_prot, gfp_t gfp)
 {
 	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
 	struct io_pgtable_cfg *cfg = &data->iop.cfg;
@@ -483,7 +483,7 @@ static int arm_lpae_map(struct io_pgtable_ops *ops, unsigned long iova,
 		return -ERANGE;
 
 	prot = arm_lpae_prot_to_pte(data, iommu_prot);
-	ret = __arm_lpae_map(data, iova, paddr, size, prot, lvl, ptep);
+	ret = __arm_lpae_map(data, iova, paddr, size, prot, lvl, ptep, gfp);
 	/*
 	 * Synchronise all PTE updates for the new mapping before there's
 	 * a chance for anything to kick off a table walk for the new iova.
@@ -1178,12 +1178,12 @@ static int __init arm_lpae_run_tests(struct io_pgtable_cfg *cfg)
 			if (ops->map(ops, iova, iova, size, IOMMU_READ |
 							    IOMMU_WRITE |
 							    IOMMU_NOEXEC |
-							    IOMMU_CACHE))
+							    IOMMU_CACHE, GFP_KERNEL))
 				return __FAIL(ops, i);
 
 			/* Overlapping mappings */
 			if (!ops->map(ops, iova, iova + size, size,
-				      IOMMU_READ | IOMMU_NOEXEC))
+				      IOMMU_READ | IOMMU_NOEXEC, GFP_KERNEL))
 				return __FAIL(ops, i);
 
 			if (ops->iova_to_phys(ops, iova + 42) != (iova + 42))
@@ -1198,7 +1198,7 @@ static int __init arm_lpae_run_tests(struct io_pgtable_cfg *cfg)
 			return __FAIL(ops, i);
 
 		/* Remap of partial unmap */
-		if (ops->map(ops, SZ_1G + size, size, size, IOMMU_READ))
+		if (ops->map(ops, SZ_1G + size, size, size, IOMMU_READ, GFP_KERNEL))
 			return __FAIL(ops, i);
 
 		if (ops->iova_to_phys(ops, SZ_1G + size + 42) != (size + 42))
@@ -1216,7 +1216,7 @@ static int __init arm_lpae_run_tests(struct io_pgtable_cfg *cfg)
 				return __FAIL(ops, i);
 
 			/* Remap full block */
-			if (ops->map(ops, iova, iova, size, IOMMU_WRITE))
+			if (ops->map(ops, iova, iova, size, IOMMU_WRITE, GFP_KERNEL))
 				return __FAIL(ops, i);
 
 			if (ops->iova_to_phys(ops, iova + 42) != (iova + 42))
diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 4c2972f..87475b2 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -687,7 +687,7 @@ static int ipmmu_map(struct iommu_domain *io_domain, unsigned long iova,
 	if (!domain)
 		return -ENODEV;
 
-	return domain->iop->map(domain->iop, iova, paddr, size, prot);
+	return domain->iop->map(domain->iop, iova, paddr, size, prot, gfp);
 }
 
 static size_t ipmmu_unmap(struct iommu_domain *io_domain, unsigned long iova,
diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index 3d8a635..12ce685 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -491,7 +491,7 @@ static int msm_iommu_map(struct iommu_domain *domain, unsigned long iova,
 	int ret;
 
 	spin_lock_irqsave(&priv->pgtlock, flags);
-	ret = priv->iop->map(priv->iop, iova, pa, len, prot);
+	ret = priv->iop->map(priv->iop, iova, pa, len, prot, GFP_ATOMIC);
 	spin_unlock_irqrestore(&priv->pgtlock, flags);
 
 	return ret;
diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 2be96f1..b7b1641 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -397,7 +397,7 @@ static int mtk_iommu_map(struct iommu_domain *domain, unsigned long iova,
 		paddr |= BIT_ULL(32);
 
 	/* Synchronize with the tlb_lock */
-	return dom->iop->map(dom->iop, iova, paddr, size, prot);
+	return dom->iop->map(dom->iop, iova, paddr, size, prot, gfp);
 }
 
 static size_t mtk_iommu_unmap(struct iommu_domain *domain,
diff --git a/drivers/iommu/qcom_iommu.c b/drivers/iommu/qcom_iommu.c
index c3e1fbd..cfcfd75 100644
--- a/drivers/iommu/qcom_iommu.c
+++ b/drivers/iommu/qcom_iommu.c
@@ -441,7 +441,7 @@ static int qcom_iommu_map(struct iommu_domain *domain, unsigned long iova,
 		return -ENODEV;
 
 	spin_lock_irqsave(&qcom_domain->pgtbl_lock, flags);
-	ret = ops->map(ops, iova, paddr, size, prot);
+	ret = ops->map(ops, iova, paddr, size, prot, GFP_ATOMIC);
 	spin_unlock_irqrestore(&qcom_domain->pgtbl_lock, flags);
 	return ret;
 }
diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
index 53d53c6..23285ba 100644
--- a/include/linux/io-pgtable.h
+++ b/include/linux/io-pgtable.h
@@ -155,7 +155,7 @@ struct io_pgtable_cfg {
  */
 struct io_pgtable_ops {
 	int (*map)(struct io_pgtable_ops *ops, unsigned long iova,
-		   phys_addr_t paddr, size_t size, int prot);
+		   phys_addr_t paddr, size_t size, int prot, gfp_t gfp);
 	size_t (*unmap)(struct io_pgtable_ops *ops, unsigned long iova,
 			size_t size, struct iommu_iotlb_gather *gather);
 	phys_addr_t (*iova_to_phys)(struct io_pgtable_ops *ops,
-- 
1.8.3.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
