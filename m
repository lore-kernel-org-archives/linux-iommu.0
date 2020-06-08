Return-Path: <SRS0=28v9=7V=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3849CC433E0
	for <iommu@archiver.kernel.org>; Mon,  8 Jun 2020 03:39:15 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 134652077D
	for <iommu@archiver.kernel.org>; Mon,  8 Jun 2020 03:39:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 134652077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id E97FC87D89;
	Mon,  8 Jun 2020 03:39:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id X2W-oHWIOtzw; Mon,  8 Jun 2020 03:39:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 216D787CB8;
	Mon,  8 Jun 2020 03:39:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0DB9EC07FF;
	Mon,  8 Jun 2020 03:39:14 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2B5FBC016F
 for <iommu@lists.linux-foundation.org>; Mon,  8 Jun 2020 03:39:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 1B34D87CB8
 for <iommu@lists.linux-foundation.org>; Mon,  8 Jun 2020 03:39:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id F6ZatVP-1x-9 for <iommu@lists.linux-foundation.org>;
 Mon,  8 Jun 2020 03:39:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from out30-130.freemail.mail.aliyun.com
 (out30-130.freemail.mail.aliyun.com [115.124.30.130])
 by hemlock.osuosl.org (Postfix) with ESMTPS id D43D787CD2
 for <iommu@lists.linux-foundation.org>; Mon,  8 Jun 2020 03:39:10 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R141e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04407;
 MF=baolin.wang@linux.alibaba.com; NM=1; PH=DS; RN=20; SR=0;
 TI=SMTPD_---0U-sNP4Y_1591587544; 
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com
 fp:SMTPD_---0U-sNP4Y_1591587544) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 08 Jun 2020 11:39:05 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, agross@kernel.org,
 bjorn.andersson@linaro.org, matthias.bgg@gmail.com, robdclark@gmail.com,
 robh@kernel.org, tomeu.vizoso@collabora.com, steven.price@arm.com,
 alyssa.rosenzweig@collabora.com, airlied@linux.ie, daniel@ffwll.ch
Subject: [PATCH 2/2] iommu: Add gfp parameter to io_pgtable_ops->map()
Date: Mon,  8 Jun 2020 11:38:41 +0800
Message-Id: <837d7131e83b06ce222bda678fe2e8ac7ba095f2.1591587029.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1591587029.git.baolin.wang@linux.alibaba.com>
References: <cover.1591587029.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <cover.1591587029.git.baolin.wang@linux.alibaba.com>
References: <cover.1591587029.git.baolin.wang@linux.alibaba.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linux-mediatek@lists.infradead.org, baolin.wang@linux.alibaba.com,
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
 drivers/iommu/io-pgtable-arm-v7s.c      | 10 +++++-----
 drivers/iommu/io-pgtable-arm.c          | 10 +++++-----
 drivers/iommu/ipmmu-vmsa.c              |  2 +-
 drivers/iommu/msm_iommu.c               |  2 +-
 drivers/iommu/mtk_iommu.c               |  2 +-
 drivers/iommu/qcom_iommu.c              |  2 +-
 include/linux/io-pgtable.h              |  2 +-
 10 files changed, 18 insertions(+), 18 deletions(-)

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
index 8250873..433b680 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2845,7 +2845,7 @@ static int arm_smmu_map(struct iommu_domain *domain, unsigned long iova,
 	if (!ops)
 		return -ENODEV;
 
-	return ops->map(ops, iova, paddr, size, prot);
+	return ops->map(ops, iova, paddr, size, prot, gfp);
 }
 
 static size_t arm_smmu_unmap(struct iommu_domain *domain, unsigned long iova,
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index a6a5796..bf640aa 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1237,7 +1237,7 @@ static int arm_smmu_map(struct iommu_domain *domain, unsigned long iova,
 		return -ENODEV;
 
 	arm_smmu_rpm_get(smmu);
-	ret = ops->map(ops, iova, paddr, size, prot);
+	ret = ops->map(ops, iova, paddr, size, prot, gfp);
 	arm_smmu_rpm_put(smmu);
 
 	return ret;
diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
index 4272fe4..ebbe2c5 100644
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
diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 04fbd4b..3ced132 100644
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
diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 310cf09..391d7f1 100644
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
index 94a6df1..f3057f9 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -511,7 +511,7 @@ static int msm_iommu_map(struct iommu_domain *domain, unsigned long iova,
 	int ret;
 
 	spin_lock_irqsave(&priv->pgtlock, flags);
-	ret = priv->iop->map(priv->iop, iova, pa, len, prot);
+	ret = priv->iop->map(priv->iop, iova, pa, len, prot, GFP_ATOMIC);
 	spin_unlock_irqrestore(&priv->pgtlock, flags);
 
 	return ret;
diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 5f4d6df..1593801 100644
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
index 5b3b270..2c4c5d7 100644
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
