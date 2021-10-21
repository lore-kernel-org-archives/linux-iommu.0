Return-Path: <SRS0=0R9D=PJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6126DC433EF
	for <iommu@archiver.kernel.org>; Thu, 21 Oct 2021 09:06:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0D2260F56
	for <iommu@archiver.kernel.org>; Thu, 21 Oct 2021 09:06:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F0D2260F56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BAB60407CA;
	Thu, 21 Oct 2021 09:06:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bHyQavte3hlO; Thu, 21 Oct 2021 09:06:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B2546407C2;
	Thu, 21 Oct 2021 09:06:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9E136C001C;
	Thu, 21 Oct 2021 09:06:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 209B8C0011
 for <iommu@lists.linux-foundation.org>; Thu, 21 Oct 2021 09:06:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 00E6040590
 for <iommu@lists.linux-foundation.org>; Thu, 21 Oct 2021 09:06:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7Yj4mJhDLbnv for <iommu@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 09:06:22 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 584864044F
 for <iommu@lists.linux-foundation.org>; Thu, 21 Oct 2021 09:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=V0ps7MOoUXk8YK3mCg0a5QwDQe75bF/iMr9Ht5KhyhM=; b=MshDVYGoh5SG2UZ+eU+vxA8+a6
 uLh+vQz54NGWTenl1nHU3Xzm0jirbt8FtOHXKiSCuQpjA14uEMYQRE+WhslVDBFml7H2XG1ZnPvqR
 vUWePdJI9LsTtiFllmoDNt7nNfv2ITXoGOf76a/tQFiOiK4Te9lqAdR6zG5Ub7SksTsXOBQh/nZVu
 ciYfReGAEO7EGq6+x99QWwi8Tw8m7xWjf3h86G0+KSbJQvDTjjihdQ/oUB9vXhtf7ef6GxV3F2fHE
 ylBevW51Bd2N6m8iypyEEBuutC+KJF4+i5D/6tpeBWtJYZTIhhkOMW2BTU3sQ9qqDxJfXeaXjvJQu
 hgHJs5EA==;
Received: from [2001:4bb8:180:8777:7df0:a8d8:40cc:3310] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mdU1l-006xu9-84; Thu, 21 Oct 2021 09:06:21 +0000
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org
Subject: [PATCH 02/10] dma-direct: unmapped remapped pages when
 dma_set_decrypted
Date: Thu, 21 Oct 2021 11:06:03 +0200
Message-Id: <20211021090611.488281-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211021090611.488281-1-hch@lst.de>
References: <20211021090611.488281-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: Robin Murphy <robin.murphy@arm.com>, David Rientjes <rientjes@google.com>
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

When dma_set_decrypted fails for the remapping case in dma_direct_alloc
we also need to unmap the pages before freeing them.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/dma/direct.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index d4d54af31a341..2fef8dd401fe9 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -230,7 +230,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 		if (!ret)
 			goto out_free_pages;
 		if (dma_set_decrypted(dev, ret, size))
-			goto out_free_pages;
+			goto out_unmap_pages;
 		memset(ret, 0, size);
 		goto done;
 	}
@@ -266,6 +266,9 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 	/* If memory cannot be re-encrypted, it must be leaked */
 	if (dma_set_encrypted(dev, page_address(page), size))
 		return NULL;
+out_unmap_pages:
+	if (IS_ENABLED(CONFIG_DMA_REMAP) && is_vmalloc_addr(ret))
+		vunmap(ret);
 out_free_pages:
 	__dma_direct_free_pages(dev, page, size);
 	return NULL;
-- 
2.30.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
