Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 961D8C433F5
	for <iommu@archiver.kernel.org>; Fri, 28 Jan 2022 12:59:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3ED4C81B70;
	Fri, 28 Jan 2022 12:59:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Qj_2WvgVE1mS; Fri, 28 Jan 2022 12:59:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1714C81B9D;
	Fri, 28 Jan 2022 12:59:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8B99FC0070;
	Fri, 28 Jan 2022 12:59:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7920AC000B
 for <iommu@lists.linux-foundation.org>; Fri, 28 Jan 2022 12:45:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 557D160B6A
 for <iommu@lists.linux-foundation.org>; Fri, 28 Jan 2022 12:45:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WY4p-S2F2afY for <iommu@lists.linux-foundation.org>;
 Fri, 28 Jan 2022 12:45:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 39EC6600D1
 for <iommu@lists.linux-foundation.org>; Fri, 28 Jan 2022 12:45:53 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 95B1DB8258F;
 Fri, 28 Jan 2022 12:45:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1C11C340E0;
 Fri, 28 Jan 2022 12:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1643373950;
 bh=vMCWcrlcdbFbw6ZhRTSMH5G249xb37QrpyMQTC2Ih8s=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=OApe1TM9xyUHQMFD6k9FG6o9kh88o2dbdqSEGbm5wq5/qqM5JnhJFTZNaAG/OoevL
 B51+tarWCZpS/wrJc4n3EK/qeZAo3/0q9InRVDCRcQ46ZibrXrySDoUS0iX5VAZGJZ
 2SsMMvYDp37uKklaalMXs5QbfHBQfyTMoGG8HKvXokzoAcJsvCgN5Z1HLStrtn247A
 5HaAnpPSZTEmO5ns0li5yaHEsQGLBmQQXlrjvPPA0OMa3/YGNqdv0h5BkoeZN+lXfA
 0pkwmUhRjmbZWykw/ud+qo2GpbNlQlgEK21LfFKtmDGmCoXpjbJ/Iv1rcHug0GcZcL
 wEOxCHwsY/dPg==
Date: Fri, 28 Jan 2022 13:45:40 +0100
From: Mauro Carvalho Chehab <mchehab@kernel.org>
To: Yong Wu <yong.wu@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v10 02/13] iommu/mediatek-v1: Free the existed fwspec if
 the master dev already has
Message-ID: <20220128134540.00c6c380@coco.lan>
In-Reply-To: <20220128134055.720bb43c@coco.lan>
References: <20220117070510.17642-1-yong.wu@mediatek.com>
 <20220117070510.17642-3-yong.wu@mediatek.com>
 <20220128134055.720bb43c@coco.lan>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 28 Jan 2022 12:59:34 +0000
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>, David Airlie <airlied@linux.ie>,
 Will Deacon <will.deacon@arm.com>, dri-devel@lists.freedesktop.org,
 yf.wang@mediatek.com, Hans Verkuil <hverkuil@xs4all.nl>,
 anthony.huang@mediatek.com,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 Evan Green <evgreen@chromium.org>, Eizan Miyamoto <eizan@chromium.org>,
 Matthias Kaehlcke <mka@chromium.org>, mingyuan.ma@mediatek.com,
 linux-media@vger.kernel.org, devicetree@vger.kernel.org,
 Joerg Roedel <jroedel@suse.de>, Philipp Zabel <p.zabel@pengutronix.de>,
 Frank Wunderlich <frank-w@public-files.de>, libo.kang@mediatek.com,
 yi.kuo@mediatek.com, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, Hsin-Yi Wang <hsinyi@chromium.org>,
 Tiffany Lin <tiffany.lin@mediatek.com>, linux-arm-kernel@lists.infradead.org,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Em Fri, 28 Jan 2022 13:40:55 +0100
Mauro Carvalho Chehab <mchehab@kernel.org> escreveu:

> Hi Matthias/Yong,
> 
> Are you ok if this patch gets merged via the media tree together with the
> remaining series, or do you prefer to apply it via SoC tree instead?

Same questions for other patches touching files outside drivers/media
on this pull request:

	https://patchwork.kernel.org/project/linux-mediatek/patch/7af52d61-47c7-581d-62ed-76a7f8315b16@xs4all.nl/

Like those:
	0004-0013-iommu-mediatek-v1-Free-the-existed-fwspec-if-the-mas.patch
	0005-0013-iommu-mediatek-Return-ENODEV-if-the-device-is-NULL.patch
	0006-0013-iommu-mediatek-Add-probe_defer-for-smi-larb.patch
	0007-0013-iommu-mediatek-Add-device_link-between-the-consumer-.patch

Regards,
Mauro

> 
> Regards,
> Mauro
> 
> 
> Em Mon, 17 Jan 2022 15:04:59 +0800
> Yong Wu <yong.wu@mediatek.com> escreveu:
> 
> > When the iommu master device enters of_iommu_xlate, the ops may be
> > NULL(iommu dev is defered), then it will initialize the fwspec here:
> > 
> > [<c0c9c5bc>] (dev_iommu_fwspec_set) from [<c06bda80>]
> > (iommu_fwspec_init+0xbc/0xd4)
> > [<c06bd9c4>] (iommu_fwspec_init) from [<c06c0db4>]
> > (of_iommu_xlate+0x7c/0x12c)
> > [<c06c0d38>] (of_iommu_xlate) from [<c06c10e8>]
> > (of_iommu_configure+0x144/0x1e8)
> > 
> > BUT the mtk_iommu_v1.c only supports arm32, the probing flow still is a bit
> > weird. We always expect create the fwspec internally. otherwise it will
> > enter here and return fail.
> > 
> > static int mtk_iommu_create_mapping(struct device *dev,
> > 				    struct of_phandle_args *args)
> > {
> >         ...
> > 	if (!fwspec) {
> > 	        ....
> > 	} else if (dev_iommu_fwspec_get(dev)->ops != &mtk_iommu_ops) {  
> >                 >>>>>>>>>>Enter here. return fail.<<<<<<<<<<<<    
> > 		return -EINVAL;
> > 	}
> > 	...
> > }
> > 
> > Thus, Free the existed fwspec if the master device already has fwspec.
> > 
> > This issue is reported at:
> > https://lore.kernel.org/linux-mediatek/trinity-7d9ebdc9-4849-4d93-bfb5-429dcb4ee449-1626253158870@3c-app-gmx-bs01/
> > 
> > Reported-by: Frank Wunderlich <frank-w@public-files.de>
> > Tested-by: Frank Wunderlich <frank-w@public-files.de> # BPI-R2/MT7623
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > Acked-by: Joerg Roedel <jroedel@suse.de>
> > Acked-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> > ---
> >  drivers/iommu/mtk_iommu_v1.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
> > index be22fcf988ce..1467ba1e4417 100644
> > --- a/drivers/iommu/mtk_iommu_v1.c
> > +++ b/drivers/iommu/mtk_iommu_v1.c
> > @@ -425,6 +425,15 @@ static struct iommu_device *mtk_iommu_probe_device(struct device *dev)
> >  	struct mtk_iommu_data *data;
> >  	int err, idx = 0;
> >  
> > +	/*
> > +	 * In the deferred case, free the existed fwspec.
> > +	 * Always initialize the fwspec internally.
> > +	 */
> > +	if (fwspec) {
> > +		iommu_fwspec_free(dev);
> > +		fwspec = dev_iommu_fwspec_get(dev);
> > +	}
> > +
> >  	while (!of_parse_phandle_with_args(dev->of_node, "iommus",
> >  					   "#iommu-cells",
> >  					   idx, &iommu_spec)) {  
> 
> 
> 
> Thanks,
> Mauro



Thanks,
Mauro
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
