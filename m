Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 064A6C433F5
	for <iommu@archiver.kernel.org>; Fri, 20 May 2022 08:52:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 99F974012F;
	Fri, 20 May 2022 08:52:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZgGnCGAG5Dc2; Fri, 20 May 2022 08:52:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6717A40A38;
	Fri, 20 May 2022 08:52:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1A0ACC0032;
	Fri, 20 May 2022 08:52:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 999D4C002D
 for <iommu@lists.linux-foundation.org>; Fri, 20 May 2022 08:52:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 76F9E8452D
 for <iommu@lists.linux-foundation.org>; Fri, 20 May 2022 08:52:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rT96Q61i2rnB for <iommu@lists.linux-foundation.org>;
 Fri, 20 May 2022 08:52:01 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org
 [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DF8D984526
 for <iommu@lists.linux-foundation.org>; Fri, 20 May 2022 08:52:00 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id BC47C1E9; Fri, 20 May 2022 10:51:58 +0200 (CEST)
Date: Fri, 20 May 2022 10:51:57 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC PATCH] dma-iommu: Add iommu_dma_max_mapping_size()
Message-ID: <YodWrRFircbmh1bN@8bytes.org>
References: <1652706361-92557-1-git-send-email-john.garry@huawei.com>
 <f5b78c9c-312e-70ab-ecbb-f14623a4b6e3@arm.com>
 <9160031b-50be-6993-5a8e-f238391962c5@huawei.com>
 <8f193bdd-3a0a-f9ed-0726-e6081f374320@arm.com>
 <20220518131353.GB26019@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220518131353.GB26019@lst.de>
Cc: Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, will@kernel.org, liyihang6@hisilicon.com
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

On Wed, May 18, 2022 at 03:13:53PM +0200, Christoph Hellwig wrote:
> On Tue, May 17, 2022 at 01:02:00PM +0100, Robin Murphy wrote:
> >> So how to inform the SCSI driver of this caching limit then so that it may 
> >> limit the SGL length?
> >
> > Driver-specific mechanism; block-layer-specific mechanism; redefine this 
> > whole API to something like dma_opt_mapping_size(), as a limit above which 
> > mappings might become less efficient or start to fail (callback to my 
> > thoughts on [1] as well, I suppose); many options. Just not imposing a 
> > ridiculously low *maximum* on everyone wherein mapping calls "should not be 
> > larger than the returned value" when that's clearly bollocks.
> 
> Well, for swiotlb it is a hard limit.  So if we want to go down that
> route we need two APIs, one for the optimal size and one for the
> hard limit.

I agree with Robin, and if it really helps some drivers I am all for
doing a dma_opt_mapping_size() instead. Limiting DMA mapping sizes to
make drivers perform better gets a clear NAK from my side.

Regards,

	Joerg
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
