Return-Path: <SRS0=d8dU=JF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F40C433B4
	for <iommu@archiver.kernel.org>; Thu,  8 Apr 2021 17:14:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CA6C610CC
	for <iommu@archiver.kernel.org>; Thu,  8 Apr 2021 17:14:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CA6C610CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7AE65402B2;
	Thu,  8 Apr 2021 17:14:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6sQImJoaAR_z; Thu,  8 Apr 2021 17:14:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3D09F4011D;
	Thu,  8 Apr 2021 17:14:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1A8B0C000B;
	Thu,  8 Apr 2021 17:14:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 96B94C000A
 for <iommu@lists.linux-foundation.org>; Thu,  8 Apr 2021 17:14:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with UTF8SMTP id 7377584DC0
 for <iommu@lists.linux-foundation.org>; Thu,  8 Apr 2021 17:14:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=mg.codeaurora.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with UTF8SMTP id iLiMJHThxtoe for <iommu@lists.linux-foundation.org>;
 Thu,  8 Apr 2021 17:14:49 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from so254-9.mailgun.net (so254-9.mailgun.net [198.61.254.9])
 by smtp1.osuosl.org (Postfix) with UTF8SMTPS id 9907A83CCD
 for <iommu@lists.linux-foundation.org>; Thu,  8 Apr 2021 17:14:42 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1617902088; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=2g0Oy5rSBWi0y4qE7vNwnyy8ef3MNY/4TAsNG17pMfY=;
 b=FfDWkwzyT6P3bgOXTgvdxHBwB9QVWn4CXl39ngIfdvIil6ar7jsKyTmBYOaF2f/fsC6eRYTN
 HlmtHaP/Ysb1N3EaYoTLdUcomaLGXhuBDDe1TEtvGUoZ9WN2gX5L+ssjzRbb30RKz3Lvq5E3
 HQO0KqZy7z6RZzickZrIW1fEW+M=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 606f39ed2cc44d3aea987b01 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 08 Apr 2021 17:14:21
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 85898C43469; Thu,  8 Apr 2021 17:14:21 +0000 (UTC)
Received: from isaacm-linux.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: isaacm)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 7C8A8C43466;
 Thu,  8 Apr 2021 17:14:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7C8A8C43466
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=fail smtp.mailfrom=isaacm@codeaurora.org
From: "Isaac J. Manjarres" <isaacm@codeaurora.org>
To: iommu@lists.linux-foundation.org,
	linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH v5 10/15] iommu/io-pgtable-arm: Implement
 arm_lpae_unmap_pages()
Date: Thu,  8 Apr 2021 10:13:57 -0700
Message-Id: <20210408171402.12607-11-isaacm@codeaurora.org>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210408171402.12607-1-isaacm@codeaurora.org>
References: <20210408171402.12607-1-isaacm@codeaurora.org>
MIME-Version: 1.0
Cc: "Isaac J. Manjarres" <isaacm@codeaurora.org>, robin.murphy@arm.com,
 will@kernel.org, pratikp@codeaurora.org
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

Implement the unmap_pages() callback for the ARM LPAE io-pgtable
format.

Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
Suggested-by: Will Deacon <will@kernel.org>
---
 drivers/iommu/io-pgtable-arm.c | 75 ++++++++++++++++++++++------------
 1 file changed, 49 insertions(+), 26 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index ea66b10c04c4..1b690911995a 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -46,6 +46,9 @@
 #define ARM_LPAE_PGD_SIZE(d)						\
 	(sizeof(arm_lpae_iopte) << (d)->pgd_bits)
 
+#define ARM_LPAE_PTES_PER_TABLE(d)					\
+	(ARM_LPAE_GRANULE(d) >> ilog2(sizeof(arm_lpae_iopte)))
+
 /*
  * Calculate the index at level l used to map virtual address a using the
  * pagetable in d.
@@ -253,8 +256,8 @@ static void __arm_lpae_set_pte(arm_lpae_iopte *ptep, arm_lpae_iopte pte,
 
 static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
 			       struct iommu_iotlb_gather *gather,
-			       unsigned long iova, size_t size, int lvl,
-			       arm_lpae_iopte *ptep);
+			       unsigned long iova, size_t size, size_t pgcount,
+			       int lvl, arm_lpae_iopte *ptep);
 
 static void __arm_lpae_init_pte(struct arm_lpae_io_pgtable *data,
 				phys_addr_t paddr, arm_lpae_iopte prot,
@@ -298,7 +301,7 @@ static int arm_lpae_init_pte(struct arm_lpae_io_pgtable *data,
 			size_t sz = ARM_LPAE_BLOCK_SIZE(lvl, data);
 
 			tblp = ptep - ARM_LPAE_LVL_IDX(iova, lvl, data);
-			if (__arm_lpae_unmap(data, NULL, iova + i * sz, sz,
+			if (__arm_lpae_unmap(data, NULL, iova + i * sz, sz, 1,
 					     lvl, tblp) != sz) {
 				WARN_ON(1);
 				return -EINVAL;
@@ -526,14 +529,15 @@ static size_t arm_lpae_split_blk_unmap(struct arm_lpae_io_pgtable *data,
 				       struct iommu_iotlb_gather *gather,
 				       unsigned long iova, size_t size,
 				       arm_lpae_iopte blk_pte, int lvl,
-				       arm_lpae_iopte *ptep)
+				       arm_lpae_iopte *ptep, size_t pgcount)
 {
 	struct io_pgtable_cfg *cfg = &data->iop.cfg;
 	arm_lpae_iopte pte, *tablep;
 	phys_addr_t blk_paddr;
 	size_t tablesz = ARM_LPAE_GRANULE(data);
 	size_t split_sz = ARM_LPAE_BLOCK_SIZE(lvl, data);
-	int i, unmap_idx = -1;
+	int ptes_per_table = ARM_LPAE_PTES_PER_TABLE(data);
+	int i, unmap_idx_start = -1, num_entries = 0, max_entries;
 
 	if (WARN_ON(lvl == ARM_LPAE_MAX_LEVELS))
 		return 0;
@@ -542,15 +546,18 @@ static size_t arm_lpae_split_blk_unmap(struct arm_lpae_io_pgtable *data,
 	if (!tablep)
 		return 0; /* Bytes unmapped */
 
-	if (size == split_sz)
-		unmap_idx = ARM_LPAE_LVL_IDX(iova, lvl, data);
+	if (size == split_sz) {
+		unmap_idx_start = ARM_LPAE_LVL_IDX(iova, lvl, data);
+		max_entries = ptes_per_table - unmap_idx_start;
+		num_entries = min_t(int, pgcount, max_entries);
+	}
 
 	blk_paddr = iopte_to_paddr(blk_pte, data);
 	pte = iopte_prot(blk_pte);
 
-	for (i = 0; i < tablesz / sizeof(pte); i++, blk_paddr += split_sz) {
+	for (i = 0; i < ptes_per_table; i++, blk_paddr += split_sz) {
 		/* Unmap! */
-		if (i == unmap_idx)
+		if (i >= unmap_idx_start && i < (unmap_idx_start + num_entries))
 			continue;
 
 		__arm_lpae_init_pte(data, blk_paddr, pte, lvl, 1, &tablep[i]);
@@ -568,38 +575,44 @@ static size_t arm_lpae_split_blk_unmap(struct arm_lpae_io_pgtable *data,
 			return 0;
 
 		tablep = iopte_deref(pte, data);
-	} else if (unmap_idx >= 0) {
-		io_pgtable_tlb_add_page(&data->iop, gather, iova, size);
-		return size;
+	} else if (unmap_idx_start >= 0) {
+		for (i = 0; i < num_entries; i++)
+			io_pgtable_tlb_add_page(&data->iop, gather, iova + i * size, size);
+
+		return num_entries * size;
 	}
 
-	return __arm_lpae_unmap(data, gather, iova, size, lvl, tablep);
+	return __arm_lpae_unmap(data, gather, iova, size, pgcount, lvl, tablep);
 }
 
 static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
 			       struct iommu_iotlb_gather *gather,
-			       unsigned long iova, size_t size, int lvl,
-			       arm_lpae_iopte *ptep)
+			       unsigned long iova, size_t size, size_t pgcount,
+			       int lvl, arm_lpae_iopte *ptep)
 {
 	arm_lpae_iopte pte;
 	struct io_pgtable *iop = &data->iop;
+	int i, num_entries, max_entries, unmap_idx_start;
 
 	/* Something went horribly wrong and we ran out of page table */
 	if (WARN_ON(lvl == ARM_LPAE_MAX_LEVELS))
 		return 0;
 
-	ptep += ARM_LPAE_LVL_IDX(iova, lvl, data);
+	unmap_idx_start = ARM_LPAE_LVL_IDX(iova, lvl, data);
+	ptep += unmap_idx_start;
 	pte = READ_ONCE(*ptep);
 	if (WARN_ON(!pte))
 		return 0;
 
 	/* If the size matches this level, we're in the right place */
 	if (size == ARM_LPAE_BLOCK_SIZE(lvl, data)) {
-		__arm_lpae_set_pte(ptep, 0, 1, &iop->cfg);
+		max_entries = ARM_LPAE_PTES_PER_TABLE(data) - unmap_idx_start;
+		num_entries = min_t(int, pgcount, max_entries);
+		__arm_lpae_set_pte(ptep, 0, num_entries, &iop->cfg);
 
 		if (!iopte_leaf(pte, lvl, iop->fmt)) {
 			/* Also flush any partial walks */
-			io_pgtable_tlb_flush_walk(iop, iova, size,
+			io_pgtable_tlb_flush_walk(iop, iova, num_entries * size,
 						  ARM_LPAE_GRANULE(data));
 			ptep = iopte_deref(pte, data);
 			__arm_lpae_free_pgtable(data, lvl + 1, ptep);
@@ -611,33 +624,35 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
 			 */
 			smp_wmb();
 		} else {
-			io_pgtable_tlb_add_page(iop, gather, iova, size);
+			for (i = 0; i < num_entries; i++)
+				io_pgtable_tlb_add_page(iop, gather, iova + i * size, size);
 		}
 
-		return size;
+		return num_entries * size;
 	} else if (iopte_leaf(pte, lvl, iop->fmt)) {
 		/*
 		 * Insert a table at the next level to map the old region,
 		 * minus the part we want to unmap
 		 */
 		return arm_lpae_split_blk_unmap(data, gather, iova, size, pte,
-						lvl + 1, ptep);
+						lvl + 1, ptep, pgcount);
 	}
 
 	/* Keep on walkin' */
 	ptep = iopte_deref(pte, data);
-	return __arm_lpae_unmap(data, gather, iova, size, lvl + 1, ptep);
+	return __arm_lpae_unmap(data, gather, iova, size, pgcount, lvl + 1, ptep);
 }
 
-static size_t arm_lpae_unmap(struct io_pgtable_ops *ops, unsigned long iova,
-			     size_t size, struct iommu_iotlb_gather *gather)
+static size_t arm_lpae_unmap_pages(struct io_pgtable_ops *ops, unsigned long iova,
+				   size_t pgsize, size_t pgcount,
+				   struct iommu_iotlb_gather *gather)
 {
 	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
 	struct io_pgtable_cfg *cfg = &data->iop.cfg;
 	arm_lpae_iopte *ptep = data->pgd;
 	long iaext = (s64)iova >> cfg->ias;
 
-	if (WARN_ON(!size || (size & cfg->pgsize_bitmap) != size))
+	if (WARN_ON(!pgsize || (pgsize & cfg->pgsize_bitmap) != pgsize || !pgcount))
 		return 0;
 
 	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_TTBR1)
@@ -645,7 +660,14 @@ static size_t arm_lpae_unmap(struct io_pgtable_ops *ops, unsigned long iova,
 	if (WARN_ON(iaext))
 		return 0;
 
-	return __arm_lpae_unmap(data, gather, iova, size, data->start_level, ptep);
+	return __arm_lpae_unmap(data, gather, iova, pgsize, pgcount,
+				data->start_level, ptep);
+}
+
+static size_t arm_lpae_unmap(struct io_pgtable_ops *ops, unsigned long iova,
+			     size_t size, struct iommu_iotlb_gather *gather)
+{
+	return arm_lpae_unmap_pages(ops, iova, size, 1, gather);
 }
 
 static phys_addr_t arm_lpae_iova_to_phys(struct io_pgtable_ops *ops,
@@ -761,6 +783,7 @@ arm_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg)
 	data->iop.ops = (struct io_pgtable_ops) {
 		.map		= arm_lpae_map,
 		.unmap		= arm_lpae_unmap,
+		.unmap_pages	= arm_lpae_unmap_pages,
 		.iova_to_phys	= arm_lpae_iova_to_phys,
 	};
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
