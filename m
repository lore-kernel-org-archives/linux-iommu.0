Return-Path: <SRS0=YF8t=OU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53017C4332F
	for <iommu@archiver.kernel.org>; Thu, 30 Sep 2021 03:28:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 050C261529
	for <iommu@archiver.kernel.org>; Thu, 30 Sep 2021 03:28:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 050C261529
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B857740190;
	Thu, 30 Sep 2021 03:28:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pMN5W9NUsJPq; Thu, 30 Sep 2021 03:28:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 46EC8402BD;
	Thu, 30 Sep 2021 03:28:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 03989C0011;
	Thu, 30 Sep 2021 03:28:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 10FC6C000D
 for <iommu@lists.linux-foundation.org>; Thu, 30 Sep 2021 03:28:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E068260E9E
 for <iommu@lists.linux-foundation.org>; Thu, 30 Sep 2021 03:28:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=mediatek.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SkBbwAqCqQAB for <iommu@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 03:28:17 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2692C605FB
 for <iommu@lists.linux-foundation.org>; Thu, 30 Sep 2021 03:28:16 +0000 (UTC)
X-UUID: 7f99426116984e4e82f32662b5e1824b-20210930
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=PUbrJ3OGRNIhFg0lP0OUuhqkMUmrG7lCbGwhX9NNv8I=; 
 b=fyhWP3a8ryvYzvl/+BcS1BevoTk8b7BSv/6fXTrv/0FJHzhAzSJ9EvZsZZOdtHQCJpzPezquq8qd8ib5G+etIueXIhiV6osK9o/XNzlJRd14yCGqik5DCS7rzqn/9x2GItVxSYy7jrBQPSt1k+koUgmZjtjH7drpKIqvXeprZhA=;
X-UUID: 7f99426116984e4e82f32662b5e1824b-20210930
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 1737133217; Thu, 30 Sep 2021 11:28:11 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 30 Sep 2021 11:28:11 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 30 Sep 2021 11:28:09 +0800
Message-ID: <79cbf64491273797f218f417234b8c95936bd3b1.camel@mediatek.com>
Subject: Re: [PATCH v8 09/12] media: mtk-vcodec: Get rid of
 mtk_smi_larb_get/put
From: Yong Wu <yong.wu@mediatek.com>
To: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>, Matthias Brugger
 <matthias.bgg@gmail.com>, Joerg Roedel <joro@8bytes.org>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski@canonical.com>, David Airlie <airlied@linux.ie>, "Mauro
 Carvalho Chehab" <mchehab@kernel.org>
Date: Thu, 30 Sep 2021 11:28:12 +0800
In-Reply-To: <02f444d5-9633-3f9c-2d1f-97ce073d1180@collabora.com>
References: <20210929013719.25120-1-yong.wu@mediatek.com>
 <20210929013719.25120-10-yong.wu@mediatek.com>
 <02f444d5-9633-3f9c-2d1f-97ce073d1180@collabora.com>
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK: N
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>, Will Deacon <will.deacon@arm.com>,
 dri-devel@lists.freedesktop.org, anthony.huang@mediatek.com,
 youlin.pei@mediatek.com, Irui Wang <irui.wang@mediatek.com>,
 Evan Green <evgreen@chromium.org>, Eizan Miyamoto <eizan@chromium.org>,
 Matthias Kaehlcke <mka@chromium.org>, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, Philipp
 Zabel <p.zabel@pengutronix.de>, Frank Wunderlich <frank-w@public-files.de>,
 yi.kuo@mediatek.com, linux-mediatek@lists.infradead.org,
 Hsin-Yi Wang <hsinyi@chromium.org>, Tiffany Lin <tiffany.lin@mediatek.com>,
 linux-arm-kernel@lists.infradead.org, anan.sun@mediatek.com,
 srv_heupstream@mediatek.com, acourbot@chromium.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, Daniel
 Vetter <daniel@ffwll.ch>, Robin Murphy <robin.murphy@arm.com>
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

Hi Dafna,

Thanks very much for the review.

On Wed, 2021-09-29 at 14:13 +0200, Dafna Hirschfeld wrote:
> 
> On 29.09.21 03:37, Yong Wu wrote:
> > MediaTek IOMMU has already added the device_link between the
> > consumer
> > and smi-larb device. If the vcodec device call the
> > pm_runtime_get_sync,
> > the smi-larb's pm_runtime_get_sync also be called automatically.
> > 
> > CC: Tiffany Lin <tiffany.lin@mediatek.com>
> > CC: Irui Wang <irui.wang@mediatek.com>
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > Reviewed-by: Evan Green <evgreen@chromium.org>
> > Acked-by: Tiffany Lin <tiffany.lin@mediatek.com>
> > Reviewed-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
> > ---
> >   .../platform/mtk-vcodec/mtk_vcodec_dec_pm.c   | 37 +++-----------
> > --
> >   .../platform/mtk-vcodec/mtk_vcodec_drv.h      |  3 --
> >   .../platform/mtk-vcodec/mtk_vcodec_enc.c      |  1 -
> >   .../platform/mtk-vcodec/mtk_vcodec_enc_pm.c   | 44 +++-----------
> > -----
> >   4 files changed, 10 insertions(+), 75 deletions(-)
> > 
> > diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_pm.c
> > b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_pm.c
> > index 6038db96f71c..d0bf9aa3b29d 100644
> > --- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_pm.c
> > +++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_pm.c
> > @@ -8,14 +8,12 @@
> >   #include <linux/of_address.h>
> >   #include <linux/of_platform.h>
> >   #include <linux/pm_runtime.h>
> > -#include <soc/mediatek/smi.h>
> >   
> >   #include "mtk_vcodec_dec_pm.h"
> >   #include "mtk_vcodec_util.h"
> >   
> >   int mtk_vcodec_init_dec_pm(struct mtk_vcodec_dev *mtkdev)
> >   {
> > -	struct device_node *node;
> >   	struct platform_device *pdev;
> >   	struct mtk_vcodec_pm *pm;
> >   	struct mtk_vcodec_clk *dec_clk;
> > @@ -26,18 +24,7 @@ int mtk_vcodec_init_dec_pm(struct mtk_vcodec_dev
> > *mtkdev)
> >   	pm = &mtkdev->pm;
> >   	pm->mtkdev = mtkdev;
> >   	dec_clk = &pm->vdec_clk;
> > -	node = of_parse_phandle(pdev->dev.of_node, "mediatek,larb", 0);
> > -	if (!node) {
> > -		mtk_v4l2_err("of_parse_phandle mediatek,larb fail!");
> > -		return -1;
> > -	}
> >   
> > -	pdev = of_find_device_by_node(node);
> > -	of_node_put(node);
> > -	if (WARN_ON(!pdev)) {
> > -		return -1;
> > -	}
> > -	pm->larbvdec = &pdev->dev;
> >   	pdev = mtkdev->plat_dev;
> >   	pm->dev = &pdev->dev;
> >   
> > @@ -47,14 +34,11 @@ int mtk_vcodec_init_dec_pm(struct
> > mtk_vcodec_dev *mtkdev)
> >   		dec_clk->clk_info = devm_kcalloc(&pdev->dev,
> >   			dec_clk->clk_num, sizeof(*clk_info),
> >   			GFP_KERNEL);
> > -		if (!dec_clk->clk_info) {
> > -			ret = -ENOMEM;
> > -			goto put_device;
> > -		}
> > +		if (!dec_clk->clk_info)
> > +			return -ENOMEM;
> >   	} else {
> >   		mtk_v4l2_err("Failed to get vdec clock count");
> > -		ret = -EINVAL;
> > -		goto put_device;
> > +		return -EINVAL;
> >   	}
> >   
> >   	for (i = 0; i < dec_clk->clk_num; i++) {
> > @@ -63,29 +47,24 @@ int mtk_vcodec_init_dec_pm(struct
> > mtk_vcodec_dev *mtkdev)
> >   			"clock-names", i, &clk_info->clk_name);
> >   		if (ret) {
> >   			mtk_v4l2_err("Failed to get clock name id =
> > %d", i);
> > -			goto put_device;
> > +			return ret;
> >   		}
> >   		clk_info->vcodec_clk = devm_clk_get(&pdev->dev,
> >   			clk_info->clk_name);
> >   		if (IS_ERR(clk_info->vcodec_clk)) {
> >   			mtk_v4l2_err("devm_clk_get (%d)%s fail", i,
> >   				clk_info->clk_name);
> > -			ret = PTR_ERR(clk_info->vcodec_clk);
> > -			goto put_device;
> > +			return PTR_ERR(clk_info->vcodec_clk);
> >   		}
> >   	}
> >   
> >   	pm_runtime_enable(&pdev->dev);
> >   	return 0;
> > -put_device:
> > -	put_device(pm->larbvdec);
> > -	return ret;
> >   }
> >   
> >   void mtk_vcodec_release_dec_pm(struct mtk_vcodec_dev *dev)
> >   {
> >   	pm_runtime_disable(dev->pm.dev);
> > -	put_device(dev->pm.larbvdec);
> >   }
> 
> Now that functions only do  'pm_runtime_disable(dev->pm.dev);' so it
> will be more
> readable to remove the function mtk_vcodec_release_dec_pm
> and replace with pm_runtime_disable(dev->pm.dev);
> Same for the 'enc' equivalent.

Make sense. But It may be not proper if using pm_runtime_disable
as the symmetry with mtk_vcodec_init_dec_pm in the mtk_vcodec_probe.

Maybe we should move pm_runtime_enable out from mtk_vcodec_init_dec_pm
into mtk_vcodec_probe. I could do a new patch for this. Is this ok for
you?

> 
> Thanks,
> Dafna

[snip]
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
