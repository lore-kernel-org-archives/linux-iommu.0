Return-Path: <SRS0=AIYf=GB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 963DFC433E0
	for <iommu@archiver.kernel.org>; Tue, 29 Dec 2020 11:17:49 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EC6820825
	for <iommu@archiver.kernel.org>; Tue, 29 Dec 2020 11:17:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EC6820825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id C7F0886970;
	Tue, 29 Dec 2020 11:17:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bEx9NBquIi7e; Tue, 29 Dec 2020 11:17:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 314928690B;
	Tue, 29 Dec 2020 11:17:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 19460C088B;
	Tue, 29 Dec 2020 11:17:48 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 85A20C0174
 for <iommu@lists.linux-foundation.org>; Tue, 29 Dec 2020 11:17:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 80C1A8690B
 for <iommu@lists.linux-foundation.org>; Tue, 29 Dec 2020 11:17:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OgUaCHdAurU2 for <iommu@lists.linux-foundation.org>;
 Tue, 29 Dec 2020 11:17:45 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw02.mediatek.com (unknown [1.203.163.81])
 by whitealder.osuosl.org (Postfix) with ESMTP id 947A8867FD
 for <iommu@lists.linux-foundation.org>; Tue, 29 Dec 2020 11:17:44 +0000 (UTC)
X-UUID: a265345998e04ca4a2d32d1135c7a17d-20201229
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=kjdDDsR62/sn1Fub2YpVwLbpjVry+o489WtdnLg/RPA=; 
 b=j85CWewiMQm78U7KBaWow+N6gvruv4RDqU5o+zYFjQvgQHlSaobts6499n2kpyUKPLTMCUBZkO/WaE0cJUXtGHhBR7Oej8zqRzafS+7fuhf6srFdh1Z/MJcsyDUk67sR28wkFn6ekgzhhzZO1p8BP6yfFf3ao1z5HePR3bWAKqM=;
X-UUID: a265345998e04ca4a2d32d1135c7a17d-20201229
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 1139923315; Tue, 29 Dec 2020 19:17:40 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Tue, 29 Dec 2020 19:17:37 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 29 Dec 2020 19:17:37 +0800
Message-ID: <1609240657.26323.298.camel@mhfsdcap03>
Subject: Re: [PATCH v5 09/27] iommu/io-pgtable-arm-v7s: Extend PA34 for
 MediaTek
From: Yong Wu <yong.wu@mediatek.com>
To: Tomasz Figa <tfiga@chromium.org>
Date: Tue, 29 Dec 2020 19:17:37 +0800
In-Reply-To: <X+L96uZU2aZWfjSP@chromium.org>
References: <20201209080102.26626-1-yong.wu@mediatek.com>
 <20201209080102.26626-10-yong.wu@mediatek.com>
 <X+L96uZU2aZWfjSP@chromium.org>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: D8FBC57831CD7A85616D1A7462D4159D3B98DDE313D42CDF6FB3EC071BE3DD992000:8
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

On Wed, 2020-12-23 at 17:20 +0900, Tomasz Figa wrote:
> On Wed, Dec 09, 2020 at 04:00:44PM +0800, Yong Wu wrote:
> > MediaTek extend the bit5 in lvl1 and lvl2 descriptor as PA34.
> > 
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > Acked-by: Will Deacon <will@kernel.org>
> > Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> > ---
> >  drivers/iommu/io-pgtable-arm-v7s.c | 9 +++++++--
> >  drivers/iommu/mtk_iommu.c          | 2 +-
> >  include/linux/io-pgtable.h         | 4 ++--
> >  3 files changed, 10 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
> > index e880745ab1e8..4d0aa079470f 100644
> > --- a/drivers/iommu/io-pgtable-arm-v7s.c
> > +++ b/drivers/iommu/io-pgtable-arm-v7s.c
> > @@ -112,9 +112,10 @@
> >  #define ARM_V7S_TEX_MASK		0x7
> >  #define ARM_V7S_ATTR_TEX(val)		(((val) & ARM_V7S_TEX_MASK) << ARM_V7S_TEX_SHIFT)
> >  
> > -/* MediaTek extend the two bits for PA 32bit/33bit */
> > +/* MediaTek extend the bits below for PA 32bit/33bit/34bit */
> >  #define ARM_V7S_ATTR_MTK_PA_BIT32	BIT(9)
> >  #define ARM_V7S_ATTR_MTK_PA_BIT33	BIT(4)
> > +#define ARM_V7S_ATTR_MTK_PA_BIT34	BIT(5)
> >  
> >  /* *well, except for TEX on level 2 large pages, of course :( */
> >  #define ARM_V7S_CONT_PAGE_TEX_SHIFT	6
> > @@ -194,6 +195,8 @@ static arm_v7s_iopte paddr_to_iopte(phys_addr_t paddr, int lvl,
> >  		pte |= ARM_V7S_ATTR_MTK_PA_BIT32;
> >  	if (paddr & BIT_ULL(33))
> >  		pte |= ARM_V7S_ATTR_MTK_PA_BIT33;
> > +	if (paddr & BIT_ULL(34))
> > +		pte |= ARM_V7S_ATTR_MTK_PA_BIT34;
> >  	return pte;
> >  }
> >  
> > @@ -218,6 +221,8 @@ static phys_addr_t iopte_to_paddr(arm_v7s_iopte pte, int lvl,
> >  		paddr |= BIT_ULL(32);
> >  	if (pte & ARM_V7S_ATTR_MTK_PA_BIT33)
> >  		paddr |= BIT_ULL(33);
> > +	if (pte & ARM_V7S_ATTR_MTK_PA_BIT34)
> > +		paddr |= BIT_ULL(34);
> >  	return paddr;
> >  }
> >  
> > @@ -754,7 +759,7 @@ static struct io_pgtable *arm_v7s_alloc_pgtable(struct io_pgtable_cfg *cfg,
> >  	if (cfg->ias > ARM_V7S_ADDR_BITS)
> >  		return NULL;
> >  
> > -	if (cfg->oas > (arm_v7s_is_mtk_enabled(cfg) ? 34 : ARM_V7S_ADDR_BITS))
> > +	if (cfg->oas > (arm_v7s_is_mtk_enabled(cfg) ? 35 : ARM_V7S_ADDR_BITS))
> >  		return NULL;
> >  
> >  	if (cfg->quirks & ~(IO_PGTABLE_QUIRK_ARM_NS |
> > diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> > index 6451d83753e1..ec3c87d4b172 100644
> > --- a/drivers/iommu/mtk_iommu.c
> > +++ b/drivers/iommu/mtk_iommu.c
> > @@ -320,7 +320,7 @@ static int mtk_iommu_domain_finalise(struct mtk_iommu_domain *dom)
> >  			IO_PGTABLE_QUIRK_ARM_MTK_EXT,
> >  		.pgsize_bitmap = mtk_iommu_ops.pgsize_bitmap,
> >  		.ias = 32,
> > -		.oas = 34,
> > +		.oas = 35,
> 
> Shouldn't this be set according to the real hardware capabilities,
> instead of always setting it to 35?

Here only make the code clean. 35 is ok for all the SoC.
But you are right from the HW point, the logic is like this:

if (MTK_IOMMU_HAS_FLAG(data->plat_data, HAS_4GB_MODE))
	dom->cfg.oas = data->enable_4GB ? 33 : 32;
else
	dom->cfg.oas = 35;

I will use this in next version.

> 
> Best regards,
> Tomasz
> 
> >  		.tlb = &mtk_iommu_flush_ops,
> >  		.iommu_dev = data->dev,
> >  	};
> > diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
> > index 4cde111e425b..1ae0757f4f94 100644
> > --- a/include/linux/io-pgtable.h
> > +++ b/include/linux/io-pgtable.h
> > @@ -77,8 +77,8 @@ struct io_pgtable_cfg {
> >  	 *	TLB maintenance when mapping as well as when unmapping.
> >  	 *
> >  	 * IO_PGTABLE_QUIRK_ARM_MTK_EXT: (ARM v7s format) MediaTek IOMMUs extend
> > -	 *	to support up to 34 bits PA where the bit32 and bit33 are
> > -	 *	encoded in the bit9 and bit4 of the PTE respectively.
> > +	 *	to support up to 35 bits PA where the bit32, bit33 and bit34 are
> > +	 *	encoded in the bit9, bit4 and bit5 of the PTE respectively.
> >  	 *
> >  	 * IO_PGTABLE_QUIRK_NON_STRICT: Skip issuing synchronous leaf TLBIs
> >  	 *	on unmap, for DMA domains using the flush queue mechanism for
> > -- 
> > 2.18.0
> > 
> > _______________________________________________
> > iommu mailing list
> > iommu@lists.linux-foundation.org
> > https://lists.linuxfoundation.org/mailman/listinfo/iommu

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
