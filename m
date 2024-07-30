Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C779814F9F9
	for <iommu@lists.linux.dev>; Tue, 30 Jul 2024 17:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722360928; cv=none; b=O1e9Sfl5xxyQ2iXek2r13g02qGnNTfRmINy/LzWzSyCo5KXBS4eI0mBG/UcQcIDOuPtWqkkZLDecBkN0s4T8EcxcKqYGK2bo7gcVdb9SssZPIqTb3Ks2yAqtcoFuC7HxCCCvEp6qo/NMTTCeKUnL6ozB0Pe7e569wlM+EObchF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722360928; c=relaxed/simple;
	bh=kaHR19k0/F/oLlfNxYx6jh9dp6SYMsv+JIi44ubapSI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SRUXJp26GOJ3037+fShrbSAtVt3ezICE0C4LnRsL2MNbtQv/6VQqDaGrJ6bYbzbvwbC3Sd1bv6XhplYiMPDn+kA0Vlvmj6zNEuwGdVocjhqYTV4ayreqIounHtWzDpsDU4+ePp0W+cVtFCT9XZapaVH6de2YHBrRo8pKeAN73oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C7xgu+uw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C7xgu+uw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722360925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JGvvLnyHosynzU4qCCDWzexJdT4L2I6G7pAHyddJSVE=;
	b=C7xgu+uwCggdEfm/FIqTmqdInihR+2xTXhmlihzdxc/dCBH0w6ISQA1gsiCx2RUufG3OkG
	7ZGe/u9UaXCb7JZYS410yL/E/BwyPA/5JrihZJD0FqOoftwGJBxqO+8KbSYrIYTS7woqbq
	NzM9hgqyZZI0ycgoFX0dJpbfDWFH30M=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-D00m_lIdNrqkIrwnknWPoA-1; Tue, 30 Jul 2024 13:35:22 -0400
X-MC-Unique: D00m_lIdNrqkIrwnknWPoA-1
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-81f968e53b0so554874039f.1
        for <iommu@lists.linux.dev>; Tue, 30 Jul 2024 10:35:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722360921; x=1722965721;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JGvvLnyHosynzU4qCCDWzexJdT4L2I6G7pAHyddJSVE=;
        b=Ui0svYlr8D5KCHKH/MdSgSU7HumRPEn8h/+MmV6noWu97xe1UbM6/rAODNY9Jc/Hah
         8lTU9VRPG6gu+YYKY1ohjH+3prJnfY2dVENKhBIWdE76of/RbfkHeeE4veRfEXX8jI98
         LwBDBPqJEq/gTMCiqwm77JEv0YtN13tE+x4Notwbx99Cw5Uwla9JKIbhKjvDGSxjYZLK
         xWDQklkAaSKFOB+GrSHj2DBwX8S/U/pIQYniJiqXTMWMkjUwV3YbF2QLiu6LCCy7J5pS
         OMyKuXWyymVJJrTv9dTG/RVak/6vCjW6A8TtKjfVzMOK1h1aUCXZ4b37xVxRJUz6v6oo
         fRHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPCKxBwwMQXM1CUYkS7ddWfvEYoAhLudDSJZR2CwKYfOtEOScmH0gPZDRQQn1y9p7B4uqQ7e5xVGc0/IRqMVwTWhvzSmQ=
X-Gm-Message-State: AOJu0Yw5ZNnHtYL0we/Hc/QJTOHqgOIbQDJoTmRIMvM0d5GqJwfzzSou
	TJeLzmI/Hzmn7E+h/fu5fxQ1KfdyKVkGsI4q1zYxTJvs1/pKuGXA0xqDVJYV27c1cZJKM/ROywc
	qo/tvqU9T6O7ufmm1aTRja9gYL2rn2HBLzzxBXRy+2+esBwt/pSUt
X-Received: by 2002:a05:6602:6b8c:b0:7f6:8650:9684 with SMTP id ca18e2360f4ac-81f95a478bamr1579930939f.5.1722360921405;
        Tue, 30 Jul 2024 10:35:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgpSmEalpua89Fpxw1wV639nT7n76zuIKZpMFI5rYYGWUEnZ2dK1ruqZiSANyryCDBNwUBow==
X-Received: by 2002:a05:6602:6b8c:b0:7f6:8650:9684 with SMTP id ca18e2360f4ac-81f95a478bamr1579927739f.5.1722360920971;
        Tue, 30 Jul 2024 10:35:20 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-81f7d74d59csm361138139f.22.2024.07.30.10.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 10:35:20 -0700 (PDT)
Date: Tue, 30 Jul 2024 11:35:17 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "joro@8bytes.org" <joro@8bytes.org>, "robin.murphy@arm.com"
 <robin.murphy@arm.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "kvm@vger.kernel.org"
 <kvm@vger.kernel.org>, "chao.p.peng@linux.intel.com"
 <chao.p.peng@linux.intel.com>, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, "baolu.lu@linux.intel.com"
 <baolu.lu@linux.intel.com>, "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "Pan, Jacob jun" <jacob.jun.pan@intel.com>, =?UTF-8?B?Q8OpZHJpYw==?= Le
 Goater <clg@redhat.com>
Subject: Re: [PATCH v2 0/4] vfio-pci support pasid attach/detach
Message-ID: <20240730113517.27b06160.alex.williamson@redhat.com>
In-Reply-To: <BN9PR11MB5276C4EF3CFB6075C7FC60AC8CAA2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240419103550.71b6a616.alex.williamson@redhat.com>
	<BN9PR11MB52766862E17DF94F848575248C112@BN9PR11MB5276.namprd11.prod.outlook.com>
	<20240423120139.GD194812@nvidia.com>
	<BN9PR11MB5276B3F627368E869ED828558C112@BN9PR11MB5276.namprd11.prod.outlook.com>
	<20240424001221.GF941030@nvidia.com>
	<20240424122437.24113510.alex.williamson@redhat.com>
	<20240424183626.GT941030@nvidia.com>
	<20240424141349.376bdbf9.alex.williamson@redhat.com>
	<20240426141117.GY941030@nvidia.com>
	<20240426141354.1f003b5f.alex.williamson@redhat.com>
	<20240429174442.GJ941030@nvidia.com>
	<BN9PR11MB5276C4EF3CFB6075C7FC60AC8CAA2@BN9PR11MB5276.namprd11.prod.outlook.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Jul 2024 02:26:20 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:

> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Tuesday, April 30, 2024 1:45 AM
> > 
> > On Fri, Apr 26, 2024 at 02:13:54PM -0600, Alex Williamson wrote:  
> > > Regarding "if we accept that text file configuration should be
> > > something the VMM supports", I'm not on board with this yet, so
> > > applying it to PASID discussion seems premature.  
> > 
> > Sure, I'm just explaining a way this could all fit together.
> >   
> 
> Thinking more along this direction.
> 
> I'm not sure how long it will take to standardize such text files and
> share them across VMMs. We may need a way to move in steps in
> Qemu to unblock the kernel development toward that end goal, e.g.
> first accepting a pasid option plus user-specified offset (if offset
> unspecified then auto-pick one in cap holes). Later when the text
> file is ready then such per-cap options can be deprecated.

Planned obsolescence is a hard sell.

> This simple way won't fix the migration issue, but at least it's on
> par with physical caps (i.e. fail the migration if offset mismatched
> between dest/src) and both will be fixed when the text file model
> is ready.
> 
> Then look at what uAPI is required to report the vPASID cap.
> 
> In earlier discussion it's leaning toward extending GET_HW_INFO
> in iommufd given both iommu/pci support are required to get
> PASID working and iommu driver will not report such support until
> pasid has been enabled in both iommu/pci. With that there is no
> need to further report PASID in vfio-pci.
> 
> But there may be other caps which are shared between VF and
> PF while having nothing to do with the iommu. e.g. the Device
> Serial Number extended cap (permitted but not recommended
> in VF). If there is a need to report such cap on VF which doesn't
> implement it to userspace, a vfio uAPI (device_feature or a new
> one dedicated to synthetical vcap) appears to be inevitable.
> 
> So I wonder whether we leave this part untouched until a real
> demand comes or use vpasid to formalize that uAPI to be forward
> looking. If in the end such uAPI will exist then it's a bit weird to
> have PASID escaped (especially when vfio-pci already reports
> PRI/ATS  which have iommu dependency too in vconfig).
> 
> In concept the Qemu logic will be clearer if any PCI caps (real
> or synthesized) is always conveyed via vfio-pci while iommufd is
> for identifying a viommu cap.

There are so many moving pieces here and the discussion trailed off a
long time ago.  I have trouble keeping all the relevant considerations
in my head, so let me try to enumerate them, please correct/add.

 - The PASID capability cannot be implemented on VFs per the PCIe spec.
   All VFs share the PF PASID configuration.  This also implies that
   the VF PASID capability is essentially emulated since the VF driver
   cannot manipulate the PF PASID directly.

 - VFIO does not currently expose the PASID capability for PFs, nor
   does anything construct a vPASID capability for VFs.

 - The PASID capability is only useful in combination with a vIOMMU
   with PASID support, which does not yet exist in QEMU.

 - Some devices are known to place registers in configuration space,
   outside of the capability chains, which historically makes it
   difficult to place a purely virtual capability without potentially
   masking such hidden registers.  Current virtual capabilities are
   placed at vendor defined fixed locations to avoid conflicts.

 - There is some expectation that otherwise compatible devices may
   not present identical capability chains, for example devices running
   different firmware or devices from different vendors implementing a
   standard register ABI (virtio) where capability chain layout is not
   standardized.

 - There have been arguments that the layout of device capabilities is
   a policy choice, where both the kernel and libvirt traditionally try
   to avoid making policy decisions.

 - Seamless live migration of devices requires that configuration space
   remains at least consistent, if not identical for much of it.
   Capability offsets cannot change during live migration.  This leads
   to the text file reference above, which is essentially just the
   notion that if the VMM defines the capability layout in config
   space, it would need to do so via a static reference, independent of
   the layout of the physical device and we might want to share that
   among multiple VMMs.

 - For a vfio-pci device to support live migration it must be enabled
   to do so by a vfio-pci variant driver.

 - We've discussed in the community and seem to have a consensus that a
   DVSEC (Designated Vendor Specific Extended Capability) could be
   defined to describe unused configuration space.  Such a DVSEC could
   be implemented natively by the device or supplied by a vfio-pci
   variant driver.  There is currently no definition of such a DVSEC.

So what are we trying to accomplish here.  PASID is the first
non-device specific virtual capability that we'd like to insert into
the VM view of the capability chain.  It won't be the last.

 - Do we push the policy of defining the capability offset to the user?

 - Do we do some hand waving that devices supporting PASID shouldn't
   have hidden registers and therefore the VMM can simply find a gap?

 - Do we ask the hardware vendor or variant driver to insert a DVSEC to
   identify available config space?

 - Do we handle this as just another device quirk, where we maintain a
   table of supported devices and vPASID offset for each?

 - Do we consider this an inflection point where the VMM entirely takes
   over the layout of the capability spaces to impose a stable
   migration layout?  On what basis do we apply that inflection?

 - Also, do we require the same policy for both standard and extended
   capability chains?

I understand the desire to make some progress, but QEMU relies on
integration with management tools, so a temporary option for a user to
specify a PASID offset in isolation sounds like a non-starter to me.

This might be a better sell if the user interface allowed fully
defining the capability chain layout from the command line and this
interface would continue to exist and supersede how the VMM might
otherwise define the capability chain when used.  A fully user defined
layout would be complicated though, so I think there would still be a
desire for QEMU to consume or define a consistent policy itself.

Even if QEMU defines the layout for a device, there may be multiple
versions of that device.  For example, maybe we just add PASID now, but
at some point we decide that we do want to replicate the PF serial
number capability.  At that point we have versions of the device which
would need to be tied to versions of the machine and maybe also
selected via a profile switch on the device command line.

If we want to simplify this, maybe we do just look at whether the
vIOMMU is configured for PASID support and if the device supports it,
then we just look for a gap and add the capability.  If we end up with
different results between source and target for migration, then
migration will fail.  Possibly we end up with a quirk table to override
the default placement of specific capabilities on specific devices.
That might evolve into a lookup for where we place all capabilities,
which essentially turns into the "file" where the VMM defines the entire
layout for some devices.

This is already TL;DR, so I'll end with that before I further drowned
the possibility of discussion.  Thanks,

Alex

