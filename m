Return-Path: <SRS0=1MD/=LF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A437C48BE0
	for <iommu@archiver.kernel.org>; Fri, 11 Jun 2021 17:35:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F280D613D0
	for <iommu@archiver.kernel.org>; Fri, 11 Jun 2021 17:35:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F280D613D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AD7FC415B8;
	Fri, 11 Jun 2021 17:35:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SC5liAnVI07d; Fri, 11 Jun 2021 17:35:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7A7B9415C6;
	Fri, 11 Jun 2021 17:35:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 510ACC000E;
	Fri, 11 Jun 2021 17:35:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4D2F8C000B
 for <iommu@lists.linux-foundation.org>; Fri, 11 Jun 2021 09:55:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2CD5B414B2
 for <iommu@lists.linux-foundation.org>; Fri, 11 Jun 2021 09:55:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QxX-nC_Xeifa for <iommu@lists.linux-foundation.org>;
 Fri, 11 Jun 2021 09:55:50 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 095FD406AB
 for <iommu@lists.linux-foundation.org>; Fri, 11 Jun 2021 09:55:49 +0000 (UTC)
Received: by mail-lf1-x12e.google.com with SMTP id bp38so7769077lfb.0
 for <iommu@lists.linux-foundation.org>; Fri, 11 Jun 2021 02:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=L6Nq/3eMJ61O2ppaiV+K5WCKa4wxPQ8pA+EactXa5/Q=;
 b=ph/XomxAPqIvxyU2lBvMH35+Kz6l15GgxHvCZPiV1EKnsNbwv18k8r3CfcXnDTadvY
 0HnwK+tCN0fm+FLw08qSlxbWGgLd6GqEV8gP9+/y3mC8mcoEseYaHD7LCYroqq3CWIuc
 rvV1kJGEsSsa+H0Bu3TBsRdiyQHI4toAKrUIEEeDeNkbUJRQmjgiwHPiHMItUrOZc1Jp
 W4prezTF9Lefwdpg90MeiDy/5zo0TrVfeIoYveukEK7APT3Exak8EMxXVAcMlp+QDfko
 P6XaKRDFXiSX8yq0rw+oLRrog118hw6/Wc5k0gg7+VdGPRxrUvhmGPfxUDfyLjcQfPpN
 E6/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=L6Nq/3eMJ61O2ppaiV+K5WCKa4wxPQ8pA+EactXa5/Q=;
 b=BSTK9e7oqs1GbUNxfXxbWwa3BwaYDXKuWhxjfiziNPdtIwFA6p7p+dVh0UDI5m+DSL
 ZsZxHNo7ii3CBDSqtGuTaRst/ROeV2mfBrc2PVF1isMis/iw7kDKGYFXR+eO9GR1Fdx0
 mAjMrxcAT5RPx4ih4mNQzPuAreu3hnpPHA0LuvOJEEF3SPbHF5dmTYK6pkgLldxBDkzQ
 yYMqnMWwR8OiZ3XHGhWMEJPT2cUzakCQ9Mvtg85jYe8NkuCAH895AxzNcjviM+1BOQLf
 vogwyyGCZ0RXC2KX8ka+MzWWVxGFM1Y26uR/X3eI6DMyKPxa2VjC4YtZkR2NsGiyyWhF
 0mmQ==
X-Gm-Message-State: AOAM533J4R9gY5YymhGepCbQSnSH+ugd+P9TN/Znn3K8xNN21XzJ4NWt
 6oSoBGDH0AHe2JRwu65tyrQ=
X-Google-Smtp-Source: ABdhPJy8EDHCE1f4s4ZC6KDj2A/UHmJhDH+REBsIFZnu4F/CM9rWslxdJXdDy1hMj7lLIs/rkF7G0w==
X-Received: by 2002:a19:dc02:: with SMTP id t2mr2158836lfg.261.1623405347760; 
 Fri, 11 Jun 2021 02:55:47 -0700 (PDT)
Received: from localhost ([178.151.124.169])
 by smtp.gmail.com with ESMTPSA id r17sm651828ljp.40.2021.06.11.02.55.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Jun 2021 02:55:47 -0700 (PDT)
From: Roman Skakun <rm.skakun@gmail.com>
X-Google-Original-From: Roman Skakun <roman_skakun@epam.com>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Juergen Gross <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 xen-devel@lists.xenproject.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] swiotlb-xen: override common mmap and get_sgtable dma ops
Date: Fri, 11 Jun 2021 12:55:28 +0300
Message-Id: <20210611095528.9230-1-roman_skakun@epam.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 11 Jun 2021 17:35:11 +0000
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

This commit is dedicated to fix incorrect convertion from
cpu_addr to page address in cases when we get virtual
address which allocated throught xen_swiotlb_alloc_coherent()
and can be mapped in the vmalloc range.
As the result, virt_to_page() cannot convert this address
properly and return incorrect page address.

Need to detect such cases and obtains the page address using
vmalloc_to_page() instead.

The reference code was copied from kernel/dma/ops_helpers.c
and modified to provide additional detections as described
above.

Signed-off-by: Roman Skakun <roman_skakun@epam.com>
Reviewed-by: Andrii Anisov <andrii_anisov@epam.com>

---
Also, I have observed that the original common code didn't 
make additional checks about contiguity of the memory region
represented by cpu_addr and size

May be, this means that these functions can get only physically 
contiguous memory.
Is this correct?

Cheers!

---
 drivers/xen/swiotlb-xen.c | 51 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 49 insertions(+), 2 deletions(-)

diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index 2b385c1b4a99..f99c98472927 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -563,6 +563,53 @@ xen_swiotlb_dma_supported(struct device *hwdev, u64 mask)
 	return xen_virt_to_bus(hwdev, xen_io_tlb_end - 1) <= mask;
 }
 
+static int
+xen_swiotlb_dma_mmap(struct device *dev, struct vm_area_struct *vma,
+		void *cpu_addr, dma_addr_t dma_addr, size_t size,
+		unsigned long attrs)
+{
+	unsigned long user_count = vma_pages(vma);
+	unsigned long count = PAGE_ALIGN(size) >> PAGE_SHIFT;
+	unsigned long off = vma->vm_pgoff;
+	struct page *page;
+
+	if (is_vmalloc_addr(cpu_addr))
+		page = vmalloc_to_page(cpu_addr);
+	else
+		page = virt_to_page(cpu_addr);
+
+	vma->vm_page_prot = dma_pgprot(dev, vma->vm_page_prot, attrs);
+
+	if (dma_mmap_from_dev_coherent(dev, vma, cpu_addr, size, &ret))
+		return -ENXIO;
+
+	if (off >= count || user_count > count - off)
+		return -ENXIO;
+
+	return remap_pfn_range(vma, vma->vm_start,
+			page_to_pfn(page) + vma->vm_pgoff,
+			user_count << PAGE_SHIFT, vma->vm_page_prot);
+}
+
+static int
+xen_swiotlb_dma_get_sgtable(struct device *dev, struct sg_table *sgt,
+		 void *cpu_addr, dma_addr_t dma_addr, size_t size,
+		 unsigned long attrs)
+{
+	struct page *page;
+	int ret;
+
+	if (is_vmalloc_addr(cpu_addr))
+		page = vmalloc_to_page(cpu_addr);
+	else
+		page = virt_to_page(cpu_addr);
+
+	ret = sg_alloc_table(sgt, 1, GFP_KERNEL);
+	if (!ret)
+		sg_set_page(sgt->sgl, page, PAGE_ALIGN(size), 0);
+	return ret;
+}
+
 const struct dma_map_ops xen_swiotlb_dma_ops = {
 	.alloc = xen_swiotlb_alloc_coherent,
 	.free = xen_swiotlb_free_coherent,
@@ -575,8 +622,8 @@ const struct dma_map_ops xen_swiotlb_dma_ops = {
 	.map_page = xen_swiotlb_map_page,
 	.unmap_page = xen_swiotlb_unmap_page,
 	.dma_supported = xen_swiotlb_dma_supported,
-	.mmap = dma_common_mmap,
-	.get_sgtable = dma_common_get_sgtable,
+	.mmap = xen_swiotlb_dma_mmap,
+	.get_sgtable = xen_swiotlb_dma_get_sgtable,
 	.alloc_pages = dma_common_alloc_pages,
 	.free_pages = dma_common_free_pages,
 };
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
