Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D2417547
	for <iommu@lists.linux.dev>; Wed, 24 Apr 2024 18:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713983939; cv=none; b=nvdnxwm7Tt2g/0XZGWEa0ajMUzc5sJaN6dyJZ33K707HoCDQgvzKwnvXrWpZfi9Q83HoR+/rtdRTQ/VbyV5x2KBQNma5DgU0Sf4rGEGHjXJv9CCVITR7yF5nk4cvTIvvVUACs978BYnCjnqSt43Qprk0f8NvPDh3VReB6H3RDvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713983939; c=relaxed/simple;
	bh=udJ5HLtq+8PYFarkckyLquzps5E8ZfnLCyaUdY+DZjw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kiw/gLHC+WI2pfWGfXc27FhV2w6PEPXhLgHX7Qjc3kB1lrssL2BaZzSKUghET1bjra1Yob+ndLWJk9LEwq0w/8IphCa3GpAWo3iZOtg+oCT4U5piUOhcDxa64v4plxbqjnlssHD6BgicQ92mGfjTiSsO8T2hVkH0oJFZoPAB7bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IC45dDp0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IC45dDp0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713983936;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qJ7YLFnZxS7AAkZVfPRO8VEYZa8wECZjy46pv+nOVZw=;
	b=IC45dDp0NfwpfznBOSgIsHDiflDh/4bAVorX8DK6BtHp6nlXaVSFoRJ9xW6nzR51vpJuef
	73YI8AY/YOwluAfb3f6fYFXzQV4AvHOgROtsxw+NPOkgzsme0kG7tRwED6RDZxVXbRbnJk
	lgoFPt4bLB48lycDVBniPVyfshiN5ZI=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-wF_xof3wNBaDYzpmV4JrZw-1; Wed, 24 Apr 2024 14:38:55 -0400
X-MC-Unique: wF_xof3wNBaDYzpmV4JrZw-1
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7dda529a35cso16794739f.3
        for <iommu@lists.linux.dev>; Wed, 24 Apr 2024 11:38:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713983933; x=1714588733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qJ7YLFnZxS7AAkZVfPRO8VEYZa8wECZjy46pv+nOVZw=;
        b=XlmHweNVwXkXI6PRYKS1119dhNTPbtt85hdw7Nv5FX7IFWHNnfZl7Q/q0d4XhiiMMH
         ZXSUzmoF0P0sJct2VIHIan+v5/Q4QeVFZu541UFGLtZGK4XtyC5h5YNOORChj7p3AiyA
         VbXYZyF/tJ9sZjru001cg90YTDqzSIpTv5ql3h96mO6ZjxFOHex+6Qm13r+bpyppkSc+
         Wxh6hLHdUX/KFXRxIT6jMcwfhfoQLv2ieB8CEsNf9K3Nb3DZgs1/PLc8u69dMsNAMCEn
         UfHJqfTNuf618q5S18uXGaEFfnrvrtZLJpwe00saAOevjVaba49jc8ONvPQJqGH87TtR
         tCEw==
X-Forwarded-Encrypted: i=1; AJvYcCXm2g9olu6QBdn9XI6CuG6wCk7U1jpo3mG0u7QqDc534LH0Wp84MKtU1Dr0H0wh0ENjSO2HjieLpwkxsJFWTiji9PS+9XE=
X-Gm-Message-State: AOJu0Yz85WX8yd1RdSdsBSVWJGSlHmVTcr+Mxg2JqCB39Os2soUfeA5z
	wX7DPHL7MurrBH8OmzmP1GWnK8nYnx0SCMYPFI6PCTTKIzW9FKh59Eegy+dotoXF6FL4uz+yHD9
	0zFq0ZZzH4LjrbT3q4MXpwCeepT0dzjNu9bFPvxyVYVfdTGZuXg6U
X-Received: by 2002:a6b:5908:0:b0:7da:19ca:722c with SMTP id n8-20020a6b5908000000b007da19ca722cmr3703210iob.12.1713983933389;
        Wed, 24 Apr 2024 11:38:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHN/il8+JlQjH7aop/qgnU0DqcOYnd3zGCXvyRn8kvHThtQsKV4okzWPT6Ds0PZZ+SCfsfDQ==
X-Received: by 2002:a6b:5908:0:b0:7da:19ca:722c with SMTP id n8-20020a6b5908000000b007da19ca722cmr3703169iob.12.1713983932917;
        Wed, 24 Apr 2024 11:38:52 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id ez4-20020a056638614400b00482a9f7066csm4297271jab.151.2024.04.24.11.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 11:38:52 -0700 (PDT)
Date: Wed, 24 Apr 2024 12:38:51 -0600
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
Message-ID: <20240424123851.09a32cdf.alex.williamson@redhat.com>
In-Reply-To: <20240424141525.GN941030@nvidia.com>
References: <BN9PR11MB52765314C4E965D4CEADA2178C0E2@BN9PR11MB5276.namprd11.prod.outlook.com>
	<4037d5f4-ae6b-4c17-97d8-e0f7812d5a6d@intel.com>
	<20240418143747.28b36750.alex.williamson@redhat.com>
	<BN9PR11MB5276819C9596480DB4C172228C0D2@BN9PR11MB5276.namprd11.prod.outlook.com>
	<20240419103550.71b6a616.alex.williamson@redhat.com>
	<BN9PR11MB52766862E17DF94F848575248C112@BN9PR11MB5276.namprd11.prod.outlook.com>
	<20240423120139.GD194812@nvidia.com>
	<BN9PR11MB5276B3F627368E869ED828558C112@BN9PR11MB5276.namprd11.prod.outlook.com>
	<20240424001221.GF941030@nvidia.com>
	<BN9PR11MB5276183377A6D053EFC837FD8C102@BN9PR11MB5276.namprd11.prod.outlook.com>
	<20240424141525.GN941030@nvidia.com>
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

On Wed, 24 Apr 2024 11:15:25 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Wed, Apr 24, 2024 at 05:19:31AM +0000, Tian, Kevin wrote:
> > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > Sent: Wednesday, April 24, 2024 8:12 AM
> > > 
> > > On Tue, Apr 23, 2024 at 11:47:50PM +0000, Tian, Kevin wrote:  
> > > > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > > > Sent: Tuesday, April 23, 2024 8:02 PM
> > > > >
> > > > > It feels simpler if the indicates if PASID and ATS can be supported
> > > > > and userspace builds the capability blocks.  
> > > >
> > > > this routes back to Alex's original question about using different
> > > > interfaces (a device feature vs. PCI PASID cap) for VF and PF.  
> > > 
> > > I'm not sure it is different interfaces..
> > > 
> > > The only reason to pass the PF's PASID cap is to give free space to
> > > the VMM. If we are saying that gaps are free space (excluding a list
> > > of bad devices) then we don't acutally need to do that anymore.
> > > 
> > > VMM will always create a synthetic PASID cap and kernel will always
> > > suppress a real one.  
> > 
> > oh you suggest that there won't even be a 1:1 map for PF!  
> 
> Right. No real need..
> 
> > kind of continue with the device_feature method as this series does.
> > and it could include all VMM-emulated capabilities which are not
> > enumerated properly from vfio pci config space.  
> 
> 1) VFIO creates the iommufd idev
> 2) VMM queries IOMMUFD_CMD_GET_HW_INFO to learn if PASID, PRI, etc,
>    etc is supported
> 3) VMM locates empty space in the config space
> 4) VMM figures out where and what cap blocks to create (considering
>    migration needs/etc)
> 5) VMM synthesizes the blocks and ties emulation to other iommufd things
> 
> This works generically for any synthetic vPCI function including a
> non-vfio-pci one.

Maybe this is the actual value in implementing this in the VMM, one
implementation can support multiple device interfaces.

> Most likely due to migration needs the exact layout of the PCI config
> space should be configured to the VMM, including the location of any
> blocks copied from physical and any blocks synthezied. This is the
> only way to be sure the config space is actually 100% consistent.

Where is this concern about config space arbitrarily changing coming
from?  It's possible, yes, but vfio-pci-core or a variant driver are
going to have some sort of reasoning for exposing a capability at a
given offset.  A variant driver is necessary for supporting migration,
that variant driver should be aware that capability offsets are part of
the migration contract, and QEMU will enforce identical config space
unless we introduce exceptions.

> For non migration cases to make it automatic we can check the free
> space via gaps. The broken devices that have problems with this can
> either be told to use the explicit approach above,the VMM could
> consult some text file, or vPASID/etc can be left disabled. IMHO the
> support of PASID is so rare today this is probably fine.
> 
> Vendors should be *strongly encouraged* to wrap their special used
> config space areas in DVSEC and not hide them in free space.

As in my previous reply, this is a new approach that I had thought we
weren't comfortable making, and I'm still not very comfortable with.
The fact is random registers exist outside of capabilities today and
creating a general policy that we're going to deal with that as issues
arise from a generic "find a gap" algorithm is concerning.

> We may also want a DVSEC to indicate free space - but if vendors are
> going to change their devices I'd rather them change to mark the used
> space with DVSEC then mark the free space :)

Sure, had we proposed this and had vendor buy-in 10+yrs ago, that'd be
great.  Thanks,

Alex

