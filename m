Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C992C433F5
	for <iommu@archiver.kernel.org>; Mon, 10 Jan 2022 10:59:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 09F856009C;
	Mon, 10 Jan 2022 10:59:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RyE03hy2-HC9; Mon, 10 Jan 2022 10:59:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C6DC06058C;
	Mon, 10 Jan 2022 10:59:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A052DC0030;
	Mon, 10 Jan 2022 10:59:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7D825C001E
 for <iommu@lists.linux-foundation.org>; Mon, 10 Jan 2022 10:59:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6871240396
 for <iommu@lists.linux-foundation.org>; Mon, 10 Jan 2022 10:59:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9BuLo4Mt3dxv for <iommu@lists.linux-foundation.org>;
 Mon, 10 Jan 2022 10:59:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3AD84401F2
 for <iommu@lists.linux-foundation.org>; Mon, 10 Jan 2022 10:59:49 +0000 (UTC)
X-UUID: 395cc667b0e14575be2c58eb00d5c3b4-20220110
X-UUID: 395cc667b0e14575be2c58eb00d5c3b4-20220110
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 1957887219; Mon, 10 Jan 2022 18:59:44 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3; 
 Mon, 10 Jan 2022 18:59:43 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 10 Jan 2022 18:59:42 +0800
Message-ID: <83400d36640fc6256972041c882d080ce9aa5fdd.camel@mediatek.com>
Subject: Re: [PATCH v3 09/33] iommu/mediatek: Remove for_each_m4u in
 tlb_sync_all
From: Yong Wu <yong.wu@mediatek.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Date: Mon, 10 Jan 2022 18:59:42 +0800
In-Reply-To: <85987e9a-dfb0-c241-1dde-43c050a78b51@collabora.com>
References: <20210923115840.17813-1-yong.wu@mediatek.com>
 <20210923115840.17813-10-yong.wu@mediatek.com>
 <bfa33e94-c2e5-5dab-c9af-b674e1669daa@collabora.com>
 <22faee018a36a49e4a507b69d087432c8cd689ec.camel@mediatek.com>
 <85987e9a-dfb0-c241-1dde-43c050a78b51@collabora.com>
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK: N
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 srv_heupstream@mediatek.com,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
 yen-chang.chen@mediatek.com, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 Hsin-Yi Wang <hsinyi@chromium.org>, Matthias Brugger <matthias.bgg@gmail.com>,
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

On Mon, 2022-01-10 at 10:16 +0100, AngeloGioacchino Del Regno wrote:
> Il 09/01/22 03:48, Yong Wu ha scritto:
> > On Tue, 2022-01-04 at 16:55 +0100, AngeloGioacchino Del Regno
> > wrote:
> > > Il 23/09/21 13:58, Yong Wu ha scritto:
> > > > The tlb_sync_all is called from these three functions:
> > > > a) flush_iotlb_all: it will be called for each a iommu HW.
> > > > b) tlb_flush_range_sync: it already has for_each_m4u.
> > > > c) in irq: When IOMMU HW translation fault, Only need flush
> > > > itself.
> > > > 
> > > > Thus, No need for_each_m4u in this tlb_sync_all. Remove it.
> > > > 
> > > > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > > > ---
> > > >    drivers/iommu/mtk_iommu.c | 18 +++++++-----------
> > > >    1 file changed, 7 insertions(+), 11 deletions(-)
> > > > 
> > > > diff --git a/drivers/iommu/mtk_iommu.c
> > > > b/drivers/iommu/mtk_iommu.c
> > > > index 6f4f6624e3ac..0b4c30baa864 100644
> > > > --- a/drivers/iommu/mtk_iommu.c
> > > > +++ b/drivers/iommu/mtk_iommu.c
> > > > @@ -206,19 +206,15 @@ static struct mtk_iommu_domain
> > > > *to_mtk_domain(struct iommu_domain *dom)
> > > >    
> > > >    static void mtk_iommu_tlb_flush_all(struct mtk_iommu_data
> > > > *data)
> > > >    {
> > > > -	struct list_head *head = data->hw_list;
> > > > -
> > > > -	for_each_m4u(data, head) {
> > > > -		if (pm_runtime_get_if_in_use(data->dev) <= 0)
> > > > -			continue;
> > > > +	if (pm_runtime_get_if_in_use(data->dev) <= 0)
> > > > +		return;
> > > >    
> > > > -		writel_relaxed(F_INVLD_EN1 | F_INVLD_EN0,
> > > > -			       data->base + data->plat_data-
> > > > > inv_sel_reg);
> > > > 
> > > > -		writel_relaxed(F_ALL_INVLD, data->base +
> > > > REG_MMU_INVALIDATE);
> > > > -		wmb(); /* Make sure the tlb flush all done */
> > > > +	writel_relaxed(F_INVLD_EN1 | F_INVLD_EN0,
> > > > +		       data->base + data->plat_data-
> > > > >inv_sel_reg);
> > > > +	writel_relaxed(F_ALL_INVLD, data->base +
> > > > REG_MMU_INVALIDATE);
> > > > +	wmb(); /* Make sure the tlb flush all done */
> > > 
> > > There aren't a lot of writes here - not anymore, since you are no
> > > longer doing
> > > this for_each_m4u()...
> > > ...so, please change writel_relaxed() to writel() calls, allowing
> > > you
> > > to also
> > > remove the write barrier at the end (since in the non relaxed
> > > version, order is already ensured).
> > 
> > In the "writel", the "__iowmb()" runs before "write_relaxed". Then
> > how
> > to guarantee the last register was wrote into the HW. Here the
> > flush
> > all don't have sync(waiting it complete)
> > 
> 
> That's right, I'm sorry for the invalid proposal.
> 
> Though, there's something else to mention here... if writing
> (F_INVLD_EN1 | F_INVLD_EN0) to inv_sel_reg is *required* to happen
> before
> writing F_ALL_INVLD to REG_MMU_INVALIDATE (which I think is exactly
> the
> case here), then, in order to ensure write ordering, you should still
> use
> writel() instead of the relaxed accessor; after which, since (as you
> mentioned)
> there is no sync readback loop, you can keep that wmb() at the end.

The writel_relaxed also makes sure the order. I did try this:


https://patchwork.kernel.org/project/linux-mediatek/patch/1570627143-29441-3-git-send-email-yong.wu@mediatek.com/

> 
> > > 
> > > >    
> > > > -		pm_runtime_put(data->dev);
> > > > -	}
> > > > +	pm_runtime_put(data->dev);
> > > >    }
> > > >    
> > > >    static void mtk_iommu_tlb_flush_range_sync(unsigned long
> > > > iova,
> > > > size_t size,
> > > > 
> 
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
