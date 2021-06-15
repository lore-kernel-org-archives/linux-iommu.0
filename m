Return-Path: <SRS0=7V87=LJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF05FC49361
	for <iommu@archiver.kernel.org>; Tue, 15 Jun 2021 17:16:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F9E5613F9
	for <iommu@archiver.kernel.org>; Tue, 15 Jun 2021 17:16:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F9E5613F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1BEEB83BA5;
	Tue, 15 Jun 2021 17:16:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HMM9njJF5tRC; Tue, 15 Jun 2021 17:16:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D501283AAE;
	Tue, 15 Jun 2021 17:16:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F0CDDC002A;
	Tue, 15 Jun 2021 17:16:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0FEC4C000B
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 17:14:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DC70A40358
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 17:14:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=quicinc.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0v_wiGYAbh37 for <iommu@lists.linux-foundation.org>;
 Tue, 15 Jun 2021 17:14:56 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com
 [199.106.114.39])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BDB42402CE
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 17:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1623777296; x=1655313296;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version;
 bh=SyoClSC10MZdzcjwY9Xji1VjhbSPkm7sFDJ1QrxLPog=;
 b=FdIcTTAhtsVq4li5TRJG2EQS+b4x7ym3kvHtu6FFzLIlZOvpL6FMoK4A
 NcjIPoXj1mFFCYM4sCQQuIgFzNYjZW1YU1FL0vUZ9fQSfFy1a8g7HZxez
 iC1Nybld8bd8AOkBoGf++px8YjQMnBzSqAGoY9RLhFDnIhDoviTCntvrX 0=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 15 Jun 2021 10:08:52 -0700
X-QCInternal: smtphost
Received: from nasanexm03e.na.qualcomm.com ([10.85.0.48])
 by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA;
 15 Jun 2021 10:08:52 -0700
Received: from th-lint-040.qualcomm.com (10.80.80.8) by
 nasanexm03e.na.qualcomm.com (10.85.0.48) with Microsoft SMTP Server (TLS) id
 15.0.1497.18; Tue, 15 Jun 2021 10:08:52 -0700
From: Georgi Djakov <quic_c_gdjako@quicinc.com>
To: <will@kernel.org>, <robin.murphy@arm.com>
Subject: [PATCH v6 09/15] iommu/io-pgtable-arm: Prepare PTE methods for
 handling multiple entries
Date: Tue, 15 Jun 2021 10:08:27 -0700
Message-ID: <1623776913-390160-10-git-send-email-quic_c_gdjako@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1623776913-390160-1-git-send-email-quic_c_gdjako@quicinc.com>
References: <1623776913-390160-1-git-send-email-quic_c_gdjako@quicinc.com>
MIME-Version: 1.0
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanexm03e.na.qualcomm.com (10.85.0.48)
X-Mailman-Approved-At: Tue, 15 Jun 2021 17:16:44 +0000
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

The PTE methods currently operate on a single entry. In preparation
for manipulating multiple PTEs in one map or unmap call, allow them
to handle multiple PTEs.

Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
Suggested-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Georgi Djakov <quic_c_gdjako@quicinc.com>
---
 drivers/iommu/io-pgtable-arm.c | 78 ++++++++++++++++++++++++------------------
 1 file changed, 44 insertions(+), 34 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 87def58e79b5..ea66b10c04c4 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -232,20 +232,23 @@ static void __arm_lpae_free_pages(void *pages, size_t size,
 	free_pages((unsigned long)pages, get_order(size));
 }
 
-static void __arm_lpae_sync_pte(arm_lpae_iopte *ptep,
+static void __arm_lpae_sync_pte(arm_lpae_iopte *ptep, int num_entries,
 				struct io_pgtable_cfg *cfg)
 {
 	dma_sync_single_for_device(cfg->iommu_dev, __arm_lpae_dma_addr(ptep),
-				   sizeof(*ptep), DMA_TO_DEVICE);
+				   sizeof(*ptep) * num_entries, DMA_TO_DEVICE);
 }
 
 static void __arm_lpae_set_pte(arm_lpae_iopte *ptep, arm_lpae_iopte pte,
-			       struct io_pgtable_cfg *cfg)
+			       int num_entries, struct io_pgtable_cfg *cfg)
 {
-	*ptep = pte;
+	int i;
+
+	for (i = 0; i < num_entries; i++)
+		ptep[i] = pte;
 
 	if (!cfg->coherent_walk)
-		__arm_lpae_sync_pte(ptep, cfg);
+		__arm_lpae_sync_pte(ptep, num_entries, cfg);
 }
 
 static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
@@ -255,47 +258,54 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
 
 static void __arm_lpae_init_pte(struct arm_lpae_io_pgtable *data,
 				phys_addr_t paddr, arm_lpae_iopte prot,
-				int lvl, arm_lpae_iopte *ptep)
+				int lvl, int num_entries, arm_lpae_iopte *ptep)
 {
 	arm_lpae_iopte pte = prot;
+	struct io_pgtable_cfg *cfg = &data->iop.cfg;
+	size_t sz = ARM_LPAE_BLOCK_SIZE(lvl, data);
+	int i;
 
 	if (data->iop.fmt != ARM_MALI_LPAE && lvl == ARM_LPAE_MAX_LEVELS - 1)
 		pte |= ARM_LPAE_PTE_TYPE_PAGE;
 	else
 		pte |= ARM_LPAE_PTE_TYPE_BLOCK;
 
-	pte |= paddr_to_iopte(paddr, data);
+	for (i = 0; i < num_entries; i++)
+		ptep[i] = pte | paddr_to_iopte(paddr + i * sz, data);
 
-	__arm_lpae_set_pte(ptep, pte, &data->iop.cfg);
+	if (!cfg->coherent_walk)
+		__arm_lpae_sync_pte(ptep, num_entries, cfg);
 }
 
 static int arm_lpae_init_pte(struct arm_lpae_io_pgtable *data,
 			     unsigned long iova, phys_addr_t paddr,
-			     arm_lpae_iopte prot, int lvl,
+			     arm_lpae_iopte prot, int lvl, int num_entries,
 			     arm_lpae_iopte *ptep)
 {
-	arm_lpae_iopte pte = *ptep;
-
-	if (iopte_leaf(pte, lvl, data->iop.fmt)) {
-		/* We require an unmap first */
-		WARN_ON(!selftest_running);
-		return -EEXIST;
-	} else if (iopte_type(pte) == ARM_LPAE_PTE_TYPE_TABLE) {
-		/*
-		 * We need to unmap and free the old table before
-		 * overwriting it with a block entry.
-		 */
-		arm_lpae_iopte *tblp;
-		size_t sz = ARM_LPAE_BLOCK_SIZE(lvl, data);
-
-		tblp = ptep - ARM_LPAE_LVL_IDX(iova, lvl, data);
-		if (__arm_lpae_unmap(data, NULL, iova, sz, lvl, tblp) != sz) {
-			WARN_ON(1);
-			return -EINVAL;
+	int i;
+
+	for (i = 0; i < num_entries; i++)
+		if (iopte_leaf(ptep[i], lvl, data->iop.fmt)) {
+			/* We require an unmap first */
+			WARN_ON(!selftest_running);
+			return -EEXIST;
+		} else if (iopte_type(ptep[i]) == ARM_LPAE_PTE_TYPE_TABLE) {
+			/*
+			 * We need to unmap and free the old table before
+			 * overwriting it with a block entry.
+			 */
+			arm_lpae_iopte *tblp;
+			size_t sz = ARM_LPAE_BLOCK_SIZE(lvl, data);
+
+			tblp = ptep - ARM_LPAE_LVL_IDX(iova, lvl, data);
+			if (__arm_lpae_unmap(data, NULL, iova + i * sz, sz,
+					     lvl, tblp) != sz) {
+				WARN_ON(1);
+				return -EINVAL;
+			}
 		}
-	}
 
-	__arm_lpae_init_pte(data, paddr, prot, lvl, ptep);
+	__arm_lpae_init_pte(data, paddr, prot, lvl, num_entries, ptep);
 	return 0;
 }
 
@@ -323,7 +333,7 @@ static arm_lpae_iopte arm_lpae_install_table(arm_lpae_iopte *table,
 		return old;
 
 	/* Even if it's not ours, there's no point waiting; just kick it */
-	__arm_lpae_sync_pte(ptep, cfg);
+	__arm_lpae_sync_pte(ptep, 1, cfg);
 	if (old == curr)
 		WRITE_ONCE(*ptep, new | ARM_LPAE_PTE_SW_SYNC);
 
@@ -344,7 +354,7 @@ static int __arm_lpae_map(struct arm_lpae_io_pgtable *data, unsigned long iova,
 
 	/* If we can install a leaf entry at this level, then do so */
 	if (size == block_size)
-		return arm_lpae_init_pte(data, iova, paddr, prot, lvl, ptep);
+		return arm_lpae_init_pte(data, iova, paddr, prot, lvl, 1, ptep);
 
 	/* We can't allocate tables at the final level */
 	if (WARN_ON(lvl >= ARM_LPAE_MAX_LEVELS - 1))
@@ -361,7 +371,7 @@ static int __arm_lpae_map(struct arm_lpae_io_pgtable *data, unsigned long iova,
 		if (pte)
 			__arm_lpae_free_pages(cptep, tblsz, cfg);
 	} else if (!cfg->coherent_walk && !(pte & ARM_LPAE_PTE_SW_SYNC)) {
-		__arm_lpae_sync_pte(ptep, cfg);
+		__arm_lpae_sync_pte(ptep, 1, cfg);
 	}
 
 	if (pte && !iopte_leaf(pte, lvl, data->iop.fmt)) {
@@ -543,7 +553,7 @@ static size_t arm_lpae_split_blk_unmap(struct arm_lpae_io_pgtable *data,
 		if (i == unmap_idx)
 			continue;
 
-		__arm_lpae_init_pte(data, blk_paddr, pte, lvl, &tablep[i]);
+		__arm_lpae_init_pte(data, blk_paddr, pte, lvl, 1, &tablep[i]);
 	}
 
 	pte = arm_lpae_install_table(tablep, ptep, blk_pte, cfg);
@@ -585,7 +595,7 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
 
 	/* If the size matches this level, we're in the right place */
 	if (size == ARM_LPAE_BLOCK_SIZE(lvl, data)) {
-		__arm_lpae_set_pte(ptep, 0, &iop->cfg);
+		__arm_lpae_set_pte(ptep, 0, 1, &iop->cfg);
 
 		if (!iopte_leaf(pte, lvl, iop->fmt)) {
 			/* Also flush any partial walks */
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
