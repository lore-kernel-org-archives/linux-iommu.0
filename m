Return-Path: <SRS0=i+j8=MG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3FAAC07E9A
	for <iommu@archiver.kernel.org>; Wed, 14 Jul 2021 08:30:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1C02613B7
	for <iommu@archiver.kernel.org>; Wed, 14 Jul 2021 08:30:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1C02613B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 70A39401F1;
	Wed, 14 Jul 2021 08:30:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dCXbQTU__keK; Wed, 14 Jul 2021 08:30:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 26E8F40114;
	Wed, 14 Jul 2021 08:30:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 015BCC001A;
	Wed, 14 Jul 2021 08:30:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D69DEC000E
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 08:30:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B713983BAF
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 08:30:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id L6tDVdlYgXYC for <iommu@lists.linux-foundation.org>;
 Wed, 14 Jul 2021 08:30:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B574A83BAE
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 08:30:29 +0000 (UTC)
Received: from [IPv6:2a02:810a:880:f54:e49e:3ed0:1a77:5623] (unknown
 [IPv6:2a02:810a:880:f54:e49e:3ed0:1a77:5623])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: dafna)
 by bhuna.collabora.co.uk (Postfix) with ESMTPSA id E74891F42822;
 Wed, 14 Jul 2021 09:30:26 +0100 (BST)
Subject: Re: [PATCH v6 07/11] drm/mediatek: Get rid of mtk_smi_larb_get/put
To: Yong Wu <yong.wu@mediatek.com>, Matthias Brugger
 <matthias.bgg@gmail.com>, Joerg Roedel <joro@8bytes.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 David Airlie <airlied@linux.ie>, Mauro Carvalho Chehab <mchehab@kernel.org>
References: <20210714025626.5528-1-yong.wu@mediatek.com>
 <20210714025626.5528-8-yong.wu@mediatek.com>
From: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Message-ID: <a0b487ec-5337-04da-2c97-f4992bf18394@collabora.com>
Date: Wed, 14 Jul 2021 10:30:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210714025626.5528-8-yong.wu@mediatek.com>
Content-Language: en-US
Cc: Xia Jiang <xia.jiang@mediatek.com>, Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Will Deacon <will.deacon@arm.com>, dri-devel@lists.freedesktop.org,
 anthony.huang@mediatek.com, youlin.pei@mediatek.com,
 Nicolas Boichat <drinkcat@chromium.org>, Evan Green <evgreen@chromium.org>,
 Eizan Miyamoto <eizan@chromium.org>, Matthias Kaehlcke <mka@chromium.org>,
 CK Hu <ck.hu@mediatek.com>, linux-media@vger.kernel.org,
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
> MediaTek IOMMU has already added the device_link between the consumer
> and smi-larb device. If the drm device call the pm_runtime_get_sync,
> the smi-larb's pm_runtime_get_sync also be called automatically.
> 
> CC: CK Hu <ck.hu@mediatek.com>
> CC: Philipp Zabel <p.zabel@pengutronix.de>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> Reviewed-by: Evan Green <evgreen@chromium.org>
> Acked-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

Reviewed-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>

> ---
>   drivers/gpu/drm/mediatek/mtk_drm_crtc.c     |  9 ------
>   drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 36 ++-------------------
>   drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h |  1 -
>   drivers/gpu/drm/mediatek/mtk_drm_drv.c      |  5 +--
>   4 files changed, 3 insertions(+), 48 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> index 08e3f352377d..d046abcf66ce 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> @@ -10,7 +10,6 @@
>   #include <linux/soc/mediatek/mtk-mutex.h>
>   
>   #include <asm/barrier.h>
> -#include <soc/mediatek/smi.h>
>   
>   #include <drm/drm_atomic.h>
>   #include <drm/drm_atomic_helper.h>
> @@ -551,12 +550,6 @@ static void mtk_drm_crtc_atomic_enable(struct drm_crtc *crtc,
>   
>   	DRM_DEBUG_DRIVER("%s %d\n", __func__, crtc->base.id);
>   
> -	ret = mtk_smi_larb_get(comp->larb_dev);
> -	if (ret) {
> -		DRM_ERROR("Failed to get larb: %d\n", ret);
> -		return;
> -	}
> -
>   	ret = pm_runtime_resume_and_get(comp->dev);
>   	if (ret < 0)
>   		DRM_DEV_ERROR(comp->dev, "Failed to enable power domain: %d\n",
> @@ -564,7 +557,6 @@ static void mtk_drm_crtc_atomic_enable(struct drm_crtc *crtc,
>   
>   	ret = mtk_crtc_ddp_hw_init(mtk_crtc);
>   	if (ret) {
> -		mtk_smi_larb_put(comp->larb_dev);
>   		pm_runtime_put(comp->dev);
>   		return;
>   	}
> @@ -601,7 +593,6 @@ static void mtk_drm_crtc_atomic_disable(struct drm_crtc *crtc,
>   
>   	drm_crtc_vblank_off(crtc);
>   	mtk_crtc_ddp_hw_fini(mtk_crtc);
> -	mtk_smi_larb_put(comp->larb_dev);
>   	ret = pm_runtime_put(comp->dev);
>   	if (ret < 0)
>   		DRM_DEV_ERROR(comp->dev, "Failed to disable power domain: %d\n",
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> index 75bc00e17fc4..7d240218d4c7 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> @@ -449,37 +449,15 @@ unsigned int mtk_drm_find_possible_crtc_by_comp(struct drm_device *drm,
>   	return ret;
>   }
>   
> -static int mtk_ddp_get_larb_dev(struct device_node *node, struct mtk_ddp_comp *comp,
> -				struct device *dev)
> -{
> -	struct device_node *larb_node;
> -	struct platform_device *larb_pdev;
> -
> -	larb_node = of_parse_phandle(node, "mediatek,larb", 0);
> -	if (!larb_node) {
> -		dev_err(dev, "Missing mediadek,larb phandle in %pOF node\n", node);
> -		return -EINVAL;
> -	}
> -
> -	larb_pdev = of_find_device_by_node(larb_node);
> -	if (!larb_pdev) {
> -		dev_warn(dev, "Waiting for larb device %pOF\n", larb_node);
> -		of_node_put(larb_node);
> -		return -EPROBE_DEFER;
> -	}
> -	of_node_put(larb_node);
> -	comp->larb_dev = &larb_pdev->dev;
> -
> -	return 0;
> -}
> -
>   int mtk_ddp_comp_init(struct device_node *node, struct mtk_ddp_comp *comp,
>   		      enum mtk_ddp_comp_id comp_id)
>   {
>   	struct platform_device *comp_pdev;
>   	enum mtk_ddp_comp_type type;
>   	struct mtk_ddp_comp_dev *priv;
> +#if IS_REACHABLE(CONFIG_MTK_CMDQ)
>   	int ret;
> +#endif
>   
>   	if (comp_id < 0 || comp_id >= DDP_COMPONENT_ID_MAX)
>   		return -EINVAL;
> @@ -495,16 +473,6 @@ int mtk_ddp_comp_init(struct device_node *node, struct mtk_ddp_comp *comp,
>   	}
>   	comp->dev = &comp_pdev->dev;
>   
> -	/* Only DMA capable components need the LARB property */
> -	if (type == MTK_DISP_OVL ||
> -	    type == MTK_DISP_OVL_2L ||
> -	    type == MTK_DISP_RDMA ||
> -	    type == MTK_DISP_WDMA) {
> -		ret = mtk_ddp_get_larb_dev(node, comp, comp->dev);
> -		if (ret)
> -			return ret;
> -	}
> -
>   	if (type == MTK_DISP_BLS ||
>   	    type == MTK_DISP_CCORR ||
>   	    type == MTK_DISP_COLOR ||
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> index bb914d976cf5..1b582262b682 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> @@ -70,7 +70,6 @@ struct mtk_ddp_comp_funcs {
>   struct mtk_ddp_comp {
>   	struct device *dev;
>   	int irq;
> -	struct device *larb_dev;
>   	enum mtk_ddp_comp_id id;
>   	const struct mtk_ddp_comp_funcs *funcs;
>   };
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> index b46bdb8985da..0d5ef3d8d081 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -577,11 +577,8 @@ static int mtk_drm_probe(struct platform_device *pdev)
>   	pm_runtime_disable(dev);
>   err_node:
>   	of_node_put(private->mutex_node);
> -	for (i = 0; i < DDP_COMPONENT_ID_MAX; i++) {
> +	for (i = 0; i < DDP_COMPONENT_ID_MAX; i++)
>   		of_node_put(private->comp_node[i]);
> -		if (private->ddp_comp[i].larb_dev)
> -			put_device(private->ddp_comp[i].larb_dev);
> -	}
>   	return ret;
>   }
>   
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
