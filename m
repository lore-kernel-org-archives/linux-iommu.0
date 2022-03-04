Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C87DFC433EF
	for <iommu@archiver.kernel.org>; Fri,  4 Mar 2022 10:05:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7B2224087E;
	Fri,  4 Mar 2022 10:05:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aTvG8ptVKLD5; Fri,  4 Mar 2022 10:05:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 53F1E4035D;
	Fri,  4 Mar 2022 10:05:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1D8EEC0012;
	Fri,  4 Mar 2022 10:05:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1FEBCC000B
 for <iommu@lists.linux-foundation.org>; Fri,  4 Mar 2022 10:05:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1DB9A403A7
 for <iommu@lists.linux-foundation.org>; Fri,  4 Mar 2022 10:05:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xg_G4sJ0iY0u for <iommu@lists.linux-foundation.org>;
 Fri,  4 Mar 2022 10:05:05 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org
 [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 802044035D
 for <iommu@lists.linux-foundation.org>; Fri,  4 Mar 2022 10:05:05 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id AD38F9BF; Fri,  4 Mar 2022 11:05:02 +0100 (CET)
Date: Fri, 4 Mar 2022 11:05:01 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Subject: Re: [PATCH v2 0/5] iommu/mediatek: Fix tlb flush logic
Message-ID: <YiHkTU2AhHIbkDbb@8bytes.org>
References: <20211208120744.2415-1-dafna.hirschfeld@collabora.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211208120744.2415-1-dafna.hirschfeld@collabora.com>
Cc: open list <linux-kernel@vger.kernel.org>, sebastian.reichel@collabora.com,
 iommu@lists.linux-foundation.org,
 "moderated list:MEDIATEK IOMMU DRIVER" <linux-mediatek@lists.infradead.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, kernel@collabora.com,
 Will Deacon <will@kernel.org>, "moderated list:ARM/Mediatek SoC support"
 <linux-arm-kernel@lists.infradead.org>, linux-media@vger.kernel.org
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

On Wed, Dec 08, 2021 at 02:07:39PM +0200, Dafna Hirschfeld wrote:
> Sebastian Reichel (1):
>   iommu/mediatek: Always check runtime PM status in tlb flush range
>     callback
> 
> Yong Wu (4):
>   iommu/mediatek: Remove for_each_m4u in tlb_sync_all
>   iommu/mediatek: Remove the power status checking in tlb flush all
>   iommu/mediatek: Add tlb_lock in tlb_flush_all
>   iommu/mediatek: Always tlb_flush_all when each PM resume
> 
>  drivers/iommu/mtk_iommu.c | 42 ++++++++++++++++++++-------------------
>  1 file changed, 22 insertions(+), 20 deletions(-)

Applied, thanks.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
