Return-Path: <SRS0=o7oR=M5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C3DDC4338F
	for <iommu@archiver.kernel.org>; Fri,  6 Aug 2021 10:35:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E69C460E52
	for <iommu@archiver.kernel.org>; Fri,  6 Aug 2021 10:35:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E69C460E52
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BC20440201;
	Fri,  6 Aug 2021 10:35:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id v9wV9j6rJUKP; Fri,  6 Aug 2021 10:35:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 50AEE40224;
	Fri,  6 Aug 2021 10:35:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2CC95C001A;
	Fri,  6 Aug 2021 10:35:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CF7B9C000E
 for <iommu@lists.linux-foundation.org>; Fri,  6 Aug 2021 10:35:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BD791402F7
 for <iommu@lists.linux-foundation.org>; Fri,  6 Aug 2021 10:35:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=chromium.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wWbAiJqF-vPJ for <iommu@lists.linux-foundation.org>;
 Fri,  6 Aug 2021 10:35:08 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 00DFE4010A
 for <iommu@lists.linux-foundation.org>; Fri,  6 Aug 2021 10:35:07 +0000 (UTC)
Received: by mail-pj1-x1032.google.com with SMTP id
 u13-20020a17090abb0db0290177e1d9b3f7so22107134pjr.1
 for <iommu@lists.linux-foundation.org>; Fri, 06 Aug 2021 03:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7VNJ9ldlXXs6LRJakCtsRERtXzUodv/hFevJ5MP7anU=;
 b=HlpCypNAVE+X85JdJl6SxuvTdJgzIPOOP5e4O+sNxbBAc5Jzzt2pOgN8VhE5Q6CuGO
 K5SFsSwHS7b/rRDIIHQl7MVvJMaRZWRyWAhEdfnkmmuLuJ4heXK9ygm6ivWSvbMvR+PV
 4vFpZteBtpnYauhkQlFFASRslZw0w2m/4RkcQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7VNJ9ldlXXs6LRJakCtsRERtXzUodv/hFevJ5MP7anU=;
 b=ZsMF71dx6FsXjOPqrBTuwe7vOzF3qMkpTYPQ6+9MnF8ivKLsQBEs+THlwcySxJv+YQ
 gmN+5NR5HmNyrIn/q7WOrpIXmOkAgTnpv6TbUpThIdRXhygKKbwTTzm+DGARltKlFxti
 CMGPLm+SA8qaWN3k/j0zvwFnB1kquBKFj+9v9XrzJouIOE3vVf6aNUpYbGyDLq7FHKPk
 xQdmuvo8Rp7uj35OmakMfUJWSAMIoVaBHu/serhi3BSIcJPNEzpr+1WClzqMCs0xb2pM
 7XP5NcX9C+LpGQ8VzbiNeFKdaYKi52/sYMSH2lVqwzxSH1vODldmSoZBK1ZqKCu68nLr
 ksIQ==
X-Gm-Message-State: AOAM533bnmIZNz5JW/1V5Tq81mn3QwyIbU2bL3G5x92jt3drVIfYC5KI
 BjK3qxzc13rU4ITNAPdJ4nMJQw==
X-Google-Smtp-Source: ABdhPJyhS5FZCaTZ3jUORBNv3HFd+FERqFeewhKQtpMPCvF95fE1qURp7oE6TnZtbXP/c0HDAfkJAA==
X-Received: by 2002:aa7:9117:0:b029:35c:4791:ff52 with SMTP id
 23-20020aa791170000b029035c4791ff52mr9796944pfh.76.1628246107301; 
 Fri, 06 Aug 2021 03:35:07 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:6f20:cf00:347a:afc2])
 by smtp.gmail.com with UTF8SMTPSA id g11sm8828931pju.13.2021.08.06.03.35.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Aug 2021 03:35:06 -0700 (PDT)
From: David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To: Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v2 3/9] dma-iommu: bounce buffers for untrusted devices
Date: Fri,  6 Aug 2021 19:34:17 +0900
Message-Id: <20210806103423.3341285-4-stevensd@google.com>
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

Add support for dynamic bounce buffers to the dma-api for use with
subgranule IOMMU mappings with untrusted devices. Bounce buffer
management is split into two parts. First, there is a buffer manager
that is responsible for allocating and tracking buffers. Second, there
is a layer that uses the managed buffers as bounce buffers. It is
responsible for managing the IOMMU mapping and for syncing between the
original and bounce buffers.

For now, buffer management is very simple - every mapping allocates a
new bounce buffer.

Signed-off-by: David Stevens <stevensd@chromium.org>
---
 drivers/iommu/Makefile            |   2 +-
 drivers/iommu/dma-iommu.c         |  70 +++++-
 drivers/iommu/io-bounce-buffers.c | 358 ++++++++++++++++++++++++++++++
 drivers/iommu/io-bounce-buffers.h |  46 ++++
 drivers/iommu/io-buffer-manager.c | 212 ++++++++++++++++++
 drivers/iommu/io-buffer-manager.h |  43 ++++
 6 files changed, 728 insertions(+), 3 deletions(-)
 create mode 100644 drivers/iommu/io-bounce-buffers.c
 create mode 100644 drivers/iommu/io-bounce-buffers.h
 create mode 100644 drivers/iommu/io-buffer-manager.c
 create mode 100644 drivers/iommu/io-buffer-manager.h

diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index c0fb0ba88143..4edaf7adc082 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -4,7 +4,7 @@ obj-$(CONFIG_IOMMU_API) += iommu.o
 obj-$(CONFIG_IOMMU_API) += iommu-traces.o
 obj-$(CONFIG_IOMMU_API) += iommu-sysfs.o
 obj-$(CONFIG_IOMMU_DEBUGFS) += iommu-debugfs.o
-obj-$(CONFIG_IOMMU_DMA) += dma-iommu.o
+obj-$(CONFIG_IOMMU_DMA) += dma-iommu.o io-bounce-buffers.o io-buffer-manager.o
 obj-$(CONFIG_IOMMU_IO_PGTABLE) += io-pgtable.o
 obj-$(CONFIG_IOMMU_IO_PGTABLE_ARMV7S) += io-pgtable-arm-v7s.o
 obj-$(CONFIG_IOMMU_IO_PGTABLE_LPAE) += io-pgtable-arm.o
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 055ccda5eba1..908eb6fb7dc3 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -24,6 +24,8 @@
 #include <linux/vmalloc.h>
 #include <linux/crash_dump.h>
 
+#include "io-bounce-buffers.h"
+
 struct iommu_dma_msi_page {
 	struct list_head	list;
 	dma_addr_t		iova;
@@ -44,6 +46,7 @@ struct iommu_dma_cookie {
 		dma_addr_t		msi_iova;
 	};
 	struct list_head		msi_page_list;
+	struct io_bounce_buffers	*bounce_buffers;
 
 	/* Domain for flush queue callback; NULL if flush queue not in use */
 	struct iommu_domain		*fq_domain;
@@ -81,6 +84,14 @@ static inline size_t cookie_msi_granule(struct iommu_dma_cookie *cookie)
 	return PAGE_SIZE;
 }
 
+static struct io_bounce_buffers *dev_to_io_bounce_buffers(struct device *dev)
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
@@ -160,6 +171,9 @@ void iommu_put_dma_cookie(struct iommu_domain *domain)
 	if (!cookie)
 		return;
 
+	if (cookie->bounce_buffers)
+		io_bounce_buffers_destroy(cookie->bounce_buffers);
+
 	if (cookie->type == IOMMU_DMA_IOVA_COOKIE && cookie->iovad.granule)
 		put_iova_domain(&cookie->iovad);
 
@@ -333,6 +347,7 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
 	unsigned long order, base_pfn;
 	struct iova_domain *iovad;
+	int ret;
 
 	if (!cookie || cookie->type != IOMMU_DMA_IOVA_COOKIE)
 		return -EINVAL;
@@ -380,7 +395,16 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
 	if (!dev)
 		return 0;
 
-	return iova_reserve_iommu_regions(dev, domain);
+	ret = iova_reserve_iommu_regions(dev, domain);
+
+	if (ret == 0 && dev_is_untrusted(dev)) {
+		cookie->bounce_buffers =
+			io_bounce_buffers_init(dev, domain, iovad);
+		if (IS_ERR(cookie->bounce_buffers))
+			ret = PTR_ERR(cookie->bounce_buffers);
+	}
+
+	return ret;
 }
 
 /**
@@ -710,8 +734,13 @@ static void iommu_dma_free_noncontiguous(struct device *dev, size_t size,
 static void iommu_dma_sync_single_for_cpu(struct device *dev,
 		dma_addr_t dma_handle, size_t size, enum dma_data_direction dir)
 {
+	struct io_bounce_buffers *bounce = dev_to_io_bounce_buffers(dev);
 	phys_addr_t phys;
 
+	if (bounce && io_bounce_buffers_sync_single(bounce, dma_handle,
+						    size, dir, true))
+		return;
+
 	if (dev_is_dma_coherent(dev))
 		return;
 
@@ -722,8 +751,13 @@ static void iommu_dma_sync_single_for_cpu(struct device *dev,
 static void iommu_dma_sync_single_for_device(struct device *dev,
 		dma_addr_t dma_handle, size_t size, enum dma_data_direction dir)
 {
+	struct io_bounce_buffers *bounce = dev_to_io_bounce_buffers(dev);
 	phys_addr_t phys;
 
+	if (bounce && io_bounce_buffers_sync_single(bounce, dma_handle,
+						    size, dir, false))
+		return;
+
 	if (dev_is_dma_coherent(dev))
 		return;
 
@@ -735,9 +769,13 @@ static void iommu_dma_sync_sg_for_cpu(struct device *dev,
 		struct scatterlist *sgl, int nelems,
 		enum dma_data_direction dir)
 {
+	struct io_bounce_buffers *bounce = dev_to_io_bounce_buffers(dev);
 	struct scatterlist *sg;
 	int i;
 
+	if (bounce && io_bounce_buffers_sync_sg(bounce, sgl, nelems, dir, true))
+		return;
+
 	if (dev_is_dma_coherent(dev))
 		return;
 
@@ -749,9 +787,14 @@ static void iommu_dma_sync_sg_for_device(struct device *dev,
 		struct scatterlist *sgl, int nelems,
 		enum dma_data_direction dir)
 {
+	struct io_bounce_buffers *bounce = dev_to_io_bounce_buffers(dev);
 	struct scatterlist *sg;
 	int i;
 
+	if (bounce && io_bounce_buffers_sync_sg(bounce, sgl,
+						nelems, dir, false))
+		return;
+
 	if (dev_is_dma_coherent(dev))
 		return;
 
@@ -763,11 +806,19 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 		unsigned long offset, size_t size, enum dma_data_direction dir,
 		unsigned long attrs)
 {
+	struct iommu_domain *domain = iommu_get_dma_domain(dev);
+	struct iommu_dma_cookie *cookie = domain->iova_cookie;
 	phys_addr_t phys = page_to_phys(page) + offset;
 	bool coherent = dev_is_dma_coherent(dev);
 	int prot = dma_info_to_prot(dir, coherent, attrs);
 	dma_addr_t dma_handle;
 
+	if (cookie->bounce_buffers &&
+	    io_bounce_buffers_map_page(cookie->bounce_buffers, dev, page,
+				       offset, size, prot, dir, attrs,
+				       &dma_handle))
+		return dma_handle;
+
 	dma_handle = __iommu_dma_map(dev, phys, size, prot, dma_get_mask(dev));
 	if (!coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
 	    dma_handle != DMA_MAPPING_ERROR)
@@ -778,6 +829,12 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 static void iommu_dma_unmap_page(struct device *dev, dma_addr_t dma_handle,
 		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
+	struct io_bounce_buffers *bounce = dev_to_io_bounce_buffers(dev);
+
+	if (bounce &&
+	    io_bounce_buffers_unmap_page(bounce, dma_handle, size, dir, attrs))
+		return;
+
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
 		iommu_dma_sync_single_for_cpu(dev, dma_handle, size, dir);
 	__iommu_dma_unmap(dev, dma_handle, size);
@@ -876,12 +933,17 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
 	dma_addr_t iova;
 	size_t iova_len = 0;
 	unsigned long mask = dma_get_seg_boundary(dev);
-	int i;
+	int i, ret;
 
 	if (static_branch_unlikely(&iommu_deferred_attach_enabled) &&
 	    iommu_deferred_attach(dev, domain))
 		return 0;
 
+	if (cookie->bounce_buffers &&
+	    io_bounce_buffers_map_sg(cookie->bounce_buffers, dev, sg, nents,
+				     prot, dir, attrs, &ret))
+		return ret;
+
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
 		iommu_dma_sync_sg_for_device(dev, sg, nents, dir);
 
@@ -947,10 +1009,14 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
 static void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
 		int nents, enum dma_data_direction dir, unsigned long attrs)
 {
+	struct io_bounce_buffers *bounce = dev_to_io_bounce_buffers(dev);
 	dma_addr_t start, end;
 	struct scatterlist *tmp;
 	int i;
 
+	if (bounce && io_bounce_buffers_unmap_sg(bounce, sg, nents, dir, attrs))
+		return;
+
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
 		iommu_dma_sync_sg_for_cpu(dev, sg, nents, dir);
 
diff --git a/drivers/iommu/io-bounce-buffers.c b/drivers/iommu/io-bounce-buffers.c
new file mode 100644
index 000000000000..78b4440b58c8
--- /dev/null
+++ b/drivers/iommu/io-bounce-buffers.c
@@ -0,0 +1,358 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Dynamic IOMMU mapped bounce buffers.
+ *
+ * Copyright (C) 2021 Google, Inc.
+ */
+
+#include <linux/dma-iommu.h>
+#include <linux/dma-map-ops.h>
+#include <linux/highmem.h>
+#include <linux/list.h>
+#include <linux/slab.h>
+
+#include "io-buffer-manager.h"
+#include "io-bounce-buffers.h"
+
+struct io_bounce_buffers {
+	struct iommu_domain *domain;
+	struct iova_domain *iovad;
+	unsigned int nid;
+	struct io_buffer_manager manager;
+};
+
+bool io_bounce_buffers_release_buffer_cb(struct io_buffer_manager *manager,
+					 dma_addr_t iova, size_t size)
+{
+	struct io_bounce_buffers *buffers =
+		container_of(manager, struct io_bounce_buffers, manager);
+	return iommu_unmap(buffers->domain, iova, size) >= size;
+}
+
+struct io_bounce_buffers *io_bounce_buffers_init(struct device *dev,
+						 struct iommu_domain *domain,
+						 struct iova_domain *iovad)
+{
+	int ret;
+	struct io_bounce_buffers *buffers;
+
+	buffers = kzalloc(sizeof(*buffers), GFP_KERNEL);
+	if (!buffers)
+		return ERR_PTR(-ENOMEM);
+
+	ret = io_buffer_manager_init(&buffers->manager);
+	if (ret) {
+		kfree(buffers);
+		return ERR_PTR(ret);
+	}
+
+	buffers->domain = domain;
+	buffers->iovad = iovad;
+	buffers->nid = dev_to_node(dev);
+
+	return buffers;
+}
+
+void io_bounce_buffers_destroy(struct io_bounce_buffers *buffers)
+{
+	kfree(buffers);
+}
+
+static bool should_sync_buffer(enum dma_data_direction dir, bool sync_for_cpu)
+{
+	return dir == DMA_BIDIRECTIONAL ||
+	       (dir == DMA_FROM_DEVICE && sync_for_cpu) ||
+	       (dir == DMA_TO_DEVICE && !sync_for_cpu);
+}
+
+static void io_bounce_buffers_do_sync(struct io_bounce_buffers *buffers,
+				      struct page **bounce_buffer,
+				      size_t bounce_offset, struct page *orig,
+				      size_t orig_offset, size_t size,
+				      enum dma_data_direction dir, int prot,
+				      bool sync_for_cpu)
+{
+	bool needs_bounce_sync = should_sync_buffer(dir, sync_for_cpu);
+	char *orig_lowmem_ptr;
+	bool dma_is_coherent = prot & IOMMU_CACHE;
+
+	if (dma_is_coherent && !needs_bounce_sync)
+		return;
+
+	orig_lowmem_ptr = PageHighMem(orig) ? NULL : page_to_virt(orig);
+
+	while (size) {
+		size_t copy_len, bounce_page_offset;
+		struct page *bounce_page;
+
+		bounce_page = bounce_buffer[bounce_offset / PAGE_SIZE];
+		bounce_page_offset = bounce_offset % PAGE_SIZE;
+
+		copy_len = size;
+		if (copy_len + bounce_page_offset > PAGE_SIZE)
+			copy_len = PAGE_SIZE - bounce_page_offset;
+
+		if (!dma_is_coherent && sync_for_cpu) {
+			phys_addr_t paddr = page_to_phys(bounce_page);
+
+			arch_sync_dma_for_cpu(paddr + bounce_page_offset,
+					      copy_len, dir);
+		}
+
+		if (needs_bounce_sync) {
+			char *bounce_page_ptr = kmap_local_page(bounce_page);
+			char *bounce_ptr = bounce_page_ptr + bounce_page_offset;
+
+			if (!orig_lowmem_ptr) {
+				size_t remaining = copy_len;
+				size_t offset = orig_offset % PAGE_SIZE;
+				size_t orig_page_idx = orig_offset / PAGE_SIZE;
+
+				while (remaining) {
+					char *orig_ptr;
+					size_t sz = min(remaining,
+							PAGE_SIZE - offset);
+
+					orig_ptr = kmap_local_page(
+						nth_page(orig, orig_page_idx));
+					if (sync_for_cpu) {
+						memcpy(orig_ptr + offset,
+						       bounce_ptr, sz);
+					} else {
+						memcpy(bounce_ptr,
+						       orig_ptr + offset, sz);
+					}
+					kunmap_local(orig_ptr);
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
+
+			kunmap_local(bounce_page_ptr);
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
+bool io_bounce_buffers_sync_single(struct io_bounce_buffers *buffers,
+				   dma_addr_t dma_handle, size_t size,
+				   enum dma_data_direction dir,
+				   bool sync_for_cpu)
+{
+	struct io_bounce_buffer_info info;
+	void *orig_buffer;
+	size_t offset;
+	int prot;
+
+	if (!io_buffer_manager_find_buffer(&buffers->manager, dma_handle, &info,
+					   &orig_buffer, &prot))
+		return false;
+
+	offset = dma_handle - info.iova;
+	io_bounce_buffers_do_sync(buffers, info.bounce_buffer, offset,
+				  orig_buffer, offset, size, dir, prot,
+				  sync_for_cpu);
+	return true;
+}
+
+static void __io_bounce_buffers_sync_sg(struct io_bounce_buffers *buffers,
+					struct scatterlist *sgl, int nents,
+					struct page **bounce_buffer,
+					enum dma_data_direction dir, int prot,
+					bool sync_for_cpu)
+{
+	size_t bounce_offset = 0;
+	struct scatterlist *iter;
+	int i;
+
+	for_each_sg(sgl, iter, nents, i) {
+		io_bounce_buffers_do_sync(buffers, bounce_buffer, bounce_offset,
+					  sg_page(iter), iter->offset,
+					  iter->length, dir, prot,
+					  sync_for_cpu);
+		bounce_offset += iter->length;
+	}
+}
+
+bool io_bounce_buffers_sync_sg(struct io_bounce_buffers *buffers,
+			       struct scatterlist *sgl, int nents,
+			       enum dma_data_direction dir, bool sync_for_cpu)
+{
+	struct io_bounce_buffer_info info;
+	void *orig_buffer;
+	int prot;
+
+	if (!io_buffer_manager_find_buffer(&buffers->manager,
+					   sg_dma_address(sgl), &info,
+					   &orig_buffer, &prot))
+		return false;
+
+	// In the non bounce buffer case, iommu_dma_map_sg syncs before setting
+	// up the new mapping's dma address. This check handles false positives
+	// in find_buffer caused by sgl being reused for a non bounce buffer
+	// case after being used with a bounce buffer.
+	if (orig_buffer != sgl)
+		return false;
+
+	__io_bounce_buffers_sync_sg(buffers, sgl, nents, info.bounce_buffer,
+				    dir, prot, sync_for_cpu);
+
+	return true;
+}
+
+bool io_bounce_buffers_unmap_page(struct io_bounce_buffers *buffers,
+				  dma_addr_t handle, size_t size,
+				  enum dma_data_direction dir,
+				  unsigned long attrs)
+{
+	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
+		io_bounce_buffers_sync_single(buffers, handle, size, dir, true);
+
+	return io_buffer_manager_release_buffer(&buffers->manager,
+						buffers->domain, handle, true);
+}
+
+bool io_bounce_buffers_unmap_sg(struct io_bounce_buffers *buffers,
+				struct scatterlist *sgl, int nents,
+				enum dma_data_direction dir,
+				unsigned long attrs)
+{
+	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
+		io_bounce_buffers_sync_sg(buffers, sgl, nents, dir, true);
+
+	return io_buffer_manager_release_buffer(
+		&buffers->manager, buffers->domain, sg_dma_address(sgl), true);
+}
+
+static bool io_bounce_buffers_map_buffer(struct io_bounce_buffers *buffers,
+					 struct io_bounce_buffer_info *info,
+					 int prot)
+{
+	unsigned int count = info->size >> PAGE_SHIFT;
+	struct sg_table sgt;
+	size_t mapped;
+
+	if (sg_alloc_table_from_pages(&sgt, info->bounce_buffer, count, 0,
+				      info->size, GFP_ATOMIC))
+		return false;
+
+	mapped = iommu_map_sg_atomic(buffers->domain, info->iova, sgt.sgl,
+				     sgt.orig_nents, prot);
+
+	sg_free_table(&sgt);
+	return mapped >= info->size;
+}
+
+bool io_bounce_buffers_map_page(struct io_bounce_buffers *buffers,
+				struct device *dev, struct page *page,
+				unsigned long offset, size_t size, int prot,
+				enum dma_data_direction dir,
+				unsigned long attrs, dma_addr_t *handle)
+{
+	bool skip_cpu_sync = attrs & DMA_ATTR_SKIP_CPU_SYNC;
+	struct io_bounce_buffer_info info;
+	bool force_bounce = iova_offset(buffers->iovad, offset | size);
+
+	if (!force_bounce)
+		return false;
+
+	*handle = DMA_MAPPING_ERROR;
+	if (!io_buffer_manager_alloc_buffer(&buffers->manager, dev, page,
+					    offset + size, prot, buffers->nid,
+					    &info))
+		return true;
+
+	if (!skip_cpu_sync)
+		io_bounce_buffers_do_sync(buffers, info.bounce_buffer, offset,
+					  page, offset, size, dir, prot, false);
+
+	if (!io_bounce_buffers_map_buffer(buffers, &info, prot)) {
+		io_buffer_manager_release_buffer(
+			&buffers->manager, buffers->domain, info.iova, false);
+		return true;
+	}
+
+	*handle = info.iova + offset;
+	return true;
+}
+
+bool io_bounce_buffers_map_sg(struct io_bounce_buffers *buffers,
+			      struct device *dev, struct scatterlist *sgl,
+			      int nents, int prot, enum dma_data_direction dir,
+			      unsigned long attrs, int *out_nents)
+{
+	struct io_bounce_buffer_info info;
+	struct scatterlist *iter;
+	size_t size = 0;
+	bool skip_cpu_sync = attrs & DMA_ATTR_SKIP_CPU_SYNC;
+	dma_addr_t seg_iova;
+	int i;
+	bool force_bounce = false;
+
+	for_each_sg(sgl, iter, nents, i) {
+		size += iter->length;
+		force_bounce |= iova_offset(buffers->iovad,
+					    iter->offset | iter->length);
+	}
+
+	if (!force_bounce)
+		return false;
+
+	*out_nents = 0;
+	if (!io_buffer_manager_alloc_buffer(&buffers->manager, dev, sgl, size,
+					    prot, buffers->nid, &info))
+		return true;
+
+	if (!skip_cpu_sync)
+		__io_bounce_buffers_sync_sg(buffers, sgl, nents,
+					    info.bounce_buffer, dir, prot,
+					    false);
+
+	if (!io_bounce_buffers_map_buffer(buffers, &info, prot)) {
+		io_buffer_manager_release_buffer(
+			&buffers->manager, buffers->domain, info.iova, false);
+		return true;
+	}
+
+	i = 0;
+	seg_iova = info.iova;
+	while (size > 0) {
+		size_t seg_size = min_t(size_t, size,
+					dma_get_max_seg_size(dev));
+
+		sg_dma_len(sgl) = seg_size;
+		sg_dma_address(sgl) = seg_iova;
+
+		sgl = sg_next(sgl);
+		size -= seg_size;
+		seg_iova += seg_size;
+		i++;
+	}
+
+	if (sgl) {
+		sg_dma_address(sgl) = DMA_MAPPING_ERROR;
+		sg_dma_len(sgl) = 0;
+	}
+
+	*out_nents = i;
+	return true;
+}
diff --git a/drivers/iommu/io-bounce-buffers.h b/drivers/iommu/io-bounce-buffers.h
new file mode 100644
index 000000000000..6d132a27646c
--- /dev/null
+++ b/drivers/iommu/io-bounce-buffers.h
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2021 Google, Inc.
+ */
+
+#ifndef _LINUX_IO_BOUNCE_BUFFERS_H
+#define _LINUX_IO_BOUNCE_BUFFERS_H
+
+#include <linux/dma-iommu.h>
+#include <linux/iova.h>
+
+struct io_bounce_buffers;
+
+struct io_bounce_buffers *io_bounce_buffers_init(struct device *dev,
+						 struct iommu_domain *domain,
+						 struct iova_domain *iovad);
+void io_bounce_buffers_destroy(struct io_bounce_buffers *buffers);
+
+bool io_bounce_buffers_sync_single(struct io_bounce_buffers *buffers,
+				   dma_addr_t dma_handle, size_t size,
+				   enum dma_data_direction dir,
+				   bool sync_for_cpu);
+bool io_bounce_buffers_sync_sg(struct io_bounce_buffers *buffers,
+			       struct scatterlist *sgl, int nents,
+			       enum dma_data_direction dir, bool sync_for_cpu);
+
+bool io_bounce_buffers_map_page(struct io_bounce_buffers *buffers,
+				struct device *dev, struct page *page,
+				unsigned long offset, size_t size, int prot,
+				enum dma_data_direction dir,
+				unsigned long attrs, dma_addr_t *handle);
+bool io_bounce_buffers_map_sg(struct io_bounce_buffers *buffers,
+			      struct device *dev, struct scatterlist *sgl,
+			      int nents, int prot, enum dma_data_direction dir,
+			      unsigned long attrs, int *out_nents);
+
+bool io_bounce_buffers_unmap_page(struct io_bounce_buffers *buffers,
+				  dma_addr_t handle, size_t size,
+				  enum dma_data_direction dir,
+				  unsigned long attrs);
+bool io_bounce_buffers_unmap_sg(struct io_bounce_buffers *buffers,
+				struct scatterlist *sgl, int nents,
+				enum dma_data_direction dir,
+				unsigned long attrs);
+
+#endif /* _LINUX_IO_BOUNCE_BUFFERS_H */
diff --git a/drivers/iommu/io-buffer-manager.c b/drivers/iommu/io-buffer-manager.c
new file mode 100644
index 000000000000..24e95a2faa37
--- /dev/null
+++ b/drivers/iommu/io-buffer-manager.c
@@ -0,0 +1,212 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Manager which allocates and tracks bounce buffers and their IOVAs. Does
+ * not actually manage the IOMMU mapping nor do the bounce copies.
+ *
+ * Copyright (C) 2021 Google, Inc.
+ */
+
+#include "io-buffer-manager.h"
+
+#include <linux/slab.h>
+
+struct io_buffer_node {
+	struct rb_node node;
+	struct io_bounce_buffer_info info;
+	void *orig_buffer;
+	int prot;
+};
+
+static void io_buffer_manager_free_pages(struct page **pages, int count)
+{
+	while (count--)
+		__free_page(pages[count]);
+	kfree(pages);
+}
+
+static struct page **io_buffer_manager_alloc_pages(int count, unsigned int nid)
+{
+	struct page **pages;
+	unsigned int i;
+
+	pages = kmalloc_array(count, sizeof(*pages), GFP_ATOMIC);
+	if (!pages)
+		return NULL;
+
+	// The IOMMU can map highmem pages, but try to allocate non-highmem
+	// pages first to make accessing the buffer cheaper.
+	for (i = 0; i < count; i++) {
+		pages[i] = alloc_pages_node(
+			nid,
+			GFP_ATOMIC | __GFP_ZERO | __GFP_NORETRY | __GFP_NOWARN,
+			0);
+		if (!pages[i]) {
+			pages[i] = alloc_pages_node(
+				nid, GFP_ATOMIC | __GFP_ZERO | __GFP_HIGHMEM,
+				0);
+			if (!pages[i]) {
+				io_buffer_manager_free_pages(pages, i);
+				return NULL;
+			}
+		}
+	}
+
+	return pages;
+}
+
+struct io_buffer_node *find_fallback_node(struct rb_root *root, dma_addr_t iova)
+{
+	struct rb_node *node = root->rb_node;
+
+	while (node) {
+		struct io_buffer_node *cur =
+			container_of(node, struct io_buffer_node, node);
+
+		if (iova < cur->info.iova)
+			node = node->rb_left;
+		else if (iova >= cur->info.iova + cur->info.size)
+			node = node->rb_right;
+		else
+			return cur;
+	}
+	return NULL;
+}
+
+bool insert_fallback_node(struct rb_root *root, struct io_buffer_node *node)
+{
+	struct rb_node **new = &(root->rb_node), *parent = NULL;
+	dma_addr_t node_end = node->info.iova + node->info.size;
+
+	while (*new) {
+		struct io_buffer_node *cur =
+			container_of(*new, struct io_buffer_node, node);
+		dma_addr_t cur_end = cur->info.iova + cur->info.size;
+
+		parent = *new;
+		if (node_end <= cur->info.iova)
+			new = &((*new)->rb_left);
+		else if (node->info.iova >= cur_end)
+			new = &((*new)->rb_right);
+		else {
+			pr_crit("IOVA collision new=[%llx,%llx) old=[%llx,%llx)\n",
+				node->info.iova, node_end, cur->info.iova,
+				cur_end);
+			return false;
+		}
+	}
+
+	rb_link_node(&node->node, parent, new);
+	rb_insert_color(&node->node, root);
+	return true;
+}
+
+bool io_buffer_manager_alloc_buffer(struct io_buffer_manager *manager,
+				    struct device *dev, void *orig_buffer,
+				    size_t size, int prot, unsigned int nid,
+				    struct io_bounce_buffer_info *info)
+{
+	struct iommu_domain *domain = iommu_get_dma_domain(dev);
+	struct io_buffer_node *node;
+	unsigned long flags;
+
+	node = kzalloc(sizeof(*node), GFP_ATOMIC);
+	if (!node)
+		return false;
+
+	size = PAGE_ALIGN(size);
+	node->info.iova =
+		__iommu_dma_alloc_iova(domain, size, dma_get_mask(dev), dev);
+	if (!node->info.iova)
+		goto free_node;
+
+	node->info.bounce_buffer =
+		io_buffer_manager_alloc_pages(size >> PAGE_SHIFT, nid);
+	if (!node->info.bounce_buffer)
+		goto free_iova;
+
+	spin_lock_irqsave(&manager->fallback_lock, flags);
+	if (!insert_fallback_node(&manager->fallback_buffers, node))
+		goto fallback_lock_unlock;
+	spin_unlock_irqrestore(&manager->fallback_lock, flags);
+
+	node->orig_buffer = orig_buffer;
+	node->prot = prot;
+	node->info.size = size;
+
+	*info = node->info;
+
+	return true;
+
+fallback_lock_unlock:
+	spin_unlock_irqrestore(&manager->fallback_lock, flags);
+free_iova:
+	__iommu_dma_free_iova(domain->iova_cookie, node->info.iova, size, NULL);
+free_node:
+	kfree(node);
+	return false;
+}
+
+bool io_buffer_manager_find_buffer(struct io_buffer_manager *manager,
+				   dma_addr_t handle,
+				   struct io_bounce_buffer_info *info,
+				   void **orig_buffer, int *prot)
+{
+	struct io_buffer_node *node;
+	unsigned long flags;
+
+	spin_lock_irqsave(&manager->fallback_lock, flags);
+	node = find_fallback_node(&manager->fallback_buffers, handle);
+	spin_unlock_irqrestore(&manager->fallback_lock, flags);
+
+	if (!node)
+		return false;
+
+	*info = node->info;
+	*orig_buffer = node->orig_buffer;
+	*prot = node->prot;
+	return true;
+}
+
+bool io_buffer_manager_release_buffer(struct io_buffer_manager *manager,
+				      struct iommu_domain *domain,
+				      dma_addr_t handle, bool inited)
+{
+	struct io_buffer_node *node;
+	unsigned long flags;
+	bool free_buffer;
+
+	spin_lock_irqsave(&manager->fallback_lock, flags);
+	node = find_fallback_node(&manager->fallback_buffers, handle);
+	if (node)
+		rb_erase(&node->node, &manager->fallback_buffers);
+	spin_unlock_irqrestore(&manager->fallback_lock, flags);
+
+	if (!node)
+		return false;
+
+	if (inited)
+		free_buffer = io_bounce_buffers_release_buffer_cb(
+			manager, node->info.iova, node->info.size);
+	else
+		free_buffer = true;
+
+	if (free_buffer) {
+		io_buffer_manager_free_pages(node->info.bounce_buffer,
+					     node->info.size >> PAGE_SHIFT);
+		__iommu_dma_free_iova(domain->iova_cookie, node->info.iova,
+				      node->info.size, NULL);
+	} else {
+		pr_warn("Bounce buffer release failed; leaking buffer\n");
+	}
+
+	kfree(node);
+	return true;
+}
+
+int io_buffer_manager_init(struct io_buffer_manager *manager)
+{
+	manager->fallback_buffers = RB_ROOT;
+	spin_lock_init(&manager->fallback_lock);
+
+	return 0;
+}
diff --git a/drivers/iommu/io-buffer-manager.h b/drivers/iommu/io-buffer-manager.h
new file mode 100644
index 000000000000..aae560cc8512
--- /dev/null
+++ b/drivers/iommu/io-buffer-manager.h
@@ -0,0 +1,43 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2021 Google, Inc.
+ */
+
+#ifndef _LINUX_IO_BUFFER_MANAGER_H
+#define _LINUX_IO_BUFFER_MANAGER_H
+
+#include <linux/dma-iommu.h>
+#include <linux/iova.h>
+#include <linux/spinlock.h>
+
+struct io_buffer_manager {
+	spinlock_t fallback_lock;
+	struct rb_root fallback_buffers;
+};
+
+struct io_bounce_buffer_info {
+	struct page **bounce_buffer;
+	dma_addr_t iova;
+	size_t size;
+};
+
+bool io_buffer_manager_alloc_buffer(struct io_buffer_manager *manager,
+				    struct device *dev, void *orig_buffer,
+				    size_t size, int prot, unsigned int nid,
+				    struct io_bounce_buffer_info *info);
+
+bool io_buffer_manager_find_buffer(struct io_buffer_manager *manager,
+				   dma_addr_t handle,
+				   struct io_bounce_buffer_info *info,
+				   void **orig_buffer, int *prot);
+
+bool io_buffer_manager_release_buffer(struct io_buffer_manager *manager,
+				      struct iommu_domain *domain,
+				      dma_addr_t handle, bool inited);
+
+int io_buffer_manager_init(struct io_buffer_manager *manager);
+
+bool io_bounce_buffers_release_buffer_cb(struct io_buffer_manager *manager,
+					 dma_addr_t iova, size_t size);
+
+#endif /* _LINUX_IO_BUFFER_MANAGER_H */
-- 
2.32.0.605.g8dce9f2422-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
