Return-Path: <SRS0=Rhk0=P6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48A43C433EF
	for <iommu@archiver.kernel.org>; Thu, 11 Nov 2021 06:50:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D044619A6
	for <iommu@archiver.kernel.org>; Thu, 11 Nov 2021 06:50:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0D044619A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D401A4043B;
	Thu, 11 Nov 2021 06:50:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mlXk64A6bEOf; Thu, 11 Nov 2021 06:50:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 888CB4041F;
	Thu, 11 Nov 2021 06:50:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5F776C0020;
	Thu, 11 Nov 2021 06:50:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 21E08C001E
 for <iommu@lists.linux-foundation.org>; Thu, 11 Nov 2021 06:50:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0C1D8400C9
 for <iommu@lists.linux-foundation.org>; Thu, 11 Nov 2021 06:50:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HLT1HZJm5Nid for <iommu@lists.linux-foundation.org>;
 Thu, 11 Nov 2021 06:50:40 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4504340426
 for <iommu@lists.linux-foundation.org>; Thu, 11 Nov 2021 06:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=1/n2ztvAixHNGXPFTYwcUgQ4RaeMTej0vLY4xe6N9v4=; b=i5x0gZ21SFXRWO6o9FXlYlWGrV
 aFKJaUncOZOSHezjKzhc7KKiM4nY1aCyiVvdih2s6KSQUZ5HLYaoanEx/NS+OOCByGdlKTow+7Nfo
 EtxToK2Vc1I1GcYqnLmaTtawc9DlNqZ7m+/qjpwkPBggL1NPSfKXboNkCrlsOeu33bnaJxB3bceQL
 8ypRQFKYIl1q80giIf+VZVNKUg/O7eLEUUiKz0R+hf4rd9L8cXe8OFk/RJTjrr+UTToBkl4Set8RY
 HAH3KIfreGqZNIFBGD+r6pJeEJAb4MG9ZaeNsWd1OqpmNTwuAOPs2NHTmoeWeuMuHhPwQ99/Q3lKa
 5wuTrW2A==;
Received: from [2001:4bb8:19a:7ee7:dc25:8b64:278b:ff22] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ml3uv-002Vxr-DO; Thu, 11 Nov 2021 06:50:38 +0000
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org
Subject: [PATCH 07/11] dma-direct: fail allocations that can't be made coherent
Date: Thu, 11 Nov 2021 07:50:23 +0100
Message-Id: <20211111065028.32761-8-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211111065028.32761-1-hch@lst.de>
References: <20211111065028.32761-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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

If the architecture can't remap or set an address uncached there is no way
to fullfill a request for a coherent allocation.  Return NULL in that case.
Note that this case currently does not happen, so this is a theoretical
fixup and/or a preparation for eventually supporting platforms that
can't support coherent allocations with the generic code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/dma/direct.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index f9658fe18498c..a13017656ecae 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -233,8 +233,9 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 				return dma_direct_alloc_from_pool(dev, size,
 						dma_handle, gfp);
 		} else {
-			if (IS_ENABLED(CONFIG_ARCH_HAS_DMA_SET_UNCACHED))
-				set_uncached = true;
+			if (!IS_ENABLED(CONFIG_ARCH_HAS_DMA_SET_UNCACHED))
+				return NULL;
+			set_uncached = true;
 		}
 	}
 
-- 
2.30.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
