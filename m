Return-Path: <SRS0=g0Sk=4O=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A95C4BA15
	for <iommu@archiver.kernel.org>; Wed, 26 Feb 2020 16:04:27 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F057921556
	for <iommu@archiver.kernel.org>; Wed, 26 Feb 2020 16:04:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F057921556
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id BE158876DB;
	Wed, 26 Feb 2020 16:04:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8pGlHE-RX1sC; Wed, 26 Feb 2020 16:04:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id A6C348758C;
	Wed, 26 Feb 2020 16:04:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 87E5AC18DA;
	Wed, 26 Feb 2020 16:04:25 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DA74DC0177
 for <iommu@lists.linux-foundation.org>; Wed, 26 Feb 2020 16:04:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id C116387583
 for <iommu@lists.linux-foundation.org>; Wed, 26 Feb 2020 16:04:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RKAWnSAicYH4 for <iommu@lists.linux-foundation.org>;
 Wed, 26 Feb 2020 16:04:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [85.220.165.71])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 5793587487
 for <iommu@lists.linux-foundation.org>; Wed, 26 Feb 2020 16:04:22 +0000 (UTC)
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
 by metis.ext.pengutronix.de with esmtp (Exim 4.92)
 (envelope-from <l.stach@pengutronix.de>)
 id 1j6zAa-000384-4V; Wed, 26 Feb 2020 17:04:20 +0100
Message-ID: <d56cec41874ee69d0f5767b549e9bd6b3003e75a.camel@pengutronix.de>
Subject: Re: Proper way to check for restricted DMA addressing from device
 driver
From: Lucas Stach <l.stach@pengutronix.de>
To: Robin Murphy <robin.murphy@arm.com>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>
Date: Wed, 26 Feb 2020 17:04:19 +0100
In-Reply-To: <bfecf850-5bd7-3092-b9b3-c5721d7a44ee@arm.com>
References: <2608dfa05478d995586c9e477917349dc18618ac.camel@pengutronix.de>
 <bfecf850-5bd7-3092-b9b3-c5721d7a44ee@arm.com>
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: iommu@lists.linux-foundation.org
Cc: Christoph Hellwig <hch@lst.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On Mi, 2020-02-26 at 15:51 +0000, Robin Murphy wrote:
> On 26/02/2020 3:44 pm, Lucas Stach wrote:
> > Hi all,
> > 
> > I'm currently struggling with how to properly check for restricted DMA
> > addressing from a device driver side. The basic issue I'm facing is
> > that I have a embedded GPU, which isn't able to address all system
> > memory due to interconnect being restricted to 32bit addressing. The
> > limits are properly described in the system device-tree and thus
> > SWIOTLB is working.
> > 
> > However graphics buffers are large and graphics drivers really like to
> > keep the dma mapping alive for performance reasons, which means I'm
> > running out of SWIOTLB space pretty easily, aside from the obvious
> > performance implications of SWIOTLB.
> > 
> > As 3 out of the maximum 4GB system memory are located in the DMA32 zone
> > and thus located in the GPU addressable space, I just want to avoid
> > allocating graphics buffers outside of the DMA32 zone.
> > 
> > To add the DMA32 restriction to my drivers allocations, I need a
> > reliable way from the device driver side to check if the GPU is in such
> > a restricted system. What I'm currently doing in my WIP patch is this:
> > 
> >   /*
> >    * If the GPU is part of a system with only 32bit bus addressing
> >    * capabilities, request pages for our SHM backend buffers from the
> >    * DMA32 zone to avoid performance killing SWIOTLB bounce buffering.
> >    */
> >   if (*gpu->dev->dma_mask < BIT_ULL(32) && !device_iommu_mapped(gpu->dev))
> >           priv->shm_gfp_mask |= GFP_DMA32;
> > 
> > However I'm not sure if there are edge cases where this check would
> > fool me. Is there any better way to check for DMA addressing
> > restrictions from the device driver side?
> 
> dma_addressing_limited()?

While amdgpu and radeon do seem to use this to trigger DMA32
allocations, the bool return value doesn't really tell if DMA32 is
helpful or not. All it tells is that the system has memory outside of
the device dma addressing capabilities.

Is the return value of this function correct if the device is behind a
IOMMU? While the device might be on a bus that is address limited a
IOMMU further up the path to memory might allow to address all system
memory, no?

Regards,
Lucas

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
