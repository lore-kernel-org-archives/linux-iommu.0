Return-Path: <SRS0=eGnl=LK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00DDDC48BE8
	for <iommu@archiver.kernel.org>; Wed, 16 Jun 2021 11:43:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A04EA61185
	for <iommu@archiver.kernel.org>; Wed, 16 Jun 2021 11:43:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A04EA61185
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 70F6440494;
	Wed, 16 Jun 2021 11:43:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id duATTEG8SmGB; Wed, 16 Jun 2021 11:43:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1533540388;
	Wed, 16 Jun 2021 11:43:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E50E3C000D;
	Wed, 16 Jun 2021 11:43:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3C46BC000B
 for <iommu@lists.linux-foundation.org>; Wed, 16 Jun 2021 11:43:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1E8198356E
 for <iommu@lists.linux-foundation.org>; Wed, 16 Jun 2021 11:43:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id W7BfXFg3svu2 for <iommu@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 11:43:16 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5162483508
 for <iommu@lists.linux-foundation.org>; Wed, 16 Jun 2021 11:43:16 +0000 (UTC)
Received: by mail-lj1-x233.google.com with SMTP id n17so3413541ljg.2
 for <iommu@lists.linux-foundation.org>; Wed, 16 Jun 2021 04:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7nQgkz7v7kjXkgg5q9M0yPzBFdiLLV6nxJ8RkjNgpeA=;
 b=aDPrdhEfh1kFSt/STcDHzzby2mSMyRVLn2/IHyVKerpOr7l762ZRsl4B8m+uIlcDi3
 YarS0JqZSnkfgGWTjhBS33bwVvWwsN9nS6HTbF06IdrjyF0I+4ErUV0d4n3oQwSBWmRP
 dj+YSl8fn58koBvmMomHtj+y335nmWnHTHraIFK6AntfuXyCET5STmdVe2XbvZl7nFhp
 BO6DQqYEqPgl4aaK7NM2AXkY++fkunJiXeaavy0hWBed6lC73frJYMnYO1aVCTLtlrF1
 +S4ovABSl4rLVsvoQQEbRdYYJjfqE1/WP2IX9ovrmrc8rEP1iDam+gsllSJ/H1DQHFmm
 O1ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7nQgkz7v7kjXkgg5q9M0yPzBFdiLLV6nxJ8RkjNgpeA=;
 b=OmjGGcEusGQovhbKTfeJY2VGxJq/rVjHw9qSCPiHo6fp02C0r5NQnMHY6v2fxudcBx
 +huyce99+BRTn33FVXWOc0qvya2lt34nyXUt2cNfkqttBA6Dgqgg/xiCz+bJdsHrh4mz
 kNJj5tc7kuNfkK5xS3xsaAJGn4aWvPm9GWE1+R4PwuNyrRzrZoU2jNdd1rTyf4ankrA8
 oxKYDxvQYf7r4JZl8yP4nB8Or3EswoAWYJdzoZsCuu8Mfc1ZXldDF4flolwahagwZKrR
 QbqJLfCj5hknlvQxt9+QPuvs7Kk0+2iZh0xyWRQRnHUS7gnbt6z/13mGoR42pbso/j6h
 UteA==
X-Gm-Message-State: AOAM530BhuFS07PVj+nnoiPdnqXhcnRMeVOzoF6HVThttWNGTWm+9XOW
 JW6gCbKTZIa1Tld9ajFh/Dc=
X-Google-Smtp-Source: ABdhPJy8y+YAcCkoYKQg66iG8xEkfr5244XcQiy8PJossc/WgLE8Gd946VbZxMMUHzTiblQoWh+b7A==
X-Received: by 2002:a2e:b0eb:: with SMTP id h11mr2037701ljl.350.1623843794328; 
 Wed, 16 Jun 2021 04:43:14 -0700 (PDT)
Received: from localhost ([178.151.124.169])
 by smtp.gmail.com with ESMTPSA id m18sm239190ljg.105.2021.06.16.04.43.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Jun 2021 04:43:14 -0700 (PDT)
From: Roman Skakun <rm.skakun@gmail.com>
X-Google-Original-From: Roman Skakun <roman_skakun@epam.com>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Juergen Gross <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 xen-devel@lists.xenproject.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] swiotlb-xen: override common mmap and get_sgtable dma ops
Date: Wed, 16 Jun 2021 14:42:05 +0300
Message-Id: <20210616114205.38902-2-roman_skakun@epam.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210616114205.38902-1-roman_skakun@epam.com>
References: <855a58e2-1e03-4763-cb56-81367b73762c@oracle.com>
 <20210616114205.38902-1-roman_skakun@epam.com>
MIME-Version: 1.0
Cc: Andrii Anisov <andrii_anisov@epam.com>,
 Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Roman Skakun <roman_skakun@epam.com>, Roman Skakun <rm.skakun@gmail.com>,
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

This commit is dedicated to fix incorrect conversion from
cpu_addr to page address in cases when we get virtual
address which allocated through xen_swiotlb_alloc_coherent()
and can be mapped in the vmalloc range.
As the result, virt_to_page() cannot convert this address
properly and return incorrect page address.

Need to detect such cases and obtains the page address using
vmalloc_to_page() instead.

The reference code for mmap() and get_sgtable() was copied
from kernel/dma/ops_helpers.c and modified to provide
additional detections as described above.

In order to simplify code there was added a new
dma_cpu_addr_to_page() helper.

Signed-off-by: Roman Skakun <roman_skakun@epam.com>
Reviewed-by: Andrii Anisov <andrii_anisov@epam.com>
---
 drivers/xen/swiotlb-xen.c | 42 +++++++++++++++++++++++++++++++--------
 1 file changed, 34 insertions(+), 8 deletions(-)

diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index 90bc5fc321bc..9331a8500547 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -118,6 +118,14 @@ static int is_xen_swiotlb_buffer(struct device *dev, dma_addr_t dma_addr)
 	return 0;
 }
 
+static struct page *cpu_addr_to_page(void *cpu_addr)
+{
+	if (is_vmalloc_addr(cpu_addr))
+		return vmalloc_to_page(cpu_addr);
+	else
+		return virt_to_page(cpu_addr);
+}
+
 static int
 xen_swiotlb_fixup(void *buf, size_t size, unsigned long nslabs)
 {
@@ -337,7 +345,7 @@ xen_swiotlb_free_coherent(struct device *hwdev, size_t size, void *vaddr,
 	int order = get_order(size);
 	phys_addr_t phys;
 	u64 dma_mask = DMA_BIT_MASK(32);
-	struct page *page;
+	struct page *page = cpu_addr_to_page(vaddr);
 
 	if (hwdev && hwdev->coherent_dma_mask)
 		dma_mask = hwdev->coherent_dma_mask;
@@ -349,11 +357,6 @@ xen_swiotlb_free_coherent(struct device *hwdev, size_t size, void *vaddr,
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
@@ -573,7 +576,23 @@ xen_swiotlb_dma_mmap(struct device *dev, struct vm_area_struct *vma,
 		     void *cpu_addr, dma_addr_t dma_addr, size_t size,
 		     unsigned long attrs)
 {
-	return dma_common_mmap(dev, vma, cpu_addr, dma_addr, size, attrs);
+	unsigned long user_count = vma_pages(vma);
+	unsigned long count = PAGE_ALIGN(size) >> PAGE_SHIFT;
+	unsigned long off = vma->vm_pgoff;
+	struct page *page = cpu_addr_to_page(cpu_addr);
+	int ret;
+
+	vma->vm_page_prot = dma_pgprot(dev, vma->vm_page_prot, attrs);
+
+	if (dma_mmap_from_dev_coherent(dev, vma, cpu_addr, size, &ret))
+		return ret;
+
+	if (off >= count || user_count > count - off)
+		return -ENXIO;
+
+	return remap_pfn_range(vma, vma->vm_start,
+			page_to_pfn(page) + vma->vm_pgoff,
+			user_count << PAGE_SHIFT, vma->vm_page_prot);
 }
 
 /*
@@ -585,7 +604,14 @@ xen_swiotlb_get_sgtable(struct device *dev, struct sg_table *sgt,
 			void *cpu_addr, dma_addr_t handle, size_t size,
 			unsigned long attrs)
 {
-	return dma_common_get_sgtable(dev, sgt, cpu_addr, handle, size, attrs);
+	struct page *page = cpu_addr_to_page(cpu_addr);
+	int ret;
+
+	ret = sg_alloc_table(sgt, 1, GFP_KERNEL);
+	if (!ret)
+		sg_set_page(sgt->sgl, page, PAGE_ALIGN(size), 0);
+
+	return ret;
 }
 
 const struct dma_map_ops xen_swiotlb_dma_ops = {
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
