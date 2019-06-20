Return-Path: <SRS0=IV2l=UT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A416C43613
	for <iommu@archiver.kernel.org>; Thu, 20 Jun 2019 14:01:01 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC99B2083B
	for <iommu@archiver.kernel.org>; Thu, 20 Jun 2019 14:01:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC99B2083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id D4C31CF3;
	Thu, 20 Jun 2019 14:01:00 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id BE6CBC90
	for <iommu@lists.linux-foundation.org>;
	Thu, 20 Jun 2019 14:00:59 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw01.mediatek.com (unknown [1.203.163.78])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id B078FE6
	for <iommu@lists.linux-foundation.org>;
	Thu, 20 Jun 2019 14:00:58 +0000 (UTC)
X-UUID: 94cc822e567147ea8d262cb818830815-20190620
X-UUID: 94cc822e567147ea8d262cb818830815-20190620
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
	(envelope-from <yong.wu@mediatek.com>)
	(mailgw01.mediatek.com ESMTP with TLS)
	with ESMTP id 2051957500; Thu, 20 Jun 2019 22:00:54 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31DR.mediatek.inc
	(172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
	Thu, 20 Jun 2019 22:00:52 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS36.mediatek.inc
	(172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
	Transport; Thu, 20 Jun 2019 22:00:51 +0800
Message-ID: <1561039251.4021.24.camel@mhfsdcap03>
Subject: Re: [PATCH v7 20/21] iommu/mediatek: Fix iova_to_phys PA start for
	4GB mode
From: Yong Wu <yong.wu@mediatek.com>
To: Matthias Brugger <matthias.bgg@gmail.com>
Date: Thu, 20 Jun 2019 22:00:51 +0800
In-Reply-To: <db9b3b2f-3206-01bf-f0f9-67251e5ff756@gmail.com>
References: <1560169080-27134-1-git-send-email-yong.wu@mediatek.com>
	<1560169080-27134-21-git-send-email-yong.wu@mediatek.com>
	<db9b3b2f-3206-01bf-f0f9-67251e5ff756@gmail.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 9F3A6F19158ACBE29AA97F263B906A0DA454BBC7D4DEDC72D58952D01E5C29BA2000:8
X-MTK: N
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
	Nicolas Boichat <drinkcat@chromium.org>,
	srv_heupstream@mediatek.com, Will Deacon <will.deacon@arm.com>,
	linux-kernel@vger.kernel.org, Evan Green <evgreen@chromium.org>, Tomasz
	Figa <tfiga@google.com>, iommu@lists.linux-foundation.org, Rob
	Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
	yingjoe.chen@mediatek.com, anan.sun@mediatek.com,
	Robin Murphy <robin.murphy@arm.com>, Matthias
	Kaehlcke <mka@chromium.org>, linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Tue, 2019-06-18 at 18:35 +0200, Matthias Brugger wrote:
> 
> On 10/06/2019 14:17, Yong Wu wrote:
> > In the 4GB mode, the physical address is remapped,
> > 
> > Here is the detailed remap relationship.
> > CPU PA         ->    HW PA
> > 0x4000_0000          0x1_4000_0000 (Add bit32)
> > 0x8000_0000          0x1_8000_0000 ...
> > 0xc000_0000          0x1_c000_0000 ...
> > 0x1_0000_0000        0x1_0000_0000 (No change)
> > 
> > Thus, we always add bit32 for PA when entering mtk_iommu_map.
> > But in the iova_to_phys, the CPU don't need this bit32 if the
> > PA is from 0x1_4000_0000 to 0x1_ffff_ffff.
> > This patch discards the bit32 in this iova_to_phys in the 4GB mode.
> > 
> > Fixes: 30e2fccf9512 ("iommu/mediatek: Enlarge the validate PA range
> > for 4GB mode")
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> >  drivers/iommu/mtk_iommu.c | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> > 
> > diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> > index 67cab2d..34f2e40 100644
> > --- a/drivers/iommu/mtk_iommu.c
> > +++ b/drivers/iommu/mtk_iommu.c
> > @@ -119,6 +119,19 @@ struct mtk_iommu_domain {
> >  
> >  static const struct iommu_ops mtk_iommu_ops;
> >  
> > +/*
> > + * In M4U 4GB mode, the physical address is remapped as below:
> > + *  CPU PA         ->   M4U HW PA
> > + *  0x4000_0000         0x1_4000_0000 (Add bit32)
> > + *  0x8000_0000         0x1_8000_0000 ...
> > + *  0xc000_0000         0x1_c000_0000 ...
> > + *  0x1_0000_0000       0x1_0000_0000 (No change)
> > + *
> > + * Thus, We always add BIT32 in the iommu_map and disable BIT32 if PA is >=
> > + * 0x1_4000_0000 in the iova_to_phys.
> > + */
> > +#define MTK_IOMMU_4GB_MODE_PA_140000000     0x140000000UL
> > +
> >  static LIST_HEAD(m4ulist);	/* List all the M4U HWs */
> >  
> >  #define for_each_m4u(data)	list_for_each_entry(data, &m4ulist, list)
> > @@ -415,6 +428,7 @@ static phys_addr_t mtk_iommu_iova_to_phys(struct iommu_domain *domain,
> >  					  dma_addr_t iova)
> >  {
> >  	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
> > +	struct mtk_iommu_data *data = mtk_iommu_get_m4u_data();
> >  	unsigned long flags;
> >  	phys_addr_t pa;
> >  
> > @@ -422,6 +436,10 @@ static phys_addr_t mtk_iommu_iova_to_phys(struct iommu_domain *domain,
> >  	pa = dom->iop->iova_to_phys(dom->iop, iova);
> >  	spin_unlock_irqrestore(&dom->pgtlock, flags);
> >  
> > +	if (data->plat_data->has_4gb_mode && data->dram_is_4gb &&
> > +	    pa >= MTK_IOMMU_4GB_MODE_PA_140000000)
> > +		pa &= ~BIT_ULL(32);
> > +
> 
> Hm, I wonder if we could fix this as first patch in the series, especially before:
> "[PATCH 06/21] iommu/io-pgtable-arm-v7s: Extend MediaTek 4GB Mode"

OK.

> 
> This would make it easier for the stable maintainer to cherry-pick the fix.
> Without 100% understanding the code, it seems suspicious to me, that you first
> move the setting of the bit32 and bit33 into v7s and later explicitly clean the
> bits here.
> 
> So my take on this is, that patch 6/21 introduced the regression you are trying
> to fix here. As said that is speculation as I don't understand the code in its
> whole.
> 
> Any clarification would be useful.

I guess the commit message in [06/21] will be helpful.

In the previous mt8173 and mt2712, the M4U HW support "4GB mode" in
which the range of dram is from 0x4000_0000 to 0x1_3fff_ffff and it was
remapped to 0x1_0000_0000 ~0x1_ffff_ffff(For readable, I have wrote the
re-map relationship into the code in this patch.). but mt8183 don't need
remap the dram address(0x4000_0000 ~ 0x3_ffff_ffff).

In order to unify the code, we add bit32 for "4GB mode". But actually
the PA doesn't always have bit32, thus, I have to remove bit32 when PA >
0x1_4000_0000.

So sorry that the "4GB mode" is a little unreadable and special, And the
4GB patch(30e2fccf9512 ("iommu/mediatek: Enlarge the validate PA range
for 4GB mode") has introduced several fix patches.

> 
> Regards,
> Matthias
> 
> >  	return pa;
> >  }
> >  
> > 
> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
