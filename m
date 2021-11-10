Return-Path: <SRS0=V2Kg=P5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B57C3C433F5
	for <iommu@archiver.kernel.org>; Wed, 10 Nov 2021 02:20:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6323F610A2
	for <iommu@archiver.kernel.org>; Wed, 10 Nov 2021 02:20:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6323F610A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1E561403E0;
	Wed, 10 Nov 2021 02:20:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id B46wcAYVOTzu; Wed, 10 Nov 2021 02:20:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8CB1E40114;
	Wed, 10 Nov 2021 02:20:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5C5CBC0012;
	Wed, 10 Nov 2021 02:20:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7B081C000E
 for <iommu@lists.linux-foundation.org>; Wed, 10 Nov 2021 02:20:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 70DEE4044C
 for <iommu@lists.linux-foundation.org>; Wed, 10 Nov 2021 02:20:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=mediatek.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id H_mPRDFloWhz for <iommu@lists.linux-foundation.org>;
 Wed, 10 Nov 2021 02:20:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2653C40448
 for <iommu@lists.linux-foundation.org>; Wed, 10 Nov 2021 02:20:39 +0000 (UTC)
X-UUID: 856a6dbc4c6341eca4ca1e898b447dc0-20211110
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=h6o8crzH0QQXPSjg4BmL9i5l114/7v3dfLGSUMXg6lQ=; 
 b=pu1+LqOeJ5IzE1w+yl088gqqRaOXP3f1DjYslC7BeDPQLvV02UHhhWX3FbEr7CzoXmGI43dLpsXURFoD1IDGNJ6RqruW9vUOlSpnkzvCNKO/RoBDtqkEy74B5vLQFaXSDCnNh4pnaBxZzWAjFrLR9eVJADb3igUhQPtjAJKAbm8=;
X-UUID: 856a6dbc4c6341eca4ca1e898b447dc0-20211110
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by
 mailgw02.mediatek.com (envelope-from <yong.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 1352684706; Wed, 10 Nov 2021 10:20:35 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3; 
 Wed, 10 Nov 2021 10:20:33 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkmbs10n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Wed, 10 Nov 2021 10:20:32 +0800
Message-ID: <5c4dd67ae7c81721d8cfd2c3b23b7c6df493cb5a.camel@mediatek.com>
Subject: Re: [PATCH v3 12/33] iommu/mediatek: Always tlb_flush_all when each
 PM resume
From: Yong Wu <yong.wu@mediatek.com>
To: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>, Joerg Roedel
 <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Will Deacon <will@kernel.org>, Robin Murphy
 <robin.murphy@arm.com>
Date: Wed, 10 Nov 2021 10:20:32 +0800
In-Reply-To: <c4be1a14-c257-81b7-4a2b-f7e68c32de88@collabora.com>
References: <20210923115840.17813-1-yong.wu@mediatek.com>
 <20210923115840.17813-13-yong.wu@mediatek.com>
 <c4be1a14-c257-81b7-4a2b-f7e68c32de88@collabora.com>
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK: N
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 srv_heupstream@mediatek.com,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>, anan.sun@mediatek.com,
 yen-chang.chen@mediatek.com, Fabien Parent <fparent@baylibre.com>,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 Hsin-Yi Wang <hsinyi@chromium.org>, Collabora Kernel
 ML <kernel@collabora.com>, sebastian.reichel@collabora.com,
 linux-arm-kernel@lists.infradead.org, AngeloGioacchino Del
 Regno <angelogioacchino.delregno@collabora.com>
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

On Tue, 2021-11-09 at 14:21 +0200, Dafna Hirschfeld wrote:
> Hi
> This patch is needed in order to update the tlb when a device is
> powered on.
> Could you send this patch alone without the whole series so it get
> accepted easier?

Which SoC are you testing on? In previous SoC, the IOMMU HW don't have
power-domain, and we have a "has_pm"[1] in the tlb function for that
case. The "has_pm" should be always 0 for the previous SoC like mt8173,
it should always tlb synchronize.

thus, Could you help share more about your issue? In which case it lack
the necessary tlb operation. At least, We need confirm if it needs a
"Fixes" tags if sending this patch alone.

Thanks.

[1] 
https://elixir.bootlin.com/linux/v5.15/source/drivers/iommu/mtk_iommu.c#L236

> I can resend the patch on your behalf if you want.
> 
> Thanks,
> Dafna
> 
> On 23.09.21 14:58, Yong Wu wrote:
> > Prepare for 2 HWs that sharing pgtable in different power-domains.
> > 
> > When there are 2 M4U HWs, it may has problem in the flush_range in
> > which
> > we get the pm_status via the m4u dev, BUT that function don't
> > reflect the
> > real power-domain status of the HW since there may be other HW also
> > use
> > that power-domain.
> > 
> > The function dma_alloc_attrs help allocate the iommu buffer which
> > need the corresponding power domain since tlb flush is needed when
> > preparing iova. BUT this function only is for allocating buffer,
> > we have no good reason to request the user always call
> > pm_runtime_get
> > before calling dma_alloc_xxx. Therefore, we add a tlb_flush_all
> > in the pm_runtime_resume to make sure the tlb always is clean.
> > 
> > Another solution is always call pm_runtime_get in the
> > tlb_flush_range.
> > This will trigger pm runtime resume/backup so often when the iommu
> > power is not active at some time(means user don't call
> > pm_runtime_get
> > before calling dma_alloc_xxx), This may cause the performance drop.
> > thus we don't use this.
> > 
> > In other case, the iommu's power should always be active via device
> > link with smi.
> > 
> > The previous SoC don't have PM except mt8192. the mt8192 IOMMU is
> > display's
> > power-domain which nearly always is enabled. thus no need fix tags
> > here.
> > Prepare for mt8195.
> > 
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> >   drivers/iommu/mtk_iommu.c | 11 +++++++++++
> >   1 file changed, 11 insertions(+)
> > 
> > diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> > index 44cf5547d084..e9e94944ed91 100644
> > --- a/drivers/iommu/mtk_iommu.c
> > +++ b/drivers/iommu/mtk_iommu.c
> > @@ -984,6 +984,17 @@ static int __maybe_unused
> > mtk_iommu_runtime_resume(struct device *dev)
> >   		return ret;
> >   	}
> >   
> > +	/*
> > +	 * Users may allocate dma buffer before they call
> > pm_runtime_get, then
> > +	 * it will lack the necessary tlb flush.
> > +	 *
> > +	 * We have no good reason to request the users always call
> > dma_alloc_xx
> > +	 * after pm_runtime_get_sync.
> > +	 *
> > +	 * Thus, Make sure the tlb always is clean after each PM
> > resume.
> > +	 */
> > +	mtk_iommu_tlb_do_flush_all(data);
> > +
> >   	/*
> >   	 * Uppon first resume, only enable the clk and return, since
> > the values of the
> >   	 * registers are not yet set.
> > 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
