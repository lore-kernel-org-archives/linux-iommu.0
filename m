Return-Path: <SRS0=3qkl=WH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A67EC41514
	for <iommu@archiver.kernel.org>; Sun, 11 Aug 2019 08:13:10 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56D28208C2
	for <iommu@archiver.kernel.org>; Sun, 11 Aug 2019 08:13:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56D28208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 632CEAF7;
	Sun, 11 Aug 2019 08:13:02 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 47EBBAD0
	for <iommu@lists.linux-foundation.org>;
	Sun, 11 Aug 2019 08:13:00 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-qt1-f193.google.com (mail-qt1-f193.google.com
	[209.85.160.193])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id EE94387E
	for <iommu@lists.linux-foundation.org>;
	Sun, 11 Aug 2019 08:12:58 +0000 (UTC)
Received: by mail-qt1-f193.google.com with SMTP id b11so212870qtp.10
	for <iommu@lists.linux-foundation.org>;
	Sun, 11 Aug 2019 01:12:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=lK2BvTRRqJlMRPRV20MG66suKP5my4fsNc+MbdelOFY=;
	b=jZcr9nWKv59oTeLV8SC3JLmG0mlZPyLOjgJBCs+DmD4aRLfC0qoZo/fU8w1S+jIhzQ
	Mojd80flCNGdUZsQ8Z1CHsZsVPBiFZh8c4DJ2Z6O0vuI0vuw6MoSX0A2+Auxj69EgpuQ
	F6kCLrzSMmXvPI8GV24yI0NY7zxN73J/oOdnc8AOv+3MCKyTC4IpQbBGGkq53ehK4xbW
	rhyQdn/7INgWDbBXkpahdMnk52Euxa6Os3xsCkHJttXlkIrm6zoIzi0S/saDhELzCTE9
	aWY17Sq9vAnqbimzmctuw0fuOIH97lAuKJFQDI41GgdIq17z1LiAArRAbXbwL6K5JQIe
	uyqQ==
X-Gm-Message-State: APjAAAVanXFIEyfw7G92nobyAPHDvVRc46hlyIuPCH1sCQVFy5ZsT5A6
	7YbVOrCOUATtb4lkqUfVjHMJ6g==
X-Google-Smtp-Source: APXvYqyKfn4s+AIYTpA1AFYCjNuZfg0Z55WNP4r2G9r1W2+SGXIZqpz/IX3y8ci3TiAqrtmHL07K4w==
X-Received: by 2002:ad4:4112:: with SMTP id i18mr8157789qvp.175.1565511178073; 
	Sun, 11 Aug 2019 01:12:58 -0700 (PDT)
Received: from redhat.com (bzq-79-181-91-42.red.bezeqint.net. [79.181.91.42])
	by smtp.gmail.com with ESMTPSA id
	l80sm26005979qke.24.2019.08.11.01.12.53
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Sun, 11 Aug 2019 01:12:56 -0700 (PDT)
Date: Sun, 11 Aug 2019 04:12:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ram Pai <linuxram@us.ibm.com>
Subject: Re: [RFC PATCH] virtio_ring: Use DMA API if guest memory is encrypted
Message-ID: <20190811041035-mutt-send-email-mst@kernel.org>
References: <87zhrj8kcp.fsf@morokweng.localdomain>
	<20190810143038-mutt-send-email-mst@kernel.org>
	<20190810220702.GA5964@ram.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190810220702.GA5964@ram.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Jason Wang <jasowang@redhat.com>, Alexey Kardashevskiy <aik@linux.ibm.com>,
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
	Paul Mackerras <paulus@ozlabs.org>, iommu@lists.linux-foundation.org,
	linuxppc-devel@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>,
	David Gibson <david@gibson.dropbear.id.au>
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

On Sat, Aug 10, 2019 at 03:07:02PM -0700, Ram Pai wrote:
> On Sat, Aug 10, 2019 at 02:57:17PM -0400, Michael S. Tsirkin wrote:
> > On Tue, Jan 29, 2019 at 03:08:12PM -0200, Thiago Jung Bauermann wrote:
> > > 
> > > Hello,
> > > 
> > > With Christoph's rework of the DMA API that recently landed, the patch
> > > below is the only change needed in virtio to make it work in a POWER
> > > secure guest under the ultravisor.
> > > 
> > > The other change we need (making sure the device's dma_map_ops is NULL
> > > so that the dma-direct/swiotlb code is used) can be made in
> > > powerpc-specific code.
> > > 
> > > Of course, I also have patches (soon to be posted as RFC) which hook up
> > > <linux/mem_encrypt.h> to the powerpc secure guest support code.
> > > 
> > > What do you think?
> > > 
> > > >From d0629a36a75c678b4a72b853f8f7f8c17eedd6b3 Mon Sep 17 00:00:00 2001
> > > From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> > > Date: Thu, 24 Jan 2019 22:08:02 -0200
> > > Subject: [RFC PATCH] virtio_ring: Use DMA API if guest memory is encrypted
> > > 
> > > The host can't access the guest memory when it's encrypted, so using
> > > regular memory pages for the ring isn't an option. Go through the DMA API.
> > > 
> > > Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> > > ---
> > >  drivers/virtio/virtio_ring.c | 5 ++++-
> > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > index cd7e755484e3..321a27075380 100644
> > > --- a/drivers/virtio/virtio_ring.c
> > > +++ b/drivers/virtio/virtio_ring.c
> > > @@ -259,8 +259,11 @@ static bool vring_use_dma_api(struct virtio_device *vdev)
> > >  	 * not work without an even larger kludge.  Instead, enable
> > >  	 * the DMA API if we're a Xen guest, which at least allows
> > >  	 * all of the sensible Xen configurations to work correctly.
> > > +	 *
> > > +	 * Also, if guest memory is encrypted the host can't access
> > > +	 * it directly. In this case, we'll need to use the DMA API.
> > >  	 */
> > > -	if (xen_domain())
> > > +	if (xen_domain() || sev_active())
> > >  		return true;
> > > 
> > >  	return false;
> > 
> > So I gave this lots of thought, and I'm coming round to
> > basically accepting something very similar to this patch.
> > 
> > But not exactly like this :).
> > 
> > Let's see what are the requirements.
> > 
> > If
> > 
> > 1. We do not trust the device (so we want to use a bounce buffer with it)
> > 2. DMA address is also a physical address of a buffer
> > 
> > then we should use DMA API with virtio.
> > 
> > 
> > sev_active() above is one way to put (1).  I can't say I love it but
> > it's tolerable.
> > 
> > 
> > But we also want promise from DMA API about 2.
> > 
> > 
> > Without promise 2 we simply can't use DMA API with a legacy device.
> > 
> > 
> > Otherwise, on a SEV system with an IOMMU which isn't 1:1
> > and with a virtio device without ACCESS_PLATFORM, we are trying
> > to pass a virtual address, and devices without ACCESS_PLATFORM
> > can only access CPU physical addresses.
> > 
> > So something like:
> > 
> > dma_addr_is_phys_addr?
> 
> 
> On our Secure pseries platform,  dma address is physical address and this
> proposal will help us, use DMA API. 
> 
> On our normal pseries platform, dma address is physical address too.
> But we do not necessarily need to use the DMA API.  We can use the DMA
> API, but our handlers will do the same thing, the generic virtio handlers
> would do. If there is an opt-out option; even when dma addr is same as
> physical addr, than there will be less code duplication.
> 
> Would something like this be better.
> 
> (dma_addr_is_phys_addr  && arch_want_to_use_dma_api()) ?
> 
> 
> RP

I think sev_active() is an OK replacement for arch_want_to_use_dma_api.
So just the addition of dma_addr_is_phys_addr would be enough.

> 
> > -- 
> > MST
> 
> -- 
> Ram Pai
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
