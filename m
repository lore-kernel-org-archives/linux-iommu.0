Return-Path: <SRS0=szPT=AU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E65FC433E0
	for <iommu@archiver.kernel.org>; Thu,  9 Jul 2020 16:19:41 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E966207D0
	for <iommu@archiver.kernel.org>; Thu,  9 Jul 2020 16:19:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E966207D0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5F640895A6;
	Thu,  9 Jul 2020 16:19:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PzqBP0Tibkgd; Thu,  9 Jul 2020 16:19:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id DC2A689A17;
	Thu,  9 Jul 2020 16:19:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C1862C08A0;
	Thu,  9 Jul 2020 16:19:39 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 028B8C016F
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jul 2020 16:19:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id E5D8A87B82
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jul 2020 16:19:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IjxDuP5huSaK for <iommu@lists.linux-foundation.org>;
 Thu,  9 Jul 2020 16:19:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 5190A879B5
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jul 2020 16:19:36 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 9B97DAED2;
 Thu,  9 Jul 2020 16:19:34 +0000 (UTC)
From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To: hch@lst.de, Robin Murphy <robin.murphy@arm.com>,
 David Rientjes <rientjes@google.com>, iommu@lists.linux-foundation.org,
 Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 4/4] dma-pool: Make sure atomic pool suits device
Date: Thu,  9 Jul 2020 18:19:04 +0200
Message-Id: <20200709161903.26229-5-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200709161903.26229-1-nsaenzjulienne@suse.de>
References: <20200709161903.26229-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Cc: linux-rpi-kernel@lists.infradead.org, jeremy.linton@arm.com,
 linux-kernel@vger.kernel.org
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

When allocating DMA memory from a pool, the core can only guess which
atomic pool will fit a device's constraints. If it doesn't, get a safer
atomic pool and try again.

Fixes: c84dc6e68a1d ("dma-pool: add additional coherent pools to map to gfp mask")
Reported-by: Jeremy Linton <jeremy.linton@arm.com>
Suggested-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 kernel/dma/pool.c | 53 +++++++++++++++++++++++++++++++++--------------
 1 file changed, 37 insertions(+), 16 deletions(-)

diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
index 3d518de07617..d48d9acb585f 100644
--- a/kernel/dma/pool.c
+++ b/kernel/dma/pool.c
@@ -240,35 +240,56 @@ static inline struct gen_pool *dma_guess_pool(struct device *dev,
 void *dma_alloc_from_pool(struct device *dev, size_t size,
 			  struct page **ret_page, gfp_t flags)
 {
-	struct gen_pool *pool = dma_guess_pool(dev, NULL);
-	unsigned long val;
+	struct gen_pool *pool = NULL;
+	unsigned long val = 0;
 	void *ptr = NULL;
-
-	if (!pool) {
-		WARN(1, "%pGg atomic pool not initialised!\n", &flags);
-		return NULL;
+	phys_addr_t phys;
+
+	while (1) {
+		pool = dma_guess_pool(dev, pool);
+		if (!pool) {
+			WARN(1, "Failed to get suitable pool for %s\n",
+			     dev_name(dev));
+			break;
+		}
+
+		val = gen_pool_alloc(pool, size);
+		if (!val)
+			continue;
+
+		phys = gen_pool_virt_to_phys(pool, val);
+		if (dma_coherent_ok(dev, phys, size))
+			break;
+
+		gen_pool_free(pool, val, size);
+		val = 0;
 	}
 
-	val = gen_pool_alloc(pool, size);
-	if (val) {
-		phys_addr_t phys = gen_pool_virt_to_phys(pool, val);
 
+	if (val) {
 		*ret_page = pfn_to_page(__phys_to_pfn(phys));
 		ptr = (void *)val;
 		memset(ptr, 0, size);
+
+		if (gen_pool_avail(pool) < atomic_pool_size)
+			schedule_work(&atomic_pool_work);
 	}
-	if (gen_pool_avail(pool) < atomic_pool_size)
-		schedule_work(&atomic_pool_work);
 
 	return ptr;
 }
 
 bool dma_free_from_pool(struct device *dev, void *start, size_t size)
 {
-	struct gen_pool *pool = dma_guess_pool(dev, NULL);
+	struct gen_pool *pool = NULL;
+
+	while (1) {
+		pool = dma_guess_pool(dev, pool);
+		if (!pool)
+			return false;
 
-	if (!pool || !gen_pool_has_addr(pool, (unsigned long)start, size))
-		return false;
-	gen_pool_free(pool, (unsigned long)start, size);
-	return true;
+		if (gen_pool_has_addr(pool, (unsigned long)start, size)) {
+			gen_pool_free(pool, (unsigned long)start, size);
+			return true;
+		}
+	}
 }
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
