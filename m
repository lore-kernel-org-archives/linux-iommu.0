Return-Path: <SRS0=5edT=4J=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80989C35646
	for <iommu@archiver.kernel.org>; Fri, 21 Feb 2020 15:57:03 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48E30206EF
	for <iommu@archiver.kernel.org>; Fri, 21 Feb 2020 15:57:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YjQiAcNd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48E30206EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 110A287598;
	Fri, 21 Feb 2020 15:57:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MHUki-9MqpYq; Fri, 21 Feb 2020 15:57:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4010C868CA;
	Fri, 21 Feb 2020 15:57:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 25DC9C1D81;
	Fri, 21 Feb 2020 15:57:02 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E597CC013E
 for <iommu@lists.linux-foundation.org>; Fri, 21 Feb 2020 15:57:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id DE4E2863D9
 for <iommu@lists.linux-foundation.org>; Fri, 21 Feb 2020 15:57:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6h6ceYCm1bcQ for <iommu@lists.linux-foundation.org>;
 Fri, 21 Feb 2020 15:57:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id EC6AE85F79
 for <iommu@lists.linux-foundation.org>; Fri, 21 Feb 2020 15:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582300618;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IY1e+IpasDBKdBXY1MmSfqqA042+XMPMI9OlNKO0Qbs=;
 b=YjQiAcNdwGqSjWHyeaFiuQ3Vp5vdMOv5xVG/2nxRd/KusIADYVqfpEcqmWZMiiBUYffU3N
 7jc7ModfpV3on9eykBXEiYVaazD61SevICvV8mptnAgh8dtqmCB0n66mXWsfNil3pImYdQ
 gam9E6T2Aeco9u7UlT+7xIPCgHYJPiI=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-mKmQ_v3JMv2p5G-FKVGRYA-1; Fri, 21 Feb 2020 10:56:57 -0500
X-MC-Unique: mKmQ_v3JMv2p5G-FKVGRYA-1
Received: by mail-qk1-f199.google.com with SMTP id e11so1988744qkl.8
 for <iommu@lists.linux-foundation.org>; Fri, 21 Feb 2020 07:56:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=IY1e+IpasDBKdBXY1MmSfqqA042+XMPMI9OlNKO0Qbs=;
 b=ITaRyW0kd/WtXmWPB++MCsFBe4yR5xaQ0RH/TWamO7d0yNJNNEzU+DXWVWJfLyM/el
 eB4o2I1r0W7aUZyMmTrekHkxVketi7FF+Wms/Z5dw9jnx0Se9V9H91CP3xuknROa2QWW
 m4hxDG/dmsyFpDOvsLPZz7VBb18SeWSh43D2njsrOm03Lgx0HJq0IM9UA3QXS9q43f6A
 HQMp+1Pt9iQ09FYHghKQSDhVLqhQuBOOEIzh8HR8NpBdBoywxZKCDWvs426Pbn7kk+gn
 A3Y+Kv3T0HC0QrXPo7SuixBdTL/gxUNlU+7KD/HyhfRQ94kV8VK7ETUBR+BZb2gZdH5P
 U3/Q==
X-Gm-Message-State: APjAAAUDDnqBypZKqNfEIAMt0QWc4O7g6YBkiEGHjd2+iimhMo0NE+9G
 t8yvT3/MfMnIeJeI++UnzAz/3bbnM2kLuUp9I7Kb9fgKLT9WTeJ9Zll5ETyCHzONpHv0Fnj0DfF
 4Irc9tNQUycQozdPAa9fG38Id5LHr2g==
X-Received: by 2002:a37:903:: with SMTP id 3mr34303231qkj.388.1582300616572;
 Fri, 21 Feb 2020 07:56:56 -0800 (PST)
X-Google-Smtp-Source: APXvYqw7hKwRKDnx5YP1WMu4iLdwz2u2ubysXuXBnyyriKxZbi7qofpxbarVNM7JFowLgzZ6blC18w==
X-Received: by 2002:a37:903:: with SMTP id 3mr34303200qkj.388.1582300616024;
 Fri, 21 Feb 2020 07:56:56 -0800 (PST)
Received: from redhat.com (bzq-109-67-14-209.red.bezeqint.net. [109.67.14.209])
 by smtp.gmail.com with ESMTPSA id k50sm1707012qtc.90.2020.02.21.07.56.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2020 07:56:54 -0800 (PST)
Date: Fri, 21 Feb 2020 10:56:45 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH 2/2] virtio: let virtio use DMA API when guest RAM is
 protected
Message-ID: <20200221104901-mutt-send-email-mst@kernel.org>
References: <20200220160606.53156-1-pasic@linux.ibm.com>
 <20200220160606.53156-3-pasic@linux.ibm.com>
 <20200220154904-mutt-send-email-mst@kernel.org>
 <20200221141230.13eebc35.pasic@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20200221141230.13eebc35.pasic@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-s390@vger.kernel.org, Janosch Frank <frankja@linux.ibm.com>,
 "Lendacky, Thomas" <Thomas.Lendacky@amd.com>, Jason Wang <jasowang@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Ram Pai <linuxram@us.ibm.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 iommu@lists.linux-foundation.org, David Gibson <david@gibson.dropbear.id.au>,
 Michael Mueller <mimu@linux.ibm.com>,
 Viktor Mihajlovski <mihajlov@linux.ibm.com>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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

On Fri, Feb 21, 2020 at 02:12:30PM +0100, Halil Pasic wrote:
> On Thu, 20 Feb 2020 15:55:14 -0500
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Thu, Feb 20, 2020 at 05:06:06PM +0100, Halil Pasic wrote:
> > > Currently the advanced guest memory protection technologies (AMD SEV,
> > > powerpc secure guest technology and s390 Protected VMs) abuse the
> > > VIRTIO_F_IOMMU_PLATFORM flag to make virtio core use the DMA API, which
> > > is in turn necessary, to make IO work with guest memory protection.
> > > 
> > > But VIRTIO_F_IOMMU_PLATFORM a.k.a. VIRTIO_F_ACCESS_PLATFORM is really a
> > > different beast: with virtio devices whose implementation runs on an SMP
> > > CPU we are still fine with doing all the usual optimizations, it is just
> > > that we need to make sure that the memory protection mechanism does not
> > > get in the way. The VIRTIO_F_ACCESS_PLATFORM mandates more work on the
> > > side of the guest (and possibly he host side as well) than we actually
> > > need.
> > > 
> > > An additional benefit of teaching the guest to make the right decision
> > > (and use DMA API) on it's own is: removing the need, to mandate special
> > > VM configuration for guests that may run with protection. This is
> > > especially interesting for s390 as VIRTIO_F_IOMMU_PLATFORM pushes all
> > > the virtio control structures into the first 2G of guest memory:
> > > something we don't necessarily want to do per-default.
> > > 
> > > Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> > > Tested-by: Ram Pai <linuxram@us.ibm.com>
> > > Tested-by: Michael Mueller <mimu@linux.ibm.com>
> > 
> > This might work for you but it's fragile, since without
> > VIRTIO_F_ACCESS_PLATFORM hypervisor assumes it gets
> > GPA's, not DMA addresses.
> > 
> 
> Thanks for your constructive approach. I do want the hypervisor to
> assume it gets GPA's. My train of thought was that the guys that need
> to use IOVA's that are not GPA's when force_dma_unencrypted() will have
> to to specify VIRTIO_F_ACCESS_PLATFORM (at the device) anyway, because
> otherwise it won't work. But I see your point: in case of a
> mis-configuration and provided the DMA API returns IOVA's one could end
> up trying to touch wrong memory locations. But this should be similar to
> what would happen if DMA ops are not used, and memory is not made accessible.
> 
> > 
> > 
> > IOW this looks like another iteration of:
> > 
> > 	virtio: Support encrypted memory on powerpc secure guests
> > 
> > which I was under the impression was abandoned as unnecessary.
> 
> Unnecessary for powerpc because they do normal PCI. In the context of
> CCW there are only guest physical addresses (CCW I/O has no concept of
> IOMMU or IOVAs).
> 
> > 
> > 
> > To summarize, the necessary conditions for a hack along these lines
> > (using DMA API without VIRTIO_F_ACCESS_PLATFORM) are that we detect that:
> > 
> >   - secure guest mode is enabled - so we know that since we don't share
> >     most memory regular virtio code won't
> >     work, even though the buggy hypervisor didn't set VIRTIO_F_ACCESS_PLATFORM
> 
> force_dma_unencrypted(&vdev->dev) is IMHO exactly about this.
> 
> >   - DMA API is giving us addresses that are actually also physical
> >     addresses
> 
> In case of s390 this is given.
> I talked with the power people before
> posting this, and they ensured me they can are willing to deal with
> this. I was hoping to talk abut this with the AMD SEV people here (hence
> the cc).

We'd need a part of DMA API that promises this though. Platform
maintainers aren't going to go out of their way to do the
right thing just for virtio, and I can't track all arches
to make sure they don't violate virtio requirements.

> 
> >   - Hypervisor is buggy and didn't enable VIRTIO_F_ACCESS_PLATFORM
> > 
> 
> I don't get this point. The argument where the hypervisor is buggy is a
> bit hard to follow for me. If hypervisor is buggy we have already lost
> anyway most of the time, or?

If VIRTIO_F_ACCESS_PLATFORM is set then things just work.  If
VIRTIO_F_ACCESS_PLATFORM is clear device is supposed to have access to
all of memory.  You can argue in various ways but it's easier to just
declare a behaviour that violates this a bug. Which might still be worth
working around, for various reasons.


> > I don't see how this patch does this.
> 
> I do get your point. I don't know of a good way to check that DMA API
> is giving us addresses that are actually physical addresses, and the
> situation you describe definitely has some risk to it.

One way would be to extend the DMA API with such an API.

Another would be to make virtio always use DMA API
and hide the logic in there.
This second approach is not easy, in particular since DMA API adds
a bunch of overhead which we need to find ways to
measure and mitigate.


> 
> Let me comment on other ideas that came up. I would be very happy to go
> with the best one. Thank you very much.
> 
> Regards,
> Halil
> 
> > 
> > 
> > > ---
> > >  drivers/virtio/virtio_ring.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > index 867c7ebd3f10..fafc8f924955 100644
> > > --- a/drivers/virtio/virtio_ring.c
> > > +++ b/drivers/virtio/virtio_ring.c
> > > @@ -243,6 +243,9 @@ static bool vring_use_dma_api(struct virtio_device *vdev)
> > >  	if (!virtio_has_iommu_quirk(vdev))
> > >  		return true;
> > >  
> > > +	if (force_dma_unencrypted(&vdev->dev))
> > > +		return true;
> > > +
> > >  	/* Otherwise, we are left to guess. */
> > >  	/*
> > >  	 * In theory, it's possible to have a buggy QEMU-supposed
> > > -- 
> > > 2.17.1
> > 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
