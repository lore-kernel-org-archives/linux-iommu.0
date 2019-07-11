Return-Path: <SRS0=Q5U9=VI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 877BDC74A5B
	for <iommu@archiver.kernel.org>; Thu, 11 Jul 2019 17:29:56 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DE8420863
	for <iommu@archiver.kernel.org>; Thu, 11 Jul 2019 17:29:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yColmb1S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DE8420863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id BAE1C5475;
	Thu, 11 Jul 2019 17:28:56 +0000 (UTC)
Received: from smtp2.linuxfoundation.org (smtp2.linux-foundation.org
	[172.17.192.36])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 2C157547D
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Jul 2019 17:20:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp2.linuxfoundation.org (Postfix) with ESMTPS id 8265F1DCF0
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Jul 2019 17:20:17 +0000 (UTC)
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa
	[217.169.31.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 3985021537;
	Thu, 11 Jul 2019 17:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562865617;
	bh=IHxHRwEN+eJLOevqPUqoXCwGJ1nWqk+WR5T6kGnN6/U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yColmb1Sd3pk9e5y0l44cGhvH3nLdbe+Rz+T1//B+nYlSOodTtE4pZOUMitKa4LDb
	fp/O2yMQ2vzGAmvNjMUYAELsu+j85IafTWhtg7Pujy/K5Ao2zcGSbxf+g0KnPcjfIA
	XtZjB7cZrB9CjhuRNwE36PGdCX8HNv+HU6aGthxs=
From: Will Deacon <will@kernel.org>
To: iommu@lists.linux-foundation.org
Subject: [RFC PATCH v2 12/19] iommu/io-pgtable: Pass struct iommu_iotlb_gather
	to ->unmap()
Date: Thu, 11 Jul 2019 18:19:20 +0100
Message-Id: <20190711171927.28803-13-will@kernel.org>
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

Update the io-pgtable ->unmap() function to take an iommu_iotlb_gather
pointer as an argument, and update the callers as appropriate.

Signed-off-by: Will Deacon <will@kernel.org>
---
 drivers/gpu/drm/panfrost/panfrost_mmu.c | 2 +-
 drivers/iommu/arm-smmu-v3.c             | 2 +-
 drivers/iommu/arm-smmu.c                | 2 +-
 drivers/iommu/io-pgtable-arm-v7s.c      | 6 +++---
 drivers/iommu/io-pgtable-arm.c          | 7 +++----
 drivers/iommu/ipmmu-vmsa.c              | 2 +-
 drivers/iommu/msm_iommu.c               | 2 +-
 drivers/iommu/mtk_iommu.c               | 2 +-
 drivers/iommu/qcom_iommu.c              | 2 +-
 include/linux/io-pgtable.h              | 4 +++-
 10 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
index 8241656adc98..b2e49f26667d 100644
--- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
@@ -215,7 +215,7 @@ void panfrost_mmu_unmap(struct panfrost_gem_object *bo)
 		size_t unmapped_page;
 		size_t pgsize = get_pgsize(iova, len - unmapped_len);
 
-		unmapped_page = ops->unmap(ops, iova, pgsize);
+		unmapped_page = ops->unmap(ops, iova, pgsize, NULL);
 		if (!unmapped_page)
 			break;
 
diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index a245c9e16077..8743f76245d8 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2006,7 +2006,7 @@ static size_t arm_smmu_unmap(struct iommu_domain *domain, unsigned long iova,
 	if (!ops)
 		return 0;
 
-	ret = ops->unmap(ops, iova, size);
+	ret = ops->unmap(ops, iova, size, gather);
 	if (ret && arm_smmu_atc_inv_domain(smmu_domain, 0, iova, size))
 		return 0;
 
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 28da70972b1b..131985a5092c 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1365,7 +1365,7 @@ static size_t arm_smmu_unmap(struct iommu_domain *domain, unsigned long iova,
 		return 0;
 
 	arm_smmu_rpm_get(smmu);
-	ret = ops->unmap(ops, iova, size);
+	ret = ops->unmap(ops, iova, size, gather);
 	arm_smmu_rpm_put(smmu);
 
 	return ret;
diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
index 5a4a534c2782..c2a9c2a59f34 100644
--- a/drivers/iommu/io-pgtable-arm-v7s.c
+++ b/drivers/iommu/io-pgtable-arm-v7s.c
@@ -677,7 +677,7 @@ static size_t __arm_v7s_unmap(struct arm_v7s_io_pgtable *data,
 }
 
 static size_t arm_v7s_unmap(struct io_pgtable_ops *ops, unsigned long iova,
-			    size_t size)
+			    size_t size, struct iommu_iotlb_gather *gather)
 {
 	struct arm_v7s_io_pgtable *data = io_pgtable_ops_to_data(ops);
 
@@ -903,7 +903,7 @@ static int __init arm_v7s_do_selftests(void)
 	size = 1UL << __ffs(cfg.pgsize_bitmap);
 	while (i < loopnr) {
 		iova_start = i * SZ_16M;
-		if (ops->unmap(ops, iova_start + size, size) != size)
+		if (ops->unmap(ops, iova_start + size, size, NULL) != size)
 			return __FAIL(ops);
 
 		/* Remap of partial unmap */
@@ -921,7 +921,7 @@ static int __init arm_v7s_do_selftests(void)
 	for_each_set_bit(i, &cfg.pgsize_bitmap, BITS_PER_LONG) {
 		size = 1UL << i;
 
-		if (ops->unmap(ops, iova, size) != size)
+		if (ops->unmap(ops, iova, size, NULL) != size)
 			return __FAIL(ops);
 
 		if (ops->iova_to_phys(ops, iova + 42))
diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 6fb83910bac5..455b3a07bd61 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -23,7 +23,6 @@
 #include <linux/atomic.h>
 #include <linux/bitops.h>
 #include <linux/io-pgtable.h>
-#include <linux/iommu.h>
 #include <linux/kernel.h>
 #include <linux/sizes.h>
 #include <linux/slab.h>
@@ -653,7 +652,7 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
 }
 
 static size_t arm_lpae_unmap(struct io_pgtable_ops *ops, unsigned long iova,
-			     size_t size)
+			     size_t size, struct iommu_iotlb_gather *gather)
 {
 	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
 	arm_lpae_iopte *ptep = data->pgd;
@@ -1178,7 +1177,7 @@ static int __init arm_lpae_run_tests(struct io_pgtable_cfg *cfg)
 
 		/* Partial unmap */
 		size = 1UL << __ffs(cfg->pgsize_bitmap);
-		if (ops->unmap(ops, SZ_1G + size, size) != size)
+		if (ops->unmap(ops, SZ_1G + size, size, NULL) != size)
 			return __FAIL(ops, i);
 
 		/* Remap of partial unmap */
@@ -1193,7 +1192,7 @@ static int __init arm_lpae_run_tests(struct io_pgtable_cfg *cfg)
 		for_each_set_bit(j, &cfg->pgsize_bitmap, BITS_PER_LONG) {
 			size = 1UL << j;
 
-			if (ops->unmap(ops, iova, size) != size)
+			if (ops->unmap(ops, iova, size, NULL) != size)
 				return __FAIL(ops, i);
 
 			if (ops->iova_to_phys(ops, iova + 42))
diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 651c3cf7b124..b619a3b0886d 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -723,7 +723,7 @@ static size_t ipmmu_unmap(struct iommu_domain *io_domain, unsigned long iova,
 {
 	struct ipmmu_vmsa_domain *domain = to_vmsa_domain(io_domain);
 
-	return domain->iop->unmap(domain->iop, iova, size);
+	return domain->iop->unmap(domain->iop, iova, size, gather);
 }
 
 static void ipmmu_flush_iotlb_all(struct iommu_domain *io_domain)
diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index d9c3d1816a29..fc2d21b8c1f8 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -536,7 +536,7 @@ static size_t msm_iommu_unmap(struct iommu_domain *domain, unsigned long iova,
 	unsigned long flags;
 
 	spin_lock_irqsave(&priv->pgtlock, flags);
-	len = priv->iop->unmap(priv->iop, iova, len);
+	len = priv->iop->unmap(priv->iop, iova, len, gather);
 	spin_unlock_irqrestore(&priv->pgtlock, flags);
 
 	return len;
diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 6dfb55014550..bf1516930d74 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -408,7 +408,7 @@ static size_t mtk_iommu_unmap(struct iommu_domain *domain,
 	size_t unmapsz;
 
 	spin_lock_irqsave(&dom->pgtlock, flags);
-	unmapsz = dom->iop->unmap(dom->iop, iova, size);
+	unmapsz = dom->iop->unmap(dom->iop, iova, size, gather);
 	spin_unlock_irqrestore(&dom->pgtlock, flags);
 
 	return unmapsz;
diff --git a/drivers/iommu/qcom_iommu.c b/drivers/iommu/qcom_iommu.c
index fb5d6c4862b4..08f4969fea39 100644
--- a/drivers/iommu/qcom_iommu.c
+++ b/drivers/iommu/qcom_iommu.c
@@ -466,7 +466,7 @@ static size_t qcom_iommu_unmap(struct iommu_domain *domain, unsigned long iova,
 	 */
 	pm_runtime_get_sync(qcom_domain->iommu->dev);
 	spin_lock_irqsave(&qcom_domain->pgtbl_lock, flags);
-	ret = ops->unmap(ops, iova, size);
+	ret = ops->unmap(ops, iova, size, gather);
 	spin_unlock_irqrestore(&qcom_domain->pgtbl_lock, flags);
 	pm_runtime_put_sync(qcom_domain->iommu->dev);
 
diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
index 843310484fe2..fe27d93c8ad9 100644
--- a/include/linux/io-pgtable.h
+++ b/include/linux/io-pgtable.h
@@ -1,7 +1,9 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef __IO_PGTABLE_H
 #define __IO_PGTABLE_H
+
 #include <linux/bitops.h>
+#include <linux/iommu.h>
 
 /*
  * Public API for use by IOMMU drivers
@@ -136,7 +138,7 @@ struct io_pgtable_ops {
 	int (*map)(struct io_pgtable_ops *ops, unsigned long iova,
 		   phys_addr_t paddr, size_t size, int prot);
 	size_t (*unmap)(struct io_pgtable_ops *ops, unsigned long iova,
-			size_t size);
+			size_t size, struct iommu_iotlb_gather *gather);
 	phys_addr_t (*iova_to_phys)(struct io_pgtable_ops *ops,
 				    unsigned long iova);
 };
-- 
2.11.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
