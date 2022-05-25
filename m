Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A003C433EF
	for <iommu@archiver.kernel.org>; Wed, 25 May 2022 05:43:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2FC3B60E57;
	Wed, 25 May 2022 05:43:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IFNSjEAyPbU5; Wed, 25 May 2022 05:43:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7F8F460B09;
	Wed, 25 May 2022 05:43:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 51FEAC0039;
	Wed, 25 May 2022 05:43:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DBF41C002D
 for <iommu@lists.linux-foundation.org>; Wed, 25 May 2022 05:43:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B6CFB83F5E
 for <iommu@lists.linux-foundation.org>; Wed, 25 May 2022 05:43:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UlBwR36YNSn5 for <iommu@lists.linux-foundation.org>;
 Wed, 25 May 2022 05:43:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5B4D582B8C
 for <iommu@lists.linux-foundation.org>; Wed, 25 May 2022 05:43:26 +0000 (UTC)
X-UUID: a469481094374202937f5807fca7138d-20220525
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5, REQID:67c377b9-f005-46ce-a6a0-97813ced0dbe, OB:0,
 LO
 B:10,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:51,FILE:0,RULE:Release_Ham,AC
 TION:release,TS:56
X-CID-INFO: VERSION:1.1.5, REQID:67c377b9-f005-46ce-a6a0-97813ced0dbe, OB:0,
 LOB:
 10,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:51,FILE:0,RULE:Release_Ham,ACTI
 ON:release,TS:56
X-CID-META: VersionHash:2a19b09, CLOUDID:f5cf24b8-3c45-407b-8f66-25095432a27a,
 C
 OID:31c0f6e3944e,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
 RL:1,File:nil,QS:0,BEC:nil
X-UUID: a469481094374202937f5807fca7138d-20220525
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
 (envelope-from <yf.wang@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 1084376180; Wed, 25 May 2022 13:43:21 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 25 May 2022 13:43:20 +0800
Received: from mbjsdccf07.mediatek.inc (10.15.20.246) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via
 Frontend Transport; Wed, 25 May 2022 13:43:19 +0800
To: <yong.wu@mediatek.com>
Subject: Re: [PATCH v5 2/2] iommu/mediatek: Allow page table PA up to 35bit
Date: Wed, 25 May 2022 13:36:42 +0800
Message-ID: <20220525053642.29653-1-yf.wang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <1625ec1f4cded0f825d93743d3d03fcf83cad5aa.camel@mediatek.com>
References: <1625ec1f4cded0f825d93743d3d03fcf83cad5aa.camel@mediatek.com>
MIME-Version: 1.0
X-MTK: N
Cc: wsd_upstream@mediatek.com, will@kernel.org, linux-kernel@vger.kernel.org,
 Libo.Kang@mediatek.com, yf.wang@mediatek.com, iommu@lists.linux-foundation.org,
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

On Thu, 2022-05-19 at 14:58 +0800, Yong Wu wrote:
> On Mon, 2022-05-16 at 22:16 +0800, yf.wang@mediatek.com wrote:
> > From: Yunfei Wang <yf.wang@mediatek.com>
> > 
> > Add the quirk IO_PGTABLE_QUIRK_ARM_MTK_TTBR_EXT support, so that
> > allows
> > page table PA up to 35bit, not only in ZONE_DMA32.
> 
> Comment why this is needed.
> 
> e.g. For single normal zone.
> 

Hi Yong,

There is no DMA32 zone in some mediatek smartphone chip for single normal zone.

The level 1 and level 2 pgtable are both allocated in ZONE_DMA32, and may have two possible problem:
1.The level 2 pgtable is allocated in ZONE_DMA32 with atomic flag, and it may fail if ZONE_DMA32 memory is used out.
2.Single memory feature will make ZONE_DMA32 empty, and cause level 1 and level 2 pgtable PA more than 32bit.

Solution:
Add the quirk IO_PGTABLE_QUIRK_ARM_MTK_TTBR_EXT support, so that level 1 and level 2 pgtable can support at most 35bit PA.

I will update the commit message in next version.

Thanks,
Yunfei.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
