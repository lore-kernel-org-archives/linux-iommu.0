Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43892C433FE
	for <iommu@archiver.kernel.org>; Tue, 22 Feb 2022 15:35:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EFEBD410D1;
	Tue, 22 Feb 2022 15:35:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Slqo48WMoH5N; Tue, 22 Feb 2022 15:35:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C72A041298;
	Tue, 22 Feb 2022 15:35:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9C7E6C0021;
	Tue, 22 Feb 2022 15:35:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5C865C0011
 for <iommu@lists.linux-foundation.org>; Tue, 22 Feb 2022 15:35:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 47365405D7
 for <iommu@lists.linux-foundation.org>; Tue, 22 Feb 2022 15:35:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1IeMY-MzfbLA for <iommu@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 15:35:37 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6E770405D6
 for <iommu@lists.linux-foundation.org>; Tue, 22 Feb 2022 15:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=2LuLtS1efSBZ06JRKs3rwu/XDIHFFEkeBlwKrISdqYE=; b=Vf12//P1cJJG7r7sSMYd3RKUpR
 1iyqvtcz1vvg2fulY2+WGMc8nNqZ0MlrzDhxAp14OnNMko2kMFYfcU0rlmFA2OCUpO2mFz7P7lvKg
 ALp0Z8CYzL61sODI1ktyZxnyHDkcqBaBsxGE7/O/0yEeje/VzIYseB2EMSkX0NSBzVGeetdBnWPlq
 h4ARmCowLPrC/KwkX0h+EeItmZFyxYuayW3LABiVBWVYx9p142xpp5CdMhN6o16cO+9maNRgWoIhF
 /De8ZYV8h4SrIxdVqDfFAtgqSO7aIGNMgslI44A+n4/vknBhdvQqpOCR4L4Wpy966WPbClzjKYvUC
 fRljMIDw==;
Received: from [2001:4bb8:198:f8fc:c22a:ebfc:be8d:63c2] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nMXCP-00AGwT-S1; Tue, 22 Feb 2022 15:35:34 +0000
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org
Subject: [PATCH 06/11] MIPS/octeon: use swiotlb_init instead of open coding it
Date: Tue, 22 Feb 2022 16:35:09 +0100
Message-Id: <20220222153514.593231-7-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220222153514.593231-1-hch@lst.de>
References: <20220222153514.593231-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: Juergen Gross <jgross@suse.com>, linux-s390@vger.kernel.org,
 linux-hyperv@vger.kernel.org, Stefano Stabellini <sstabellini@kernel.org>,
 linux-ia64@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
 x86@kernel.org, linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 tboot-devel@lists.sourceforge.net, linux-pci@vger.kernel.org,
 xen-devel@lists.xenproject.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 David Woodhouse <dwmw2@infradead.org>, linux-riscv@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
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

Use the generic swiotlb initialization helper instead of open coding it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/mips/cavium-octeon/dma-octeon.c | 15 ++-------------
 arch/mips/pci/pci-octeon.c           |  2 +-
 2 files changed, 3 insertions(+), 14 deletions(-)

diff --git a/arch/mips/cavium-octeon/dma-octeon.c b/arch/mips/cavium-octeon/dma-octeon.c
index df70308db0e69..fb7547e217263 100644
--- a/arch/mips/cavium-octeon/dma-octeon.c
+++ b/arch/mips/cavium-octeon/dma-octeon.c
@@ -186,15 +186,12 @@ phys_addr_t dma_to_phys(struct device *dev, dma_addr_t daddr)
 	return daddr;
 }
 
-char *octeon_swiotlb;
-
 void __init plat_swiotlb_setup(void)
 {
 	phys_addr_t start, end;
 	phys_addr_t max_addr;
 	phys_addr_t addr_size;
 	size_t swiotlbsize;
-	unsigned long swiotlb_nslabs;
 	u64 i;
 
 	max_addr = 0;
@@ -236,15 +233,7 @@ void __init plat_swiotlb_setup(void)
 	if (OCTEON_IS_OCTEON2() && max_addr >= 0x100000000ul)
 		swiotlbsize = 64 * (1<<20);
 #endif
-	swiotlb_nslabs = swiotlbsize >> IO_TLB_SHIFT;
-	swiotlb_nslabs = ALIGN(swiotlb_nslabs, IO_TLB_SEGSIZE);
-	swiotlbsize = swiotlb_nslabs << IO_TLB_SHIFT;
-
-	octeon_swiotlb = memblock_alloc_low(swiotlbsize, PAGE_SIZE);
-	if (!octeon_swiotlb)
-		panic("%s: Failed to allocate %zu bytes align=%lx\n",
-		      __func__, swiotlbsize, PAGE_SIZE);
 
-	if (swiotlb_init_with_tbl(octeon_swiotlb, swiotlb_nslabs, 1) == -ENOMEM)
-		panic("Cannot allocate SWIOTLB buffer");
+	swiotlb_adjust_size(swiotlbsize);
+	swiotlb_init(1);
 }
diff --git a/arch/mips/pci/pci-octeon.c b/arch/mips/pci/pci-octeon.c
index fc29b85cfa926..e457a18cbdc59 100644
--- a/arch/mips/pci/pci-octeon.c
+++ b/arch/mips/pci/pci-octeon.c
@@ -664,7 +664,7 @@ static int __init octeon_pci_setup(void)
 
 		/* BAR1 movable regions contiguous to cover the swiotlb */
 		octeon_bar1_pci_phys =
-			virt_to_phys(octeon_swiotlb) & ~((1ull << 22) - 1);
+			io_tlb_default_mem.start & ~((1ull << 22) - 1);
 
 		for (index = 0; index < 32; index++) {
 			union cvmx_pci_bar1_indexx bar1_index;
-- 
2.30.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
