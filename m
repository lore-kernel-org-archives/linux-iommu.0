Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFFE5C43334
	for <iommu@archiver.kernel.org>; Wed, 15 Jun 2022 06:32:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 987B940396;
	Wed, 15 Jun 2022 06:32:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 87ACTD6KPKup; Wed, 15 Jun 2022 06:32:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6F2414028D;
	Wed, 15 Jun 2022 06:32:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3AB70C0039;
	Wed, 15 Jun 2022 06:32:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5CF45C002D
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jun 2022 06:32:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3C79C8346C
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jun 2022 06:32:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id S8WpTgYOlFkM for <iommu@lists.linux-foundation.org>;
 Wed, 15 Jun 2022 06:32:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C0CB383381
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jun 2022 06:32:42 +0000 (UTC)
X-UUID: dcbc5ea542084fe7a5cea6244c90db68-20220615
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6, REQID:3b517620-0903-442b-9e0b-b63c47245006, OB:0,
 LO
 B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACT
 ION:release,TS:45
X-CID-INFO: VERSION:1.1.6, REQID:3b517620-0903-442b-9e0b-b63c47245006, OB:0,
 LOB:
 0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTIO
 N:release,TS:45
X-CID-META: VersionHash:b14ad71, CLOUDID:2c498c48-4c92-421c-ad91-b806c0f58b2a,
 C
 OID:f536385ec483,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
 RL:0,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: dcbc5ea542084fe7a5cea6244c90db68-20220615
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 720961827; Wed, 15 Jun 2022 14:32:37 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 15 Jun 2022 14:32:36 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 15 Jun 2022 14:32:31 +0800
Message-ID: <9ef61bb49dec1526b807f6dc7a36297a2cebab88.camel@mediatek.com>
Subject: Re: [PATCH v8 1/3] iommu/io-pgtable-arm-v7s: Add a quirk to allow
 pgtable PA up to 35bit
To: Will Deacon <will@kernel.org>, <yf.wang@mediatek.com>
Date: Wed, 15 Jun 2022 14:32:31 +0800
In-Reply-To: <20220614125630.GA8159@willie-the-truck>
References: <20220611102656.10954-1-yf.wang@mediatek.com>
 <20220611102656.10954-2-yf.wang@mediatek.com>
 <20220614125630.GA8159@willie-the-truck>
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK: N
Cc: "Isaac J. Manjarres" <isaacm@codeaurora.org>,
 Miles Chen <miles.chen@mediatek.com>, wsd_upstream@mediatek.com,
 Libo Kang <Libo.Kang@mediatek.com>, open list <linux-kernel@vger.kernel.org>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 Ning Li <ning.li@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>,
 "moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>
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

On Tue, 2022-06-14 at 13:56 +0100, Will Deacon wrote:
> > @@ -74,17 +74,22 @@ struct io_pgtable_cfg {
> >  	 *	to support up to 35 bits PA where the bit32, bit33 and
> > bit34 are
> >  	 *	encoded in the bit9, bit4 and bit5 of the PTE respectively.
> >  	 *
> > +	 * IO_PGTABLE_QUIRK_ARM_MTK_TTBR_EXT: (ARM v7s format) MediaTek
> > IOMMUs
> > +	 *	extend the translation table base support up to 35 bits PA,
> > the
> > +	 *	encoding format is same with IO_PGTABLE_QUIRK_ARM_MTK_EXT.
> > +	 *
> 
> One thing I don't get is how the existing driver handles this. It
> seems
> as though if the HAS_4GB_MODE flag is not set, then we set oas to 35
> but
> without any pgtable changes. How does this work?

Regarding the pgtable, we already use the quirk
IO_PGTABLE_QUIRK_ARM_MTK_EXT to support 35bits oas.

HAS_4GB_MODE is the flag for the previous SoC that only supports 33bits
oas, it also is covered by IO_PGTABLE_QUIRK_ARM_MTK_EXT. and in 4GB
mode we add PA32 manually in mtk_iommu_map.

> 
> If it turns out that the existing devices can't handle 35-bit PAs,
> then
> could we use an oas of 35 to indicate that this new format is in use
> instead of introducing another quirk?

The existed devices can handle 35bits oas. The problem is that if
the pgtable PA could support up to 35bits. The previous SoC like mt8173
can't support while the lastest SoC can. This is the purpose of this
new quick. therefore we need GFP_DMA/DMA32 for pgtable allocating in
mt8173 and GFP_DMA/DMA32 is not needed in the new quirk.

> 
> Will

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
