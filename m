Return-Path: <SRS0=3N47=YS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C91B9C47E49
	for <iommu@archiver.kernel.org>; Fri, 25 Oct 2019 18:09:10 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A43E3222C1
	for <iommu@archiver.kernel.org>; Fri, 25 Oct 2019 18:09:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A43E3222C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id A584AE1F;
	Fri, 25 Oct 2019 18:08:50 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 8B176DC2
	for <iommu@lists.linux-foundation.org>;
	Fri, 25 Oct 2019 18:08:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 02D4489C
	for <iommu@lists.linux-foundation.org>;
	Fri, 25 Oct 2019 18:08:49 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A89B4337;
	Fri, 25 Oct 2019 11:08:48 -0700 (PDT)
Received: from e110467-lin.cambridge.arm.com (e110467-lin.cambridge.arm.com
	[10.1.197.57])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0333F3F6C4; 
	Fri, 25 Oct 2019 11:08:47 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org
Subject: [PATCH v2 06/10] iommu/io-pgtable-arm: Simplify level indexing
Date: Fri, 25 Oct 2019 19:08:35 +0100
Message-Id: <698173b487383735e470a28e5cca4f9db22703de.1572024120.git.robin.murphy@arm.com>
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

The nature of the LPAE format means that data->pg_shift is always
redundant with data->bits_per_level, since they represent the size of a
page and the number of PTEs per page respectively, and the size of a PTE
is constant. Thus it works out more efficient to only store the latter,
and derive the former via a trivial addition where necessary.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/io-pgtable-arm.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 4b1483eb0ccf..15b4927ce36b 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -36,10 +36,11 @@
  * in a virtual address mapped by the pagetable in d.
  */
 #define ARM_LPAE_LVL_SHIFT(l,d)						\
-	(((ARM_LPAE_MAX_LEVELS - 1 - (l)) * (d)->bits_per_level) +	\
-	(d)->pg_shift)
+	(((ARM_LPAE_MAX_LEVELS - (l)) * (d)->bits_per_level) +		\
+	ilog2(sizeof(arm_lpae_iopte)))
 
-#define ARM_LPAE_GRANULE(d)		(1UL << (d)->pg_shift)
+#define ARM_LPAE_GRANULE(d)						\
+	(sizeof(arm_lpae_iopte) << (d)->bits_per_level)
 #define ARM_LPAE_PGD_SIZE(d)						\
 	(sizeof(arm_lpae_iopte) << (d)->pgd_bits)
 
@@ -55,9 +56,7 @@
 	 ((1 << ((d)->bits_per_level + ARM_LPAE_PGD_IDX(l,d))) - 1))
 
 /* Calculate the block/page mapping size at level l for pagetable in d. */
-#define ARM_LPAE_BLOCK_SIZE(l,d)					\
-	(1ULL << (ilog2(sizeof(arm_lpae_iopte)) +			\
-		((ARM_LPAE_MAX_LEVELS - (l)) * (d)->bits_per_level)))
+#define ARM_LPAE_BLOCK_SIZE(l,d)	(1ULL << ARM_LPAE_LVL_SHIFT(l,d))
 
 /* Page table bits */
 #define ARM_LPAE_PTE_TYPE_SHIFT		0
@@ -175,8 +174,7 @@ struct arm_lpae_io_pgtable {
 
 	int			pgd_bits;
 	int			start_level;
-	unsigned long		pg_shift;
-	unsigned long		bits_per_level;
+	int			bits_per_level;
 
 	void			*pgd;
 };
@@ -206,7 +204,7 @@ static phys_addr_t iopte_to_paddr(arm_lpae_iopte pte,
 {
 	u64 paddr = pte & ARM_LPAE_PTE_ADDR_MASK;
 
-	if (data->pg_shift < 16)
+	if (data->bits_per_level < 13) /* i.e. 64K granule */
 		return paddr;
 
 	/* Rotate the packed high-order bits back to the top */
@@ -742,9 +740,8 @@ static void arm_lpae_restrict_pgsizes(struct io_pgtable_cfg *cfg)
 static struct arm_lpae_io_pgtable *
 arm_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg)
 {
-	unsigned long va_bits;
 	struct arm_lpae_io_pgtable *data;
-	int levels;
+	int levels, va_bits, pg_shift;
 
 	arm_lpae_restrict_pgsizes(cfg);
 
@@ -766,10 +763,10 @@ arm_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg)
 	if (!data)
 		return NULL;
 
-	data->pg_shift = __ffs(cfg->pgsize_bitmap);
-	data->bits_per_level = data->pg_shift - ilog2(sizeof(arm_lpae_iopte));
+	pg_shift = __ffs(cfg->pgsize_bitmap);
+	data->bits_per_level = pg_shift - ilog2(sizeof(arm_lpae_iopte));
 
-	va_bits = cfg->ias - data->pg_shift;
+	va_bits = cfg->ias - pg_shift;
 	levels = DIV_ROUND_UP(va_bits, data->bits_per_level);
 	data->start_level = ARM_LPAE_MAX_LEVELS - levels;
 
@@ -1138,9 +1135,9 @@ static void __init arm_lpae_dump_ops(struct io_pgtable_ops *ops)
 
 	pr_err("cfg: pgsize_bitmap 0x%lx, ias %u-bit\n",
 		cfg->pgsize_bitmap, cfg->ias);
-	pr_err("data: %d levels, 0x%zx pgd_size, %lu pg_shift, %lu bits_per_level, pgd @ %p\n",
+	pr_err("data: %d levels, 0x%zx pgd_size, %u pg_shift, %u bits_per_level, pgd @ %p\n",
 		ARM_LPAE_MAX_LEVELS - data->start_level, ARM_LPAE_PGD_SIZE(data),
-		data->pg_shift, data->bits_per_level, data->pgd);
+		ilog2(ARM_LPAE_GRANULE(data)), data->bits_per_level, data->pgd);
 }
 
 #define __FAIL(ops, i)	({						\
-- 
2.21.0.dirty

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
