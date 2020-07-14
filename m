Return-Path: <SRS0=v902=AZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 596F9C433E5
	for <iommu@archiver.kernel.org>; Tue, 14 Jul 2020 11:59:38 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D32B22224
	for <iommu@archiver.kernel.org>; Tue, 14 Jul 2020 11:59:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D32B22224
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id BE41C883C2;
	Tue, 14 Jul 2020 11:59:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id k4Pc0JAKySLI; Tue, 14 Jul 2020 11:59:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 083D888371;
	Tue, 14 Jul 2020 11:59:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CC207C0891;
	Tue, 14 Jul 2020 11:59:35 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CA7E3C0733
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jul 2020 11:59:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id B618B883A6
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jul 2020 11:59:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HnH1lJfP5yzt for <iommu@lists.linux-foundation.org>;
 Tue, 14 Jul 2020 11:59:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 8A6E988371
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jul 2020 11:59:33 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D97231FB;
 Tue, 14 Jul 2020 04:59:32 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com
 [10.1.196.37])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4E01D3F73D;
 Tue, 14 Jul 2020 04:59:32 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org
Subject: [PATCH v2] iommu/exynos: Rename update_pte()
Date: Tue, 14 Jul 2020 12:59:28 +0100
Message-Id: <829bb5dc18e734870b75db673ddce86e7e37fc73.1594727968.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.26.2.dirty
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org
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

The name "update_pte" is a little too generic, and can end up clashing
with architecture pagetable code leaked out of common mm headers. Rename
it to something more appropriately namespaced.

Reported-by: kernel test robot <lkp@intel.com>
Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>

---
v2: fix typo - thanks Marek!
---
 drivers/iommu/exynos-iommu.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 60c8a56e4a3f..75cdd37fae38 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -721,7 +721,7 @@ static struct platform_driver exynos_sysmmu_driver __refdata = {
 	}
 };
 
-static inline void update_pte(sysmmu_pte_t *ent, sysmmu_pte_t val)
+static inline void exynos_iommu_set_pte(sysmmu_pte_t *ent, sysmmu_pte_t val)
 {
 	dma_sync_single_for_cpu(dma_dev, virt_to_phys(ent), sizeof(*ent),
 				DMA_TO_DEVICE);
@@ -933,7 +933,7 @@ static sysmmu_pte_t *alloc_lv2entry(struct exynos_iommu_domain *domain,
 		if (!pent)
 			return ERR_PTR(-ENOMEM);
 
-		update_pte(sent, mk_lv1ent_page(virt_to_phys(pent)));
+		exynos_iommu_set_pte(sent, mk_lv1ent_page(virt_to_phys(pent)));
 		kmemleak_ignore(pent);
 		*pgcounter = NUM_LV2ENTRIES;
 		handle = dma_map_single(dma_dev, pent, LV2TABLE_SIZE,
@@ -994,7 +994,7 @@ static int lv1set_section(struct exynos_iommu_domain *domain,
 		*pgcnt = 0;
 	}
 
-	update_pte(sent, mk_lv1ent_sect(paddr, prot));
+	exynos_iommu_set_pte(sent, mk_lv1ent_sect(paddr, prot));
 
 	spin_lock(&domain->lock);
 	if (lv1ent_page_zero(sent)) {
@@ -1018,7 +1018,7 @@ static int lv2set_page(sysmmu_pte_t *pent, phys_addr_t paddr, size_t size,
 		if (WARN_ON(!lv2ent_fault(pent)))
 			return -EADDRINUSE;
 
-		update_pte(pent, mk_lv2ent_spage(paddr, prot));
+		exynos_iommu_set_pte(pent, mk_lv2ent_spage(paddr, prot));
 		*pgcnt -= 1;
 	} else { /* size == LPAGE_SIZE */
 		int i;
@@ -1150,7 +1150,7 @@ static size_t exynos_iommu_unmap(struct iommu_domain *iommu_domain,
 		}
 
 		/* workaround for h/w bug in System MMU v3.3 */
-		update_pte(ent, ZERO_LV2LINK);
+		exynos_iommu_set_pte(ent, ZERO_LV2LINK);
 		size = SECT_SIZE;
 		goto done;
 	}
@@ -1171,7 +1171,7 @@ static size_t exynos_iommu_unmap(struct iommu_domain *iommu_domain,
 	}
 
 	if (lv2ent_small(ent)) {
-		update_pte(ent, 0);
+		exynos_iommu_set_pte(ent, 0);
 		size = SPAGE_SIZE;
 		domain->lv2entcnt[lv1ent_offset(iova)] += 1;
 		goto done;
-- 
2.26.2.dirty

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
