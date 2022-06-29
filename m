Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83706C43334
	for <iommu@archiver.kernel.org>; Wed, 29 Jun 2022 12:51:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0059361210;
	Wed, 29 Jun 2022 12:51:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0059361210
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NQjDmQCwgo82; Wed, 29 Jun 2022 12:51:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 93CEE60BD5;
	Wed, 29 Jun 2022 12:51:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 93CEE60BD5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 68FA3C0032;
	Wed, 29 Jun 2022 12:51:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F41BBC002D
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jun 2022 12:51:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D62E5840AD
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jun 2022 12:51:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D62E5840AD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gVy08AleyslE for <iommu@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 12:51:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1906181B04
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1906181B04
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jun 2022 12:51:08 +0000 (UTC)
X-UUID: dfe6b9e3523a4b43891c40f87b43b53c-20220629
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.7, REQID:f30fd70c-5076-48ad-aaf4-061616af7cea, OB:10,
 L
 OB:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,AC
 TION:release,TS:50
X-CID-INFO: VERSION:1.1.7, REQID:f30fd70c-5076-48ad-aaf4-061616af7cea, OB:10,
 LOB
 :0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTI
 ON:release,TS:50
X-CID-META: VersionHash:87442a2, CLOUDID:558df762-0b3f-4b2c-b3a6-ed5c044366a0,
 C
 OID:b851f965efbe,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
 RL:1,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: dfe6b9e3523a4b43891c40f87b43b53c-20220629
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
 (envelope-from <yf.wang@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 1556319841; Wed, 29 Jun 2022 20:51:01 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3; 
 Wed, 29 Jun 2022 20:50:59 +0800
Received: from mbjsdccf07.mediatek.inc (10.15.20.246) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Wed, 29 Jun 2022 20:50:58 +0800
To: <yong.wu@mediatek.com>
Subject: Re: [PATCH v10 1/2] iommu/io-pgtable-arm-v7s: Add a quirk to allow
 pgtable PA up to 35bit
Date: Wed, 29 Jun 2022 20:44:03 +0800
Message-ID: <20220629124403.18122-1-yf.wang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <1ce1947984043bc4284abe94b53888c11a072345.camel@mediatek.com>
References: <1ce1947984043bc4284abe94b53888c11a072345.camel@mediatek.com>
MIME-Version: 1.0
X-MTK: N
Cc: isaacm@codeaurora.org, miles.chen@mediatek.com, wsd_upstream@mediatek.com,
 will@kernel.org, linux-kernel@vger.kernel.org, Libo.Kang@mediatek.com,
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

On Wed, 2022-06-22 at 09:28 +0800, Yong Wu wrote:
> On Thu, 2022-06-16 at 20:07 +0800, yf.wang@mediatek.com wrote:
> > From: Yunfei Wang <yf.wang@mediatek.com>
> > 
> > Single memory zone feature will remove ZONE_DMA32 and ZONE_DMA and
> > cause pgtable PA size larger than 32bit.
> > 
> > Since Mediatek IOMMU hardware support at most 35bit PA in pgtable,
> > so add a quirk to allow the PA of pgtables support up to bit35.
> > 
> > Signed-off-by: Ning Li <ning.li@mediatek.com>
> > Signed-off-by: Yunfei Wang <yf.wang@mediatek.com>
> > ---
> >  drivers/iommu/io-pgtable-arm-v7s.c | 67 +++++++++++++++++++++++---
> > --
> > --
> >  include/linux/io-pgtable.h         | 15 ++++---
> >  2 files changed, 63 insertions(+), 19 deletions(-)
> 
> [...]
> 
> >  	/* TTBR */
> > -	cfg->arm_v7s_cfg.ttbr = virt_to_phys(data->pgd) |
> > ARM_V7S_TTBR_S |
> > +	paddr = virt_to_phys(data->pgd);
> > +	cfg->arm_v7s_cfg.ttbr = paddr | ARM_V7S_TTBR_S |
> >  				(cfg->coherent_walk ? (ARM_V7S_TTBR_NOS
> > > 
> > 
> >  				 ARM_V7S_TTBR_IRGN_ATTR(ARM_V7S_RGN_WBW
> > A) |
> >  				 ARM_V7S_TTBR_ORGN_ATTR(ARM_V7S_RGN_WBW
> > A)) :
> >  				(ARM_V7S_TTBR_IRGN_ATTR(ARM_V7S_RGN_NC)
> > > 
> > 
> >  				 ARM_V7S_TTBR_ORGN_ATTR(ARM_V7S_RGN_NC)
> > ));
> > +
> > +	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_TTBR_EXT)
> > +		cfg->arm_v7s_cfg.ttbr = (paddr & GENMASK(31, 7)) |
> > +					upper_32_bits(paddr);
> 
> If we keep ttbr u32, we have to put the special logic here. This line
> is ok for all the MediaTek cases, not only for this quirk. It means:
> 
>     if (arm_v7s_is_mtk_enabled(cfg))
>            cfg->arm_v7s_cfg.ttbr = (virt_to_phys(data->pgd) &
> GENMASK(31, 7)) | upper_32_bits(paddr);
>     else
>            xxx
>  
>      Then we don't need add "& MMU_PT_ADDR_MASK" in mtk_iommu.c since
> you have done it here.
> 

Hi Yong,
Thanks for your suggestion, PATCH v11 version will modify it.

Thanks,
Yunfei.

> > +
> >  	return &data->iop;
> >  
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
