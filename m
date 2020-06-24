Return-Path: <SRS0=9F5p=AF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10093C433DF
	for <iommu@archiver.kernel.org>; Wed, 24 Jun 2020 20:47:32 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D080B2081A
	for <iommu@archiver.kernel.org>; Wed, 24 Jun 2020 20:47:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NF2dsNPS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D080B2081A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id A363A8852E;
	Wed, 24 Jun 2020 20:47:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QbmmvXdWKD1S; Wed, 24 Jun 2020 20:47:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 19EFF88528;
	Wed, 24 Jun 2020 20:47:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0672BC0888;
	Wed, 24 Jun 2020 20:47:31 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 12D76C016F
 for <iommu@lists.linux-foundation.org>; Wed, 24 Jun 2020 20:47:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 011CA2039E
 for <iommu@lists.linux-foundation.org>; Wed, 24 Jun 2020 20:47:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id z7lqFQ6CwdlW for <iommu@lists.linux-foundation.org>;
 Wed, 24 Jun 2020 20:47:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by silver.osuosl.org (Postfix) with ESMTPS id CB9432039C
 for <iommu@lists.linux-foundation.org>; Wed, 24 Jun 2020 20:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593031647;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O1reBoQYH57HQ1CEDrheXYLt8D4SLeQ87NHH75QUkc8=;
 b=NF2dsNPSLYo7W0d3DNoeyIVdLTNNbaMA60M8XYx9HQ+l98H+WW5j1NEUuXmPPwVryAFma9
 dm4dNs7ngtCk+zwxM4GDgSyjQsyqEED1UWYl564Lch1lZ7Ua6sEgexuTCYciYjqWPPlCm6
 ivgeAbpDdfyneMU3i0RbZJc31rRxL1g=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-478-7XRDqIgdPNWJR9KhniJrFQ-1; Wed, 24 Jun 2020 16:47:26 -0400
X-MC-Unique: 7XRDqIgdPNWJR9KhniJrFQ-1
Received: by mail-wr1-f72.google.com with SMTP id z3so4077181wrr.7
 for <iommu@lists.linux-foundation.org>; Wed, 24 Jun 2020 13:47:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=O1reBoQYH57HQ1CEDrheXYLt8D4SLeQ87NHH75QUkc8=;
 b=Ebh1HmoQtt+tDbz2r5KF06L3nZgokebRBqtch4p+G+kUlhtDyCg6Fq8cxH0c3d9cd9
 Eep2y3db/lVYQFvpfxKRFzQIK4vrnN+rcPk1W9UVrX3RIAlFUeyYvvZqew0tPBWytStV
 BlvN5/hOIFh/alZm8PQUeH0SRyMgNsjX9lE8MVwgAdKdMGUC2W0q4KCkPWOgxhSS4rbr
 1HTHMiD6EiN9ygynD5BhNYpv6DMc11TkgrLa7ZiYT4f4apAa7xL2/CcG1KZMZNb9nGCk
 rjBDSFbXydDMKTOmJ4rO5MckE0clZQ+fO1WEgJsli+zVmJni8adnaQmgy4O72MgmhtzS
 lPyQ==
X-Gm-Message-State: AOAM531hnY1JR15+XN11962wJqcwZ6gg/UvewT4bs0XRHbHdrgjQsNWa
 x4IPEx8ztHdY1Pd2InTwo1Zxgu3ZA0GOj6j0kXX3rdccyG8XXWMpHGXUy4RAocya8x5rmZTMGI5
 LHCubTjx7pPimldCXslQ/+A9WrGunoQ==
X-Received: by 2002:adf:ed47:: with SMTP id u7mr30096024wro.201.1593031644767; 
 Wed, 24 Jun 2020 13:47:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxPnaDNUPfot+ph5kW9eA3bmRXVnTYtGfhIgsVyoq9C+ZHJySjaF/DLGkUFrdWo8f0RjJM2sQ==
X-Received: by 2002:adf:ed47:: with SMTP id u7mr30096000wro.201.1593031644489; 
 Wed, 24 Jun 2020 13:47:24 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 v7sm28870842wrp.45.2020.06.24.13.47.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2020 13:47:23 -0700 (PDT)
Date: Wed, 24 Jun 2020 16:47:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Stabellini <sstabellini@kernel.org>
Subject: Re: [PATCH] xen: introduce xen_vring_use_dma
Message-ID: <20200624163940-mutt-send-email-mst@kernel.org>
References: <20200624091732.23944-1-peng.fan@nxp.com>
 <20200624050355-mutt-send-email-mst@kernel.org>
 <alpine.DEB.2.21.2006241047010.8121@sstabellini-ThinkPad-T480s>
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2006241047010.8121@sstabellini-ThinkPad-T480s>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: jgross@suse.com, Peng Fan <peng.fan@nxp.com>, konrad.wilk@oracle.com,
 jasowang@redhat.com, x86@kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 linux-imx@nxp.com, xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com,
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

On Wed, Jun 24, 2020 at 10:59:47AM -0700, Stefano Stabellini wrote:
> On Wed, 24 Jun 2020, Michael S. Tsirkin wrote:
> > On Wed, Jun 24, 2020 at 05:17:32PM +0800, Peng Fan wrote:
> > > Export xen_swiotlb for all platforms using xen swiotlb
> > > 
> > > Use xen_swiotlb to determine when vring should use dma APIs to map the
> > > ring: when xen_swiotlb is enabled the dma API is required. When it is
> > > disabled, it is not required.
> > > 
> > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > 
> > Isn't there some way to use VIRTIO_F_IOMMU_PLATFORM for this?
> > Xen was there first, but everyone else is using that now.
> 
> Unfortunately it is complicated and it is not related to
> VIRTIO_F_IOMMU_PLATFORM :-(
> 
> 
> The Xen subsystem in Linux uses dma_ops via swiotlb_xen to translate
> foreign mappings (memory coming from other VMs) to physical addresses.
> On x86, it also uses dma_ops to translate Linux's idea of a physical
> address into a real physical address (this is unneeded on ARM.)
> 
> 
> So regardless of VIRTIO_F_IOMMU_PLATFORM, dma_ops should be used on Xen/x86
> always and on Xen/ARM if Linux is Dom0 (because it has foreign
> mappings.) That is why we have the if (xen_domain) return true; in
> vring_use_dma_api.

VIRTIO_F_IOMMU_PLATFORM makes guest always use DMA ops.

Xen hack predates VIRTIO_F_IOMMU_PLATFORM so it *also*
forces DMA ops even if VIRTIO_F_IOMMU_PLATFORM is clear.

Unfortunately as a result Xen never got around to
properly setting VIRTIO_F_IOMMU_PLATFORM.

I would like to make Xen do what everyone else is doing
which is just set VIRTIO_F_IOMMU_PLATFORM and then put
platform specific hacks inside DMA API.
Then we can think about deprecating the Xen hack in a
distance future, or hiding it behind a static branch, or something
like this.


> You might have noticed that I missed one possible case above: Xen/ARM
> DomU :-)
> 
> Xen/ARM domUs don't need swiotlb_xen, it is not even initialized. So if
> (xen_domain) return true; would give the wrong answer in that case.
> Linux would end up calling the "normal" dma_ops, not swiotlb-xen, and
> the "normal" dma_ops fail.
> 
> 
> The solution I suggested was to make the check in vring_use_dma_api more
> flexible by returning true if the swiotlb_xen is supposed to be used,
> not in general for all Xen domains, because that is what the check was
> really meant to do.

Why not fix DMA ops so they DTRT (nop) on Xen/ARM DomU? What is wrong with that?


> 
> In this regards I have two more comments:
> 
> - the comment on top of the check in vring_use_dma_api is still valid
> - the patch looks broken on x86: it should always return true, but it
>   returns false instead
> 
>  
> > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > index a2de775801af..768afd79f67a 100644
> > > --- a/drivers/virtio/virtio_ring.c
> > > +++ b/drivers/virtio/virtio_ring.c
> > > @@ -252,7 +252,7 @@ static bool vring_use_dma_api(struct virtio_device *vdev)
> > >  	 * the DMA API if we're a Xen guest, which at least allows
> > >  	 * all of the sensible Xen configurations to work correctly.
> > >  	 */
> > > -	if (xen_domain())
> > > +	if (xen_vring_use_dma())
> > >  		return true;
> > >  
> > >  	return false;
> > 
> > 
> > The comment above this should probably be fixed.
> 
> > 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
