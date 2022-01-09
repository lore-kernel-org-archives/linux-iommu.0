Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3DB2C433F5
	for <iommu@archiver.kernel.org>; Sun,  9 Jan 2022 02:47:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4D00240362;
	Sun,  9 Jan 2022 02:47:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uI0cfzKLFwnr; Sun,  9 Jan 2022 02:47:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 26A1C4035F;
	Sun,  9 Jan 2022 02:47:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F292BC0030;
	Sun,  9 Jan 2022 02:47:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CE78BC001E
 for <iommu@lists.linux-foundation.org>; Sun,  9 Jan 2022 02:47:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BC44D81751
 for <iommu@lists.linux-foundation.org>; Sun,  9 Jan 2022 02:47:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qB7w4TBqpJiC for <iommu@lists.linux-foundation.org>;
 Sun,  9 Jan 2022 02:47:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6E47C81750
 for <iommu@lists.linux-foundation.org>; Sun,  9 Jan 2022 02:47:34 +0000 (UTC)
X-UUID: 6a1134e4382c4508a775f56ce5df269e-20220109
X-UUID: 6a1134e4382c4508a775f56ce5df269e-20220109
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 1736701365; Sun, 09 Jan 2022 10:47:26 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3; 
 Sun, 9 Jan 2022 10:47:25 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 9 Jan 2022 10:47:24 +0800
Message-ID: <c5062c4636e67924af8fbf9a66565e2f89dddce5.camel@mediatek.com>
Subject: Re: [PATCH v3 13/33] iommu/mediatek: Remove the power status
 checking in tlb flush all
From: Yong Wu <yong.wu@mediatek.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Date: Sun, 9 Jan 2022 10:47:24 +0800
In-Reply-To: <1cb7458d-a012-2e84-82bd-7e4f30ed9162@collabora.com>
References: <20210923115840.17813-1-yong.wu@mediatek.com>
 <20210923115840.17813-14-yong.wu@mediatek.com>
 <1cb7458d-a012-2e84-82bd-7e4f30ed9162@collabora.com>
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
> > To simplify the code, Remove the power status checking in the
> > tlb_flush_all, remove this:
> >     if (pm_runtime_get_if_in_use(data->dev) <= 0)
> > 	    continue;
> > 
> > After this patch, the mtk_iommu_tlb_flush_all will be called from
> > a) isr
> > b) pm runtime resume callback
> > c) tlb flush range fail case
> > d) iommu_create_device_direct_mappings
> >     -> iommu_flush_iotlb_all
> > In first three cases, the power and clock always are enabled; d) is
> > direct
> > mapping, the tlb flush is unnecessay since we already have
> > tlb_flush_all
> > in the pm_runtime_resume callback. When the iommu's power status is
> > changed to active, the tlb always is clean.
> > 
> > In addition, there still are 2 reasons that don't add PM status
> > checking
> > in the tlb flush all:
> > a) Write tlb flush all register also is ok even though the HW has
> > no
> > power and clocks. Write ignore.
> 
> Do you mean that the register write seemingly succeeds but the
> hardware discards it?
> Please, reword the `a` sentence to be clearer.

Yes. This is the "Write ignore" I tried to explain.

By the way, the tlb operation patches were moved to this patchset[1]
from Dafna. Would you help take a look at that one? I will send the
next mt8195 version based on that patchset.

[1] 
https://lore.kernel.org/linux-mediatek/20211208120744.2415-1-dafna.hirschfeld@collabora.com/

Thanks.

> 
> > b) pm_runtime_get_if_in_use(m4udev) is 0 when the tlb_flush_all
> > is called frm pm_runtime_resume cb. From this point, we can not add
> > this code above in this tlb_flush_all.
> > 
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> >   drivers/iommu/mtk_iommu.c | 20 +++++++-------------
> >   1 file changed, 7 insertions(+), 13 deletions(-)
> > 
> > diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> > index e9e94944ed91..4a33b6c6b1db 100644
> > --- a/drivers/iommu/mtk_iommu.c
> > +++ b/drivers/iommu/mtk_iommu.c
> > @@ -204,10 +204,14 @@ static struct mtk_iommu_domain
> > *to_mtk_domain(struct iommu_domain *dom)
> >   	return container_of(dom, struct mtk_iommu_domain, domain);
> >   }
> >   
> > -static void mtk_iommu_tlb_do_flush_all(struct mtk_iommu_data
> > *data)
> > +static void mtk_iommu_tlb_flush_all(struct mtk_iommu_data *data)
> >   {
> >   	unsigned long flags;
> >   
> > +	/*
> > +	 * No need get power status since the HW PM status nearly is
> > active
> > +	 * when entering here.
> 
> Please reword this comment to explain the entire situation.
> 
> > +	 */
> >   	spin_lock_irqsave(&data->tlb_lock, flags);
> >   	writel_relaxed(F_INVLD_EN1 | F_INVLD_EN0,
> >   		       data->base + data->plat_data->inv_sel_reg);
> > @@ -216,16 +220,6 @@ static void mtk_iommu_tlb_do_flush_all(struct
> > mtk_iommu_data *data)
> >   	spin_unlock_irqrestore(&data->tlb_lock, flags);
> >   }
> >   
> > -static void mtk_iommu_tlb_flush_all(struct mtk_iommu_data *data)
> > -{
> > -	if (pm_runtime_get_if_in_use(data->dev) <= 0)
> > -		return;
> > -
> > -	mtk_iommu_tlb_do_flush_all(data);
> > -
> > -	pm_runtime_put(data->dev);
> > -}
> > -
> >   static void mtk_iommu_tlb_flush_range_sync(unsigned long iova,
> > size_t size,
> >   					   struct mtk_iommu_data *data)
> >   {
> > @@ -263,7 +257,7 @@ static void
> > mtk_iommu_tlb_flush_range_sync(unsigned long iova, size_t size,
> >   		if (ret) {
> >   			dev_warn(data->dev,
> >   				 "Partial TLB flush timed out, falling
> > back to full flush\n");
> > -			mtk_iommu_tlb_do_flush_all(data);
> > +			mtk_iommu_tlb_flush_all(data);
> >   		}
> >   
> >   		if (has_pm)
> > @@ -993,7 +987,7 @@ static int __maybe_unused
> > mtk_iommu_runtime_resume(struct device *dev)
> >   	 *
> >   	 * Thus, Make sure the tlb always is clean after each PM
> > resume.
> >   	 */
> > -	mtk_iommu_tlb_do_flush_all(data);
> > +	mtk_iommu_tlb_flush_all(data);
> >   
> >   	/*
> >   	 * Uppon first resume, only enable the clk and return, since
> > the values of the
> > 
> 
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
