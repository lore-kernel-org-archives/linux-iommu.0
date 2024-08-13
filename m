Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8DC1A0B00
	for <iommu@lists.linux.dev>; Tue, 13 Aug 2024 16:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723566048; cv=none; b=fQmYxAXGEEMrrbxj+5iB5i3o5ZoVw26JGmZU4kYv7xnt0pM/MxBp/9tSqLtHjJ23knsaXh0GXlOeS2Q7wpxgcWtt2xwnALPAyD7KJOw7FSBF6iWXW2mUe/JZler1VhXxE8xl1jMi2kLnFARlk23yBjYpm7PAJ/cOIrloKpztpS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723566048; c=relaxed/simple;
	bh=+9wkQGPYmUheiEipMVFsnkcQgN8JlF9+u7qlkp96n+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ciPJ+4NVOYRiBTk82ifUXAOrslJ/QPeYUuDRexZifqv01g6UAVlFLz0sRed4a4WGwywpvxWo8VZgcMOJlPv0LZXdjzNLZ8M3CicNvHAf0k1kOuRrSr3sMvDaPp30/7iKsDH9xamCgX99iR4waFF67xUaPNnd7rKiK2tPADp6bf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=GkZPu0iO; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="GkZPu0iO"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6bd936f6fc1so12544736d6.0
        for <iommu@lists.linux.dev>; Tue, 13 Aug 2024 09:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1723566046; x=1724170846; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wMEq4LbyuxOtml7HFeYfnn5WvGQEvm/oJ5mICOXvZ94=;
        b=GkZPu0iOb9K8Y0SjqfEhIrAjthY/5AKfgipNsKRmvLUi3qOUkpCUL16QJc/pnVZdCD
         GWCAj8PQETLkKkggrvhG7WNY7js8RoiJhxizdmnolgwrzcJae1K6ahc1fKVD4XgdYV5P
         b8tc7ECrSJwQA4b265zucfjknsZGY2V4dsPzoqN79XMT7TFsDYpC0uOZLnlmyH1rVw5z
         guH+LhdbD77dbAS6EN+hbWwCcfGup2PVs2bENZ0bxELfECIZFQ5fkNavnkudlZzaelNS
         acH2rdOfr0ThNKA2X5P2T84DRlwiQlh2kmaVQULz0UDCP+BdSiQmXqs8pot69m2X0A3K
         SfrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723566046; x=1724170846;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wMEq4LbyuxOtml7HFeYfnn5WvGQEvm/oJ5mICOXvZ94=;
        b=JsnG+8N7qc8Z98D1ftySByTa4K5+bvwSs1yr4XSsXVb4Mm40eyzXm6YlsIiOQtKtw/
         mH+BRMWxB0znmsCt93pbjNBZYb4yY8+h8uNKJmSpTpssV/7cJ3hZKegw4rRLgG/hy2qM
         nPkV6DO5LzvVK9Bd2K4gg8g9vHbfS9t87yX2ncPAYLtK4oD6U46VIlC50LVAuU8GrEIu
         f3iSsZxXOCEo9nbhcHXO/OdMYZCikUyzh22ZLdP/aHFTGAmwVtrKprGyuAX8uFZOb0oh
         8b9miTmYkLclRMad/7kzV5lKwE/YKnwHA09EgX2jDDIlrOak5iwGH3agWj3htQpWF2jX
         9V1w==
X-Forwarded-Encrypted: i=1; AJvYcCXNjNleVCZ9c8UbS0rhzJ7vBs+643sjPghR1GxjopMT8f84KkJgR8/HE1xmwz/VDmCZlfa3Yf/ahmumM3tRsEuyzxgB42I=
X-Gm-Message-State: AOJu0YzhjTJPWCtPGQVVS37DFy0D7zFEg8bjAVnI9ihqiUYQjy0Xm4UD
	R/upy2SQaxLw+KAmdbVuXSjc2tA1sCNuP6keQvA735qcv+vlu8xIfP+38w2oa0M=
X-Google-Smtp-Source: AGHT+IErsKkH1GQT6qnua4JuEwHNOPxQRCUSrmwccspXWVk4ixKNiznO3/lCgerLOMnspC502Obk6w==
X-Received: by 2002:a05:6214:4611:b0:6b0:7485:719c with SMTP id 6a1803df08f44-6bf5d164290mr381956d6.2.1723566045680;
        Tue, 13 Aug 2024 09:20:45 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bd82e314b8sm34778776d6.103.2024.08.13.09.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 09:20:45 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sduGK-008Nj9-1d;
	Tue, 13 Aug 2024 13:20:44 -0300
Date: Tue, 13 Aug 2024 13:20:44 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Vasant Hegde <vasant.hegde@amd.com>,
	Baolu Lu <baolu.lu@linux.intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH RFCv2] iommu: Add domain type and flag to
 domain_alloc_paging()
Message-ID: <20240813162044.GI1985367@ziepe.ca>
References: <8e531f39-9d14-4d3b-8a52-c2e8ca026f9e@linux.intel.com>
 <098008f7-2b3e-405a-a096-947e5df560e6@amd.com>
 <20240806123452.GE676757@ziepe.ca>
 <6b197aac-c38f-4e6e-9d32-d74e1a5b3968@amd.com>
 <20240806173230.GS676757@ziepe.ca>
 <bbe564b6-5079-4973-8678-1068a53ddf70@amd.com>
 <20240807135915.GF8473@ziepe.ca>
 <e5da0709-86d3-4b45-82cc-d995a2686afa@amd.com>
 <20240807182947.GI8473@ziepe.ca>
 <BN9PR11MB52765C37F5401E9AA7113D748C862@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52765C37F5401E9AA7113D748C862@BN9PR11MB5276.namprd11.prod.outlook.com>

On Tue, Aug 13, 2024 at 09:40:32AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@ziepe.ca>
> > Sent: Thursday, August 8, 2024 2:30 AM
> > 
> > On Wed, Aug 07, 2024 at 10:22:00PM +0530, Vasant Hegde wrote:
> > > > Needs more words, maybe even two flags?
> > > >
> > > >  @IOMMU_HWPT_ALLOC_DEV_PASID: When the domain is used on a
> > device,
> > > >  with no PASID, the device will support later attaching a PASID as
> > > >  well. Some HW requires a specific domain format on the device to
> > > >  allow PASID to work.
> > >
> > > I will add this.
> > >
> > > >  @IOMMU_HWPT_ALLOC_PASID: The domain can be used as a PASID.
> > The
> > > >  domain attached to the device must have also been allocated with
> > > >  IOMMU_HWPT_ALLOC_DEV_PASID.
> > >
> > > Why do we need this flag? Previous one is already allocated PASID capable
> > > domain. Is this similar to SVA domain?
> > 
> > IOMMU_HWPT_ALLOC_DEV_PASID is the flag you specify to allocate the
> > domain you will attach to the RID
> > 
> > IOMMU_HWPT_ALLOC_PASID is the flag you specify if you intend to attach
> > this domain to a PASID
> > 
> > They are actually different operations from a user perspective. Today
> > every iommu driver implements them with the same logic..
> > 
> > So I thought perhaps they should be seperate, at least if we get some
> > really crazy HW down the road the uAPI will still work. uAPI is a bit
> > more tricky because you can't change it.
> > 
> 
> I'm not sure it's necessary to push this burden to all existing IOMMUs
> which don't have such requirement.

If we are making a common uAPI then we need to have all the HW act the
same. No implicit behaviors that people accidently rely on.

So if we say you need flags before domains can be used with PASID then
the core code must check those flags for all HW even if it is a
driver-NOP.

So what are the flags you want?

Flags = 0 means the domain cannot be attached to a PASID
Flags = 0 means the domain cannot be attached to the RID while PASID
is in use

The core code should enforce this rule always.

Above that we minimally need

Flags = IOMMU_HWPT_ALLOC_PASID allows the domain to be attached to a
PASID

And you need to decide if the RID usage is bundled with the above as
well.

> Can we simplify it by just supporting one flag and then incrementally
> add another one when a future demand comes and advocate such
> new requirement by GET_HW_INFO?

Well you end up not supporting any special cases that would need
it. It is uAPI so it is good to always be mindful that things are well
defined and clear.

If you want one flag then it still has to do both behaviors and you
still have to describe and enforce both behaviors. So I don't know
there is a lot of savings, or that it is clearer.

I hope nobody ever needs two flags, that would be terrible HW..

Jason
