Return-Path: <SRS0=45t2=MU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB080C4338F
	for <iommu@archiver.kernel.org>; Wed, 28 Jul 2021 15:59:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D6CF61050
	for <iommu@archiver.kernel.org>; Wed, 28 Jul 2021 15:59:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8D6CF61050
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6F7CB839BF;
	Wed, 28 Jul 2021 15:59:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id I_pO5r5awfxd; Wed, 28 Jul 2021 15:59:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 554EC839E6;
	Wed, 28 Jul 2021 15:59:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2AE57C001A;
	Wed, 28 Jul 2021 15:59:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EFC2FC000E
 for <iommu@lists.linux-foundation.org>; Wed, 28 Jul 2021 15:59:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E003D405E1
 for <iommu@lists.linux-foundation.org>; Wed, 28 Jul 2021 15:59:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UDujQyrZ_i-Z for <iommu@lists.linux-foundation.org>;
 Wed, 28 Jul 2021 15:59:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4A332405F6
 for <iommu@lists.linux-foundation.org>; Wed, 28 Jul 2021 15:59:14 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B06AA1FB;
 Wed, 28 Jul 2021 08:59:13 -0700 (PDT)
Received: from 010265703453.arm.com (unknown [10.57.36.146])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1ED633F70D;
 Wed, 28 Jul 2021 08:59:11 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org,
	will@kernel.org
Subject: [PATCH v2 05/24] iommu/exynos: Drop IOVA cookie management
Date: Wed, 28 Jul 2021 16:58:26 +0100
Message-Id: <a53d0e899de26a160b66d215d21c39418b6787e2.1627468309.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1627468308.git.robin.murphy@arm.com>
References: <cover.1627468308.git.robin.murphy@arm.com>
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org, dianders@chromium.org,
 iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
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

The core code bakes its own cookies now.

CC: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/exynos-iommu.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index d0fbf1d10e18..34085d069cda 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -735,20 +735,16 @@ static struct iommu_domain *exynos_iommu_domain_alloc(unsigned type)
 	/* Check if correct PTE offsets are initialized */
 	BUG_ON(PG_ENT_SHIFT < 0 || !dma_dev);
 
+	if (type != IOMMU_DOMAIN_DMA && type != IOMMU_DOMAIN_UNMANAGED)
+		return NULL;
+
 	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
 	if (!domain)
 		return NULL;
 
-	if (type == IOMMU_DOMAIN_DMA) {
-		if (iommu_get_dma_cookie(&domain->domain) != 0)
-			goto err_pgtable;
-	} else if (type != IOMMU_DOMAIN_UNMANAGED) {
-		goto err_pgtable;
-	}
-
 	domain->pgtable = (sysmmu_pte_t *)__get_free_pages(GFP_KERNEL, 2);
 	if (!domain->pgtable)
-		goto err_dma_cookie;
+		goto err_pgtable;
 
 	domain->lv2entcnt = (short *)__get_free_pages(GFP_KERNEL | __GFP_ZERO, 1);
 	if (!domain->lv2entcnt)
@@ -779,9 +775,6 @@ static struct iommu_domain *exynos_iommu_domain_alloc(unsigned type)
 	free_pages((unsigned long)domain->lv2entcnt, 1);
 err_counter:
 	free_pages((unsigned long)domain->pgtable, 2);
-err_dma_cookie:
-	if (type == IOMMU_DOMAIN_DMA)
-		iommu_put_dma_cookie(&domain->domain);
 err_pgtable:
 	kfree(domain);
 	return NULL;
@@ -809,9 +802,6 @@ static void exynos_iommu_domain_free(struct iommu_domain *iommu_domain)
 
 	spin_unlock_irqrestore(&domain->lock, flags);
 
-	if (iommu_domain->type == IOMMU_DOMAIN_DMA)
-		iommu_put_dma_cookie(iommu_domain);
-
 	dma_unmap_single(dma_dev, virt_to_phys(domain->pgtable), LV1TABLE_SIZE,
 			 DMA_TO_DEVICE);
 
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
