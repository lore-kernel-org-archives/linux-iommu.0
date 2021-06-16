Return-Path: <SRS0=eGnl=LK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A43C48BE8
	for <iommu@archiver.kernel.org>; Wed, 16 Jun 2021 13:39:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AC2E6135C
	for <iommu@archiver.kernel.org>; Wed, 16 Jun 2021 13:39:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AC2E6135C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D619B60AAB;
	Wed, 16 Jun 2021 13:39:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BN899JiPmhL5; Wed, 16 Jun 2021 13:39:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9B9C460A8E;
	Wed, 16 Jun 2021 13:39:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4BFC7C0026;
	Wed, 16 Jun 2021 13:39:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A99BBC000B
 for <iommu@lists.linux-foundation.org>; Wed, 16 Jun 2021 13:39:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1FD8183B1D
 for <iommu@lists.linux-foundation.org>; Wed, 16 Jun 2021 13:39:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=quicinc.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oq78yUU49YFJ for <iommu@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 13:39:13 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com
 [199.106.114.39])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 393B883868
 for <iommu@lists.linux-foundation.org>; Wed, 16 Jun 2021 13:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1623850753; x=1655386753;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version;
 bh=ZgPeTZPfjOpXgnvKbqS9xE+8IKVSPSdpTVeE7AfikNs=;
 b=ua3tx8UwN5HalnLWnF2T8+F6+gZ1JziFEFy2HEMMXBQoEjrQ0ZaDLNp8
 oK2m+xOkRearc26s6Ks3luktNhI/dyIkjLQiNDsiI292WEhFzQrO6iJb7
 Gnf40hZFsp7uMXOP1POBPQcaVAbpKC98Uaj8b9xcv9pTdORdCTbiq5P+S Y=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 16 Jun 2021 06:39:12 -0700
X-QCInternal: smtphost
Received: from nasanexm03e.na.qualcomm.com ([10.85.0.48])
 by ironmsg04-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 16 Jun 2021 06:39:10 -0700
Received: from th-lint-040.qualcomm.com (10.80.80.8) by
 nasanexm03e.na.qualcomm.com (10.85.0.48) with Microsoft SMTP Server (TLS) id
 15.0.1497.18; Wed, 16 Jun 2021 06:39:09 -0700
From: Georgi Djakov <quic_c_gdjako@quicinc.com>
To: <will@kernel.org>, <robin.murphy@arm.com>
Subject: [PATCH v7 10/15] iommu/io-pgtable-arm: Implement
 arm_lpae_unmap_pages()
Date: Wed, 16 Jun 2021 06:38:51 -0700
Message-ID: <1623850736-389584-11-git-send-email-quic_c_gdjako@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1623850736-389584-1-git-send-email-quic_c_gdjako@quicinc.com>
References: <1623850736-389584-1-git-send-email-quic_c_gdjako@quicinc.com>
MIME-Version: 1.0
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanexm03h.na.qualcomm.com (10.85.0.50) To
 nasanexm03e.na.qualcomm.com (10.85.0.48)
Cc: isaacm@codeaurora.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, djakov@kernel.org, pratikp@codeaurora.org,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

From: "Isaac J. Manjarres" <isaacm@codeaurora.org>

Implement the unmap_pages() callback for the ARM LPAE io-pgtable
format.

Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
Suggested-by: Will Deacon <will@kernel.org>
Signed-off-by: Georgi Djakov <quic_c_gdjako@quicinc.com>
---
 drivers/iommu/io-pgtable-arm.c | 120 +++++++++++++++++++++++++----------------
 1 file changed, 74 insertions(+), 46 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index ea66b10c04c4..fe8fa0ee9c98 100644
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
@@ -239,22 +242,19 @@ static void __arm_lpae_sync_pte(arm_lpae_iopte *ptep, int num_entries,
 				   sizeof(*ptep) * num_entries, DMA_TO_DEVICE);
 }
 
-static void __arm_lpae_set_pte(arm_lpae_iopte *ptep, arm_lpae_iopte pte,
-			       int num_entries, struct io_pgtable_cfg *cfg)
+static void __arm_lpae_clear_pte(arm_lpae_iopte *ptep, struct io_pgtable_cfg *cfg)
 {
-	int i;
 
-	for (i = 0; i < num_entries; i++)
-		ptep[i] = pte;
+	*ptep = 0;
 
 	if (!cfg->coherent_walk)
-		__arm_lpae_sync_pte(ptep, num_entries, cfg);
+		__arm_lpae_sync_pte(ptep, 1, cfg);
 }
 
 static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
 			       struct iommu_iotlb_gather *gather,
-			       unsigned long iova, size_t size, int lvl,
-			       arm_lpae_iopte *ptep);
+			       unsigned long iova, size_t size, size_t pgcount,
+			       int lvl, arm_lpae_iopte *ptep);
 
 static void __arm_lpae_init_pte(struct arm_lpae_io_pgtable *data,
 				phys_addr_t paddr, arm_lpae_iopte prot,
@@ -298,7 +298,7 @@ static int arm_lpae_init_pte(struct arm_lpae_io_pgtable *data,
 			size_t sz = ARM_LPAE_BLOCK_SIZE(lvl, data);
 
 			tblp = ptep - ARM_LPAE_LVL_IDX(iova, lvl, data);
-			if (__arm_lpae_unmap(data, NULL, iova + i * sz, sz,
+			if (__arm_lpae_unmap(data, NULL, iova + i * sz, sz, 1,
 					     lvl, tblp) != sz) {
 				WARN_ON(1);
 				return -EINVAL;
@@ -526,14 +526,15 @@ static size_t arm_lpae_split_blk_unmap(struct arm_lpae_io_pgtable *data,
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
@@ -542,15 +543,18 @@ static size_t arm_lpae_split_blk_unmap(struct arm_lpae_io_pgtable *data,
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
@@ -568,76 +572,92 @@ static size_t arm_lpae_split_blk_unmap(struct arm_lpae_io_pgtable *data,
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
+	int i = 0, num_entries, max_entries, unmap_idx_start;
 
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
-
-		if (!iopte_leaf(pte, lvl, iop->fmt)) {
-			/* Also flush any partial walks */
-			io_pgtable_tlb_flush_walk(iop, iova, size,
-						  ARM_LPAE_GRANULE(data));
-			ptep = iopte_deref(pte, data);
-			__arm_lpae_free_pgtable(data, lvl + 1, ptep);
-		} else if (iop->cfg.quirks & IO_PGTABLE_QUIRK_NON_STRICT) {
-			/*
-			 * Order the PTE update against queueing the IOVA, to
-			 * guarantee that a flush callback from a different CPU
-			 * has observed it before the TLBIALL can be issued.
-			 */
-			smp_wmb();
-		} else {
-			io_pgtable_tlb_add_page(iop, gather, iova, size);
+		max_entries = ARM_LPAE_PTES_PER_TABLE(data) - unmap_idx_start;
+		num_entries = min_t(int, pgcount, max_entries);
+
+		while (i < num_entries) {
+			pte = READ_ONCE(*ptep);
+			if (WARN_ON(!pte))
+				break;
+
+			__arm_lpae_clear_pte(ptep, &iop->cfg);
+
+			if (!iopte_leaf(pte, lvl, iop->fmt)) {
+				/* Also flush any partial walks */
+				io_pgtable_tlb_flush_walk(iop, iova + i * size, size,
+							  ARM_LPAE_GRANULE(data));
+				__arm_lpae_free_pgtable(data, lvl + 1, iopte_deref(pte, data));
+			} else if (iop->cfg.quirks & IO_PGTABLE_QUIRK_NON_STRICT) {
+				/*
+				 * Order the PTE update against queueing the IOVA, to
+				 * guarantee that a flush callback from a different CPU
+				 * has observed it before the TLBIALL can be issued.
+				 */
+				smp_wmb();
+			} else {
+				io_pgtable_tlb_add_page(iop, gather, iova + i * size, size);
+			}
+
+			ptep++;
+			i++;
 		}
 
-		return size;
+		return i * size;
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
@@ -645,7 +665,14 @@ static size_t arm_lpae_unmap(struct io_pgtable_ops *ops, unsigned long iova,
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
@@ -761,6 +788,7 @@ arm_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg)
 	data->iop.ops = (struct io_pgtable_ops) {
 		.map		= arm_lpae_map,
 		.unmap		= arm_lpae_unmap,
+		.unmap_pages	= arm_lpae_unmap_pages,
 		.iova_to_phys	= arm_lpae_iova_to_phys,
 	};
 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
