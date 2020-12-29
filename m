Return-Path: <SRS0=AIYf=GB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB7DFC433DB
	for <iommu@archiver.kernel.org>; Tue, 29 Dec 2020 11:06:58 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80E62207D1
	for <iommu@archiver.kernel.org>; Tue, 29 Dec 2020 11:06:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80E62207D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 42DC385948;
	Tue, 29 Dec 2020 11:06:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Xr0-StIUwI8d; Tue, 29 Dec 2020 11:06:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id AAC1685945;
	Tue, 29 Dec 2020 11:06:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7D558C088B;
	Tue, 29 Dec 2020 11:06:57 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1A40FC0174
 for <iommu@lists.linux-foundation.org>; Tue, 29 Dec 2020 11:06:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 15BF686C62
 for <iommu@lists.linux-foundation.org>; Tue, 29 Dec 2020 11:06:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XS2cRPjTflZc for <iommu@lists.linux-foundation.org>;
 Tue, 29 Dec 2020 11:06:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw01.mediatek.com (unknown [1.203.163.78])
 by whitealder.osuosl.org (Postfix) with ESMTP id 678C386C50
 for <iommu@lists.linux-foundation.org>; Tue, 29 Dec 2020 11:06:54 +0000 (UTC)
X-UUID: 75617dd10cbf41aa8a8aa93cbb70916a-20201229
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=zfneozaYhu5jrm9Q37fk5lPpqTHzSi4uBaXsfUw6RZ4=; 
 b=X+VtajVVr1i7nGvkkzSQLloRasRFyxUOGpUfSdJxREgqwpZ6gmOhtWoJJ3oDds8qijzQAZYPbFcgZI1opp22jBsXFvJZF3Ce3vrTlunQ2pI9h/dr0Y+Rf6uo0+vAjcXB0uUgv0BCx4+lWDNQKG8BxsWZXoRh3qzhiS48DW9gRKY=;
X-UUID: 75617dd10cbf41aa8a8aa93cbb70916a-20201229
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 794393449; Tue, 29 Dec 2020 19:06:28 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Tue, 29 Dec 2020 19:06:18 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 29 Dec 2020 19:06:18 +0800
Message-ID: <1609239977.26323.292.camel@mhfsdcap03>
Subject: Re: [PATCH v5 18/27] iommu/mediatek: Add power-domain operation
From: Yong Wu <yong.wu@mediatek.com>
To: Tomasz Figa <tfiga@chromium.org>
Date: Tue, 29 Dec 2020 19:06:17 +0800
In-Reply-To: <X+MBcmzQn9iQWlVZ@chromium.org>
References: <20201209080102.26626-1-yong.wu@mediatek.com>
 <X+MBcmzQn9iQWlVZ@chromium.org>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: D6856EB35728775B524D669116D09ECF5C09C39014423CFC3B03E7EB5EA35C712000:8
X-MTK: N
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 Nicolas Boichat <drinkcat@chromium.org>, srv_heupstream@mediatek.com,
 Tomasz Figa <tfiga@google.com>, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org, Evan Green <evgreen@chromium.org>,
 chao.hao@mediatek.com, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 Krzysztof Kozlowski <krzk@kernel.org>,
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

On Wed, 2020-12-23 at 17:36 +0900, Tomasz Figa wrote:
> On Wed, Dec 09, 2020 at 04:00:53PM +0800, Yong Wu wrote:
> > In the previous SoC, the M4U HW is in the EMI power domain which is
> > always on. the latest M4U is in the display power domain which may be
> > turned on/off, thus we have to add pm_runtime interface for it.
> > 
> > When the engine work, the engine always enable the power and clocks for
> > smi-larb/smi-common, then the M4U's power will always be powered on
> > automatically via the device link with smi-common.
> > 
> > Note: we don't enable the M4U power in iommu_map/unmap for tlb flush.
> > If its power already is on, of course it is ok. if the power is off,
> > the main tlb will be reset while M4U power on, thus the tlb flush while
> > m4u power off is unnecessary, just skip it.
> > 
> > There will be one case that pm runctime status is not expected when tlb
> > flush. After boot, the display may call dma_alloc_attrs before it call
> > pm_runtime_get(disp-dev), then the m4u's pm status is not active inside
> > the dma_alloc_attrs. Since it only happens after boot, the tlb is clean
> > at that time, I also think this is ok.
> > 
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> >  drivers/iommu/mtk_iommu.c | 41 +++++++++++++++++++++++++++++++++------
> >  1 file changed, 35 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> > index 6fe3ee2b2bf5..0e9c03cbab32 100644
> > --- a/drivers/iommu/mtk_iommu.c
> > +++ b/drivers/iommu/mtk_iommu.c
> > @@ -184,6 +184,8 @@ static void mtk_iommu_tlb_flush_all(void *cookie)
> >  	struct mtk_iommu_data *data = cookie;
> >  
> >  	for_each_m4u(data) {
> > +		if (!pm_runtime_active(data->dev))
> > +			continue;
> 
> Is it guaranteed that the status is active in the check above, but then
> the process is preempted and it goes down here?
> 
> Shouldn't we do something like below?
> 
>         ret = pm_runtime_get_if_active();
>         if (!ret)
>                 continue;
>         if (ret < 0)
>                 // handle error
>         
>         // Flush
>         
>         pm_runtime_put();

Make sense. Thanks. There is a comment in arm_smmu.c "avoid touching
dev->power.lock in fastpaths". To avoid this here too(we have many SoC
don't have power-domain). then the code will be like:

	bool has_pm = !!data->dev->pm_domain;

	if (has_pm) {
		if (pm_runtime_get_if_in_use(data->dev) <= 0)
			continue;
	}

	xxxx

	if (has_pm)
		pm_runtime_put(data->dev);
> 
> Similar comment to the other places being changed by this patch.
> 
> >  		writel_relaxed(F_INVLD_EN1 | F_INVLD_EN0,
> >  			       data->base + data->plat_data->inv_sel_reg);
> >  		writel_relaxed(F_ALL_INVLD, data->base + REG_MMU_INVALIDATE);
> > @@ -200,6 +202,10 @@ static void mtk_iommu_tlb_flush_range_sync(unsigned long iova, size_t size,
> >  	u32 tmp;
> >  
> >  	for_each_m4u(data) {
> > +		/* skip tlb flush when pm is not active. */
> > +		if (!pm_runtime_active(data->dev))
> > +			continue;
> > +
> >  		spin_lock_irqsave(&data->tlb_lock, flags);
> >  		writel_relaxed(F_INVLD_EN1 | F_INVLD_EN0,
> >  			       data->base + data->plat_data->inv_sel_reg);
[snip]
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
