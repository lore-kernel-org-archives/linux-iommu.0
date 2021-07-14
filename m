Return-Path: <SRS0=i+j8=MG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22562C11F68
	for <iommu@archiver.kernel.org>; Wed, 14 Jul 2021 08:28:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3AEF613D7
	for <iommu@archiver.kernel.org>; Wed, 14 Jul 2021 08:28:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3AEF613D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8C36B60726;
	Wed, 14 Jul 2021 08:28:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0Z9ylv4j2TCM; Wed, 14 Jul 2021 08:28:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 647BE60662;
	Wed, 14 Jul 2021 08:28:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 46D0BC001A;
	Wed, 14 Jul 2021 08:28:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 502B8C000E
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 08:28:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3DBEF401F1
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 08:28:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pnZy62ByPEkJ for <iommu@lists.linux-foundation.org>;
 Wed, 14 Jul 2021 08:28:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 43E8C40114
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 08:28:52 +0000 (UTC)
Received: from [IPv6:2a02:810a:880:f54:e49e:3ed0:1a77:5623] (unknown
 [IPv6:2a02:810a:880:f54:e49e:3ed0:1a77:5623])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: dafna)
 by bhuna.collabora.co.uk (Postfix) with ESMTPSA id C8B601F42822;
 Wed, 14 Jul 2021 09:28:48 +0100 (BST)
Subject: Re: [PATCH v6 04/11] media: mtk-jpeg: Get rid of mtk_smi_larb_get/put
To: Yong Wu <yong.wu@mediatek.com>, Matthias Brugger
 <matthias.bgg@gmail.com>, Joerg Roedel <joro@8bytes.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 David Airlie <airlied@linux.ie>, Mauro Carvalho Chehab <mchehab@kernel.org>
References: <20210714025626.5528-1-yong.wu@mediatek.com>
 <20210714025626.5528-5-yong.wu@mediatek.com>
From: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Message-ID: <2753c4b1-76e7-9acd-ca1c-62e6017ed971@collabora.com>
Date: Wed, 14 Jul 2021 10:28:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210714025626.5528-5-yong.wu@mediatek.com>
Content-Language: en-US
Cc: Xia Jiang <xia.jiang@mediatek.com>, Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Will Deacon <will.deacon@arm.com>, dri-devel@lists.freedesktop.org,
 anthony.huang@mediatek.com, youlin.pei@mediatek.com,
 Nicolas Boichat <drinkcat@chromium.org>, Rick Chang <rick.chang@mediatek.com>,
 Evan Green <evgreen@chromium.org>, Eizan Miyamoto <eizan@chromium.org>,
 Matthias Kaehlcke <mka@chromium.org>, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>,
 yi.kuo@mediatek.com, linux-mediatek@lists.infradead.org,
 Hsin-Yi Wang <hsinyi@chromium.org>, ming-fan.chen@mediatek.com,
 Tiffany Lin <tiffany.lin@mediatek.com>, linux-arm-kernel@lists.infradead.org,
 anan.sun@mediatek.com, srv_heupstream@mediatek.com, acourbot@chromium.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Daniel Vetter <daniel@ffwll.ch>, Robin Murphy <robin.murphy@arm.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>



On 14.07.21 04:56, Yong Wu wrote:
> MediaTek IOMMU has already added device_link between the consumer
> and smi-larb device. If the jpg device call the pm_runtime_get_sync,
> the smi-larb's pm_runtime_get_sync also be called automatically.
> 
> After removing the larb_get operations, then mtk_jpeg_clk_init is
> also unnecessary. Remove it too.
> 
> CC: Rick Chang <rick.chang@mediatek.com>
> CC: Xia Jiang <xia.jiang@mediatek.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> Reviewed-by: Evan Green <evgreen@chromium.org>
> Acked-by: Rick Chang <rick.chang@mediatek.com>

Reviewed-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>

> ---
>   .../media/platform/mtk-jpeg/mtk_jpeg_core.c   | 45 +------------------
>   .../media/platform/mtk-jpeg/mtk_jpeg_core.h   |  2 -
>   2 files changed, 2 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c b/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
> index a89c7b206eef..4fea2c512434 100644
> --- a/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
> +++ b/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
> @@ -22,7 +22,6 @@
>   #include <media/v4l2-ioctl.h>
>   #include <media/videobuf2-core.h>
>   #include <media/videobuf2-dma-contig.h>
> -#include <soc/mediatek/smi.h>
>   
>   #include "mtk_jpeg_enc_hw.h"
>   #include "mtk_jpeg_dec_hw.h"
> @@ -1055,10 +1054,6 @@ static void mtk_jpeg_clk_on(struct mtk_jpeg_dev *jpeg)
>   {
>   	int ret;
>   
> -	ret = mtk_smi_larb_get(jpeg->larb);
> -	if (ret)
> -		dev_err(jpeg->dev, "mtk_smi_larb_get larbvdec fail %d\n", ret);
> -
>   	ret = clk_bulk_prepare_enable(jpeg->variant->num_clks,
>   				      jpeg->variant->clks);
>   	if (ret)
> @@ -1069,7 +1064,6 @@ static void mtk_jpeg_clk_off(struct mtk_jpeg_dev *jpeg)
>   {
>   	clk_bulk_disable_unprepare(jpeg->variant->num_clks,
>   				   jpeg->variant->clks);
> -	mtk_smi_larb_put(jpeg->larb);
>   }
>   
>   static irqreturn_t mtk_jpeg_enc_done(struct mtk_jpeg_dev *jpeg)
> @@ -1284,35 +1278,6 @@ static struct clk_bulk_data mtk_jpeg_clocks[] = {
>   	{ .id = "jpgenc" },
>   };
>   
> -static int mtk_jpeg_clk_init(struct mtk_jpeg_dev *jpeg)
> -{
> -	struct device_node *node;
> -	struct platform_device *pdev;
> -	int ret;
> -
> -	node = of_parse_phandle(jpeg->dev->of_node, "mediatek,larb", 0);
> -	if (!node)
> -		return -EINVAL;
> -	pdev = of_find_device_by_node(node);
> -	if (WARN_ON(!pdev)) {
> -		of_node_put(node);
> -		return -EINVAL;
> -	}
> -	of_node_put(node);
> -
> -	jpeg->larb = &pdev->dev;
> -
> -	ret = devm_clk_bulk_get(jpeg->dev, jpeg->variant->num_clks,
> -				jpeg->variant->clks);
> -	if (ret) {
> -		dev_err(&pdev->dev, "failed to get jpeg clock:%d\n", ret);
> -		put_device(&pdev->dev);
> -		return ret;
> -	}
> -
> -	return 0;
> -}
> -
>   static void mtk_jpeg_job_timeout_work(struct work_struct *work)
>   {
>   	struct mtk_jpeg_dev *jpeg = container_of(work, struct mtk_jpeg_dev,
> @@ -1333,11 +1298,6 @@ static void mtk_jpeg_job_timeout_work(struct work_struct *work)
>   	v4l2_m2m_job_finish(jpeg->m2m_dev, ctx->fh.m2m_ctx);
>   }
>   
> -static inline void mtk_jpeg_clk_release(struct mtk_jpeg_dev *jpeg)
> -{
> -	put_device(jpeg->larb);
> -}
> -
>   static int mtk_jpeg_probe(struct platform_device *pdev)
>   {
>   	struct mtk_jpeg_dev *jpeg;
> @@ -1376,7 +1336,8 @@ static int mtk_jpeg_probe(struct platform_device *pdev)
>   		goto err_req_irq;
>   	}
>   
> -	ret = mtk_jpeg_clk_init(jpeg);
> +	ret = devm_clk_bulk_get(jpeg->dev, jpeg->variant->num_clks,
> +				jpeg->variant->clks);
>   	if (ret) {
>   		dev_err(&pdev->dev, "Failed to init clk, err %d\n", ret);
>   		goto err_clk_init;
> @@ -1442,7 +1403,6 @@ static int mtk_jpeg_probe(struct platform_device *pdev)
>   	v4l2_device_unregister(&jpeg->v4l2_dev);
>   
>   err_dev_register:
> -	mtk_jpeg_clk_release(jpeg);
>   
>   err_clk_init:
>   
> @@ -1460,7 +1420,6 @@ static int mtk_jpeg_remove(struct platform_device *pdev)
>   	video_device_release(jpeg->vdev);
>   	v4l2_m2m_release(jpeg->m2m_dev);
>   	v4l2_device_unregister(&jpeg->v4l2_dev);
> -	mtk_jpeg_clk_release(jpeg);
>   
>   	return 0;
>   }
> diff --git a/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.h b/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.h
> index 595f7f10c9fd..3e4811a41ba2 100644
> --- a/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.h
> +++ b/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.h
> @@ -85,7 +85,6 @@ struct mtk_jpeg_variant {
>    * @alloc_ctx:		videobuf2 memory allocator's context
>    * @vdev:		video device node for jpeg mem2mem mode
>    * @reg_base:		JPEG registers mapping
> - * @larb:		SMI device
>    * @job_timeout_work:	IRQ timeout structure
>    * @variant:		driver variant to be used
>    */
> @@ -99,7 +98,6 @@ struct mtk_jpeg_dev {
>   	void			*alloc_ctx;
>   	struct video_device	*vdev;
>   	void __iomem		*reg_base;
> -	struct device		*larb;
>   	struct delayed_work job_timeout_work;
>   	const struct mtk_jpeg_variant *variant;
>   };
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
