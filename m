Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1FABC433F5
	for <iommu@archiver.kernel.org>; Mon,  9 May 2022 06:18:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 93055817F2;
	Mon,  9 May 2022 06:18:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XQQJkP8V9S4R; Mon,  9 May 2022 06:18:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 905BC817AD;
	Mon,  9 May 2022 06:18:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6542DC0032;
	Mon,  9 May 2022 06:18:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 57165C002D
 for <iommu@lists.linux-foundation.org>; Mon,  9 May 2022 06:18:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 44B2E817F2
 for <iommu@lists.linux-foundation.org>; Mon,  9 May 2022 06:18:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DpDLBZqeIpUJ for <iommu@lists.linux-foundation.org>;
 Mon,  9 May 2022 06:18:04 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A1A6C817AD
 for <iommu@lists.linux-foundation.org>; Mon,  9 May 2022 06:18:04 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id EFE0668AFE; Mon,  9 May 2022 08:18:00 +0200 (CEST)
Date: Mon, 9 May 2022 08:18:00 +0200
From: Christoph Hellwig <hch@lst.de>
To: Stefano Stabellini <sstabellini@kernel.org>
Subject: Re: [PATCH] swiotlb-xen: fix DMA_ATTR_NO_KERNEL_MAPPING on arm
Message-ID: <20220509061800.GC17190@lst.de>
References: <20220423171422.1831676-1-hch@lst.de>
 <alpine.DEB.2.22.394.2204261605420.915916@ubuntu-linux-20-04-desktop>
 <20220428132737.GA13999@lst.de>
 <alpine.DEB.2.22.394.2204281449060.915916@ubuntu-linux-20-04-desktop>
 <27d39d5a-3b79-bdda-b7e4-f4477667919f@oracle.com>
 <alpine.DEB.2.22.394.2204281548320.915916@ubuntu-linux-20-04-desktop>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2204281548320.915916@ubuntu-linux-20-04-desktop>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: jgross@suse.com, iommu@lists.linux-foundation.org,
 xen-devel@lists.xenproject.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Rahul Singh <Rahul.Singh@arm.com>, Christoph Hellwig <hch@lst.de>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Thu, Apr 28, 2022 at 03:49:53PM -0700, Stefano Stabellini wrote:
> On one hand, Linux doesn't boot on a platform without this fix. On the
> other hand, I totally see that this patch could introduce regressions on
> x86 so I think it is fair that we are careful with it.
> 
> >From my point of view, it might be better to wait for 5.19 and mark it
> as backport.

Sounds good to me.  Based on the other mails I assume you want me to
take it through the dma-mapping tree, so I will do that tomorrow unless
I hear otherwise.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
