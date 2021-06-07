Return-Path: <SRS0=ynGH=LB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE244C47095
	for <iommu@archiver.kernel.org>; Mon,  7 Jun 2021 15:42:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99A3C61073
	for <iommu@archiver.kernel.org>; Mon,  7 Jun 2021 15:42:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99A3C61073
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 70987836EA;
	Mon,  7 Jun 2021 15:42:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VO3bVOnKc3_t; Mon,  7 Jun 2021 15:42:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1487183750;
	Mon,  7 Jun 2021 15:42:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E47EDC000E;
	Mon,  7 Jun 2021 15:42:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 93461C0001
 for <iommu@lists.linux-foundation.org>; Mon,  7 Jun 2021 15:41:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7A2FF4019B
 for <iommu@lists.linux-foundation.org>; Mon,  7 Jun 2021 15:41:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id v4wn9EYxL0Ak for <iommu@lists.linux-foundation.org>;
 Mon,  7 Jun 2021 15:41:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 82454400CD
 for <iommu@lists.linux-foundation.org>; Mon,  7 Jun 2021 15:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1623080514;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4A1ZmmoADOeXeNhTZ74YAKcHNecX4lcp36tJa9lAB8U=;
 b=MYOnkdg0KiR+vJS28Ow/8nygMs7FrbhnvrY/tpdTT8Ae7KNKMOC8HNZFThSDtuZhPYKDdY
 t427m3pMok1SVdC3Qqz0p+ssxqLTxfnrSzWYjwFnPP4U4lgulHSUCqBlVvfeokZ04nTHGI
 Cssta4IKG2qSqB3ZbKMDIz5j5PO5vhE=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-298-yvwEGMjEP-WcMxfJ1VM6LA-1; Mon, 07 Jun 2021 11:41:51 -0400
X-MC-Unique: yvwEGMjEP-WcMxfJ1VM6LA-1
Received: by mail-oo1-f70.google.com with SMTP id
 c25-20020a4ad7990000b029020e67cc1879so11260675oou.18
 for <iommu@lists.linux-foundation.org>; Mon, 07 Jun 2021 08:41:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4A1ZmmoADOeXeNhTZ74YAKcHNecX4lcp36tJa9lAB8U=;
 b=rzwEgMukXJ6wR+tjQ4K0Qq52Xm9wwZBObeVPL6HIvdYfijdatymrt1fEZZrrfZ8QEl
 z6EojAO0YtwhsHKSZm6S1k0I0+m+AoqxnY98gJjD2peT0HxFjV1UVtk2mFUwXhLiXm3s
 Kk5iUor5bP2YtYzgfYl/ecy4+rQoRu767cOIw79ncF7iUg1mJmQ3ImPzx9dix4hlOZj8
 0jflUbY9fkVA5H7Vu6Nm65nfw+6BZjrkYyPqTiDzDLWyEN1GeqccLRYYseBGaa4NDZBT
 FfgJKw0sIIJHZ4LiCXa8i6H0QM4uYjpa+mNGTQCHoX6Rx/U1HYjk5G8VLJhAPMc/oY90
 aogQ==
X-Gm-Message-State: AOAM530BzfaVCHvDwSggQNeHefQ9hnDhVzXxsaNoaZ+koIbVPjfaxH9g
 W+DjPnUFGHzhdJBFKenggsxmtkt89i7tXOrkmIRK91JFpBMSV2QMRvBKVlmu3vw9VxClYERnqx6
 dzrdc4epoaq1A4EYs6gmLkxcGZ6ebHA==
X-Received: by 2002:a05:6830:2472:: with SMTP id
 x50mr14281116otr.277.1623080510429; 
 Mon, 07 Jun 2021 08:41:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz/RofL2Q+8xiXeUnngaY/JJcX9WjaL0+G657PUCf43sOCgIlYvMmiGQ+4O43ZMMQuPVTHGYg==
X-Received: by 2002:a05:6830:2472:: with SMTP id
 x50mr14281089otr.277.1623080510058; 
 Mon, 07 Jun 2021 08:41:50 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
 by smtp.gmail.com with ESMTPSA id t21sm2412663otd.35.2021.06.07.08.41.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Jun 2021 08:41:49 -0700 (PDT)
Date: Mon, 7 Jun 2021 09:41:48 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [RFC] /dev/ioasid uAPI proposal
Message-ID: <20210607094148.7e2341fc.alex.williamson@redhat.com>
In-Reply-To: <20210604230108.GB1002214@nvidia.com>
References: <MWHPR11MB1886469C0136C6523AB158B68C3B9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210604122830.GK1002214@nvidia.com>
 <20210604092620.16aaf5db.alex.williamson@redhat.com>
 <815fd392-0870-f410-cbac-859070df1b83@redhat.com>
 <20210604155016.GR1002214@nvidia.com>
 <30e5c597-b31c-56de-c75e-950c91947d8f@redhat.com>
 <20210604160336.GA414156@nvidia.com>
 <2c62b5c7-582a-c710-0436-4ac5e8fd8b39@redhat.com>
 <20210604172207.GT1002214@nvidia.com>
 <20210604152918.57d0d369.alex.williamson@redhat.com>
 <20210604230108.GB1002214@nvidia.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, David Woodhouse <dwmw2@infradead.org>,
 Jason Wang <jasowang@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Robin Murphy <robin.murphy@arm.com>,
 David Gibson <david@gibson.dropbear.id.au>
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

On Fri, 4 Jun 2021 20:01:08 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Fri, Jun 04, 2021 at 03:29:18PM -0600, Alex Williamson wrote:
> > On Fri, 4 Jun 2021 14:22:07 -0300
> > Jason Gunthorpe <jgg@nvidia.com> wrote:
> >   
> > > On Fri, Jun 04, 2021 at 06:10:51PM +0200, Paolo Bonzini wrote:  
> > > > On 04/06/21 18:03, Jason Gunthorpe wrote:    
> > > > > On Fri, Jun 04, 2021 at 05:57:19PM +0200, Paolo Bonzini wrote:    
> > > > > > I don't want a security proof myself; I want to trust VFIO to make the right
> > > > > > judgment and I'm happy to defer to it (via the KVM-VFIO device).
> > > > > > 
> > > > > > Given how KVM is just a device driver inside Linux, VMs should be a slightly
> > > > > > more roundabout way to do stuff that is accessible to bare metal; not a way
> > > > > > to gain extra privilege.    
> > > > > 
> > > > > Okay, fine, lets turn the question on its head then.
> > > > > 
> > > > > VFIO should provide a IOCTL VFIO_EXECUTE_WBINVD so that userspace VFIO
> > > > > application can make use of no-snoop optimizations. The ability of KVM
> > > > > to execute wbinvd should be tied to the ability of that IOCTL to run
> > > > > in a normal process context.
> > > > > 
> > > > > So, under what conditions do we want to allow VFIO to giave a process
> > > > > elevated access to the CPU:    
> > > > 
> > > > Ok, I would definitely not want to tie it *only* to CAP_SYS_RAWIO (i.e.
> > > > #2+#3 would be worse than what we have today), but IIUC the proposal (was it
> > > > yours or Kevin's?) was to keep #2 and add #1 with an enable/disable ioctl,
> > > > which then would be on VFIO and not on KVM.      
> > > 
> > > At the end of the day we need an ioctl with two arguments:
> > >  - The 'security proof' FD (ie /dev/vfio/XX, or /dev/ioasid, or whatever)
> > >  - The KVM FD to control wbinvd support on
> > > 
> > > Philosophically it doesn't matter too much which subsystem that ioctl
> > > lives, but we have these obnoxious cross module dependencies to
> > > consider.. 
> > > 
> > > Framing the question, as you have, to be about the process, I think
> > > explains why KVM doesn't really care what is decided, so long as the
> > > process and the VM have equivalent rights.
> > > 
> > > Alex, how about a more fleshed out suggestion:
> > > 
> > >  1) When the device is attached to the IOASID via VFIO_ATTACH_IOASID
> > >     it communicates its no-snoop configuration:  
> > 
> > Communicates to whom?  
> 
> To the /dev/iommu FD which will have to maintain a list of devices
> attached to it internally.
> 
> > >      - 0 enable, allow WBINVD
> > >      - 1 automatic disable, block WBINVD if the platform
> > >        IOMMU can police it (what we do today)
> > >      - 2 force disable, do not allow BINVD ever  
> > 
> > The only thing we know about the device is whether or not Enable
> > No-snoop is hard wired to zero, ie. it either can't generate no-snoop
> > TLPs ("coherent-only") or it might ("assumed non-coherent").    
> 
> Here I am outlining the choice an also imagining we might want an
> admin knob to select the three.

You're calling this an admin knob, which to me suggests a global module
option, so are you trying to implement both an administrator and a user
policy?  ie. the user can create scenarios where access to wbinvd might
be justified by hardware/IOMMU configuration, but can be limited by the
admin?

For example I proposed that the ioasidfd would bear the responsibility
of a wbinvd ioctl and therefore validate the user's access to enable
wbinvd emulation w/ KVM, so I'm assuming this module option lives
there.  I essentially described the "enable" behavior in my previous
reply, user has access to wbinvd if owning a non-coherent capable
device managed in a non-coherent IOASID.  Yes, the user IOASID
configuration controls the latter half of this.

What then is "automatic" mode?  The user cannot create a non-coherent
IOASID with a non-coherent device if the IOMMU supports no-snoop
blocking?  Do they get a failure?  Does it get silently promoted to
coherent?

In "disable" mode, I think we're just narrowing the restriction
further, a non-coherent capable device cannot be used except in a
forced coherent IOASID.

> > If we're putting the policy decision in the hands of userspace they
> > should have access to wbinvd if they own a device that is assumed
> > non-coherent AND it's attached to an IOMMU (page table) that is not
> > blocking no-snoop (a "non-coherent IOASID").  
> 
> There are two parts here, like Paolo was leading too. If the process
> has access to WBINVD and then if such an allowed process tells KVM to
> turn on WBINVD in the guest.
> 
> If the process has a device and it has a way to create a non-coherent
> IOASID, then that process has access to WBINVD.
> 
> For security it doesn't matter if the process actually creates the
> non-coherent IOASID or not. An attacker will simply do the steps that
> give access to WBINVD.

Yes, at this point the user has the ability to create a configuration
where they could have access to wbinvd, but if they haven't created
such a configuration, is the wbinvd a no-op?

> The important detail is that access to WBINVD does not compell the
> process to tell KVM to turn on WBINVD. So a qemu with access to WBINVD
> can still choose to create a secure guest by always using IOMMU_CACHE
> in its page tables and not asking KVM to enable WBINVD.

Of course.

> This propsal shifts this policy decision from the kernel to userspace.
> qemu is responsible to determine if KVM should enable wbinvd or not
> based on if it was able to create IOASID's with IOMMU_CACHE.

QEMU is responsible for making sure the VM is consistent; if
non-coherent DMA can occur, wbinvd is emulated.  But it's still the
KVM/IOASID connection that validates that access.

> > Conversely, a user could create a non-coherent IOASID and attach any
> > device to it, regardless of IOMMU backing capabilities.  Only if an
> > assumed non-coherent device is attached would the wbinvd be allowed.  
> 
> Right, this is exactly the point. Since the user gets to pick if the
> IOASID is coherent or not then an attacker can always reach WBINVD
> using only the device FD. Additional checks don't add to the security
> of the process.
> 
> The additional checks you are describing add to the security of the
> guest, however qemu is capable of doing them without more help from the
> kernel.
> 
> It is the strenth of Paolo's model that KVM should not be able to do
> optionally less, not more than the process itself can do.

I think my previous reply was working towards those guidelines.  I feel
like we're mostly in agreement, but perhaps reading past each other.
Nothing here convinced me against my previous proposal that the
ioasidfd bears responsibility for managing access to a wbinvd ioctl,
and therefore the equivalent KVM access.  Whether wbinvd is allowed or
no-op'd when the use has access to a non-coherent device in a
configuration where the IOMMU prevents non-coherent DMA is maybe still
a matter of personal preference.

> > > It is pretty simple from a /dev/ioasid perpsective, covers todays
> > > compat requirement, gives some future option to allow the no-snoop
> > > optimization, and gives a new option for qemu to totally block wbinvd
> > > no matter what.  
> > 
> > What do you imagine is the use case for totally blocking wbinvd?   
> 
> If wbinvd is really security important then an operator should endevor
> to turn it off. It can be safely turned off if the operator
> understands the SRIOV devices they are using. ie if you are only using
> mlx5 or a nvme then force it off and be secure, regardless of the
> platform capability.

Ok, I'm not opposed to something like a module option that restricts to
only coherent DMA, but we need to work through how that's exposed and
the userspace behavior.  The most obvious would be that a GET_INFO
ioctl on the ioasidfd indicates the restrictions, a flag on the IOASID
alloc indicates the coherency of the IOASID, and we fail any cases
where the admin policy or hardware support doesn't match (ie. alloc if
it's incompatible with policy, attach if the device/IOMMU backing
violates policy).  This is all a compatible layer with what I described
previously.  Thanks,

Alex

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
