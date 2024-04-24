Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A7516EC13
	for <iommu@lists.linux.dev>; Wed, 24 Apr 2024 18:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713983084; cv=none; b=kRROkfvTFQS8R1LSMzLbLcqvDldiE9KhEHMz7P/oBg1uFOAgb9k20oSyFUymOb4xEnZfD1TPLmddRLCY1N+/Qk7u1DJGUFMcajPS3vToB1OOeSHHXp3PB9CuVLmCrnNWJcuKQjM+xbs0yB9bNcx4IDAK1n9MdKHv6AHhH469Pvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713983084; c=relaxed/simple;
	bh=jjC6skZ2GOntTeo2OM26tneWmFhSGk3j+D2cgYiZ87s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hC4NNDZOAVQy1E9xFqFCAkeXwNMvwRmYmJWkh6uE5BEjv5IDftto70eI3n3zrJLgV5f/92VmQu+nofquxFlc0w0mIz1M0IQx/woQ0qepswzfggJeRCf3ub6QBH6Fale/kBDQ9LpB6TIzjUtAi+Wu2A0XPNC5qj21AlFMV5H8eoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D1nM1wnb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D1nM1wnb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713983082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FnKq2U3fRDJWPm0C3LVL8dpQqqXexDD8FcFI9Cb/pmo=;
	b=D1nM1wnbyapmG3+ADDmx+kgd0pqCT8Cr1KQnq2ET9UPzLsoU9aR95mg0f4DZQqdmIk/sb8
	In4AVoTSta7ZyXLuETyXOAB478owA7svbN6ALYPwpIKTeFTFR+puNTLU1KsGxQW1MhHNYh
	8HxUmvJwOoD/NZhFzHD3OknS56Q+CF4=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-iPd7gGqXMNeSei7bd49fgw-1; Wed, 24 Apr 2024 14:24:40 -0400
X-MC-Unique: iPd7gGqXMNeSei7bd49fgw-1
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-36a20206746so1900075ab.3
        for <iommu@lists.linux.dev>; Wed, 24 Apr 2024 11:24:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713983079; x=1714587879;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FnKq2U3fRDJWPm0C3LVL8dpQqqXexDD8FcFI9Cb/pmo=;
        b=DL8PB9i1M9m+twvDC7tDUAV2gtjoX3mQzVz71VByqlowTwFMi4b5ihWa8gzbdQovuV
         dC5qWMLyZBhvkmLZwigWtIRqAMiosrHDlbNpG99kVBcF31UYisMNLLqWc1g4b9MJbtuW
         Mc50IOVbVQgDF8eu1vG6UeLBEP42lvWVGMXWyA4Grtlp91E38i6PaHBtByemKyPBEk9x
         byHbur/5Y23+eqgHmxsExU+vX+AdWfg9bG1Coj+OBg35inHl5z6T95R8CeGwIOzT2OjX
         blEWu5c+VKt+bHAOBSGmaZzeHPvNoTYfvgOzBJKGYbibey1RhJbcEJphKWE+3o4sdquB
         7Jjg==
X-Forwarded-Encrypted: i=1; AJvYcCXO6J/IUPafx/iDzLoNtv2wPx7vYq7cqire5jRdsBRQPxvrcQUi4ceOQzFDsHRruk6Y2cTt1a6IKn/lPuzjSQk5/l7RxpQ=
X-Gm-Message-State: AOJu0YzHTlerEOeYeys0Qca0SIidkhMLrq9y6+gKTZmFAJODBAjYEShK
	Hl5s3gNAOhazXgxxcbydSyfQUybIWsQKXEyGr0tIj5bqNt4M34mn8ij5s5ufTma8yjJEOlcdjCO
	t33jrYNr99lo6nfe2qZy36TWkACThvgjPGA/Chn3Fwsi2FsogbOfymIf1L8xZ
X-Received: by 2002:a05:6e02:156e:b0:36b:26df:cce9 with SMTP id k14-20020a056e02156e00b0036b26dfcce9mr4012848ilu.22.1713983079756;
        Wed, 24 Apr 2024 11:24:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJRE81Lsld2/Anqpcdy+p8VCTYAOTeRxzlkPJx/J4ZyxQS0hy7J4OMpPBrRG+0N7s8o1zMMA==
X-Received: by 2002:a05:6e02:156e:b0:36b:26df:cce9 with SMTP id k14-20020a056e02156e00b0036b26dfcce9mr4012828ilu.22.1713983079458;
        Wed, 24 Apr 2024 11:24:39 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id m7-20020a056638260700b0047bf7a10f23sm4278005jat.170.2024.04.24.11.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 11:24:38 -0700 (PDT)
Date: Wed, 24 Apr 2024 12:24:37 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "joro@8bytes.org" <joro@8bytes.org>, "robin.murphy@arm.com"
 <robin.murphy@arm.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "kvm@vger.kernel.org"
 <kvm@vger.kernel.org>, "chao.p.peng@linux.intel.com"
 <chao.p.peng@linux.intel.com>, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, "baolu.lu@linux.intel.com"
 <baolu.lu@linux.intel.com>, "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "Pan, Jacob jun" <jacob.jun.pan@intel.com>
Subject: Re: [PATCH v2 0/4] vfio-pci support pasid attach/detach
Message-ID: <20240424122437.24113510.alex.williamson@redhat.com>
In-Reply-To: <20240424001221.GF941030@nvidia.com>
References: <20240417122051.GN3637727@nvidia.com>
	<20240417170216.1db4334a.alex.williamson@redhat.com>
	<BN9PR11MB52765314C4E965D4CEADA2178C0E2@BN9PR11MB5276.namprd11.prod.outlook.com>
	<4037d5f4-ae6b-4c17-97d8-e0f7812d5a6d@intel.com>
	<20240418143747.28b36750.alex.williamson@redhat.com>
	<BN9PR11MB5276819C9596480DB4C172228C0D2@BN9PR11MB5276.namprd11.prod.outlook.com>
	<20240419103550.71b6a616.alex.williamson@redhat.com>
	<BN9PR11MB52766862E17DF94F848575248C112@BN9PR11MB5276.namprd11.prod.outlook.com>
	<20240423120139.GD194812@nvidia.com>
	<BN9PR11MB5276B3F627368E869ED828558C112@BN9PR11MB5276.namprd11.prod.outlook.com>
	<20240424001221.GF941030@nvidia.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
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

On Tue, 23 Apr 2024 21:12:21 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Tue, Apr 23, 2024 at 11:47:50PM +0000, Tian, Kevin wrote:
> > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > Sent: Tuesday, April 23, 2024 8:02 PM
> > > 
> > > On Tue, Apr 23, 2024 at 07:43:27AM +0000, Tian, Kevin wrote:  
> > > > I'm not sure how userspace can fully handle this w/o certain assistance
> > > > from the kernel.
> > > >
> > > > So I kind of agree that emulated PASID capability is probably the only
> > > > contract which the kernel should provide:
> > > >   - mapped 1:1 at the physical location, or
> > > >   - constructed at an offset according to DVSEC, or
> > > >   - constructed at an offset according to a look-up table
> > > >
> > > > The VMM always scans the vfio pci config space to expose vPASID.
> > > >
> > > > Then the remaining open is what VMM could do when a VF supports
> > > > PASID but unfortunately it's not reported by vfio. W/o the capability
> > > > of inspecting the PASID state of PF, probably the only feasible option
> > > > is to maintain a look-up table in VMM itself and assumes the kernel
> > > > always enables the PASID cap on PF.  
> > > 
> > > I'm still not sure I like doing this in the kernel - we need to do the
> > > same sort of thing for ATS too, right?  
> > 
> > VF is allowed to implement ATS.
> > 
> > PRI has the same problem as PASID.  
> 
> I'm surprised by this, I would have guessed ATS would be the device
> global one, PRI not being per-VF seems problematic??? How do you
> disable PRI generation to get a clean shutdown?
> 
> > > It feels simpler if the indicates if PASID and ATS can be supported
> > > and userspace builds the capability blocks.  
> > 
> > this routes back to Alex's original question about using different
> > interfaces (a device feature vs. PCI PASID cap) for VF and PF.  
> 
> I'm not sure it is different interfaces..
> 
> The only reason to pass the PF's PASID cap is to give free space to
> the VMM. If we are saying that gaps are free space (excluding a list
> of bad devices) then we don't acutally need to do that anymore.

Are we saying that now??  That's new.

> VMM will always create a synthetic PASID cap and kernel will always
> suppress a real one.
> 
> An iommufd query will indicate if the vIOMMU can support vPASID on
> that device.
> 
> Same for all the troublesome non-physical caps.
> 
> > > There are migration considerations too - the blocks need to be
> > > migrated over and end up in the same place as well..  
> > 
> > Can you elaborate what is the problem with the kernel emulating
> > the PASID cap in this consideration?  
> 
> If the kernel changes the algorithm, say it wants to do PASID, PRI,
> something_new then it might change the layout
> 
> We can't just have the kernel decide without also providing a way for
> userspace to say what the right layout actually is. :\

The capability layout is only relevant to migration, right?  A variant
driver that supports migration is a prerequisite and would also be
responsible for exposing the PASID capability.  This isn't as disjoint
as it's being portrayed.

> > Does it talk about a case where the devices between src/dest are
> > different versions (but backward compatible) with different unused
> > space layout and the kernel approach may pick up different offsets
> > while the VMM can guarantee the same offset?  
> 
> That is also a concern where the PCI cap layout may change a bit but
> they are still migration compatible, but my bigger worry is that the
> kernel just lays out the fake caps in a different way because the
> kernel changes.

Outside of migration, what does it matter if the cap layout is
different?  A driver should never hard code the address for a
capability.
 
> At least if the VMM is doing this then the VMM can include the
> information in its migration scheme and use it to recreate the PCI
> layout withotu having to create a bunch of uAPI to do so.

We're again back to migration compatibility, where again the capability
layout would be governed by the migration support in the in-kernel
variant driver.  Once migration is involved the location of a PASID
shouldn't be arbitrary, whether it's provided by the kernel or the VMM.

Regardless, the VMM ultimately has the authority what the guest
sees in config space.  The VMM is not bound to expose the PASID at the
offset provided by the kernel, or bound to expose it at all.  The
kernel exposed PASID can simply provide an available location and set
of enabled capabilities.  Thanks,

Alex

