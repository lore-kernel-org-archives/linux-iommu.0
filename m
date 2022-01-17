Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AC10C433F5
	for <iommu@archiver.kernel.org>; Mon, 17 Jan 2022 12:25:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1163B606B0;
	Mon, 17 Jan 2022 12:25:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9tkdTsAKKPD0; Mon, 17 Jan 2022 12:25:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id EE9B860A8B;
	Mon, 17 Jan 2022 12:25:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B8E74C0031;
	Mon, 17 Jan 2022 12:25:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 87B2AC002F
 for <iommu@lists.linux-foundation.org>; Mon, 17 Jan 2022 12:25:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7539860A8B
 for <iommu@lists.linux-foundation.org>; Mon, 17 Jan 2022 12:25:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Fx5KrMiqd7J9 for <iommu@lists.linux-foundation.org>;
 Mon, 17 Jan 2022 12:25:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 97E3E606B0
 for <iommu@lists.linux-foundation.org>; Mon, 17 Jan 2022 12:25:36 +0000 (UTC)
X-UUID: 0984eb39b4094fda8f758cd6e9dcc5da-20220117
X-UUID: 0984eb39b4094fda8f758cd6e9dcc5da-20220117
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 728321395; Mon, 17 Jan 2022 20:25:31 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3; 
 Mon, 17 Jan 2022 20:25:30 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 17 Jan 2022 20:25:29 +0800
Message-ID: <792f1119b9c848a01e8b8ddd196a1db7acc1f0ae.camel@mediatek.com>
Subject: Re: [PATCH v3 5/7] memory: mtk-smi: Fix the return value for
 clk_bulk_prepare_enable
From: Yong Wu <yong.wu@mediatek.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Date: Mon, 17 Jan 2022 20:25:28 +0800
In-Reply-To: <7370f18b-e273-69f2-1cc9-a42495e04874@canonical.com>
References: <20220113111057.29918-1-yong.wu@mediatek.com>
 <20220113111057.29918-6-yong.wu@mediatek.com>
 <7370f18b-e273-69f2-1cc9-a42495e04874@canonical.com>
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK: N
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org, yi.kuo@mediatek.com,
 Joerg Roedel <jroedel@suse.de>, srv_heupstream@mediatek.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 lc.kan@mediatek.com, Matthias Brugger <matthias.bgg@gmail.com>,
 anthony.huang@mediatek.com, anan.sun@mediatek.com,
 linux-arm-kernel@lists.infradead.org,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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

On Mon, 2022-01-17 at 13:01 +0100, Krzysztof Kozlowski wrote:
> On 13/01/2022 12:10, Yong Wu wrote:
> > Function clk_bulk_prepare_enable() returns 0 for success or a
> > negative
> > number for error. Fix this code style issue.
> 
> The message does not really make sense. If negative is returned, then
> the check (ret < 0) was correct.
> 
> I guess you wanted to say that common code style is to check for any
> non-zero return value, just like it's implementation in clk.h does.
> 
> I'll adjust the commit msg when applying.

Thanks for the help.

> 
> > 
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > Reviewed-by: AngeloGioacchino Del Regno <
> > angelogioacchino.delregno@collabora.com>
> > ---
> >  drivers/memory/mtk-smi.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
> > index b883dcc0bbfa..e7b1a22b12ea 100644
> > --- a/drivers/memory/mtk-smi.c
> > +++ b/drivers/memory/mtk-smi.c
> > @@ -480,7 +480,7 @@ static int __maybe_unused
> > mtk_smi_larb_resume(struct device *dev)
> >  	int ret;
> >  
> >  	ret = clk_bulk_prepare_enable(larb->smi.clk_num, larb-
> > >smi.clks);
> > -	if (ret < 0)
> > +	if (ret)
> >  		return ret;
> >  
> >  	/* Configure the basic setting for this larb */
> 
> Best regards,
> Krzysztof

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
