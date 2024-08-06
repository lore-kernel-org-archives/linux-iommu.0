Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6151BDAA3
	for <iommu@lists.linux.dev>; Tue,  6 Aug 2024 12:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722947697; cv=none; b=S6rWWBwaL0RdGmU0YVF69MvYzNczqSGj50HcVwkxbkKpeEZWrrTd0V3dWi04R87nJkx4aP1cwndlo0E+6o7OVUKmND241UwNwb5XtR1JZScRek+agMqBTRZF/n+UBuo49zLCDRQ8Ay4hP5HDMXOlxSV/zC4d2/sk6Zp0ERec3As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722947697; c=relaxed/simple;
	bh=r8rmV4jgeMJkmzZ2MBVxQuEVVb5Pmne7D+T5M4+W2X0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O7skBAopSmSIO77rtkrND4k9JeNErfMYxeDa3JidZqdlb+Y+jdTGpo88uP30iFPojU4zUsCFKIHWcx1L7pzQY9frePAQpojHgeIWBS1oYHo8ICmMH/lAWx3a5KSgdsgoU2XXl7ceW1DnSDh8APptSKgHsQ3pjNcB+YtnErrG3Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=SsN0qMLM; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="SsN0qMLM"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6bba6ced3d4so2266786d6.2
        for <iommu@lists.linux.dev>; Tue, 06 Aug 2024 05:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1722947694; x=1723552494; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tT87GVmE4PazQcQpqemDvL8DBN7ES24yAzLyZIfJhqQ=;
        b=SsN0qMLMsHef3xH9SwOSzsHo124ROs3ok3ddZQzPsBaajt5skpf4Bw+NvHpY9RAN/j
         HXIh0fkbH0De2Ae8u8jJzssiSlUE7pa8Og/0+LZB4nn/kQ897Q/5RbhkrMl5marK8WLK
         NwBn8eulBnXXi1yJRzO3DrLokNVSRMJaPTi0Nb7qGbA0CGTG11I3RTl0wW0jhtYRXvno
         6E7gLlVRIlgY8TjO0Dnmc357mhGNAXfFAtJn0nJ68z6s8oUmEOVYcRm6vpa6TpvJRh+u
         /+ZH6Z32R+kPjl1zENDPEzaiPEpAsa7LuzAs/mr95lmgZ5a1hqcIT+n8xlES3S1ni8zr
         wNhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722947694; x=1723552494;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tT87GVmE4PazQcQpqemDvL8DBN7ES24yAzLyZIfJhqQ=;
        b=RG5NL6jv8UlLngu8jG6id9mMyuFSJSai/ufPl6KGNH1PxtBnfUAQWGObmm2tStGSc+
         9W8gcvY4VqFK/3eeThI4aDx7asxxDW/zmNcN+eIzKkxLq1m2TwdvbUcG+3LZl5A/iDWA
         YvOQ4i60CHXhTRGYQcrPTe25aHYxMXxhVioyNRw7EAqf8r5CXxo5CwM00sFoCVxQyjan
         S/On8ExrWd37qLntmyszVSbBL7KMddKnG5XRgtfuvzUicGBGYqYrCX16GXp8yIwqJUmz
         ys2WMybt99hVjVXGUuuy3t1xkPf72Nc7zCim0ihCg3yXfuW9/EKqmkjwt3JwVoRHtjNL
         Vz6A==
X-Forwarded-Encrypted: i=1; AJvYcCV5WcqH+ryS0eggxcFHYY4jB7s8vSMhu7UQhbakgSiMpLG+N4NNksBYf6MHeNT/7zQBlARE4mXwZhf8FDxbrLeCOy09jVU=
X-Gm-Message-State: AOJu0YyBgzurtT57W/gfyolYAQohjA+idL58zrxvPlzNf0N21psLODgU
	RSgawQlG6fcAUANFV83QO9BwtgJMmEGABwRqDGRu16hcxQR/dyyIRrvC0NirEbA=
X-Google-Smtp-Source: AGHT+IGmYQFj1ribzYl9gphX3skOBCcH3cNPrQ+MYzDmvPNBOyJNFL/h/6Y5NFSlQz+sUvZygGTpHw==
X-Received: by 2002:a05:6214:4389:b0:6b5:4865:948f with SMTP id 6a1803df08f44-6bb983fc1bamr126034186d6.27.1722947694339;
        Tue, 06 Aug 2024 05:34:54 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bba1527214sm41599216d6.116.2024.08.06.05.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 05:34:53 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sbJOu-00EH65-RA;
	Tue, 06 Aug 2024 09:34:52 -0300
Date: Tue, 6 Aug 2024 09:34:52 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev,
	joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	suravee.suthikulpanit@amd.com, yi.l.liu@intel.com
Subject: Re: [PATCH RFCv2] iommu: Add domain type and flag to
 domain_alloc_paging()
Message-ID: <20240806123452.GE676757@ziepe.ca>
References: <20240801144523.11803-1-vasant.hegde@amd.com>
 <8e531f39-9d14-4d3b-8a52-c2e8ca026f9e@linux.intel.com>
 <098008f7-2b3e-405a-a096-947e5df560e6@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <098008f7-2b3e-405a-a096-947e5df560e6@amd.com>

On Fri, Aug 02, 2024 at 11:23:52AM +0530, Vasant Hegde wrote:

> >> +    struct iommu_domain *(*domain_alloc_paging)(struct device *dev,
> >> +                            u32 iommu_domain_type, u32 flags);
> > 
> > I still can't see a value to pass the domain type in this callback.
> > Different domain could have different domain allocation callback, hence
> > the domain type has already been implied.

+1

> > For the paging domain, there should be no difference between DMA and
> > UNMNANAGED from iommu driver's point of view.
> 
> That's true. Its all paging domain. But we need a way to indicate the desired
> capability like PASID.
 
> I thoughts we can use `type` for allocating domain and then `flag` to pass the
> quirks. Otherwise we have to club everything in `flags` itself.
> 
> Something like below works ?
> 
>   - DMA-API domain : flag - DOMAIN_ALLOC_FLAG_PASID
>     If both device and IOMMU supports PASID it will allocate PASID capable
>     domain (Like AMD case domain with V2 page table). Else it will alloate
>     non-pasid capable domain (In AMD case it will be domain with v1 page table).

This is a much larger problem. The DMA API domain is created way early
before any drivers are bound. If it doesn't support PASID then no
drivers will get to use PASID at all.

You'd need to figure out some way to switch the DMA API domain on the
fly around when a PASID wanting driver binds. This might be reasonable
since PASID devices tend to need single device groups to work at all
and we could conceivably switch the group under driver control during
early binding.

For now we expect that the DMA API domain will support PASID if the
underyling device supports PASID, that is the only way this can work
today. Meaning domain_alloc_paging() must always return something that
can enable PASID.

>   - UNMANAGED domain : Do not pass *_PASID support flag
>     Since PASID flag is *not* passed, driver will decide best suitable page
>     table (in AMD case, we will allocate V1 page table)

And here this is only VFIO. When you figure out with Alex and Yi how
VFIO will decide to do PASID or not then pass that indication through
the existing flag argument on domain_alloc_user(). At least this is
pretty simple.

But as I said before, the important thing from your perspective is
that VFIO does not default-on PASID support!

Jason
