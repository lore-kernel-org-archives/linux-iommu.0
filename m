Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1ADDC43334
	for <iommu@archiver.kernel.org>; Wed, 22 Jun 2022 01:29:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7885B41C0B;
	Wed, 22 Jun 2022 01:29:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7885B41C0B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NlSv1GiGI-Xe; Wed, 22 Jun 2022 01:29:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 12CAE41C0F;
	Wed, 22 Jun 2022 01:29:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 12CAE41C0F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E6441C0039;
	Wed, 22 Jun 2022 01:29:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B14B7C002D
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 01:29:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8CA1584663
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 01:29:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8CA1584663
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id E5E3cHsp12a5 for <iommu@lists.linux-foundation.org>;
 Wed, 22 Jun 2022 01:29:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AB30684660
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AB30684660
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 01:29:04 +0000 (UTC)
X-UUID: dafd4677dfb24b0a972f7a508371cfc2-20220622
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6, REQID:b6e29bde-d88d-4d96-8ba2-de15ea8d5e73, OB:0,
 LO
 B:0,IP:0,URL:5,TC:0,Content:10,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACT
 ION:release,TS:15
X-CID-META: VersionHash:b14ad71, CLOUDID:a10fb02d-1756-4fa3-be7f-474a6e4be921,
 C
 OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:3,EDM:-3,IP:nil,URL:1,File:nil
 ,QS:nil,BEC:nil,COL:0
X-UUID: dafd4677dfb24b0a972f7a508371cfc2-20220622
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by
 mailgw02.mediatek.com (envelope-from <yong.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 312043959; Wed, 22 Jun 2022 09:28:57 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3; 
 Wed, 22 Jun 2022 09:28:56 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Wed, 22 Jun 2022 09:28:55 +0800
Message-ID: <1ce1947984043bc4284abe94b53888c11a072345.camel@mediatek.com>
Subject: Re: [PATCH v10 1/2] iommu/io-pgtable-arm-v7s: Add a quirk to allow
 pgtable PA up to 35bit
To: <yf.wang@mediatek.com>, Will Deacon <will@kernel.org>, Robin Murphy
 <robin.murphy@arm.com>
Date: Wed, 22 Jun 2022 09:28:55 +0800
In-Reply-To: <20220616120713.12728-2-yf.wang@mediatek.com>
References: <20220616120713.12728-1-yf.wang@mediatek.com>
 <20220616120713.12728-2-yf.wang@mediatek.com>
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK: N
Cc: "Isaac J. Manjarres" <isaacm@codeaurora.org>, wsd_upstream@mediatek.com,
 Libo Kang <Libo.Kang@mediatek.com>, open list <linux-kernel@vger.kernel.org>,
 Miles Chen <miles.chen@mediatek.com>, "open
 list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 "moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, Ning Li <ning.li@mediatek.com>
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
From: Yong Wu via iommu <iommu@lists.linux-foundation.org>
Reply-To: Yong Wu <yong.wu@mediatek.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Thu, 2022-06-16 at 20:07 +0800, yf.wang@mediatek.com wrote:
> From: Yunfei Wang <yf.wang@mediatek.com>
> 
> Single memory zone feature will remove ZONE_DMA32 and ZONE_DMA and
> cause pgtable PA size larger than 32bit.
> 
> Since Mediatek IOMMU hardware support at most 35bit PA in pgtable,
> so add a quirk to allow the PA of pgtables support up to bit35.
> 
> Signed-off-by: Ning Li <ning.li@mediatek.com>
> Signed-off-by: Yunfei Wang <yf.wang@mediatek.com>
> ---
>  drivers/iommu/io-pgtable-arm-v7s.c | 67 +++++++++++++++++++++++-----
> --
>  include/linux/io-pgtable.h         | 15 ++++---
>  2 files changed, 63 insertions(+), 19 deletions(-)

[...]

>  	/* TTBR */
> -	cfg->arm_v7s_cfg.ttbr = virt_to_phys(data->pgd) |
> ARM_V7S_TTBR_S |
> +	paddr = virt_to_phys(data->pgd);
> +	cfg->arm_v7s_cfg.ttbr = paddr | ARM_V7S_TTBR_S |
>  				(cfg->coherent_walk ? (ARM_V7S_TTBR_NOS
> |
>  				 ARM_V7S_TTBR_IRGN_ATTR(ARM_V7S_RGN_WBW
> A) |
>  				 ARM_V7S_TTBR_ORGN_ATTR(ARM_V7S_RGN_WBW
> A)) :
>  				(ARM_V7S_TTBR_IRGN_ATTR(ARM_V7S_RGN_NC)
> |
>  				 ARM_V7S_TTBR_ORGN_ATTR(ARM_V7S_RGN_NC)
> ));
> +
> +	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_TTBR_EXT)
> +		cfg->arm_v7s_cfg.ttbr = (paddr & GENMASK(31, 7)) |
> +					upper_32_bits(paddr);

If we keep ttbr u32, we have to put the special logic here. This line
is ok for all the MediaTek cases, not only for this quirk. It means:

    if (arm_v7s_is_mtk_enabled(cfg))
           cfg->arm_v7s_cfg.ttbr = (virt_to_phys(data->pgd) &
GENMASK(31, 7)) | upper_32_bits(paddr);
    else
           xxx
 
     Then we don't need add "& MMU_PT_ADDR_MASK" in mtk_iommu.c since
you have done it here.

> +
>  	return &data->iop;
>  

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
