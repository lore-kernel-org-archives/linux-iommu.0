Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74DE6C433FE
	for <iommu@archiver.kernel.org>; Wed, 11 May 2022 12:58:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2E7EB6109C;
	Wed, 11 May 2022 12:58:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 97uadvmCAHFZ; Wed, 11 May 2022 12:58:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 08830610D7;
	Wed, 11 May 2022 12:58:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8C8E8C0082;
	Wed, 11 May 2022 12:58:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B48ECC002D
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 12:58:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A1C15404D5
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 12:58:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WILiWcrbprGa for <iommu@lists.linux-foundation.org>;
 Wed, 11 May 2022 12:58:13 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2A0D64031D
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 12:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=VBAca1xXxndzNfh1X1k86JeV9qFeb8QaWGR+x5euRpI=; b=VBMFfZIBGc4yLHRm2Wa5peBxYo
 L7lkpBKL9qmRp7GdsRzDbo2hOxkLdrUFWSDWJAWKxk7QsvkAo2WDU1HButK/AFoRRG2iI+xRaqzne
 eJpGCLr8lqE1G4UklNZu5W5Via4KqfQygzftAqjThgZhRiLJT9nOUNEt91aPkno5EGtYNQKITCBm9
 0qhtN7kBThU6Wf12wDMqazMp94VKvBm1Bh2nyagV+tLVCyBBcz19ufT9rcxQ1nGaInv4lWj1hvQ9c
 ORWQ8Tf+T/53asn71Frgu3Zufwh+iDGXlg9wwgJIvAusQNxKo6BMaE2N49S38haolif8C8QpTZGf3
 yN2fiQ/g==;
Received: from [2001:4bb8:184:7881:740a:25f7:2c13:ef7a] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nolut-006reA-JL; Wed, 11 May 2022 12:58:12 +0000
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org
Subject: [PATCH 1/3] swiotlb: don't panic when the swiotlb buffer can't be
 allocated
Date: Wed, 11 May 2022 14:58:03 +0200
Message-Id: <20220511125805.1377025-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220511125805.1377025-1-hch@lst.de>
References: <20220511125805.1377025-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: xen-devel@lists.xenproject.org,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Stefano Stabellini <sstabellini@kernel.org>, Conor.Dooley@microchip.com
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

For historical reasons the switlb code paniced when the metadata could
not be allocated, but just printed a warning when the actual main
swiotlb buffer could not be allocated.  Restore this somewhat unexpected
behavior as changing it caused a boot failure on the Microchip RISC-V
PolarFire SoC Icicle kit.

Fixes: 6424e31b1c05 ("swiotlb: remove swiotlb_init_with_tbl and swiotlb_init_late_with_tbl")
Reported-by: Conor Dooley <Conor.Dooley@microchip.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Conor Dooley <Conor.Dooley@microchip.com>
---
 kernel/dma/swiotlb.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index e2ef0864eb1e5..3e992a308c8a1 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -254,8 +254,10 @@ void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
 		tlb = memblock_alloc(bytes, PAGE_SIZE);
 	else
 		tlb = memblock_alloc_low(bytes, PAGE_SIZE);
-	if (!tlb)
-		panic("%s: failed to allocate tlb structure\n", __func__);
+	if (!tlb) {
+		pr_warn("%s: failed to allocate tlb structure\n", __func__);
+		return;
+	}
 
 	if (remap && remap(tlb, nslabs) < 0) {
 		memblock_free(tlb, PAGE_ALIGN(bytes));
-- 
2.30.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
