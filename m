Return-Path: <SRS0=o7oR=M5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED369C4338F
	for <iommu@archiver.kernel.org>; Fri,  6 Aug 2021 10:35:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A853660E52
	for <iommu@archiver.kernel.org>; Fri,  6 Aug 2021 10:35:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A853660E52
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7FBFD60842;
	Fri,  6 Aug 2021 10:35:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8VExAb0wSFAv; Fri,  6 Aug 2021 10:35:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id CB1AA60627;
	Fri,  6 Aug 2021 10:35:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A92CCC001A;
	Fri,  6 Aug 2021 10:35:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 32790C000E
 for <iommu@lists.linux-foundation.org>; Fri,  6 Aug 2021 10:35:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 22314403A2
 for <iommu@lists.linux-foundation.org>; Fri,  6 Aug 2021 10:35:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=chromium.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TxpVH3qZKj_R for <iommu@lists.linux-foundation.org>;
 Fri,  6 Aug 2021 10:35:19 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 157984027D
 for <iommu@lists.linux-foundation.org>; Fri,  6 Aug 2021 10:35:18 +0000 (UTC)
Received: by mail-pl1-x632.google.com with SMTP id d1so6516742pll.1
 for <iommu@lists.linux-foundation.org>; Fri, 06 Aug 2021 03:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qq7Es9qqurMOQgOXW7Nt7GCi8I+eBGGn+82njpl5RUg=;
 b=NnlSmW2PrmoyObUCRaZVUJoSZs4knmCzyqQwfRuwHHLljanPmiVXbvb2Zj9ByKrEXL
 Cp7Vo0uGfKa3vmjiZdUyEH61UP9Cs4OhWGiGkQjNeQfG6SfyXsoe8sU/y3iFjSogh8RV
 1wkyGhZzZvyaVfDMMW6NwTzGQJqeklSSONpwA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qq7Es9qqurMOQgOXW7Nt7GCi8I+eBGGn+82njpl5RUg=;
 b=rux1mCv96avNxDUsq3xjN8JGjIkau3IU3ix1OWv0Fz0fvObXFPP4tLovQSzu0vh3KZ
 eCTx+/9ZXiT8NOTcmFeOJxX5Akt9n42Evil+aBOtyxSAYTjfRax8tW9ezvxZtXDMtOCw
 C2UwN7S7mIw1kRxNrxP1/t4smPSQNtL/UOD7yyVcGVoQlAtu6g53XVRbRZYp/AuJl8zF
 KClGnF+YyrIsIl+J6NtRCXYgz/7kpTCkQHyl5jn6FgbBvsZI1K36UmBNHWEGIuwcGcWo
 VA/kw8xkO8fkbcJS7Ns+82n6oHgSw9CghFWY+A2fjRQaL0wp/ZJmvqOqDjrc+RCNM1V/
 s/+w==
X-Gm-Message-State: AOAM533FZtbaP1dzoolviuU7V+3uLaUhcR0sDWNsv9aubpWQRDLS/WgF
 3TsZq16xBDtiO9IGaY/ytUYh/A==
X-Google-Smtp-Source: ABdhPJwAS6c0/pX19p9ixDXxlAF28wpG8y2g1tzflaCFloZCKNHLyID0BKQR+Rb2iGmSyzxxfpPHvg==
X-Received: by 2002:a65:578a:: with SMTP id b10mr189421pgr.135.1628246118464; 
 Fri, 06 Aug 2021 03:35:18 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:6f20:cf00:347a:afc2])
 by smtp.gmail.com with UTF8SMTPSA id z24sm9136241pfn.150.2021.08.06.03.35.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Aug 2021 03:35:18 -0700 (PDT)
From: David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To: Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v2 6/9] dma-iommu: add bounce buffer pools
Date: Fri,  6 Aug 2021 19:34:20 +0900
Message-Id: <20210806103423.3341285-7-stevensd@google.com>
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
In-Reply-To: <20210806103423.3341285-1-stevensd@google.com>
References: <20210806103423.3341285-1-stevensd@google.com>
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org, Sergey Senozhatsky <senozhatsky@chromium.org>,
 iommu@lists.linux-foundation.org, David Stevens <stevensd@chromium.org>,
 Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>
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

From: David Stevens <stevensd@chromium.org>

Add per-domain pools for IOMMU mapped bounce buffers. Each domain has 8
buffer pools, which hold buffers of size 2^n pages. Buffers are
allocated on demand, and unused buffers are periodically released from
the cache. Single use buffers are still used for mappings that are too
large to use any pool, or if there are too many simultaneously in-use
streaming mappings.

Signed-off-by: David Stevens <stevensd@chromium.org>
---
 drivers/iommu/dma-iommu.c         |  24 +-
 drivers/iommu/io-bounce-buffers.c |  42 ++-
 drivers/iommu/io-bounce-buffers.h |   3 +
 drivers/iommu/io-buffer-manager.c | 417 +++++++++++++++++++++++++++++-
 drivers/iommu/io-buffer-manager.h |  49 +++-
 include/linux/dma-iommu.h         |   2 +
 6 files changed, 520 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 908eb6fb7dc3..42f85b7a90f0 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -378,6 +378,11 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
 			return -EFAULT;
 		}
 
+		if (cookie->bounce_buffers &&
+		    !io_bounce_buffer_reinit_check(cookie->bounce_buffers,
+						   dev, base, limit))
+			return -EFAULT;
+
 		return 0;
 	}
 
@@ -436,12 +441,24 @@ static int dma_info_to_prot(enum dma_data_direction dir, bool coherent,
 	}
 }
 
+u64 __iommu_dma_limit(struct iommu_domain *domain, struct device *dev, u64 mask)
+{
+	u64 dma_limit = mask;
+
+	dma_limit = min_not_zero(dma_limit, dev->bus_dma_limit);
+	if (domain->geometry.force_aperture)
+		dma_limit = min(dma_limit, (u64)domain->geometry.aperture_end);
+
+	return dma_limit;
+}
+
 dma_addr_t __iommu_dma_alloc_iova(struct iommu_domain *domain,
-		size_t size, u64 dma_limit, struct device *dev)
+		size_t size, u64 mask, struct device *dev)
 {
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
 	struct iova_domain *iovad = &cookie->iovad;
 	unsigned long shift, iova_len, iova = 0;
+	u64 dma_limit = __iommu_dma_limit(domain, dev, mask);
 
 	if (cookie->type == IOMMU_DMA_MSI_COOKIE) {
 		cookie->msi_iova += size;
@@ -459,11 +476,6 @@ dma_addr_t __iommu_dma_alloc_iova(struct iommu_domain *domain,
 	if (iova_len < (1 << (IOVA_RANGE_CACHE_MAX_SIZE - 1)))
 		iova_len = roundup_pow_of_two(iova_len);
 
-	dma_limit = min_not_zero(dma_limit, dev->bus_dma_limit);
-
-	if (domain->geometry.force_aperture)
-		dma_limit = min(dma_limit, (u64)domain->geometry.aperture_end);
-
 	/* Try to get PCI devices a SAC address */
 	if (dma_limit > DMA_BIT_MASK(32) && !iommu_dma_forcedac && dev_is_pci(dev))
 		iova = alloc_iova_fast(iovad, iova_len,
diff --git a/drivers/iommu/io-bounce-buffers.c b/drivers/iommu/io-bounce-buffers.c
index ed05f593a195..8af8e1546d5f 100644
--- a/drivers/iommu/io-bounce-buffers.c
+++ b/drivers/iommu/io-bounce-buffers.c
@@ -9,11 +9,17 @@
 #include <linux/dma-map-ops.h>
 #include <linux/highmem.h>
 #include <linux/list.h>
+#include <linux/moduleparam.h>
 #include <linux/slab.h>
 
 #include "io-buffer-manager.h"
 #include "io-bounce-buffers.h"
 
+// Specifies the number of slots in each buffer pool. The total amount of
+// preallocated IOVA range per 1024 slots is slightly under 1GB.
+static unsigned int buffer_pool_size = 1024;
+module_param(buffer_pool_size, uint, 0);
+
 struct io_bounce_buffers {
 	struct iommu_domain *domain;
 	struct iova_domain *iovad;
@@ -40,7 +46,8 @@ struct io_bounce_buffers *io_bounce_buffers_init(struct device *dev,
 	if (!buffers)
 		return ERR_PTR(-ENOMEM);
 
-	ret = io_buffer_manager_init(&buffers->manager);
+	ret = io_buffer_manager_init(&buffers->manager, dev, iovad,
+				     buffer_pool_size);
 	if (ret) {
 		kfree(buffers);
 		return ERR_PTR(ret);
@@ -53,8 +60,26 @@ struct io_bounce_buffers *io_bounce_buffers_init(struct device *dev,
 	return buffers;
 }
 
+bool io_bounce_buffer_reinit_check(struct io_bounce_buffers *buffers,
+				   struct device *dev, dma_addr_t base,
+				   dma_addr_t limit)
+{
+	if (!io_buffer_manager_reinit_check(&buffers->manager, dev,
+					    buffers->iovad, base, limit)) {
+		pr_warn("io-buffer-buffers out of range of %s\n",
+			dev_name(dev));
+		return false;
+	}
+
+	if (buffers->nid != dev_to_node(dev))
+		pr_info("node mismatch: buffers=%d dev=%d\n", buffers->nid,
+			dev_to_node(dev));
+	return true;
+}
+
 void io_bounce_buffers_destroy(struct io_bounce_buffers *buffers)
 {
+	io_buffer_manager_destroy(&buffers->manager, buffers->domain);
 	kfree(buffers);
 }
 
@@ -377,7 +402,7 @@ bool io_bounce_buffers_map_page(struct io_bounce_buffers *buffers,
 				enum dma_data_direction dir,
 				unsigned long attrs, dma_addr_t *handle)
 {
-	bool skip_cpu_sync = attrs & DMA_ATTR_SKIP_CPU_SYNC;
+	bool new_buffer, skip_cpu_sync = attrs & DMA_ATTR_SKIP_CPU_SYNC;
 	struct io_bounce_buffer_info info;
 	bool force_bounce = iova_offset(buffers->iovad, offset | size);
 
@@ -387,14 +412,15 @@ bool io_bounce_buffers_map_page(struct io_bounce_buffers *buffers,
 	*handle = DMA_MAPPING_ERROR;
 	if (!io_buffer_manager_alloc_buffer(&buffers->manager, dev, page,
 					    offset + size, prot, buffers->nid,
-					    &info))
+					    &info, &new_buffer))
 		return true;
 
 	if (!skip_cpu_sync)
 		io_bounce_buffers_do_sync(buffers, info.bounce_buffer, offset,
 					  page, offset, size, dir, prot, false);
 
-	if (!io_bounce_buffers_map_buffer(buffers, &info, prot, skip_cpu_sync,
+	if (new_buffer &&
+	    !io_bounce_buffers_map_buffer(buffers, &info, prot, skip_cpu_sync,
 					  offset, size)) {
 		io_buffer_manager_release_buffer(&buffers->manager,
 						 buffers->domain, info.iova,
@@ -414,7 +440,7 @@ bool io_bounce_buffers_map_sg(struct io_bounce_buffers *buffers,
 	struct io_bounce_buffer_info info;
 	struct scatterlist *iter;
 	size_t size = 0;
-	bool skip_cpu_sync = attrs & DMA_ATTR_SKIP_CPU_SYNC;
+	bool new_buffer, skip_cpu_sync = attrs & DMA_ATTR_SKIP_CPU_SYNC;
 	dma_addr_t seg_iova;
 	int i;
 	bool force_bounce = false;
@@ -430,7 +456,8 @@ bool io_bounce_buffers_map_sg(struct io_bounce_buffers *buffers,
 
 	*out_nents = 0;
 	if (!io_buffer_manager_alloc_buffer(&buffers->manager, dev, sgl, size,
-					    prot, buffers->nid, &info))
+					    prot, buffers->nid, &info,
+					    &new_buffer))
 		return true;
 
 	if (!skip_cpu_sync)
@@ -438,7 +465,8 @@ bool io_bounce_buffers_map_sg(struct io_bounce_buffers *buffers,
 					    info.bounce_buffer, dir, prot,
 					    false);
 
-	if (!io_bounce_buffers_map_buffer(buffers, &info, prot, skip_cpu_sync,
+	if (new_buffer &&
+	    !io_bounce_buffers_map_buffer(buffers, &info, prot, skip_cpu_sync,
 					  0, size)) {
 		io_buffer_manager_release_buffer(&buffers->manager,
 						 buffers->domain, info.iova,
diff --git a/drivers/iommu/io-bounce-buffers.h b/drivers/iommu/io-bounce-buffers.h
index 6d132a27646c..cf329a9704fa 100644
--- a/drivers/iommu/io-bounce-buffers.h
+++ b/drivers/iommu/io-bounce-buffers.h
@@ -14,6 +14,9 @@ struct io_bounce_buffers;
 struct io_bounce_buffers *io_bounce_buffers_init(struct device *dev,
 						 struct iommu_domain *domain,
 						 struct iova_domain *iovad);
+bool io_bounce_buffer_reinit_check(struct io_bounce_buffers *buffers,
+				   struct device *dev, dma_addr_t base,
+				   dma_addr_t limit);
 void io_bounce_buffers_destroy(struct io_bounce_buffers *buffers);
 
 bool io_bounce_buffers_sync_single(struct io_bounce_buffers *buffers,
diff --git a/drivers/iommu/io-buffer-manager.c b/drivers/iommu/io-buffer-manager.c
index 587584fdf26b..1c69df08603c 100644
--- a/drivers/iommu/io-buffer-manager.c
+++ b/drivers/iommu/io-buffer-manager.c
@@ -3,6 +3,14 @@
  * Manager which allocates and tracks bounce buffers and their IOVAs. Does
  * not actually manage the IOMMU mapping nor do the bounce copies.
  *
+ * The manager caches recently used bounce buffers. The cache is initialized
+ * with a fixed number of slots, which allows for cache operations to be
+ * performed efficiently. Slots are assigned pre-allocated IOVAs. The number
+ * of slots is configurable, but is limited to 1/2 of the total IOVA range.
+ *
+ * If the cache fills up, or for very large allocations, the manager falls
+ * back to single-use bounce buffers.
+ *
  * Copyright (C) 2021 Google, Inc.
  */
 
@@ -10,6 +18,8 @@
 
 #include <linux/slab.h>
 
+#define EVICT_PERIOD_MSEC 5000
+
 struct io_buffer_node {
 	struct rb_node node;
 	struct io_bounce_buffer_info info;
@@ -51,6 +61,115 @@ static struct page **io_buffer_manager_alloc_pages(int count, unsigned int nid)
 	return pages;
 }
 
+static dma_addr_t io_buffer_slot_to_iova(struct io_buffer_slot *slot,
+					 struct io_buffer_pool *pool)
+{
+	return pool->iova_base + pool->buffer_size * (slot - pool->slots);
+}
+
+static struct io_buffer_slot **
+io_buffer_pool_get_cache(struct io_buffer_pool *pool, int prot)
+{
+	prot &= (IOMMU_READ | IOMMU_WRITE);
+	if (prot == IOMMU_READ)
+		return &pool->cached_slots[IO_BUFFER_SLOT_TYPE_RO];
+	else if (prot == IOMMU_WRITE)
+		return &pool->cached_slots[IO_BUFFER_SLOT_TYPE_WO];
+	BUG_ON(prot == 0);
+	return &pool->cached_slots[IO_BUFFER_SLOT_TYPE_RW];
+}
+
+/**
+ * io_buffer_manager_relese_slots - release unused buffer slots
+ * @to_free: head of list of slots to free
+ * @head: outparam of head of list of slots that were freed
+ * @tail_link: outparam for next ptr of tail of list of freed slots
+ *
+ * Frees slots that are evicted from cache. May leak slots if an
+ * error occurs while freeing slot resources.
+ */
+static void io_buffer_manager_relese_slots(struct io_buffer_manager *manager,
+					   struct io_buffer_pool *pool,
+					   struct io_buffer_slot *to_free,
+					   struct io_buffer_slot **head,
+					   struct io_buffer_slot ***tail_link)
+{
+	struct io_buffer_slot *tmp, **prev_link;
+
+	*head = to_free;
+	prev_link = head;
+
+	while ((tmp = *prev_link)) {
+		dma_addr_t iova = io_buffer_slot_to_iova(tmp, pool);
+
+		if (io_bounce_buffers_release_buffer_cb(manager, iova,
+							pool->buffer_size)) {
+			io_buffer_manager_free_pages(tmp->bounce_buffer,
+						     pool->buffer_size >>
+							     PAGE_SHIFT);
+		} else {
+			// If freeing fails, the iova is in an unknown state.
+			// Remove it from the list of slots being freed.
+			pr_warn("Bounce buffer release failed; leaking slot\n");
+			*prev_link = tmp->next;
+		}
+		prev_link = &tmp->next;
+	}
+
+	*tail_link = prev_link;
+}
+
+static void __io_buffer_manager_evict(struct io_buffer_manager *manager,
+				      bool pool_teardown)
+{
+	struct io_buffer_pool *pool;
+	struct io_buffer_slot **prev_link, *to_free;
+	unsigned long flags;
+	int i, j;
+	bool requeue = false;
+
+	for (i = 0; i < NUM_POOLS; i++) {
+		pool = &manager->pools[i];
+
+		spin_lock_irqsave(&pool->lock, flags);
+		for (j = 0; j < IO_BUFFER_SLOT_TYPE_COUNT; j++) {
+			prev_link = &pool->cached_slots[j];
+
+			if (pool_teardown) {
+				to_free = *prev_link;
+			} else {
+				while ((to_free = *prev_link)) {
+					if (to_free->old_cache_entry) {
+						*prev_link = NULL;
+						break;
+					}
+					requeue = true;
+					to_free->old_cache_entry = true;
+					prev_link = &to_free->next;
+				}
+			}
+			if (!to_free)
+				continue;
+
+			spin_unlock_irqrestore(&pool->lock, flags);
+
+			io_buffer_manager_relese_slots(manager, pool, to_free,
+						       &to_free, &prev_link);
+
+			spin_lock_irqsave(&pool->lock, flags);
+			if (to_free) {
+				*prev_link = pool->empty_slots;
+				pool->empty_slots = to_free;
+			}
+		}
+		spin_unlock_irqrestore(&pool->lock, flags);
+	}
+
+	if (requeue)
+		queue_delayed_work(manager->evict_wq, &manager->evict_work,
+				   msecs_to_jiffies(EVICT_PERIOD_MSEC));
+}
+
 struct io_buffer_node *find_fallback_node(struct rb_root *root, dma_addr_t iova)
 {
 	struct rb_node *node = root->rb_node;
@@ -97,15 +216,126 @@ bool insert_fallback_node(struct rb_root *root, struct io_buffer_node *node)
 	return true;
 }
 
+static void io_buffer_manager_evict(struct work_struct *work)
+{
+	struct io_buffer_manager *manager = container_of(
+		to_delayed_work(work), struct io_buffer_manager, evict_work);
+	__io_buffer_manager_evict(manager, false);
+}
+
+static void fill_buffer_info(struct io_buffer_slot *slot,
+			     struct io_buffer_pool *pool,
+			     struct io_bounce_buffer_info *info)
+{
+	info->bounce_buffer = slot->bounce_buffer;
+	info->iova = io_buffer_slot_to_iova(slot, pool);
+	info->size = pool->buffer_size;
+}
+
+static bool io_buffer_pool_has_empty_slot(struct io_buffer_pool *pool,
+					  int num_slots)
+{
+	if (pool->empty_slots)
+		return true;
+
+	if (!pool->slots) {
+		pool->slots = kmalloc_array(num_slots, sizeof(*pool->slots),
+					    GFP_ATOMIC);
+		if (!pool->slots)
+			return false;
+	}
+
+	if (pool->untouched_slot_idx < num_slots) {
+		struct io_buffer_slot *slot =
+			&pool->slots[pool->untouched_slot_idx++];
+		memset(slot, 0, sizeof(*slot));
+		pool->empty_slots = slot;
+	}
+
+	return !!pool->empty_slots;
+}
+
+static bool io_buffer_manager_alloc_slot(struct io_buffer_manager *manager,
+					 void *orig_buffer, size_t size,
+					 int prot, unsigned int nid,
+					 struct io_bounce_buffer_info *info,
+					 bool *new_buffer)
+{
+	struct io_buffer_slot *slot = NULL, **prev_link, *cur;
+	struct io_buffer_pool *pool = NULL;
+	unsigned long flags;
+	dma_addr_t iova;
+	int pool_idx;
+
+	if (!manager->num_slots)
+		return false;
+
+	// Compute the power-of-2 size buffer needed, and then the pool idx.
+	pool_idx = roundup_pow_of_two(ALIGN(size, PAGE_SIZE));
+	pool_idx = fls(pool_idx >> PAGE_SHIFT) - 1;
+	if (pool_idx >= NUM_POOLS)
+		return false;
+	pool = manager->pools + pool_idx;
+
+	spin_lock_irqsave(&pool->lock, flags);
+
+	prev_link = io_buffer_pool_get_cache(pool, prot);
+	while ((cur = *prev_link)) {
+		if (cur->prot == prot) {
+			slot = cur;
+			*prev_link = cur->next;
+			break;
+		}
+		prev_link = &cur->next;
+	}
+
+	*new_buffer = slot == NULL;
+	if (*new_buffer) {
+		if (!io_buffer_pool_has_empty_slot(pool, manager->num_slots)) {
+			spin_unlock_irqrestore(&pool->lock, flags);
+			return false;
+		}
+
+		slot = pool->empty_slots;
+		pool->empty_slots = slot->next;
+		spin_unlock_irqrestore(&pool->lock, flags);
+
+		iova = io_buffer_slot_to_iova(slot, pool);
+
+		slot->bounce_buffer = io_buffer_manager_alloc_pages(
+			pool->buffer_size >> PAGE_SHIFT, nid);
+		if (!slot->bounce_buffer) {
+			spin_lock_irqsave(&pool->lock, flags);
+			slot->next = pool->empty_slots;
+			pool->empty_slots = slot;
+			spin_unlock_irqrestore(&pool->lock, flags);
+			return false;
+		}
+	} else {
+		spin_unlock_irqrestore(&pool->lock, flags);
+	}
+
+	slot->orig_buffer = orig_buffer;
+	slot->prot = prot;
+
+	fill_buffer_info(slot, pool, info);
+	return true;
+}
+
 bool io_buffer_manager_alloc_buffer(struct io_buffer_manager *manager,
 				    struct device *dev, void *orig_buffer,
 				    size_t size, int prot, unsigned int nid,
-				    struct io_bounce_buffer_info *info)
+				    struct io_bounce_buffer_info *info,
+				    bool *new_buffer)
 {
 	struct iommu_domain *domain = iommu_get_dma_domain(dev);
 	struct io_buffer_node *node;
 	unsigned long flags;
 
+	if (io_buffer_manager_alloc_slot(manager, orig_buffer, size, prot,
+					 nid, info, new_buffer))
+		return true;
+
 	node = kzalloc(sizeof(*node), GFP_ATOMIC);
 	if (!node)
 		return false;
@@ -131,6 +361,7 @@ bool io_buffer_manager_alloc_buffer(struct io_buffer_manager *manager,
 	node->info.size = size;
 
 	*info = node->info;
+	*new_buffer = true;
 
 	return true;
 
@@ -143,14 +374,49 @@ bool io_buffer_manager_alloc_buffer(struct io_buffer_manager *manager,
 	return false;
 }
 
+static bool __io_buffer_manager_find_slot(struct io_buffer_manager *manager,
+					  dma_addr_t handle,
+					  struct io_buffer_pool **pool,
+					  struct io_buffer_slot **slot)
+{
+	size_t i;
+	dma_addr_t iova_end = manager->iova + manager->iova_size;
+
+	if (!manager->num_slots || handle < manager->iova || handle >= iova_end)
+		return false;
+
+	// Pools are ordered from largest to smallest, and each pool is twice
+	// as large as the next pool. Find how far from the end of the overall
+	// allocation the handle is in terms of the size of the iova range
+	// assigned to the smallest pool (1-indexed), and then compute the idx.
+	i = ALIGN(iova_end - handle, PAGE_SIZE) >> PAGE_SHIFT;
+	i = DIV_ROUND_UP(i, manager->num_slots);
+	i = fls(i) - 1;
+
+	*pool = manager->pools + i;
+	*slot = (*pool)->slots +
+		(handle - (*pool)->iova_base) / (*pool)->buffer_size;
+
+	return true;
+}
+
 bool io_buffer_manager_find_buffer(struct io_buffer_manager *manager,
 				   dma_addr_t handle,
 				   struct io_bounce_buffer_info *info,
 				   void **orig_buffer, int *prot)
 {
+	struct io_buffer_pool *pool;
+	struct io_buffer_slot *slot;
 	struct io_buffer_node *node;
 	unsigned long flags;
 
+	if (__io_buffer_manager_find_slot(manager, handle, &pool, &slot)) {
+		fill_buffer_info(slot, pool, info);
+		*orig_buffer = slot->orig_buffer;
+		*prot = slot->prot;
+		return true;
+	}
+
 	spin_lock_irqsave(&manager->fallback_lock, flags);
 	node = find_fallback_node(&manager->fallback_buffers, handle);
 	spin_unlock_irqrestore(&manager->fallback_lock, flags);
@@ -169,10 +435,45 @@ bool io_buffer_manager_release_buffer(struct io_buffer_manager *manager,
 				      dma_addr_t handle, bool inited,
 				      prerelease_cb cb, void *ctx)
 {
+	struct io_buffer_slot *slot, **cache;
+	struct io_buffer_pool *pool;
 	struct io_buffer_node *node;
 	unsigned long flags;
 	bool free_buffer;
 
+	if (__io_buffer_manager_find_slot(manager, handle, &pool, &slot)) {
+		if (cb) {
+			struct io_bounce_buffer_info info;
+
+			fill_buffer_info(slot, pool, &info);
+			cb(&info, slot->prot, slot->orig_buffer, ctx);
+		}
+
+		spin_lock_irqsave(&pool->lock, flags);
+
+		if (likely(inited)) {
+			cache = io_buffer_pool_get_cache(pool, slot->prot);
+			if (*cache == NULL)
+				queue_delayed_work(
+					manager->evict_wq, &manager->evict_work,
+					msecs_to_jiffies(EVICT_PERIOD_MSEC));
+
+			slot->orig_buffer = NULL;
+			slot->next = *cache;
+			*cache = slot;
+			slot->old_cache_entry = false;
+		} else {
+			io_buffer_manager_free_pages(slot->bounce_buffer,
+						     pool->buffer_size >>
+							     PAGE_SHIFT);
+			slot->next = pool->empty_slots;
+			pool->empty_slots = slot;
+		}
+
+		spin_unlock_irqrestore(&pool->lock, flags);
+		return true;
+	}
+
 	spin_lock_irqsave(&manager->fallback_lock, flags);
 	node = find_fallback_node(&manager->fallback_buffers, handle);
 	if (node)
@@ -204,10 +505,122 @@ bool io_buffer_manager_release_buffer(struct io_buffer_manager *manager,
 	return true;
 }
 
-int io_buffer_manager_init(struct io_buffer_manager *manager)
+void io_buffer_manager_destroy(struct io_buffer_manager *manager,
+			       struct iommu_domain *domain)
+{
+	int i;
+
+	if (!manager->num_slots)
+		return;
+
+	cancel_delayed_work_sync(&manager->evict_work);
+	destroy_workqueue(manager->evict_wq);
+	__io_buffer_manager_evict(manager, true);
+	__iommu_dma_free_iova(domain->iova_cookie, manager->iova,
+			      manager->iova_size, NULL);
+
+	for (i = 0; i < NUM_POOLS; i++)
+		kfree(manager->pools[i].slots);
+}
+
+bool io_buffer_manager_reinit_check(struct io_buffer_manager *manager,
+				    struct device *dev,
+				    struct iova_domain *iovad, dma_addr_t base,
+				    dma_addr_t limit)
+{
+	struct iommu_domain *domain = iommu_get_dma_domain(dev);
+	u64 dma_limit = __iommu_dma_limit(domain, dev, dma_get_mask(dev));
+	dma_addr_t start_iova = iovad->start_pfn << iovad->granule;
+
+	if (!manager->num_slots)
+		return true;
+
+	if (base > manager->iova ||
+	    limit < manager->iova + manager->iova_size) {
+		pr_warn("Bounce buffer pool out of range\n");
+		return false;
+	}
+
+	if (~dma_limit & (manager->iova + manager->iova_size - 1)) {
+		pr_warn("Bounce buffer pool larger than dma limit\n");
+		return false;
+	}
+
+	if (manager->iova_size > (dma_limit - start_iova) / 2)
+		pr_info("Bounce buffer pool using >1/2 of iova range\n");
+
+	return true;
+}
+
+int io_buffer_manager_init(struct io_buffer_manager *manager,
+			   struct device *dev, struct iova_domain *iovad,
+			   unsigned int num_slots)
 {
+	struct iommu_domain *domain = iommu_get_dma_domain(dev);
+	int i;
+	unsigned int old_num_slots = num_slots;
+	size_t reserved_iova_pages, pages_per_slot, max_reserved_iova_pages;
+	dma_addr_t iova_base;
+	u64 dma_limit, start_iova;
+
 	manager->fallback_buffers = RB_ROOT;
 	spin_lock_init(&manager->fallback_lock);
 
+	if (num_slots == 0)
+		return 0;
+
+	INIT_DELAYED_WORK(&manager->evict_work, io_buffer_manager_evict);
+	manager->evict_wq = create_singlethread_workqueue("io-buffer-buffers");
+	if (!manager->evict_wq)
+		return -ENOMEM;
+
+	// Make sure there are iovas left over for non-pooled buffers. The iova
+	// allocation can be quite large, so also handle allocation falures due
+	// to reserved iova regions.
+	dma_limit = __iommu_dma_limit(domain, dev, dma_get_mask(dev));
+	start_iova = iovad->start_pfn << iovad->granule;
+	max_reserved_iova_pages = ((dma_limit - start_iova) / 2) >> PAGE_SHIFT;
+	pages_per_slot = (1 << NUM_POOLS) - 1;
+	do {
+		reserved_iova_pages = pages_per_slot * num_slots;
+		if (reserved_iova_pages > max_reserved_iova_pages) {
+			num_slots = max_reserved_iova_pages / pages_per_slot;
+			reserved_iova_pages = pages_per_slot * num_slots;
+		}
+
+		manager->iova_size = reserved_iova_pages << PAGE_SHIFT;
+		manager->iova = __iommu_dma_alloc_iova(
+			domain, manager->iova_size, dma_get_mask(dev), dev);
+		max_reserved_iova_pages /= 2;
+	} while (!manager->iova && max_reserved_iova_pages >= pages_per_slot);
+
+	if (!manager->iova) {
+		destroy_workqueue(manager->evict_wq);
+		return -ENOSPC;
+	} else if (num_slots < old_num_slots) {
+		pr_info("Insufficient space for %u slots, limited to %u\n",
+			old_num_slots, num_slots);
+	}
+	manager->num_slots = num_slots;
+
+	// To ensure that no slot has a segment which crosses a segment
+	// boundary, align each slot's iova to the slot's size.
+	// __iommu_dma_alloc_iova aligns to roundup_power_of_two(size), which
+	// is larger than the largest buffer size. Assigning iova_base from
+	// largest to smallest ensures each iova_base is aligned to the
+	// previous pool's larger size.
+	iova_base = manager->iova;
+	for (i = NUM_POOLS - 1; i >= 0; i--) {
+		struct io_buffer_pool *pool = manager->pools + i;
+
+		spin_lock_init(&pool->lock);
+		pool->empty_slots = NULL;
+		pool->untouched_slot_idx = 0;
+		pool->buffer_size = PAGE_SIZE << i;
+		pool->iova_base = iova_base;
+
+		iova_base += num_slots * pool->buffer_size;
+	}
+
 	return 0;
 }
diff --git a/drivers/iommu/io-buffer-manager.h b/drivers/iommu/io-buffer-manager.h
index 0e75d89926ca..2aa3b9afcb3d 100644
--- a/drivers/iommu/io-buffer-manager.h
+++ b/drivers/iommu/io-buffer-manager.h
@@ -9,10 +9,44 @@
 #include <linux/dma-iommu.h>
 #include <linux/iova.h>
 #include <linux/spinlock.h>
+#include <linux/workqueue.h>
+
+struct io_buffer_slot {
+	void *orig_buffer;
+	struct page **bounce_buffer;
+	struct io_buffer_slot *next;
+	int prot;
+	bool old_cache_entry;
+};
+
+enum io_buffer_slot_type {
+	IO_BUFFER_SLOT_TYPE_RO = 0,
+	IO_BUFFER_SLOT_TYPE_WO,
+	IO_BUFFER_SLOT_TYPE_RW,
+	IO_BUFFER_SLOT_TYPE_COUNT,
+};
+
+struct io_buffer_pool {
+	struct io_buffer_slot *cached_slots[IO_BUFFER_SLOT_TYPE_COUNT];
+	struct io_buffer_slot *empty_slots;
+	unsigned int untouched_slot_idx;
+	spinlock_t lock;
+	dma_addr_t iova_base;
+	size_t buffer_size;
+	struct io_buffer_slot *slots;
+};
+
+#define NUM_POOLS 8
 
 struct io_buffer_manager {
+	struct workqueue_struct *evict_wq;
+	struct delayed_work evict_work;
+	unsigned int num_slots;
 	spinlock_t fallback_lock;
 	struct rb_root fallback_buffers;
+	struct io_buffer_pool pools[NUM_POOLS];
+	dma_addr_t iova;
+	size_t iova_size;
 };
 
 struct io_bounce_buffer_info {
@@ -24,7 +58,8 @@ struct io_bounce_buffer_info {
 bool io_buffer_manager_alloc_buffer(struct io_buffer_manager *manager,
 				    struct device *dev, void *orig_buffer,
 				    size_t size, int prot, unsigned int nid,
-				    struct io_bounce_buffer_info *info);
+				    struct io_bounce_buffer_info *info,
+				    bool *new_buffer);
 
 bool io_buffer_manager_find_buffer(struct io_buffer_manager *manager,
 				   dma_addr_t handle,
@@ -39,7 +74,17 @@ bool io_buffer_manager_release_buffer(struct io_buffer_manager *manager,
 				      dma_addr_t handle, bool inited,
 				      prerelease_cb cb, void *ctx);
 
-int io_buffer_manager_init(struct io_buffer_manager *manager);
+int io_buffer_manager_init(struct io_buffer_manager *manager,
+			   struct device *dev, struct iova_domain *iovad,
+			   unsigned int num_slots);
+
+bool io_buffer_manager_reinit_check(struct io_buffer_manager *manager,
+				    struct device *dev,
+				    struct iova_domain *iovad, dma_addr_t base,
+				    dma_addr_t limit);
+
+void io_buffer_manager_destroy(struct io_buffer_manager *manager,
+			       struct iommu_domain *domain);
 
 bool io_bounce_buffers_release_buffer_cb(struct io_buffer_manager *manager,
 					 dma_addr_t iova, size_t size);
diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
index 50f676678318..944fd491d94f 100644
--- a/include/linux/dma-iommu.h
+++ b/include/linux/dma-iommu.h
@@ -49,6 +49,8 @@ dma_addr_t __iommu_dma_alloc_iova(struct iommu_domain *domain,
 				  struct device *dev);
 void __iommu_dma_free_iova(struct iommu_dma_cookie *cookie,
 		dma_addr_t iova, size_t size, struct page *freelist);
+u64 __iommu_dma_limit(struct iommu_domain *domain,
+		      struct device *dev, u64 mask);
 
 #else /* CONFIG_IOMMU_DMA */
 
-- 
2.32.0.605.g8dce9f2422-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
