Return-Path: <SRS0=mply=KV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B48C2B9F7
	for <iommu@archiver.kernel.org>; Wed, 26 May 2021 05:41:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B243C611CD
	for <iommu@archiver.kernel.org>; Wed, 26 May 2021 05:41:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B243C611CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 539C8605BC;
	Wed, 26 May 2021 05:41:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id V6pMTEKTznc7; Wed, 26 May 2021 05:41:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 19858605BD;
	Wed, 26 May 2021 05:41:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E4E31C000E;
	Wed, 26 May 2021 05:41:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AD2CFC0001
 for <iommu@lists.linux-foundation.org>; Wed, 26 May 2021 05:41:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A86F9605BD
 for <iommu@lists.linux-foundation.org>; Wed, 26 May 2021 05:41:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fFDqBdbMAx5E for <iommu@lists.linux-foundation.org>;
 Wed, 26 May 2021 05:41:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1648E605BC
 for <iommu@lists.linux-foundation.org>; Wed, 26 May 2021 05:41:47 +0000 (UTC)
Received: from [IPv6:2a00:a040:193:3500:f557:1b29:6904:4855] (unknown
 [IPv6:2a00:a040:193:3500:f557:1b29:6904:4855])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: dafna)
 by bhuna.collabora.co.uk (Postfix) with ESMTPSA id CA57E1F427EB;
 Wed, 26 May 2021 06:41:36 +0100 (BST)
Subject: Re: [PATCH v5 11/16] drm/mediatek: Get rid of mtk_smi_larb_get/put
To: Yong Wu <yong.wu@mediatek.com>, Matthias Brugger
 <matthias.bgg@gmail.com>, Joerg Roedel <joro@8bytes.org>,
 Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>
References: <20210410091128.31823-1-yong.wu@mediatek.com>
 <20210410091128.31823-12-yong.wu@mediatek.com>
From: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Message-ID: <6f3bfbeb-e7d4-249e-b4f0-da1825fec461@collabora.com>
Date: Wed, 26 May 2021 08:41:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210410091128.31823-12-yong.wu@mediatek.com>
Content-Language: en-US
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org, yi.kuo@mediatek.com,
 Nicolas Boichat <drinkcat@chromium.org>, acourbot@chromium.org,
 srv_heupstream@mediatek.com, eizan@chromium.org,
 Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
 Evan Green <evgreen@chromium.org>, chao.hao@mediatek.com,
 iommu@lists.linux-foundation.org, Matthias Kaehlcke <mka@chromium.org>,
 linux-mediatek@lists.infradead.org, Philipp Zabel <p.zabel@pengutronix.de>,
 CK Hu <ck.hu@mediatek.com>, ming-fan.chen@mediatek.com, anan.sun@mediatek.com,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
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

Hi

On 10.04.21 12:11, Yong Wu wrote:
> MediaTek IOMMU has already added the device_link between the consumer
> and smi-larb device. If the drm device call the pm_runtime_get_sync,
> the smi-larb's pm_runtime_get_sync also be called automatically.
> 
> CC: CK Hu <ck.hu@mediatek.com>
> CC: Philipp Zabel <p.zabel@pengutronix.de>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> Reviewed-by: Evan Green <evgreen@chromium.org>
> Acked-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> ---
>   drivers/gpu/drm/mediatek/mtk_drm_crtc.c     |  9 ------
>   drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 35 ---------------------
>   drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h |  1 -
>   drivers/gpu/drm/mediatek/mtk_drm_drv.c      |  5 +--
>   4 files changed, 1 insertion(+), 49 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> index 971ef58ac1dc..d59353af4019 100644
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
> @@ -544,12 +543,6 @@ static void mtk_drm_crtc_atomic_enable(struct drm_crtc *crtc,
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
> @@ -557,7 +550,6 @@ static void mtk_drm_crtc_atomic_enable(struct drm_crtc *crtc,
>   
>   	ret = mtk_crtc_ddp_hw_init(mtk_crtc);
>   	if (ret) {
> -		mtk_smi_larb_put(comp->larb_dev);
>   		pm_runtime_put(comp->dev);
>   		return;
>   	}
> @@ -594,7 +586,6 @@ static void mtk_drm_crtc_atomic_disable(struct drm_crtc *crtc,
>   
>   	drm_crtc_vblank_off(crtc);
>   	mtk_crtc_ddp_hw_fini(mtk_crtc);
> -	mtk_smi_larb_put(comp->larb_dev);
>   	ret = pm_runtime_put(comp->dev);
>   	if (ret < 0)
>   		DRM_DEV_ERROR(comp->dev, "Failed to disable power domain: %d\n",
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> index 75bc00e17fc4..6c01492ba4df 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> @@ -449,37 +449,12 @@ unsigned int mtk_drm_find_possible_crtc_by_comp(struct drm_device *drm,
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
> -	int ret;
Hi,

This 'ret' is also used inside `if IS_REACHABLE(CONFIG_MTK_CMDQ)`
so it  should not be removed.

Thanks,
Dafna

>   
>   	if (comp_id < 0 || comp_id >= DDP_COMPONENT_ID_MAX)
>   		return -EINVAL;
> @@ -495,16 +470,6 @@ int mtk_ddp_comp_init(struct device_node *node, struct mtk_ddp_comp *comp,
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
> index b013d56d2777..622de47239eb 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -576,11 +576,8 @@ static int mtk_drm_probe(struct platform_device *pdev)
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
