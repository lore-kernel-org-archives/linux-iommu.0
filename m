Return-Path: <SRS0=C6HT=CX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 932CAC43461
	for <iommu@archiver.kernel.org>; Mon, 14 Sep 2020 22:33:35 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3977208DB
	for <iommu@archiver.kernel.org>; Mon, 14 Sep 2020 22:33:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zm/iWjnX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3977208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 3DB7587059;
	Mon, 14 Sep 2020 22:33:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0HbdAe-olsC3; Mon, 14 Sep 2020 22:33:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 3CCAE87054;
	Mon, 14 Sep 2020 22:33:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0834EC0859;
	Mon, 14 Sep 2020 22:33:32 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 19A2FC0051
 for <iommu@lists.linux-foundation.org>; Mon, 14 Sep 2020 22:33:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id EC8BF87059
 for <iommu@lists.linux-foundation.org>; Mon, 14 Sep 2020 22:33:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nN7as2y8+JBc for <iommu@lists.linux-foundation.org>;
 Mon, 14 Sep 2020 22:33:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [207.211.31.81])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 6FC2C87054
 for <iommu@lists.linux-foundation.org>; Mon, 14 Sep 2020 22:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600122808;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rjaf02v1R3x1zDA9n+pIS+ZUb4zwiX61GOvGB/O1OBA=;
 b=Zm/iWjnXPpAE6VT15DsG7/dx7PhAgiIUs3RezVlp/Eb1CyNcqdbraqrPhoXNyTgtSInRPx
 n721LZPBm4WRiToKgtpKmSjzZQSj8lJeB2e/XG4YazFtlAU8T6iykRWUIEaUt0I3z5i+7k
 d4jk+roiWs3QiYFP+kRjSIi7KkeheL8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-77-22uIGfMvN6uZMXtGoh0XvA-1; Mon, 14 Sep 2020 18:33:24 -0400
X-MC-Unique: 22uIGfMvN6uZMXtGoh0XvA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 67628802B70;
 Mon, 14 Sep 2020 22:33:22 +0000 (UTC)
Received: from x1.home (ovpn-112-71.phx2.redhat.com [10.3.112.71])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8D97E7B7B5;
 Mon, 14 Sep 2020 22:33:10 +0000 (UTC)
Date: Mon, 14 Sep 2020 16:33:10 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v7 00/16] vfio: expose virtual Shared Virtual Addressing
 to VMs
Message-ID: <20200914163310.450c8d6e@x1.home>
In-Reply-To: <20200914190057.GM904879@nvidia.com>
References: <1599734733-6431-1-git-send-email-yi.l.liu@intel.com>
 <411c81c0-f13c-37cc-6c26-cafb42b46b15@redhat.com>
 <20200914133113.GB1375106@myrica>
 <20200914134738.GX904879@nvidia.com>
 <20200914162247.GA63399@otc-nc-03>
 <20200914163354.GG904879@nvidia.com>
 <20200914105857.3f88a271@x1.home>
 <20200914174121.GI904879@nvidia.com>
 <20200914122328.0a262a7b@x1.home>
 <20200914190057.GM904879@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, kevin.tian@intel.com,
 "Raj, Ashok" <ashok.raj@intel.com>, kvm@vger.kernel.org,
 iommu@lists.linux-foundation.org, stefanha@gmail.com,
 Jason Wang <jasowang@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, jun.j.tian@intel.com, yi.y.sun@intel.com,
 hao.wu@intel.com
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

On Mon, 14 Sep 2020 16:00:57 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Mon, Sep 14, 2020 at 12:23:28PM -0600, Alex Williamson wrote:
> > On Mon, 14 Sep 2020 14:41:21 -0300
> > Jason Gunthorpe <jgg@nvidia.com> wrote:
> >   
> > > On Mon, Sep 14, 2020 at 10:58:57AM -0600, Alex Williamson wrote:
> > >    
> > > > "its own special way" is arguable, VFIO is just making use of what's
> > > > being proposed as the uapi via its existing IOMMU interface.    
> > > 
> > > I mean, if we have a /dev/sva then it makes no sense to extend the
> > > VFIO interfaces with the same stuff. VFIO should simply accept a PASID
> > > created from /dev/sva and use it just like any other user-DMA driver
> > > would.  
> > 
> > I don't think that's absolutely true.  By the same logic, we could say
> > that pci-sysfs provides access to PCI BAR and config space
> > resources,  
> 
> No, it is the reverse, VFIO is a better version of pci-sysfs, so
> pci-sysfs is the one that is obsoleted by VFIO. Similarly a /dev/sva
> would be the superset interface for PASID, so whatver VFIO has would
> be obsoleted.
> 
> It would be very unusual for the kernel to have to 'preferred'
> interfaces for the same thing, IMHO. The review process for uAPI
> should really prevent that by allowing all interests to be served
> while the uAPI is designed.
> 
> > the VFIO device interface duplicates part of that interface therefore it
> > should be abandoned.  But in reality, VFIO providing access to those
> > resources puts those accesses within the scope and control of the VFIO
> > interface.  
> 
> Not clear to my why VFIO needs that. PASID seems quite orthogonal from
> VFIO to me.


Can you explain that further, or spit-ball what you think this /dev/sva
interface looks like and how a user might interact between vfio and
this new interface?  The interface proposed here definitely does not
seem orthogonal to the vfio IOMMU interface, ie. selecting a specific
IOMMU domain mode during vfio setup, allocating pasids and associating
them with page tables for that two-stage IOMMU setup, performing cache
invalidations based on page table updates, etc.  How does it make more
sense for a vIOMMU to setup some aspects of the IOMMU through vfio and
others through a TBD interface?


> > > This has already happened, the SVA patches generally allow unpriv user
> > > space to allocate a PASID for their process.
> > > 
> > > If a device implements a mdev shared with a kernel driver (like IDXD)
> > > then it will be sharing that PASID pool across both drivers. In this
> > > case it makes no sense that VFIO has PASID quota logic because it has
> > > an incomplete view. It could only make sense if VFIO is the exclusive
> > > owner of the bus/device/function.
> > > 
> > > The tracking logic needs to be global.. Most probably in some kind of
> > > PASID cgroup controller?  
> > 
> > AIUI, that doesn't exist yet, so it makes sense that VFIO, as the
> > mechanism through which a user would allocate a PASID,   
> 
> VFIO is not the exclusive user interface for PASID. Other SVA drivers
> will allocate PASIDs. Any quota has to be implemented by the IOMMU
> layer, and shared across all drivers.


The IOMMU needs to allocate PASIDs, so in that sense it enforces a
quota via the architectural limits, but is the IOMMU layer going to
distinguish in-kernel versus user limits?  A cgroup limit seems like a
good idea, but that's not really at the IOMMU layer either and I don't
see that a /dev/sva and vfio interface couldn't both support a cgroup
type quota.

 
> > space.  Also, "unprivileged user" is a bit of a misnomer in this
> > context as the VFIO user must be privileged with ownership of a device
> > before they can even participate in PASID allocation.  Is truly
> > unprivileged access reasonable for a limited resource?  
> 
> I'm not talking about VFIO, I'm talking about the other SVA drivers. I
> expect some of them will be unpriv safe, like IDXD, for
> instance.
> 
> Some way to manage the limited PASID resource will be necessary beyond
> just VFIO.

And it's not clear that they'll have compatible requirements.  A
userspace idxd driver might have limited needs versus a vIOMMU backend.
Does a single quota model adequately support both or are we back to the
differences between access to a device and ownership of a device?
Maybe a single pasid per user makes sense in the former.  If we could
bring this discussion to some sort of more concrete proposal it might
be easier to weigh the choices.
 
> > QEMU typically runs in a sandbox with limited access, when a device or
> > mdev is assigned to a VM, file permissions are configured to allow that
> > access.  QEMU doesn't get to poke at any random dev file it likes,
> > that's part of how userspace reduces the potential attack surface.  
> 
> Plumbing the exact same APIs through VFIO's uAPI vs /dev/sva doesn't
> reduce the attack surface. qemu can simply include /dev/sva in the
> sandbox when using VFIO with no increase in attack surface from this
> proposed series.

APIs confined to the ownership model that vfio already enforces might
absolutely present a more limited attack surface than some new
interface intended to provide universal sva resource access.  We don't
know until we see it.  The real argument would be whether we have a
more hardened interface due to more review from more users.

 
> > This series is a blueprint within the context of the ownership and
> > permission model that VFIO already provides.  It doesn't seem like we
> > can pluck that out on its own, nor is it necessarily the case that VFIO
> > wouldn't want to provide PASID services within its own API even if we
> > did have this undefined /dev/sva interface.  
> 
> I don't see what you do - VFIO does not own PASID, and in this
> vfio-mdev mode it does not own the PCI device/IOMMU either. So why
> would this need to be part of the VFIO owernship and permission model?

Doesn't the PASID model essentially just augment the requester ID IOMMU
model so as to manage the IOVAs for a subdevice of a RID?  The vfio
model builds on a user's access to a vfio group to entitle them to
allocate IOMMU resources, or in this case PASIDs.  What elevates a user
to be able to allocate such resources in this new proposal?  Do they
need a device at all?  It's not clear to me why RID based IOMMU
management fits within vfio's scope, but PASID based does not.  Seems
like that would chip away at aux domains in general.  Thanks,

Alex

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
