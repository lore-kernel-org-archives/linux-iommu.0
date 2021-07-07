Return-Path: <SRS0=iPMr=L7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D80C07E9E
	for <iommu@archiver.kernel.org>; Wed,  7 Jul 2021 07:55:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58CF361CB0
	for <iommu@archiver.kernel.org>; Wed,  7 Jul 2021 07:55:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58CF361CB0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 31FDC4000B;
	Wed,  7 Jul 2021 07:55:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OztDrFvr3uvy; Wed,  7 Jul 2021 07:55:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4655E40215;
	Wed,  7 Jul 2021 07:55:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2E7EBC0010;
	Wed,  7 Jul 2021 07:55:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8F54DC000E
 for <iommu@lists.linux-foundation.org>; Wed,  7 Jul 2021 07:55:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 724E983252
 for <iommu@lists.linux-foundation.org>; Wed,  7 Jul 2021 07:55:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=chromium.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QWNHWAY5ZARy for <iommu@lists.linux-foundation.org>;
 Wed,  7 Jul 2021 07:55:40 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DC5F88333F
 for <iommu@lists.linux-foundation.org>; Wed,  7 Jul 2021 07:55:40 +0000 (UTC)
Received: by mail-pl1-x629.google.com with SMTP id o4so620003plg.1
 for <iommu@lists.linux-foundation.org>; Wed, 07 Jul 2021 00:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=e134orQ9ELEz4qxFeLbufAylaJHKhytS2YuIyFFD4NE=;
 b=LadPjXgucRVJoGrABLUVq22ohKOUMms7OhX9MpdafmYDZaEqTCI+LOHP5O1xoN9fG4
 jEna0IDOMlcu8lsOzOg3n/9C/cS180r33e467LrHQhxZeZ+kRpgav1f72nkc97EwOEUu
 bNOYwlp9+GuRMsqfGPpbHaNTwoFSJNp+6sx5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=e134orQ9ELEz4qxFeLbufAylaJHKhytS2YuIyFFD4NE=;
 b=F/f44xpTfSh9/qLeUrqkZoz9y8uuaT1M4GHJlAzEMyHO65Uk9hXSW3BEbns+BwC9xc
 zSEEYZKYxS/90F0Ytl4g8fZlzVYA9LGE6Md1zGaa1JE0rjm3u2LetwLWQXdFW0SsBPQJ
 lFYQ+4ApJ8TTdOIlwO+jM2IvqPK18GxK89evdaRvUvIFCuZVHv3B0LR3C5uef+VebpDO
 DkRWI8vINNob79E+kC93O2l/ffdUS6mip6h8cubpwVNxp5ai8Hn2nXENGTqz+QUEzl6j
 A7GZ3QzO2gVMpN1rexODSkSs1FTWDEb4seENTtvCABGzyyyOuxB6DLAheMjYXpYFACdt
 +nlg==
X-Gm-Message-State: AOAM530TSEp3ugsbD8MU0bxjoScsgNSDEKkGs0S8mt6GIMIXy5ATQPjn
 fsqPe9mfGDdQiDLYadI1j1KSQw==
X-Google-Smtp-Source: ABdhPJyiChTbK9xZ9TuLxlknFFFIsqW9wdRhw1ljciiXX1fOUVaF9lL2SAfqLg15Q43M4NuNcVFX6w==
X-Received: by 2002:a17:902:fe84:b029:128:cd7a:c06f with SMTP id
 x4-20020a170902fe84b0290128cd7ac06fmr20338841plm.46.1625644540183; 
 Wed, 07 Jul 2021 00:55:40 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:355a:c470:1237:e5f4])
 by smtp.gmail.com with UTF8SMTPSA id bp4sm5298672pjb.53.2021.07.07.00.55.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Jul 2021 00:55:39 -0700 (PDT)
From: David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Subject: [PATCH 4/4] dma-iommu: Add iommu bounce buffers to dma-iommu api
Date: Wed,  7 Jul 2021 16:55:05 +0900
Message-Id: <20210707075505.2896824-5-stevensd@google.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
In-Reply-To: <20210707075505.2896824-1-stevensd@google.com>
References: <20210707075505.2896824-1-stevensd@google.com>
MIME-Version: 1.0
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
 iommu@lists.linux-foundation.org, David Stevens <stevensd@chromium.org>,
 Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
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

Add support for per-domain dynamic pools of iommu bounce buffers to the
dma-iommu api. When enabled, all non-direct streaming mappings below a
configurable size will go through bounce buffers.

Each domain has its own buffer pool. Each buffer pool is split into
multiple power-of-2 size classes. Each class has a number of
preallocated slots that can hold bounce buffers. Bounce buffers are
allocated on demand, and unmapped bounce buffers are stored in a cache
with periodic eviction of unused cache entries. As the buffer pool is an
optimization, any failures simply result in falling back to the normal
dma-iommu handling.

Signed-off-by: David Stevens <stevensd@chromium.org>
---
 drivers/iommu/Kconfig          |  10 +
 drivers/iommu/Makefile         |   1 +
 drivers/iommu/dma-iommu.c      |  75 +++-
 drivers/iommu/io-buffer-pool.c | 656 +++++++++++++++++++++++++++++++++
 drivers/iommu/io-buffer-pool.h |  91 +++++
 5 files changed, 826 insertions(+), 7 deletions(-)
 create mode 100644 drivers/iommu/io-buffer-pool.c
 create mode 100644 drivers/iommu/io-buffer-pool.h

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 1f111b399bca..6eee57b03ff9 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -420,4 +420,14 @@ config SPRD_IOMMU
 
 	  Say Y here if you want to use the multimedia devices listed above.
 
+config IOMMU_IO_BUFFER
+	bool "Use IOMMU bounce buffers"
+	depends on IOMMU_DMA
+	help
+	  Use bounce buffers for small, streaming DMA operations. This may
+	  have performance benefits on systems where establishing IOMMU mappings
+	  is particularly expensive, such as when running as a guest.
+
+	  If unsure, say N here.
+
 endif # IOMMU_SUPPORT
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index c0fb0ba88143..2287b2e3d92d 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -5,6 +5,7 @@ obj-$(CONFIG_IOMMU_API) += iommu-traces.o
 obj-$(CONFIG_IOMMU_API) += iommu-sysfs.o
 obj-$(CONFIG_IOMMU_DEBUGFS) += iommu-debugfs.o
 obj-$(CONFIG_IOMMU_DMA) += dma-iommu.o
+obj-$(CONFIG_IOMMU_IO_BUFFER) += io-buffer-pool.o
 obj-$(CONFIG_IOMMU_IO_PGTABLE) += io-pgtable.o
 obj-$(CONFIG_IOMMU_IO_PGTABLE_ARMV7S) += io-pgtable-arm-v7s.o
 obj-$(CONFIG_IOMMU_IO_PGTABLE_LPAE) += io-pgtable-arm.o
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 48267d9f5152..1d2cfbbe03c1 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -26,6 +26,8 @@
 #include <linux/crash_dump.h>
 #include <linux/dma-direct.h>
 
+#include "io-buffer-pool.h"
+
 struct iommu_dma_msi_page {
 	struct list_head	list;
 	dma_addr_t		iova;
@@ -46,6 +48,7 @@ struct iommu_dma_cookie {
 		dma_addr_t		msi_iova;
 	};
 	struct list_head		msi_page_list;
+	struct io_buffer_pool		*bounce_buffers;
 
 	/* Domain for flush queue callback; NULL if flush queue not in use */
 	struct iommu_domain		*fq_domain;
@@ -83,6 +86,14 @@ static inline size_t cookie_msi_granule(struct iommu_dma_cookie *cookie)
 	return PAGE_SIZE;
 }
 
+static inline struct io_buffer_pool *dev_to_io_buffer_pool(struct device *dev)
+{
+	struct iommu_domain *domain = iommu_get_dma_domain(dev);
+	struct iommu_dma_cookie *cookie = domain->iova_cookie;
+
+	return cookie->bounce_buffers;
+}
+
 static struct iommu_dma_cookie *cookie_alloc(enum iommu_dma_cookie_type type)
 {
 	struct iommu_dma_cookie *cookie;
@@ -162,6 +173,9 @@ void iommu_put_dma_cookie(struct iommu_domain *domain)
 	if (!cookie)
 		return;
 
+	if (IS_ENABLED(CONFIG_IOMMU_IO_BUFFER))
+		io_buffer_pool_destroy(cookie->bounce_buffers);
+
 	if (cookie->type == IOMMU_DMA_IOVA_COOKIE && cookie->iovad.granule)
 		put_iova_domain(&cookie->iovad);
 
@@ -334,6 +348,7 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
 	unsigned long order, base_pfn;
 	struct iova_domain *iovad;
+	int ret;
 
 	if (!cookie || cookie->type != IOMMU_DMA_IOVA_COOKIE)
 		return -EINVAL;
@@ -381,7 +396,13 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
 	if (!dev)
 		return 0;
 
-	return iova_reserve_iommu_regions(dev, domain);
+	ret = iova_reserve_iommu_regions(dev, domain);
+
+	if (ret == 0 && IS_ENABLED(CONFIG_IOMMU_IO_BUFFER))
+		ret = io_buffer_pool_init(dev, domain, iovad,
+					  &cookie->bounce_buffers);
+
+	return ret;
 }
 
 /**
@@ -537,11 +558,10 @@ static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
 }
 
 static dma_addr_t __iommu_dma_map_swiotlb(struct device *dev, phys_addr_t phys,
-		size_t org_size, dma_addr_t dma_mask, bool coherent,
+		size_t org_size, dma_addr_t dma_mask, int prot,
 		enum dma_data_direction dir, unsigned long attrs,
 		phys_addr_t *adj_phys)
 {
-	int prot = dma_info_to_prot(dir, coherent, attrs);
 	struct iommu_domain *domain = iommu_get_dma_domain(dev);
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
 	struct iova_domain *iovad = &cookie->iovad;
@@ -781,6 +801,11 @@ static void iommu_dma_sync_single_for_cpu(struct device *dev,
 {
 	phys_addr_t phys;
 
+	if (IS_ENABLED(CONFIG_IOMMU_IO_BUFFER) &&
+	    io_buffer_pool_sync_single(dev_to_io_buffer_pool(dev), dma_handle,
+				       size, dir, true))
+		return;
+
 	if (dev_is_dma_coherent(dev) && !dev_use_swiotlb(dev))
 		return;
 
@@ -796,6 +821,11 @@ static void __iommu_dma_sync_single_for_device(struct device *dev,
 		dma_addr_t dma_handle, size_t size,
 		enum dma_data_direction dir, phys_addr_t phys)
 {
+	if (IS_ENABLED(CONFIG_IOMMU_IO_BUFFER) &&
+	    io_buffer_pool_sync_single(dev_to_io_buffer_pool(dev), dma_handle,
+				       size, dir, false))
+		return;
+
 	if (dev_is_dma_coherent(dev) && !dev_use_swiotlb(dev))
 		return;
 
@@ -823,6 +853,11 @@ static void iommu_dma_sync_sg_for_cpu(struct device *dev,
 	struct scatterlist *sg;
 	int i;
 
+	if (IS_ENABLED(CONFIG_IOMMU_IO_BUFFER) &&
+	    io_buffer_pool_sync_sg(dev_to_io_buffer_pool(dev),
+				   sgl, nelems, dir, true))
+		return;
+
 	if (dev_is_dma_coherent(dev) && !dev_use_swiotlb(dev))
 		return;
 
@@ -842,6 +877,11 @@ static void iommu_dma_sync_sg_for_device(struct device *dev,
 	struct scatterlist *sg;
 	int i;
 
+	if (IS_ENABLED(CONFIG_IOMMU_IO_BUFFER) &&
+	    io_buffer_pool_sync_sg(dev_to_io_buffer_pool(dev),
+				   sgl, nelems, dir, false))
+		return;
+
 	if (dev_is_dma_coherent(dev) && !dev_use_swiotlb(dev))
 		return;
 
@@ -861,10 +901,17 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 {
 	phys_addr_t phys = page_to_phys(page) + offset, adj_phys;
 	bool coherent = dev_is_dma_coherent(dev);
-	dma_addr_t dma_handle;
+	int prot = dma_info_to_prot(dir, coherent, attrs);
+	dma_addr_t dma_handle = DMA_MAPPING_ERROR;
+
+	if (IS_ENABLED(CONFIG_IOMMU_IO_BUFFER))
+		dma_handle = io_buffer_pool_map_page(dev_to_io_buffer_pool(dev),
+				page, offset, size, prot, attrs);
+
+	if (dma_handle == DMA_MAPPING_ERROR)
+		dma_handle = __iommu_dma_map_swiotlb(dev, phys, size,
+				dma_get_mask(dev), prot, dir, attrs, &adj_phys);
 
-	dma_handle = __iommu_dma_map_swiotlb(dev, phys, size,
-			dma_get_mask(dev), coherent, dir, attrs, &adj_phys);
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
 	    dma_handle != DMA_MAPPING_ERROR)
 		__iommu_dma_sync_single_for_device(dev, dma_handle, size,
@@ -877,6 +924,11 @@ static void iommu_dma_unmap_page(struct device *dev, dma_addr_t dma_handle,
 {
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
 		iommu_dma_sync_single_for_cpu(dev, dma_handle, size, dir);
+
+	if (IS_ENABLED(CONFIG_IOMMU_IO_BUFFER) &&
+	    io_buffer_pool_unmap_buffer(dev_to_io_buffer_pool(dev), dma_handle))
+		return;
+
 	__iommu_dma_unmap_swiotlb(dev, dma_handle, size, dir, attrs);
 }
 
@@ -1012,7 +1064,11 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
 	    iommu_deferred_attach(dev, domain))
 		return 0;
 
-	if (dev_use_swiotlb(dev)) {
+	if (IS_ENABLED(CONFIG_IOMMU_IO_BUFFER))
+		early_mapped = io_buffer_pool_map_sg(cookie->bounce_buffers,
+				dev, sg, nents, prot, attrs);
+
+	if (!early_mapped && dev_use_swiotlb(dev)) {
 		early_mapped = iommu_dma_map_sg_swiotlb(dev, sg, nents,
 							dir, attrs);
 		if (!early_mapped)
@@ -1110,6 +1166,11 @@ static void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
 		sg = tmp;
 	}
 	end = sg_dma_address(sg) + sg_dma_len(sg);
+
+	if (IS_ENABLED(CONFIG_IOMMU_IO_BUFFER) &&
+	    io_buffer_pool_unmap_buffer(dev_to_io_buffer_pool(dev), start))
+		return;
+
 	__iommu_dma_unmap(dev, start, end - start);
 }
 
diff --git a/drivers/iommu/io-buffer-pool.c b/drivers/iommu/io-buffer-pool.c
new file mode 100644
index 000000000000..3f6f32411889
--- /dev/null
+++ b/drivers/iommu/io-buffer-pool.c
@@ -0,0 +1,656 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Dynamic pools of IOMMU mapped bounce buffers.
+ *
+ * Copyright (C) 2021 Google, Inc.
+ */
+
+#include <linux/dma-iommu.h>
+#include <linux/dma-map-ops.h>
+#include <linux/highmem.h>
+#include <linux/list.h>
+#include <linux/moduleparam.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/swiotlb.h>
+#include <linux/workqueue.h>
+
+#include "io-buffer-pool.h"
+
+struct io_buffer_slot {
+	struct list_head list;
+	void *orig_buffer;
+	struct page **bounce_buffer;
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
+struct io_buffer_class {
+	struct list_head cached_slots[IO_BUFFER_SLOT_TYPE_COUNT];
+	struct list_head empty_slots;
+	spinlock_t lock;
+	dma_addr_t unaligned_iova;
+	dma_addr_t iova_base;
+	size_t buffer_size;
+	struct io_buffer_slot *slots;
+};
+
+struct io_buffer_pool {
+	struct workqueue_struct *evict_wq;
+	struct delayed_work evict_work;
+	struct iommu_domain *domain;
+	unsigned int nid;
+	struct io_buffer_class classes[];
+};
+
+#define EVICT_PERIOD_MSEC 5000
+
+static unsigned int num_slots = 1024;
+module_param(num_slots, uint, 0);
+
+// A bitmask which selects the buffer classes used by the pool. Bit i enables
+// a class with buffer size (1 << i) * PAGE_SIZE.
+static u8 class_sizes = 32 | 4 | 1;
+module_param(class_sizes, byte, 0);
+static unsigned int num_classes;
+
+static unsigned int init_num_classes(void)
+{
+	unsigned char sizes_mask = class_sizes;
+	unsigned int count = 0;
+
+	while (sizes_mask) {
+		count += (sizes_mask & 1);
+		sizes_mask >>= 1;
+	}
+
+	num_classes = count;
+	return num_classes;
+}
+
+static dma_addr_t io_buffer_slot_to_iova(struct io_buffer_slot *slot,
+					 struct io_buffer_class *class)
+{
+	return class->iova_base + class->buffer_size * (slot - class->slots);
+}
+
+static struct list_head *
+io_buffer_class_get_cache(struct io_buffer_class *class, int prot)
+{
+	prot &= (IOMMU_READ | IOMMU_WRITE);
+	if (prot == IOMMU_READ)
+		return &class->cached_slots[IO_BUFFER_SLOT_TYPE_RO];
+	else if (prot == IOMMU_WRITE)
+		return &class->cached_slots[IO_BUFFER_SLOT_TYPE_WO];
+	BUG_ON(prot == 0);
+	return &class->cached_slots[IO_BUFFER_SLOT_TYPE_RW];
+}
+
+static bool io_buffer_pool_free_slot(struct io_buffer_pool *pool,
+				     struct io_buffer_class *class,
+				     struct io_buffer_slot *slot)
+{
+	dma_addr_t iova = io_buffer_slot_to_iova(slot, class);
+	size_t unmapped;
+
+	unmapped = iommu_unmap(pool->domain, iova, class->buffer_size);
+
+	if (unmapped != class->buffer_size) {
+		pr_err("Failed to unmap bounce buffer, leaking buffer.\n");
+		return false;
+	}
+
+	__iommu_dma_free_pages(slot->bounce_buffer,
+			       class->buffer_size >> PAGE_SHIFT);
+	return true;
+}
+
+static void __io_buffer_pool_evict(struct io_buffer_pool *pool,
+				   bool pool_teardown)
+{
+	struct io_buffer_class *class;
+	struct io_buffer_slot *slot;
+	struct list_head *cache;
+	unsigned long flags;
+	int i, j;
+	bool requeue = false, freed;
+
+	for (i = 0; i < num_classes; i++) {
+		class = &pool->classes[i];
+
+		spin_lock_irqsave(&class->lock, flags);
+		for (j = 0; j < IO_BUFFER_SLOT_TYPE_COUNT; j++) {
+			cache = &class->cached_slots[j];
+
+			while (!list_empty(cache)) {
+				slot = list_last_entry(
+					cache, struct io_buffer_slot, list);
+				if (!pool_teardown && !slot->old_cache_entry)
+					break;
+				list_del(&slot->list);
+				spin_unlock_irqrestore(&class->lock, flags);
+
+				freed = io_buffer_pool_free_slot(pool, class,
+								 slot);
+
+				spin_lock_irqsave(&class->lock, flags);
+
+				// If the iova is in an unknown state, then
+				// give up on the slot altogether.
+				if (freed)
+					list_add(&slot->list,
+						 &class->empty_slots);
+			}
+
+			list_for_each_entry(slot, cache, list) {
+				slot->old_cache_entry = true;
+				requeue = true;
+			}
+		}
+		spin_unlock_irqrestore(&class->lock, flags);
+	}
+
+	if (!pool_teardown && requeue)
+		queue_delayed_work(pool->evict_wq, &pool->evict_work,
+				   msecs_to_jiffies(EVICT_PERIOD_MSEC));
+}
+
+static void io_buffer_pool_evict(struct work_struct *work)
+{
+	struct io_buffer_pool *pool = container_of(
+		to_delayed_work(work), struct io_buffer_pool, evict_work);
+	__io_buffer_pool_evict(pool, false);
+}
+
+int io_buffer_class_init(struct io_buffer_class *class, struct device *dev,
+			 struct iommu_domain *domain, size_t buffer_size)
+{
+	int i;
+
+	class->slots = kcalloc(num_slots, sizeof(*class->slots), GFP_KERNEL);
+	if (!class->slots)
+		return -ENOMEM;
+
+	spin_lock_init(&class->lock);
+	for (i = 0; i < IO_BUFFER_SLOT_TYPE_COUNT; i++)
+		INIT_LIST_HEAD(&class->cached_slots[i]);
+	INIT_LIST_HEAD(&class->empty_slots);
+	for (i = 0; i < num_slots; i++)
+		list_add_tail(&class->slots[i].list, &class->empty_slots);
+
+	class->buffer_size = buffer_size;
+	class->unaligned_iova = __iommu_dma_alloc_iova(
+		domain, buffer_size * (num_slots + 1), dma_get_mask(dev), dev);
+	if (!class->unaligned_iova) {
+		kfree(class->slots);
+		return -ENOSPC;
+	}
+
+	// Since the class's buffer size is a power of 2, aligning the
+	// class's base iova to that power of 2 ensures that no slot has
+	// has a segment which falls across a segment boundary.
+	class->iova_base = ALIGN(class->unaligned_iova, class->buffer_size);
+	return 0;
+}
+
+int io_buffer_pool_init(struct device *dev, struct iommu_domain *domain,
+			struct iova_domain *iovad,
+			struct io_buffer_pool **pool_out)
+{
+	int i, ret;
+	u8 class_size_mask;
+	struct io_buffer_pool *pool = *pool_out;
+
+	if (pool) {
+		for (i = 0; i < num_classes; i++) {
+			struct io_buffer_class *class = pool->classes + i;
+			dma_addr_t iova_end = class->iova_base +
+					      class->buffer_size * num_slots;
+			if (~dma_get_mask(dev) & (iova_end - 1)) {
+				pr_err("io-buffer-pool out of range of %s\n",
+				       dev_name(dev));
+				return -EFAULT;
+			}
+		}
+		if (pool->nid != dev_to_node(dev))
+			pr_warn("node mismatch: pool=%d dev=%d\n", pool->nid,
+				dev_to_node(dev));
+		return 0;
+	}
+
+	*pool_out = NULL;
+
+	if (init_num_classes() == 0 || num_slots == 0)
+		return 0;
+
+	pool = kzalloc(sizeof(*pool) +
+			       sizeof(struct io_buffer_class) * num_classes,
+		       GFP_KERNEL);
+	if (!pool)
+		return -ENOMEM;
+
+	INIT_DELAYED_WORK(&pool->evict_work, io_buffer_pool_evict);
+	pool->evict_wq = create_singlethread_workqueue("io-buffer-pool");
+	if (!pool->evict_wq) {
+		ret = -ENOMEM;
+		goto out_wq_alloc_fail;
+	}
+
+	for (i = 0, class_size_mask = class_sizes; i < num_classes; i++) {
+		int bit_idx;
+		size_t buffer_size;
+
+		bit_idx = ffs(class_size_mask) - 1;
+		BUG_ON(bit_idx < 0);
+		buffer_size = iova_align(iovad, PAGE_SIZE) << bit_idx;
+		class_size_mask &= ~(1 << bit_idx);
+
+		ret = io_buffer_class_init(pool->classes + i, dev, domain,
+					   buffer_size);
+		if (ret)
+			goto out_class_init_fail;
+	}
+
+	pool->domain = domain;
+	pool->nid = dev_to_node(dev);
+
+	*pool_out = pool;
+	return 0;
+
+out_class_init_fail:
+	while (--i >= 0) {
+		struct io_buffer_class *class = pool->classes + i;
+
+		__iommu_dma_free_iova(domain->iova_cookie,
+				      class->unaligned_iova,
+				      class->buffer_size * (num_slots + 1),
+				      NULL);
+		kfree(class->slots);
+	}
+	destroy_workqueue(pool->evict_wq);
+out_wq_alloc_fail:
+	kfree(pool);
+	return ret;
+}
+
+void io_buffer_pool_destroy(struct io_buffer_pool *pool)
+{
+	int i;
+
+	if (!pool)
+		return;
+
+	cancel_delayed_work_sync(&pool->evict_work);
+	destroy_workqueue(pool->evict_wq);
+	__io_buffer_pool_evict(pool, true);
+
+	for (i = 0; i < num_classes; i++) {
+		struct io_buffer_class *class = pool->classes + i;
+
+		__iommu_dma_free_iova(pool->domain->iova_cookie,
+				      class->unaligned_iova,
+				      class->buffer_size * (num_slots + 1),
+				      NULL);
+		kfree(class->slots);
+	}
+	kfree(pool);
+}
+
+static bool io_buffer_pool_find_buffer(struct io_buffer_pool *pool,
+				       dma_addr_t handle,
+				       struct io_buffer_class **class,
+				       struct io_buffer_slot **slot)
+{
+	int i;
+	struct io_buffer_class *cur;
+
+	for (i = 0; i < num_classes; i++) {
+		cur = pool->classes + i;
+		if (handle >= cur->iova_base &&
+		    handle < cur->iova_base + cur->buffer_size * num_slots) {
+			*class = cur;
+			*slot = cur->slots +
+				(handle - cur->iova_base) / cur->buffer_size;
+			return true;
+		}
+	}
+	return false;
+}
+
+bool io_buffer_pool_unmap_buffer(struct io_buffer_pool *pool, dma_addr_t handle)
+{
+	struct io_buffer_slot *slot;
+	struct io_buffer_class *class;
+	struct list_head *cache;
+	unsigned long flags;
+
+	if (!pool || !io_buffer_pool_find_buffer(pool, handle, &class, &slot))
+		return false;
+
+	spin_lock_irqsave(&class->lock, flags);
+
+	cache = io_buffer_class_get_cache(class, slot->prot);
+	if (list_empty(cache))
+		queue_delayed_work(pool->evict_wq, &pool->evict_work,
+				   msecs_to_jiffies(EVICT_PERIOD_MSEC));
+
+	slot->orig_buffer = NULL;
+	list_add(&slot->list, cache);
+	slot->old_cache_entry = false;
+
+	spin_unlock_irqrestore(&class->lock, flags);
+	return true;
+}
+
+static bool io_buffer_pool_fill_slot(struct io_buffer_pool *pool,
+				     struct io_buffer_class *class,
+				     struct io_buffer_slot *slot, int prot)
+{
+	dma_addr_t iova = io_buffer_slot_to_iova(slot, class);
+	struct sg_table sgt;
+	unsigned int count;
+	size_t mapped = 0;
+
+	count = class->buffer_size >> PAGE_SHIFT;
+	slot->bounce_buffer = __iommu_dma_alloc_pages(
+		count, (pool->domain->pgsize_bitmap | PAGE_SIZE) >> PAGE_SHIFT,
+		pool->nid, GFP_ATOMIC, GFP_ATOMIC);
+	if (!slot->bounce_buffer)
+		return false;
+
+	if (sg_alloc_table_from_pages(&sgt, slot->bounce_buffer, count, 0,
+				      class->buffer_size, GFP_ATOMIC))
+		goto out_free_pages;
+
+	mapped = iommu_map_sg_atomic(pool->domain, iova, sgt.sgl,
+				     sgt.orig_nents, prot);
+
+	sg_free_table(&sgt);
+
+out_free_pages:
+	if (mapped < class->buffer_size) {
+		__iommu_dma_free_pages(slot->bounce_buffer, count);
+		return false;
+	}
+
+	slot->prot = prot;
+	return true;
+}
+
+static dma_addr_t io_buffer_pool_map_buffer(struct io_buffer_pool *pool,
+					    void *orig_buffer, size_t size,
+					    int prot, unsigned long attrs)
+{
+	struct io_buffer_slot *slot = NULL, *tmp;
+	struct io_buffer_class *class = NULL;
+	struct list_head *cache;
+	unsigned long flags;
+	int i;
+
+	if (!pool)
+		return DMA_MAPPING_ERROR;
+
+	for (i = 0; i < num_classes; i++) {
+		class = pool->classes + i;
+		if (size <= class->buffer_size)
+			break;
+	}
+
+	if (i == num_classes)
+		return DMA_MAPPING_ERROR;
+
+	spin_lock_irqsave(&class->lock, flags);
+
+	cache = io_buffer_class_get_cache(class, prot);
+	if (!list_empty(cache)) {
+		list_for_each_entry(tmp, cache, list) {
+			if (tmp->prot == prot) {
+				slot = tmp;
+				list_del(&slot->list);
+				break;
+			}
+		}
+	}
+
+	if (slot == NULL) {
+		if (list_empty(&class->empty_slots)) {
+			spin_unlock_irqrestore(&class->lock, flags);
+			return DMA_MAPPING_ERROR;
+		}
+
+		slot = list_first_entry(&class->empty_slots,
+					struct io_buffer_slot, list);
+		list_del(&slot->list);
+		spin_unlock_irqrestore(&class->lock, flags);
+
+		if (!io_buffer_pool_fill_slot(pool, class, slot, prot)) {
+			spin_lock_irqsave(&class->lock, flags);
+			list_add(&slot->list, &class->empty_slots);
+			spin_unlock_irqrestore(&class->lock, flags);
+			return DMA_MAPPING_ERROR;
+		}
+	} else {
+		spin_unlock_irqrestore(&class->lock, flags);
+	}
+
+	slot->orig_buffer = orig_buffer;
+	return io_buffer_slot_to_iova(slot, class);
+}
+
+dma_addr_t io_buffer_pool_map_page(struct io_buffer_pool *pool,
+				   struct page *page, unsigned long offset,
+				   size_t size, int prot, unsigned long attrs)
+{
+	dma_addr_t iova = io_buffer_pool_map_buffer(pool, page, offset + size,
+						    prot, attrs);
+	return iova != DMA_MAPPING_ERROR ? iova + offset : iova;
+}
+
+int io_buffer_pool_map_sg(struct io_buffer_pool *pool, struct device *dev,
+			  struct scatterlist *sg, int nents, int prot,
+			  unsigned long attrs)
+{
+	struct scatterlist *s;
+	unsigned int size = 0;
+	dma_addr_t iova;
+	int i;
+
+	for_each_sg(sg, s, nents, i)
+		size += s->length;
+
+	iova = io_buffer_pool_map_buffer(pool, sg, size, prot, attrs);
+	if (iova == DMA_MAPPING_ERROR)
+		return 0;
+
+	i = 0;
+	while (size > 0) {
+		unsigned int seg_size = min(size, dma_get_max_seg_size(dev));
+
+		sg_dma_len(sg) = seg_size;
+		sg_dma_address(sg) = iova;
+
+		sg = sg_next(sg);
+		size -= seg_size;
+		iova += seg_size;
+		i++;
+	}
+
+	if (sg) {
+		sg_dma_address(sg) = DMA_MAPPING_ERROR;
+		sg_dma_len(sg) = 0;
+	}
+
+	return i;
+}
+
+static bool io_buffer_needs_sync(enum dma_data_direction dir,
+				 bool sync_for_cpu)
+{
+	return dir == DMA_BIDIRECTIONAL ||
+	       (dir == DMA_FROM_DEVICE && sync_for_cpu) ||
+	       (dir == DMA_TO_DEVICE && !sync_for_cpu);
+}
+
+static void io_buffer_pool_do_sync(struct io_buffer_pool *pool,
+				   struct io_buffer_class *class,
+				   struct io_buffer_slot *slot,
+				   size_t bounce_offset, struct page *orig,
+				   size_t orig_offset, size_t size,
+				   enum dma_data_direction dir,
+				   bool sync_for_cpu)
+{
+	bool needs_buffer_sync = io_buffer_needs_sync(dir, sync_for_cpu);
+	char *orig_lowmem_ptr;
+	bool dma_is_coherent = slot->prot & IOMMU_CACHE;
+
+	if (dma_is_coherent && !needs_buffer_sync)
+		return;
+
+	orig_lowmem_ptr = PageHighMem(orig) ? NULL : page_to_virt(orig);
+
+	while (size) {
+		size_t copy_len, bounce_page_offset;
+		struct page *bounce_page;
+
+		bounce_page = slot->bounce_buffer[bounce_offset / PAGE_SIZE];
+		bounce_page_offset = bounce_offset % PAGE_SIZE;
+
+		copy_len = size;
+		if (copy_len + bounce_page_offset > PAGE_SIZE) {
+			size_t new_copy_len = PAGE_SIZE - bounce_page_offset;
+			size_t page_idx = bounce_offset / PAGE_SIZE;
+			int consecutive_pages = 1;
+
+			while (++page_idx < class->buffer_size / PAGE_SIZE &&
+			       new_copy_len < copy_len) {
+				if (nth_page(bounce_page, consecutive_pages) !=
+				    slot->bounce_buffer[page_idx])
+					break;
+				consecutive_pages++;
+				new_copy_len =
+					min(copy_len, new_copy_len + PAGE_SIZE);
+			}
+			copy_len = new_copy_len;
+		}
+
+		if (!dma_is_coherent && sync_for_cpu) {
+			phys_addr_t paddr = page_to_phys(bounce_page);
+
+			arch_sync_dma_for_cpu(paddr + bounce_page_offset,
+					      copy_len, dir);
+		}
+
+		if (needs_buffer_sync) {
+			char *bounce_ptr =
+				page_to_virt(bounce_page) + bounce_page_offset;
+
+			if (!orig_lowmem_ptr) {
+				size_t remaining = copy_len;
+				size_t offset = orig_offset % PAGE_SIZE;
+				unsigned long flags;
+				size_t orig_page_idx = orig_offset / PAGE_SIZE;
+
+				while (remaining) {
+					char *orig_ptr;
+					size_t sz = min(remaining,
+							PAGE_SIZE - offset);
+
+					local_irq_save(flags);
+					orig_ptr = kmap_atomic(
+						nth_page(orig, orig_page_idx));
+					if (sync_for_cpu) {
+						memcpy(orig_ptr + offset,
+						       bounce_ptr, sz);
+					} else {
+						memcpy(bounce_ptr,
+						       orig_ptr + offset, sz);
+					}
+					kunmap_atomic(orig_ptr);
+					local_irq_restore(flags);
+
+					remaining -= sz;
+					orig_page_idx += 1;
+					bounce_ptr += sz;
+					offset = 0;
+				}
+			} else if (sync_for_cpu) {
+				memcpy(orig_lowmem_ptr + orig_offset,
+				       bounce_ptr, copy_len);
+			} else {
+				memcpy(bounce_ptr,
+				       orig_lowmem_ptr + orig_offset, copy_len);
+			}
+		}
+
+		if (!dma_is_coherent && !sync_for_cpu) {
+			phys_addr_t paddr = page_to_phys(bounce_page);
+
+			arch_sync_dma_for_device(paddr + bounce_page_offset,
+						 copy_len, dir);
+		}
+
+		bounce_offset += copy_len;
+		orig_offset += copy_len;
+		size -= copy_len;
+	}
+}
+
+bool io_buffer_pool_sync_single(struct io_buffer_pool *pool,
+				dma_addr_t dma_handle, size_t size,
+				enum dma_data_direction dir,
+				bool sync_for_cpu)
+{
+	struct io_buffer_slot *slot;
+	struct io_buffer_class *class;
+	size_t offset;
+
+	if (!pool ||
+	    !io_buffer_pool_find_buffer(pool, dma_handle, &class, &slot))
+		return false;
+
+	offset = dma_handle - io_buffer_slot_to_iova(slot, class);
+	io_buffer_pool_do_sync(pool, class, slot, offset, slot->orig_buffer,
+			       offset, size, dir, sync_for_cpu);
+
+	return true;
+}
+
+bool io_buffer_pool_sync_sg(struct io_buffer_pool *pool,
+			    struct scatterlist *sgl, int nelems,
+			    enum dma_data_direction dir,
+			    bool sync_for_cpu)
+{
+	struct io_buffer_slot *slot;
+	struct io_buffer_class *class;
+	struct scatterlist *iter;
+	size_t bounce_offset;
+	int i;
+
+	if (!pool || !io_buffer_pool_find_buffer(pool, sg_dma_address(sgl),
+						 &class, &slot))
+		return false;
+
+	// In the non io-buffer-pool case, iommu_dma_map_sg syncs before setting
+	// up the new mapping's dma address. This check handles false positives
+	// in find_buffer caused by sgl being reused for a non io-buffer-pool
+	// case after being used with the io-buffer-pool.
+	if (slot->orig_buffer != sgl)
+		return false;
+
+	bounce_offset = 0;
+	for_each_sg(sgl, iter, nelems, i) {
+		io_buffer_pool_do_sync(pool, class, slot, bounce_offset,
+				       sg_page(iter), iter->offset,
+				       iter->length, dir, sync_for_cpu);
+		bounce_offset += iter->length;
+	}
+
+	return true;
+}
diff --git a/drivers/iommu/io-buffer-pool.h b/drivers/iommu/io-buffer-pool.h
new file mode 100644
index 000000000000..27820436d1d7
--- /dev/null
+++ b/drivers/iommu/io-buffer-pool.h
@@ -0,0 +1,91 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Dynamic pools of IOMMU mapped bounce buffers.
+ *
+ * Copyright (C) 2021 Google, Inc.
+ */
+
+#ifndef _LINUX_IO_BUFFER_POOL_H
+#define _LINUX_IO_BUFFER_POOL_H
+
+struct io_buffer_pool;
+
+#ifdef CONFIG_IOMMU_IO_BUFFER
+
+#include <linux/dma-iommu.h>
+#include <linux/iova.h>
+#include <linux/swiotlb.h>
+
+int io_buffer_pool_init(struct device *dev, struct iommu_domain *domain,
+			struct iova_domain *iovad,
+			struct io_buffer_pool **pool);
+void io_buffer_pool_destroy(struct io_buffer_pool *pool);
+bool io_buffer_pool_sync_single(struct io_buffer_pool *pool,
+				dma_addr_t dma_handle, size_t size,
+				enum dma_data_direction dir,
+				bool sync_for_cpu);
+bool io_buffer_pool_sync_sg(struct io_buffer_pool *pool,
+			    struct scatterlist *sgl, int nelems,
+			    enum dma_data_direction dir,
+			    bool sync_for_cpu);
+dma_addr_t io_buffer_pool_map_page(struct io_buffer_pool *pool,
+				   struct page *page, unsigned long offset,
+				   size_t size, int prot, unsigned long attrs);
+int io_buffer_pool_map_sg(struct io_buffer_pool *pool, struct device *dev,
+			  struct scatterlist *sg, int nents, int prot,
+			  unsigned long attrs);
+bool io_buffer_pool_unmap_buffer(struct io_buffer_pool *pool,
+				 dma_addr_t handle);
+
+#else
+
+int io_buffer_pool_init(struct device *dev, struct iommu_domain *domain,
+			struct iova_domain *iovad,
+			struct io_buffer_pool **pool)
+{
+	return 0;
+}
+
+void io_buffer_pool_destroy(struct io_buffer_pool *pool)
+{
+}
+
+bool io_buffer_pool_sync_single(struct io_buffer_pool *pool,
+				dma_addr_t dma_handle, size_t size,
+				enum dma_data_direction dir,
+				bool sync_for_cpu)
+{
+	return false;
+}
+
+bool io_buffer_pool_sync_sg(struct io_buffer_pool *pool,
+			    struct scatterlist *sgl, int nelems,
+			    enum dma_data_direction dir,
+			    bool sync_for_cpu)
+{
+	return false;
+}
+
+dma_addr_t io_buffer_pool_map_page(struct io_buffer_pool *pool,
+				   struct page *page, unsigned long offset,
+				   size_t size, int prot, unsigned long attrs)
+{
+	return DMA_MAPPING_ERROR;
+}
+
+int io_buffer_pool_map_sg(struct io_buffer_pool *pool, struct device *dev,
+			  struct scatterlist *sg, int nents, int prot,
+			  unsigned long attrs)
+{
+	return 0;
+}
+
+bool io_buffer_pool_unmap_buffer(struct io_buffer_pool *pool,
+				 dma_addr_t handle)
+{
+	return false;
+}
+
+#endif /* CONFIG_IOMMU_IO_BUFFER */
+
+#endif /* _LINUX_IO_BUFFER_POOL_H */
-- 
2.32.0.93.g670b81a890-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
