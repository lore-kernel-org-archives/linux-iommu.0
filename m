Return-Path: <SRS0=XGcg=MI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C29C12002
	for <iommu@archiver.kernel.org>; Fri, 16 Jul 2021 08:39:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED77C613ED
	for <iommu@archiver.kernel.org>; Fri, 16 Jul 2021 08:39:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED77C613ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B077C40EE5;
	Fri, 16 Jul 2021 08:39:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IPsY8b7xj486; Fri, 16 Jul 2021 08:39:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6E3174012F;
	Fri, 16 Jul 2021 08:39:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 399C5C0010;
	Fri, 16 Jul 2021 08:39:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2CEF8C000E
 for <iommu@lists.linux-foundation.org>; Fri, 16 Jul 2021 08:39:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 06BB642372
 for <iommu@lists.linux-foundation.org>; Fri, 16 Jul 2021 08:39:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4CwArHiAN0XW for <iommu@lists.linux-foundation.org>;
 Fri, 16 Jul 2021 08:39:51 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 082DA4227A
 for <iommu@lists.linux-foundation.org>; Fri, 16 Jul 2021 08:39:50 +0000 (UTC)
Received: by mail-ej1-x62e.google.com with SMTP id qb4so13945589ejc.11
 for <iommu@lists.linux-foundation.org>; Fri, 16 Jul 2021 01:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1Aw+MvYuySKaeeZ9hfm0Wk5AJLKyuRLmX4WBjc8rKNo=;
 b=oUyFrqUYKdou9ruiR6KE+JMXnnLCL8dvqhN70gcyzeACf6NUw7EI0ATRz7wTttz15f
 7mOLygE4HmSHan8OZfyp5j8RPsbBrT3a0He5k0WrJB0y+5+L+NOkn9K5yvzS/pYZCO7p
 u7KZO9StVPaxTPF8Gr1jsGLQfWYOI2yH+fArBC1KqFZmKDSGTfAFVbEAaJhaz4AytnK+
 dyb74/h+h4RPLfu4yWREg9BWVCsYAyrrBgnZTYI0oQjZZZAiUpIi/RfegTpwdAhY2A7S
 DsU9Z4zG4GoeFsMnKMjo7DZYbgBHzHPJ/9lwWvF6RbJwmOcAv7hCambLdViiqWQdNc4U
 0rYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1Aw+MvYuySKaeeZ9hfm0Wk5AJLKyuRLmX4WBjc8rKNo=;
 b=HZQVA7605nXlerC9MTrl9V3YRAlNF9ZV92lgd5v/9+PoKEKaHFwMU1khxSX5hxl6g9
 su1AidhJ0RCP06Wn+rRGb688J2wbAsYEJqkWMwlkmbLlFhinO1shOdDlKoiYLkrh07p3
 jMOOo8czBwCxzVqJuN/p8xAkC4/yw3ds316IctY/QEe638sXcGR8hJACyE6VYyQaCvll
 /RTn6zBFwBRInaqc/GGBFVU/eL5S5QeiEjaTf4z/6k05Z2tilI/zV2/qyk4+bRQKaFO8
 91tdfW1hgXBPcSbYKoneEqgHnM8h+CrBJlF0mthkHvEB9gksgZFrNShOqcD6Q9wb5Vk2
 wptw==
X-Gm-Message-State: AOAM531SKVQz9C/loozt0x9vUMLe+31N4bMwnL1ltMcm9pXjcBYwjGUc
 5ZarPt/6hQFEp55KnbpVXqM=
X-Google-Smtp-Source: ABdhPJwfFSjxOhCm0YSnLeoEw5a02XTjG3qrNAIfyswu4/Xx0Hrjsx5GukzWb4EvgN4GswtGTuomdw==
X-Received: by 2002:a17:906:c9cb:: with SMTP id
 hk11mr10449398ejb.544.1626424789035; 
 Fri, 16 Jul 2021 01:39:49 -0700 (PDT)
Received: from localhost ([185.117.121.76])
 by smtp.gmail.com with ESMTPSA id p18sm3390639edu.8.2021.07.16.01.39.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Jul 2021 01:39:48 -0700 (PDT)
From: Roman Skakun <rm.skakun@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2] dma-mapping: use vmalloc_to_page for vmalloc addresses
Date: Fri, 16 Jul 2021 11:39:34 +0300
Message-Id: <20210716083934.154992-1-rm.skakun@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210715170011.GA17324@lst.de>
References: <20210715170011.GA17324@lst.de>
MIME-Version: 1.0
Cc: Juergen Gross <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Andrii Anisov <andrii_anisov@epam.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
 linux-kernel@vger.kernel.org, Roman Skakun <rm.skakun@gmail.com>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 iommu@lists.linux-foundation.org, Roman Skakun <roman_skakun@epam.com>,
 xen-devel@lists.xenproject.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Volodymyr Babchuk <volodymyr_babchuk@epam.com>
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

From: Roman Skakun <Roman_Skakun@epam.com>

This commit is dedicated to fix incorrect conversion from
cpu_addr to page address in cases when we get virtual
address which allocated in the vmalloc range.
As the result, virt_to_page() cannot convert this address
properly and return incorrect page address.

Need to detect such cases and obtains the page address using
vmalloc_to_page() instead.

Signed-off-by: Roman Skakun <roman_skakun@epam.com>
Reviewed-by: Andrii Anisov <andrii_anisov@epam.com>
---
Hi, Christoph!
It's updated patch in accordance with your and Stefano 
suggestions. 

 drivers/xen/swiotlb-xen.c   |  7 +------
 include/linux/dma-map-ops.h |  2 ++
 kernel/dma/ops_helpers.c    | 16 ++++++++++++++--
 3 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index 92ee6eea30cd..c2f612a10a95 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -337,7 +337,7 @@ xen_swiotlb_free_coherent(struct device *hwdev, size_t size, void *vaddr,
 	int order = get_order(size);
 	phys_addr_t phys;
 	u64 dma_mask = DMA_BIT_MASK(32);
-	struct page *page;
+	struct page *page = cpu_addr_to_page(vaddr);
 
 	if (hwdev && hwdev->coherent_dma_mask)
 		dma_mask = hwdev->coherent_dma_mask;
@@ -349,11 +349,6 @@ xen_swiotlb_free_coherent(struct device *hwdev, size_t size, void *vaddr,
 	/* Convert the size to actually allocated. */
 	size = 1UL << (order + XEN_PAGE_SHIFT);
 
-	if (is_vmalloc_addr(vaddr))
-		page = vmalloc_to_page(vaddr);
-	else
-		page = virt_to_page(vaddr);
-
 	if (!WARN_ON((dev_addr + size - 1 > dma_mask) ||
 		     range_straddles_page_boundary(phys, size)) &&
 	    TestClearPageXenRemapped(page))
diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index a5f89fc4d6df..ce0edb0bb603 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -226,6 +226,8 @@ struct page *dma_alloc_from_pool(struct device *dev, size_t size,
 		bool (*phys_addr_ok)(struct device *, phys_addr_t, size_t));
 bool dma_free_from_pool(struct device *dev, void *start, size_t size);
 
+struct page *cpu_addr_to_page(void *cpu_addr);
+
 #ifdef CONFIG_ARCH_HAS_DMA_COHERENCE_H
 #include <asm/dma-coherence.h>
 #elif defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
diff --git a/kernel/dma/ops_helpers.c b/kernel/dma/ops_helpers.c
index 910ae69cae77..472e861750d3 100644
--- a/kernel/dma/ops_helpers.c
+++ b/kernel/dma/ops_helpers.c
@@ -5,6 +5,17 @@
  */
 #include <linux/dma-map-ops.h>
 
+/*
+ * This helper converts virtual address to page address.
+ */
+struct page *cpu_addr_to_page(void *cpu_addr)
+{
+	if (is_vmalloc_addr(cpu_addr))
+		return vmalloc_to_page(cpu_addr);
+	else
+		return virt_to_page(cpu_addr);
+}
+
 /*
  * Create scatter-list for the already allocated DMA buffer.
  */
@@ -12,7 +23,7 @@ int dma_common_get_sgtable(struct device *dev, struct sg_table *sgt,
 		 void *cpu_addr, dma_addr_t dma_addr, size_t size,
 		 unsigned long attrs)
 {
-	struct page *page = virt_to_page(cpu_addr);
+	struct page *page = cpu_addr_to_page(cpu_addr);
 	int ret;
 
 	ret = sg_alloc_table(sgt, 1, GFP_KERNEL);
@@ -32,6 +43,7 @@ int dma_common_mmap(struct device *dev, struct vm_area_struct *vma,
 	unsigned long user_count = vma_pages(vma);
 	unsigned long count = PAGE_ALIGN(size) >> PAGE_SHIFT;
 	unsigned long off = vma->vm_pgoff;
+	struct page *page = cpu_addr_to_page(cpu_addr);
 	int ret = -ENXIO;
 
 	vma->vm_page_prot = dma_pgprot(dev, vma->vm_page_prot, attrs);
@@ -43,7 +55,7 @@ int dma_common_mmap(struct device *dev, struct vm_area_struct *vma,
 		return -ENXIO;
 
 	return remap_pfn_range(vma, vma->vm_start,
-			page_to_pfn(virt_to_page(cpu_addr)) + vma->vm_pgoff,
+			page_to_pfn(page) + vma->vm_pgoff,
 			user_count << PAGE_SHIFT, vma->vm_page_prot);
 #else
 	return -ENXIO;
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
