Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 589B8C43334
	for <iommu@archiver.kernel.org>; Wed, 15 Jun 2022 13:17:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0AB6783E47;
	Wed, 15 Jun 2022 13:17:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YJjKqaQJ1T4l; Wed, 15 Jun 2022 13:17:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 16FAE8316F;
	Wed, 15 Jun 2022 13:17:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EE386C0039;
	Wed, 15 Jun 2022 13:17:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BE367C002D
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jun 2022 13:17:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id ADB0483E47
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jun 2022 13:17:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OJTKAbZxDDY3 for <iommu@lists.linux-foundation.org>;
 Wed, 15 Jun 2022 13:17:06 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A07CB8316F
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jun 2022 13:17:06 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 1829A68AA6; Wed, 15 Jun 2022 15:17:01 +0200 (CEST)
Date: Wed, 15 Jun 2022 15:17:00 +0200
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: helping with remapping vmem for dma
Message-ID: <20220615131700.GA18061@lst.de>
References: <trinity-685a668a-2395-45f2-81e5-53f526863a66-1655295061671@3c-app-gmx-bap28>
 <6e58b50c-cd05-a37b-07e1-10ee24fb972f@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6e58b50c-cd05-a37b-07e1-10ee24fb972f@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: iommu@lists.linux-foundation.org, Christoph Hellwig <hch@lst.de>,
 linux-kernel@vger.kernel.org, Frank Wunderlich <frank-w@public-files.de>
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

On Wed, Jun 15, 2022 at 02:15:33PM +0100, Robin Murphy wrote:
> Put simply, if you want to call dma_map_single() on a buffer, then that 
> buffer needs to be allocated with kmalloc() (or technically alloc_pages(), 
> but then dma_map_page() would make more sense when dealing with entire 
> pages.

Yes.  It sounds like the memory here comes from the dma coherent
allocator, in which case the code need to use the address returned
by that and not create another mapping.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
