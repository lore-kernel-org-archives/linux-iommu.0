Return-Path: <SRS0=gCe8=2L=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3219BC2D0C0
	for <iommu@archiver.kernel.org>; Sat, 21 Dec 2019 15:11:13 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05B4D2070B
	for <iommu@archiver.kernel.org>; Sat, 21 Dec 2019 15:11:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tcd-ie.20150623.gappssmtp.com header.i=@tcd-ie.20150623.gappssmtp.com header.b="1+ewonpp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05B4D2070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tcd.ie
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5004E86CA5;
	Sat, 21 Dec 2019 15:11:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1s_d86SdT-9W; Sat, 21 Dec 2019 15:11:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4036686CBB;
	Sat, 21 Dec 2019 15:11:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 17097C1D84;
	Sat, 21 Dec 2019 15:11:10 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B6743C077D
 for <iommu@lists.linux-foundation.org>; Sat, 21 Dec 2019 15:11:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id A39B987A50
 for <iommu@lists.linux-foundation.org>; Sat, 21 Dec 2019 15:11:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DPZ6EEmVVm2h for <iommu@lists.linux-foundation.org>;
 Sat, 21 Dec 2019 15:11:07 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com
 [209.85.208.66])
 by whitealder.osuosl.org (Postfix) with ESMTPS id E886D87776
 for <iommu@lists.linux-foundation.org>; Sat, 21 Dec 2019 15:11:06 +0000 (UTC)
Received: by mail-ed1-f66.google.com with SMTP id b8so11400001edx.7
 for <iommu@lists.linux-foundation.org>; Sat, 21 Dec 2019 07:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tcd-ie.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=I0JykHmW6XFDV2Vp/ugaZ7Nn7DA+ujFyMXFyqOzSTdU=;
 b=1+ewonppiB9W8lYl08p7pr7gd0zz68oU69i75ATsgN+8WGxiWusi3bKC7mEUH2iUZT
 r5uuxiRFx6OdSJyL1vDTT0ELk3P59Rbywd2YUr6MPFBAqDg9BLH08FlJLPwUNE6DLLTL
 oBF6KagVp/BAfe3aaPxiclOamAqrOGT34nI75PzRaFRvXI3YHm865eNbfcU/BNc990SF
 1jPGoBvfkIsGC/24dKPIs6QFcky/NgVLoTfYoW5PgQa7frPzYLKYkbDOR2yneEk5x2dH
 NoI0/BPadpvBuQht5nq6M38jRRJC31jTXLFsMRDmEvCnLzHv55aGt7qQ04zM16VkFEtn
 KxDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=I0JykHmW6XFDV2Vp/ugaZ7Nn7DA+ujFyMXFyqOzSTdU=;
 b=XW7fhAKls01GpfvKTaPuSpbhtCXCVPJ+dB/7JBHKA2PZg9Bp6954L0HtnHA0Oraprs
 cFQRiNZ7zPgOnU5RxeIXSQP0BXQvD9js6VHch5TeFP9nlx0MymVzzLUjiz453rlY8J22
 fUOKR3XeeWapWywDlo2N5/5CcSxJOSXIXMZab4/c8mYtcw9WjtDbjyctTqLltKlKP2c0
 oHgPUplMwdUki0bDBwdNkvhTO5U/+konQCkpcKjyLcKTlvHVQKEJzked2mSsz5pGdmEi
 L74qG9rDBC4K7njdbdJZ4V6v32Y82XX/pliId97Vdw8pnSH6roOmEkMY1ES1fHrv2aQx
 ILJQ==
X-Gm-Message-State: APjAAAWTgoFu5dx0REanJsIqg5Sl5idDs5hH0Po9f8Ko4mIAqzyt4K4C
 8ABZkNa/TUnhxQnKsE6bRL0QWsVu+sDrJQ==
X-Google-Smtp-Source: APXvYqycgCWhv0uGKFS1lUiWbcIQuToFD3SFHqFOMFhJaeY3cSmbPrLeHRVjV6Yu+VQxlly42u07SA==
X-Received: by 2002:a05:6402:221c:: with SMTP id
 cq28mr22032517edb.110.1576940693185; 
 Sat, 21 Dec 2019 07:04:53 -0800 (PST)
Received: from localhost.localdomain ([80.233.37.20])
 by smtp.googlemail.com with ESMTPSA id u13sm1517639ejz.69.2019.12.21.07.04.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Dec 2019 07:04:52 -0800 (PST)
From: Tom Murphy <murphyt7@tcd.ie>
To: iommu@lists.linux-foundation.org
Subject: [PATCH 6/8] iommu: allow the dma-iommu api to use bounce buffers
Date: Sat, 21 Dec 2019 15:03:58 +0000
Message-Id: <20191221150402.13868-7-murphyt7@tcd.ie>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191221150402.13868-1-murphyt7@tcd.ie>
References: <20191221150402.13868-1-murphyt7@tcd.ie>
MIME-Version: 1.0
Cc: Heiko Stuebner <heiko@sntech.de>, kvm@vger.kernel.org,
 David Airlie <airlied@linux.ie>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 dri-devel@lists.freedesktop.org, Bjorn Andersson <bjorn.andersson@linaro.org>,
 linux-tegra@vger.kernel.org, Julien Grall <julien.grall@arm.com>,
 Thierry Reding <thierry.reding@gmail.com>, Will Deacon <will@kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 linux-samsung-soc@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>,
 linux-rockchip@lists.infradead.org, Andy Gross <agross@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 linux-mediatek@lists.infradead.org, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 virtualization@lists.linux-foundation.org,
 Gerald Schaefer <gerald.schaefer@de.ibm.com>,
 David Woodhouse <dwmw2@infradead.org>, Cornelia Huck <cohuck@redhat.com>,
 linux-kernel@vger.kernel.org, Tom Murphy <murphyt7@tcd.ie>,
 Kukjin Kim <kgene@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 Robin Murphy <robin.murphy@arm.com>
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

Allow the dma-iommu api to use bounce buffers for untrusted devices.
This is a copy of the intel bounce buffer code.

Signed-off-by: Tom Murphy <murphyt7@tcd.ie>
---
 drivers/iommu/dma-iommu.c | 93 ++++++++++++++++++++++++++++++++-------
 drivers/iommu/iommu.c     | 10 +++++
 include/linux/iommu.h     |  9 +++-
 3 files changed, 95 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 4eac3cd35443..cf778db7d84d 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -20,9 +20,11 @@
 #include <linux/irq.h>
 #include <linux/mm.h>
 #include <linux/pci.h>
+#include <linux/swiotlb.h>
 #include <linux/scatterlist.h>
 #include <linux/vmalloc.h>
 #include <linux/crash_dump.h>
+#include <linux/dma-direct.h>
 
 struct iommu_dma_msi_page {
 	struct list_head	list;
@@ -505,29 +507,89 @@ static void __iommu_dma_unmap(struct device *dev, dma_addr_t dma_addr,
 			iommu_tlb_sync(domain, &iotlb_gather);
 	}
 
+
 	iommu_dma_free_iova(cookie, dma_addr, size, freelist);
 }
 
+static void __iommu_dma_unmap_swiotlb(struct device *dev, dma_addr_t dma_addr,
+		size_t size, enum dma_data_direction dir,
+		unsigned long attrs)
+{
+	struct iommu_domain *domain = iommu_get_dma_domain(dev);
+	struct iommu_dma_cookie *cookie = domain->iova_cookie;
+	struct iova_domain *iovad = &cookie->iovad;
+	size_t iova_off = iova_offset(iovad, dma_addr);
+	size_t aligned_size = iova_align(iovad, size + iova_off);
+	phys_addr_t phys;
+
+	phys = iommu_iova_to_phys(domain, dma_addr);
+	if (WARN_ON(!phys))
+		return;
+
+	__iommu_dma_unmap(dev, dma_addr, size);
+
+#ifdef CONFIG_SWIOTLB
+	if (unlikely(is_swiotlb_buffer(phys)))
+		swiotlb_tbl_unmap_single(dev, phys, size,
+				aligned_size, dir, attrs);
+#endif
+}
+
 static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
-		size_t size, int prot, dma_addr_t dma_mask)
+		size_t org_size, dma_addr_t dma_mask, bool coherent,
+		enum dma_data_direction dir, unsigned long attrs)
 {
+	int prot = dma_info_to_prot(dir, coherent, attrs);
 	struct iommu_domain *domain = iommu_get_dma_domain(dev);
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
 	struct iova_domain *iovad = &cookie->iovad;
 	size_t iova_off = iova_offset(iovad, phys);
+	size_t aligned_size = iova_align(iovad, org_size + iova_off);
 	dma_addr_t iova;
 
 	if (unlikely(iommu_dma_deferred_attach(dev, domain)))
 		return DMA_MAPPING_ERROR;
 
-	size = iova_align(iovad, size + iova_off);
+#ifdef CONFIG_SWIOTLB
+	/*
+	 * If both the physical buffer start address and size are
+	 * page aligned, we don't need to use a bounce page.
+	 */
+	if (iommu_needs_bounce_buffer(dev)
+			&& !iova_offset(iovad, phys | org_size)) {
+		phys = swiotlb_tbl_map_single(dev,
+				__phys_to_dma(dev, io_tlb_start),
+				phys, org_size, aligned_size, dir, attrs);
+
+		if (phys == DMA_MAPPING_ERROR)
+			return DMA_MAPPING_ERROR;
+
+		/* Cleanup the padding area. */
+		void *padding_start = phys_to_virt(phys);
+		size_t padding_size = aligned_size;
+
+		if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
+		    (dir == DMA_TO_DEVICE ||
+		     dir == DMA_BIDIRECTIONAL)) {
+			padding_start += org_size;
+			padding_size -= org_size;
+		}
 
-	iova = iommu_dma_alloc_iova(domain, size, dma_mask, dev);
+		memset(padding_start, 0, padding_size);
+	}
+#endif
+
+	iova = iommu_dma_alloc_iova(domain, aligned_size, dma_mask, dev);
 	if (!iova)
 		return DMA_MAPPING_ERROR;
 
-	if (iommu_map_atomic(domain, iova, phys - iova_off, size, prot)) {
-		iommu_dma_free_iova(cookie, iova, size, NULL);
+	if (iommu_map_atomic(domain, iova, phys - iova_off, aligned_size,
+				prot)) {
+
+		if (unlikely(is_swiotlb_buffer(phys)))
+			swiotlb_tbl_unmap_single(dev, phys, aligned_size,
+					aligned_size, dir, attrs);
+		iommu_dma_free_iova(cookie, iova, aligned_size, NULL);
 		return DMA_MAPPING_ERROR;
 	}
 	return iova + iova_off;
@@ -761,10 +823,10 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 {
 	phys_addr_t phys = page_to_phys(page) + offset;
 	bool coherent = dev_is_dma_coherent(dev);
-	int prot = dma_info_to_prot(dir, coherent, attrs);
 	dma_addr_t dma_handle;
 
-	dma_handle = __iommu_dma_map(dev, phys, size, prot, dma_get_mask(dev));
+	dma_handle = __iommu_dma_map(dev, phys, size, dma_get_mask(dev),
+			coherent, dir, attrs);
 	if (!coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
 	    dma_handle != DMA_MAPPING_ERROR)
 		arch_sync_dma_for_device(phys, size, dir);
@@ -776,7 +838,7 @@ static void iommu_dma_unmap_page(struct device *dev, dma_addr_t dma_handle,
 {
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
 		iommu_dma_sync_single_for_cpu(dev, dma_handle, size, dir);
-	__iommu_dma_unmap(dev, dma_handle, size);
+	__iommu_dma_unmap_swiotlb(dev, dma_handle, size, dir, attrs);
 }
 
 /*
@@ -960,21 +1022,20 @@ static void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
 		sg = tmp;
 	}
 	end = sg_dma_address(sg) + sg_dma_len(sg);
-	__iommu_dma_unmap(dev, start, end - start);
+	__iommu_dma_unmap_swiotlb(dev, start, end - start, dir, attrs);
 }
 
 static dma_addr_t iommu_dma_map_resource(struct device *dev, phys_addr_t phys,
 		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
-	return __iommu_dma_map(dev, phys, size,
-			dma_info_to_prot(dir, false, attrs) | IOMMU_MMIO,
-			dma_get_mask(dev));
+	return __iommu_dma_map(dev, phys, size, dma_get_mask(dev), false, dir,
+			attrs);
 }
 
 static void iommu_dma_unmap_resource(struct device *dev, dma_addr_t handle,
 		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
-	__iommu_dma_unmap(dev, handle, size);
+	__iommu_dma_unmap_swiotlb(dev, handle, size, dir, attrs);
 }
 
 static void __iommu_dma_free(struct device *dev, size_t size, void *cpu_addr)
@@ -1056,7 +1117,6 @@ static void *iommu_dma_alloc(struct device *dev, size_t size,
 		dma_addr_t *handle, gfp_t gfp, unsigned long attrs)
 {
 	bool coherent = dev_is_dma_coherent(dev);
-	int ioprot = dma_info_to_prot(DMA_BIDIRECTIONAL, coherent, attrs);
 	struct page *page = NULL;
 	void *cpu_addr;
 
@@ -1074,8 +1134,9 @@ static void *iommu_dma_alloc(struct device *dev, size_t size,
 	if (!cpu_addr)
 		return NULL;
 
-	*handle = __iommu_dma_map(dev, page_to_phys(page), size, ioprot,
-			dev->coherent_dma_mask);
+	*handle = __iommu_dma_map(dev, page_to_phys(page), size,
+			dev->coherent_dma_mask, coherent, DMA_BIDIRECTIONAL,
+			attrs);
 	if (*handle == DMA_MAPPING_ERROR) {
 		__iommu_dma_free(dev, size, cpu_addr);
 		return NULL;
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index cec728f40d9c..e5653cb20c83 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2236,6 +2236,16 @@ void iommu_get_resv_regions(struct device *dev, struct list_head *list)
 		ops->get_resv_regions(dev, list);
 }
 
+int iommu_needs_bounce_buffer(struct device *dev)
+{
+	const struct iommu_ops *ops = dev->bus->iommu_ops;
+
+	if (ops && ops->needs_bounce_buffer)
+		return ops->needs_bounce_buffer(dev);
+
+	return 0;
+}
+
 void iommu_put_resv_regions(struct device *dev, struct list_head *list)
 {
 	const struct iommu_ops *ops = dev->bus->iommu_ops;
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 61cac25410b5..d377ffa362a7 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -280,6 +280,7 @@ struct iommu_ops {
 			       enum iommu_attr attr, void *data);
 	int (*domain_set_attr)(struct iommu_domain *domain,
 			       enum iommu_attr attr, void *data);
+	int (*needs_bounce_buffer)(struct device *dev);
 
 	/* Request/Free a list of reserved regions for a device */
 	void (*get_resv_regions)(struct device *dev, struct list_head *list);
@@ -460,6 +461,7 @@ extern phys_addr_t iommu_iova_to_phys(struct iommu_domain *domain, dma_addr_t io
 extern void iommu_set_fault_handler(struct iommu_domain *domain,
 			iommu_fault_handler_t handler, void *token);
 
+extern int iommu_needs_bounce_buffer(struct device *dev);
 extern void iommu_get_resv_regions(struct device *dev, struct list_head *list);
 extern void iommu_put_resv_regions(struct device *dev, struct list_head *list);
 extern int iommu_request_dm_for_dev(struct device *dev);
@@ -530,7 +532,7 @@ static inline void iommu_flush_iotlb_all(struct iommu_domain *domain)
 		domain->ops->flush_iotlb_all(domain);
 }
 
-static inline void flush_iotlb_range(struct iommu_domain *domain,
+static inline void iommu_flush_iotlb_range(struct iommu_domain *domain,
 			unsigned long iova, size_t size,
 			struct page *freelist)
 {
@@ -764,6 +766,11 @@ static inline void iommu_set_fault_handler(struct iommu_domain *domain,
 {
 }
 
+static inline int iommu_needs_bounce_buffer(struct device *dev)
+{
+	return 0;
+}
+
 static inline void iommu_get_resv_regions(struct device *dev,
 					struct list_head *list)
 {
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
