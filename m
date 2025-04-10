Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EA628C5C1
	for <iommu@lists.linux.dev>; Thu, 10 Apr 2025 13:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744290335; cv=none; b=bQHN75pvTriI6DfsCp7O3XsA0+hsBew5yCz2CGYlP8Ko5pwuhHfsJwxVGsxxU8H8Jze9BZYWG0w8JYyUx3uoGHd7/I4F7fAoojzFY2at20zm6RD0hziw6wglyYixCMqJ65FIMBH4k6vNt0IT727nDyiV/XgRiaQDtXjSQwBPhxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744290335; c=relaxed/simple;
	bh=HMR9MCdcSh4ghNXN2PNjr8BtDW52Pk7L9AMhE1YOGEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NywDmE+0S4s0XRN92ZTLgZtgeplrJk4FMCHGtBms/jDxgxdPshEq1mjp6RmP3Rgh4oSEhDsgZN6m3Uy+l3nXbu0BJqYhMuGjeS5ZX6FGlx98g2yc/EVIikojB68mpmaFx4bXVWiQrsEQeAJqtEVTLoXCQj4RpqaQ4h1iKKm9h/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=OsTnzLcN; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="OsTnzLcN"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7c546334bdeso65861885a.2
        for <iommu@lists.linux.dev>; Thu, 10 Apr 2025 06:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1744290331; x=1744895131; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZHIQ/++9W1bwFwjTR3scNHhBiiv2Oa9aNs8dRl0dl1I=;
        b=OsTnzLcNJplDvhcrb4iiB1wJ5UrrJoPmzEzoB67wS4c7SBD4ARv9JgYmqe8GpkHH0w
         RZN23wb15Sq1dsXbyvTpG0nlDSLBK//4J0w/T4qhMZ13tOYRKioK7i/6BXSozhcwzRDO
         qeHgUifrkssEXGnL+btT0J/BCoHCwbKkXvhoM44mT9fUj/ks5yo4gg1+AQ0Hvt2kCn+V
         pq2eg13wHtZfStvO+7Y4NO/A8AG02lEeeFr5QSO3dCRkrvYL9na/KCoLymwMWOrwGFzX
         iM4i0UPvrMBm2+mDJKKnCtFnnMnjOqc6JDAf1drtr/HfneZ3nI5FClFRD/KZ0wm+WfqK
         /kYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744290331; x=1744895131;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZHIQ/++9W1bwFwjTR3scNHhBiiv2Oa9aNs8dRl0dl1I=;
        b=XfvqxHCuQYWV3FwymuUXExdq2qGL/XV2PtzrZq01/RJbJB5lIDVIJRegVRnQsNkjmg
         jns6uAjgg8b7TmAjTkives/NkDktq1JUXnMzMU5B1Ke2TAblDBtwhepoME557w4D9v0A
         uu00e0BrcLwUk3mgr152EQsUuzDDqyG02G/iR3sYOjjsIZp8jckqyyybMXJeZSV0vMlW
         U+xQb2TbwEGDmLsugzLt0jqA89poW5cMm9NgPWHfBiKhI4Sk8hXtJKiTQVx2badqIob+
         /+wn2ON9351oLl22ssdUfJUvaPlf+hMsk4GKG6a8F5JqK/o0GBabPMP7gIumNbyCKF0e
         vcIg==
X-Forwarded-Encrypted: i=1; AJvYcCXOiN669DI9AawTGXbM46gi9+e8CDIp9pilZd0L/J5YZ/8Bz/HZdJSE6oP7qbAwXRpa3Vygig==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy2X1uS6s0vTAppjKrUow9+oTxP7af7gJxwDdxXjGTpY78+YxLw
	4Qy1hhpsg2Vexor4wAoPtdCaZmTaonEBYhlZJuLegFBPjxGbOvaUjkzkgS8ntXs=
X-Gm-Gg: ASbGncsfmWy6xL8E4WkoOFI1w6QKyTsCaImj0i2VUISpDSZ6V9q8MXejm4e3Nzv84xA
	LoeJ79nRdMg8fN2uwd9L2hYLphlRTzzAexhSSzivZn6z9WamF1OAdip41BgpEX7WRlM+yne7T3e
	x5WwPjNZ3pTJtuJpNkYjX89b6dKZ2ibgqg8EzhGdPzDCEw2f/qqoWeq60V+SyC9kxU8pM8e3YOi
	uyyZfPq0LkDhI94Io68x4MaQNpUsQf7MCr2VSBzANQs1s3wJbwrVxSnzG5E5sOaWyaWa5c2Tgtp
	0l569ptM0I9VSgfImiC87N2sSFe3grySD0NHSNoQIXj1kUq8Katzqm9wNpm4XhNkDcH2bCFeVtf
	nP7bF+W9HO2OntltvECA=
X-Google-Smtp-Source: AGHT+IG4IzEnrtMNm0AmTZUaqXGTX04b5UW6VZBKQK8VGv14pbPLZJgnECNrc0NUhMe5YZKTD9kaag==
X-Received: by 2002:a05:620a:2445:b0:7c5:99f9:6ada with SMTP id af79cd13be357-7c7a76d3503mr365847885a.50.1744290330960;
        Thu, 10 Apr 2025 06:05:30 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c7a8969f1asm82420785a.59.2025.04.10.06.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 06:05:29 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1u2raz-00000009aH7-1871;
	Thu, 10 Apr 2025 10:05:29 -0300
Date: Thu, 10 Apr 2025 10:05:29 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: x86@kernel.org, kvm@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>, Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Christoph Hellwig <hch@lst.de>, Nikunj A Dadhania <nikunj@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Joao Martins <joao.m.martins@oracle.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Steve Sistare <steven.sistare@oracle.com>,
	Lukas Wunner <lukas@wunner.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Dionna Glaze <dionnaglaze@google.com>, Yi Liu <yi.l.liu@intel.com>,
	iommu@lists.linux.dev, linux-coco@lists.linux.dev,
	Zhi Wang <zhiw@nvidia.com>, AXu Yilun <yilun.xu@linux.intel.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>
Subject: Re: [RFC PATCH v2 13/22] iommufd: amd-iommu: Add vdevice support
Message-ID: <20250410130529.GE1727154@ziepe.ca>
References: <20250218111017.491719-1-aik@amd.com>
 <20250218111017.491719-14-aik@amd.com>
 <20250401161138.GL186258@ziepe.ca>
 <b051dcc8-58a5-4f24-8b06-e817e9762952@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b051dcc8-58a5-4f24-8b06-e817e9762952@amd.com>

On Thu, Apr 10, 2025 at 04:39:39PM +1000, Alexey Kardashevskiy wrote:
> > > @@ -2549,12 +2561,15 @@ amd_iommu_domain_alloc_paging_flags(struct device *dev, u32 flags,
> > >   {
> > >   	struct amd_iommu *iommu = get_amd_iommu_from_dev(dev);
> > >   	const u32 supported_flags = IOMMU_HWPT_ALLOC_DIRTY_TRACKING |
> > > +						IOMMU_HWPT_ALLOC_PASID |
> > > +						IOMMU_HWPT_ALLOC_NEST_PARENT;
> > > +	const u32 supported_flags2 = IOMMU_HWPT_ALLOC_DIRTY_TRACKING |
> > >   						IOMMU_HWPT_ALLOC_PASID;
> > 
> > Just ignore NEST_PARENT? That seems wrong, it should force a V1 page
> > table??
> 
> 
> Ahhh... This is because I still have troubles with what IOMMU_DOMAIN_NESTED
> means (and iommufd.rst does not help me). There is one device, one IOMMU
> table buuut 2 domains? Uh.

It means whatever you want it to mean, so long as it holds a reference
to a NEST_PARENT :)

> > You can get 1:1 domain objects linked to the viommu by creating the
> > 'S1' type domains, maybe that is what you want here. A special domain
> > type that is TSM that has a special DTE.
> 
> Should not IOMMU_DOMAIN_NESTED be that "S1" domain?

Yes that is how ARM is doing it.

Minimally IOMMU_DOMAIN_NESTED on AMD should refere to a partial DTE
fragment that sets the GCR3 information and other guest controlled
bits from the vDTE. It should hold a reference to the viommu and the
S2 NEST_PARENT.

From that basis then you'd try to fit in the CC stuff.

> > Though I'd really rather see the domain attach logic and DTE formation
> > in the AMD driver be fixed up before we made it more complex :\
> > 
> > It would be nice to see normal nesting and viommu support first too :\
> 
> It is in the works too. Thanks,

I think your work will be easier to understand when viewed on top of
working basic nesting support as it is just a special case of that

Jason
