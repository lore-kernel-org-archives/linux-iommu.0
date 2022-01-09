Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8FA9C433EF
	for <iommu@archiver.kernel.org>; Sun,  9 Jan 2022 02:48:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9379560AB9;
	Sun,  9 Jan 2022 02:48:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id O1lKpN3tvx5F; Sun,  9 Jan 2022 02:48:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7C73A60AB7;
	Sun,  9 Jan 2022 02:48:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6337AC0030;
	Sun,  9 Jan 2022 02:48:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AA018C001E
 for <iommu@lists.linux-foundation.org>; Sun,  9 Jan 2022 02:48:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 88E6840412
 for <iommu@lists.linux-foundation.org>; Sun,  9 Jan 2022 02:48:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4YvOzsAehs5m for <iommu@lists.linux-foundation.org>;
 Sun,  9 Jan 2022 02:48:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 92B7A4040A
 for <iommu@lists.linux-foundation.org>; Sun,  9 Jan 2022 02:48:32 +0000 (UTC)
X-UUID: aa644fda6f2f4c9294059b61c4946042-20220109
X-UUID: aa644fda6f2f4c9294059b61c4946042-20220109
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by
 mailgw01.mediatek.com (envelope-from <yong.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 862979138; Sun, 09 Jan 2022 10:48:30 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3; 
 Sun, 9 Jan 2022 10:48:28 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 9 Jan 2022 10:48:27 +0800
Message-ID: <22faee018a36a49e4a507b69d087432c8cd689ec.camel@mediatek.com>
Subject: Re: [PATCH v3 09/33] iommu/mediatek: Remove for_each_m4u in
 tlb_sync_all
From: Yong Wu <yong.wu@mediatek.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Date: Sun, 9 Jan 2022 10:48:27 +0800
In-Reply-To: <bfa33e94-c2e5-5dab-c9af-b674e1669daa@collabora.com>
References: <20210923115840.17813-1-yong.wu@mediatek.com>
 <20210923115840.17813-10-yong.wu@mediatek.com>
 <bfa33e94-c2e5-5dab-c9af-b674e1669daa@collabora.com>
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK: N
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 srv_heupstream@mediatek.com,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
 yen-chang.chen@mediatek.com, chao.hao@mediatek.com,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, Hsin-Yi Wang <hsinyi@chromium.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, anan.sun@mediatek.com,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
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

On Tue, 2022-01-04 at 16:55 +0100, AngeloGioacchino Del Regno wrote:
> Il 23/09/21 13:58, Yong Wu ha scritto:
> > The tlb_sync_all is called from these three functions:
> > a) flush_iotlb_all: it will be called for each a iommu HW.
> > b) tlb_flush_range_sync: it already has for_each_m4u.
> > c) in irq: When IOMMU HW translation fault, Only need flush itself.
> > 
> > Thus, No need for_each_m4u in this tlb_sync_all. Remove it.
> > 
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> >   drivers/iommu/mtk_iommu.c | 18 +++++++-----------
> >   1 file changed, 7 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> > index 6f4f6624e3ac..0b4c30baa864 100644
> > --- a/drivers/iommu/mtk_iommu.c
> > +++ b/drivers/iommu/mtk_iommu.c
> > @@ -206,19 +206,15 @@ static struct mtk_iommu_domain
> > *to_mtk_domain(struct iommu_domain *dom)
> >   
> >   static void mtk_iommu_tlb_flush_all(struct mtk_iommu_data *data)
> >   {
> > -	struct list_head *head = data->hw_list;
> > -
> > -	for_each_m4u(data, head) {
> > -		if (pm_runtime_get_if_in_use(data->dev) <= 0)
> > -			continue;
> > +	if (pm_runtime_get_if_in_use(data->dev) <= 0)
> > +		return;
> >   
> > -		writel_relaxed(F_INVLD_EN1 | F_INVLD_EN0,
> > -			       data->base + data->plat_data-
> > >inv_sel_reg);
> > -		writel_relaxed(F_ALL_INVLD, data->base +
> > REG_MMU_INVALIDATE);
> > -		wmb(); /* Make sure the tlb flush all done */
> > +	writel_relaxed(F_INVLD_EN1 | F_INVLD_EN0,
> > +		       data->base + data->plat_data->inv_sel_reg);
> > +	writel_relaxed(F_ALL_INVLD, data->base + REG_MMU_INVALIDATE);
> > +	wmb(); /* Make sure the tlb flush all done */
> 
> There aren't a lot of writes here - not anymore, since you are no
> longer doing
> this for_each_m4u()...
> ...so, please change writel_relaxed() to writel() calls, allowing you
> to also
> remove the write barrier at the end (since in the non relaxed
> version, order is already ensured).

In the "writel", the "__iowmb()" runs before "write_relaxed". Then how
to guarantee the last register was wrote into the HW. Here the flush
all don't have sync(waiting it complete)

> 
> >   
> > -		pm_runtime_put(data->dev);
> > -	}
> > +	pm_runtime_put(data->dev);
> >   }
> >   
> >   static void mtk_iommu_tlb_flush_range_sync(unsigned long iova,
> > size_t size,
> > 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
