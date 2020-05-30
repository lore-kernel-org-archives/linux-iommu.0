Return-Path: <SRS0=Olas=7M=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A098C433DF
	for <iommu@archiver.kernel.org>; Sat, 30 May 2020 08:18:23 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD4F520774
	for <iommu@archiver.kernel.org>; Sat, 30 May 2020 08:18:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="fmc1P4tZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD4F520774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id AA597221BB;
	Sat, 30 May 2020 08:18:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VITGHnEo3M8D; Sat, 30 May 2020 08:18:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 7DE8822179;
	Sat, 30 May 2020 08:18:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 69ED7C0863;
	Sat, 30 May 2020 08:18:20 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 04CA0C016F
 for <iommu@lists.linux-foundation.org>; Sat, 30 May 2020 08:18:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id E741588443
 for <iommu@lists.linux-foundation.org>; Sat, 30 May 2020 08:18:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ArY6fvBlRO6N for <iommu@lists.linux-foundation.org>;
 Sat, 30 May 2020 08:18:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by whitealder.osuosl.org (Postfix) with ESMTP id 1182D88432
 for <iommu@lists.linux-foundation.org>; Sat, 30 May 2020 08:18:17 +0000 (UTC)
X-UUID: 3743f9c466e24b0c9adeca20aaf26bd5-20200530
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From;
 bh=b857mO0IxNjltTZKT+A58I0DX/pCaEnU3D8hoT6uu5g=; 
 b=fmc1P4tZIaeLrWDjd7yWkSoedns9J5DvTyGDKztUSqDk9EimlA+G4b4So9M8WBVLVYkHvXfmIGcqxhmAFpf8YL8k3+xKXohYjTkHaVHaTI3hSCxG1IWR9O+TrPh/lta7D5jE8UjPkVa3Q6EV1H82hbOw6oJTjmAYyxoQWx0XRG4=;
X-UUID: 3743f9c466e24b0c9adeca20aaf26bd5-20200530
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
 with ESMTP id 1038921384; Sat, 30 May 2020 16:13:15 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 30 May 2020 16:13:12 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 30 May 2020 16:13:12 +0800
From: Yong Wu <yong.wu@mediatek.com>
To: Matthias Brugger <matthias.bgg@gmail.com>, Joerg Roedel <joro@8bytes.org>, 
 Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v4 06/17] media: mtk-jpeg: Get rid of mtk_smi_larb_get/put
Date: Sat, 30 May 2020 16:10:07 +0800
Message-ID: <1590826218-23653-7-git-send-email-yong.wu@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1590826218-23653-1-git-send-email-yong.wu@mediatek.com>
References: <1590826218-23653-1-git-send-email-yong.wu@mediatek.com>
MIME-Version: 1.0
X-MTK: N
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 Nicolas Boichat <drinkcat@chromium.org>, cui.zhang@mediatek.com,
 eizan@chromium.org, srv_heupstream@mediatek.com, chao.hao@mediatek.com,
 Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
 Evan Green <evgreen@chromium.org>, Tomasz Figa <tfiga@google.com>,
 iommu@lists.linux-foundation.org, Matthias Kaehlcke <mka@chromium.org>,
 linux-mediatek@lists.infradead.org, Rick Chang <rick.chang@mediatek.com>,
 ming-fan.chen@mediatek.com, anan.sun@mediatek.com,
 Robin Murphy <robin.murphy@arm.com>, acourbot@chromium.org,
 linux-arm-kernel@lists.infradead.org
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

MediaTek IOMMU has already added device_link between the consumer
and smi-larb device. If the jpg device call the pm_runtime_get_sync,
the smi-larb's pm_runtime_get_sync also be called automatically.

CC: Rick Chang <rick.chang@mediatek.com>
Signed-off-by: Yong Wu <yong.wu@mediatek.com>
Reviewed-by: Evan Green <evgreen@chromium.org>
---
 drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c | 22 ----------------------
 drivers/media/platform/mtk-jpeg/mtk_jpeg_core.h |  2 --
 2 files changed, 24 deletions(-)

diff --git a/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c b/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
index f82a81a..21fba6f 100644
--- a/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
+++ b/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
@@ -21,7 +21,6 @@
 #include <media/v4l2-ioctl.h>
 #include <media/videobuf2-core.h>
 #include <media/videobuf2-dma-contig.h>
-#include <soc/mediatek/smi.h>
 
 #include "mtk_jpeg_hw.h"
 #include "mtk_jpeg_core.h"
@@ -893,11 +892,6 @@ static int mtk_jpeg_queue_init(void *priv, struct vb2_queue *src_vq,
 
 static void mtk_jpeg_clk_on(struct mtk_jpeg_dev *jpeg)
 {
-	int ret;
-
-	ret = mtk_smi_larb_get(jpeg->larb);
-	if (ret)
-		dev_err(jpeg->dev, "mtk_smi_larb_get larbvdec fail %d\n", ret);
 	clk_prepare_enable(jpeg->clk_jdec_smi);
 	clk_prepare_enable(jpeg->clk_jdec);
 }
@@ -906,7 +900,6 @@ static void mtk_jpeg_clk_off(struct mtk_jpeg_dev *jpeg)
 {
 	clk_disable_unprepare(jpeg->clk_jdec);
 	clk_disable_unprepare(jpeg->clk_jdec_smi);
-	mtk_smi_larb_put(jpeg->larb);
 }
 
 static irqreturn_t mtk_jpeg_dec_irq(int irq, void *priv)
@@ -1051,21 +1044,6 @@ static int mtk_jpeg_release(struct file *file)
 
 static int mtk_jpeg_clk_init(struct mtk_jpeg_dev *jpeg)
 {
-	struct device_node *node;
-	struct platform_device *pdev;
-
-	node = of_parse_phandle(jpeg->dev->of_node, "mediatek,larb", 0);
-	if (!node)
-		return -EINVAL;
-	pdev = of_find_device_by_node(node);
-	if (WARN_ON(!pdev)) {
-		of_node_put(node);
-		return -EINVAL;
-	}
-	of_node_put(node);
-
-	jpeg->larb = &pdev->dev;
-
 	jpeg->clk_jdec = devm_clk_get(jpeg->dev, "jpgdec");
 	if (IS_ERR(jpeg->clk_jdec))
 		return PTR_ERR(jpeg->clk_jdec);
diff --git a/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.h b/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.h
index 999bd14..8579494 100644
--- a/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.h
+++ b/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.h
@@ -47,7 +47,6 @@ enum mtk_jpeg_ctx_state {
  * @dec_reg_base:	JPEG registers mapping
  * @clk_jdec:		JPEG hw working clock
  * @clk_jdec_smi:	JPEG SMI bus clock
- * @larb:		SMI device
  */
 struct mtk_jpeg_dev {
 	struct mutex		lock;
@@ -61,7 +60,6 @@ struct mtk_jpeg_dev {
 	void __iomem		*dec_reg_base;
 	struct clk		*clk_jdec;
 	struct clk		*clk_jdec_smi;
-	struct device		*larb;
 };
 
 /**
-- 
1.9.1
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
