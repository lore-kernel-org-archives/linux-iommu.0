Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3315A305678
	for <iommu@lists.linux.dev>; Fri,  3 Jul 2026 17:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783099971; cv=none; b=T/646VeJyASTKa2+mPrAtxBB4BapKQT7oet0vW6+znZXy3BpVVEB8uJcE5M0Fx7MRsBU9TmNCn0UN6juKR4c0F3lpO0iG65elvOd3q+HgUb3tD6lzsCgCjscPq+eol48b6NCzejSuBd/pZGoXcYLf+Lg3keacW9TXbhqZCRg8Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783099971; c=relaxed/simple;
	bh=Wcpl1M8C6rbl+gWtOZA3jLQB6f728HV5z3+kNftSXRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ukTTcWJu+Irz/kJYpkAmKb90iV9PfvxcFag/Gvu5yvBDVr2jO/3F4stNXGvtavKwN4qySNCkQBIalINu5NutZBZLd0GgAw574xSxoZmSYgZh/VhObGz4Xy1J+szjZZgvFkUD1itUAHlTBNpYLykvbMBykD2uq/8ShJ1Xg6iAzZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=FcdhbDQO; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="FcdhbDQO"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-51bfbe05683so5676011cf.2
        for <iommu@lists.linux.dev>; Fri, 03 Jul 2026 10:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783099969; x=1783704769; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yiTtUHYVC+sBH8N9u4bqwWOXo++BMfy79AiAKwhU9io=;
        b=FcdhbDQOWUwQ1+peY9pcTByWKCcVrMTnFKM05K3E/gSgdKQfFq7h4dMHmca8HSaf4O
         OVdZY4nw2gNFeN0nhFOUzSHJ2X+EEuXRvGq06IV+GJkQYc3ekOaWeY6mZjkMThWcg0HN
         CS/KOerU55vMdBeF/QfIC2AKIE7or9kVa7hRemcV10bhjgISq0eO267fRcX0z3xXTEUJ
         1q9o29CKmA+S6Qa/HzaqqU5g9F6S1SlafBTW+9nPYgP6/pC6VioiGWtd7XxMTHgNGjLa
         IvmSmeQxwKkxr/xNzYE5GtUFD41IIPJQxtADmSaD1uzhisMPkxGSqz8+744rsCcjoMSm
         QqMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783099969; x=1783704769;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yiTtUHYVC+sBH8N9u4bqwWOXo++BMfy79AiAKwhU9io=;
        b=IPac9I6H4inOA48yzxx4M7XncKEpx7mDSoQzDaDAbDjD+VOpebrmOuZy3yrjF3EfsR
         qb9wxL8ewhWeUt4RtdtsoAwFHsl1R775UkihF+1zBCSY4Ik39Ns/ajZ9fEYqn1SsI3GL
         NElod/xxsb+8gj5ocfEfc7T1mJp1k3DDVj7tOUQ7uFu5LzCA2wLUNR3mCohPOhskrCBj
         LPa9VJxTHVMGfFGFMLAaTgL/pzb/PmhB4ZqDR3iDQ+YHZqICTPKGl6B/lG0TQrXUC8BF
         iAAljmN4mzqfwxulOP+s3pyESh6bxDAQ71+w44g1iAbFEZJzJvZG9fIQcARFUAlXwluk
         KviA==
X-Forwarded-Encrypted: i=1; AFNElJ+9Qcay8+bm9rZnYdYdgGqVwBcRrY0C5c2cH2z6dKarFlqjOjIFerBIBwEl5AkMGbLEiRIZIw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yydz/3WUGvUfsy9P4unjCsDJLVdVrYKrrAB/0EBuOqQVvwmRNFd
	iE+pLboN1gBrACjjjIvhmEusdQXRpqT0UA5Ba2gG4Gx35GRMdL22CYBLW5PIaWV1Ang=
X-Gm-Gg: AfdE7cmxxvvQXJtvKDXd5mh430ljtsqWqNUmyHsLlKiE8/LDIGcuNifvU+fjTXA5pya
	RFJaupLb7WGdq4PxdfuESA8HrBFz+NTi3qACBGBGMvH7er26jjXE6rkzSVk6FvIf7AdaJP3sRnU
	ICeLBfbklPzNQxSlY6hNutwsYbONrlclFcDocrcUUeTlHbVdlZSCaq1ynP7QQFo24nb5mOI0Qme
	AWPguiDaByp0yYYAoCKgOUju7N7oCN1ZGfdkpgnhH/rKi6WclZrn6UQBe4nSfUbZVP7bQJqvQoN
	pl27ys7aIBpVEwi3A1YRkGFkPT3xaCJzZo1b2takHmC35h18a70hIEe4q7vNgPDdCGtbY18OBTT
	UJc10PIMmHx5GhEXPTszCucFcKDBZ1wkAyUDJJFCwfJflEzfyL4yFR+F1DEKOyT3opyVvjD8P/i
	bPBH4o0MMBQ1KCm1xuhLhnLi5oSjMq21pfrbcIKB/XVcggEEM0BvgQaE+UlygukqTgF0M=
X-Received: by 2002:a05:622a:290:b0:51c:e14:87a7 with SMTP id d75a77b69052e-51c4c214c01mr7650981cf.28.1783099969076;
        Fri, 03 Jul 2026 10:32:49 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f472a9ad1fsm58402856d6.47.2026.07.03.10.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 10:32:48 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wfhku-00000008Ink-0GPL;
	Fri, 03 Jul 2026 14:32:48 -0300
Date: Fri, 3 Jul 2026 14:32:48 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Yu Zhang <zhangyu1@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
	iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org, wei.liu@kernel.org, kys@microsoft.com,
	haiyangz@microsoft.com, decui@microsoft.com, longli@microsoft.com,
	joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	bhelgaas@google.com, kwilczynski@kernel.org, lpieralisi@kernel.org,
	mani@kernel.org, robh@kernel.org, arnd@arndb.de,
	mhklinux@outlook.com, jacob.pan@linux.microsoft.com,
	tgopinath@linux.microsoft.com, easwar.hariharan@linux.microsoft.com,
	mrathor@linux.microsoft.com
Subject: Re: [PATCH v2 3/4] iommu/hyperv: Add para-virtualized IOMMU support
 for Hyper-V guest
Message-ID: <20260703173248.GB1968184@ziepe.ca>
References: <20260702160518.311234-1-zhangyu1@linux.microsoft.com>
 <20260702160518.311234-4-zhangyu1@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702160518.311234-4-zhangyu1@linux.microsoft.com>

On Fri, Jul 03, 2026 at 12:05:17AM +0800, Yu Zhang wrote:

> +static bool hv_iommu_capable(struct device *dev, enum iommu_cap cap)
> +{
> +	switch (cap) {
> +	case IOMMU_CAP_CACHE_COHERENCY:
> +		return true;
> +	case IOMMU_CAP_DEFERRED_FLUSH:
> +		return true;

This CAP isn't necessary anymore

> +static struct iommu_device *hv_iommu_probe_device(struct device *dev)
> +{
> +	struct pci_dev *pdev;
> +	struct hv_iommu_endpoint *vdev;
> +	struct hv_output_get_logical_device_property device_iommu_property = {0};
> +
> +	if (!dev_is_pci(dev))
> +		return ERR_PTR(-ENODEV);
> +
> +	pdev = to_pci_dev(dev);
> +
> +	if (hv_iommu_get_logical_device_property(dev,
> +						 HV_LOGICAL_DEVICE_PROPERTY_PVIOMMU,
> +						 &device_iommu_property) ||
> +	    !(device_iommu_property.device_iommu & HV_DEVICE_IOMMU_ENABLED))
> +		return ERR_PTR(-ENODEV);
> +
> +	vdev = kzalloc_obj(*vdev, GFP_KERNEL);
> +	if (!vdev)
> +		return ERR_PTR(-ENOMEM);
> +
> +	vdev->dev = dev;
> +	vdev->hv_iommu = hv_iommu_device;
> +	dev_iommu_priv_set(dev, vdev);
> +
> +	if (hv_iommu_ats_supported(hv_iommu_device->cap) &&
> +	    pci_ats_supported(pdev))
> +		pci_enable_ats(pdev, __ffs(hv_iommu_device->pgsize_bitmap));

This can probably just be PAGE_SHIFT

Also ATS shouldn't be enabled until a translation is installed,
otherwise the driver cannot participate in the ATS error handling
Nicolin is working on.

> +static void hv_iommu_release_device(struct device *dev)
> +{
> +	struct hv_iommu_endpoint *vdev = dev_iommu_priv_get(dev);
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +
> +	if (pdev->ats_enabled)
> +		pci_disable_ats(pdev);
> +
> +	dev_iommu_priv_set(dev, NULL);

No necessary, the caller does it

> +static struct iommu_group *hv_iommu_device_group(struct device *dev)
> +{
> +	if (dev_is_pci(dev))
> +		return pci_device_group(dev);
> +
> +	WARN_ON_ONCE(1);
> +	return generic_device_group(dev);

I think you can just return failure here instead of WARN_ON ?

> +static int __init hv_initialize_static_domains(void)
> +{
> +	int ret;
> +	struct hv_iommu_domain *hv_domain;
> +
> +	/* Default stage-1 identity domain */
> +	hv_domain = &hv_identity_domain;
> +
> +	ret = hv_create_device_domain(hv_domain, HV_DEVICE_DOMAIN_TYPE_S1);
> +	if (ret)
> +		return ret;
> +
> +	ret = hv_configure_device_domain(hv_domain, IOMMU_DOMAIN_IDENTITY);
> +	if (ret)
> +		goto delete_identity_domain;

IMHO I would change this around to have a single function that accepts
a struct hv_input_configure_device_domain as input and does both of
the hypercalls inside. Then here it is easy to directly construct the
hv_input_configure_device_domain for blocking and identity.

I'd be happy if this never touched domain_type, drivers shouldn't be
touching that.

> +static void __init hv_init_iommu_device(struct hv_iommu_dev *hv_iommu,
> +			struct hv_output_get_iommu_capabilities *hv_iommu_cap)
> +{
> +	ida_init(&hv_iommu->domain_ids);
> +
> +	hv_iommu->cap = hv_iommu_cap->iommu_cap;
> +	hv_iommu->max_iova_width = hv_iommu_cap->max_iova_width;
> +	if (!hv_iommu_5lvl_supported(hv_iommu->cap) &&
> +	    hv_iommu->max_iova_width > 48) {
> +		pr_info("5-level paging not supported, limiting iova width to 48.\n");
> +		hv_iommu->max_iova_width = 48;
> +	}
> +
> +	hv_iommu->geometry = (struct iommu_domain_geometry) {
> +		.aperture_start = 0,
> +		.aperture_end = (((u64)1) << hv_iommu->max_iova_width) - 1,
> +		.force_aperture = true,
> +	};

I don't see anything reading this, I don't expect this to be used?

The max_iova_width has to be passed into the iommupt creation, which
it does:

 +	cfg.common.hw_max_vasz_lg2 = hv_iommu_device->max_iova_width;
 +	cfg.common.hw_max_oasz_lg2 = 52;
 +	cfg.top_level = (hv_iommu_device->max_iova_width > 48) ? 4 : 3;
 +	ret = pt_iommu_x86_64_init(&hv_domain->pt_iommu_x86_64, &cfg, GFP_KERNEL);
 +	if (ret)

So just delete hv->iommu->geometry.

Also, VT-D has weirdness where the HW can require a 4 level table but
only a 3 level worth of IOVA width is being used. This was a
real-world bug we hit when converting to iommupt. This interaction
with the HV doesn't seem able to represent that.

> +	/*
> +	 * The page table code only maps x86 page sizes (4K/2M/1G); require the
> +	 * hypervisor to advertise a non-empty subset of exactly those.
> +	 */
> +	if (!hv_iommu_cap.pgsize_bitmap ||
> +	    (hv_iommu_cap.pgsize_bitmap & ~(u64)(SZ_4K | SZ_2M | SZ_1G))) {
> +		pr_err("unsupported page sizes: pgsize_bitmap=0x%llx\n",
> +		       hv_iommu_cap.pgsize_bitmap);
> +		return -ENODEV;
> +	}

This can just be

if (!(hv_iommu_cap.pgsize_bitmap & PAGE_SHIFT)) {
		pr_err("unsupported page sizes: pgsize_bitmap=0x%llx\n",
		       hv_iommu_cap.pgsize_bitmap);
}		return -ENODEV;

Which is all you really need. If the HV doesn't support 1G it is
perfectly fine, the iommupt page bitmap is already masked by this. 

> +	ret = iommu_device_register(&hv_iommu->iommu, &hv_iommu_ops, NULL);
> +	if (ret) {
> +		pr_err("iommu_device_register failed: %d\n", ret);
> +		goto err_sysfs_remove;
> +	}
> +
> +	pr_info("successfully initialized\n");

Don't log someting so vauge?

Jason
