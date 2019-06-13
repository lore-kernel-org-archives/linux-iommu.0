Return-Path: <SRS0=dZmg=UM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A7A4C31E45
	for <iommu@archiver.kernel.org>; Thu, 13 Jun 2019 10:20:57 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BCA92084D
	for <iommu@archiver.kernel.org>; Thu, 13 Jun 2019 10:20:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BCA92084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 6EC72138D;
	Thu, 13 Jun 2019 10:20:43 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 5231B1366
	for <iommu@lists.linux-foundation.org>;
	Thu, 13 Jun 2019 10:20:41 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com
	[210.160.252.171])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id B984576D
	for <iommu@lists.linux-foundation.org>;
	Thu, 13 Jun 2019 10:20:40 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="5.62,369,1554735600"; d="scan'208";a="18589673"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
	by relmlie5.idc.renesas.com with ESMTP; 13 Jun 2019 19:20:37 +0900
Received: from localhost.localdomain (unknown [10.166.17.210])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id E2A694274BC4;
	Thu, 13 Jun 2019 19:20:37 +0900 (JST)
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: joro@8bytes.org, axboe@kernel.dk, ulf.hansson@linaro.org,
	wsa+renesas@sang-engineering.com
Subject: [RFC PATCH v6 4/5] mmc: tmio: Use dma_max_mapping_size() instead of a
	workaround
Date: Thu, 13 Jun 2019 19:20:14 +0900
Message-Id: <1560421215-10750-5-git-send-email-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1560421215-10750-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
References: <1560421215-10750-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Cc: linux-renesas-soc@vger.kernel.org, linux-mmc@vger.kernel.org,
	linux-block@vger.kernel.org, iommu@lists.linux-foundation.org, hch@lst.de
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

Since the commit 133d624b1cee ("dma: Introduce dma_max_mapping_size()")
provides a helper function to get the max mapping size, we can use
the function instead of the workaround code for swiotlb.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/mmc/host/tmio_mmc_core.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index 130b91c..85bd6aa6 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -26,6 +26,7 @@
 
 #include <linux/delay.h>
 #include <linux/device.h>
+#include <linux/dma-mapping.h>
 #include <linux/highmem.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
@@ -1189,19 +1190,9 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host)
 	mmc->max_blk_size = TMIO_MAX_BLK_SIZE;
 	mmc->max_blk_count = pdata->max_blk_count ? :
 		(PAGE_SIZE / mmc->max_blk_size) * mmc->max_segs;
-	mmc->max_req_size = mmc->max_blk_size * mmc->max_blk_count;
-	/*
-	 * Since swiotlb has memory size limitation, this will calculate
-	 * the maximum size locally (because we don't have any APIs for it now)
-	 * and check the current max_req_size. And then, this will update
-	 * the max_req_size if needed as a workaround.
-	 */
-	if (swiotlb_max_segment()) {
-		unsigned int max_size = (1 << IO_TLB_SHIFT) * IO_TLB_SEGSIZE;
-
-		if (mmc->max_req_size > max_size)
-			mmc->max_req_size = max_size;
-	}
+	mmc->max_req_size = min_t(unsigned int,
+				  mmc->max_blk_size * mmc->max_blk_count,
+				  dma_max_mapping_size(&pdev->dev));
 	mmc->max_seg_size = mmc->max_req_size;
 
 	if (mmc_can_gpio_ro(mmc))
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
