Return-Path: <SRS0=mWlM=CR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A5BAC43461
	for <iommu@archiver.kernel.org>; Tue,  8 Sep 2020 16:48:20 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C30E20759
	for <iommu@archiver.kernel.org>; Tue,  8 Sep 2020 16:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qtB2arh/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C30E20759
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9B88187397;
	Tue,  8 Sep 2020 16:48:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id u0NPXc4pq2Ip; Tue,  8 Sep 2020 16:48:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id ED7F28737F;
	Tue,  8 Sep 2020 16:48:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E806AC088B;
	Tue,  8 Sep 2020 16:48:18 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9696CC0052
 for <iommu@lists.linux-foundation.org>; Tue,  8 Sep 2020 16:48:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 8EC3286C52
 for <iommu@lists.linux-foundation.org>; Tue,  8 Sep 2020 16:48:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jLnkVhllT-E3 for <iommu@lists.linux-foundation.org>;
 Tue,  8 Sep 2020 16:48:17 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id E2B5386C6C
 for <iommu@lists.linux-foundation.org>; Tue,  8 Sep 2020 16:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=IQrZo4aJNvIdGgzUh8cZgzH0FUyElPFQii/JEvXGgtk=; b=qtB2arh/HjoxfST21M5t0r8PEZ
 zS+je+XGSNwe7BlpD2U3bSjxFADL+LPHiufNuapJUkQHyDF29RqylSCg/g2qTIxPW57m4VDtJNbLl
 5tH6Jg19Byds6WyYSOFSnI2ASAtASepawkX88SxkM0r3kzYUXQGd0iBds3cZWgxqsePyGHfYdaLNF
 zI1FmO6f/YhubYBzOSiM/VvGKJXcclr4H1ZjNzjjb/WcENm5VcYivfOOEa+Z7F4rxt19Khq+DwI1z
 beqDLdt5iShfyysR22GEFJrvkAPoDmXUYhzsBvG2Mbnd2wZsuMIxbu2nh7rssQWpx5A4TGf7WQJ6Z
 QuYMq6tw==;
Received: from [2001:4bb8:184:af1:3dc3:9c83:fc6c:e0f] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kFgmn-0001RB-FQ; Tue, 08 Sep 2020 16:48:01 +0000
From: Christoph Hellwig <hch@lst.de>
To: Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 iommu@lists.linux-foundation.org
Subject: [PATCH 02/12] MIPS/jazzdma: remove the unused vdma_remap function
Date: Tue,  8 Sep 2020 18:47:48 +0200
Message-Id: <20200908164758.3177341-3-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908164758.3177341-1-hch@lst.de>
References: <20200908164758.3177341-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: linux-ia64@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
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

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---
 arch/mips/include/asm/jazzdma.h |  2 -
 arch/mips/jazz/jazzdma.c        | 70 ---------------------------------
 2 files changed, 72 deletions(-)

diff --git a/arch/mips/include/asm/jazzdma.h b/arch/mips/include/asm/jazzdma.h
index d13f940022d5f9..c831da7fa89803 100644
--- a/arch/mips/include/asm/jazzdma.h
+++ b/arch/mips/include/asm/jazzdma.h
@@ -10,8 +10,6 @@
  */
 extern unsigned long vdma_alloc(unsigned long paddr, unsigned long size);
 extern int vdma_free(unsigned long laddr);
-extern int vdma_remap(unsigned long laddr, unsigned long paddr,
-		      unsigned long size);
 extern unsigned long vdma_phys2log(unsigned long paddr);
 extern unsigned long vdma_log2phys(unsigned long laddr);
 extern void vdma_stats(void);		/* for debugging only */
diff --git a/arch/mips/jazz/jazzdma.c b/arch/mips/jazz/jazzdma.c
index 014773f0bfcd74..fe40dbed04c1d6 100644
--- a/arch/mips/jazz/jazzdma.c
+++ b/arch/mips/jazz/jazzdma.c
@@ -209,76 +209,6 @@ int vdma_free(unsigned long laddr)
 
 EXPORT_SYMBOL(vdma_free);
 
-/*
- * Map certain page(s) to another physical address.
- * Caller must have allocated the page(s) before.
- */
-int vdma_remap(unsigned long laddr, unsigned long paddr, unsigned long size)
-{
-	int first, pages;
-
-	if (laddr > 0xffffff) {
-		if (vdma_debug)
-			printk
-			    ("vdma_map: Invalid logical address: %08lx\n",
-			     laddr);
-		return -EINVAL; /* invalid logical address */
-	}
-	if (paddr > 0x1fffffff) {
-		if (vdma_debug)
-			printk
-			    ("vdma_map: Invalid physical address: %08lx\n",
-			     paddr);
-		return -EINVAL; /* invalid physical address */
-	}
-
-	pages = (((paddr & (VDMA_PAGESIZE - 1)) + size) >> 12) + 1;
-	first = laddr >> 12;
-	if (vdma_debug)
-		printk("vdma_remap: first=%x, pages=%x\n", first, pages);
-	if (first + pages > VDMA_PGTBL_ENTRIES) {
-		if (vdma_debug)
-			printk("vdma_alloc: Invalid size: %08lx\n", size);
-		return -EINVAL;
-	}
-
-	paddr &= ~(VDMA_PAGESIZE - 1);
-	while (pages > 0 && first < VDMA_PGTBL_ENTRIES) {
-		if (pgtbl[first].owner != laddr) {
-			if (vdma_debug)
-				printk("Trying to remap other's pages.\n");
-			return -EPERM;	/* not owner */
-		}
-		pgtbl[first].frame = paddr;
-		paddr += VDMA_PAGESIZE;
-		first++;
-		pages--;
-	}
-
-	/*
-	 * Update translation table
-	 */
-	r4030_write_reg32(JAZZ_R4030_TRSTBL_INV, 0);
-
-	if (vdma_debug > 2) {
-		int i;
-		pages = (((paddr & (VDMA_PAGESIZE - 1)) + size) >> 12) + 1;
-		first = laddr >> 12;
-		printk("LADDR: ");
-		for (i = first; i < first + pages; i++)
-			printk("%08x ", i << 12);
-		printk("\nPADDR: ");
-		for (i = first; i < first + pages; i++)
-			printk("%08x ", pgtbl[i].frame);
-		printk("\nOWNER: ");
-		for (i = first; i < first + pages; i++)
-			printk("%08x ", pgtbl[i].owner);
-		printk("\n");
-	}
-
-	return 0;
-}
-
 /*
  * Translate a physical address to a logical address.
  * This will return the logical address of the first
-- 
2.28.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
