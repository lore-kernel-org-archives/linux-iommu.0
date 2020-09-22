Return-Path: <SRS0=CZ1O=C7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 559D5C4741F
	for <iommu@archiver.kernel.org>; Tue, 22 Sep 2020 13:39:48 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA3BD239A1
	for <iommu@archiver.kernel.org>; Tue, 22 Sep 2020 13:39:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="b4ImiuW8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA3BD239A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 8578F2050F;
	Tue, 22 Sep 2020 13:39:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AHYQYA6L1aXN; Tue, 22 Sep 2020 13:39:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id AF8DD20385;
	Tue, 22 Sep 2020 13:39:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9954EC0893;
	Tue, 22 Sep 2020 13:39:44 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C0ADDC0051
 for <iommu@lists.linux-foundation.org>; Tue, 22 Sep 2020 13:39:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id B06E9870F7
 for <iommu@lists.linux-foundation.org>; Tue, 22 Sep 2020 13:39:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nZ0TbTTjJPBl for <iommu@lists.linux-foundation.org>;
 Tue, 22 Sep 2020 13:39:41 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by hemlock.osuosl.org (Postfix) with ESMTPS id AAB4686FDB
 for <iommu@lists.linux-foundation.org>; Tue, 22 Sep 2020 13:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=TW4HF4UNXK4k3VZxzu0QvqfItRwA9waS7E5349XKG5g=; b=b4ImiuW8O74awq/o/PA9Fq702/
 kf02jCe7wdTk/hcyClX7EyumlmM3ocHR0NDc7HN9kZY908uBfDM4pkM1D+e2xEnDvxdNFHlUVAV2Q
 DOtteGsOyDgEt+KjftqyrWHgvb+d5mSbvTz6DJyTlYLZorTSrfXUaZXuTY6Xj/vRhCYTxmcqKLy5I
 Z0X+PI69+GPVBOOeeLsxs8R09sZxkp++fS+HlWjI0w1S3p7tKHxG9XGGvpYxoJT3KRQn0nmss62k3
 mppxdfH/STzLV2PFsKDecsK9AGmjNcPnoR7TjbKbPIZw/Km9Uw7lVoVGE9Cintxxp/MFrP5IiGcPX
 wpwG4wbQ==;
Received: from p4fdb0c34.dip0.t-ipconnect.de ([79.219.12.52] helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kKiWB-0005M9-Fu; Tue, 22 Sep 2020 13:39:39 +0000
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org
Subject: [PATCH 2/3] dma-mapping: move valid_dma_direction to dma-direction.h
Date: Tue, 22 Sep 2020 15:40:01 +0200
Message-Id: <20200922134002.1227279-3-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200922134002.1227279-1-hch@lst.de>
References: <20200922134002.1227279-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: linux-kernel@vger.kernel.org,
 Dominik Brodowski <linux@dominikbrodowski.net>
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

Move the valid_dma_direction helper to a more suitable header, and
clean it up to use the proper enum as well as removing pointless braces.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/dma-direction.h | 8 +++++++-
 include/linux/dma-mapping.h   | 7 -------
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/include/linux/dma-direction.h b/include/linux/dma-direction.h
index 9c96e30e6a0bb0..a2fe4571bc9279 100644
--- a/include/linux/dma-direction.h
+++ b/include/linux/dma-direction.h
@@ -9,4 +9,10 @@ enum dma_data_direction {
 	DMA_NONE = 3,
 };
 
-#endif
+static inline int valid_dma_direction(enum dma_data_direction dir)
+{
+	return dir == DMA_BIDIRECTIONAL || dir == DMA_TO_DEVICE ||
+		dir == DMA_FROM_DEVICE;
+}
+
+#endif /* _LINUX_DMA_DIRECTION_H */
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index e074588d753ff6..51e93d44b826c8 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -138,13 +138,6 @@ extern const struct dma_map_ops dma_dummy_ops;
 
 #define DMA_BIT_MASK(n)	(((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
 
-static inline int valid_dma_direction(int dma_direction)
-{
-	return ((dma_direction == DMA_BIDIRECTIONAL) ||
-		(dma_direction == DMA_TO_DEVICE) ||
-		(dma_direction == DMA_FROM_DEVICE));
-}
-
 #ifdef CONFIG_DMA_DECLARE_COHERENT
 /*
  * These three functions are only for dma allocator.
-- 
2.28.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
