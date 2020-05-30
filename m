Return-Path: <SRS0=Olas=7M=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 164A0C433E1
	for <iommu@archiver.kernel.org>; Sat, 30 May 2020 08:13:46 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDF11207BC
	for <iommu@archiver.kernel.org>; Sat, 30 May 2020 08:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="hQvOF71K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDF11207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id B75948917D;
	Sat, 30 May 2020 08:13:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4mszbLPQJKhP; Sat, 30 May 2020 08:13:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 05829885C6;
	Sat, 30 May 2020 08:13:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F198EC088A;
	Sat, 30 May 2020 08:13:42 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2166BC016F
 for <iommu@lists.linux-foundation.org>; Sat, 30 May 2020 08:13:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 0E029882FD
 for <iommu@lists.linux-foundation.org>; Sat, 30 May 2020 08:13:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id o56wZd4DpJeF for <iommu@lists.linux-foundation.org>;
 Sat, 30 May 2020 08:13:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw01.mediatek.com (unknown [210.61.82.183])
 by whitealder.osuosl.org (Postfix) with ESMTP id 4E00287E34
 for <iommu@lists.linux-foundation.org>; Sat, 30 May 2020 08:13:40 +0000 (UTC)
X-UUID: fcc0f40ed6d146219732eb893537b5e2-20200530
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From;
 bh=woRB42GOP9qjDXW9aHZHkmqZIGzuEYzWf3H2RFksJJY=; 
 b=hQvOF71KXtm/CmjBImRG1nVFHB06DXipezYG+0o9vKRDfe3jh1adNasnLH8HLy0PVGJoHpCa4ki6dKsIoT5xcDipqsKn8h05h47zY8Jg+TNfoaPsRDDVbK6bh4l+CqsQJ/DwUtFZ4AuEoUGUBfFL9x2uftcEzRHNjl7UB02IftA=;
X-UUID: fcc0f40ed6d146219732eb893537b5e2-20200530
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
 with ESMTP id 1856444204; Sat, 30 May 2020 16:13:34 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 30 May 2020 16:13:31 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 30 May 2020 16:13:31 +0800
From: Yong Wu <yong.wu@mediatek.com>
To: Matthias Brugger <matthias.bgg@gmail.com>, Joerg Roedel <joro@8bytes.org>, 
 Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v4 08/17] media: mtk-vcodec: separate mtk-vcodec-enc node.
Date: Sat, 30 May 2020 16:10:09 +0800
Message-ID: <1590826218-23653-9-git-send-email-yong.wu@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1590826218-23653-1-git-send-email-yong.wu@mediatek.com>
References: <1590826218-23653-1-git-send-email-yong.wu@mediatek.com>
MIME-Version: 1.0
X-MTK: N
Cc: Maoguang Meng <maoguang.meng@mediatek.com>,
 Will Deacon <will.deacon@arm.com>, youlin.pei@mediatek.com,
 Irui Wang <irui.wang@mediatek.com>, Nicolas Boichat <drinkcat@chromium.org>,
 Evan Green <evgreen@chromium.org>, eizan@chromium.org,
 Matthias Kaehlcke <mka@chromium.org>, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, cui.zhang@mediatek.com,
 Tomasz Figa <tfiga@google.com>, linux-mediatek@lists.infradead.org,
 Hsin-Yi Wang <hsinyi@chromium.org>, ming-fan.chen@mediatek.com,
 anan.sun@mediatek.com, acourbot@chromium.org, srv_heupstream@mediatek.com,
 linux-kernel@vger.kernel.org, chao.hao@mediatek.com,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>
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

From: Maoguang Meng <maoguang.meng@mediatek.com>

MTK H264 Encoder(VENC_SYS) and VP8 Encoder(VENC_LT_SYS) are two
independent hardware instance. They have their owner interrupt,
register mapping, and special clocks.

This patch seperates the two instance. This is a preparing patch for
adding device_link between the larbs and venc-device. It's mainly for
fixing the problem:
https://lkml.org/lkml/2019/9/3/316

User Call "VIDIOC_QUERYCAP":
H264 Encoder return driver name "mtk-vcodec-enc";
VP8 Encoder return driver name "mtk-venc-vp8.

Signed-off-by: Maoguang Meng <maoguang.meng@mediatek.com>
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Signed-off-by: Irui Wang <irui.wang@mediatek.com>
---
 drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h |  10 +-
 drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c |  23 +++-
 .../media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c | 127 +++++++++------------
 .../media/platform/mtk-vcodec/mtk_vcodec_enc_pm.c  |  31 +----
 .../media/platform/mtk-vcodec/mtk_vcodec_enc_pm.h  |   1 -
 .../media/platform/mtk-vcodec/venc/venc_vp8_if.c   |   4 +-
 6 files changed, 80 insertions(+), 116 deletions(-)

diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h b/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h
index a2716117..52d1ce1 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h
@@ -19,6 +19,7 @@
 #define MTK_VCODEC_DRV_NAME	"mtk_vcodec_drv"
 #define MTK_VCODEC_DEC_NAME	"mtk-vcodec-dec"
 #define MTK_VCODEC_ENC_NAME	"mtk-vcodec-enc"
+#define MTK_VENC_VP8_NAME	"mtk-venc-vp8"
 #define MTK_PLATFORM_STR	"platform:mt8173"
 
 #define MTK_VCODEC_MAX_PLANES	3
@@ -193,7 +194,6 @@ struct mtk_vcodec_pm {
 
 	struct mtk_vcodec_clk	venc_clk;
 	struct device	*larbvenc;
-	struct device	*larbvenclt;
 	struct device	*dev;
 	struct mtk_vcodec_dev	*mtkdev;
 };
@@ -311,25 +311,27 @@ enum mtk_chip {
  * @chip: chip this encoder is compatible with
  *
  * @uses_ext: whether the encoder uses the extended firmware messaging format
- * @has_lt_irq: whether the encoder uses the LT irq
+ * @name: whether the encoder core is vp8
  * @min_birate: minimum supported encoding bitrate
  * @max_bitrate: maximum supported encoding bitrate
  * @capture_formats: array of supported capture formats
  * @num_capture_formats: number of entries in capture_formats
  * @output_formats: array of supported output formats
  * @num_output_formats: number of entries in output_formats
+ * @core_id: stand for h264 or vp8 encode index
  */
 struct mtk_vcodec_enc_pdata {
 	enum mtk_chip chip;
 
 	bool uses_ext;
-	bool has_lt_irq;
+	const char *name;
 	unsigned long min_bitrate;
 	unsigned long max_bitrate;
 	const struct mtk_video_fmt *capture_formats;
 	size_t num_capture_formats;
 	const struct mtk_video_fmt *output_formats;
 	size_t num_output_formats;
+	int core_id;
 };
 
 /**
@@ -359,7 +361,6 @@ struct mtk_vcodec_enc_pdata {
  *
  * @dec_irq: decoder irq resource
  * @enc_irq: h264 encoder irq resource
- * @enc_lt_irq: vp8 encoder irq resource
  *
  * @dec_mutex: decoder hardware lock
  * @enc_mutex: encoder hardware lock.
@@ -395,7 +396,6 @@ struct mtk_vcodec_dev {
 
 	int dec_irq;
 	int enc_irq;
-	int enc_lt_irq;
 
 	struct mutex dec_mutex;
 	struct mutex enc_mutex;
diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
index f0af78f..5301dca 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
@@ -9,6 +9,7 @@
 #include <media/v4l2-mem2mem.h>
 #include <media/videobuf2-dma-contig.h>
 #include <soc/mediatek/smi.h>
+#include <linux/pm_runtime.h>
 
 #include "mtk_vcodec_drv.h"
 #include "mtk_vcodec_enc.h"
@@ -174,7 +175,10 @@ static int vidioc_enum_fmt_vid_out(struct file *file, void *priv,
 static int vidioc_venc_querycap(struct file *file, void *priv,
 				struct v4l2_capability *cap)
 {
-	strscpy(cap->driver, MTK_VCODEC_ENC_NAME, sizeof(cap->driver));
+	const struct mtk_vcodec_enc_pdata *pdata =
+		fh_to_ctx(priv)->dev->venc_pdata;
+
+	strscpy(cap->driver, pdata->name, sizeof(cap->driver));
 	strscpy(cap->bus_info, MTK_PLATFORM_STR, sizeof(cap->bus_info));
 	strscpy(cap->card, MTK_PLATFORM_STR, sizeof(cap->card));
 
@@ -788,7 +792,7 @@ static int vb2ops_venc_start_streaming(struct vb2_queue *q, unsigned int count)
 	  */
 	if ((ctx->state == MTK_STATE_ABORT) || (ctx->state == MTK_STATE_FREE)) {
 		ret = -EIO;
-		goto err_set_param;
+		goto err_start_stream;
 	}
 
 	/* Do the initialization when both start_streaming have been called */
@@ -800,6 +804,12 @@ static int vb2ops_venc_start_streaming(struct vb2_queue *q, unsigned int count)
 			return 0;
 	}
 
+	ret = pm_runtime_get_sync(&ctx->dev->plat_dev->dev);
+	if (ret < 0) {
+		mtk_v4l2_err("pm_runtime_get_sync fail %d", ret);
+		goto err_start_stream;
+	}
+
 	mtk_venc_set_param(ctx, &param);
 	ret = venc_if_set_param(ctx, VENC_SET_PARAM_ENC, &param);
 	if (ret) {
@@ -826,6 +836,11 @@ static int vb2ops_venc_start_streaming(struct vb2_queue *q, unsigned int count)
 	return 0;
 
 err_set_param:
+	ret = pm_runtime_put(&ctx->dev->plat_dev->dev);
+	if (ret < 0)
+		mtk_v4l2_err("pm_runtime_put fail %d", ret);
+
+err_start_stream:
 	for (i = 0; i < q->num_buffers; ++i) {
 		struct vb2_buffer *buf = vb2_get_buffer(q, i);
 
@@ -879,6 +894,10 @@ static void vb2ops_venc_stop_streaming(struct vb2_queue *q)
 	if (ret)
 		mtk_v4l2_err("venc_if_deinit failed=%d", ret);
 
+	ret = pm_runtime_put(&ctx->dev->plat_dev->dev);
+	if (ret < 0)
+		mtk_v4l2_err("pm_runtime_put fail %d", ret);
+
 	ctx->state = MTK_STATE_FREE;
 }
 
diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c
index b8fe408..fe17f0c 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c
@@ -49,12 +49,15 @@
 	},
 };
 
-static const struct mtk_video_fmt mtk_video_formats_capture_mt8173[] =  {
+static const struct mtk_video_fmt mtk_video_formats_capture_mt8173_h264[] =  {
 	{
 		.fourcc = V4L2_PIX_FMT_H264,
 		.type = MTK_FMT_ENC,
 		.num_planes = 1,
 	},
+};
+
+static const struct mtk_video_fmt mtk_video_formats_capture_mt8173_vp8[] =  {
 	{
 		.fourcc = V4L2_PIX_FMT_VP8,
 		.type = MTK_FMT_ENC,
@@ -110,35 +113,13 @@ static irqreturn_t mtk_vcodec_enc_irq_handler(int irq, void *priv)
 	ctx = dev->curr_ctx;
 	spin_unlock_irqrestore(&dev->irqlock, flags);
 
-	mtk_v4l2_debug(1, "id=%d", ctx->id);
-	addr = dev->reg_base[VENC_SYS] + MTK_VENC_IRQ_ACK_OFFSET;
-
-	ctx->irq_status = readl(dev->reg_base[VENC_SYS] +
-				(MTK_VENC_IRQ_STATUS_OFFSET));
-
-	clean_irq_status(ctx->irq_status, addr);
-
-	wake_up_ctx(ctx, MTK_INST_IRQ_RECEIVED);
-	return IRQ_HANDLED;
-}
-
-static irqreturn_t mtk_vcodec_enc_lt_irq_handler(int irq, void *priv)
-{
-	struct mtk_vcodec_dev *dev = priv;
-	struct mtk_vcodec_ctx *ctx;
-	unsigned long flags;
-	void __iomem *addr;
-
-	spin_lock_irqsave(&dev->irqlock, flags);
-	ctx = dev->curr_ctx;
-	spin_unlock_irqrestore(&dev->irqlock, flags);
+	mtk_v4l2_debug(1, "id=%d coreid:%d", ctx->id, dev->venc_pdata->core_id);
+	addr = dev->reg_base[dev->venc_pdata->core_id] +
+				MTK_VENC_IRQ_ACK_OFFSET;
 
-	mtk_v4l2_debug(1, "id=%d", ctx->id);
-	ctx->irq_status = readl(dev->reg_base[VENC_LT_SYS] +
+	ctx->irq_status = readl(dev->reg_base[dev->venc_pdata->core_id] +
 				(MTK_VENC_IRQ_STATUS_OFFSET));
 
-	addr = dev->reg_base[VENC_LT_SYS] + MTK_VENC_IRQ_ACK_OFFSET;
-
 	clean_irq_status(ctx->irq_status, addr);
 
 	wake_up_ctx(ctx, MTK_INST_IRQ_RECEIVED);
@@ -265,7 +246,8 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
 	struct resource *res;
 	phandle rproc_phandle;
 	enum mtk_vcodec_fw_type fw_type;
-	int i, j, ret;
+	int ret;
+	void __iomem *reg_base;
 
 	dev = devm_kzalloc(&pdev->dev, sizeof(*dev), GFP_KERNEL);
 	if (!dev)
@@ -291,63 +273,39 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
 	dev->venc_pdata = of_device_get_match_data(&pdev->dev);
 	ret = mtk_vcodec_init_enc_pm(dev);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "Failed to get mt vcodec clock source!");
+		dev_err(&pdev->dev, "Failed to get mtk vcodec clock source!");
 		goto err_enc_pm;
 	}
 
-	for (i = VENC_SYS, j = 0; i < NUM_MAX_VCODEC_REG_BASE; i++, j++) {
-		res = platform_get_resource(pdev, IORESOURCE_MEM, j);
-		dev->reg_base[i] = devm_ioremap_resource(&pdev->dev, res);
-		if (IS_ERR((__force void *)dev->reg_base[i])) {
-			ret = PTR_ERR((__force void *)dev->reg_base[i]);
-			goto err_res;
-		}
-		mtk_v4l2_debug(2, "reg[%d] base=0x%p", i, dev->reg_base[i]);
-	}
+	pm_runtime_enable(&pdev->dev);
+
+	snprintf(dev->v4l2_dev.name, sizeof(dev->v4l2_dev.name), "%s",
+		 dev->venc_pdata->name);
 
-	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (res == NULL) {
-		dev_err(&pdev->dev, "failed to get irq resource");
-		ret = -ENOENT;
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	reg_base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR((__force void *)reg_base)) {
+		ret = PTR_ERR((__force void *)reg_base);
 		goto err_res;
 	}
+	dev->reg_base[dev->venc_pdata->core_id] = reg_base;
 
 	dev->enc_irq = platform_get_irq(pdev, 0);
 	ret = devm_request_irq(&pdev->dev, dev->enc_irq,
 			       mtk_vcodec_enc_irq_handler,
 			       0, pdev->name, dev);
 	if (ret) {
-		dev_err(&pdev->dev, "Failed to install dev->enc_irq %d (%d)",
-			dev->enc_irq,
-			ret);
+		dev_err(&pdev->dev,
+			"Failed to install dev->enc_irq %d (%d) core_id:%d",
+			dev->enc_irq, ret, dev->venc_pdata->core_id);
 		ret = -EINVAL;
 		goto err_res;
 	}
 	disable_irq(dev->enc_irq);
 
-	if (dev->venc_pdata->has_lt_irq) {
-		dev->enc_lt_irq = platform_get_irq(pdev, 1);
-		ret = devm_request_irq(&pdev->dev,
-				       dev->enc_lt_irq,
-				       mtk_vcodec_enc_lt_irq_handler,
-				       0, pdev->name, dev);
-		if (ret) {
-			dev_err(&pdev->dev,
-				"Failed to install dev->enc_lt_irq %d (%d)",
-				dev->enc_lt_irq, ret);
-			ret = -EINVAL;
-			goto err_res;
-		}
-		disable_irq(dev->enc_lt_irq); /* VENC_LT */
-	}
-
 	mutex_init(&dev->enc_mutex);
 	mutex_init(&dev->dev_mutex);
 	spin_lock_init(&dev->irqlock);
-
-	snprintf(dev->v4l2_dev.name, sizeof(dev->v4l2_dev.name), "%s",
-		 "[MTK_V4L2_VENC]");
-
 	ret = v4l2_device_register(&pdev->dev, &dev->v4l2_dev);
 	if (ret) {
 		mtk_v4l2_err("v4l2_device_register err=%d", ret);
@@ -373,7 +331,7 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
 					V4L2_CAP_STREAMING;
 
 	snprintf(vfd_enc->name, sizeof(vfd_enc->name), "%s",
-		 MTK_VCODEC_ENC_NAME);
+			dev->venc_pdata->name);
 	video_set_drvdata(vfd_enc, dev);
 	dev->vfd_enc = vfd_enc;
 	platform_set_drvdata(pdev, dev);
@@ -401,8 +359,8 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
 		goto err_enc_reg;
 	}
 
-	mtk_v4l2_debug(0, "encoder registered as /dev/video%d",
-			vfd_enc->num);
+	mtk_v4l2_debug(0, "encoder %d registered as /dev/video%d",
+		       dev->venc_pdata->core_id, vfd_enc->num);
 
 	return 0;
 
@@ -415,26 +373,39 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
 err_enc_alloc:
 	v4l2_device_unregister(&dev->v4l2_dev);
 err_res:
-	mtk_vcodec_release_enc_pm(dev);
+	pm_runtime_disable(&pdev->dev);
 err_enc_pm:
 	mtk_vcodec_fw_release(dev->fw_handler);
 	return ret;
 }
 
-static const struct mtk_vcodec_enc_pdata mt8173_pdata = {
+static const struct mtk_vcodec_enc_pdata mt8173_avc_pdata = {
+	.chip = MTK_MT8173,
+	.name = MTK_VCODEC_ENC_NAME,
+	.capture_formats = mtk_video_formats_capture_mt8173_h264,
+	.num_capture_formats = 1,
+	.output_formats = mtk_video_formats_output_mt8173,
+	.num_output_formats = ARRAY_SIZE(mtk_video_formats_output_mt8173),
+	.min_bitrate = 1,
+	.max_bitrate = 4000000,
+	.core_id = VENC_SYS,
+};
+
+static const struct mtk_vcodec_enc_pdata mt8173_vp8_pdata = {
 	.chip = MTK_MT8173,
-	.has_lt_irq = true,
-	.capture_formats = mtk_video_formats_capture_mt8173,
-	.num_capture_formats = ARRAY_SIZE(mtk_video_formats_capture_mt8173),
+	.name = MTK_VENC_VP8_NAME,
+	.capture_formats = mtk_video_formats_capture_mt8173_vp8,
+	.num_capture_formats = 1,
 	.output_formats = mtk_video_formats_output_mt8173,
 	.num_output_formats = ARRAY_SIZE(mtk_video_formats_output_mt8173),
 	.min_bitrate = 1,
 	.max_bitrate = 4000000,
+	.core_id = VENC_LT_SYS,
 };
 
 static const struct mtk_vcodec_enc_pdata mt8183_pdata = {
 	.chip = MTK_MT8183,
-	.has_lt_irq = false,
+	.name = MTK_VCODEC_ENC_NAME,
 	.uses_ext = true,
 	.capture_formats = mtk_video_formats_capture_mt8183,
 	.num_capture_formats = ARRAY_SIZE(mtk_video_formats_capture_mt8183),
@@ -443,10 +414,14 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
 	.num_output_formats = ARRAY_SIZE(mtk_video_formats_output_mt8173),
 	.min_bitrate = 64,
 	.max_bitrate = 40000000,
+	.core_id = VENC_SYS,
 };
 
 static const struct of_device_id mtk_vcodec_enc_match[] = {
-	{.compatible = "mediatek,mt8173-vcodec-enc", .data = &mt8173_pdata},
+	{.compatible = "mediatek,mt8173-vcodec-avc-enc",
+			.data = &mt8173_avc_pdata},
+	{.compatible = "mediatek,mt8173-vcodec-vp8-enc",
+			.data = &mt8173_vp8_pdata},
 	{.compatible = "mediatek,mt8183-vcodec-enc", .data = &mt8183_pdata},
 	{},
 };
@@ -466,7 +441,7 @@ static int mtk_vcodec_enc_remove(struct platform_device *pdev)
 		video_unregister_device(dev->vfd_enc);
 
 	v4l2_device_unregister(&dev->v4l2_dev);
-	mtk_vcodec_release_enc_pm(dev);
+	pm_runtime_disable(&pdev->dev);
 	mtk_vcodec_fw_release(dev->fw_handler);
 	return 0;
 }
diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.c
index ee22902..01c6a55 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.c
@@ -43,21 +43,6 @@ int mtk_vcodec_init_enc_pm(struct mtk_vcodec_dev *mtkdev)
 		return -ENODEV;
 	}
 	pm->larbvenc = &pdev->dev;
-
-	node = of_parse_phandle(dev->of_node, "mediatek,larb", 1);
-	if (!node) {
-		mtk_v4l2_err("no mediatek,larb found");
-		return -ENODEV;
-	}
-
-	pdev = of_find_device_by_node(node);
-	of_node_put(node);
-	if (!pdev) {
-		mtk_v4l2_err("no mediatek,larb device found");
-		return -ENODEV;
-	}
-
-	pm->larbvenclt = &pdev->dev;
 	pdev = mtkdev->plat_dev;
 	pm->dev = &pdev->dev;
 
@@ -94,11 +79,6 @@ int mtk_vcodec_init_enc_pm(struct mtk_vcodec_dev *mtkdev)
 	return ret;
 }
 
-void mtk_vcodec_release_enc_pm(struct mtk_vcodec_dev *mtkdev)
-{
-}
-
-
 void mtk_vcodec_enc_clock_on(struct mtk_vcodec_pm *pm)
 {
 	struct mtk_vcodec_clk *enc_clk = &pm->venc_clk;
@@ -116,18 +96,10 @@ void mtk_vcodec_enc_clock_on(struct mtk_vcodec_pm *pm)
 	ret = mtk_smi_larb_get(pm->larbvenc);
 	if (ret) {
 		mtk_v4l2_err("mtk_smi_larb_get larb3 fail %d", ret);
-		goto larbvencerr;
-	}
-	ret = mtk_smi_larb_get(pm->larbvenclt);
-	if (ret) {
-		mtk_v4l2_err("mtk_smi_larb_get larb4 fail %d", ret);
-		goto larbvenclterr;
+		goto clkerr;
 	}
 	return;
 
-larbvenclterr:
-	mtk_smi_larb_put(pm->larbvenc);
-larbvencerr:
 clkerr:
 	for (i -= 1; i >= 0; i--)
 		clk_disable_unprepare(enc_clk->clk_info[i].vcodec_clk);
@@ -139,7 +111,6 @@ void mtk_vcodec_enc_clock_off(struct mtk_vcodec_pm *pm)
 	int i = 0;
 
 	mtk_smi_larb_put(pm->larbvenc);
-	mtk_smi_larb_put(pm->larbvenclt);
 	for (i = enc_clk->clk_num - 1; i >= 0; i--)
 		clk_disable_unprepare(enc_clk->clk_info[i].vcodec_clk);
 }
diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.h b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.h
index b7ecdfd..c1b5986 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.h
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.h
@@ -10,7 +10,6 @@
 #include "mtk_vcodec_drv.h"
 
 int mtk_vcodec_init_enc_pm(struct mtk_vcodec_dev *dev);
-void mtk_vcodec_release_enc_pm(struct mtk_vcodec_dev *dev);
 
 void mtk_vcodec_enc_clock_on(struct mtk_vcodec_pm *pm);
 void mtk_vcodec_enc_clock_off(struct mtk_vcodec_pm *pm);
diff --git a/drivers/media/platform/mtk-vcodec/venc/venc_vp8_if.c b/drivers/media/platform/mtk-vcodec/venc/venc_vp8_if.c
index 11abb19..8267a9c 100644
--- a/drivers/media/platform/mtk-vcodec/venc/venc_vp8_if.c
+++ b/drivers/media/platform/mtk-vcodec/venc/venc_vp8_if.c
@@ -367,7 +367,7 @@ static int vp8_enc_encode(void *handle,
 
 	mtk_vcodec_debug_enter(inst);
 
-	enable_irq(ctx->dev->enc_lt_irq);
+	enable_irq(ctx->dev->enc_irq);
 
 	switch (opt) {
 	case VENC_START_OPT_ENCODE_FRAME:
@@ -386,7 +386,7 @@ static int vp8_enc_encode(void *handle,
 
 encode_err:
 
-	disable_irq(ctx->dev->enc_lt_irq);
+	disable_irq(ctx->dev->enc_irq);
 	mtk_vcodec_debug_leave(inst);
 
 	return ret;
-- 
1.9.1
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
