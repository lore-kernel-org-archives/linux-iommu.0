Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6A93C433F5
	for <iommu@archiver.kernel.org>; Thu, 31 Mar 2022 06:06:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5518E83E93;
	Thu, 31 Mar 2022 06:06:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VaR1hPp4hbAz; Thu, 31 Mar 2022 06:06:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2065783E9B;
	Thu, 31 Mar 2022 06:06:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E7339C001D;
	Thu, 31 Mar 2022 06:06:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 64C4DC0012
 for <iommu@lists.linux-foundation.org>; Thu, 31 Mar 2022 06:06:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4CB2C60C0C
 for <iommu@lists.linux-foundation.org>; Thu, 31 Mar 2022 06:06:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2d6oHTdkdWmr for <iommu@lists.linux-foundation.org>;
 Thu, 31 Mar 2022 06:06:32 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E41F360B72
 for <iommu@lists.linux-foundation.org>; Thu, 31 Mar 2022 06:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=/axUWkKlZzh6o/ea+huJNRWUtJNaL6z48+bZU4ad7vo=; b=VpQmULlFaNWsWo5o1K/rseJsLT
 UkRfIWiUc5kypQ39MZv/xiPlAJG2dE1EgdcFs3UeJ0+LLPyyuz4bJEpGPwSWoAnzedCIQ014S7AbN
 zebj9fMBL9rXKhDNcA2lTYHT0BoOvMynMvkEphZzXJ4bZN3udd13OezG9/AWoQ0amDUEjkhjn6lrs
 IUwGh2EsNw1ngmvOi1FGh5fDjK5Bnovid0bQECZ4UKapYP2qnpErK6azL603AgnnfgXeSNbov/Dnl
 nfb4cbzGS6QHnG5rjSx5OQfml/eUZESk+jCyg8Qh9RqWAI77cNoiWY8L4z8lFtZZjKd+iIF9txfIs
 5P3gym9w==;
Received: from [89.144.223.87] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nZnx1-000onS-Ep; Thu, 31 Mar 2022 06:06:31 +0000
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org
Subject: [PATCH] dma-mapping: move pgprot_decrypted out of dma_pgprot
Date: Thu, 31 Mar 2022 08:06:27 +0200
Message-Id: <20220331060627.2872150-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: thomas.lendacky@amd.com, robin.murphy@arm.com, Alex Xu <alex_y_xu@yahoo.ca>
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

pgprot_decrypted is used by AMD SME systems to allow access to memory
that was set to not encrypted using set_memory_decrypted.  That only
happens for dma-direct memory as the IOMMU solves the addressing
challenges for the encryption bit using its own remapping.

Move the pgprot_decrypted call out of dma_pgprot which is also used
by the IOMMU mappings and into dma-direct so that it is only used with
memory that was set decrypted.

Fixes: 5ff79fddf0ef ("dma-mapping: remove CONFIG_DMA_REMAP")
Reported-by: Alex Xu (Hello71) <alex_y_xu@yahoo.ca>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/dma/direct.c  | 10 ++++++++--
 kernel/dma/mapping.c |  2 --
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 35a1d29d6a2e9..9743c6ccce1a9 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -277,12 +277,16 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 	}
 
 	if (remap) {
+		pgprot_t prot = dma_pgprot(dev, PAGE_KERNEL, attrs);
+
+		if (force_dma_unencrypted(dev))
+			prot = pgprot_decrypted(prot);
+
 		/* remove any dirty cache lines on the kernel alias */
 		arch_dma_prep_coherent(page, size);
 
 		/* create a coherent mapping */
-		ret = dma_common_contiguous_remap(page, size,
-				dma_pgprot(dev, PAGE_KERNEL, attrs),
+		ret = dma_common_contiguous_remap(page, size, prot,
 				__builtin_return_address(0));
 		if (!ret)
 			goto out_free_pages;
@@ -535,6 +539,8 @@ int dma_direct_mmap(struct device *dev, struct vm_area_struct *vma,
 	int ret = -ENXIO;
 
 	vma->vm_page_prot = dma_pgprot(dev, vma->vm_page_prot, attrs);
+	if (force_dma_unencrypted(dev))
+		vma->vm_page_prot = pgprot_decrypted(vma->vm_page_prot);
 
 	if (dma_mmap_from_dev_coherent(dev, vma, cpu_addr, size, &ret))
 		return ret;
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 559461a826bab..db7244291b745 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -407,8 +407,6 @@ EXPORT_SYMBOL(dma_get_sgtable_attrs);
  */
 pgprot_t dma_pgprot(struct device *dev, pgprot_t prot, unsigned long attrs)
 {
-	if (force_dma_unencrypted(dev))
-		prot = pgprot_decrypted(prot);
 	if (dev_is_dma_coherent(dev))
 		return prot;
 #ifdef CONFIG_ARCH_HAS_DMA_WRITE_COMBINE
-- 
2.30.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
