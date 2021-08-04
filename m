Return-Path: <SRS0=FZ/Z=M3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9455FC4320A
	for <iommu@archiver.kernel.org>; Wed,  4 Aug 2021 17:16:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6544460EBB
	for <iommu@archiver.kernel.org>; Wed,  4 Aug 2021 17:16:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6544460EBB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3845883B58;
	Wed,  4 Aug 2021 17:16:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cctfRvjt02AR; Wed,  4 Aug 2021 17:16:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 02D2D83BAB;
	Wed,  4 Aug 2021 17:16:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E0FFDC0010;
	Wed,  4 Aug 2021 17:16:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6BB41C000E
 for <iommu@lists.linux-foundation.org>; Wed,  4 Aug 2021 17:16:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5C76083BAB
 for <iommu@lists.linux-foundation.org>; Wed,  4 Aug 2021 17:16:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MAB_9Y3TiaTp for <iommu@lists.linux-foundation.org>;
 Wed,  4 Aug 2021 17:16:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8E37983B58
 for <iommu@lists.linux-foundation.org>; Wed,  4 Aug 2021 17:16:40 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EEE191042;
 Wed,  4 Aug 2021 10:16:39 -0700 (PDT)
Received: from 010265703453.arm.com (unknown [10.57.36.146])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3FE793F66F;
 Wed,  4 Aug 2021 10:16:38 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org,
	will@kernel.org
Subject: [PATCH v3 15/25] iommu/io-pgtable: Remove non-strict quirk
Date: Wed,  4 Aug 2021 18:15:43 +0100
Message-Id: <5de2e87b4aa4ce499071f2f5660b24761f9c1768.1628094601.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1628094600.git.robin.murphy@arm.com>
References: <cover.1628094600.git.robin.murphy@arm.com>
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org, dianders@chromium.org,
 iommu@lists.linux-foundation.org, rajatja@google.com,
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

IO_PGTABLE_QUIRK_NON_STRICT was never a very comfortable fit, since it's
not a quirk of the pagetable format itself. Now that we have a more
appropriate way to convey non-strict unmaps, though, this last of the
non-quirk quirks can also go, and with the flush queue code also now
enforcing its own ordering we can have a lovely cleanup all round.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>

---

v3: New
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  3 ---
 drivers/iommu/arm/arm-smmu/arm-smmu.c       |  3 ---
 drivers/iommu/io-pgtable-arm-v7s.c          | 12 ++----------
 drivers/iommu/io-pgtable-arm.c              | 12 ++----------
 include/linux/io-pgtable.h                  |  5 -----
 5 files changed, 4 insertions(+), 31 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 4c648da447bf..d9c93d8d193d 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2174,9 +2174,6 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain,
 		.iommu_dev	= smmu->dev,
 	};
 
-	if (!iommu_get_dma_strict(domain))
-		pgtbl_cfg.quirks |= IO_PGTABLE_QUIRK_NON_STRICT;
-
 	pgtbl_ops = alloc_io_pgtable_ops(fmt, &pgtbl_cfg, smmu_domain);
 	if (!pgtbl_ops)
 		return -ENOMEM;
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 970d9e4dcd69..a325d4769c17 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -765,9 +765,6 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 		.iommu_dev	= smmu->dev,
 	};
 
-	if (!iommu_get_dma_strict(domain))
-		pgtbl_cfg.quirks |= IO_PGTABLE_QUIRK_NON_STRICT;
-
 	if (smmu->impl && smmu->impl->init_context) {
 		ret = smmu->impl->init_context(smmu_domain, &pgtbl_cfg, dev);
 		if (ret)
diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
index 5db90d7ce2ec..e84478d39705 100644
--- a/drivers/iommu/io-pgtable-arm-v7s.c
+++ b/drivers/iommu/io-pgtable-arm-v7s.c
@@ -700,14 +700,7 @@ static size_t __arm_v7s_unmap(struct arm_v7s_io_pgtable *data,
 						ARM_V7S_BLOCK_SIZE(lvl + 1));
 				ptep = iopte_deref(pte[i], lvl, data);
 				__arm_v7s_free_table(ptep, lvl + 1, data);
-			} else if (iop->cfg.quirks & IO_PGTABLE_QUIRK_NON_STRICT) {
-				/*
-				 * Order the PTE update against queueing the IOVA, to
-				 * guarantee that a flush callback from a different CPU
-				 * has observed it before the TLBIALL can be issued.
-				 */
-				smp_wmb();
-			} else {
+			} else if (!gather->queued) {
 				io_pgtable_tlb_add_page(iop, gather, iova, blk_size);
 			}
 			iova += blk_size;
@@ -791,8 +784,7 @@ static struct io_pgtable *arm_v7s_alloc_pgtable(struct io_pgtable_cfg *cfg,
 
 	if (cfg->quirks & ~(IO_PGTABLE_QUIRK_ARM_NS |
 			    IO_PGTABLE_QUIRK_NO_PERMS |
-			    IO_PGTABLE_QUIRK_ARM_MTK_EXT |
-			    IO_PGTABLE_QUIRK_NON_STRICT))
+			    IO_PGTABLE_QUIRK_ARM_MTK_EXT))
 		return NULL;
 
 	/* If ARM_MTK_4GB is enabled, the NO_PERMS is also expected. */
diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 053df4048a29..48a5bd8f571d 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -638,14 +638,7 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
 				io_pgtable_tlb_flush_walk(iop, iova + i * size, size,
 							  ARM_LPAE_GRANULE(data));
 				__arm_lpae_free_pgtable(data, lvl + 1, iopte_deref(pte, data));
-			} else if (iop->cfg.quirks & IO_PGTABLE_QUIRK_NON_STRICT) {
-				/*
-				 * Order the PTE update against queueing the IOVA, to
-				 * guarantee that a flush callback from a different CPU
-				 * has observed it before the TLBIALL can be issued.
-				 */
-				smp_wmb();
-			} else {
+			} else if (!gather->queued) {
 				io_pgtable_tlb_add_page(iop, gather, iova + i * size, size);
 			}
 
@@ -825,7 +818,6 @@ arm_64_lpae_alloc_pgtable_s1(struct io_pgtable_cfg *cfg, void *cookie)
 	bool tg1;
 
 	if (cfg->quirks & ~(IO_PGTABLE_QUIRK_ARM_NS |
-			    IO_PGTABLE_QUIRK_NON_STRICT |
 			    IO_PGTABLE_QUIRK_ARM_TTBR1 |
 			    IO_PGTABLE_QUIRK_ARM_OUTER_WBWA))
 		return NULL;
@@ -929,7 +921,7 @@ arm_64_lpae_alloc_pgtable_s2(struct io_pgtable_cfg *cfg, void *cookie)
 	typeof(&cfg->arm_lpae_s2_cfg.vtcr) vtcr = &cfg->arm_lpae_s2_cfg.vtcr;
 
 	/* The NS quirk doesn't apply at stage 2 */
-	if (cfg->quirks & ~(IO_PGTABLE_QUIRK_NON_STRICT))
+	if (cfg->quirks)
 		return NULL;
 
 	data = arm_lpae_alloc_pgtable(cfg);
diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
index c43f3b899d2a..9ba6d9ea316e 100644
--- a/include/linux/io-pgtable.h
+++ b/include/linux/io-pgtable.h
@@ -73,10 +73,6 @@ struct io_pgtable_cfg {
 	 *	to support up to 35 bits PA where the bit32, bit33 and bit34 are
 	 *	encoded in the bit9, bit4 and bit5 of the PTE respectively.
 	 *
-	 * IO_PGTABLE_QUIRK_NON_STRICT: Skip issuing synchronous leaf TLBIs
-	 *	on unmap, for DMA domains using the flush queue mechanism for
-	 *	delayed invalidation.
-	 *
 	 * IO_PGTABLE_QUIRK_ARM_TTBR1: (ARM LPAE format) Configure the table
 	 *	for use in the upper half of a split address space.
 	 *
@@ -86,7 +82,6 @@ struct io_pgtable_cfg {
 	#define IO_PGTABLE_QUIRK_ARM_NS		BIT(0)
 	#define IO_PGTABLE_QUIRK_NO_PERMS	BIT(1)
 	#define IO_PGTABLE_QUIRK_ARM_MTK_EXT	BIT(3)
-	#define IO_PGTABLE_QUIRK_NON_STRICT	BIT(4)
 	#define IO_PGTABLE_QUIRK_ARM_TTBR1	BIT(5)
 	#define IO_PGTABLE_QUIRK_ARM_OUTER_WBWA	BIT(6)
 	unsigned long			quirks;
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
