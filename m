Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83086C433F5
	for <iommu@archiver.kernel.org>; Mon, 23 May 2022 12:27:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1C3E36107E;
	Mon, 23 May 2022 12:27:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qrqHXcL3B9Oj; Mon, 23 May 2022 12:27:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E7AFB60B66;
	Mon, 23 May 2022 12:27:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CBAFAC0039;
	Mon, 23 May 2022 12:27:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CDC5AC002D
 for <iommu@lists.linux-foundation.org>; Mon, 23 May 2022 12:27:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BC2E483EAD
 for <iommu@lists.linux-foundation.org>; Mon, 23 May 2022 12:27:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id N0Yuy3Pj_rNX for <iommu@lists.linux-foundation.org>;
 Mon, 23 May 2022 12:27:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 526BC83EA2
 for <iommu@lists.linux-foundation.org>; Mon, 23 May 2022 12:27:30 +0000 (UTC)
X-UUID: 80521b9d309b45c081ef9ff8d748708d-20220523
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5, REQID:c68145b2-2b3d-40f6-816f-a8913b4ecc56, OB:0,
 LO
 B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
 ON:release,TS:0
X-CID-META: VersionHash:2a19b09, CLOUDID:9eb83ce3-edbf-4bd4-8a34-dfc5f7bb086d,
 C
 OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:-5,EDM:-3,IP:nil,URL:0,File:ni
 l,QS:0,BEC:nil
X-UUID: 80521b9d309b45c081ef9ff8d748708d-20220523
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by
 mailgw01.mediatek.com (envelope-from <mark-pk.tsai@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 788225916; Mon, 23 May 2022 20:27:24 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3; 
 Mon, 23 May 2022 20:27:23 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Mon, 23 May 2022 20:27:23 +0800
To: <robin.murphy@arm.com>
Subject: Re: [PATCH 0/2] dma-mapping,
 remoteproc: Fix dma_mem leak after rproc_shutdown
Date: Mon, 23 May 2022 20:27:23 +0800
Message-ID: <20220523122723.32602-1-mark-pk.tsai@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <6f1f48e2-a54d-58d6-8946-853cffeb55df@arm.com>
References: <6f1f48e2-a54d-58d6-8946-853cffeb55df@arm.com>
MIME-Version: 1.0
X-MTK: N
Cc: mathieu.poirier@linaro.org, yj.chiang@mediatek.com,
 linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 mark-pk.tsai@mediatek.com, matthias.bgg@gmail.com, hch@lst.de,
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
From: Mark-PK Tsai via iommu <iommu@lists.linux-foundation.org>
Reply-To: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

> >> Sigh.  In theory drivers should never declare coherent memory like
> >> this, and there has been some work to fix remoteproc in that regard.
> >>
> >> But I guess until that is merged we'll need somthing like this fix.
> > 
> > Hi,
> > 
> > Thanks for your comment.
> > As I didn't see other fix of this issue, should we use this patch
> > before the remoteproc work you mentioned is merged?
> 
> TBH I think it would be better "fixed" with a kmemleak_ignore() and a 
> big comment, rather than adding API cruft for something that isn't a 
> real problem. I'm quite sure that no real-world user is unbinding 
> remoteproc drivers frequently enough that leaking a 48-byte allocation 
> each time has any practical significance.
> 

Actually we stop 2 remote processors using the same remoteproc driver
when system suspend or screen off on our arm64 platform.
And the 48-byte slab allocation will be aligned up to 128 bytes on arm64.
So the leak can be significant in our use case especially
in stress test...

We really don't want to ignore it. Maybe there're other way to fix
it without adding APIs?
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
