Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 170BAC433FE
	for <iommu@archiver.kernel.org>; Fri, 13 May 2022 13:02:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id AA6D9408B8;
	Fri, 13 May 2022 13:02:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ab7Fft7-LVCu; Fri, 13 May 2022 13:02:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5EDEC4011C;
	Fri, 13 May 2022 13:02:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 31708C0032;
	Fri, 13 May 2022 13:02:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6D0E2C002D
 for <iommu@lists.linux-foundation.org>; Fri, 13 May 2022 13:02:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 54F5E401D8
 for <iommu@lists.linux-foundation.org>; Fri, 13 May 2022 13:02:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IGTFOU-aZJFk for <iommu@lists.linux-foundation.org>;
 Fri, 13 May 2022 13:01:59 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 878B2401D2
 for <iommu@lists.linux-foundation.org>; Fri, 13 May 2022 13:01:59 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 23E6F4D2; Fri, 13 May 2022 15:01:57 +0200 (CEST)
Date: Fri, 13 May 2022 15:01:55 +0200
From: Joerg Roedel <joro@8bytes.org>
To: yf.wang@mediatek.com
Subject: Re: [PATCH] iommu/dma: Fix iova map result check bug
Message-ID: <Yn5Ww0xCuH+y4h+Y@8bytes.org>
References: <20220507085204.16914-1-yf.wang@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220507085204.16914-1-yf.wang@mediatek.com>
Cc: wsd_upstream@mediatek.com, Will Deacon <will@kernel.org>,
 open list <linux-kernel@vger.kernel.org>, Libo Kang <Libo.Kang@mediatek.com>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 Ning Li <Ning.Li@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 stable@vger.kernel.org, Logan Gunthorpe <logang@deltatee.com>,
 "moderated list:ARM/Mediatek SoC support"
 <linux-arm-kernel@lists.infradead.org>
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

On Sat, May 07, 2022 at 04:52:03PM +0800, yf.wang@mediatek.com wrote:
>  drivers/iommu/dma-iommu.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Applied, thanks.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
