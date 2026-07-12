Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7D737A820
	for <iommu@lists.linux.dev>; Sun, 12 Jul 2026 22:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783894289; cv=none; b=r/pyQURggBSggFNnFNrxqrYP3DzhjhUCdlGGyiv8wG5RZdVWOmygYWIigtuH05yPn5GtR/cO9j+NkfR9j8pJNqFHF5ejyv2WjIHFLMdukqI72itUiD7tLtHweOxkKt/LIiB14+F6KbKw56muupfpuk7j43048YR3RoY3T9A6H1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783894289; c=relaxed/simple;
	bh=vICjuJZMyL8ox/LroketggeEi023fKRGGXjlLd3/YVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BZctkeKo8flFsubtFnTkyBOX0nENjuDaTcbU9r6Xh1aN1zLVR11a97oQYAvuBzEu6a+Srbpb/MQnqb01cBUfcyjlj8dnn3yAlaKHUlIlEYJy5rkVwKZUUbr78jDyUSyoK0qciszd0KMyyIsIcihzj5k2itEFtNUk+cAh3KVNf/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=d5eAOVXt; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="d5eAOVXt"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8ff5d1b0f91so14637366d6.2
        for <iommu@lists.linux.dev>; Sun, 12 Jul 2026 15:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783894286; x=1784499086; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=egnmCxbrpH7UR+MZJeffNbFqc9tcIYQZ6W/rYZyeos8=;
        b=d5eAOVXtzs3RfJkskFqaJcYXEXnzWr3meAs+/dlP/m3Lq/+xLITH3maziciht9tVBN
         iZLcjfiJEW0Bj+L9yhrGKPM/tc/FhAV4p9kTfrF//tIt0WBMYY744TZiybnjGpW5mLrb
         gMJbuXT1nauzNZkqcZ9oRhH8RozTIZs0gMrJHLa7E9szeKALRqqu5/bFfKAJ0vzvHPgG
         ZFMHb/P47Jto7oVy/fyXTNqBvsDjIsnR0UXAwz2jM+t44Ao/FEeF1KWgJaPnp5MB20Lt
         P02sytIRDfJ/LDKDe47jgcbi5f/mqtGy91kEMTzQ6b+t9FImxHT4puRv/y89gltyRju7
         0olw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783894286; x=1784499086;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=egnmCxbrpH7UR+MZJeffNbFqc9tcIYQZ6W/rYZyeos8=;
        b=Yskl/tvSiocNyeiPvbpQrkJPs/UMxCH9p/u94W6UibrAEtCJ1G+Gso/c2q7h5FNg+R
         pxwtlWLzuUGiPJrU9jhxov9dYTbJ/NcAUDVNOovigBDR4bOYttSENMydQ6GDzpTxSjdj
         KFtvZuuqbHcwNvB4IWwCrO/plvggq/Ymjo89F+mwmKVcJ4svowamiTWw1wjPHIZzAgBJ
         sJc6MJLwyhopkcVYJm8OPsPHeq0MuclXTfNBcuWXS/w1tJsGAR/kRk0axXjhzZ5N9/sl
         ifNAhWUPoZeNXSFlyiq7NsVpXtopy9932ZToAigNqDtv0veT22/6/CGypVLf29qtSROE
         peIQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr+mBU7V7K23cWdauxIIhv9fN+zG2MzkNYaAZs5Ef2KuDeWFg0EH+HBzIRaxb2kXSDwiRST6A==@lists.linux.dev
X-Gm-Message-State: AOJu0YzlUVKTEHCcq9Ja1rDSColA35u/VA1MaEe/YGJ//NublnYX34MR
	wdK/dQ6ZLhlgrxCRbZ2r53eS7XEYotFpi4hlb1YA1O5gSy/v18/fdc7GCrhOqUfU42s=
X-Gm-Gg: AfdE7cnwejYzn233z3Sl41Y3PLUVzS6aXLxNcV4YNUzr/oGWUFLpt+S+WtQ3LcZvUCT
	ilcBXPvqX0zufe8UkhplKGoufvzj58Q+jYZ9bfT2x1jSckBFB7f0sjaRiaYnoVIRIwRDwcvvEaU
	/bFY0d5vo37xuWPKG4xuwYIwXuc37vuKiK9HwiBZyJ4GQldceH4twi5rIATu9tR22GB+A2RJ/Ho
	+FueRhFlFQ9K9tZVW9CKVnbwpFKaijS9a+lC21u53RbMAUyhoRoEDfnPxuet3za4nzBirbIYKTi
	QssZTpfWh6XfBXZCK6G9B7KEwF8lSviBnuqjtcng3+FBVa/X92eWXY/ljhNbOfpkqRHUFVZtQUr
	p4Y9hkXuqTBlPFOoHJjvyHaeqWSsySGRmCiCggkuMMLfCfJEbgGU6sugi3nEu
X-Received: by 2002:ad4:5dc3:0:b0:8f1:440c:7f81 with SMTP id 6a1803df08f44-903fe450e71mr71838966d6.4.1783894286578;
        Sun, 12 Jul 2026 15:11:26 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd50e10f4sm113814616d6.1.2026.07.12.15.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 15:11:26 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wj2OT-0000000Bo42-2Ctj;
	Sun, 12 Jul 2026 19:11:25 -0300
Date: Sun, 12 Jul 2026 19:11:25 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Daniel Drake <dan@reactivated.net>
Cc: "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	nick.hollinghurst@raspberrypi.com
Subject: Re: [PATCH 5/6] iommu: Add Broadcom BCM2712 IOMMU driver
Message-ID: <20260712221125.GD1835788@ziepe.ca>
References: <20260712-bcm2712-iommu-submit-v1-0-80e10cdde2ea@reactivated.net>
 <20260712-bcm2712-iommu-submit-v1-5-80e10cdde2ea@reactivated.net>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260712-bcm2712-iommu-submit-v1-5-80e10cdde2ea@reactivated.net>

On Sun, Jul 12, 2026 at 10:18:55PM +0100, Daniel Drake wrote:
> +static int bcm2712_iommu_of_xlate(struct device *dev,
> +				  const struct of_phandle_args *args)
> +{
> +	struct platform_device *iommu_dev = of_find_device_by_node(args->np);
> +	struct bcm2712_iommu *mmu = platform_get_drvdata(iommu_dev);
> +
> +	dev_iommu_priv_set(dev, mmu);
> +	return 0;
> +}

Any chance this could work the way that smmuv3 does? I view it as the
more modern example..

> +static int bcm2712_iommu_map_pages(struct iommu_domain *domain,
> +				   unsigned long iova, phys_addr_t paddr,
> +				   size_t pgsize, size_t pgcount, int prot,
> +				   gfp_t gfp, size_t *mapped)
> +{
> +	struct bcm2712_iommu_domain *mydomain = to_bcm2712_domain(domain);
> +	struct pt_iommu *pt = &mydomain->pt.iommu;
> +
> +	return pt->ops->map_range(pt, bcm2712_iova_to_offset(mydomain, iova),
> +				  paddr, pgsize * pgcount, prot, gfp, mapped);
> +}

These ops should not be present, the iommpt provides the ops directly
through a macro;

> +static const struct iommu_ops bcm2712_iommu_ops = {
> +	.identity_domain = &bcm2712_identity_domain,
> +	.domain_alloc_paging = bcm2712_iommu_domain_alloc,
> +	.probe_device = bcm2712_iommu_probe_device,
> +	.device_group = generic_single_device_group,
> +	.of_xlate = bcm2712_iommu_of_xlate,
> +	.default_domain_ops = &(const struct iommu_domain_ops) {
> +		.attach_dev	 = bcm2712_iommu_attach_dev,
> +		.iotlb_sync      = bcm2712_iommu_sync,
> +		.iotlb_sync_map  = bcm2712_iommu_sync_map,
> +		.flush_iotlb_all = bcm2712_iommu_sync_all,
> +		.free		 = bcm2712_iommu_domain_free,
> +		.map_pages       = bcm2712_iommu_map_pages,
> +		.unmap_pages     = bcm2712_iommu_unmap_pages,
> +		.iova_to_phys    = bcm2712_iova_to_phys,
> +	},

"default_domain_ops" should ideally be split out to a "paging domain
ops" static and set directly during alloc_paging. They are not really
"default" anymore if the driver has unique ops for every domain type.

Then use something like:

		IOMMU_PT_DOMAIN_OPS(bcm2712),

To define all the page table related ops automatically.

Any chace the HW can do a blocking_domain, or is the only way to do
that with an empty paging domain?

Jason
