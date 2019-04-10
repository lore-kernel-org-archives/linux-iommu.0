Return-Path: <SRS0=ghiB=SM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15FA9C10F11
	for <iommu@archiver.kernel.org>; Wed, 10 Apr 2019 06:44:33 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E28412083E
	for <iommu@archiver.kernel.org>; Wed, 10 Apr 2019 06:44:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E28412083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id B10CD159B;
	Wed, 10 Apr 2019 06:44:32 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 53A891595
	for <iommu@lists.linux-foundation.org>;
	Wed, 10 Apr 2019 06:44:14 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id C2DA263D
	for <iommu@lists.linux-foundation.org>;
	Wed, 10 Apr 2019 06:44:13 +0000 (UTC)
Received: by newverein.lst.de (Postfix, from userid 2407)
	id 8DE4C68B02; Wed, 10 Apr 2019 08:43:59 +0200 (CEST)
Date: Wed, 10 Apr 2019 08:43:59 +0200
From: "hch@lst.de" <hch@lst.de>
To: Thomas Hellstrom <thellstrom@vmware.com>
Subject: Re: revert dma direct internals abuse
Message-ID: <20190410064359.GC5543@lst.de>
References: <20190408105525.5493-1-hch@lst.de>
	<7d5f35da4a6b58639519f0764c7edbfe4dd1ba02.camel@vmware.com>
	<20190409095740.GE6827@lst.de>
	<5f0837ffc135560c764c38849eead40269cebb48.camel@vmware.com>
	<20190409133157.GA10876@lst.de>
	<466e658c73607fca5112d718972e87c0b78653ad.camel@vmware.com>
	<20190409152538.GA12816@lst.de>
	<da06614b308500392c179651ef9c6fb835ee4045.camel@vmware.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <da06614b308500392c179651ef9c6fb835ee4045.camel@vmware.com>
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
Message-ID: <20190410064359.8rGH3EGJ50UBSrcaJ_3LvzJi5JHSuivFxsRxd-w21LE@z>

On Tue, Apr 09, 2019 at 05:24:48PM +0000, Thomas Hellstrom wrote:
> > Note that this only affects external, untrusted devices.  But that
> > may include eGPU,
> 
> What about discrete graphics cards, like Radeon and Nvidia? Who gets to
> determine what's trusted?

Based on firmware tables.  discrete graphics would not qualify unless
they are attached through thunderbolt bridges or external PCIe ports.

> GPU libraries traditionally have been taking care of the CPU mapping
> caching modes since the first AGP drivers. GPU MMU ptes commonly
> support various caching options and pages are changing caching mode
> dynamically.
> So even if the DMA layer needs to do the remapping, couldn't we do that
> on-demand when needed with a simple interface?

The problem is that there is no "simple" interface as the details
depend on the architecture.  We have the following base variants
to create coherent memory:

  1) do nothing - this works on x86-like platforms where I/O is always
     coherent
  2) use a special kernel segment, after flushing the caches for the
     normal segment, done on platforms like mips that have this
     special segment
  3) remap the existing kernel direct mapping, after flushing the
     caches, done by openrisc and in some cases arm32
  4) create a new mapping in vmap or ioremap space after flushing the
     caches - done by most architectures with an MMU and non-coherent
     devices
  5) use a special pool of uncached memory set aside by the hardware
     or firmware - done by most architectures without an MMU but with
     non-coherent devices

So that is just five major variants with a lot of details on how
it is done in practice.  Add to that that many of the operations
are fairly expensive and need to be pre-loaded.

> > That being said: your driver already uses the dma coherent API
> > under various circumstances, so you already have the above issues.
> 
> Yes, but they are hidden behind driver options. We can't have someone
> upgrade their kernel and suddenly things don't work anymore, That said,
> I think the SWIOTLB case is rare enough for the below solution to be
> acceptable, although the TTM check for the coherent page pool being
> available still needs to remain.

So can you please respin a version acceptable to you and submit it
for 5.1 ASAP?  Otherwise I'll need to move ahead with the simple
revert.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
