Return-Path: <SRS0=VyMr=O3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF36C433F5
	for <iommu@archiver.kernel.org>; Thu,  7 Oct 2021 02:57:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C80DF610A8
	for <iommu@archiver.kernel.org>; Thu,  7 Oct 2021 02:57:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C80DF610A8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 81BF860719;
	Thu,  7 Oct 2021 02:57:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pkDHch-4uRLb; Thu,  7 Oct 2021 02:57:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1AA9860663;
	Thu,  7 Oct 2021 02:57:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F24FFC000F;
	Thu,  7 Oct 2021 02:57:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E6A81C000D
 for <iommu@lists.linux-foundation.org>; Thu,  7 Oct 2021 02:57:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BAE2A841B6
 for <iommu@lists.linux-foundation.org>; Thu,  7 Oct 2021 02:57:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=mediatek.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Q3yo8AvItVhX for <iommu@lists.linux-foundation.org>;
 Thu,  7 Oct 2021 02:57:07 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2E97483FE8
 for <iommu@lists.linux-foundation.org>; Thu,  7 Oct 2021 02:57:06 +0000 (UTC)
X-UUID: 23a9fe624ca14001ac777cca9e1593f6-20211007
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=puAeYVHv80gaLD3QPUVP0U9ZlM4HRv166FTTO6hr2Lk=; 
 b=LqzMu5O1Ak1GXXXZIGexmWg/0ZCTwsSG5We2XLOH6iO7Ba4RPqZF5ht9oZZ69+uMg+JklvO1wEOXebFap0K1/ydqHp0no/CJKw0h7AA/w2OoRanFVNXcLOl70D13Lna3urZ/5YBRsjcFc+CPP8WM5CE1JtRZPqAeGH5mq87dze0=;
X-UUID: 23a9fe624ca14001ac777cca9e1593f6-20211007
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 722450187; Thu, 07 Oct 2021 10:57:01 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3; 
 Thu, 7 Oct 2021 10:57:00 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 7 Oct 2021 10:56:58 +0800
Message-ID: <7703076927822fc31d1af37f8fd3bfe5e0513d29.camel@mediatek.com>
Subject: Re: [PATCH v8 09/12] media: mtk-vcodec: Get rid of
 mtk_smi_larb_get/put
From: Yong Wu <yong.wu@mediatek.com>
To: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>, Matthias Brugger
 <matthias.bgg@gmail.com>, Joerg Roedel <joro@8bytes.org>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski@canonical.com>, David Airlie <airlied@linux.ie>, "Mauro
 Carvalho Chehab" <mchehab@kernel.org>
Date: Thu, 7 Oct 2021 10:57:01 +0800
In-Reply-To: <f9829a5a-984c-bced-0286-53f9edc8ae3d@collabora.com>
References: <20210929013719.25120-1-yong.wu@mediatek.com>
 <20210929013719.25120-10-yong.wu@mediatek.com>
 <02f444d5-9633-3f9c-2d1f-97ce073d1180@collabora.com>
 <79cbf64491273797f218f417234b8c95936bd3b1.camel@mediatek.com>
 <f9829a5a-984c-bced-0286-53f9edc8ae3d@collabora.com>
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

On Thu, 2021-09-30 at 12:57 +0200, Dafna Hirschfeld wrote:
> 
> On 30.09.21 05:28, Yong Wu wrote:
> > Hi Dafna,
> > 
> > Thanks very much for the review.
> > 
> > On Wed, 2021-09-29 at 14:13 +0200, Dafna Hirschfeld wrote:
> > > 
> > > On 29.09.21 03:37, Yong Wu wrote:
> > > > MediaTek IOMMU has already added the device_link between the
> > > > consumer
> > > > and smi-larb device. If the vcodec device call the
> > > > pm_runtime_get_sync,
> > > > the smi-larb's pm_runtime_get_sync also be called
> > > > automatically.
> > > > 
> > > > CC: Tiffany Lin <tiffany.lin@mediatek.com>
> > > > CC: Irui Wang <irui.wang@mediatek.com>
> > > > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > > > Reviewed-by: Evan Green <evgreen@chromium.org>
> > > > Acked-by: Tiffany Lin <tiffany.lin@mediatek.com>
> > > > Reviewed-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
> > > > ---
> > > >    .../platform/mtk-vcodec/mtk_vcodec_dec_pm.c   | 37 +++----
> > > > -------
> > > > --
> > > >    .../platform/mtk-vcodec/mtk_vcodec_drv.h      |  3 --
> > > >    .../platform/mtk-vcodec/mtk_vcodec_enc.c      |  1 -
> > > >    .../platform/mtk-vcodec/mtk_vcodec_enc_pm.c   | 44 +++----
> > > > -------

[snip]

> > > >    void mtk_vcodec_release_dec_pm(struct mtk_vcodec_dev *dev)
> > > >    {
> > > >    	pm_runtime_disable(dev->pm.dev);
> > > > -	put_device(dev->pm.larbvdec);
> > > >    }
> > > 
> > > Now that functions only do  'pm_runtime_disable(dev->pm.dev);' so
> > > it
> > > will be more
> > > readable to remove the function mtk_vcodec_release_dec_pm
> > > and replace with pm_runtime_disable(dev->pm.dev);
> > > Same for the 'enc' equivalent.
> > 
> > Make sense. But It may be not proper if using pm_runtime_disable
> > as the symmetry with mtk_vcodec_init_dec_pm in the
> > mtk_vcodec_probe.
> > 
> > Maybe we should move pm_runtime_enable out from
> > mtk_vcodec_init_dec_pm
> > into mtk_vcodec_probe. I could do a new patch for this. Is this ok
> > for
> > you?
> 
> yes, there is also asymettry when calling pm_runtime* in general,
> I see in the decoder it is called from mtk_vcodec_dec_pm.c
> but in the encoder it is called from mtk_vcodec_enc.c,
> 
> I think all calls to pm_runtime* should be out of the *_pm.c files

OK. I will try this.

> since for example 'mtk_vcodec_dec_pw_on' also do just one call to
> pm_runtime_resume_and_get so this function can also be removed.

I guess this one should be reserved to vcodec guys. I see this function
is changed at [1]. Let's keep this patchset clean.

[1] 
https://patchwork.kernel.org/project/linux-mediatek/patch/20210901083215.25984-10-yunfei.dong@mediatek.com/

> 
> thanks,
> Dafna
> 
> > 
> > > 
> > > Thanks,
> > > Dafna
> > 
> > [snip]
> > _______________________________________________
> > Linux-mediatek mailing list
> > Linux-mediatek@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-mediatek
> > 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
