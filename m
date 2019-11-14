Return-Path: <SRS0=E0xS=ZG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BCA4C43215
	for <iommu@archiver.kernel.org>; Thu, 14 Nov 2019 07:41:11 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75F99206DB
	for <iommu@archiver.kernel.org>; Thu, 14 Nov 2019 07:41:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75F99206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 1FABBACD;
	Thu, 14 Nov 2019 07:41:11 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 059D1408
	for <iommu@lists.linux-foundation.org>;
	Thu, 14 Nov 2019 07:41:10 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id B71828A
	for <iommu@lists.linux-foundation.org>;
	Thu, 14 Nov 2019 07:41:08 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id EF39468AFE; Thu, 14 Nov 2019 08:41:05 +0100 (CET)
Date: Thu, 14 Nov 2019 08:41:05 +0100
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: generic DMA bypass flag
Message-ID: <20191114074105.GC26546@lst.de>
References: <20191113133731.20870-1-hch@lst.de>
	<d27b7b29-df78-4904-8002-b697da5cb013@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d27b7b29-df78-4904-8002-b697da5cb013@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	linuxppc-dev@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>
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

On Wed, Nov 13, 2019 at 02:45:15PM +0000, Robin Murphy wrote:
> In all honesty, this seems silly. If we can set a per-device flag to say 
> "oh, bypass these ops and use some other ops instead", then we can just as 
> easily simply give the device the appropriate ops in the first place. 
> Because, y'know, the name of the game is "per-device ops".

Except that we can't do it _that_ easily.  The problem is that for both
the powerpc and intel case the selection is dynamic.  If a device is in
the identify domain with intel-iommu (or the equivalent on powerpc which
doesn't use the normal iommu framework), we still want to use the iommu
to be able to map memory for devices with a too small dma mask using
the iommu instead of using swiotlb bouncing.  So to "just" use the
per-device dma ops we'd need:

  a) a hook in dma_direct_supported to pick another set of ops for
     small dma masks
  b) a hook in the IOMMU ops to propagate to the direct ops for full
     64-bit masks

I looked into that for powerpc a while ago and it wasn't pretty at all.
Compared to that just checking another flag for the DMA direct calls
is relatively clean and trivial as seens in the diffstat for this series
alone.

> I don't see a great benefit to pulling legacy cruft out into common code 
> instead of just working to get rid of it in-place, when said cruft pulls in 
> the opposite direction to where we're taking the common code (i.e. it's 
> inherently based on the premise of global ops).

I'm not sure what legacy cruft it pull in.  I think it actually fits very
much into a mental model of "direct mapping is the default, to be overriden
if needed" which is pretty close to what we have at the moment.  Just
with a slightly more complicated processing of the override.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
