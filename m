Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89A21C433EF
	for <iommu@archiver.kernel.org>; Wed, 25 May 2022 03:28:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 409AF8349A;
	Wed, 25 May 2022 03:28:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TwwL4rM7oq4j; Wed, 25 May 2022 03:28:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 14E4382FA2;
	Wed, 25 May 2022 03:28:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DD36CC0039;
	Wed, 25 May 2022 03:28:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 361B9C002D
 for <iommu@lists.linux-foundation.org>; Wed, 25 May 2022 03:28:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1041F8349A
 for <iommu@lists.linux-foundation.org>; Wed, 25 May 2022 03:28:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MHEfNgEfNFUa for <iommu@lists.linux-foundation.org>;
 Wed, 25 May 2022 03:28:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DB30C82FA2
 for <iommu@lists.linux-foundation.org>; Wed, 25 May 2022 03:28:22 +0000 (UTC)
X-UUID: 01a910ce870243ac929270e8b9848174-20220525
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5, REQID:c4016c45-e276-4a22-b8f1-b1a8da546e26, OB:10,
 L
 OB:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:51,FILE:0,RULE:Release_Ham,AC
 TION:release,TS:56
X-CID-INFO: VERSION:1.1.5, REQID:c4016c45-e276-4a22-b8f1-b1a8da546e26, OB:10,
 LOB
 :0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:51,FILE:0,RULE:Release_Ham,ACTI
 ON:release,TS:56
X-CID-META: VersionHash:2a19b09, CLOUDID:b7f01fb8-3c45-407b-8f66-25095432a27a,
 C
 OID:bf78fb8f7416,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
 RL:1,File:nil,QS:0,BEC:nil
X-UUID: 01a910ce870243ac929270e8b9848174-20220525
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
 (envelope-from <yf.wang@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 1293842912; Wed, 25 May 2022 11:28:13 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 25 May 2022 11:28:12 +0800
Received: from mbjsdccf07.mediatek.inc (10.15.20.246) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Wed, 25 May 2022 11:28:10 +0800
To: <miles.chen@mediatek.com>
Subject: Re: [PATCH v5 1/2] iommu/io-pgtable-arm-v7s: Add a quirk to allow
 pgtable PA up to 35bit
Date: Wed, 25 May 2022 11:21:33 +0800
Message-ID: <20220525032133.29053-1-yf.wang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220519062756.14447-1-miles.chen@mediatek.com>
References: <20220519062756.14447-1-miles.chen@mediatek.com>
MIME-Version: 1.0
X-MTK: N
Cc: isaacm@codeaurora.org, wsd_upstream@mediatek.com, will@kernel.org,
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

On Thu, 2022-05-19 at 14:27 +0800, Miles Chen wrote:
> Hi Yunfei,
> 
> > The calling to kmem_cache_alloc for level 2 pgtable allocation may
> > run
> > in atomic context, and it fails sometimes when DMA32 zone runs out
> > of
> > memory.
> > 
> > Since Mediatek IOMMU hardware support at most 35bit PA in pgtable,
> > so add a quirk to allow the PA of pgtables support up to bit35.
> > 
> > Signed-off-by: Ning Li <ning.li@mediatek.com>
> > Signed-off-by: Yunfei Wang <yf.wang@mediatek.com>
> > ---
> >  drivers/iommu/io-pgtable-arm-v7s.c | 56 ++++++++++++++++++++++--
> > ------
> >  include/linux/io-pgtable.h         | 15 +++++---
> >  2 files changed, 52 insertions(+), 19 deletions(-)
> > 
> > diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-
> > pgtable-arm-v7s.c
> 
> ...snip...
> 
> > +     gfp_t gfp_l1 = __GFP_ZERO | ARM_V7S_TABLE_GFP_DMA;
> >       struct io_pgtable_cfg *cfg = &data->iop.cfg;
> >       struct device *dev = cfg->iommu_dev;
> >       phys_addr_t phys;
> > @@ -241,9 +251,11 @@ static void *__arm_v7s_alloc_table(int lvl,
> > gfp_t gfp,
> >       size_t size = ARM_V7S_TABLE_SIZE(lvl, cfg);
> >       void *table = NULL;
> > 
> > +     if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_TTBR_EXT)
> > +             gfp_l1 = __GFP_ZERO;
> 
> __GFP_ZERO is an action modifier, if we do not want
> ARM_V7S_TABLE_GFP_DMA (GFP_DMA/GFP_DMA32), use gfp_l1 = (GFP_KERNEL |
> __GFP_ZERO)
> 

Hi Miles,
Thanks for the suggestion, we will update it in the next version.

Thanks,
Yunfei.

> > +
> >       if (lvl == 1)
> > -             table = (void *)__get_free_pages(
> > -                     __GFP_ZERO | ARM_V7S_TABLE_GFP_DMA,
> > get_order(size));
> > +             table = (void *)__get_free_pages(gfp_l1,
> > get_order(size));
> >       else if (lvl == 2)
> >               table = kmem_cache_zalloc(data->l2_tables, gfp);
> > 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
