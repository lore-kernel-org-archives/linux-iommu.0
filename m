Return-Path: <SRS0=aFDh=SL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C85C3C282DA
	for <iommu@archiver.kernel.org>; Tue,  9 Apr 2019 13:32:12 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9ACD0206C0
	for <iommu@archiver.kernel.org>; Tue,  9 Apr 2019 13:32:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ACD0206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 4D940E31;
	Tue,  9 Apr 2019 13:32:12 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 9EF9EE2B
	for <iommu@lists.linux-foundation.org>;
	Tue,  9 Apr 2019 13:32:11 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id F311A735
	for <iommu@lists.linux-foundation.org>;
	Tue,  9 Apr 2019 13:32:10 +0000 (UTC)
Received: by newverein.lst.de (Postfix, from userid 2407)
	id 715E868B02; Tue,  9 Apr 2019 15:31:58 +0200 (CEST)
Date: Tue, 9 Apr 2019 15:31:58 +0200
From: "hch@lst.de" <hch@lst.de>
To: Thomas Hellstrom <thellstrom@vmware.com>
Subject: Re: revert dma direct internals abuse
Message-ID: <20190409133157.GA10876@lst.de>
References: <20190408105525.5493-1-hch@lst.de>
	<7d5f35da4a6b58639519f0764c7edbfe4dd1ba02.camel@vmware.com>
	<20190409095740.GE6827@lst.de>
	<5f0837ffc135560c764c38849eead40269cebb48.camel@vmware.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5f0837ffc135560c764c38849eead40269cebb48.camel@vmware.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	Deepak Singh Rawat <drawat@vmware.com>,
	"torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
	"hch@lst.de" <hch@lst.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190409133158.FvnvU3WF3YS2kSvpV2VbUdOIRq58KlZNxDSzMCqyip0@z>

On Tue, Apr 09, 2019 at 01:04:51PM +0000, Thomas Hellstrom wrote:
> On the VMware platform we have two possible vIOMMUS, the AMD iommu and
> Intel VTD, Given those conditions I belive the patch is functionally
> correct. We can't cover the AMD case with intel_iommu_enabled.
> Furthermore the only form of incoherency that can affect our graphics
> device is someone forcing SWIOTLB in which case that person would be
> happier with software rendering. In any case, observing the fact that
> the direct_ops are not used makes sure that SWIOTLB is not used.
> Knowing that we're on the VMware platform, we're coherent and can
> safely have the dma layer do dma address translation for us. All this
> information was not explicilty written in the changelog, no.

We have a series pending that might bounce your buffers even when
using the Intel IOMMU, which should eventually also find its way
to other IOMMUs:

    https://lists.linuxfoundation.org/pipermail/iommu/2019-March/034090.html

> In any case, assuming that that patch is reverted due to the layering
> violation, Are you willing to help out with a small API to detect the
> situation where streaming DMA is incoherent?

The short but sad answer is that we can't ever guarantee that you
can skip the dma_*sync_* calls.  There are too many factors in play
that might require it at any time - working around unaligned addresses
in iommus, CPUs that are coherent for some device and not some, addressing
limitations both in physical CPUs and VMs (see the various "secure VM"
concepts floating around at the moment).

If you want to avoid the dma_*sync_* calls you must use
dma_alloc_coherent to allocate the memory.  Note that the memory for
dma_alloc_coherent actually comes from the normal page pool most of
the time, and for certain on x86, which seems to be what you care
about.  The times of it dipping into the tiny swiotlb pool are long
gone.  So at least for you I see absolutely no reason to not simply
always use dma_alloc_coherent to start with.  For other uses that
involve platforms without DMA coherent devices like arm the tradeoffs
might be a little different.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
