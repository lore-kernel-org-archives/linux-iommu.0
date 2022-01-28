Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58F1CC433F5
	for <iommu@archiver.kernel.org>; Fri, 28 Jan 2022 09:39:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 006CA40383;
	Fri, 28 Jan 2022 09:39:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0TiR5x9qA7eJ; Fri, 28 Jan 2022 09:39:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9396240167;
	Fri, 28 Jan 2022 09:39:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 66F76C0011;
	Fri, 28 Jan 2022 09:39:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3E4C8C000B
 for <iommu@lists.linux-foundation.org>; Fri, 28 Jan 2022 09:39:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 251AB4099A
 for <iommu@lists.linux-foundation.org>; Fri, 28 Jan 2022 09:39:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7oES_24GpPeT for <iommu@lists.linux-foundation.org>;
 Fri, 28 Jan 2022 09:39:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5B9E8409B2
 for <iommu@lists.linux-foundation.org>; Fri, 28 Jan 2022 09:39:14 +0000 (UTC)
X-UUID: e9dc301affb34158a208a53be4e13ed2-20220128
X-UUID: e9dc301affb34158a208a53be4e13ed2-20220128
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 506976823; Fri, 28 Jan 2022 17:39:09 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 28 Jan 2022 17:39:08 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 28 Jan 2022 17:39:07 +0800
Message-ID: <01cc69cdf7773962140c01fe37b12ab2c9491c25.camel@mediatek.com>
Subject: Re: [PATCH 2/2] iommu/mediatek: Add mt8186 iommu support
From: Yong Wu <yong.wu@mediatek.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Date: Fri, 28 Jan 2022 17:39:06 +0800
In-Reply-To: <b52a1df8-58f4-baa2-cfb6-9c56244caa0f@collabora.com>
References: <20220125093244.18230-1-yong.wu@mediatek.com>
 <20220125093244.18230-3-yong.wu@mediatek.com>
 <b52a1df8-58f4-baa2-cfb6-9c56244caa0f@collabora.com>
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK: N
Cc: yf.wang@mediatek.com, yen-chang.chen@mediatek.com,
 Will Deacon <will@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 xueqi.zhang@mediatek.com, mingyuan.ma@mediatek.com, devicetree@vger.kernel.org,
 chengci.xu@mediatek.com, libo.kang@mediatek.com,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 Hsin-Yi Wang <hsinyi@chromium.org>, Matthias
 Brugger <matthias.bgg@gmail.com>, linux-arm-kernel@lists.infradead.org,
 anan.sun@mediatek.com, srv_heupstream@mediatek.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
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

On Thu, 2022-01-27 at 12:28 +0100, AngeloGioacchino Del Regno wrote:
> Il 25/01/22 10:32, Yong Wu ha scritto:
> > Add mt8186 iommu supports.
> > 
> > Signed-off-by: Anan Sun <anan.sun@mediatek.com>
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> >   drivers/iommu/mtk_iommu.c | 17 +++++++++++++++++
> >   1 file changed, 17 insertions(+)

[snip]

> >   static const struct mtk_iommu_plat_data mt8192_data = {
> >   	.m4u_plat       = M4U_MT8192,
> >   	.flags          = HAS_BCLK | HAS_SUB_COMM_2BITS |
> > OUT_ORDER_WR_EN |
> > @@ -1470,6 +1486,7 @@ static const struct of_device_id
> > mtk_iommu_of_ids[] = {
> >   	{ .compatible = "mediatek,mt8167-m4u", .data = &mt8167_data},
> >   	{ .compatible = "mediatek,mt8173-m4u", .data = &mt8173_data},
> >   	{ .compatible = "mediatek,mt8183-m4u", .data = &mt8183_data},
> > +	{ .compatible = "mediatek,mt8186-iommu-mm", .data =
> > &mt8186_data_mm},
> 
> Hello!
> 
> Is there any particular reason why this compatible is not
> "mediatek,mt8186-m4u"?

There is no special reason. In the previous SoC, We only support MM
IOMMU, it was called by "m4u". In the lastest SoC, We have the other
types IOMMU, like for INFRA masters and APU, thus they are called "mm
iommu", "infra iommu" and "apu iommu". Of course, "m4u" means "mm
iommu".

> 
> Thanks,
> Angelo
> 
> >   	{ .compatible = "mediatek,mt8192-m4u", .data = &mt8192_data},
> >   	{ .compatible = "mediatek,mt8195-iommu-infra", .data =
> > &mt8195_data_infra},
> >   	{ .compatible = "mediatek,mt8195-iommu-vdo",   .data =
> > &mt8195_data_vdo},
> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
