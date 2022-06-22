Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8780BC43334
	for <iommu@archiver.kernel.org>; Wed, 22 Jun 2022 13:42:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EF9C54181D;
	Wed, 22 Jun 2022 13:42:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EF9C54181D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LYW8OR7zRvPS; Wed, 22 Jun 2022 13:42:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 95308417DE;
	Wed, 22 Jun 2022 13:42:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 95308417DE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 71AB6C0032;
	Wed, 22 Jun 2022 13:42:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2E138C002D
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 13:42:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 02D2360AF8
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 13:42:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 02D2360AF8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id b49C_m0JYmb1 for <iommu@lists.linux-foundation.org>;
 Wed, 22 Jun 2022 13:42:13 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 570DD607F7
Received: from theia.8bytes.org (8bytes.org
 [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 570DD607F7
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 13:42:13 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 314092D0; Wed, 22 Jun 2022 15:42:10 +0200 (CEST)
Date: Wed, 22 Jun 2022 15:42:08 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] iommu/dma: Fix race condition during iova_domain
 initialization
Message-ID: <YrMcMOVSQtLqJ3kp@8bytes.org>
References: <20220530120748.31733-1-yf.wang@mediatek.com>
 <YrMPG4dIEnFkCbi9@8bytes.org>
 <a0f0d3da-6992-7033-5262-156ffa5316e7@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a0f0d3da-6992-7033-5262-156ffa5316e7@arm.com>
Cc: wsd_upstream@mediatek.com, open list <linux-kernel@vger.kernel.org>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Libo Kang <Libo.Kang@mediatek.com>, yf.wang@mediatek.com,
 Miles Chen <miles.chen@mediatek.com>,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 "moderated list:ARM/Mediatek SoC support"
 <linux-arm-kernel@lists.infradead.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, Will Deacon <will@kernel.org>,
 Ning Li <ning.li@mediatek.com>
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

On Wed, Jun 22, 2022 at 02:27:57PM +0100, Robin Murphy wrote:
> Apologies, I did spot this before, I've just been tied up with other things
> and dropping everything non-critical on the floor, so didn't get round to
> replying before it slipped my mind again.
> 
> In summary, I hate it, but mostly because the whole situation of calling
> iommu_probe_device off the back of driver probe is fundamentally broken. I'm
> still a few steps away from fixing that properly, at which point I can just
> as well rip all these little bodges out again. If it really does need
> mitigating in the meantime (i.e. this is real-world async probe, not just
> some contrived testcase), then I can't easily think of any cleaner hack, so,
> 
> Acked-by: Robin Murphy <robin.murphy@arm.com>

Alright, applied this now.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
