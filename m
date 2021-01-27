Return-Path: <SRS0=KfvE=G6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 948C8C433E0
	for <iommu@archiver.kernel.org>; Wed, 27 Jan 2021 20:00:59 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 534CB64DA3
	for <iommu@archiver.kernel.org>; Wed, 27 Jan 2021 20:00:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 534CB64DA3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id F204F231A0;
	Wed, 27 Jan 2021 20:00:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wfO9lTL3LzIM; Wed, 27 Jan 2021 20:00:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 009AA23100;
	Wed, 27 Jan 2021 20:00:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DEA6BC08A1;
	Wed, 27 Jan 2021 20:00:57 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 079DAC013A
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 20:00:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id D0AEF22D22
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 20:00:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bhHDwZjKljKi for <iommu@lists.linux-foundation.org>;
 Wed, 27 Jan 2021 20:00:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id 3E09C23120
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 20:00:55 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id F286564DA4;
 Wed, 27 Jan 2021 20:00:53 +0000 (UTC)
Subject: [PATCH RFC 5/9] iommu/io-pgtable-arm: Hook up map_sg()
From: Chuck Lever <chuck.lever@oracle.com>
To: baolu.lu@linux.intel.com
Date: Wed, 27 Jan 2021 15:00:53 -0500
Message-ID: <161177765310.1311.13604114123927933039.stgit@manet.1015granger.net>
In-Reply-To: <161177711359.1311.417185373365934204.stgit@manet.1015granger.net>
References: <161177711359.1311.417185373365934204.stgit@manet.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Cc: isaacm@codeaurora.org, robin.murphy@arm.com,
 iommu@lists.linux-foundation.org, will@kernel.org
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

From: Isaac J. Manjarres <isaacm@codeaurora.org>

Implement the map_sg io-pgtable op for the ARM LPAE io-pgtable
code, so that IOMMU drivers can call it when they need to map
a scatter-gather list.

Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
Tested-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 drivers/iommu/io-pgtable-arm.c |   86 ++++++++++++++++++++++++++++++++++++++++
 drivers/iommu/iommu.c          |   12 +++---
 include/linux/iommu.h          |    8 ++++
 3 files changed, 101 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 87def58e79b5..0c11529442b8 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -473,6 +473,91 @@ static int arm_lpae_map(struct io_pgtable_ops *ops, unsigned long iova,
 	return ret;
 }
 
+static int arm_lpae_map_by_pgsize(struct io_pgtable_ops *ops,
+				  unsigned long iova, phys_addr_t paddr,
+				  size_t size, int iommu_prot, gfp_t gfp,
+				  size_t *mapped)
+{
+	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
+	struct io_pgtable_cfg *cfg = &data->iop.cfg;
+	arm_lpae_iopte *ptep = data->pgd;
+	int ret, lvl = data->start_level;
+	arm_lpae_iopte prot = arm_lpae_prot_to_pte(data, iommu_prot);
+	unsigned int min_pagesz = 1 << __ffs(cfg->pgsize_bitmap);
+	long iaext = (s64)(iova + size - 1) >> cfg->ias;
+	size_t pgsize;
+
+	if (!IS_ALIGNED(iova | paddr | size, min_pagesz)) {
+		pr_err("unaligned: iova 0x%lx pa %pa size 0x%zx min_pagesz 0x%x\n",
+		       iova, &paddr, size, min_pagesz);
+		return -EINVAL;
+	}
+
+	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_TTBR1)
+		iaext = ~iaext;
+	if (WARN_ON(iaext || (paddr + size - 1) >> cfg->oas))
+		return -ERANGE;
+
+	while (size) {
+		pgsize = iommu_pgsize(cfg->pgsize_bitmap, iova | paddr, size);
+		ret = __arm_lpae_map(data, iova, paddr, pgsize, prot, lvl, ptep,
+				     gfp);
+		if (ret)
+			return ret;
+
+		iova += pgsize;
+		paddr += pgsize;
+		*mapped += pgsize;
+		size -= pgsize;
+	}
+
+	return 0;
+}
+
+static int arm_lpae_map_sg(struct io_pgtable_ops *ops, unsigned long iova,
+			   struct scatterlist *sg, unsigned int nents,
+			   int iommu_prot, gfp_t gfp, size_t *mapped)
+{
+
+	size_t len = 0;
+	unsigned int i = 0;
+	int ret;
+	phys_addr_t start;
+
+	*mapped = 0;
+
+	/* If no access, then nothing to do */
+	if (!(iommu_prot & (IOMMU_READ | IOMMU_WRITE)))
+		return 0;
+
+	while (i <= nents) {
+		phys_addr_t s_phys = sg_phys(sg);
+
+		if (len && s_phys != start + len) {
+			ret = arm_lpae_map_by_pgsize(ops, iova + *mapped, start,
+						     len, iommu_prot, gfp,
+						     mapped);
+
+			if (ret)
+				return ret;
+
+			len = 0;
+		}
+
+		if (len) {
+			len += sg->length;
+		} else {
+			len = sg->length;
+			start = s_phys;
+		}
+
+		if (++i < nents)
+			sg = sg_next(sg);
+	}
+
+	return 0;
+}
+
 static void __arm_lpae_free_pgtable(struct arm_lpae_io_pgtable *data, int lvl,
 				    arm_lpae_iopte *ptep)
 {
@@ -750,6 +835,7 @@ arm_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg)
 
 	data->iop.ops = (struct io_pgtable_ops) {
 		.map		= arm_lpae_map,
+		.map_sg		= arm_lpae_map_sg,
 		.unmap		= arm_lpae_unmap,
 		.iova_to_phys	= arm_lpae_iova_to_phys,
 	};
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 3d099a31ddca..ed879a4d7fac 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2346,8 +2346,8 @@ phys_addr_t iommu_iova_to_phys(struct iommu_domain *domain, dma_addr_t iova)
 }
 EXPORT_SYMBOL_GPL(iommu_iova_to_phys);
 
-static size_t iommu_pgsize(struct iommu_domain *domain,
-			   unsigned long addr_merge, size_t size)
+size_t iommu_pgsize(unsigned long pgsize_bitmap, unsigned long addr_merge,
+		    size_t size)
 {
 	unsigned int pgsize_idx;
 	size_t pgsize;
@@ -2366,7 +2366,7 @@ static size_t iommu_pgsize(struct iommu_domain *domain,
 	pgsize = (1UL << (pgsize_idx + 1)) - 1;
 
 	/* throw away page sizes not supported by the hardware */
-	pgsize &= domain->pgsize_bitmap;
+	pgsize &= pgsize_bitmap;
 
 	/* make sure we're still sane */
 	BUG_ON(!pgsize);
@@ -2412,7 +2412,8 @@ static int __iommu_map(struct iommu_domain *domain, unsigned long iova,
 	pr_debug("map: iova 0x%lx pa %pa size 0x%zx\n", iova, &paddr, size);
 
 	while (size) {
-		size_t pgsize = iommu_pgsize(domain, iova | paddr, size);
+		size_t pgsize = iommu_pgsize(domain->pgsize_bitmap,
+					     iova | paddr, size);
 
 		pr_debug("mapping: iova 0x%lx pa %pa pgsize 0x%zx\n",
 			 iova, &paddr, pgsize);
@@ -2500,7 +2501,8 @@ static size_t __iommu_unmap(struct iommu_domain *domain,
 	 * or we hit an area that isn't mapped.
 	 */
 	while (unmapped < size) {
-		size_t pgsize = iommu_pgsize(domain, iova, size - unmapped);
+		size_t pgsize = iommu_pgsize(domain->pgsize_bitmap, iova,
+					     size - unmapped);
 
 		unmapped_page = ops->unmap(domain, iova, pgsize, iotlb_gather);
 		if (!unmapped_page)
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 9ce0aa9e236b..cd5f35022a25 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -439,6 +439,8 @@ extern int iommu_sva_unbind_gpasid(struct iommu_domain *domain,
 				   struct device *dev, ioasid_t pasid);
 extern struct iommu_domain *iommu_get_domain_for_dev(struct device *dev);
 extern struct iommu_domain *iommu_get_dma_domain(struct device *dev);
+extern size_t iommu_pgsize(unsigned long pgsize_bitmap, unsigned long addr_mer,
+			   size_t size);
 extern int iommu_map(struct iommu_domain *domain, unsigned long iova,
 		     phys_addr_t paddr, size_t size, int prot);
 extern int iommu_map_atomic(struct iommu_domain *domain, unsigned long iova,
@@ -691,6 +693,12 @@ static inline struct iommu_domain *iommu_get_domain_for_dev(struct device *dev)
 	return NULL;
 }
 
+static inline size_t iommu_pgsize(unsigned long pgsize_bitmap,
+				  unsigned long addr_merge, size_t size)
+{
+	return 0;
+}
+
 static inline int iommu_map(struct iommu_domain *domain, unsigned long iova,
 			    phys_addr_t paddr, size_t size, int prot)
 {


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
