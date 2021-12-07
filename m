Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C29AC433EF
	for <iommu@archiver.kernel.org>; Tue,  7 Dec 2021 06:24:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D2AF58248F;
	Tue,  7 Dec 2021 06:24:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JxeQ1OlUSrE2; Tue,  7 Dec 2021 06:24:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B1CFB81CDC;
	Tue,  7 Dec 2021 06:24:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 78B97C001E;
	Tue,  7 Dec 2021 06:24:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B940DC0012
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 06:24:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A7DAC823E2
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 06:24:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id c-kk7AHLHFDc for <iommu@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 06:24:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1DD6F81CDC
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 06:24:17 +0000 (UTC)
X-UUID: 5b912bf4d72b42b99a20f911787d68db-20211207
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=69qaWgeCtoVl4LXqKx5dxuVaxCCi/f31QLGTc1pclR4=; 
 b=bh+PSfggMCrFYUQ7aMLMZc15Or4sTaulKL1h3Qh8Wt3CQGEMuch3SpQMM0vqfcFLIZ/ndKQZifD4THRj79MXMrZadgyXth5dMu+xYCCCDta4ZD40bBuD/zTKmnXcbrIBL3u7lgJ1OTKfwgyi9lbFe5+SRtWVq49UkmKcWEBhneg=;
X-UUID: 5b912bf4d72b42b99a20f911787d68db-20211207
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by
 mailgw02.mediatek.com (envelope-from <yong.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 281838797; Tue, 07 Dec 2021 14:24:13 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Tue, 7 Dec 2021 14:24:12 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 7 Dec 2021 14:24:11 +0800
Message-ID: <ebc8e4c0b0519043c5a82c6c967ac6d524e8869a.camel@mediatek.com>
Subject: Re: [PATCH 3/4] memory: mtk-smi: Add sleep ctrl function
From: Yong Wu <yong.wu@mediatek.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Date: Tue, 7 Dec 2021 14:24:07 +0800
In-Reply-To: <f2ffd08a-44c3-9458-1bd8-68e3c0755611@collabora.com>
References: <20211203064027.14993-1-yong.wu@mediatek.com>
 <20211203064027.14993-4-yong.wu@mediatek.com>
 <f2ffd08a-44c3-9458-1bd8-68e3c0755611@collabora.com>
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK: N
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org, yi.kuo@mediatek.com,
 srv_heupstream@mediatek.com, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, lc.kan@mediatek.com, Matthias
 Brugger <matthias.bgg@gmail.com>, anthony.huang@mediatek.com,
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

Hi AngeloGioacchino,

Thanks for your review.

On Mon, 2021-12-06 at 16:08 +0100, AngeloGioacchino Del Regno wrote:
> Il 03/12/21 07:40, Yong Wu ha scritto:
> > sleep control means that when the larb go to sleep, we should wait
> > a bit
> > until all the current commands are finished. thus, when the larb
> > runtime
> > suspend, we need enable this function to wait until all the existed
> > command are finished. when the larb resume, just disable this
> > function.
> > This function only improve the safe of bus. Add a new flag for this
> > function. Prepare for mt8186.
> > 
> > Signed-off-by: Anan Sun <anan.sun@mediatek.com>
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> >   drivers/memory/mtk-smi.c | 39
> > +++++++++++++++++++++++++++++++++++----
> >   1 file changed, 35 insertions(+), 4 deletions(-)

[snip]

> >   static int __maybe_unused mtk_smi_larb_suspend(struct device
> > *dev)
> >   {
> >   	struct mtk_smi_larb *larb = dev_get_drvdata(dev);
> > +	int ret = 0;
> > +
> > +	if (MTK_SMI_CAPS(larb->larb_gen->flags_general,
> > MTK_SMI_FLAG_SLEEP_CTL))
> > +		ret = mtk_smi_larb_sleep_ctrl(dev, true);
> 
> Sorry but what happens if SLP_PROT_RDY is not getting set properly?
>  From what I can understand in the commit description that you wrote,
> if we reach
> the timeout, then the LARB transactions are not over....
> 
> I see that you are indeed returning a failure here, but you are also
> turning off
> the clocks regardless of whether we get a failure or a success; I'm
> not sure that
> this is right, as this may leave the hardware in an unpredictable
> state (since
> there were some more LARB transactions that didn't go through),
> leading to crashes
> at system resume (or when retyring to suspend).

Thanks for this question. In theory you are right. In this case, the
bus already hang.

We only printed a fail log in this patch. If this fail happens, we
should request the master to check which case cause the larb hang.

If the master has a good reason or limitation, the hang is expected, I
think we have to add larb reset in this fail case: Reset the larb when
the larb runtime resume.

Fortunately, we have never got this issue. We could add this reset when
necessary. Is this OK for you?

Thanks.

> 
> >   
> >   	clk_bulk_disable_unprepare(larb->smi.clk_num, larb->smi.clks);
> > -	return 0;
> > +	return ret;
> >   }
> >   
> >   static const struct dev_pm_ops smi_larb_pm_ops = {
> > 
> 
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
