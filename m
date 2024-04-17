Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BC88565B
	for <iommu@lists.linux.dev>; Wed, 17 Apr 2024 23:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713394945; cv=none; b=cggHAgX9bAB7WTtfcPnJnTYa+9xBe3VobYF0mPMUBiDGdlKCUceCkE1+ZOM7OSmv5ra7MsaT1MfJZ3SxONBL+7DzjYAPzqcZFMLJNH0AYeuVeqzhJ9gSl0mDtmuEftykVtRP6NJLlKzF5A88T/iG1vAAHJOCl9SBkg+CfKbSUsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713394945; c=relaxed/simple;
	bh=LBU3fLFom8vb/7JkuEvy+I6UW8qanTPcmH2t8cVFq8c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rXR3gW1cJkVlON04NSM2n3Qaz8hv0UhGgGCUKRJZ5frO4+qyIqRspaC9KJAI4kaviTwBBgnUyrUdxFm6NiDIlRQkuWu4pBgoDSkELVR9iJlyP64mmMhn+B5utguYtTrkGft6+hsmvE9dw4ZrwWnF/yjnXChir4mUtE2f6ETsYaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QK4dy2xV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QK4dy2xV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713394942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LV6Nb717r/ECNUv4GKXXSYG0oYIZ4itZI6Tnma6j0S4=;
	b=QK4dy2xVKoNQRcv1b7qQ2tTwFJHPWiernmqSmXk3IbkX/85jnRdu0GoKm2o8qnPW+6LEdV
	hawu2rxgaGMBN/MY0hnMlXulewJsJ9cTO5cGfqczq0T9sVZ/3gxvvRaCqoFEIFLJ5QRxhY
	zGRmAt56Gxcl7MMNSjov2MRG8wxoVu4=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-1Fd9SuRNNSyCrhG_vG1bMg-1; Wed, 17 Apr 2024 19:02:21 -0400
X-MC-Unique: 1Fd9SuRNNSyCrhG_vG1bMg-1
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-5aa1b55ef83so317620eaf.1
        for <iommu@lists.linux.dev>; Wed, 17 Apr 2024 16:02:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713394940; x=1713999740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LV6Nb717r/ECNUv4GKXXSYG0oYIZ4itZI6Tnma6j0S4=;
        b=UTEOu39YkeESG2HD8hNesz+zwNwMNDJRDpPlE+SLEm1V3QKO26W8gDlrmsCZ9+dJ2k
         JzEfYuHRtkqVXXoahKf/6WEmmepBV1GgxFJ5JOBVboteY8wIsIsCmNZTbqO13c+NlrUH
         UtRBqzQVUWbL+q3Ny1hSexRZzyA1K2KOq9HXEAnv0HKcTlmnUD9wzpSb+lZcjLcdvC3r
         VHaag+h7J5I7d3VJOW4ogJvGazD9bF1EvCD0aD9x6UmwhcF0kELBjLMsHlJa5cXxJ1hT
         lsHaszQPHtD5w5RLktvgLLBquuXj+I2HeJp3GRUEPNzVcZqVI7pRsFKbzqmj6hbBySd5
         f7LQ==
X-Forwarded-Encrypted: i=1; AJvYcCXW5tmFnDI8ps3nrkPK0gZWikXELhW6YtgQx+qHvGHd5+N6oQuFu24a6z3rXZowKOCktf1jfWfNmmHMk0lk8fIvKdf3Zww=
X-Gm-Message-State: AOJu0Yxs55IWfmhhiIqpBy8kxlwTaxTIB3eNOiz3qx/Fg0DgaN7WATqO
	on3kJezyJwtOTfIoYzZ5ttRYQtybEfkOZRBp6qBF4CzZ0Zg6gISrQ4q9x8vJhwiB7s6sR4kJcu4
	bz+VMIY4tN27DQt1sd/nGk7Ty/CywNv2JxPSPmq5mkFmFvfEVV+Gz
X-Received: by 2002:a4a:98c6:0:b0:5aa:5252:6efc with SMTP id b6-20020a4a98c6000000b005aa52526efcmr1287484ooj.9.1713394940286;
        Wed, 17 Apr 2024 16:02:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzaXJdXFiq9LMPiWxQaCBmqb2idfqAHM9IG+BCrxxovArqOWEnbc06EItG1q9EXTRxNzWIYg==
X-Received: by 2002:a4a:98c6:0:b0:5aa:5252:6efc with SMTP id b6-20020a4a98c6000000b005aa52526efcmr1287472ooj.9.1713394940025;
        Wed, 17 Apr 2024 16:02:20 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id m7-20020a4aab87000000b005a4a656860bsm77843oon.2.2024.04.17.16.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 16:02:19 -0700 (PDT)
Date: Wed, 17 Apr 2024 17:02:16 -0600
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
Message-ID: <20240417170216.1db4334a.alex.williamson@redhat.com>
In-Reply-To: <20240417122051.GN3637727@nvidia.com>
References: <20240412082121.33382-1-yi.l.liu@intel.com>
	<BN9PR11MB5276318EF2CD66BEF826F59A8C082@BN9PR11MB5276.namprd11.prod.outlook.com>
	<20240416175018.GJ3637727@nvidia.com>
	<BN9PR11MB5276E6975F78AE96F8DEC66D8C0F2@BN9PR11MB5276.namprd11.prod.outlook.com>
	<20240417122051.GN3637727@nvidia.com>
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

On Wed, 17 Apr 2024 09:20:51 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Wed, Apr 17, 2024 at 07:16:05AM +0000, Tian, Kevin wrote:
> > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > Sent: Wednesday, April 17, 2024 1:50 AM
> > > 
> > > On Tue, Apr 16, 2024 at 08:38:50AM +0000, Tian, Kevin wrote:  
> > > > > From: Liu, Yi L <yi.l.liu@intel.com>
> > > > > Sent: Friday, April 12, 2024 4:21 PM
> > > > >
> > > > > A userspace VMM is supposed to get the details of the device's PASID
> > > > > capability
> > > > > and assemble a virtual PASID capability in a proper offset in the virtual  
> > > PCI  
> > > > > configuration space. While it is still an open on how to get the available
> > > > > offsets. Devices may have hidden bits that are not in the PCI cap chain.  
> > > For  
> > > > > now, there are two options to get the available offsets.[2]
> > > > >
> > > > > - Report the available offsets via ioctl. This requires device-specific logic
> > > > >   to provide available offsets. e.g., vfio-pci variant driver. Or may the  
> > > device  
> > > > >   provide the available offset by DVSEC.
> > > > > - Store the available offsets in a static table in userspace VMM. VMM gets  
> > > the  
> > > > >   empty offsets from this table.
> > > > >  
> > > >
> > > > I'm not a fan of requesting a variant driver for every PASID-capable
> > > > VF just for the purpose of reporting a free range in the PCI config space.
> > > >
> > > > It's easier to do that quirk in userspace.
> > > >
> > > > But I like Alex's original comment that at least for PF there is no reason
> > > > to hide the offset. there could be a flag+field to communicate it. or
> > > > if there will be a new variant VF driver for other purposes e.g. migration
> > > > it can certainly fill the field too.  
> > > 
> > > Yes, since this has been such a sticking point can we get a clean
> > > series that just enables it for PF and then come with a solution for
> > > VF?
> > >   
> > 
> > sure but we at least need to reach consensus on a minimal required
> > uapi covering both PF/VF to move forward so the user doesn't need
> > to touch different contracts for PF vs. VF.  
> 
> Do we? The situation where the VMM needs to wholly make a up a PASID
> capability seems completely new and seperate from just using an
> existing PASID capability as in the PF case.

But we don't actually expose the PASID capability on the PF and as
argued in path 4/ we can't because it would break existing userspace.

> If it needs to make another system call or otherwise to do that then
> that seems fine to do incrementally??

With PASID currently hidden, VF and PF support really seem too similar
not to handle them both at the same time.  What's missing is a
mechanism to describe unused config space where userspace can implement
an emulated PASID capability.  Defining a DVSEC capability to handle
this seemed to be the preferred solution from the LPC discussion.  PF
and VF devices that implement a TBD DVSEC capability could avoid
needing a variant driver.  Until then we need to be careful not to
undermine a future world with that preferred solution by introducing
side-band mechanisms which only work for variant drivers and PF
devices.  Thanks,

Alex

