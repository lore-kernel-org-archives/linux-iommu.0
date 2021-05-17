Return-Path: <SRS0=Mf8z=KM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 832CFC43600
	for <iommu@archiver.kernel.org>; Mon, 17 May 2021 10:02:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E21E6008E
	for <iommu@archiver.kernel.org>; Mon, 17 May 2021 10:02:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E21E6008E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id F0F81404DB;
	Mon, 17 May 2021 10:02:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Em1t-tcNRDEy; Mon, 17 May 2021 10:02:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8F85F404D7;
	Mon, 17 May 2021 10:02:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 881A9C0022;
	Mon, 17 May 2021 10:02:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 33C03C0001
 for <iommu@lists.linux-foundation.org>; Mon, 17 May 2021 09:56:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 15923400F4
 for <iommu@lists.linux-foundation.org>; Mon, 17 May 2021 09:56:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PujqDg_liUsZ for <iommu@lists.linux-foundation.org>;
 Mon, 17 May 2021 09:56:41 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com
 [IPv6:2607:f8b0:4864:20::430])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 08D3240282
 for <iommu@lists.linux-foundation.org>; Mon, 17 May 2021 09:56:36 +0000 (UTC)
Received: by mail-pf1-x430.google.com with SMTP id c17so4575435pfn.6
 for <iommu@lists.linux-foundation.org>; Mon, 17 May 2021 02:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hoAtLiRrlnpVO+dLi72CXlnN2jmtqImhZcu6dtX0W3g=;
 b=PaJhBXadgomCQdWGfB1BW2y4tYRpoQMxnd+NFKbnGwBPFJy0kXdSAkFQyLguDrKpzb
 shyqbgnHUFG8x2o+kKhvy68zLMMS92dKdRKb4W2Vm+6wHxjirLSsqyGKfF106fVYtA35
 sHteREgSI1VlwzjbegasVMTNx0xImuAvTUk/NmzRV9IFWaGMDlX+bigpyh9q+1jZCdMJ
 sc7QHqG6A+CXZFaKBgTEqH6opAGk4aTqFwmhoMcxNarKFIGuMNE1qjnLGj1hiUYDi+8t
 D+JJk7diTtIjj+qepWteMQJnkMdncuXVhGU24et8HZuxkDYyh1uW/e+e9IH9n8OdFb8t
 rz0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hoAtLiRrlnpVO+dLi72CXlnN2jmtqImhZcu6dtX0W3g=;
 b=ACRQLzSJQIKRne2DBGUVDBT9MImJ1gRhk1OcpDxhboV5hK7gfwLzvSGHu0NT2cAgax
 XbbE8DUgddUrTPb4GEl1enPx31lqFaSIrLWBiRvhCI/gKr9yPLXlhYPsak6E2MnWoJd9
 3kCBt5mSKPt02KzBegKpNxVtCeQdx8mBSBBM4AcLQQk6OX/mNTDOcmRqtaYnk9j1azFT
 lbfTmG6TBi+b5GxzQx9Z8wiS9PzxvHphzWSF/FwzJwSnWCBbSY43e3ARTUavZxW9G9YK
 0kS5GHw26VRw4Gv/DMJda9WvTxFf/NMUkvLpEsvsxBrG+deZhSH2lbd4eSGBIziJD4QR
 J96Q==
X-Gm-Message-State: AOAM530N+ItcCt1iDVncjzUji93Ah2AFcVil/uD5aEq+pyu2sOC2hG3F
 5nFeElxy2vS3RJZQa0n9yvww
X-Google-Smtp-Source: ABdhPJwG1Imyv2mTwQJr7/u81IGyTuXLr1894C/kISVUIDPCgLwo7wOyhcAN0mmhVYI8AqbKUT8dEQ==
X-Received: by 2002:a05:6a00:2290:b029:2d5:451b:f16c with SMTP id
 f16-20020a056a002290b02902d5451bf16cmr16592506pfe.55.1621245396420; 
 Mon, 17 May 2021 02:56:36 -0700 (PDT)
Received: from localhost ([139.177.225.253])
 by smtp.gmail.com with ESMTPSA id 11sm4945388pfh.182.2021.05.17.02.56.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 May 2021 02:56:35 -0700 (PDT)
From: Xie Yongji <xieyongji@bytedance.com>
To: mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
 sgarzare@redhat.com, parav@nvidia.com, hch@infradead.org,
 christian.brauner@canonical.com, rdunlap@infradead.org,
 willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
 bcrl@kvack.org, corbet@lwn.net, mika.penttila@nextfour.com,
 dan.carpenter@oracle.com, joro@8bytes.org
Subject: [PATCH v7 10/12] vduse: Implement an MMU-based IOMMU driver
Date: Mon, 17 May 2021 17:55:11 +0800
Message-Id: <20210517095513.850-11-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210517095513.850-1-xieyongji@bytedance.com>
References: <20210517095513.850-1-xieyongji@bytedance.com>
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 17 May 2021 10:01:55 +0000
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 linux-fsdevel@vger.kernel.org
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

This implements an MMU-based IOMMU driver to support mapping
kernel dma buffer into userspace. The basic idea behind it is
treating MMU (VA->PA) as IOMMU (IOVA->PA). The driver will set
up MMU mapping instead of IOMMU mapping for the DMA transfer so
that the userspace process is able to use its virtual address to
access the dma buffer in kernel.

And to avoid security issue, a bounce-buffering mechanism is
introduced to prevent userspace accessing the original buffer
directly.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vdpa/vdpa_user/iova_domain.c | 531 +++++++++++++++++++++++++++++++++++
 drivers/vdpa/vdpa_user/iova_domain.h |  70 +++++
 2 files changed, 601 insertions(+)
 create mode 100644 drivers/vdpa/vdpa_user/iova_domain.c
 create mode 100644 drivers/vdpa/vdpa_user/iova_domain.h

diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_user/iova_domain.c
new file mode 100644
index 000000000000..560b0516f6cd
--- /dev/null
+++ b/drivers/vdpa/vdpa_user/iova_domain.c
@@ -0,0 +1,531 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * MMU-based IOMMU implementation
+ *
+ * Copyright (C) 2020-2021 Bytedance Inc. and/or its affiliates. All rights reserved.
+ *
+ * Author: Xie Yongji <xieyongji@bytedance.com>
+ *
+ */
+
+#include <linux/slab.h>
+#include <linux/file.h>
+#include <linux/anon_inodes.h>
+#include <linux/highmem.h>
+#include <linux/vmalloc.h>
+#include <linux/vdpa.h>
+
+#include "iova_domain.h"
+
+static int vduse_iotlb_add_range(struct vduse_iova_domain *domain,
+				 u64 start, u64 last,
+				 u64 addr, unsigned int perm,
+				 struct file *file, u64 offset)
+{
+	struct vdpa_map_file *map_file;
+	int ret;
+
+	map_file = kmalloc(sizeof(*map_file), GFP_ATOMIC);
+	if (!map_file)
+		return -ENOMEM;
+
+	map_file->file = get_file(file);
+	map_file->offset = offset;
+
+	ret = vhost_iotlb_add_range_ctx(domain->iotlb, start, last,
+					addr, perm, map_file);
+	if (ret) {
+		fput(map_file->file);
+		kfree(map_file);
+		return ret;
+	}
+	return 0;
+}
+
+static void vduse_iotlb_del_range(struct vduse_iova_domain *domain,
+				  u64 start, u64 last)
+{
+	struct vdpa_map_file *map_file;
+	struct vhost_iotlb_map *map;
+
+	while ((map = vhost_iotlb_itree_first(domain->iotlb, start, last))) {
+		map_file = (struct vdpa_map_file *)map->opaque;
+		fput(map_file->file);
+		kfree(map_file);
+		vhost_iotlb_map_free(domain->iotlb, map);
+	}
+}
+
+int vduse_domain_set_map(struct vduse_iova_domain *domain,
+			 struct vhost_iotlb *iotlb)
+{
+	struct vdpa_map_file *map_file;
+	struct vhost_iotlb_map *map;
+	u64 start = 0ULL, last = ULLONG_MAX;
+	int ret;
+
+	spin_lock(&domain->iotlb_lock);
+	vduse_iotlb_del_range(domain, start, last);
+
+	for (map = vhost_iotlb_itree_first(iotlb, start, last); map;
+	     map = vhost_iotlb_itree_next(map, start, last)) {
+		map_file = (struct vdpa_map_file *)map->opaque;
+		ret = vduse_iotlb_add_range(domain, map->start, map->last,
+					    map->addr, map->perm,
+					    map_file->file,
+					    map_file->offset);
+		if (ret)
+			goto err;
+	}
+	spin_unlock(&domain->iotlb_lock);
+
+	return 0;
+err:
+	vduse_iotlb_del_range(domain, start, last);
+	spin_unlock(&domain->iotlb_lock);
+	return ret;
+}
+
+static int vduse_domain_map_bounce_page(struct vduse_iova_domain *domain,
+					 u64 iova, u64 size, u64 paddr)
+{
+	struct vduse_bounce_map *map;
+	u64 last = iova + size - 1;
+
+	while (iova <= last) {
+		map = &domain->bounce_maps[iova >> PAGE_SHIFT];
+		if (!map->bounce_page) {
+			map->bounce_page = alloc_page(GFP_ATOMIC);
+			if (!map->bounce_page)
+				return -ENOMEM;
+		}
+		map->orig_phys = paddr;
+		paddr += PAGE_SIZE;
+		iova += PAGE_SIZE;
+	}
+	return 0;
+}
+
+static void vduse_domain_unmap_bounce_page(struct vduse_iova_domain *domain,
+					   u64 iova, u64 size)
+{
+	struct vduse_bounce_map *map;
+	u64 last = iova + size - 1;
+
+	while (iova <= last) {
+		map = &domain->bounce_maps[iova >> PAGE_SHIFT];
+		map->orig_phys = INVALID_PHYS_ADDR;
+		iova += PAGE_SIZE;
+	}
+}
+
+static void do_bounce(phys_addr_t orig, void *addr, size_t size,
+		      enum dma_data_direction dir)
+{
+	unsigned long pfn = PFN_DOWN(orig);
+	unsigned int offset = offset_in_page(orig);
+	char *buffer;
+	unsigned int sz = 0;
+
+	while (size) {
+		sz = min_t(size_t, PAGE_SIZE - offset, size);
+
+		buffer = kmap_atomic(pfn_to_page(pfn));
+		if (dir == DMA_TO_DEVICE)
+			memcpy(addr, buffer + offset, sz);
+		else
+			memcpy(buffer + offset, addr, sz);
+		kunmap_atomic(buffer);
+
+		size -= sz;
+		pfn++;
+		addr += sz;
+		offset = 0;
+	}
+}
+
+static void vduse_domain_bounce(struct vduse_iova_domain *domain,
+				dma_addr_t iova, size_t size,
+				enum dma_data_direction dir)
+{
+	struct vduse_bounce_map *map;
+	unsigned int offset;
+	void *addr;
+	size_t sz;
+
+	if (iova >= domain->bounce_size)
+		return;
+
+	while (size) {
+		map = &domain->bounce_maps[iova >> PAGE_SHIFT];
+		offset = offset_in_page(iova);
+		sz = min_t(size_t, PAGE_SIZE - offset, size);
+
+		if (WARN_ON(!map->bounce_page ||
+			    map->orig_phys == INVALID_PHYS_ADDR))
+			return;
+
+		addr = page_address(map->bounce_page) + offset;
+		do_bounce(map->orig_phys + offset, addr, sz, dir);
+		size -= sz;
+		iova += sz;
+	}
+}
+
+static struct page *
+vduse_domain_get_coherent_page(struct vduse_iova_domain *domain, u64 iova)
+{
+	u64 start = iova & PAGE_MASK;
+	u64 last = start + PAGE_SIZE - 1;
+	struct vhost_iotlb_map *map;
+	struct page *page = NULL;
+
+	spin_lock(&domain->iotlb_lock);
+	map = vhost_iotlb_itree_first(domain->iotlb, start, last);
+	if (!map)
+		goto out;
+
+	page = pfn_to_page((map->addr + iova - map->start) >> PAGE_SHIFT);
+	get_page(page);
+out:
+	spin_unlock(&domain->iotlb_lock);
+
+	return page;
+}
+
+static struct page *
+vduse_domain_get_bounce_page(struct vduse_iova_domain *domain, u64 iova)
+{
+	struct vduse_bounce_map *map;
+	struct page *page = NULL;
+
+	spin_lock(&domain->iotlb_lock);
+	map = &domain->bounce_maps[iova >> PAGE_SHIFT];
+	if (!map->bounce_page)
+		goto out;
+
+	page = map->bounce_page;
+	get_page(page);
+out:
+	spin_unlock(&domain->iotlb_lock);
+
+	return page;
+}
+
+static void
+vduse_domain_free_bounce_pages(struct vduse_iova_domain *domain)
+{
+	struct vduse_bounce_map *map;
+	unsigned long pfn, bounce_pfns;
+
+	spin_lock(&domain->iotlb_lock);
+	bounce_pfns = domain->bounce_size >> PAGE_SHIFT;
+
+	for (pfn = 0; pfn < bounce_pfns; pfn++) {
+		map = &domain->bounce_maps[pfn];
+		if (WARN_ON(map->orig_phys != INVALID_PHYS_ADDR))
+			continue;
+
+		if (!map->bounce_page)
+			continue;
+
+		__free_page(map->bounce_page);
+		map->bounce_page = NULL;
+	}
+	spin_unlock(&domain->iotlb_lock);
+}
+
+void vduse_domain_reset_bounce_map(struct vduse_iova_domain *domain)
+{
+	if (!domain->bounce_map)
+		return;
+
+	spin_lock(&domain->iotlb_lock);
+	if (!domain->bounce_map)
+		goto unlock;
+
+	vduse_iotlb_del_range(domain, 0, domain->bounce_size - 1);
+	domain->bounce_map = 0;
+unlock:
+	spin_unlock(&domain->iotlb_lock);
+}
+
+static int vduse_domain_init_bounce_map(struct vduse_iova_domain *domain)
+{
+	int ret = 0;
+
+	if (domain->bounce_map)
+		return 0;
+
+	spin_lock(&domain->iotlb_lock);
+	if (domain->bounce_map)
+		goto unlock;
+
+	ret = vduse_iotlb_add_range(domain, 0, domain->bounce_size - 1,
+				    0, VHOST_MAP_RW, domain->file, 0);
+	if (ret)
+		goto unlock;
+
+	domain->bounce_map = 1;
+unlock:
+	spin_unlock(&domain->iotlb_lock);
+	return ret;
+}
+
+static dma_addr_t
+vduse_domain_alloc_iova(struct iova_domain *iovad,
+			unsigned long size, unsigned long limit)
+{
+	unsigned long shift = iova_shift(iovad);
+	unsigned long iova_len = iova_align(iovad, size) >> shift;
+	unsigned long iova_pfn;
+
+	/*
+	 * Freeing non-power-of-two-sized allocations back into the IOVA caches
+	 * will come back to bite us badly, so we have to waste a bit of space
+	 * rounding up anything cacheable to make sure that can't happen. The
+	 * order of the unadjusted size will still match upon freeing.
+	 */
+	if (iova_len < (1 << (IOVA_RANGE_CACHE_MAX_SIZE - 1)))
+		iova_len = roundup_pow_of_two(iova_len);
+	iova_pfn = alloc_iova_fast(iovad, iova_len, limit >> shift, true);
+
+	return iova_pfn << shift;
+}
+
+static void vduse_domain_free_iova(struct iova_domain *iovad,
+				   dma_addr_t iova, size_t size)
+{
+	unsigned long shift = iova_shift(iovad);
+	unsigned long iova_len = iova_align(iovad, size) >> shift;
+
+	free_iova_fast(iovad, iova >> shift, iova_len);
+}
+
+dma_addr_t vduse_domain_map_page(struct vduse_iova_domain *domain,
+				 struct page *page, unsigned long offset,
+				 size_t size, enum dma_data_direction dir,
+				 unsigned long attrs)
+{
+	struct iova_domain *iovad = &domain->stream_iovad;
+	unsigned long limit = domain->bounce_size - 1;
+	phys_addr_t pa = page_to_phys(page) + offset;
+	dma_addr_t iova = vduse_domain_alloc_iova(iovad, size, limit);
+
+	if (!iova)
+		return DMA_MAPPING_ERROR;
+
+	if (vduse_domain_init_bounce_map(domain))
+		goto err;
+
+	if (vduse_domain_map_bounce_page(domain, (u64)iova, (u64)size, pa))
+		goto err;
+
+	if (dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL)
+		vduse_domain_bounce(domain, iova, size, DMA_TO_DEVICE);
+
+	return iova;
+err:
+	vduse_domain_free_iova(iovad, iova, size);
+	return DMA_MAPPING_ERROR;
+}
+
+void vduse_domain_unmap_page(struct vduse_iova_domain *domain,
+			     dma_addr_t dma_addr, size_t size,
+			     enum dma_data_direction dir, unsigned long attrs)
+{
+	struct iova_domain *iovad = &domain->stream_iovad;
+
+	if (dir == DMA_FROM_DEVICE || dir == DMA_BIDIRECTIONAL)
+		vduse_domain_bounce(domain, dma_addr, size, DMA_FROM_DEVICE);
+
+	vduse_domain_unmap_bounce_page(domain, (u64)dma_addr, (u64)size);
+	vduse_domain_free_iova(iovad, dma_addr, size);
+}
+
+void *vduse_domain_alloc_coherent(struct vduse_iova_domain *domain,
+				  size_t size, dma_addr_t *dma_addr,
+				  gfp_t flag, unsigned long attrs)
+{
+	struct iova_domain *iovad = &domain->consistent_iovad;
+	unsigned long limit = domain->iova_limit;
+	dma_addr_t iova = vduse_domain_alloc_iova(iovad, size, limit);
+	void *orig = alloc_pages_exact(size, flag);
+
+	if (!iova || !orig)
+		goto err;
+
+	spin_lock(&domain->iotlb_lock);
+	if (vduse_iotlb_add_range(domain, (u64)iova, (u64)iova + size - 1,
+				  virt_to_phys(orig), VHOST_MAP_RW,
+				  domain->file, (u64)iova)) {
+		spin_unlock(&domain->iotlb_lock);
+		goto err;
+	}
+	spin_unlock(&domain->iotlb_lock);
+
+	*dma_addr = iova;
+
+	return orig;
+err:
+	*dma_addr = DMA_MAPPING_ERROR;
+	if (orig)
+		free_pages_exact(orig, size);
+	if (iova)
+		vduse_domain_free_iova(iovad, iova, size);
+
+	return NULL;
+}
+
+void vduse_domain_free_coherent(struct vduse_iova_domain *domain, size_t size,
+				void *vaddr, dma_addr_t dma_addr,
+				unsigned long attrs)
+{
+	struct iova_domain *iovad = &domain->consistent_iovad;
+	struct vhost_iotlb_map *map;
+	struct vdpa_map_file *map_file;
+	phys_addr_t pa;
+
+	spin_lock(&domain->iotlb_lock);
+	map = vhost_iotlb_itree_first(domain->iotlb, (u64)dma_addr,
+				      (u64)dma_addr + size - 1);
+	if (WARN_ON(!map)) {
+		spin_unlock(&domain->iotlb_lock);
+		return;
+	}
+	map_file = (struct vdpa_map_file *)map->opaque;
+	fput(map_file->file);
+	kfree(map_file);
+	pa = map->addr;
+	vhost_iotlb_map_free(domain->iotlb, map);
+	spin_unlock(&domain->iotlb_lock);
+
+	vduse_domain_free_iova(iovad, dma_addr, size);
+	free_pages_exact(phys_to_virt(pa), size);
+}
+
+static vm_fault_t vduse_domain_mmap_fault(struct vm_fault *vmf)
+{
+	struct vduse_iova_domain *domain = vmf->vma->vm_private_data;
+	unsigned long iova = vmf->pgoff << PAGE_SHIFT;
+	struct page *page;
+
+	if (!domain)
+		return VM_FAULT_SIGBUS;
+
+	if (iova < domain->bounce_size)
+		page = vduse_domain_get_bounce_page(domain, iova);
+	else
+		page = vduse_domain_get_coherent_page(domain, iova);
+
+	if (!page)
+		return VM_FAULT_SIGBUS;
+
+	vmf->page = page;
+
+	return 0;
+}
+
+static const struct vm_operations_struct vduse_domain_mmap_ops = {
+	.fault = vduse_domain_mmap_fault,
+};
+
+static int vduse_domain_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	struct vduse_iova_domain *domain = file->private_data;
+
+	vma->vm_flags |= VM_DONTDUMP | VM_DONTEXPAND;
+	vma->vm_private_data = domain;
+	vma->vm_ops = &vduse_domain_mmap_ops;
+
+	return 0;
+}
+
+static int vduse_domain_release(struct inode *inode, struct file *file)
+{
+	struct vduse_iova_domain *domain = file->private_data;
+
+	vduse_domain_reset_bounce_map(domain);
+	vduse_domain_free_bounce_pages(domain);
+	put_iova_domain(&domain->stream_iovad);
+	put_iova_domain(&domain->consistent_iovad);
+	vhost_iotlb_free(domain->iotlb);
+	vfree(domain->bounce_maps);
+	kfree(domain);
+
+	return 0;
+}
+
+static const struct file_operations vduse_domain_fops = {
+	.owner = THIS_MODULE,
+	.mmap = vduse_domain_mmap,
+	.release = vduse_domain_release,
+};
+
+void vduse_domain_destroy(struct vduse_iova_domain *domain)
+{
+	fput(domain->file);
+}
+
+struct vduse_iova_domain *
+vduse_domain_create(unsigned long iova_limit, size_t bounce_size)
+{
+	struct vduse_iova_domain *domain;
+	struct file *file;
+	struct vduse_bounce_map *map;
+	unsigned long pfn, bounce_pfns;
+
+	bounce_pfns = PAGE_ALIGN(bounce_size) >> PAGE_SHIFT;
+	if (iova_limit <= bounce_size)
+		return NULL;
+
+	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
+	if (!domain)
+		return NULL;
+
+	domain->iotlb = vhost_iotlb_alloc(0, 0);
+	if (!domain->iotlb)
+		goto err_iotlb;
+
+	domain->iova_limit = iova_limit;
+	domain->bounce_size = PAGE_ALIGN(bounce_size);
+	domain->bounce_maps = vzalloc(bounce_pfns *
+				sizeof(struct vduse_bounce_map));
+	if (!domain->bounce_maps)
+		goto err_map;
+
+	for (pfn = 0; pfn < bounce_pfns; pfn++) {
+		map = &domain->bounce_maps[pfn];
+		map->orig_phys = INVALID_PHYS_ADDR;
+	}
+	file = anon_inode_getfile("[vduse-domain]", &vduse_domain_fops,
+				domain, O_RDWR);
+	if (IS_ERR(file))
+		goto err_file;
+
+	domain->file = file;
+	spin_lock_init(&domain->iotlb_lock);
+	init_iova_domain(&domain->stream_iovad,
+			PAGE_SIZE, IOVA_START_PFN);
+	init_iova_domain(&domain->consistent_iovad,
+			PAGE_SIZE, bounce_pfns);
+
+	return domain;
+err_file:
+	vfree(domain->bounce_maps);
+err_map:
+	vhost_iotlb_free(domain->iotlb);
+err_iotlb:
+	kfree(domain);
+	return NULL;
+}
+
+int vduse_domain_init(void)
+{
+	return iova_cache_get();
+}
+
+void vduse_domain_exit(void)
+{
+	iova_cache_put();
+}
diff --git a/drivers/vdpa/vdpa_user/iova_domain.h b/drivers/vdpa/vdpa_user/iova_domain.h
new file mode 100644
index 000000000000..31f822afa5f5
--- /dev/null
+++ b/drivers/vdpa/vdpa_user/iova_domain.h
@@ -0,0 +1,70 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * MMU-based IOMMU implementation
+ *
+ * Copyright (C) 2020-2021 Bytedance Inc. and/or its affiliates. All rights reserved.
+ *
+ * Author: Xie Yongji <xieyongji@bytedance.com>
+ *
+ */
+
+#ifndef _VDUSE_IOVA_DOMAIN_H
+#define _VDUSE_IOVA_DOMAIN_H
+
+#include <linux/iova.h>
+#include <linux/dma-mapping.h>
+#include <linux/vhost_iotlb.h>
+
+#define IOVA_START_PFN 1
+
+#define INVALID_PHYS_ADDR (~(phys_addr_t)0)
+
+struct vduse_bounce_map {
+	struct page *bounce_page;
+	u64 orig_phys;
+};
+
+struct vduse_iova_domain {
+	struct iova_domain stream_iovad;
+	struct iova_domain consistent_iovad;
+	struct vduse_bounce_map *bounce_maps;
+	size_t bounce_size;
+	unsigned long iova_limit;
+	int bounce_map;
+	struct vhost_iotlb *iotlb;
+	spinlock_t iotlb_lock;
+	struct file *file;
+};
+
+int vduse_domain_set_map(struct vduse_iova_domain *domain,
+			struct vhost_iotlb *iotlb);
+
+dma_addr_t vduse_domain_map_page(struct vduse_iova_domain *domain,
+				struct page *page, unsigned long offset,
+				size_t size, enum dma_data_direction dir,
+				unsigned long attrs);
+
+void vduse_domain_unmap_page(struct vduse_iova_domain *domain,
+			dma_addr_t dma_addr, size_t size,
+			enum dma_data_direction dir, unsigned long attrs);
+
+void *vduse_domain_alloc_coherent(struct vduse_iova_domain *domain,
+				size_t size, dma_addr_t *dma_addr,
+				gfp_t flag, unsigned long attrs);
+
+void vduse_domain_free_coherent(struct vduse_iova_domain *domain, size_t size,
+				void *vaddr, dma_addr_t dma_addr,
+				unsigned long attrs);
+
+void vduse_domain_reset_bounce_map(struct vduse_iova_domain *domain);
+
+void vduse_domain_destroy(struct vduse_iova_domain *domain);
+
+struct vduse_iova_domain *vduse_domain_create(unsigned long iova_limit,
+						size_t bounce_size);
+
+int vduse_domain_init(void);
+
+void vduse_domain_exit(void);
+
+#endif /* _VDUSE_IOVA_DOMAIN_H */
-- 
2.11.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
