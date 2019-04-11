Return-Path: <SRS0=Ap1T=SN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 178E9C10F14
	for <iommu@archiver.kernel.org>; Thu, 11 Apr 2019 07:10:40 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF66621841
	for <iommu@archiver.kernel.org>; Thu, 11 Apr 2019 07:10:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Aik3rNqu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF66621841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 4DD07229C;
	Thu, 11 Apr 2019 07:10:35 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 1E51C2290
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Apr 2019 07:10:17 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id A92F4854
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Apr 2019 07:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=5KMApAvxR039a2cHMBFA/xSjh1Dr8HlYT2OhTdLdPgc=;
	b=Aik3rNquPvOS7z15TksFDYEGL8
	ZMZ4YxuDNC3JVNXosmC0AXek80VQnYKrXxqxeEKYYG4HAA8LtBoRrULhqezvru59xGRpJbLO72tcb
	SJBmEoNG0DmotEflq22OZJDfTJTaWHIPveEfELOvnPdjyWsVZ3OxXHX80lYIsCA994AfhF5d1sPxF
	N1/HgLyOPJGaFn+KNdWEwsrMHjUZU4eq/cTm3H42+O214g9bxcSev1uwQYPKFfy3gYzwhJs3WcLkt
	clATeahY/epEiGMJTfdoY/emrcIopwdMlq3hFWSslLs/tQn7rVHsTzB0xrtBTCSmdV5IheYWJXQUO
	WbDGgyFg==;
Received: from 089144214194.atnat0023.highway.a1.net ([89.144.214.194]
	helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
	id 1hETqf-0006mv-8q; Thu, 11 Apr 2019 07:10:13 +0000
From: Christoph Hellwig <hch@lst.de>
To: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 1/2] mmc: let the dma map ops handle bouncing
Date: Thu, 11 Apr 2019 09:09:47 +0200
Message-Id: <20190411070948.29564-2-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190411070948.29564-1-hch@lst.de>
References: <20190411070948.29564-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
	bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: iommu@lists.linux-foundation.org, linux-mmc@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190411070947.mUxT_rkfsxYXO0-9G7qalMYGM_OAdo3q31nhkCdpM9k@z>

Just like we do for all other block drivers.  Especially as the limit
imposed at the moment might be way to pessimistic for iommus.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/mmc/core/queue.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index 7c364a9c4eeb..eb9c0692062c 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -354,18 +354,15 @@ static const struct blk_mq_ops mmc_mq_ops = {
 static void mmc_setup_queue(struct mmc_queue *mq, struct mmc_card *card)
 {
 	struct mmc_host *host = card->host;
-	u64 limit = BLK_BOUNCE_HIGH;
 	unsigned block_size = 512;
 
-	if (mmc_dev(host)->dma_mask && *mmc_dev(host)->dma_mask)
-		limit = (u64)dma_max_pfn(mmc_dev(host)) << PAGE_SHIFT;
-
 	blk_queue_flag_set(QUEUE_FLAG_NONROT, mq->queue);
 	blk_queue_flag_clear(QUEUE_FLAG_ADD_RANDOM, mq->queue);
 	if (mmc_can_erase(card))
 		mmc_queue_setup_discard(mq->queue, card);
 
-	blk_queue_bounce_limit(mq->queue, limit);
+	if (!mmc_dev(host)->dma_mask || !*mmc_dev(host)->dma_mask)
+		blk_queue_bounce_limit(mq->queue, BLK_BOUNCE_HIGH);
 	blk_queue_max_hw_sectors(mq->queue,
 		min(host->max_blk_count, host->max_req_size / 512));
 	blk_queue_max_segments(mq->queue, host->max_segs);
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
