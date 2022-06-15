Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5470AC43334
	for <iommu@archiver.kernel.org>; Wed, 15 Jun 2022 14:21:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C9FED83E3A;
	Wed, 15 Jun 2022 14:21:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0cbpY0RbFcvF; Wed, 15 Jun 2022 14:21:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8889583E20;
	Wed, 15 Jun 2022 14:21:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 68AA5C0032;
	Wed, 15 Jun 2022 14:21:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 61410C002D
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jun 2022 14:21:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 41FA483E3A
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jun 2022 14:21:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DBKdcmjcmWLH for <iommu@lists.linux-foundation.org>;
 Wed, 15 Jun 2022 14:21:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 31E4683E20
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jun 2022 14:21:11 +0000 (UTC)
X-UUID: 95235e6e05714a97ab6a52166d268a1a-20220615
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6, REQID:c4f47823-d73c-46fb-a21b-2d909cce153f, OB:0,
 LO
 B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:26,FILE:0,RULE:Release_Ham,ACT
 ION:release,TS:26
X-CID-INFO: VERSION:1.1.6, REQID:c4f47823-d73c-46fb-a21b-2d909cce153f, OB:0,
 LOB:
 0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:26,FILE:0,RULE:Release_Ham,ACTIO
 N:release,TS:26
X-CID-META: VersionHash:b14ad71, CLOUDID:dffd58f6-e099-41ba-a32c-13b8bfe63214,
 C
 OID:IGNORED,Recheck:0,SF:28|100|17|19|48|101,TC:nil,Content:0,EDM:-3,IP:ni
 l,URL:0,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: 95235e6e05714a97ab6a52166d268a1a-20220615
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
 (envelope-from <yf.wang@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 1618739428; Wed, 15 Jun 2022 22:21:02 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 15 Jun 2022 22:21:00 +0800
Received: from mbjsdccf07.mediatek.inc (10.15.20.246) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via
 Frontend Transport; Wed, 15 Jun 2022 22:20:59 +0800
To: <will@kernel.org>
Subject: Re: [PATCH v8 1/3] iommu/io-pgtable-arm-v7s: Add a quirk to allow
 pgtable PA up to 35bit
Date: Wed, 15 Jun 2022 22:14:11 +0800
Message-ID: <20220615141411.5119-1-yf.wang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220614125630.GA8159@willie-the-truck>
References: <20220614125630.GA8159@willie-the-truck>
MIME-Version: 1.0
X-MTK: N
Cc: isaacm@codeaurora.org, miles.chen@mediatek.com, wsd_upstream@mediatek.com,
 linux-kernel@vger.kernel.org, Libo.Kang@mediatek.com,
 iommu@lists.linux-foundation.org, yf.wang@mediatek.com,
 linux-mediatek@lists.infradead.org, ning.li@mediatek.com,
 matthias.bgg@gmail.com, robin.murphy@arm.com,
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
From: "yf.wang--- via iommu" <iommu@lists.linux-foundation.org>
Reply-To: yf.wang@mediatek.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Tue, 2022-06-14 at 13:56 +0100, Will Deacon wrote:
> Hi,
> 
> For some reason, this series has landed in my spam folder so
> apologies
> for the delay :/
> 
> 
> > +static arm_v7s_iopte paddr_to_iopte(phys_addr_t paddr, int lvl,
> > +				    struct io_pgtable_cfg *cfg)
> > +{
> > +	arm_v7s_iopte pte = paddr & ARM_V7S_LVL_MASK(lvl);
> > +
> > +	if (!arm_v7s_is_mtk_enabled(cfg))
> > +		return pte;
> > +
> > +	return to_iopte_mtk(paddr, pte);
> 
> nit, but can we rename and rework this so it reads a bit better,
> please?
> Something like:
> 
> 
> 	if (arm_v7s_is_mtk_enabled(cfg))
> 		return to_mtk_iopte(paddr, pte);
> 
> 	return pte;
> 
> 

Hi Will,
Thanks for your suggestion, PATCH v9 version will modify it.


> >  static phys_addr_t iopte_to_paddr(arm_v7s_iopte pte, int lvl,
> >  				  struct io_pgtable_cfg *cfg)
> >  {
> > @@ -234,6 +239,7 @@ static arm_v7s_iopte *iopte_deref(arm_v7s_iopte
> > pte, int lvl,
> >  static void *__arm_v7s_alloc_table(int lvl, gfp_t gfp,
> >  				   struct arm_v7s_io_pgtable *data)
> >  {
> > +	gfp_t gfp_l1 = __GFP_ZERO | ARM_V7S_TABLE_GFP_DMA;
> >  	struct io_pgtable_cfg *cfg = &data->iop.cfg;
> >  	struct device *dev = cfg->iommu_dev;
> >  	phys_addr_t phys;
> > @@ -241,9 +247,11 @@ static void *__arm_v7s_alloc_table(int lvl,
> > gfp_t gfp,
> >  	size_t size = ARM_V7S_TABLE_SIZE(lvl, cfg);
> >  	void *table = NULL;
> >  
> > +	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_TTBR_EXT)
> > +		gfp_l1 = GFP_KERNEL | __GFP_ZERO;
> 
> I think it's a bit grotty to override the flags inline like this
> (same for
> the slab flag later on). Something like this is a bit cleaner:
> 
> 
> 	/*
> 	 * Comment explaining why GFP_KERNEL is desirable here.
> 	 * I'm assuming it's because the walker can address all of
> memory.
> 	 */
> 	gfp_l1 = cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_TTBR_EXT ?
> 		 GFP_KERNEL : ARM_V7S_TABLE_GFP_DMA;
> 
> 	...
> 
> 	__get_free_pages(gfp_l1 | __GFP_ZERO, ...);
> 
> 
> and similar for the slab flag.
> 

Hi Will,
Thanks for your suggestion, PATCH v9 version will modify it.


> >  	if (lvl == 1)
> > -		table = (void *)__get_free_pages(
> > -			__GFP_ZERO | ARM_V7S_TABLE_GFP_DMA,
> > get_order(size));
> > +		table = (void *)__get_free_pages(gfp_l1,
> > get_order(size));
> >  	else if (lvl == 2)
> >  		table = kmem_cache_zalloc(data->l2_tables, gfp);
> >  
> > @@ -251,7 +259,8 @@ static void *__arm_v7s_alloc_table(int lvl,
> > gfp_t gfp,
> >  		return NULL;
> >  
> >  	phys = virt_to_phys(table);
> > -	if (phys != (arm_v7s_iopte)phys) {
> > +	if (phys != (arm_v7s_iopte)phys &&
> > +	    !(cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_TTBR_EXT)) {
> >  		/* Doesn't fit in PTE */
> 
> Shouldn't we be checking that the address is within 35 bits here?
> Perhaps we
> should generate a mask from the oas instead of just using the cast.
> 

Hi Will,
Thanks for your suggestion, PATCH v9 version will add checking that the address is within 35 bits:

phys = virt_to_phys(table);
if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_TTBR_EXT ?
    phys >= (1ULL << cfg->oas) : phys != (arm_v7s_iopte)phys) {
	/* Doesn't fit in PTE */


Thanks,
Yunfei.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
