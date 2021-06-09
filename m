Return-Path: <SRS0=g+Up=LD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D237CC48BCD
	for <iommu@archiver.kernel.org>; Wed,  9 Jun 2021 18:10:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68C6A613D7
	for <iommu@archiver.kernel.org>; Wed,  9 Jun 2021 18:10:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68C6A613D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1998340572;
	Wed,  9 Jun 2021 18:10:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7wg9w_Mibkqz; Wed,  9 Jun 2021 18:10:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6C99740570;
	Wed,  9 Jun 2021 18:10:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 46604C000B;
	Wed,  9 Jun 2021 18:10:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9EDD2C000B
 for <iommu@lists.linux-foundation.org>; Wed,  9 Jun 2021 18:10:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7FBC040569
 for <iommu@lists.linux-foundation.org>; Wed,  9 Jun 2021 18:10:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hYKVzHUG7q61 for <iommu@lists.linux-foundation.org>;
 Wed,  9 Jun 2021 18:10:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0B32C40535
 for <iommu@lists.linux-foundation.org>; Wed,  9 Jun 2021 18:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1623262199;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JOwht44zIwnvhZGhBylEJZ1HMLRCQIT09lPxcbLsgFw=;
 b=hCrbkmYnidzmtM9Akm9qDRx3lFgdd6h5i/A5rRMLwmGHjz93aC8rJHMWAnEwq81SDxHeB0
 YRIwhP4sicEsQeLJFXJ80HLkFSNvNkxPgedcJEBIBedSEYi0/EhFww+FvIqtwsRu59llcF
 fK3YK+JYTo33eE5kKhRX9Ytrp/DyKsY=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-400-TFNoIKoFMReRy6h8BzpQvQ-1; Wed, 09 Jun 2021 14:09:52 -0400
X-MC-Unique: TFNoIKoFMReRy6h8BzpQvQ-1
Received: by mail-oi1-f198.google.com with SMTP id
 p5-20020acabf050000b02901eed1481b82so9929627oif.20
 for <iommu@lists.linux-foundation.org>; Wed, 09 Jun 2021 11:09:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:organization:mime-version:content-transfer-encoding;
 bh=JOwht44zIwnvhZGhBylEJZ1HMLRCQIT09lPxcbLsgFw=;
 b=Wu+ovuNpNQjZq6rt3h3faFPl8SPddz6gaP4ea5BlkTNXVTN0SYZHbUySqF+lrD0HYd
 kAV4o64VR2dnJbj2RqFsjrQM+/ZYSSjOXpMCCCiC1hrEBrw0V7X5ydEs0/3/jm1FGlwx
 ZTEt4HR/lTPeU6k78llDFtSpXEyFx/hmRQ/RnRrcBYzPRrn99yLH901rtb5fSNO9+1NZ
 2QHFEt/N1N90qMJGvf0yekxY98I3bzH5pO3pjb5N7RSiGkbbWFtWwU0D0MAasLCswVyU
 q9rSHkUBSKmtkByiZvGX/7vEb/Qk9kY+sudQfJ2wjagx2P8LogZyLvoDOPfRWdRMbzrg
 Bi8Q==
X-Gm-Message-State: AOAM532mGX5r+G0CnVEp/UJAz2xh7BZRGm7VpPmzESuUDnbTWbMfoYCI
 hcs4JENDiYp74cybEOMuLsDBDtYa50C/LZiReZg9LGGhCuiH02Nt4t3OwioLfTw+7H2pRuQ98sj
 He9m+SpNsl4kvn/y2bVtxXcKY332OMQ==
X-Received: by 2002:a9d:738b:: with SMTP id j11mr586983otk.228.1623262191544; 
 Wed, 09 Jun 2021 11:09:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzL4iBTnFQwcrcHt1XtTg0skstDsIFzQVz9wujpxn5h4yklYHUBRGE6+Rx/IdOFv3xTrym92w==
X-Received: by 2002:a9d:738b:: with SMTP id j11mr586961otk.228.1623262191272; 
 Wed, 09 Jun 2021 11:09:51 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
 by smtp.gmail.com with ESMTPSA id j7sm104864oij.25.2021.06.09.11.09.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Jun 2021 11:09:50 -0700 (PDT)
Date: Wed, 9 Jun 2021 12:09:49 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [RFC] /dev/ioasid uAPI proposal
Message-ID: <20210609120949.602fa078.alex.williamson@redhat.com>
In-Reply-To: <MWHPR11MB18861A89FE6620921E7A7CAC8C369@MWHPR11MB1886.namprd11.prod.outlook.com>
References: <20210604092620.16aaf5db.alex.williamson@redhat.com>
 <815fd392-0870-f410-cbac-859070df1b83@redhat.com>
 <20210604155016.GR1002214@nvidia.com>
 <30e5c597-b31c-56de-c75e-950c91947d8f@redhat.com>
 <20210604160336.GA414156@nvidia.com>
 <2c62b5c7-582a-c710-0436-4ac5e8fd8b39@redhat.com>
 <20210604172207.GT1002214@nvidia.com>
 <2d1ad075-bec6-bfb9-ce71-ed873795e973@redhat.com>
 <20210607175926.GJ1002214@nvidia.com>
 <fdb2f38c-da1f-9c12-af44-22df039fcfea@redhat.com>
 <20210608131547.GE1002214@nvidia.com>
 <89d30977-119c-49f3-3bf6-d3f7104e07d8@redhat.com>
 <20210608124700.7b9aa5a6.alex.williamson@redhat.com>
 <MWHPR11MB18861A89FE6620921E7A7CAC8C369@MWHPR11MB1886.namprd11.prod.outlook.com>
Organization: Red Hat
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 David Woodhouse <dwmw2@infradead.org>, Jason Wang <jasowang@redhat.com>,
 LKML <linux-kernel@vger.kernel.org>, Kirti Wankhede <kwankhede@nvidia.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Robin Murphy <robin.murphy@arm.com>,
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

On Wed, 9 Jun 2021 02:49:32 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:

> > From: Alex Williamson <alex.williamson@redhat.com>
> > Sent: Wednesday, June 9, 2021 2:47 AM
> > 
> > On Tue, 8 Jun 2021 15:44:26 +0200
> > Paolo Bonzini <pbonzini@redhat.com> wrote:
> >   
> > > On 08/06/21 15:15, Jason Gunthorpe wrote:  
> > > > On Tue, Jun 08, 2021 at 09:56:09AM +0200, Paolo Bonzini wrote:
> > > >  
> > > >>>> Alternatively you can add a KVM_DEV_IOASID_{ADD,DEL} pair of  
> > ioctls. But it  
> > > >>>> seems useless complication compared to just using what we have  
> > now, at least  
> > > >>>> while VMs only use IOASIDs via VFIO.  
> > > >>>
> > > >>> The simplest is KVM_ENABLE_WBINVD(<fd security proof>) and be  
> > done  
> > > >>> with it.  
> > 
> > Even if we were to relax wbinvd access to any device (capable of
> > no-snoop or not) in any IOMMU configuration (blocking no-snoop or not),
> > I think as soon as we say "proof" is required to gain this access then
> > that proof should be ongoing for the life of the access.
> > 
> > That alone makes this more than a "I want this feature, here's my
> > proof", one-shot ioctl.  Like the groupfd enabling a path for KVM to
> > ask if that group is non-coherent and holding a group reference to
> > prevent the group from being used to authorize multiple KVM instances,
> > the ioasidfd proof would need to minimally validate that devices are
> > present and provide some reference to enforce that model as ongoing, or
> > notifier to indicate an end of that authorization.  I don't think we
> > can simplify that out of the equation or we've essentially invalidated
> > that the proof is really required.
> >   
> > > >>
> > > >> The simplest one is KVM_DEV_VFIO_GROUP_ADD/DEL, that already  
> > exists and also  
> > > >> covers hot-unplug.  The second simplest one is  
> > KVM_DEV_IOASID_ADD/DEL.  
> > > >
> > > > This isn't the same thing, this is back to trying to have the kernel
> > > > set policy for userspace.  
> > >
> > > If you want a userspace policy then there would be three states:
> > >
> > > * WBINVD enabled because a WBINVD-enabled VFIO device is attached.
> > >
> > > * WBINVD potentially enabled but no WBINVD-enabled VFIO device  
> > attached  
> > >
> > > * WBINVD forcefully disabled
> > >
> > > KVM_DEV_VFIO_GROUP_ADD/DEL can still be used to distinguish the first
> > > two.  Due to backwards compatibility, those two describe the default
> > > behavior; disabling wbinvd can be done easily with a new sub-ioctl of
> > > KVM_ENABLE_CAP and doesn't require any security proof.  
> > 
> > That seems like a good model, use the kvm-vfio device for the default
> > behavior and extend an existing KVM ioctl if QEMU still needs a way to
> > tell KVM to assume all DMA is coherent, regardless of what the kvm-vfio
> > device reports.
> > 
> > If feels like we should be able to support a backwards compatibility
> > mode using the vfio group, but I expect long term we'll want to
> > transition the kvm-vfio device from a groupfd to an ioasidfd.
> >   
> > > The meaning of WBINVD-enabled is "won't return -ENXIO for the wbinvd
> > > ioctl", nothing more nothing less.  If all VFIO devices are going to be
> > > WBINVD-enabled, then that will reflect on KVM as well, and I won't have
> > > anything to object if there's consensus on the device assignment side of
> > > things that the wbinvd ioctl won't ever fail.  
> > 
> > If we create the IOMMU vs device coherency matrix:
> > 
> >             \ Device supports
> > IOMMU blocks \   no-snoop
> >   no-snoop    \  yes | no  |
> > ---------------+-----+-----+
> >            yes |  1  |  2  |
> > ---------------+-----+-----+
> >            no  |  3  |  4  |
> > ---------------+-----+-----+
> > 
> > DMA is always coherent in boxes {1,2,4} (wbinvd emulation is not
> > needed).  VFIO will currently always configure the IOMMU for {1,2} when
> > the feature is supported.  Boxes {3,4} are where we'll currently
> > emulate wbinvd.  The best we could do, not knowing the guest or
> > insights into the guest driver would be to only emulate wbinvd for {3}.
> > 
> > The majority of devices appear to report no-snoop support {1,3}, but
> > the claim is that it's mostly unused outside of GPUs, effectively {2,4}.
> > I'll speculate that most IOMMUs support enforcing coherency (amd, arm,
> > fsl unconditionally, intel conditionally) {1,2}.
> > 
> > I think that means we're currently operating primarily in Box {1},
> > which does not seem to lean towards unconditional wbinvd access with
> > device ownership.
> > 
> > I think we have a desire with IOASID to allow user policy to operate
> > certain devices in {3} and I think the argument there is that a
> > specific software enforced coherence sync is more efficient on the bus
> > than the constant coherence enforcement by the IOMMU.
> > 
> > I think that the disable mode Jason proposed is essentially just a way
> > to move a device from {3} to {4}, ie. the IOASID support or
> > configuration does not block no-snoop and the device claims to support
> > no-snoop, but doesn't use it.  How we'd determine this to be true for
> > a device without a crystal ball of driver development or hardware
> > errata that no-snoop transactions are not possible regardless of the
> > behavior of the enable bit, I'm not sure.  If we're operating a device
> > in {3}, but the device does not generate no-snoop transactions, then
> > presumably the guest driver isn't generating wbinvd instructions for us
> > to emulate, so where are the wbinvd instructions that this feature
> > would prevent being emulated coming from?  Thanks,
> >   
> 
> I'm writing v2 now. Below is what I captured from this discussion.
> Please let me know whether it matches your thoughts:
> 
> - Keep existing kvm-vfio device with kernel-decided policy in short term, 
>   i.e. 'disable' for 1/2 and 'enable' for 3/4. Jason still has different thought
>   whether this should be an explicit wbinvd cmd, though;

Right, in the short term there will need to be compatibility through
the vfio groupfd as used by the kvm-vfio device and that should attempt
to approximate the narrowest reporting of potential non-coherent DMA,
ideally only 3, but acceptable equivalence for 3/4.

> - Long-term transition to ioasidfd (for non-vfio usage);

Long term, I'd expect the kvm-vfio device to transition to ioasidfd as
well.

> - As extension we want to support 'force-enable' (1->3 for performance
>   reason) from user but not 'force-disable' (3->4, sounds meaningless 
>   since if guest driver doesn't use wbinvd then keeping wbinvd emulation 
>   doesn't hurt);

Yes, the user should have control to define an IOASID that does not
enforce coherency by the IOMMU.  The value of disabling KVM wbinvd
emulation (3->4) needs to be justified, but there's no opposition to
extending existing KVM ioctls to providing that emulate-pause/resume
switch.
 
> - To support 'force-enable' no need for additional KVM-side contract.
>    It just relies on what kvm-vfio device reports, regardless of whether
>    an 'enable' policy comes from kernel or user;

Yes.

> - 'force-enable' is supported through /dev/iommu (new name for
>   /dev/ioasid);

Same as 2 above, but yes.  There are probably several opens here
regarding the user granularity of IOMMU coherence, ex. is it defined at
the IOASID or per mapping?  If not per mapping, how is it enforced for
user owned page tables?  The map/unmap interface could simply follow an
IOASID creation attribute to maintain ioctl compatibility with type1.

> - Qemu first calls IOMMU_GET_DEV_INFO(device_handle) to acquire 
>   the default policy (enable vs. disable) for a device. This is the kernel 
>   decision based on device no-snoop and iommu snoop control capability;

The device handle is from vfio though, right?  I'd think this would be
a capability on the VFIO_DEVICE_GET_INFO ioctl, where for PCI,
non-coherent is simply the result of probing that Enable No-snoop is
already or can be enabled (not hardwired zero).

kvm_vfio_group_is_coherent() would require either IOMMU enforced
coherence or all devices in the group to be coherent, the latter
allowing box 4 in the matrix to make wbinvd a no-op.

> - If not specified, an newly-created IOASID follows the kernel policy.
>   Alternatively, Qemu could explicitly mark an IOASID as non-coherent
>   when IOMMU_ALLOC_IOASID;

It seems like the "kernel policy" is specific to vfio compatibility.
The native IOASID API should allow the user to specify.
 
> - Attaching a non-snoop device which cannot be forced to snoop by 
>   iommu to a coherent IOASID gets a failure, because a snoop-format 
>   I/O page table causes error on such iommu;

Yes, and vfio code emulating type1 via IOASID would need to create a
separate IOASID.

> - Devices attached to a non-coherent IOASID all use the no-snoop 
>   format I/O page table, even when the iommu is capable of forcing 
>   snoop;

Both this and the previous are assuming the coherence is defined at the
IOASID rather than per mapping, I think we need to decide if that's the
case.

> - After IOASID is properly configured, Qemu then uses kvm-vfio device
>   to notify KVM which calls vfio helper function to get coherent attribute
>   per vfio_group. Because this attribute is kept in IOASID, we possibly
>   need return the attribute to vfio when vfio_attach_ioasid. 

Yes, vfio will need some way to know whether the IOASID is operating in
boxes 3/4 (or better just 3).  Also, since coherence is the product of
device configuration rather than group configuration, we'll likely need
new mechanisms to keep the KVM view correct.  Thanks,

Alex

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
