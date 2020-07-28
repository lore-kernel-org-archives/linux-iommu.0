Return-Path: <SRS0=UphA=BH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C518EC433ED
	for <iommu@archiver.kernel.org>; Tue, 28 Jul 2020 05:02:00 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98CF821775
	for <iommu@archiver.kernel.org>; Tue, 28 Jul 2020 05:02:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jLhs3co0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98CF821775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 77DB4868F3;
	Tue, 28 Jul 2020 05:02:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DGgq2JV0uaJl; Tue, 28 Jul 2020 05:01:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C0BAB860CD;
	Tue, 28 Jul 2020 05:01:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ACFDBC004F;
	Tue, 28 Jul 2020 05:01:59 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EAEBDC004D
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jul 2020 05:01:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id D7C74860CD
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jul 2020 05:01:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rJodGtwUbX1L for <iommu@lists.linux-foundation.org>;
 Tue, 28 Jul 2020 05:01:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com
 [209.85.215.196])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 0D8AC86427
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jul 2020 05:01:57 +0000 (UTC)
Received: by mail-pg1-f196.google.com with SMTP id l63so11190573pge.12
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jul 2020 22:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=GzlYUZg9l79IbjjLQqSE/48BZ7PWQ7uRxN6Q6PXEhSQ=;
 b=jLhs3co02jfrEEgXDA7ysPbXZIOT6+aQEIY05gAffMbBj6QlSdbkT1FE0S6W0cG6T5
 LU7+PgVpV29MsP3Qg1Yxoh289spWujm0eYaBb+R7lp2zVr4J+NF9fbtPpXlJLSxdVlHy
 UXZIQfVfLs8E8wHYwC6oick+9vhx7X2X4GaVQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GzlYUZg9l79IbjjLQqSE/48BZ7PWQ7uRxN6Q6PXEhSQ=;
 b=GZV7eId9vhkalLruftKoR8K8IIgEMxJbikWgm3YF0zEr0fA6ajvyAxIMSUFZ3aejAY
 kCS7tiHvzHp619Xr7q8gaZYsUbTjHfm7MYbBXRY27RM357C5RqCehfnZZk3BI3ZsEOcp
 lEZxDrMEbxYcufIwPkY+5AORCQ/A8VTn8g0eUW6My8rGmef5Xt3YlWQC/zjUeEUom68n
 URM/lmxvaDjStYT/YhoZm9HZpzTC+EIwjA1kT3rccYr3DMqvs/6qvbgGYg59gCFqMuwd
 GFBmq156I1X0aypIaQg2mzgIotRrp2pdm31M99T1gGdR8ARbUPmW424BqVbzUx2Vu8YQ
 gqbw==
X-Gm-Message-State: AOAM533cWGFDSpknNrEJMgl6hfQGKy/AVgBQfvezTiEnZ4K/DnYVhkgP
 XHLRAnTGXdLOFaMwy0CN4vatCw==
X-Google-Smtp-Source: ABdhPJyZAgI1AxksVIP03OkPyiL9SyEpbcrgBE+N4KENj9Tb2I3RCkhBC6+eGBSrdfJEuXkYWgCaQg==
X-Received: by 2002:a63:f814:: with SMTP id n20mr22114160pgh.92.1595912516165; 
 Mon, 27 Jul 2020 22:01:56 -0700 (PDT)
Received: from localhost ([2401:fa00:1:10:3e52:82ff:fe5e:cc9d])
 by smtp.gmail.com with ESMTPSA id b185sm16194692pfa.148.2020.07.27.22.01.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jul 2020 22:01:55 -0700 (PDT)
From: Claire Chang <tientzu@chromium.org>
To: robh+dt@kernel.org, frowand.list@gmail.com, hch@lst.de,
 m.szyprowski@samsung.com, robin.murphy@arm.com
Subject: [RFC v2 2/5] swiotlb: Add device swiotlb pool
Date: Tue, 28 Jul 2020 13:01:37 +0800
Message-Id: <20200728050140.996974-3-tientzu@chromium.org>
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
In-Reply-To: <20200728050140.996974-1-tientzu@chromium.org>
References: <20200728050140.996974-1-tientzu@chromium.org>
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, heikki.krogerus@linux.intel.com,
 saravanak@google.com, suzuki.poulose@arm.com, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, bgolaszewski@baylibre.com,
 iommu@lists.linux-foundation.org, drinkcat@chromium.org, tientzu@chromium.org,
 dan.j.williams@intel.com, treding@nvidia.com
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

Add the initialization function to create device swiotlb pools from
matching reserved-memory nodes in the device tree.

Signed-off-by: Claire Chang <tientzu@chromium.org>
---
 include/linux/device.h |   4 ++
 kernel/dma/swiotlb.c   | 148 +++++++++++++++++++++++++++++++++--------
 2 files changed, 126 insertions(+), 26 deletions(-)

diff --git a/include/linux/device.h b/include/linux/device.h
index 79ce404619e6..f40f711e43e9 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -575,6 +575,10 @@ struct device {
 	struct cma *cma_area;		/* contiguous memory area for dma
 					   allocations */
 #endif
+#ifdef CONFIG_SWIOTLB
+	struct io_tlb_mem	*dma_io_tlb_mem;
+#endif
+
 	/* arch specific additions */
 	struct dev_archdata	archdata;
 
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index f83911fa14ce..eaa101b3e75b 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -36,6 +36,10 @@
 #include <linux/scatterlist.h>
 #include <linux/mem_encrypt.h>
 #include <linux/set_memory.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_fdt.h>
+#include <linux/of_reserved_mem.h>
 #ifdef CONFIG_DEBUG_FS
 #include <linux/debugfs.h>
 #endif
@@ -298,20 +302,14 @@ static void swiotlb_cleanup(void)
 	max_segment = 0;
 }
 
-int
-swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs)
+static void swiotlb_init_io_tlb_mem(struct io_tlb_mem *mem, phys_addr_t start,
+				    size_t size)
 {
-	struct io_tlb_mem *mem = &io_tlb_default_mem;
-	unsigned long i, bytes;
-
-	bytes = nslabs << IO_TLB_SHIFT;
+	unsigned long i;
 
-	mem->nslabs = nslabs;
-	mem->start = virt_to_phys(tlb);
-	mem->end = mem->start + bytes;
-
-	set_memory_decrypted((unsigned long)tlb, bytes >> PAGE_SHIFT);
-	memset(tlb, 0, bytes);
+	mem->nslabs = size >> IO_TLB_SHIFT;
+	mem->start = start;
+	mem->end = mem->start + size;
 
 	/*
 	 * Allocate and initialize the free list array.  This array is used
@@ -336,11 +334,6 @@ swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs)
 	}
 	mem->index = 0;
 
-	swiotlb_print_info();
-
-	late_alloc = 1;
-
-	swiotlb_set_max_segment(mem->nslabs << IO_TLB_SHIFT);
 	spin_lock_init(&mem->lock);
 
 	return 0;
@@ -354,6 +347,38 @@ swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs)
 	return -ENOMEM;
 }
 
+int swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs)
+{
+	struct io_tlb_mem *mem = &io_tlb_default_mem;
+	unsigned long bytes;
+	int ret;
+
+	bytes = nslabs << IO_TLB_SHIFT;
+
+	set_memory_decrypted((unsigned long)tlb, bytes >> PAGE_SHIFT);
+	memset(tlb, 0, bytes);
+
+	ret = swiotlb_init_io_tlb_mem(mem, virt_to_phys(tlb), bytes);
+	if (ret)
+		return ret;
+
+	swiotlb_print_info();
+
+	late_alloc = 1;
+
+	swiotlb_set_max_segment(mem->nslabs << IO_TLB_SHIFT);
+
+	return 0;
+}
+
+static void swiotlb_free_pages(struct io_tlb_mem *mem)
+{
+	free_pages((unsigned long)mem->orig_addr,
+		   get_order(mem->nslabs * sizeof(phys_addr_t)));
+	free_pages((unsigned long)mem->list,
+		   get_order(mem->nslabs * sizeof(int)));
+}
+
 void __init swiotlb_exit(void)
 {
 	struct io_tlb_mem *mem = &io_tlb_default_mem;
@@ -362,10 +387,7 @@ void __init swiotlb_exit(void)
 		return;
 
 	if (late_alloc) {
-		free_pages((unsigned long)mem->orig_addr,
-			   get_order(mem->nslabs * sizeof(phys_addr_t)));
-		free_pages((unsigned long)mem->list, get_order(mem->nslabs *
-							       sizeof(int)));
+		swiotlb_free_pages(mem);
 		free_pages((unsigned long)phys_to_virt(mem->start),
 			   get_order(mem->nslabs << IO_TLB_SHIFT));
 	} else {
@@ -687,16 +709,90 @@ bool is_swiotlb_active(void)
 
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
+static int device_swiotlb_init(struct reserved_mem *rmem,
+				       struct device *dev)
+{
+	struct io_tlb_mem *mem;
+	int ret;
+
+	if (dev->dma_io_tlb_mem)
+		return 0;
+
+	mem = kzalloc(sizeof(*mem), GFP_KERNEL);
+	if (!mem)
+		return -ENOMEM;
+
+	if (!devm_memremap(dev, rmem->base, rmem->size, MEMREMAP_WB)) {
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	ret = swiotlb_init_io_tlb_mem(mem, rmem->base, rmem->size);
+	if (ret)
+		goto cleanup;
+
+	swiotlb_create_debugfs(mem, dev_name(dev), io_tlb_default_mem.debugfs);
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
+static void device_swiotlb_release(struct reserved_mem *rmem,
+					   struct device *dev)
+{
+	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
+
+	dev->dma_io_tlb_mem = NULL;
+
+	debugfs_remove_recursive(mem->debugfs);
+	swiotlb_free_pages(mem);
+	kfree(mem);
+}
+
+static const struct reserved_mem_ops rmem_device_swiotlb_ops = {
+	.device_init	= device_swiotlb_init,
+	.device_release	= device_swiotlb_release,
+};
+
+static int __init device_swiotlb_pool_setup(struct reserved_mem *rmem)
+{
+	unsigned long node = rmem->fdt_node;
+
+	if (of_get_flat_dt_prop(node, "reusable", NULL) ||
+	    of_get_flat_dt_prop(node, "linux,cma-default", NULL) ||
+	    of_get_flat_dt_prop(node, "linux,dma-default", NULL) ||
+	    of_get_flat_dt_prop(node, "no-map", NULL))
+		return -EINVAL;
+
+	rmem->ops = &rmem_device_swiotlb_ops;
+	pr_info("Reserved memory: created device swiotlb memory pool at %pa, size %ld MiB\n",
+		&rmem->base, (unsigned long)rmem->size / SZ_1M);
+	return 0;
+}
+
+RESERVEDMEM_OF_DECLARE(dma, "device-swiotlb-pool", device_swiotlb_pool_setup);
-- 
2.28.0.rc0.142.g3c755180ce-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
