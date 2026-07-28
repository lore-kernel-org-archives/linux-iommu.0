Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF51422E23
	for <iommu@lists.linux.dev>; Tue, 28 Jul 2026 10:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785235882; cv=none; b=es1QO8F51ds2Hm0BLFQDn5jCOWV/jsEtwPWyjSCgmcIHT2qEB4ouupA6FUQGO2g8a/8xUuJM1ud7jt+ksZ3Kao40MEfT280a4Anh2n0ItBWD3E1SiS2ohn3aVILeHM8Ku8ilerEFrGBJrESY44G5BgaxiZ4ZDxlcupEtMHTSZNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785235882; c=relaxed/simple;
	bh=aoYVGfnSBH0ng6djWFow4DX/7VPpJNIQwf3sIJ/WmBQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=htWFxmAzVXSy+XrcECcrAw2huJVA6Eh8sH0Ub1Cl5dbzvNyVCdzMBa7TNIfaG/D8e/S1tRegYrrkwaMHj+AUA7O+QMK0DUpQmP2vzToczuooV230rI6fbI7IhJRjJfApn8NiroddVN/+XqKsvkA58do3sFKDLLOIOPzTLubQyi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=nYGJuYFU; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="nYGJuYFU"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1744B1A9A;
	Tue, 28 Jul 2026 03:51:08 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7E83D3F66F;
	Tue, 28 Jul 2026 03:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785235872; bh=aoYVGfnSBH0ng6djWFow4DX/7VPpJNIQwf3sIJ/WmBQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nYGJuYFUyqJWwkSFtHnRVoNV4GDMyo2yP7jeOpVqExQuUG92X0f3XnGMpuxTeMCyr
	 V6wDOx0Zdk5ODt8z4VfEY/lJ5ZZwiAHX2yq/3CaILUn4VrnYsW4W8mV5aHkaR6UQOY
	 Z8LDlxMBoZr/eju+iozXirt3jsBndrUjp0uOFqKA=
Message-ID: <3e7ba95b-51e7-48e4-aea5-f86db1739ac2@arm.com>
Date: Tue, 28 Jul 2026 11:51:04 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] iommu: Add Broadcom BCM2712 IOMMU driver
To: Daniel Drake <dan@reactivated.net>, "Joerg Roedel (AMD)"
 <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, nick.hollinghurst@raspberrypi.com,
 Jason Gunthorpe <jgg@ziepe.ca>
References: <20260727-bcm2712-iommu-submit-v2-0-0247b5c03de8@reactivated.net>
 <20260727-bcm2712-iommu-submit-v2-4-0247b5c03de8@reactivated.net>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260727-bcm2712-iommu-submit-v2-4-0247b5c03de8@reactivated.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/07/2026 9:43 pm, Daniel Drake wrote:
[...]
> + * Each BCM2712 IOMMU has multiple devices hardwired into it, whose
> + * DMA transactions all route through the IOMMU. There is no stream ID tagging
> + * or any other kind of segmentation to differentiate between requests from
> + * different devices. It is also not possible to toggle a specific device
> + * between iommu-mapped and bypass modes.

Hmm, so it's kind of like an IOMMU and a GART had a baby?

> + * With these limitations in mind, we configure the hardware to operate over two
> + * windows:
> + *  1. The lower part of the address space operates in identity/bypass mode.
> + *     This enables non-IOMMU-consumer devices to work as normal (including
> + *     devices set up by the firmware, devices that don't require large DMA
> + *     allocations, devices that handle scatter-gather natively, etc.)
> + *  2. A 4GB translation aperture is defined at a fixed, high address, beyond
> + *     regular RAM and MMIO space. Mappings are operated in this aperture for
> + *     devices that wish to take advantage of the IOMMU.
[...]
> +static struct iommu_domain *bcm2712_iommu_domain_alloc(struct device *dev)
> +{
> +	struct bcm2712_iommu *mmu = dev_iommu_priv_get(dev);
> +	struct bcm2712_iommu_domain *domain;
> +	struct pt_iommu_bcm2712_cfg cfg;
> +	int ret;
> +
> +	domain = kzalloc_obj(*domain);
> +	if (!domain)
> +		return NULL;
> +
> +	domain->mmu = mmu;
> +	domain->pt.iommu.iommu_device = mmu->dev;
> +	memset(&cfg, 0, sizeof(cfg));
> +	cfg.common.features = BIT(PT_FEAT_DMA_INCOHERENT);
> +
> +	/* Bigpage and superpage sizes are typically 64K and 1M, but may vary */
> +	if (mmu->bigpage_size)
> +		cfg.bigpage_lg2 = ilog2(mmu->bigpage_size);
> +	if (mmu->superpage_size)
> +		cfg.superpage_lg2 = ilog2(mmu->superpage_size);
> +
> +	/* 2-level format: 10-bit L1 + 10-bit L2 + 12-bit page offset */
> +	cfg.common.hw_max_vasz_lg2 =
> +		(2 * PTES_PER_IOPG_SHIFT) + IOMMU_PAGE_SHIFT;
> +
> +	/* PTEs encode a 28-bit output address PFN */
> +	cfg.common.hw_max_oasz_lg2 = 28 + IOMMU_PAGE_SHIFT;
> +
> +	ret = pt_iommu_bcm2712_init(&domain->pt, &cfg, GFP_KERNEL);
> +	if (ret)
> +		goto err;
> +
> +	/* Set up a default (error) page used to catch illegal reads/writes */
> +	domain->default_page = iommu_alloc_pages_sz(GFP_KERNEL, PAGE_SIZE);
> +	if (!domain->default_page)
> +		goto err;
> +
> +	domain->base.geometry.aperture_start = BCM2712_APERTURE_BASE;
> +	domain->base.geometry.aperture_end = BCM2712_APERTURE_END - 1;
> +	domain->base.geometry.force_aperture = true;

...and thus (as things stand) this is a lie :(

If you want to operate like an IOMMU, then the translation aperture and 
the bypass window should really be mutually-exclusive; conversely if you 
want to operate like a GART then you can't really pretend to support 
blocking domains which will also disrupt devices outside the IOMMU 
group. Trying to compromise leaves you with rather a 
worst-of-both-worlds setup as-is...

Thanks,
Robin.

> +	domain->base.ops = &bcm2712_paging_domain_ops;
> +	return &domain->base;
> +
> +err:
> +	bcm2712_iommu_domain_free(&domain->base);
> +	return NULL;
> +}
