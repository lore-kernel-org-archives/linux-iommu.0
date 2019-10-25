Return-Path: <SRS0=3N47=YS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F350CA9EBD
	for <iommu@archiver.kernel.org>; Fri, 25 Oct 2019 18:09:02 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25D3F22459
	for <iommu@archiver.kernel.org>; Fri, 25 Oct 2019 18:09:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25D3F22459
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 5AB2DE18;
	Fri, 25 Oct 2019 18:08:50 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 08D10DCB
	for <iommu@lists.linux-foundation.org>;
	Fri, 25 Oct 2019 18:08:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 36A9C87E
	for <iommu@lists.linux-foundation.org>;
	Fri, 25 Oct 2019 18:08:47 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD90C494;
	Fri, 25 Oct 2019 11:08:46 -0700 (PDT)
Received: from e110467-lin.cambridge.arm.com (e110467-lin.cambridge.arm.com
	[10.1.197.57])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 381A23F6C4; 
	Fri, 25 Oct 2019 11:08:46 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org
Subject: [PATCH v2 04/10] iommu/io-pgtable-arm: Simplify start level lookup
Date: Fri, 25 Oct 2019 19:08:33 +0100
Message-Id: <3ce1f4395940e5feb5d217e050f3993b3d910491.1572024120.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.21.0.dirty
In-Reply-To: <cover.1572024119.git.robin.murphy@arm.com>
References: <cover.1572024119.git.robin.murphy@arm.com>
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

Beyond a couple of allocation-time calculations, data->levels is only
ever used to derive the start level. Storing the start level directly
leads to a small reduction in object code, which should help eke out a
little more efficiency, and slightly more readable source to boot.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/io-pgtable-arm.c | 45 +++++++++++++++-------------------
 1 file changed, 20 insertions(+), 25 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index a9dff0ecf0c3..fb5d30e04001 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -31,19 +31,13 @@
 #define io_pgtable_ops_to_data(x)					\
 	io_pgtable_to_data(io_pgtable_ops_to_pgtable(x))
 
-/*
- * For consistency with the architecture, we always consider
- * ARM_LPAE_MAX_LEVELS levels, with the walk starting at level n >=0
- */
-#define ARM_LPAE_START_LVL(d)		(ARM_LPAE_MAX_LEVELS - (d)->levels)
-
 /*
  * Calculate the right shift amount to get to the portion describing level l
  * in a virtual address mapped by the pagetable in d.
  */
 #define ARM_LPAE_LVL_SHIFT(l,d)						\
-	((((d)->levels - ((l) - ARM_LPAE_START_LVL(d) + 1))		\
-	  * (d)->bits_per_level) + (d)->pg_shift)
+	(((ARM_LPAE_MAX_LEVELS - 1 - (l)) * (d)->bits_per_level) +	\
+	(d)->pg_shift)
 
 #define ARM_LPAE_GRANULE(d)		(1UL << (d)->pg_shift)
 
@@ -55,7 +49,7 @@
  * pagetable in d.
  */
 #define ARM_LPAE_PGD_IDX(l,d)						\
-	((l) == ARM_LPAE_START_LVL(d) ? ilog2(ARM_LPAE_PAGES_PER_PGD(d)) : 0)
+	((l) == (d)->start_level ? ilog2(ARM_LPAE_PAGES_PER_PGD(d)) : 0)
 
 #define ARM_LPAE_LVL_IDX(a,l,d)						\
 	(((u64)(a) >> ARM_LPAE_LVL_SHIFT(l,d)) &			\
@@ -180,7 +174,7 @@
 struct arm_lpae_io_pgtable {
 	struct io_pgtable	iop;
 
-	int			levels;
+	int			start_level;
 	size_t			pgd_size;
 	unsigned long		pg_shift;
 	unsigned long		bits_per_level;
@@ -481,7 +475,7 @@ static int arm_lpae_map(struct io_pgtable_ops *ops, unsigned long iova,
 	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
 	struct io_pgtable_cfg *cfg = &data->iop.cfg;
 	arm_lpae_iopte *ptep = data->pgd;
-	int ret, lvl = ARM_LPAE_START_LVL(data);
+	int ret, lvl = data->start_level;
 	arm_lpae_iopte prot;
 
 	/* If no access, then nothing to do */
@@ -511,7 +505,7 @@ static void __arm_lpae_free_pgtable(struct arm_lpae_io_pgtable *data, int lvl,
 	arm_lpae_iopte *start, *end;
 	unsigned long table_size;
 
-	if (lvl == ARM_LPAE_START_LVL(data))
+	if (lvl == data->start_level)
 		table_size = data->pgd_size;
 	else
 		table_size = ARM_LPAE_GRANULE(data);
@@ -540,7 +534,7 @@ static void arm_lpae_free_pgtable(struct io_pgtable *iop)
 {
 	struct arm_lpae_io_pgtable *data = io_pgtable_to_data(iop);
 
-	__arm_lpae_free_pgtable(data, ARM_LPAE_START_LVL(data), data->pgd);
+	__arm_lpae_free_pgtable(data, data->start_level, data->pgd);
 	kfree(data);
 }
 
@@ -657,7 +651,6 @@ static size_t arm_lpae_unmap(struct io_pgtable_ops *ops, unsigned long iova,
 	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
 	struct io_pgtable_cfg *cfg = &data->iop.cfg;
 	arm_lpae_iopte *ptep = data->pgd;
-	int lvl = ARM_LPAE_START_LVL(data);
 
 	if (WARN_ON(!size || (size & cfg->pgsize_bitmap) != size))
 		return 0;
@@ -665,7 +658,7 @@ static size_t arm_lpae_unmap(struct io_pgtable_ops *ops, unsigned long iova,
 	if (WARN_ON(iova >> data->iop.cfg.ias))
 		return 0;
 
-	return __arm_lpae_unmap(data, gather, iova, size, lvl, ptep);
+	return __arm_lpae_unmap(data, gather, iova, size, data->start_level, ptep);
 }
 
 static phys_addr_t arm_lpae_iova_to_phys(struct io_pgtable_ops *ops,
@@ -673,7 +666,7 @@ static phys_addr_t arm_lpae_iova_to_phys(struct io_pgtable_ops *ops,
 {
 	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
 	arm_lpae_iopte pte, *ptep = data->pgd;
-	int lvl = ARM_LPAE_START_LVL(data);
+	int lvl = data->start_level;
 
 	do {
 		/* Valid IOPTE pointer? */
@@ -752,6 +745,7 @@ arm_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg)
 {
 	unsigned long va_bits, pgd_bits;
 	struct arm_lpae_io_pgtable *data;
+	int levels;
 
 	arm_lpae_restrict_pgsizes(cfg);
 
@@ -777,10 +771,11 @@ arm_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg)
 	data->bits_per_level = data->pg_shift - ilog2(sizeof(arm_lpae_iopte));
 
 	va_bits = cfg->ias - data->pg_shift;
-	data->levels = DIV_ROUND_UP(va_bits, data->bits_per_level);
+	levels = DIV_ROUND_UP(va_bits, data->bits_per_level);
+	data->start_level = ARM_LPAE_MAX_LEVELS - levels;
 
 	/* Calculate the actual size of our pgd (without concatenation) */
-	pgd_bits = va_bits - (data->bits_per_level * (data->levels - 1));
+	pgd_bits = va_bits - (data->bits_per_level * (levels - 1));
 	data->pgd_size = 1UL << (pgd_bits + ilog2(sizeof(arm_lpae_iopte)));
 
 	data->iop.ops = (struct io_pgtable_ops) {
@@ -910,13 +905,13 @@ arm_64_lpae_alloc_pgtable_s2(struct io_pgtable_cfg *cfg, void *cookie)
 	 * Concatenate PGDs at level 1 if possible in order to reduce
 	 * the depth of the stage-2 walk.
 	 */
-	if (data->levels == ARM_LPAE_MAX_LEVELS) {
+	if (data->start_level == 0) {
 		unsigned long pgd_pages;
 
 		pgd_pages = data->pgd_size >> ilog2(sizeof(arm_lpae_iopte));
 		if (pgd_pages <= ARM_LPAE_S2_MAX_CONCAT_PAGES) {
 			data->pgd_size = pgd_pages << data->pg_shift;
-			data->levels--;
+			data->start_level++;
 		}
 	}
 
@@ -926,7 +921,7 @@ arm_64_lpae_alloc_pgtable_s2(struct io_pgtable_cfg *cfg, void *cookie)
 	     (ARM_LPAE_TCR_RGN_WBWA << ARM_LPAE_TCR_IRGN0_SHIFT) |
 	     (ARM_LPAE_TCR_RGN_WBWA << ARM_LPAE_TCR_ORGN0_SHIFT);
 
-	sl = ARM_LPAE_START_LVL(data);
+	sl = data->start_level;
 
 	switch (ARM_LPAE_GRANULE(data)) {
 	case SZ_4K:
@@ -1041,8 +1036,8 @@ arm_mali_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg, void *cookie)
 		return NULL;
 
 	/* Mali seems to need a full 4-level table regardless of IAS */
-	if (data->levels < ARM_LPAE_MAX_LEVELS) {
-		data->levels = ARM_LPAE_MAX_LEVELS;
+	if (data->start_level > 0) {
+		data->start_level = 0;
 		data->pgd_size = sizeof(arm_lpae_iopte);
 	}
 	/*
@@ -1143,8 +1138,8 @@ static void __init arm_lpae_dump_ops(struct io_pgtable_ops *ops)
 	pr_err("cfg: pgsize_bitmap 0x%lx, ias %u-bit\n",
 		cfg->pgsize_bitmap, cfg->ias);
 	pr_err("data: %d levels, 0x%zx pgd_size, %lu pg_shift, %lu bits_per_level, pgd @ %p\n",
-		data->levels, data->pgd_size, data->pg_shift,
-		data->bits_per_level, data->pgd);
+		ARM_LPAE_MAX_LEVELS - data->start_level, data->pgd_size,
+		data->pg_shift, data->bits_per_level, data->pgd);
 }
 
 #define __FAIL(ops, i)	({						\
-- 
2.21.0.dirty

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
