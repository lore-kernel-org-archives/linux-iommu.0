Return-Path: <SRS0=8EFN=74=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B50C433DF
	for <iommu@archiver.kernel.org>; Mon, 15 Jun 2020 07:05:51 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E31D1206D7
	for <iommu@archiver.kernel.org>; Mon, 15 Jun 2020 07:05:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fd8CvaSI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E31D1206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id B4B9E888F6;
	Mon, 15 Jun 2020 07:05:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lwefsNakpfDI; Mon, 15 Jun 2020 07:05:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 27496888EC;
	Mon, 15 Jun 2020 07:05:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1FC5DC0888;
	Mon, 15 Jun 2020 07:05:50 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F36F4C016E
 for <iommu@lists.linux-foundation.org>; Mon, 15 Jun 2020 07:05:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id F030C85F59
 for <iommu@lists.linux-foundation.org>; Mon, 15 Jun 2020 07:05:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hOAWwAa0d49S for <iommu@lists.linux-foundation.org>;
 Mon, 15 Jun 2020 07:05:46 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
 [198.137.202.133])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 46B7985F41
 for <iommu@lists.linux-foundation.org>; Mon, 15 Jun 2020 07:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=9PwCkGms9dVgRtFT/XuDtAwMFuvtV/uIApbSPhlCIuk=; b=fd8CvaSI5AwXkd0FolpNXSWp6L
 Lf0WXHQFNDWocADGwPMQQPWFUInl59HAMpHcyGh/Fk32rV7xI6c0KKwVuHuad+Y0TGBOB+vM3TxQ0
 cSi272PsOVuevxt2UF+LcQTxJ9vEFGVjMvYjjeNOyCWtmRRMqd4XC2vd6L1lCb9S2O5aT5VYtjSoX
 PSw6Xd59viTbFsZNziecBOMc//85nfPFMn5hp25wJDdUrHO//VVID+cZntJ3qj6xq2mC82MLkjyFL
 XGBfS/eDiWxnhf8lEw0SRbgTAaILWJ5FjW2WI/OxL3+mib9hvehzVqbMjhJBP5qLKWrl2txhKMKdO
 Zs0NOLeQ==;
Received: from 195-192-102-148.dyn.cablelink.at ([195.192.102.148]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jkjBh-00088n-2d; Mon, 15 Jun 2020 07:05:45 +0000
From: Christoph Hellwig <hch@lst.de>
To: linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux-foundation.org
Subject: [PATCH] dma-direct: enable mmap for !CONFIG_MMU
Date: Mon, 15 Jun 2020 09:05:42 +0200
Message-Id: <20200615070542.43761-1-hch@lst.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: vladimir.murzin@arm.com, dillon min <dillon.minfei@gmail.com>
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

nommu configfs can trivially map the coherent allocations to user space,
as no actual page table setup is required and the kernel and the user
space programs share the same address space.

Fixes: 62fcee9a3bd7 ("dma-mapping: remove CONFIG_ARCH_NO_COHERENT_DMA_MMAP")
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reported-by: dillon min <dillon.minfei@gmail.com>
Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>
Tested-by: dillon min <dillon.minfei@gmail.com>
---
 kernel/dma/Kconfig  |  1 +
 kernel/dma/direct.c | 14 --------------
 2 files changed, 1 insertion(+), 14 deletions(-)

diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index d006668c0027d2..e0dae570a51530 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -71,6 +71,7 @@ config SWIOTLB
 # in the pagetables
 #
 config DMA_NONCOHERENT_MMAP
+	default y if !MMU
 	bool
 
 config DMA_REMAP
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 0a4881e59aa7d6..9ec6a5c3fc578c 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -459,7 +459,6 @@ int dma_direct_get_sgtable(struct device *dev, struct sg_table *sgt,
 	return ret;
 }
 
-#ifdef CONFIG_MMU
 bool dma_direct_can_mmap(struct device *dev)
 {
 	return dev_is_dma_coherent(dev) ||
@@ -485,19 +484,6 @@ int dma_direct_mmap(struct device *dev, struct vm_area_struct *vma,
 	return remap_pfn_range(vma, vma->vm_start, pfn + vma->vm_pgoff,
 			user_count << PAGE_SHIFT, vma->vm_page_prot);
 }
-#else /* CONFIG_MMU */
-bool dma_direct_can_mmap(struct device *dev)
-{
-	return false;
-}
-
-int dma_direct_mmap(struct device *dev, struct vm_area_struct *vma,
-		void *cpu_addr, dma_addr_t dma_addr, size_t size,
-		unsigned long attrs)
-{
-	return -ENXIO;
-}
-#endif /* CONFIG_MMU */
 
 int dma_direct_supported(struct device *dev, u64 mask)
 {
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
