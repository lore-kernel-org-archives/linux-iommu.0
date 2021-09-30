Return-Path: <SRS0=YF8t=OU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF101C433EF
	for <iommu@archiver.kernel.org>; Thu, 30 Sep 2021 07:14:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D6F661880
	for <iommu@archiver.kernel.org>; Thu, 30 Sep 2021 07:14:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8D6F661880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 646E580E06;
	Thu, 30 Sep 2021 07:14:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id f-GPSR2EkoHx; Thu, 30 Sep 2021 07:14:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 33DF180DD5;
	Thu, 30 Sep 2021 07:14:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1E3ADC000F;
	Thu, 30 Sep 2021 07:14:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DA428C000D
 for <iommu@lists.linux-foundation.org>; Thu, 30 Sep 2021 07:14:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BB9856071F
 for <iommu@lists.linux-foundation.org>; Thu, 30 Sep 2021 07:14:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=mediatek.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HodCd3z-rhBf for <iommu@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 07:14:51 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1F0556068D
 for <iommu@lists.linux-foundation.org>; Thu, 30 Sep 2021 07:14:50 +0000 (UTC)
X-UUID: 02bdd3d43917428486059ffb84059693-20210930
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=W+gAqULzOpfc/ivXZHGg1RcECraPP+WX8duBqllWiWg=; 
 b=q6efus+v6mX5SugaKB9oDbvpcDX3wweSD7qtPf2IR45WzvSCiPikm9UkP3QVbvTgTgLPZDSnAT7wHVIQ2xQIp7xdgzrJmimFYB9auLntLAhrici9R0V3DC6TqxrDFvuFZJtlP6xPLCacUIEC/WOzXMzfNySweY7gwtEkUXD715U=;
X-UUID: 02bdd3d43917428486059ffb84059693-20210930
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by
 mailgw01.mediatek.com (envelope-from <yong.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 1808720043; Thu, 30 Sep 2021 15:14:45 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3; 
 Thu, 30 Sep 2021 15:14:44 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 30 Sep 2021 15:14:42 +0800
Message-ID: <d3ed2bdef81ce1822b20da9570b5245cc0df6330.camel@mediatek.com>
Subject: Re: [PATCH v8 03/12] iommu/mediatek: Add probe_defer for smi-larb
From: Yong Wu <yong.wu@mediatek.com>
To: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>, Matthias Brugger
 <matthias.bgg@gmail.com>, Joerg Roedel <joro@8bytes.org>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski@canonical.com>, David Airlie <airlied@linux.ie>, "Mauro
 Carvalho Chehab" <mchehab@kernel.org>
Date: Thu, 30 Sep 2021 15:14:45 +0800
In-Reply-To: <33a8b313-ad1b-d307-7e8c-2fdebdc6f1a7@collabora.com>
References: <20210929013719.25120-1-yong.wu@mediatek.com>
 <20210929013719.25120-4-yong.wu@mediatek.com>
 <33a8b313-ad1b-d307-7e8c-2fdebdc6f1a7@collabora.com>
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK: N
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>, Will Deacon <will.deacon@arm.com>,
 dri-devel@lists.freedesktop.org, anthony.huang@mediatek.com,
 youlin.pei@mediatek.com, Evan Green <evgreen@chromium.org>,
 Eizan Miyamoto <eizan@chromium.org>, Matthias Kaehlcke <mka@chromium.org>,
 linux-media@vger.kernel.org, devicetree@vger.kernel.org, Philipp
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

On Wed, 2021-09-29 at 18:33 +0200, Dafna Hirschfeld wrote:
> 
> On 29.09.21 03:37, Yong Wu wrote:
> > Prepare for adding device_link.
> > 
> > The iommu consumer should use device_link to connect with the
> > smi-larb(supplier). then the smi-larb should run before the iommu
> > consumer. Here we delay the iommu driver until the smi driver is
> > ready,
> > then all the iommu consumers always are after the smi driver.
> > 
> > When there is no this patch, if some consumer drivers run before
> > smi-larb, the supplier link_status is DL_DEV_NO_DRIVER(0) in the
> > device_link_add, then device_links_driver_bound will use WARN_ON
> > to complain that the link_status of supplier is not right.
> > 
> > device_is_bound may be more elegant here. but it is not allowed to
> > EXPORT from https://lore.kernel.org/patchwork/patch/1334670/.
> > 
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > Tested-by: Frank Wunderlich <frank-w@public-files.de> # BPI-
> > R2/MT7623
> > ---
> >   drivers/iommu/mtk_iommu.c    | 2 +-
> >   drivers/iommu/mtk_iommu_v1.c | 2 +-
> >   2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> > index d837adfd1da5..d5848f78a677 100644
> > --- a/drivers/iommu/mtk_iommu.c
> > +++ b/drivers/iommu/mtk_iommu.c
> > @@ -844,7 +844,7 @@ static int mtk_iommu_probe(struct
> > platform_device *pdev)
> >   			id = i;
> >   
> >   		plarbdev = of_find_device_by_node(larbnode);
> > -		if (!plarbdev) {
> > +		if (!plarbdev || !plarbdev->dev.driver) {
> >   			of_node_put(larbnode);
> >   			return -EPROBE_DEFER;
> 
> if plarbdev is null doesn't that mean that the device does not exist?

This is probe function, Is it possible the platform device is not ready
at this time?

I checked the platform device should be created at:

of_platform_default_populate_init:  arch_initcall_sync
  ->of_platform_populate
      ->of_platform_device_create_pdata

Not sure if this may be delayed for some device. If not, it should be
ENODEV here.

> so we should return -ENODEV in that case?
> 
> thanks,
> Dafna
> 
> >   		}
> > diff --git a/drivers/iommu/mtk_iommu_v1.c
> > b/drivers/iommu/mtk_iommu_v1.c
> > index 1467ba1e4417..4d7809432239 100644
> > --- a/drivers/iommu/mtk_iommu_v1.c
> > +++ b/drivers/iommu/mtk_iommu_v1.c
> > @@ -602,7 +602,7 @@ static int mtk_iommu_probe(struct
> > platform_device *pdev)
> >   		}
> >   
> >   		plarbdev = of_find_device_by_node(larbnode);
> > -		if (!plarbdev) {
> > +		if (!plarbdev || !plarbdev->dev.driver) {
> >   			of_node_put(larbnode);
> >   			return -EPROBE_DEFER;
> >   		}
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
