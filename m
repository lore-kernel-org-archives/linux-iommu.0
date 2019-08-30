Return-Path: <SRS0=ODk1=W2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B136C3A59B
	for <iommu@archiver.kernel.org>; Fri, 30 Aug 2019 15:01:04 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EF522341B
	for <iommu@archiver.kernel.org>; Fri, 30 Aug 2019 15:01:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EF522341B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id C9BC560C8;
	Fri, 30 Aug 2019 15:01:03 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id E0A575C7E
	for <iommu@lists.linux-foundation.org>;
	Fri, 30 Aug 2019 14:59:40 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 4EF4F89B
	for <iommu@lists.linux-foundation.org>;
	Fri, 30 Aug 2019 14:59:40 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8244E68BFE; Fri, 30 Aug 2019 16:59:35 +0200 (CEST)
Date: Fri, 30 Aug 2019 16:59:35 +0200
From: Christoph Hellwig <hch@lst.de>
To: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Subject: Re: [PATCH 1/4] vmalloc: lift the arm flag for coherent mappings
	to common code
Message-ID: <20190830145935.GA19838@lst.de>
References: <20190830062924.21714-1-hch@lst.de>
	<20190830062924.21714-2-hch@lst.de>
	<20190830092918.GV13294@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190830092918.GV13294@shell.armlinux.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: linux-xtensa@linux-xtensa.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, iommu@lists.linux-foundation.org,
	Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
	linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Fri, Aug 30, 2019 at 10:29:18AM +0100, Russell King - ARM Linux admin wrote:
> On Fri, Aug 30, 2019 at 08:29:21AM +0200, Christoph Hellwig wrote:
> > The arm architecture had a VM_ARM_DMA_CONSISTENT flag to mark DMA
> > coherent remapping for a while.  Lift this flag to common code so
> > that we can use it generically.  We also check it in the only place
> > VM_USERMAP is directly check so that we can entirely replace that
> > flag as well (although I'm not even sure why we'd want to allow
> > remapping DMA appings, but I'd rather not change behavior).
> 
> Good, because if you did change that behaviour, you'd break almost
> every ARM framebuffer and cripple ARM audio drivers.

How would that break them?  All the usual video and audio drivers that
use dma_alloc_* then use dma_mmap_* which never end up in the only place
that actually checks VM_USERMAP (remap_vmalloc_range_partial) as they
end up in the dma_map_ops mmap methods which contain what is effecitvely
open coded versions of that routine.  There are very few callers of
remap_vmalloc_range_partial / remap_vmalloc_range, and while a few of
those actually are in media drivers and the virtual frame buffer video
driver, none of these seems to be called on dma memory (which would
be a layering violation anyway).
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
