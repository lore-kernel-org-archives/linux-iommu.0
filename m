Return-Path: <SRS0=nJTY=HL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 313EBC433DB
	for <iommu@archiver.kernel.org>; Tue,  9 Feb 2021 06:22:30 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C190A64E54
	for <iommu@archiver.kernel.org>; Tue,  9 Feb 2021 06:22:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C190A64E54
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9A6E386F96;
	Tue,  9 Feb 2021 06:22:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qXnSjLGChfQh; Tue,  9 Feb 2021 06:22:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 027D086F8D;
	Tue,  9 Feb 2021 06:22:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E1341C0174;
	Tue,  9 Feb 2021 06:22:28 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 17095C013A
 for <iommu@lists.linux-foundation.org>; Tue,  9 Feb 2021 06:22:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 05C1585FE4
 for <iommu@lists.linux-foundation.org>; Tue,  9 Feb 2021 06:22:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uDaQgPLm5ikU for <iommu@lists.linux-foundation.org>;
 Tue,  9 Feb 2021 06:22:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 4BAFA85FD4
 for <iommu@lists.linux-foundation.org>; Tue,  9 Feb 2021 06:22:27 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id s15so9158737plr.9
 for <iommu@lists.linux-foundation.org>; Mon, 08 Feb 2021 22:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CxLFhhx42ZtNAWWPxxTC2YTMXHtyxeDPJClSNQiYoYc=;
 b=FOjc62yoUhk/LYUclkinZZ4zDvKpeGo1x74CjLhqDxql67icfdZqyBr48BDMmzkMqR
 tA+flicJ3qCGmrksh4BzQ5Am4hl3t7sFnye0tmSkf0JhPfYSoJrQn4ouvbgIPDxqcZT9
 22NHFR6mKzgKsRHbHqBZhVhBnyuYHLbdeoeHw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CxLFhhx42ZtNAWWPxxTC2YTMXHtyxeDPJClSNQiYoYc=;
 b=WDv9xePbsPVMWed8lNHWIaM0ec86nF0r5J11LPZOLlvOz/ifMZfyITOA6fp/cr+Kxr
 nNmMp5wfVRfObxEogz207ic86cGUdbiqG+De7uanfMIdf7cTKfOMghNdB2Et5nequgF/
 h1aKEBw5Npr51MoX1Kj1zPfhGpnCiGmW9xaxb8XY68gPG7RTEVUgv3gxWpT55V12XN6g
 ETTpjONV7Z8HWmmYVXJO0NS5mpC6TOkluGONEUI9s/j+gfkdrtgjtvEL0zPW0vvo3N49
 YEkhmBZpgMFXlDsfvZGPNXNaaa8nYbz+riMntyCkwnc8c8zK//iz6L/Ahijkwte0HHrn
 aVew==
X-Gm-Message-State: AOAM533fwYAHc9zAa40pLwGaxUsCxt3u8lj4hm2Zvb3kIZ6gfK+W7zLc
 4ZbQQQ7jQRukaADgD0GaUKbgMg==
X-Google-Smtp-Source: ABdhPJwDHlCULV4tTgyY9CKwnf/NbNTRufsz7Pi36U/uwqUNeuQrkhr5EaPoNzogQlT61PzYunqO5A==
X-Received: by 2002:a17:90a:3188:: with SMTP id
 j8mr2559404pjb.53.1612851746343; 
 Mon, 08 Feb 2021 22:22:26 -0800 (PST)
Received: from localhost ([2401:fa00:1:10:a106:46e1:a999:81df])
 by smtp.gmail.com with UTF8SMTPSA id np7sm1080411pjb.10.2021.02.08.22.22.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Feb 2021 22:22:25 -0800 (PST)
From: Claire Chang <tientzu@chromium.org>
To: Rob Herring <robh+dt@kernel.org>, mpe@ellerman.id.au,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, boris.ostrovsky@oracle.com,
 jgross@suse.com, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v4 06/14] swiotlb: Add restricted DMA pool
Date: Tue,  9 Feb 2021 14:21:23 +0800
Message-Id: <20210209062131.2300005-7-tientzu@chromium.org>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
In-Reply-To: <20210209062131.2300005-1-tientzu@chromium.org>
References: <20210209062131.2300005-1-tientzu@chromium.org>
MIME-Version: 1.0
Cc: heikki.krogerus@linux.intel.com, peterz@infradead.org,
 benh@kernel.crashing.org, grant.likely@arm.com, paulus@samba.org,
 mingo@kernel.org, sstabellini@kernel.org,
 Saravana Kannan <saravanak@google.com>, xypron.glpk@gmx.de,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 xen-devel@lists.xenproject.org, Thierry Reding <treding@nvidia.com>,
 linux-devicetree <devicetree@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org,
 Nicolas Boichat <drinkcat@chromium.org>, Claire Chang <tientzu@chromium.org>,
 Dan Williams <dan.j.williams@intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Greg KH <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
 lkml <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Jim Quinlan <james.quinlan@broadcom.com>, Robin Murphy <robin.murphy@arm.com>
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
matching reserved-memory nodes.

Signed-off-by: Claire Chang <tientzu@chromium.org>
---
 include/linux/device.h |  4 ++
 kernel/dma/swiotlb.c   | 94 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 97 insertions(+), 1 deletion(-)

diff --git a/include/linux/device.h b/include/linux/device.h
index 7619a84f8ce4..08d440627b93 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -415,6 +415,7 @@ struct dev_links_info {
  * @dma_pools:	Dma pools (if dma'ble device).
  * @dma_mem:	Internal for coherent mem override.
  * @cma_area:	Contiguous memory area for dma allocations
+ * @dev_swiotlb: Internal for swiotlb override.
  * @archdata:	For arch-specific additions.
  * @of_node:	Associated device tree node.
  * @fwnode:	Associated device node supplied by platform firmware.
@@ -517,6 +518,9 @@ struct device {
 #ifdef CONFIG_DMA_CMA
 	struct cma *cma_area;		/* contiguous memory area for dma
 					   allocations */
+#endif
+#ifdef CONFIG_DMA_RESTRICTED_POOL
+	struct swiotlb *dev_swiotlb;
 #endif
 	/* arch specific additions */
 	struct dev_archdata	archdata;
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index dc37951c6924..3a17451c5981 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -39,6 +39,13 @@
 #ifdef CONFIG_DEBUG_FS
 #include <linux/debugfs.h>
 #endif
+#ifdef CONFIG_DMA_RESTRICTED_POOL
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_fdt.h>
+#include <linux/of_reserved_mem.h>
+#include <linux/slab.h>
+#endif
 
 #include <asm/io.h>
 #include <asm/dma.h>
@@ -75,7 +82,8 @@ enum swiotlb_force swiotlb_force;
  *              range check to see if the memory was in fact allocated by this
  *              API.
  * @nslabs:     The number of IO TLB blocks (in groups of 64) between @start and
- *              @end. This is command line adjustable via setup_io_tlb_npages.
+ *              @end. For default swiotlb, this is command line adjustable via
+ *              setup_io_tlb_npages.
  * @used:       The number of used IO TLB block.
  * @list:       The free list describing the number of free entries available
  *              from each index.
@@ -780,3 +788,87 @@ static int __init swiotlb_create_default_debugfs(void)
 
 late_initcall(swiotlb_create_default_debugfs);
 #endif
+
+#ifdef CONFIG_DMA_RESTRICTED_POOL
+static int rmem_swiotlb_device_init(struct reserved_mem *rmem,
+				    struct device *dev)
+{
+	struct swiotlb *swiotlb = rmem->priv;
+	int ret;
+
+	if (dev->dev_swiotlb)
+		return -EBUSY;
+
+	/* Since multiple devices can share the same pool, the private data,
+	 * swiotlb struct, will be initialized by the first device attached
+	 * to it.
+	 */
+	if (!swiotlb) {
+		swiotlb = kzalloc(sizeof(*swiotlb), GFP_KERNEL);
+		if (!swiotlb)
+			return -ENOMEM;
+#ifdef CONFIG_ARM
+		unsigned long pfn = PHYS_PFN(reme->base);
+
+		if (!PageHighMem(pfn_to_page(pfn))) {
+			ret = -EINVAL;
+			goto cleanup;
+		}
+#endif /* CONFIG_ARM */
+
+		ret = swiotlb_init_tlb_pool(swiotlb, rmem->base, rmem->size);
+		if (ret)
+			goto cleanup;
+
+		rmem->priv = swiotlb;
+	}
+
+#ifdef CONFIG_DEBUG_FS
+	swiotlb_create_debugfs(swiotlb, rmem->name, default_swiotlb.debugfs);
+#endif /* CONFIG_DEBUG_FS */
+
+	dev->dev_swiotlb = swiotlb;
+
+	return 0;
+
+cleanup:
+	kfree(swiotlb);
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
+	debugfs_remove_recursive(dev->dev_swiotlb->debugfs);
+#endif /* CONFIG_DEBUG_FS */
+	dev->dev_swiotlb = NULL;
+}
+
+static const struct reserved_mem_ops rmem_swiotlb_ops = {
+	.device_init = rmem_swiotlb_device_init,
+	.device_release = rmem_swiotlb_device_release,
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
+#endif /* CONFIG_DMA_RESTRICTED_POOL */
-- 
2.30.0.478.g8a0d178c01-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
