Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A4B16424
	for <iommu@lists.linux.dev>; Sun,  5 Nov 2023 18:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="htzGUpBo"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-778af1b5b1eso241306485a.2
        for <iommu@lists.linux.dev>; Sun, 05 Nov 2023 10:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1699208165; x=1699812965; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oMjRtGkADMXPD2kNvmxw4fZy95fi5rCRiLo0M/hXXb8=;
        b=htzGUpBo+opnN4246RXbl9cVFowgdLH8BuMrOsaFlu0s2x8otmHYtviXsamOxhFbK0
         Cb6SaI5Ax2793ONtllVjjLWvBfQ1o1xlxYYxYgkwLEqI1ORFjJIKyGFKF1cndkU0EUKR
         UTro2gkTJXY7/13Xq7tHc8o92w1fZh1ZgcJlJ5jaQhkq5GGPoi/BMn/G+eQJ88n1m6HU
         lUEzqULkWe8R11e4DxhURiJEYCzMwe2t011YBslEsb8ua3fQvBolwEDIiJYUs1fkLRJm
         kpRyzfAF7NSgkaeuw+x4q9IuIHeHdRqNAdOtz6rL0BEOdzStNsL/AMap+ro3Mq3A50KI
         UWIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699208165; x=1699812965;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oMjRtGkADMXPD2kNvmxw4fZy95fi5rCRiLo0M/hXXb8=;
        b=F1nxLEV9ZE61cO6E6NxaZKdhX3e50gX6y9XnSruQ8HmPEC6j0OGdGDK9/BVqsNF7Kg
         NsyLwjDMSAgQdy1i3spiexffz7DoXqwTEC6oWzwKNY4LDSGMeDw0yYC0DomgTg+4mmS1
         2Fr7sN5HUTqJ6pTKUyON8wers1LoodAVY5rmnaGVdbayDzZMh/knJ7OegwgH9+wkgAfT
         5DXvFpnUJhJds6ayf7DOm2s3oP3MekQt+QVsPdQF8QQiolAHn/GtzdU0Kj/erE6FPJIK
         ZvBFuVLqMk64Q18Lj0vgQ5HCmFeIxLagP0haJH4iCOXcmQTmGVmZiGoHtegXNNIwdT1t
         aAqA==
X-Gm-Message-State: AOJu0Yw551l0snjPQi2Hm71uAoggOpKmJgQIq3KsFQzTglIBupF5rst7
	tDY/VhSeIAK3dJzp3u9+n//aNU8UK+3xe9IINMA=
X-Google-Smtp-Source: AGHT+IHwNC0Arz+XXgHA5cSTJT9PH0WZHBnxlztWbPDzwf/N3KyKJUt2nXyOS/hrhy0gKiAPfx3qqw==
X-Received: by 2002:a05:620a:468d:b0:779:da55:b327 with SMTP id bq13-20020a05620a468d00b00779da55b327mr32397970qkb.11.1699208165429;
        Sun, 05 Nov 2023 10:16:05 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id l17-20020a05620a28d100b007770d47c621sm2604584qkp.66.2023.11.05.10.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Nov 2023 10:16:04 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qzhfI-001Ff2-5C;
	Sun, 05 Nov 2023 14:16:04 -0400
Date: Sun, 5 Nov 2023 14:16:04 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v3 06/13] iommu/amd: Introduce per-device domain ID to
 workaround potential TLB aliasing issue
Message-ID: <20231105181604.GH4634@ziepe.ca>
References: <20231013151652.6008-1-vasant.hegde@amd.com>
 <20231013151652.6008-7-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013151652.6008-7-vasant.hegde@amd.com>

On Fri, Oct 13, 2023 at 03:16:45PM +0000, Vasant Hegde wrote:
> With v1 page table (stage-2), the AMD IOMMU spec states that the hardware
> must use the domain ID to tag its internal translation caches. I/O devices
> with different v1 page tables must be given different domain IDs. I/O
> devices that share the same v1 page table __may__ be given the same domain
> ID. This domain ID management policy is currently implemented by the AMD
> IOMMU driver. In this case, only the domain ID is needed when issuing the
> INVALIDATE_IOMMU_PAGES command to invalidate the IOMMU translation cache
> (TLB).
> 
> With v2 page table (stage-1), the hardware uses domain ID and PASID as
> parameters to tag and issue the INVALIDATE_IOMMU_PAGES command. Since the
> GCR3 table is setup per-device, and there is no guarantee for PASID to be
> unique across multiple devices, the same PASID for different devices could
> have different v2 page tables. In such case, if multiple devices share the
> same domain ID, IOMMU translation cache for these devices would be polluted
> due to TLB aliasing.
> 
> Hence, avoid the TLB aliasing issue by allocating unique domain ID for each
> device even when multiple devices are sharing the same v1 page table.
> Please note that this workaround would result in multiple
> INVALIDATE_IOMMU_PAGES commands (one per domain id) when unmapping a
> translation on the shared v1 page table.

It is worth pointing out that this is a shortcut to implementing a
more complete solution where the domain ID can be shared right up until a
PASID is used.


> @@ -1418,6 +1426,19 @@ static int device_flush_iotlb_range(struct iommu_dev_data *dev_data,
>  	return iommu_queue_command(iommu, &cmd);
>  }
>  
> +/* Flush IOMMU TLB for the given device */
> +static int device_flush_tlb_range(struct iommu_dev_data *dev_data,
> +				  ioasid_t pasid, u64 address, size_t size)
> +{
> +	struct iommu_cmd cmd;
> +	struct amd_iommu *iommu = get_amd_iommu_from_dev(dev_data->dev);
> +	bool gn = is_pasid_valid(pasid);

Again it seems obfuscating to ecode the table type in the
pasid.

> @@ -1523,11 +1544,25 @@ static int domain_flush_tlb_range(struct protection_domain *pdom,
>  static void __domain_flush_pages(struct protection_domain *pdom,
>  				 ioasid_t pasid, u64 address, size_t size)
>  {
> -	int ret;
> +	struct iommu_dev_data *dev_data;
> +	int ret = 0;
>  
> -	ret = domain_flush_tlb_range(pdom, pasid, address, size);
> +	if (domain_id_is_per_dev(pdom)) {
> +		list_for_each_entry(dev_data, &pdom->dev_list, list) {
> +			ret |= device_flush_tlb_range(dev_data,
> +						      pasid, address, size);
>  
> -	ret |= domain_flush_dev_iotlb_range(pdom, pasid, address, size);
> +			if (!dev_data->ats_enabled)
> +				continue;
> +
> +			ret |= device_flush_iotlb_range(dev_data,
> +							pasid, address, size);
> +		}
> +	} else {
> +		ret = domain_flush_tlb_range(pdom, pasid, address, size);
> +
> +		ret |= domain_flush_dev_iotlb_range(pdom, pasid, address, size);
> +	}
>  
>  	WARN_ON(ret);
>  }

I feel like this has become pretty complicated.

I think this driver really suffers from not having the right
data structures to handle everything cleanly.

In smmuv3 I added a 'master_domain' structure that linked the PCI
device to the iommu_domain. ie when attach is done you'd create a new
master_domain that essentially stores the parameters required to do
invalidation.

For what is going on here I would say to do that an then put the
"domain id" inside the "master_domain". Decide when the domain is
attached if the domain id should by taken from the iommu_domain
(device does not support PASID) or from the device (device does
support PASID)

Then you don't need all this logic to try to figure out what the cache
tag is later on. And you can get build up to removing the
protection_domain->iommu madness and more properly integrate the pci
alias stuff too.

Doing this datastructure change was a big step that made all the rest
of the PASID/SVA/etc stuff I did in smmuv3 flow nicely and logically

Jason
