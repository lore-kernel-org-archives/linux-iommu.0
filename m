Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABD05C433EF
	for <iommu@archiver.kernel.org>; Tue, 14 Jun 2022 17:24:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3F22A4186A;
	Tue, 14 Jun 2022 17:24:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tUfT_3zrD6UI; Tue, 14 Jun 2022 17:24:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id DC4B34182F;
	Tue, 14 Jun 2022 17:24:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 82B71C0032;
	Tue, 14 Jun 2022 17:24:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E8C92C002D
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jun 2022 17:24:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D0DE0832D0
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jun 2022 17:24:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5y4SmkmdKzHN for <iommu@lists.linux-foundation.org>;
 Tue, 14 Jun 2022 17:24:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EE9B0832BF
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jun 2022 17:24:49 +0000 (UTC)
X-UUID: e4f84348b096411aa6777251d7e3db7b-20220615
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6, REQID:45571f93-f34e-4e25-b58e-33f8ac16bd47, OB:0,
 LO
 B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACT
 ION:release,TS:45
X-CID-INFO: VERSION:1.1.6, REQID:45571f93-f34e-4e25-b58e-33f8ac16bd47, OB:0,
 LOB:
 0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTIO
 N:release,TS:45
X-CID-META: VersionHash:b14ad71, CLOUDID:62159807-b57a-4a25-a071-bc7b4972bc68,
 C
 OID:d225c7074901,Recheck:0,SF:28|17|19|48,TC:nil,Content:-5,EDM:-3,IP:nil,
 URL:1,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: e4f84348b096411aa6777251d7e3db7b-20220615
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
 (envelope-from <miles.chen@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 1661669870; Wed, 15 Jun 2022 01:24:44 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3; 
 Wed, 15 Jun 2022 01:24:42 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Wed, 15 Jun 2022 01:24:42 +0800
To: <yf.wang@mediatek.com>
Subject: Re: [PATCH v8 2/3] iommu/mediatek: Rename MTK_IOMMU_TLB_ADDR to
 MTK_IOMMU_ADDR
Date: Wed, 15 Jun 2022 01:24:42 +0800
Message-ID: <20220614172442.15826-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220611102656.10954-3-yf.wang@mediatek.com>
References: <20220611102656.10954-3-yf.wang@mediatek.com>
MIME-Version: 1.0
X-MTK: N
Cc: miles.chen@mediatek.com, wsd_upstream@mediatek.com,
 linux-kernel@vger.kernel.org, Libo.Kang@mediatek.com,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 ning.li@mediatek.com, matthias.bgg@gmail.com, will@kernel.org,
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
From: Miles Chen via iommu <iommu@lists.linux-foundation.org>
Reply-To: Miles Chen <miles.chen@mediatek.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

> Rename MTK_IOMMU_TLB_ADDR to MTK_IOMMU_ADDR, and update MTK_IOMMU_ADDR
> definition for better generality.
> 
> Signed-off-by: Ning Li <ning.li@mediatek.com>
> Signed-off-by: Yunfei Wang <yf.wang@mediatek.com>

Reviewed-by: Miles Chen <miles.chen@mediatek.com> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
