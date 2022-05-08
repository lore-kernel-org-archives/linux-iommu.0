Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2A5CC433F5
	for <iommu@archiver.kernel.org>; Sun,  8 May 2022 16:01:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 93C4D81390;
	Sun,  8 May 2022 16:01:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TjHsZkqjmlD0; Sun,  8 May 2022 16:01:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4B28F80BCF;
	Sun,  8 May 2022 16:01:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 166C7C0039;
	Sun,  8 May 2022 16:01:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 50595C002D
 for <iommu@lists.linux-foundation.org>; Sun,  8 May 2022 16:01:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 471D781390
 for <iommu@lists.linux-foundation.org>; Sun,  8 May 2022 16:01:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iDO3DCOzoU72 for <iommu@lists.linux-foundation.org>;
 Sun,  8 May 2022 16:01:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C15F980BCF
 for <iommu@lists.linux-foundation.org>; Sun,  8 May 2022 16:01:24 +0000 (UTC)
X-UUID: 1dbc5d80bf594775b536ef032d9feea6-20220509
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4, REQID:056b2570-af1b-4a0a-850b-587964813929, OB:0,
 LO
 B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACT
 ION:release,TS:45
X-CID-INFO: VERSION:1.1.4, REQID:056b2570-af1b-4a0a-850b-587964813929, OB:0,
 LOB:
 0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTIO
 N:release,TS:45
X-CID-META: VersionHash:faefae9, CLOUDID:4f60a016-2e53-443e-b81a-655c13977218,
 C
 OID:IGNORED,Recheck:0,SF:28|17|19|48,TC:nil,Content:-5,EDM:-3,File:nil,QS:
 0,BEC:nil
X-UUID: 1dbc5d80bf594775b536ef032d9feea6-20220509
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by
 mailgw01.mediatek.com (envelope-from <miles.chen@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1948238772; Mon, 09 May 2022 00:01:17 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3; 
 Mon, 9 May 2022 00:01:15 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via
 Frontend Transport; Mon, 9 May 2022 00:01:15 +0800
To: <yf.wang@mediatek.com>
Subject: Re: [PATCH] iommu/dma: Fix iova map result check bug
Date: Mon, 9 May 2022 00:01:15 +0800
Message-ID: <20220508160115.4851-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220507085204.16914-1-yf.wang@mediatek.com>
References: <20220507085204.16914-1-yf.wang@mediatek.com>
MIME-Version: 1.0
X-MTK: N
Cc: wsd_upstream@mediatek.com, will@kernel.org, linux-kernel@vger.kernel.org,
 Libo.Kang@mediatek.com, iommu@lists.linux-foundation.org,
 linux-mediatek@lists.infradead.org, Ning.Li@mediatek.com,
 matthias.bgg@gmail.com, stable@vger.kernel.org, logang@deltatee.com,
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

> The data type of the return value of the iommu_map_sg_atomic
> is ssize_t, but the data type of iova size is size_t,
> e.g. one is int while the other is unsigned int.
> 
> When iommu_map_sg_atomic return value is compared with iova size,
> it will force the signed int to be converted to unsigned int, if
> iova map fails and iommu_map_sg_atomic return error code is less
> than 0, then (ret < iova_len) is false, which will to cause not
> do free iova, and the master can still successfully get the iova
> of map fail, which is not expected.
> 
> Therefore, we need to check the return value of iommu_map_sg_atomic
> in two cases according to whether it is less than 0.
> 
> Fixes: ad8f36e4b6b1 ("iommu: return full error code from iommu_map_sg[_atomic]()")
> Signed-off-by: Yunfei Wang <yf.wang@mediatek.com>

Yes, we have to make sure ssize_t >= 0 before comparing ssize_t and size_t.

Reviewed-by: Miles Chen <miles.chen@mediatek.com> 
>
> Cc: <stable@vger.kernel.org> # 5.15.*
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
