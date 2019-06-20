Return-Path: <SRS0=IV2l=UT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D83FC43613
	for <iommu@archiver.kernel.org>; Thu, 20 Jun 2019 08:51:09 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C01A206E0
	for <iommu@archiver.kernel.org>; Thu, 20 Jun 2019 08:51:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C01A206E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 36787C6A;
	Thu, 20 Jun 2019 08:50:46 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 9A424ACC
	for <iommu@lists.linux-foundation.org>;
	Thu, 20 Jun 2019 08:50:43 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com
	[210.160.252.171])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 021A8837
	for <iommu@lists.linux-foundation.org>;
	Thu, 20 Jun 2019 08:50:42 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="5.62,396,1554735600"; d="scan'208";a="19173854"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
	by relmlie5.idc.renesas.com with ESMTP; 20 Jun 2019 17:50:41 +0900
Received: from localhost.localdomain (unknown [10.166.17.210])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id E3E01400C422;
	Thu, 20 Jun 2019 17:50:40 +0900 (JST)
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: ulf.hansson@linaro.org, hch@lst.de, m.szyprowski@samsung.com,
	robin.murphy@arm.com, joro@8bytes.org, axboe@kernel.dk
Subject: [RFC PATCH v7 5/5] mmc: queue: Use bigger segments if DMA MAP layer
	can merge the segments
Date: Thu, 20 Jun 2019 17:50:10 +0900
Message-Id: <1561020610-953-6-git-send-email-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1561020610-953-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
References: <1561020610-953-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Cc: linux-renesas-soc@vger.kernel.org, linux-mmc@vger.kernel.org,
	linux-block@vger.kernel.org, wsa+renesas@sang-engineering.com,
	iommu@lists.linux-foundation.org
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

When the max_segs of a mmc host is smaller than 512, the mmc
subsystem tries to use 512 segments if DMA MAP layer can merge
the segments, and then the mmc subsystem exposes such information
to the block layer by using blk_queue_can_use_dma_map_merging().

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/mmc/core/queue.c | 35 ++++++++++++++++++++++++++++++++---
 include/linux/mmc/host.h |  1 +
 2 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index 92900a0..ab0ecc6 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -24,6 +24,8 @@
 #include "card.h"
 #include "host.h"
 
+#define MMC_DMA_MAP_MERGE_SEGMENTS	512
+
 static inline bool mmc_cqe_dcmd_busy(struct mmc_queue *mq)
 {
 	/* Allow only 1 DCMD at a time */
@@ -196,6 +198,12 @@ static void mmc_queue_setup_discard(struct request_queue *q,
 		blk_queue_flag_set(QUEUE_FLAG_SECERASE, q);
 }
 
+static unsigned int mmc_get_max_segments(struct mmc_host *host)
+{
+	return host->can_dma_map_merge ? MMC_DMA_MAP_MERGE_SEGMENTS :
+					 host->max_segs;
+}
+
 /**
  * mmc_init_request() - initialize the MMC-specific per-request data
  * @q: the request queue
@@ -209,7 +217,7 @@ static int __mmc_init_request(struct mmc_queue *mq, struct request *req,
 	struct mmc_card *card = mq->card;
 	struct mmc_host *host = card->host;
 
-	mq_rq->sg = mmc_alloc_sg(host->max_segs, gfp);
+	mq_rq->sg = mmc_alloc_sg(mmc_get_max_segments(host), gfp);
 	if (!mq_rq->sg)
 		return -ENOMEM;
 
@@ -368,13 +376,23 @@ static void mmc_setup_queue(struct mmc_queue *mq, struct mmc_card *card)
 	blk_queue_bounce_limit(mq->queue, limit);
 	blk_queue_max_hw_sectors(mq->queue,
 		min(host->max_blk_count, host->max_req_size / 512));
-	blk_queue_max_segments(mq->queue, host->max_segs);
+	if (host->can_dma_map_merge)
+		WARN(!blk_queue_can_use_dma_map_merging(mq->queue,
+							mmc_dev(host)),
+		     "merging was advertised but not possible");
+	blk_queue_max_segments(mq->queue, mmc_get_max_segments(host));
 
 	if (mmc_card_mmc(card))
 		block_size = card->ext_csd.data_sector_size;
 
 	blk_queue_logical_block_size(mq->queue, block_size);
-	blk_queue_max_segment_size(mq->queue,
+	/*
+	 * After blk_queue_can_use_dma_map_merging() was called with succeed,
+	 * since it calls blk_queue_virt_boundary(), the mmc should not call
+	 * both blk_queue_max_segment_size().
+	 */
+	if (host->can_dma_map_merge)
+		blk_queue_max_segment_size(mq->queue,
 			round_down(host->max_seg_size, block_size));
 
 	dma_set_max_seg_size(mmc_dev(host), queue_max_segment_size(mq->queue));
@@ -424,6 +442,17 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card)
 	mq->tag_set.cmd_size = sizeof(struct mmc_queue_req);
 	mq->tag_set.driver_data = mq;
 
+	/*
+	 * Since blk_mq_alloc_tag_set() calls .init_request() of mmc_mq_ops,
+	 * the host->can_dma_map_merge should be set before to get max_segs
+	 * from mmc_get_max_segments().
+	 */
+	if (host->max_segs < MMC_DMA_MAP_MERGE_SEGMENTS &&
+	    dma_get_merge_boundary(mmc_dev(host)))
+		host->can_dma_map_merge = 1;
+	else
+		host->can_dma_map_merge = 0;
+
 	ret = blk_mq_alloc_tag_set(&mq->tag_set);
 	if (ret)
 		return ret;
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 43d0f0c..10c3719 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -398,6 +398,7 @@ struct mmc_host {
 	unsigned int		retune_now:1;	/* do re-tuning at next req */
 	unsigned int		retune_paused:1; /* re-tuning is temporarily disabled */
 	unsigned int		use_blk_mq:1;	/* use blk-mq */
+	unsigned int		can_dma_map_merge:1; /* merging can be used */
 
 	int			rescan_disable;	/* disable card detection */
 	int			rescan_entered;	/* used with nonremovable devices */
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
