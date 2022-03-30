Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C3ABC433FE
	for <iommu@archiver.kernel.org>; Wed, 30 Mar 2022 18:01:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 922CF41D7F;
	Wed, 30 Mar 2022 18:01:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2iY4hKGY3qLt; Wed, 30 Mar 2022 18:01:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 39D7641CF5;
	Wed, 30 Mar 2022 18:01:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F0D9BC001D;
	Wed, 30 Mar 2022 18:01:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AD4B7C0012
 for <iommu@lists.linux-foundation.org>; Wed, 30 Mar 2022 18:01:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8BB5341CF6
 for <iommu@lists.linux-foundation.org>; Wed, 30 Mar 2022 18:01:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GDOrrp4G009N for <iommu@lists.linux-foundation.org>;
 Wed, 30 Mar 2022 18:01:29 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E51BE41CF5
 for <iommu@lists.linux-foundation.org>; Wed, 30 Mar 2022 18:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=8sQ6SQCM7+eekKWwRavWR33/gb8wY09eRtrYpsnuNfQ=; b=yUXTtYD7LDJ8eYXzNSyyQftYQp
 S3O3C63uKLospuC5Mh4AL7JUStHkfwaRMljYo1yNjIR4OiIFD0WCK6jyi4GeT6zDxpQJ1+vdcHAMr
 Q9GQ8fNuoqDTs+qyoLgpt5fZSxYSIBkGtonuYlUG6ikqvFlpI2GChXbsKYHjI4IF/xYbqm+ndyIMd
 ZT3PM5Bm0h4mo51aGi0q6qMUxCjahNmfVAewOXBnIkSgPBXAUY3oAv4hW8yl+qZwlGs/YmUtbLjqG
 wX+ok7SDr/YclbDU4s+KHcUp+FpF2CmEH5tEZs9x1mHwaVvFaNUhDxmbduA7BR2uyfpRiyCw7IYfk
 eQNcXaFA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1nZcdJ-00H3zL-To; Wed, 30 Mar 2022 18:01:25 +0000
Date: Wed, 30 Mar 2022 11:01:25 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Subject: Re: "dma-mapping: remove CONFIG_DMA_REMAP" causes AMD SME boot fail
Message-ID: <YkSa9d3JOExAiBXU@infradead.org>
References: <1648659326.eabkokyuym.none.ref@localhost>
 <1648659326.eabkokyuym.none@localhost>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1648659326.eabkokyuym.none@localhost>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: Christoph Hellwig <hch@infradead.org>, iommu@lists.linux-foundation.org,
 regressions@lists.linux.dev, linux-kernel@vger.kernel.org
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

Can you try this patch, which is a bit of a hack?

diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index 50d209939c66c..61997c2ee0a17 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -28,7 +28,8 @@ bool force_dma_unencrypted(struct device *dev)
 	 * device does not support DMA to addresses that include the
 	 * encryption mask.
 	 */
-	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT)) {
+	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT) &&
+	    !get_dma_ops(dev)) {
 		u64 dma_enc_mask = DMA_BIT_MASK(__ffs64(sme_me_mask));
 		u64 dma_dev_mask = min_not_zero(dev->coherent_dma_mask,
 						dev->bus_dma_limit);
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
