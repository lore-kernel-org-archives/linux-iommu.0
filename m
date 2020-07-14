Return-Path: <SRS0=v902=AZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4569BC43446
	for <iommu@archiver.kernel.org>; Tue, 14 Jul 2020 12:40:10 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24B0422472
	for <iommu@archiver.kernel.org>; Tue, 14 Jul 2020 12:40:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24B0422472
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 073BC2514E;
	Tue, 14 Jul 2020 12:40:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HOYKgyANjI7S; Tue, 14 Jul 2020 12:40:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 309362EA9C;
	Tue, 14 Jul 2020 12:40:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1D20CC1797;
	Tue, 14 Jul 2020 12:40:04 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5B74AC0888
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jul 2020 12:40:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 53A192514E
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jul 2020 12:40:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id I0coLNL7ObFr for <iommu@lists.linux-foundation.org>;
 Tue, 14 Jul 2020 12:40:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by silver.osuosl.org (Postfix) with ESMTPS id 7F9A12674B
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jul 2020 12:40:01 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id B6D5AB02E;
 Tue, 14 Jul 2020 12:40:02 +0000 (UTC)
From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To: hch@lst.de, linux-kernel@vger.kernel.org,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v2 3/4] dma-pool: Introduce dma_guess_pool()
Date: Tue, 14 Jul 2020 14:39:27 +0200
Message-Id: <20200714123928.8581-4-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714123928.8581-1-nsaenzjulienne@suse.de>
References: <20200714123928.8581-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org, linux-rpi-kernel@lists.infradead.org,
 jeremy.linton@arm.com
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

dma-pool's dev_to_pool() creates the false impression that there is a
way to grantee a mapping between a device's DMA constraints and an
atomic pool. It tuns out it's just a guess, and the device might need to
use an atomic pool containing memory from a 'safer' (or lower) memory
zone.

To help mitigate this, introduce dma_guess_pool() which can be fed a
device's DMA constraints and atomic pools already known to be faulty, in
order for it to provide an better guess on which pool to use.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 kernel/dma/pool.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
index 318035e093fb..5b9eaa2b498d 100644
--- a/kernel/dma/pool.c
+++ b/kernel/dma/pool.c
@@ -203,7 +203,7 @@ static int __init dma_atomic_pool_init(void)
 }
 postcore_initcall(dma_atomic_pool_init);
 
-static inline struct gen_pool *dev_to_pool(struct device *dev)
+static inline struct gen_pool *dma_guess_pool_from_device(struct device *dev)
 {
 	u64 phys_mask;
 	gfp_t gfp;
@@ -217,10 +217,30 @@ static inline struct gen_pool *dev_to_pool(struct device *dev)
 	return atomic_pool_kernel;
 }
 
+static inline struct gen_pool *dma_get_safer_pool(struct gen_pool *bad_pool)
+{
+	if (bad_pool == atomic_pool_kernel)
+		return atomic_pool_dma32 ? : atomic_pool_dma;
+
+	if (bad_pool == atomic_pool_dma32)
+		return atomic_pool_dma;
+
+	return NULL;
+}
+
+static inline struct gen_pool *dma_guess_pool(struct device *dev,
+					      struct gen_pool *bad_pool)
+{
+	if (bad_pool)
+		return dma_get_safer_pool(bad_pool);
+
+	return dma_guess_pool_from_device(dev);
+}
+
 void *dma_alloc_from_pool(struct device *dev, size_t size,
 			  struct page **ret_page, gfp_t flags)
 {
-	struct gen_pool *pool = dev_to_pool(dev);
+	struct gen_pool *pool = dma_guess_pool(dev, NULL);
 	unsigned long val;
 	void *ptr = NULL;
 
@@ -249,7 +269,7 @@ void *dma_alloc_from_pool(struct device *dev, size_t size,
 
 bool dma_free_from_pool(struct device *dev, void *start, size_t size)
 {
-	struct gen_pool *pool = dev_to_pool(dev);
+	struct gen_pool *pool = dma_guess_pool(dev, NULL);
 
 	if (!pool || !gen_pool_has_addr(pool, (unsigned long)start, size))
 		return false;
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
