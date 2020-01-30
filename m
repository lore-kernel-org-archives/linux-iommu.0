Return-Path: <SRS0=QAIZ=3T=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F3DC2D0DB
	for <iommu@archiver.kernel.org>; Thu, 30 Jan 2020 16:40:18 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95A3720674
	for <iommu@archiver.kernel.org>; Thu, 30 Jan 2020 16:40:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95A3720674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 57002877AD;
	Thu, 30 Jan 2020 16:40:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rMJl-bgn03xY; Thu, 30 Jan 2020 16:40:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id A3FB187686;
	Thu, 30 Jan 2020 16:40:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 989ECC1796;
	Thu, 30 Jan 2020 16:40:17 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 93BA2C0171
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jan 2020 16:40:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 8F8A7876D5
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jan 2020 16:40:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rlVaOtTAAdUF for <iommu@lists.linux-foundation.org>;
 Thu, 30 Jan 2020 16:40:15 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 265C587686
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jan 2020 16:40:15 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id AF3F568B20; Thu, 30 Jan 2020 17:40:10 +0100 (CET)
Date: Thu, 30 Jan 2020 17:40:10 +0100
From: Christoph Hellwig <hch@lst.de>
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PoC] arm: dma-mapping: direct: Apply dma_pfn_offset only when
 it is valid
Message-ID: <20200130164010.GA6472@lst.de>
References: <8eb68140-97b2-62ce-3e06-3761984aa5b1@ti.com>
 <20200114164332.3164-1-peter.ujfalusi@ti.com>
 <f8121747-8840-e279-8c7c-75a9d4becce8@arm.com>
 <28ee3395-baed-8d59-8546-ab7765829cc8@ti.com>
 <4f0e307f-29a9-44cd-eeaa-3b999e03871c@arm.com>
 <75843c71-1718-8d61-5e3d-edba6e1b10bd@ti.com> <20200130075332.GA30735@lst.de>
 <b2b1cb21-3aae-2181-fd79-f63701f283c0@ti.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b2b1cb21-3aae-2181-fd79-f63701f283c0@ti.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: robh@kernel.org, vigneshr@ti.com, konrad.wilk@oracle.com,
 linux@armlinux.org.uk, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
 Christoph Hellwig <hch@lst.de>, linux-arm-kernel@lists.infradead.org,
 rogerq@ti.com
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

On Thu, Jan 30, 2020 at 03:04:37PM +0200, Peter Ujfalusi via iommu wrote:
> On 30/01/2020 9.53, Christoph Hellwig wrote:
> > [skipping the DT bits, as I'm everything but an expert on that..]
> > 
> > On Mon, Jan 27, 2020 at 04:00:30PM +0200, Peter Ujfalusi wrote:
> >> I agree on the phys_to_dma(). It should fail for addresses which does
> >> not fall into any of the ranges.
> >> It is just a that we in Linux don't have the concept atm for ranges, we
> >> have only _one_ range which applies to every memory address.
> > 
> > what does atm here mean?
> 
> struct device have only single dma_pfn_offset, one can not have multiple
> ranges defined. If we have then only the first is taken and the physical
> address and dma address is discarded, only the dma_pfn_offset is stored
> and used.
> 
> > We have needed multi-range support for quite a while, as common broadcom
> > SOCs do need it.  So patches for that are welcome at least from the
> > DMA layer perspective (kinda similar to your pseudo code earlier)
> 
> But do they have dma_pfn_offset != 0?

Well, with that I mean multiple ranges with different offsets.  Take
a look at arch/mips/bmips/dma.c:__phys_to_dma() and friends.  This
is an existing implementation for mips, but there are arm and arm64
SOCs using the same logic on the market as well, and we'll want to
support them eventually.

> The dma_pfn_offset is _still_ applied to the mask we are trying to set
> (and validate) via dma-direct.

And for the general case that is exactly the right thing to do, we
just need to deal with really odd ZONE_DMA placements like yours.

> > We'll need to find the minimum change to make it work
> > for now without switching ops, even if it isn't the correct one, and
> > then work from there.
> 
> Sure, but can we fix the regression by reverting to arm_ops for now only
> if dma_pfn_offset is not 0? It used to work fine in the past at least it
> appeared to work on K2 platforms.

But that will cause yet another regression in what we have just fixed
with using the generic direct ops, at which points it turns into who
screams louder.

For now I'm tempted to throw something like this in, which is a bit
of a hack, but actually 100% matches what various architectures have
historically done:


diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 6af7ae83c4ad..6ba9ee6e20bd 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -482,6 +482,9 @@ int dma_direct_supported(struct device *dev, u64 mask)
 {
 	u64 min_mask;
 
+	if (mask >= DMA_BIT_MASK(32))
+		return 1;
+
 	if (IS_ENABLED(CONFIG_ZONE_DMA))
 		min_mask = DMA_BIT_MASK(zone_dma_bits);
 	else
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
