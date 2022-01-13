Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 539AFC433FE
	for <iommu@archiver.kernel.org>; Thu, 13 Jan 2022 06:06:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0F3FC84BF5;
	Thu, 13 Jan 2022 06:06:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ngjgrOhUM2ux; Thu, 13 Jan 2022 06:06:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E9A4384BF3;
	Thu, 13 Jan 2022 06:06:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D04CCC0030;
	Thu, 13 Jan 2022 06:06:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 92140C001E
 for <iommu@lists.linux-foundation.org>; Thu, 13 Jan 2022 06:06:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7FFE741615
 for <iommu@lists.linux-foundation.org>; Thu, 13 Jan 2022 06:06:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AtMVS6_jU6Dc for <iommu@lists.linux-foundation.org>;
 Thu, 13 Jan 2022 06:06:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1D967415F1
 for <iommu@lists.linux-foundation.org>; Thu, 13 Jan 2022 06:06:06 +0000 (UTC)
X-UUID: ccfd07641bb4491a9d856d3e5b2f3b67-20220113
X-UUID: ccfd07641bb4491a9d856d3e5b2f3b67-20220113
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 1129358751; Thu, 13 Jan 2022 14:06:02 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 13 Jan 2022 14:06:01 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 13 Jan 2022 14:05:59 +0800
Message-ID: <18d7e049adc69f4b7f0ecfdf8520a02bd6e17149.camel@mediatek.com>
Subject: Re: [PATCH v2 4/6] memory: mtk-smi: Fix the return value for
 clk_bulk_prepare_enable
From: Yong Wu <yong.wu@mediatek.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Date: Thu, 13 Jan 2022 14:05:59 +0800
In-Reply-To: <00efa277-6475-4f20-f045-443a0706e9e2@collabora.com>
References: <20220111063904.7583-1-yong.wu@mediatek.com>
 <20220111063904.7583-5-yong.wu@mediatek.com>
 <00efa277-6475-4f20-f045-443a0706e9e2@collabora.com>
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK: N
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org, yi.kuo@mediatek.com,
 srv_heupstream@mediatek.com, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, lc.kan@mediatek.com,
 Matthias Brugger <matthias.bgg@gmail.com>, anthony.huang@mediatek.com,
 anan.sun@mediatek.com, Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel@lists.infradead.org
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

On Tue, 2022-01-11 at 10:10 +0100, AngeloGioacchino Del Regno wrote:
> Il 11/01/22 07:39, Yong Wu ha scritto:
> > The successful return value for clk_bulk_prepare_enable is 0,
> > rather than
> > "< 0". Fix this.
> > 
> 
> Hello! Thanks for this commit!
> However, there are a few comments...
> 
> This description is a bit confusing, please reword it, something
> like...
> 
> "Function clk_bulk_prepare_enable() returns 0 for success or a
> negative
> number for error. Fix this code style issue."

Thanks for your quickly reviewing.

I will use this in next version and remove the "Fixes" tag.

> 
> In any case, you're not fixing any bad logic issue here, as the
> function
> will never return anything > 0.
> 
> What you're fixing is a common pattern usage issue, so the Fixes tag
> can be
> removed since it's not really useful to schedule this commit for
> backport
> over older stable versions.
> 
> 
> After the requested changes:
> 
> Reviewed-by: AngeloGioacchino Del Regno <
> angelogioacchino.delregno@collabora.com>
> 
> > Fixes: 0e14917c57f9 ("memory: mtk-smi: Use clk_bulk clock ops")
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> >   drivers/memory/mtk-smi.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
> > index b883dcc0bbfa..e7b1a22b12ea 100644
> > --- a/drivers/memory/mtk-smi.c
> > +++ b/drivers/memory/mtk-smi.c
> > @@ -480,7 +480,7 @@ static int __maybe_unused
> > mtk_smi_larb_resume(struct device *dev)
> >   	int ret;
> >   
> >   	ret = clk_bulk_prepare_enable(larb->smi.clk_num, larb-
> > >smi.clks);
> > -	if (ret < 0)
> > +	if (ret)
> >   		return ret;
> >   
> >   	/* Configure the basic setting for this larb */
> > 
> 
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
