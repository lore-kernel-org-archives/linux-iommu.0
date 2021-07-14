Return-Path: <SRS0=i+j8=MG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B85C07E9A
	for <iommu@archiver.kernel.org>; Wed, 14 Jul 2021 11:17:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FE5B613B2
	for <iommu@archiver.kernel.org>; Wed, 14 Jul 2021 11:17:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FE5B613B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 025E360B41;
	Wed, 14 Jul 2021 11:17:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id N5GOyghPXFnZ; Wed, 14 Jul 2021 11:17:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C100660B19;
	Wed, 14 Jul 2021 11:17:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AB2E6C0010;
	Wed, 14 Jul 2021 11:17:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 766A3C000E
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 11:17:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 650A560B41
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 11:17:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JcL8zcA6FKLu for <iommu@lists.linux-foundation.org>;
 Wed, 14 Jul 2021 11:17:30 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw02.mediatek.com (unknown [1.203.163.81])
 by smtp3.osuosl.org (Postfix) with ESMTP id A10EE60B19
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 11:17:29 +0000 (UTC)
X-UUID: 37b55c57c3454cd8b103485dbf769f8b-20210714
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=Q6LzrYoLA5I8zE2H4Wb3+h6SVEZjseCiEm0eHzHqVVY=; 
 b=Y1vmKf1JjW7fRct618pV5oa5Z4kb7hgjD2TkcFjjj+p9/1ijs5I3S///bHnVdVC6E+/uh2bQgRjZwz9zBBWjc1A0gdm55I+yH1AmUv0OD9WlpoMtFWZcXajNzBTq+rTYerQnF/NKoW7HZIHuWMiF6mOIwa7HpXBtE7zudMjUugo=;
X-UUID: 37b55c57c3454cd8b103485dbf769f8b-20210714
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 1517682039; Wed, 14 Jul 2021 19:17:19 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Wed, 14 Jul 2021 19:17:15 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 14 Jul 2021 19:17:13 +0800
Message-ID: <1626261434.14352.14.camel@mhfsdcap03>
Subject: Re: [PATCH v6 06/11] drm/mediatek: Add pm runtime support for ovl
 and rdma
From: Yong Wu <yong.wu@mediatek.com>
To: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Date: Wed, 14 Jul 2021 19:17:14 +0800
In-Reply-To: <61aa5aa9-5bd2-e99c-02ef-f5d13526eb43@collabora.com>
References: <20210714025626.5528-1-yong.wu@mediatek.com>
 <20210714025626.5528-7-yong.wu@mediatek.com>
 <61aa5aa9-5bd2-e99c-02ef-f5d13526eb43@collabora.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 71B93BC55DBF796D54EF11802D7AD481B3722F9B783DF86A1B40DE94AAC8E5FC2000:8
X-MTK: N
Cc: Xia Jiang <xia.jiang@mediatek.com>, Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 David Airlie <airlied@linux.ie>, Will
 Deacon <will.deacon@arm.com>, dri-devel@lists.freedesktop.org,
 anthony.huang@mediatek.com, youlin.pei@mediatek.com,
 Nicolas Boichat <drinkcat@chromium.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 Evan Green <evgreen@chromium.org>, Eizan
 Miyamoto <eizan@chromium.org>, Matthias Kaehlcke <mka@chromium.org>,
 yongqiang.niu@mediatek.com, CK Hu <ck.hu@mediatek.com>,
 linux-media@vger.kernel.org, devicetree@vger.kernel.org,
 Philipp Zabel <p.zabel@pengutronix.de>, Tiffany Lin <tiffany.lin@mediatek.com>,
 yi.kuo@mediatek.com, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, Hsin-Yi Wang <hsinyi@chromium.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, ming-fan.chen@mediatek.com, Mauro
 Carvalho Chehab <mchehab@kernel.org>, linux-arm-kernel@lists.infradead.org,
 anan.sun@mediatek.com, acourbot@chromium.org, srv_heupstream@mediatek.com,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Wed, 2021-07-14 at 10:44 +0200, Dafna Hirschfeld wrote:
> 
> On 14.07.21 04:56, Yong Wu wrote:
> > From: Yongqiang Niu <yongqiang.niu@mediatek.com>
> > 
> > Prepare for smi cleaning up "mediatek,larb".
> > 
> > Display use the dispsys device to call pm_rumtime_get_sync before.
> > This patch add pm_runtime_xx with ovl and rdma device whose nodes has
> > "iommus" property, then display could help pm_runtime_get for smi via
> > ovl or rdma device.
> > 
> > CC: CK Hu <ck.hu@mediatek.com>
> > Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > (Yong: Use pm_runtime_resume_and_get instead of pm_runtime_get_sync)
> > Acked-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> > ---
> >   drivers/gpu/drm/mediatek/mtk_disp_ovl.c  |  9 ++++++++-
> >   drivers/gpu/drm/mediatek/mtk_disp_rdma.c |  9 ++++++++-
> >   drivers/gpu/drm/mediatek/mtk_drm_crtc.c  | 12 +++++++++++-
> >   3 files changed, 27 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> > index fa9d79963cd3..ea5760f856ec 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> > @@ -11,6 +11,7 @@
> >   #include <linux/of_device.h>
> >   #include <linux/of_irq.h>
> >   #include <linux/platform_device.h>
> > +#include <linux/pm_runtime.h>
> >   #include <linux/soc/mediatek/mtk-cmdq.h>
> >   
> >   #include "mtk_disp_drv.h"
> > @@ -414,15 +415,21 @@ static int mtk_disp_ovl_probe(struct platform_device *pdev)
> >   		return ret;
> >   	}
> >   
> > +	pm_runtime_enable(dev);
> > +
> >   	ret = component_add(dev, &mtk_disp_ovl_component_ops);
> > -	if (ret)
> > +	if (ret) {
> > +		pm_runtime_disable(dev);
> >   		dev_err(dev, "Failed to add component: %d\n", ret);
> > +	}
> >   
> >   	return ret;
> >   }
> >   
> >   static int mtk_disp_ovl_remove(struct platform_device *pdev)
> >   {
> > +	pm_runtime_disable(&pdev->dev);
> > +
> >   	return 0;
> >   }
> >   
> > diff --git a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
> > index 705f28ceb4dd..0f31d1c8e37c 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
> > @@ -9,6 +9,7 @@
> >   #include <linux/of_device.h>
> >   #include <linux/of_irq.h>
> >   #include <linux/platform_device.h>
> > +#include <linux/pm_runtime.h>
> >   #include <linux/soc/mediatek/mtk-cmdq.h>
> >   
> >   #include "mtk_disp_drv.h"
> > @@ -327,9 +328,13 @@ static int mtk_disp_rdma_probe(struct platform_device *pdev)
> >   
> >   	platform_set_drvdata(pdev, priv);
> >   
> > +	pm_runtime_enable(dev);
> > +
> >   	ret = component_add(dev, &mtk_disp_rdma_component_ops);
> > -	if (ret)
> > +	if (ret) {
> > +		pm_runtime_disable(dev);
> >   		dev_err(dev, "Failed to add component: %d\n", ret);
> > +	}
> >   
> >   	return ret;
> >   }
> > @@ -338,6 +343,8 @@ static int mtk_disp_rdma_remove(struct platform_device *pdev)
> >   {
> >   	component_del(&pdev->dev, &mtk_disp_rdma_component_ops);
> >   
> > +	pm_runtime_disable(&pdev->dev);
> > +
> >   	return 0;
> >   }
> >   
> > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> > index 474efb844249..08e3f352377d 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> > @@ -557,9 +557,15 @@ static void mtk_drm_crtc_atomic_enable(struct drm_crtc *crtc,
> >   		return;
> >   	}
> >   
> > +	ret = pm_runtime_resume_and_get(comp->dev);
> > +	if (ret < 0)
> > +		DRM_DEV_ERROR(comp->dev, "Failed to enable power domain: %d\n",
> > +			      ret);
> 
> shouldn't the code return in case of failure here?

After confirm with yongqiang, We will fix this in next version.

Thanks.

> 
> Thanks,
> Dafna
> 
> > +
> >   	ret = mtk_crtc_ddp_hw_init(mtk_crtc);
> >   	if (ret) {
> >   		mtk_smi_larb_put(comp->larb_dev);
> > +		pm_runtime_put(comp->dev);
> >   		return;
> >   	}
> >   
> > @@ -572,7 +578,7 @@ static void mtk_drm_crtc_atomic_disable(struct drm_crtc *crtc,
> >   {
> >   	struct mtk_drm_crtc *mtk_crtc = to_mtk_crtc(crtc);
> >   	struct mtk_ddp_comp *comp = mtk_crtc->ddp_comp[0];
> > -	int i;
> > +	int i, ret;
> >   
> >   	DRM_DEBUG_DRIVER("%s %d\n", __func__, crtc->base.id);
> >   	if (!mtk_crtc->enabled)
> > @@ -596,6 +602,10 @@ static void mtk_drm_crtc_atomic_disable(struct drm_crtc *crtc,
> >   	drm_crtc_vblank_off(crtc);
> >   	mtk_crtc_ddp_hw_fini(mtk_crtc);
> >   	mtk_smi_larb_put(comp->larb_dev);
> > +	ret = pm_runtime_put(comp->dev);
> > +	if (ret < 0)
> > +		DRM_DEV_ERROR(comp->dev, "Failed to disable power domain: %d\n",
> > +			      ret);
> >   
> >   	mtk_crtc->enabled = false;
> >   }
> > 
> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
