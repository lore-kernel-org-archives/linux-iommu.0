Return-Path: <SRS0=Vfdp=LE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E34C47094
	for <iommu@archiver.kernel.org>; Thu, 10 Jun 2021 12:00:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7303613E7
	for <iommu@archiver.kernel.org>; Thu, 10 Jun 2021 12:00:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7303613E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 68FD683D19;
	Thu, 10 Jun 2021 12:00:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id x8O2l3wAbuec; Thu, 10 Jun 2021 12:00:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4011883CD5;
	Thu, 10 Jun 2021 12:00:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 29B4AC000D;
	Thu, 10 Jun 2021 12:00:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 42363C000B
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 12:00:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3AFF5405EE
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 12:00:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=mediatek.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Xcri3CeOrYn7 for <iommu@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 12:00:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw01.mediatek.com (unknown [1.203.163.78])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5468A405ED
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 12:00:31 +0000 (UTC)
X-UUID: 827a8c7e72784590a93ccdd7abfe48bd-20210610
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=tlUPqFBYcu/rjIdxpBkPwMA/VWMkzOdQO1eIjrE31tg=; 
 b=rU3BCHZWLwd+LKYt/jYpih3uoKBlREvBTWTuqfOnCDU+GLNFEta/DZGQLWQ6RJRA71PyWZN+Wj7RQ6optVVL8nhUF68S1VN3Pxa/6AeAVin1B75ZIiadGc+yV7Wn4xjQ23Fp7TRkwSeF6RV9hu9kZ7o9T4vrQEPz6asioHh7Ork=;
X-UUID: 827a8c7e72784590a93ccdd7abfe48bd-20210610
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 39873709; Thu, 10 Jun 2021 20:00:23 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Thu, 10 Jun 2021 20:00:19 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 10 Jun 2021 20:00:18 +0800
Message-ID: <1623326418.23717.18.camel@mhfsdcap03>
Subject: Re: [PATCH v5 11/16] drm/mediatek: Get rid of mtk_smi_larb_get/put
From: Yong Wu <yong.wu@mediatek.com>
To: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Date: Thu, 10 Jun 2021 20:00:18 +0800
In-Reply-To: <6f3bfbeb-e7d4-249e-b4f0-da1825fec461@collabora.com>
References: <20210410091128.31823-1-yong.wu@mediatek.com>
 <20210410091128.31823-12-yong.wu@mediatek.com>
 <6f3bfbeb-e7d4-249e-b4f0-da1825fec461@collabora.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 5BEB4821D74113F0BEB303285223F2F9684DE83B6E5B1323D11FBD40F26FC9382000:8
X-MTK: N
Cc: Will Deacon <will.deacon@arm.com>, Krzysztof Kozlowski <krzk@kernel.org>,
 youlin.pei@mediatek.com, Nicolas Boichat <drinkcat@chromium.org>,
 Evan Green <evgreen@chromium.org>, eizan@chromium.org,
 Matthias Kaehlcke <mka@chromium.org>, CK Hu <ck.hu@mediatek.com>,
 devicetree@vger.kernel.org, yi.kuo@mediatek.com,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>, ming-fan.chen@mediatek.com,
 linux-arm-kernel@lists.infradead.org, anan.sun@mediatek.com,
 acourbot@chromium.org, srv_heupstream@mediatek.com,
 linux-kernel@vger.kernel.org, chao.hao@mediatek.com,
 iommu@lists.linux-foundation.org, Philipp Zabel <p.zabel@pengutronix.de>,
 Robin Murphy <robin.murphy@arm.com>
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

On Wed, 2021-05-26 at 08:41 +0300, Dafna Hirschfeld wrote:
> Hi
> 
> On 10.04.21 12:11, Yong Wu wrote:
> > MediaTek IOMMU has already added the device_link between the consumer
> > and smi-larb device. If the drm device call the pm_runtime_get_sync,
> > the smi-larb's pm_runtime_get_sync also be called automatically.
> > 
> > CC: CK Hu <ck.hu@mediatek.com>
> > CC: Philipp Zabel <p.zabel@pengutronix.de>
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > Reviewed-by: Evan Green <evgreen@chromium.org>
> > Acked-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> > ---
> >   drivers/gpu/drm/mediatek/mtk_drm_crtc.c     |  9 ------
> >   drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 35 ---------------------
> >   drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h |  1 -
> >   drivers/gpu/drm/mediatek/mtk_drm_drv.c      |  5 +--
> >   4 files changed, 1 insertion(+), 49 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> > index 971ef58ac1dc..d59353af4019 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> > @@ -10,7 +10,6 @@
> >   #include <linux/soc/mediatek/mtk-mutex.h>
> >   
> >   #include <asm/barrier.h>
> > -#include <soc/mediatek/smi.h>
> >   
> >   #include <drm/drm_atomic.h>
> >   #include <drm/drm_atomic_helper.h>
> > @@ -544,12 +543,6 @@ static void mtk_drm_crtc_atomic_enable(struct drm_crtc *crtc,
> >   
> >   	DRM_DEBUG_DRIVER("%s %d\n", __func__, crtc->base.id);
> >   
> > -	ret = mtk_smi_larb_get(comp->larb_dev);
> > -	if (ret) {
> > -		DRM_ERROR("Failed to get larb: %d\n", ret);
> > -		return;
> > -	}
> > -
> >   	ret = pm_runtime_resume_and_get(comp->dev);
> >   	if (ret < 0)
> >   		DRM_DEV_ERROR(comp->dev, "Failed to enable power domain: %d\n",
> > @@ -557,7 +550,6 @@ static void mtk_drm_crtc_atomic_enable(struct drm_crtc *crtc,
> >   
> >   	ret = mtk_crtc_ddp_hw_init(mtk_crtc);
> >   	if (ret) {
> > -		mtk_smi_larb_put(comp->larb_dev);
> >   		pm_runtime_put(comp->dev);
> >   		return;
> >   	}
> > @@ -594,7 +586,6 @@ static void mtk_drm_crtc_atomic_disable(struct drm_crtc *crtc,
> >   
> >   	drm_crtc_vblank_off(crtc);
> >   	mtk_crtc_ddp_hw_fini(mtk_crtc);
> > -	mtk_smi_larb_put(comp->larb_dev);
> >   	ret = pm_runtime_put(comp->dev);
> >   	if (ret < 0)
> >   		DRM_DEV_ERROR(comp->dev, "Failed to disable power domain: %d\n",
> > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> > index 75bc00e17fc4..6c01492ba4df 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> > @@ -449,37 +449,12 @@ unsigned int mtk_drm_find_possible_crtc_by_comp(struct drm_device *drm,
> >   	return ret;
> >   }
> >   
> > -static int mtk_ddp_get_larb_dev(struct device_node *node, struct mtk_ddp_comp *comp,
> > -				struct device *dev)
> > -{
> > -	struct device_node *larb_node;
> > -	struct platform_device *larb_pdev;
> > -
> > -	larb_node = of_parse_phandle(node, "mediatek,larb", 0);
> > -	if (!larb_node) {
> > -		dev_err(dev, "Missing mediadek,larb phandle in %pOF node\n", node);
> > -		return -EINVAL;
> > -	}
> > -
> > -	larb_pdev = of_find_device_by_node(larb_node);
> > -	if (!larb_pdev) {
> > -		dev_warn(dev, "Waiting for larb device %pOF\n", larb_node);
> > -		of_node_put(larb_node);
> > -		return -EPROBE_DEFER;
> > -	}
> > -	of_node_put(larb_node);
> > -	comp->larb_dev = &larb_pdev->dev;
> > -
> > -	return 0;
> > -}
> > -
> >   int mtk_ddp_comp_init(struct device_node *node, struct mtk_ddp_comp *comp,
> >   		      enum mtk_ddp_comp_id comp_id)
> >   {
> >   	struct platform_device *comp_pdev;
> >   	enum mtk_ddp_comp_type type;
> >   	struct mtk_ddp_comp_dev *priv;
> > -	int ret;
> Hi,
> 
> This 'ret' is also used inside `if IS_REACHABLE(CONFIG_MTK_CMDQ)`
> so it  should not be removed.

Hi Dafna,

Thanks very much for pointing out. Apparently I didn't enable this to
build. Sorry for this.

I will fix it in next version.

> 
> Thanks,
> Dafna
> 
> >   
> >   	if (comp_id < 0 || comp_id >= DDP_COMPONENT_ID_MAX)
> >   		return -EINVAL;
> > @@ -495,16 +470,6 @@ int mtk_ddp_comp_init(struct device_node *node, struct mtk_ddp_comp *comp,
> >   	}
> >   	comp->dev = &comp_pdev->dev;
> >   
> > -	/* Only DMA capable components need the LARB property */
> > -	if (type == MTK_DISP_OVL ||
> > -	    type == MTK_DISP_OVL_2L ||
> > -	    type == MTK_DISP_RDMA ||
> > -	    type == MTK_DISP_WDMA) {
> > -		ret = mtk_ddp_get_larb_dev(node, comp, comp->dev);
> > -		if (ret)
> > -			return ret;
> > -	}
> > -
> >   	if (type == MTK_DISP_BLS ||
> >   	    type == MTK_DISP_CCORR ||
> >   	    type == MTK_DISP_COLOR ||
> > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> > index bb914d976cf5..1b582262b682 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> > +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> > @@ -70,7 +70,6 @@ struct mtk_ddp_comp_funcs {
> >   struct mtk_ddp_comp {
> >   	struct device *dev;
> >   	int irq;
> > -	struct device *larb_dev;
> >   	enum mtk_ddp_comp_id id;
> >   	const struct mtk_ddp_comp_funcs *funcs;
> >   };
> > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> > index b013d56d2777..622de47239eb 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> > @@ -576,11 +576,8 @@ static int mtk_drm_probe(struct platform_device *pdev)
> >   	pm_runtime_disable(dev);
> >   err_node:
> >   	of_node_put(private->mutex_node);
> > -	for (i = 0; i < DDP_COMPONENT_ID_MAX; i++) {
> > +	for (i = 0; i < DDP_COMPONENT_ID_MAX; i++)
> >   		of_node_put(private->comp_node[i]);
> > -		if (private->ddp_comp[i].larb_dev)
> > -			put_device(private->ddp_comp[i].larb_dev);
> > -	}
> >   	return ret;
> >   }
> >   
> > 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
