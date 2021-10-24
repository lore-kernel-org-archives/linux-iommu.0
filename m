Return-Path: <SRS0=5tw2=PM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 409E0C433FE
	for <iommu@archiver.kernel.org>; Sun, 24 Oct 2021 17:40:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FFF860FC3
	for <iommu@archiver.kernel.org>; Sun, 24 Oct 2021 17:40:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7FFF860FC3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4268180D90;
	Sun, 24 Oct 2021 17:40:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4F_uNRclgq5h; Sun, 24 Oct 2021 17:40:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2EB9B80DA1;
	Sun, 24 Oct 2021 17:40:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DE8C5C0019;
	Sun, 24 Oct 2021 17:40:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 46D72C000E
 for <iommu@lists.linux-foundation.org>; Sun, 24 Oct 2021 17:40:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 35B1640298
 for <iommu@lists.linux-foundation.org>; Sun, 24 Oct 2021 17:40:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WvMGIpJfZmgy for <iommu@lists.linux-foundation.org>;
 Sun, 24 Oct 2021 17:40:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from smtp.smtpout.orange.fr (smtp01.smtpout.orange.fr
 [80.12.242.123])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 058B340271
 for <iommu@lists.linux-foundation.org>; Sun, 24 Oct 2021 17:40:28 +0000 (UTC)
Received: from pop-os.home ([92.140.161.106]) by smtp.orange.fr with ESMTPA
 id ehTsmakZrdmYbehTsmLbF2; Sun, 24 Oct 2021 19:40:26 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 24 Oct 2021 19:40:26 +0200
X-ME-IP: 92.140.161.106
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: hch@lst.de,
	m.szyprowski@samsung.com,
	robin.murphy@arm.com
Subject: [PATCH] dma-mapping: Use 'bitmap_zalloc()' when applicable
Date: Sun, 24 Oct 2021 19:40:23 +0200
Message-Id: <20976d6fd4af266dec589b40929b53dfddd64b75.1635097161.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 iommu@lists.linux-foundation.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org
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

'dma_mem->bitmap' is a bitmap. So use 'bitmap_zalloc()' to simplify code,
improve the semantic and avoid some open-coded arithmetic in allocator
arguments.

Also change the corresponding 'kfree()' into 'bitmap_free()' to keep
consistency.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 kernel/dma/coherent.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/dma/coherent.c b/kernel/dma/coherent.c
index 25fc85a7aebe..375fb3c9538d 100644
--- a/kernel/dma/coherent.c
+++ b/kernel/dma/coherent.c
@@ -40,7 +40,6 @@ static struct dma_coherent_mem *dma_init_coherent_memory(phys_addr_t phys_addr,
 {
 	struct dma_coherent_mem *dma_mem;
 	int pages = size >> PAGE_SHIFT;
-	int bitmap_size = BITS_TO_LONGS(pages) * sizeof(long);
 	void *mem_base;
 
 	if (!size)
@@ -53,7 +52,7 @@ static struct dma_coherent_mem *dma_init_coherent_memory(phys_addr_t phys_addr,
 	dma_mem = kzalloc(sizeof(struct dma_coherent_mem), GFP_KERNEL);
 	if (!dma_mem)
 		goto out_unmap_membase;
-	dma_mem->bitmap = kzalloc(bitmap_size, GFP_KERNEL);
+	dma_mem->bitmap = bitmap_zalloc(pages, GFP_KERNEL);
 	if (!dma_mem->bitmap)
 		goto out_free_dma_mem;
 
@@ -81,7 +80,7 @@ static void dma_release_coherent_memory(struct dma_coherent_mem *mem)
 		return;
 
 	memunmap(mem->virt_base);
-	kfree(mem->bitmap);
+	bitmap_free(mem->bitmap);
 	kfree(mem);
 }
 
-- 
2.30.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
