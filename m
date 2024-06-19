Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0A91514D0
	for <iommu@lists.linux.dev>; Wed, 19 Jun 2024 16:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718814605; cv=none; b=h0Ad8B3PhoNpR1cqtNUa1bnYIT2tN/aEypopp+Rm9ZPtI069iilrP3GnO1Lf+AVAvmaUJysAnZK3AY5qocB2x9v8h+bVZSbYKxLDVXz/JEYP7oPeHAYDkLewyTYO7hlZJCF9nuzkmRiWf9wHl/pNbqFZ4GyGEoRG3V8de3Onx6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718814605; c=relaxed/simple;
	bh=82XceL+YciLTG3nHflFVuex7M++I4Coz2CHC4Pzh3ZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vjp8IAdGLXz6bTvpKbmUYeREkTMv6Erpw/rxNYMYVoRxzUoDO+dqPW7pByiI3U0n7R2qAA/9exaxjxO34lv88IKlTnAFKoh9hfBHPD3K9vfGGO/hTOjZ+a1LGKViXMuf2QjHwDO2yP9jb1aRC7QFwYEtO6LkF6hfQzID3xB30H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=d4pUOFM0; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="d4pUOFM0"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6b0745efaeeso154406d6.1
        for <iommu@lists.linux.dev>; Wed, 19 Jun 2024 09:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1718814602; x=1719419402; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3c7XeNS34MogaG1zO0Gxm1rH0neHp06/RmAfCCHTdTs=;
        b=d4pUOFM0qn/VWNeCNZOIFqHckLm7DDSS6kBl5i0eGvDpmtL3X08oOzHjblxB5kBokC
         YEsleGpxONQPhUjaPStMfpBeLgeuMvGqLEM1vooFkzYA/Aigh7gWZQ1FbEmln8Ztksxn
         g/Q1W1NRCaFLJ6swu4E2mEJJnCglIujtXUR1gOjl3NFi7qTIl3aNcsdtVTZdX0Ju/iJK
         Gc7RB5KaspGrnWu29HU3wAHnuWiRImqrC+H3kfGswT/J/1fRlNMGEZG6l6eYBsOufHZp
         JiuuuWvUz7iSLmBn415ZqR/pJAcwf0MCo3db0ir7nRnl/IaLEeeT0ZcqS3l/1c5QuEyr
         Fn6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718814602; x=1719419402;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3c7XeNS34MogaG1zO0Gxm1rH0neHp06/RmAfCCHTdTs=;
        b=p4fILyhk9Txw8Q8fosGRjSBasZJYI3Wk8Wcm7zZFOnDc8DB2QVXghmwzt1Ka7wR29X
         C0kl7RyW30nsUmRNMoZerqeXFwIgZsNYcbx2kV2T+cKlGNve2t61cGg806jz76szb+ps
         8K4TfRWnJPX2DnC7IPCUkaxzhNV+lJhusvAH8pgCq7GNYaTVHwdfEchUrSrz4rvf+1lT
         5F+mtcQztT5OsZyi16Nm+JP4irnNg84ZEqM+iaQoeVJt5AgVa8ERp5ivrgMwuqfyz3ob
         tla+hAi4UJB1oqVAvbt7gjIEm8qxHgt2mhV5gHTmhfx3eXw9r+ZL33EqkA81L2RaOpdf
         L0mw==
X-Forwarded-Encrypted: i=1; AJvYcCX2FjKrfrRVWTwm3YmHndagC1VkyZP/y3cpuWAY0I4ns4RLl0/FR/gEod9680pv5Wfmb2Dl+hVOuiwqj7vZMoa/AlyV2j8=
X-Gm-Message-State: AOJu0Yw84AluzzABkDl1lvOaSo5pZhl0rmHGVGxIv2qTRCXzfTZSWNp7
	Y6ibE5uWRYyjBrDTui7Rx2cpIWscqWEp+O2RNVt3B6VCzYC8g2eZKXpMwKr+bOE=
X-Google-Smtp-Source: AGHT+IFNd2KMs9vwOpIBWhDkSpGzT3UnUk3IdJB0sc4eGBGCnxklfZldC9FeJXialSmZ2UnfepoWDA==
X-Received: by 2002:ad4:4484:0:b0:6b5:6a1:f899 with SMTP id 6a1803df08f44-6b506a1fbf6mr19249466d6.10.1718814602415;
        Wed, 19 Jun 2024 09:30:02 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5ee8bc0sm79593276d6.121.2024.06.19.09.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 09:30:01 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sJyC8-0059Sy-QH;
	Wed, 19 Jun 2024 13:30:00 -0300
Date: Wed, 19 Jun 2024 13:30:00 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Teddy Astie <teddy.astie@vates.tech>
Cc: xen-devel@lists.xenproject.org, iommu@lists.linux.dev,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
Subject: Re: [RFC PATCH] iommu/xen: Add Xen PV-IOMMU driver
Message-ID: <20240619163000.GK791043@ziepe.ca>
References: <fe36b8d36ed3bc01c78901bdf7b87a71cb1adaad.1718286176.git.teddy.astie@vates.tech>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe36b8d36ed3bc01c78901bdf7b87a71cb1adaad.1718286176.git.teddy.astie@vates.tech>

On Thu, Jun 13, 2024 at 01:50:22PM +0000, Teddy Astie wrote:

> +struct iommu_domain *xen_iommu_domain_alloc(unsigned type)
> +{
> +	struct xen_iommu_domain *domain;
> +	u16 ctx_no;
> +	int ret;
> +
> +	if (type & IOMMU_DOMAIN_IDENTITY) {
> +		/* use default domain */
> +		ctx_no = 0;

Please use the new ops, domain_alloc_paging and the static identity domain.

> +static struct iommu_group *xen_iommu_device_group(struct device *dev)
> +{
> +	if (!dev_is_pci(dev))
> +		return ERR_PTR(-ENODEV);
> +

device_group is only called after probe_device, since you already
exclude !pci during probe there is no need for this wrapper, just set
the op directly to pci_device_group.

> +static void xen_iommu_release_device(struct device *dev)
> +{
> +	int ret;
> +	struct pci_dev *pdev;
> +	struct pv_iommu_op op = {
> +		.subop_id = IOMMUOP_reattach_device,
> +		.flags = 0,
> +		.ctx_no = 0 /* reattach device back to default context */
> +	};

Consider if you can use release_domain for this, I think this is
probably a BLOCKED domain behavior.

> +	if (!dev_is_pci(dev))
> +		return;

No op is ever called on a non-probed device, remove all these checks.

> +static int xen_iommu_map_pages(struct iommu_domain *domain, unsigned long iova,
> +							   phys_addr_t paddr, size_t pgsize, size_t pgcount,
> +							   int prot, gfp_t gfp, size_t *mapped)
> +{
> +	size_t xen_pg_count = (pgsize / XEN_PAGE_SIZE) * pgcount;
> +	struct xen_iommu_domain *dom = to_xen_iommu_domain(domain);
> +	struct pv_iommu_op op = {
> +		.subop_id = IOMMUOP_map_pages,
> +		.flags = 0,
> +		.ctx_no = dom->ctx_no
> +	};
> +	/* NOTE: paddr is actually bound to pfn, not gfn */
> +	uint64_t pfn = addr_to_pfn(paddr);
> +	uint64_t dfn = addr_to_pfn(iova);
> +	int ret = 0;
> +
> +	if (WARN(!dom->ctx_no, "Tried to map page to default context"))
> +		return -EINVAL;

A paging domain should be the only domain ops that have a populated
map so this should be made impossible by construction.

Jason
