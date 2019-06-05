Return-Path: <SRS0=DEPd=UE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF252C28CC5
	for <iommu@archiver.kernel.org>; Wed,  5 Jun 2019 11:17:36 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B06A120665
	for <iommu@archiver.kernel.org>; Wed,  5 Jun 2019 11:17:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B06A120665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 5E4D7CB8;
	Wed,  5 Jun 2019 11:17:00 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 792E7C5D
	for <iommu@lists.linux-foundation.org>;
	Wed,  5 Jun 2019 11:16:56 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com
	[210.160.252.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 8CC6A854
	for <iommu@lists.linux-foundation.org>;
	Wed,  5 Jun 2019 11:16:55 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="5.60,550,1549897200"; d="scan'208";a="17680362"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
	by relmlie6.idc.renesas.com with ESMTP; 05 Jun 2019 20:16:53 +0900
Received: from localhost.localdomain (unknown [10.166.17.210])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id B64F141BD76A;
	Wed,  5 Jun 2019 20:16:53 +0900 (JST)
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: ulf.hansson@linaro.org, wsa+renesas@sang-engineering.com, hch@lst.de,
	m.szyprowski@samsung.com, robin.murphy@arm.com, joro@8bytes.org
Subject: [RFC PATCH v5 8/8] mmc: renesas_sdhi: use multiple segments if
	possible
Date: Wed,  5 Jun 2019 20:11:54 +0900
Message-Id: <1559733114-4221-9-git-send-email-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559733114-4221-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
References: <1559733114-4221-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Cc: linux-renesas-soc@vger.kernel.org, iommu@lists.linux-foundation.org,
	linux-mmc@vger.kernel.org
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

If the IOMMU driver has a capable for merging segments to
a segment strictly, this can expose the host->mmc->max_segs with
multiple segments to a block layer by using blk_queue_max_segments()
that mmc_setup_queue() calls. Notes that an sdio card may be
possible to use multiple segments with non page aligned size, so
that this will not expose multiple segments to avoid failing
dma_map_sg() every time.

Notes that on renesas_sdhi_sys_dmac, the max_segs value will change
from 32 to 512, but the sys_dmac can handle 512 segments, so that
this init_card ops is added on "TMIO_MMC_MIN_RCAR2" environment.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/mmc/host/renesas_sdhi_core.c          | 27 +++++++++++++++++++++++++++
 drivers/mmc/host/renesas_sdhi_internal_dmac.c |  4 ++++
 2 files changed, 31 insertions(+)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index c5ee4a6..379cefa 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -20,6 +20,7 @@
 
 #include <linux/clk.h>
 #include <linux/delay.h>
+#include <linux/iommu.h>
 #include <linux/kernel.h>
 #include <linux/mfd/tmio.h>
 #include <linux/mmc/host.h>
@@ -46,6 +47,8 @@
 #define SDHI_VER_GEN3_SD	0xcc10
 #define SDHI_VER_GEN3_SDMMC	0xcd10
 
+#define SDHI_MAX_SEGS_IN_IOMMU	512
+
 struct renesas_sdhi_quirks {
 	bool hs400_disabled;
 	bool hs400_4taps;
@@ -203,6 +206,28 @@ static void renesas_sdhi_clk_disable(struct tmio_mmc_host *host)
 	clk_disable_unprepare(priv->clk_cd);
 }
 
+static void renesas_sdhi_init_card(struct mmc_host *mmc, struct mmc_card *card)
+{
+	struct tmio_mmc_host *host = mmc_priv(mmc);
+
+	/*
+	 * If the IOMMU driver has a capable for merging segments to
+	 * a segment strictly, this can expose the host->mmc->max_segs with
+	 * multiple segments to a block layer by using blk_queue_max_segments()
+	 * that mmc_setup_queue() calls. Notes that an sdio card may be
+	 * possible to use multiple segments with non page aligned size, so
+	 * that this will not expose multiple segments to avoid failing
+	 * dma_map_sg() every time.
+	 */
+	if (host->pdata->max_segs < SDHI_MAX_SEGS_IN_IOMMU &&
+	    iommu_capable(host->pdev->dev.bus, IOMMU_CAP_MERGING) &&
+	    (mmc_card_mmc(card) || mmc_card_sd(card)))
+		host->mmc->max_segs = SDHI_MAX_SEGS_IN_IOMMU;
+	else
+		host->mmc->max_segs = host->pdata->max_segs ? :
+				      TMIO_DEFAULT_MAX_SEGS;
+}
+
 static int renesas_sdhi_card_busy(struct mmc_host *mmc)
 {
 	struct tmio_mmc_host *host = mmc_priv(mmc);
@@ -726,6 +751,8 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 
 	/* SDR speeds are only available on Gen2+ */
 	if (mmc_data->flags & TMIO_MMC_MIN_RCAR2) {
+		host->ops.init_card = renesas_sdhi_init_card;
+
 		/* card_busy caused issues on r8a73a4 (pre-Gen2) CD-less SDHI */
 		host->ops.card_busy = renesas_sdhi_card_busy;
 		host->ops.start_signal_voltage_switch =
diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index 751fe91..a442f86 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -11,6 +11,7 @@
 #include <linux/device.h>
 #include <linux/dma-mapping.h>
 #include <linux/io-64-nonatomic-hi-lo.h>
+#include <linux/iommu.h>
 #include <linux/mfd/tmio.h>
 #include <linux/mmc/host.h>
 #include <linux/mod_devicetable.h>
@@ -337,6 +338,9 @@ static int renesas_sdhi_internal_dmac_probe(struct platform_device *pdev)
 	/* value is max of SD_SECCNT. Confirmed by HW engineers */
 	dma_set_max_seg_size(dev, 0xffffffff);
 
+	if (iommu_capable(dev->bus, IOMMU_CAP_MERGING))
+		dma_set_iova_contiguous(dev, true);
+
 	return renesas_sdhi_probe(pdev, &renesas_sdhi_internal_dmac_dma_ops);
 }
 
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
