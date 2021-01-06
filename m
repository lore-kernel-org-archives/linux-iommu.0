Return-Path: <SRS0=DPil=GJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB4FC433E0
	for <iommu@archiver.kernel.org>; Wed,  6 Jan 2021 03:41:50 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6164722D04
	for <iommu@archiver.kernel.org>; Wed,  6 Jan 2021 03:41:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6164722D04
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 031AD85570;
	Wed,  6 Jan 2021 03:41:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fceIYGYWssEg; Wed,  6 Jan 2021 03:41:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 474E8855CE;
	Wed,  6 Jan 2021 03:41:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 34100C0891;
	Wed,  6 Jan 2021 03:41:49 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 12A33C013A
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jan 2021 03:41:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 0EA7386AF8
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jan 2021 03:41:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Xebc+ceYAiCl for <iommu@lists.linux-foundation.org>;
 Wed,  6 Jan 2021 03:41:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com
 [209.85.215.175])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 4152D86AEF
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jan 2021 03:41:47 +0000 (UTC)
Received: by mail-pg1-f175.google.com with SMTP id n7so1318877pgg.2
 for <iommu@lists.linux-foundation.org>; Tue, 05 Jan 2021 19:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Dj8JKlKorbjSOdwS0lvNYWFk7amT5kVhimzXI22aOmo=;
 b=nyHDRg7Vmv1AYnOmtvFMyhhjPOqDXplXsE46O+JQcnB7v+fs3ZJWBBx1UfSrKuJzD/
 qiFZ8JU9bombqMxXDm/lZSO/uU9UIeCy/s4FTWAcP6gjSJdtc1DTG2nFcQh6/7gh/rE4
 s4F6iUuPmIjkPdKaCf1nMPPcD/1GvLZGYzHJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Dj8JKlKorbjSOdwS0lvNYWFk7amT5kVhimzXI22aOmo=;
 b=i42vExc7QzyDk92Uuxc74izsBQS04S1cL2MGacdxNVQmxzNPHKq+qx73+cngmPAFRV
 aui98MpqV/XYVYEwOB2vxUKeAMfpaeUqHIZM4l9IvdraOaEZHOBbb4xMRne8jAIt5qIh
 25hZrEBaChCFnsSAOGJEBm8UbSUN2jl8OS8oZaIXRtvuYp9Fh8qeclt8Qk9jeI/nCglV
 rr7zQmnhiSDXBSEOe2ws9xKN8Xmkwyy/Fj+LF12+Xhp6dKsJXBNvmRhtChSfv1C+k9aj
 XjYhqiwxa/VxyshXo5AnKAeFIHpwI417Ou2bkeqFURyvRR4bLDTDVW1HDfHVQUqOmvXS
 sNLA==
X-Gm-Message-State: AOAM530HPj0tgi1BZMK468MiJc3jJsxtlvKAZLDbnfTh4ibBcej3Y5Bn
 r0J2wqNbt6aA7EDNlXLIgezfhg==
X-Google-Smtp-Source: ABdhPJz99z2RdIIx1bNT47v5aDKOf5A60/F7kX7ZvEglTd1/imvNFy1tfXVN1FEQPH8zUfX6RY9tlA==
X-Received: by 2002:aa7:810a:0:b029:1a6:501b:19ed with SMTP id
 b10-20020aa7810a0000b02901a6501b19edmr1942562pfi.17.1609904506706; 
 Tue, 05 Jan 2021 19:41:46 -0800 (PST)
Received: from localhost ([2401:fa00:1:10:3e52:82ff:fe5e:cc9d])
 by smtp.gmail.com with ESMTPSA id x23sm631878pgk.14.2021.01.05.19.41.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Jan 2021 19:41:46 -0800 (PST)
From: Claire Chang <tientzu@chromium.org>
To: robh+dt@kernel.org, mpe@ellerman.id.au, benh@kernel.crashing.org,
 paulus@samba.org, joro@8bytes.org, will@kernel.org, frowand.list@gmail.com,
 konrad.wilk@oracle.com, boris.ostrovsky@oracle.com, jgross@suse.com,
 sstabellini@kernel.org, hch@lst.de, m.szyprowski@samsung.com,
 robin.murphy@arm.com
Subject: [RFC PATCH v3 2/6] swiotlb: Add restricted DMA pool
Date: Wed,  6 Jan 2021 11:41:20 +0800
Message-Id: <20210106034124.30560-3-tientzu@chromium.org>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
In-Reply-To: <20210106034124.30560-1-tientzu@chromium.org>
References: <20210106034124.30560-1-tientzu@chromium.org>
MIME-Version: 1.0
Cc: heikki.krogerus@linux.intel.com, peterz@infradead.org, grant.likely@arm.com,
 mingo@kernel.org, drinkcat@chromium.org, saravanak@google.com,
 xypron.glpk@gmx.de, rafael.j.wysocki@intel.com, bgolaszewski@baylibre.com,
 xen-devel@lists.xenproject.org, treding@nvidia.com, devicetree@vger.kernel.org,
 Claire Chang <tientzu@chromium.org>, dan.j.williams@intel.com,
 andriy.shevchenko@linux.intel.com, gregkh@linuxfoundation.org,
 rdunlap@infradead.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org
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

Add the initialization function to create restricted DMA pools from
matching reserved-memory nodes in the device tree.

Signed-off-by: Claire Chang <tientzu@chromium.org>
---
 include/linux/device.h  |   4 ++
 include/linux/swiotlb.h |   7 +-
 kernel/dma/Kconfig      |   1 +
 kernel/dma/swiotlb.c    | 144 ++++++++++++++++++++++++++++++++++------
 4 files changed, 131 insertions(+), 25 deletions(-)

diff --git a/include/linux/device.h b/include/linux/device.h
index 89bb8b84173e..ca6f71ec8871 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -413,6 +413,7 @@ struct dev_links_info {
  * @dma_pools:	Dma pools (if dma'ble device).
  * @dma_mem:	Internal for coherent mem override.
  * @cma_area:	Contiguous memory area for dma allocations
+ * @dma_io_tlb_mem: Internal for swiotlb io_tlb_mem override.
  * @archdata:	For arch-specific additions.
  * @of_node:	Associated device tree node.
  * @fwnode:	Associated device node supplied by platform firmware.
@@ -515,6 +516,9 @@ struct device {
 #ifdef CONFIG_DMA_CMA
 	struct cma *cma_area;		/* contiguous memory area for dma
 					   allocations */
+#endif
+#ifdef CONFIG_SWIOTLB
+	struct io_tlb_mem	*dma_io_tlb_mem;
 #endif
 	/* arch specific additions */
 	struct dev_archdata	archdata;
diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index dd8eb57cbb8f..a1bbd7788885 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -76,12 +76,13 @@ extern enum swiotlb_force swiotlb_force;
  *
  * @start:	The start address of the swiotlb memory pool. Used to do a quick
  *		range check to see if the memory was in fact allocated by this
- *		API.
+ *		API. For restricted DMA pool, this is device tree adjustable.
  * @end:	The end address of the swiotlb memory pool. Used to do a quick
  *		range check to see if the memory was in fact allocated by this
- *		API.
+ *		API. For restricted DMA pool, this is device tree adjustable.
  * @nslabs:	The number of IO TLB blocks (in groups of 64) between @start and
- *		@end. This is command line adjustable via setup_io_tlb_npages.
+ *		@end. For default swiotlb, this is command line adjustable via
+ *		setup_io_tlb_npages.
  * @used:	The number of used IO TLB block.
  * @list:	The free list describing the number of free entries available
  *		from each index.
diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index 479fc145acfc..131a0a66781b 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -82,6 +82,7 @@ config ARCH_HAS_FORCE_DMA_UNENCRYPTED
 config SWIOTLB
 	bool
 	select NEED_DMA_MAP_STATE
+	select OF_EARLY_FLATTREE
 
 #
 # Should be selected if we can mmap non-coherent mappings to userspace.
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index e4368159f88a..7fb2ac087d23 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -36,6 +36,11 @@
 #include <linux/scatterlist.h>
 #include <linux/mem_encrypt.h>
 #include <linux/set_memory.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_fdt.h>
+#include <linux/of_reserved_mem.h>
+#include <linux/slab.h>
 #ifdef CONFIG_DEBUG_FS
 #include <linux/debugfs.h>
 #endif
@@ -319,20 +324,21 @@ static void swiotlb_cleanup(void)
 	max_segment = 0;
 }
 
-int
-swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs)
+static int swiotlb_init_io_tlb_mem(struct io_tlb_mem *mem, phys_addr_t start,
+				   size_t size)
 {
-	struct io_tlb_mem *mem = &io_tlb_default_mem;
-	unsigned long i, bytes;
+	unsigned long i;
+	void *vaddr = phys_to_virt(start);
 
-	bytes = nslabs << IO_TLB_SHIFT;
+	size = ALIGN(size, 1 << IO_TLB_SHIFT);
+	mem->nslabs = size >> IO_TLB_SHIFT;
+	mem->nslabs = ALIGN(mem->nslabs, IO_TLB_SEGSIZE);
 
-	mem->nslabs = nslabs;
-	mem->start = virt_to_phys(tlb);
-	mem->end = mem->start + bytes;
+	mem->start = start;
+	mem->end = mem->start + size;
 
-	set_memory_decrypted((unsigned long)tlb, bytes >> PAGE_SHIFT);
-	memset(tlb, 0, bytes);
+	set_memory_decrypted((unsigned long)vaddr, size >> PAGE_SHIFT);
+	memset(vaddr, 0, size);
 
 	/*
 	 * Allocate and initialize the free list array.  This array is used
@@ -356,13 +362,6 @@ swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs)
 		mem->orig_addr[i] = INVALID_PHYS_ADDR;
 	}
 	mem->index = 0;
-	no_iotlb_memory = false;
-
-	swiotlb_print_info();
-
-	late_alloc = 1;
-
-	swiotlb_set_max_segment(mem->nslabs << IO_TLB_SHIFT);
 
 	return 0;
 
@@ -375,6 +374,27 @@ swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs)
 	return -ENOMEM;
 }
 
+int swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs)
+{
+	struct io_tlb_mem *mem = &io_tlb_default_mem;
+	unsigned long bytes = nslabs << IO_TLB_SHIFT;
+	int ret;
+
+	ret = swiotlb_init_io_tlb_mem(mem, virt_to_phys(tlb), bytes);
+	if (ret)
+		return ret;
+
+	no_iotlb_memory = false;
+
+	swiotlb_print_info();
+
+	late_alloc = 1;
+
+	swiotlb_set_max_segment(bytes);
+
+	return 0;
+}
+
 void __init swiotlb_exit(void)
 {
 	struct io_tlb_mem *mem = &io_tlb_default_mem;
@@ -703,16 +723,96 @@ bool is_swiotlb_active(void)
 
 #ifdef CONFIG_DEBUG_FS
 
-static int __init swiotlb_create_debugfs(void)
+static void swiotlb_create_debugfs(struct io_tlb_mem *mem, const char *name,
+				   struct dentry *node)
 {
-	struct io_tlb_mem *mem = &io_tlb_default_mem;
-
-	mem->debugfs = debugfs_create_dir("swiotlb", NULL);
+	mem->debugfs = debugfs_create_dir(name, node);
 	debugfs_create_ulong("io_tlb_nslabs", 0400, mem->debugfs, &mem->nslabs);
 	debugfs_create_ulong("io_tlb_used", 0400, mem->debugfs, &mem->used);
+}
+
+static int __init swiotlb_create_default_debugfs(void)
+{
+	swiotlb_create_debugfs(&io_tlb_default_mem, "swiotlb", NULL);
+
 	return 0;
 }
 
-late_initcall(swiotlb_create_debugfs);
+late_initcall(swiotlb_create_default_debugfs);
 
 #endif
+
+static int rmem_swiotlb_device_init(struct reserved_mem *rmem,
+				    struct device *dev)
+{
+	struct io_tlb_mem *mem = rmem->priv;
+	int ret;
+
+	if (dev->dma_io_tlb_mem)
+		return -EBUSY;
+
+	if (!mem) {
+		mem = kzalloc(sizeof(*mem), GFP_KERNEL);
+		if (!mem)
+			return -ENOMEM;
+
+		if (!memremap(rmem->base, rmem->size, MEMREMAP_WB)) {
+			ret = -EINVAL;
+			goto cleanup;
+		}
+
+		ret = swiotlb_init_io_tlb_mem(mem, rmem->base, rmem->size);
+		if (ret)
+			goto cleanup;
+
+		rmem->priv = mem;
+	}
+
+#ifdef CONFIG_DEBUG_FS
+	swiotlb_create_debugfs(mem, dev_name(dev), io_tlb_default_mem.debugfs);
+#endif
+
+	dev->dma_io_tlb_mem = mem;
+
+	return 0;
+
+cleanup:
+	kfree(mem);
+
+	return ret;
+}
+
+static void rmem_swiotlb_device_release(struct reserved_mem *rmem,
+					struct device *dev)
+{
+	if (!dev)
+		return;
+
+#ifdef CONFIG_DEBUG_FS
+	debugfs_remove_recursive(dev->dma_io_tlb_mem->debugfs);
+#endif
+	dev->dma_io_tlb_mem = NULL;
+}
+
+static const struct reserved_mem_ops rmem_swiotlb_ops = {
+	.device_init	= rmem_swiotlb_device_init,
+	.device_release	= rmem_swiotlb_device_release,
+};
+
+static int __init rmem_swiotlb_setup(struct reserved_mem *rmem)
+{
+	unsigned long node = rmem->fdt_node;
+
+	if (of_get_flat_dt_prop(node, "reusable", NULL) ||
+	    of_get_flat_dt_prop(node, "linux,cma-default", NULL) ||
+	    of_get_flat_dt_prop(node, "linux,dma-default", NULL) ||
+	    of_get_flat_dt_prop(node, "no-map", NULL))
+		return -EINVAL;
+
+	rmem->ops = &rmem_swiotlb_ops;
+	pr_info("Reserved memory: created device swiotlb memory pool at %pa, size %ld MiB\n",
+		&rmem->base, (unsigned long)rmem->size / SZ_1M);
+	return 0;
+}
+
+RESERVEDMEM_OF_DECLARE(dma, "restricted-dma-pool", rmem_swiotlb_setup);
-- 
2.29.2.729.g45daf8777d-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
