Return-Path: <SRS0=TfAO=UR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E824C31E51
	for <iommu@archiver.kernel.org>; Tue, 18 Jun 2019 07:58:01 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AF6E20B1F
	for <iommu@archiver.kernel.org>; Tue, 18 Jun 2019 07:58:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AF6E20B1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 190CBB6C;
	Tue, 18 Jun 2019 07:58:01 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id A2AACB5F
	for <iommu@lists.linux-foundation.org>;
	Tue, 18 Jun 2019 06:40:31 +0000 (UTC)
X-Greylist: delayed 00:05:01 by SQLgrey-1.7.6
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 9234CE6
	for <iommu@lists.linux-foundation.org>;
	Tue, 18 Jun 2019 06:40:30 +0000 (UTC)
X-UUID: c955ef6297754fd299307ade39fb6010-20190618
X-UUID: c955ef6297754fd299307ade39fb6010-20190618
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(mhqrelay.mediatek.com ESMTP with TLS)
	with ESMTP id 442174043; Tue, 18 Jun 2019 14:35:20 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
	mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server
	(TLS) id 15.0.1395.4; Tue, 18 Jun 2019 14:35:19 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
	(172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
	Transport; Tue, 18 Jun 2019 14:35:19 +0800
Message-ID: <1560839719.3736.0.camel@mtksdaap41>
Subject: Re: [PATCH v2 08/12] drm/mediatek: Get rid of mtk_smi_larb_get/put
From: CK Hu <ck.hu@mediatek.com>
To: Yong Wu <yong.wu@mediatek.com>
Date: Tue, 18 Jun 2019 14:35:19 +0800
In-Reply-To: <1560171313-28299-9-git-send-email-yong.wu@mediatek.com>
References: <1560171313-28299-1-git-send-email-yong.wu@mediatek.com>
	<1560171313-28299-9-git-send-email-yong.wu@mediatek.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK: N
X-Mailman-Approved-At: Tue, 18 Jun 2019 07:57:59 +0000
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
	Nicolas Boichat <drinkcat@chromium.org>,
	srv_heupstream@mediatek.com, Will Deacon <will.deacon@arm.com>,
	linux-kernel@vger.kernel.org, Evan Green <evgreen@chromium.org>,
	Tomasz Figa <tfiga@google.com>, iommu@lists.linux-foundation.org,
	Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	yingjoe.chen@mediatek.com, anan.sun@mediatek.com,
	Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Hi, Yong:

On Mon, 2019-06-10 at 20:55 +0800, Yong Wu wrote:
> MediaTek IOMMU has already added the device_link between the consumer
> and smi-larb device. If the drm device call the pm_runtime_get_sync,
> the smi-larb's pm_runtime_get_sync also be called automatically.
> 
> CC: CK Hu <ck.hu@mediatek.com>
> CC: Philipp Zabel <p.zabel@pengutronix.de>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> Reviewed-by: Evan Green <evgreen@chromium.org>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_crtc.c     | 11 -----------
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 26 --------------------------
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h |  1 -
>  3 files changed, 38 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> index acad088..3a21a48 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> @@ -18,7 +18,6 @@
>  #include <drm/drm_probe_helper.h>
>  #include <linux/clk.h>
>  #include <linux/pm_runtime.h>
> -#include <soc/mediatek/smi.h>
>  
>  #include "mtk_drm_drv.h"
>  #include "mtk_drm_crtc.h"
> @@ -371,20 +370,12 @@ static void mtk_drm_crtc_atomic_enable(struct drm_crtc *crtc,
>  				       struct drm_crtc_state *old_state)
>  {
>  	struct mtk_drm_crtc *mtk_crtc = to_mtk_crtc(crtc);
> -	struct mtk_ddp_comp *comp = mtk_crtc->ddp_comp[0];
>  	int ret;
>  
>  	DRM_DEBUG_DRIVER("%s %d\n", __func__, crtc->base.id);
>  
> -	ret = mtk_smi_larb_get(comp->larb_dev);
> -	if (ret) {
> -		DRM_ERROR("Failed to get larb: %d\n", ret);
> -		return;
> -	}
> -
>  	ret = mtk_crtc_ddp_hw_init(mtk_crtc);
>  	if (ret) {
> -		mtk_smi_larb_put(comp->larb_dev);
>  		return;
>  	}

Remove {}.

Regards,
CK

>  
> @@ -396,7 +387,6 @@ static void mtk_drm_crtc_atomic_disable(struct drm_crtc *crtc,
>  					struct drm_crtc_state *old_state)
>  {
>  	struct mtk_drm_crtc *mtk_crtc = to_mtk_crtc(crtc);
> -	struct mtk_ddp_comp *comp = mtk_crtc->ddp_comp[0];
>  	int i;
>  
>  	DRM_DEBUG_DRIVER("%s %d\n", __func__, crtc->base.id);
> @@ -419,7 +409,6 @@ static void mtk_drm_crtc_atomic_disable(struct drm_crtc *crtc,
>  
>  	drm_crtc_vblank_off(crtc);
>  	mtk_crtc_ddp_hw_fini(mtk_crtc);
> -	mtk_smi_larb_put(comp->larb_dev);
>  
>  	mtk_crtc->enabled = false;
>  }
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> index 54ca794..ede15c9 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> @@ -265,8 +265,6 @@ int mtk_ddp_comp_init(struct device *dev, struct device_node *node,
>  		      const struct mtk_ddp_comp_funcs *funcs)
>  {
>  	enum mtk_ddp_comp_type type;
> -	struct device_node *larb_node;
> -	struct platform_device *larb_pdev;
>  
>  	if (comp_id < 0 || comp_id >= DDP_COMPONENT_ID_MAX)
>  		return -EINVAL;
> @@ -296,30 +294,6 @@ int mtk_ddp_comp_init(struct device *dev, struct device_node *node,
>  	if (IS_ERR(comp->clk))
>  		return PTR_ERR(comp->clk);
>  
> -	/* Only DMA capable components need the LARB property */
> -	comp->larb_dev = NULL;
> -	if (type != MTK_DISP_OVL &&
> -	    type != MTK_DISP_RDMA &&
> -	    type != MTK_DISP_WDMA)
> -		return 0;
> -
> -	larb_node = of_parse_phandle(node, "mediatek,larb", 0);
> -	if (!larb_node) {
> -		dev_err(dev,
> -			"Missing mediadek,larb phandle in %pOF node\n", node);
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
> -
> -	comp->larb_dev = &larb_pdev->dev;
> -
>  	return 0;
>  }
>  
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> index 8399229..b8dc17e 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> @@ -91,7 +91,6 @@ struct mtk_ddp_comp {
>  	struct clk *clk;
>  	void __iomem *regs;
>  	int irq;
> -	struct device *larb_dev;
>  	enum mtk_ddp_comp_id id;
>  	const struct mtk_ddp_comp_funcs *funcs;
>  };


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
