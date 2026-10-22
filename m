Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792674990;
	b=vQUXY2bdZJlz0w41lQR/NcKhvm2nxEFW7rJ4DtdY7ScmoP4BgxLkW83uSY3OB9UHS0jp
	 fOI+HDRtSlpo3YPXm/c/BDJd5wburZiT8Alxe5FND8Fsj+N4mmtaXa4Q/zDpE+7COf+jM
	 LgE4tmyZbyUZMRjhdFBbOXU8aFkCAhme0LwkLgQOH9lEQBC3gXB7hJoMAdxwrggcPMwj5
	 eytAYDUp5nI6exrZSgcBxn0N4oNBRv7Enbh1q2zlRnW1TvTbwP3VXD/MRKSVE4L9WqoVk
	 1kOvlAb0F1xC8oI6KN3cjFoTBYgEZXJziu4f3zEeeIiPs3H6F+4grgZuAHdnaab/DUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792674990;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=95gIZ/rOhUqAkfRUZlhwY8It1fpNlrmqRnyk+6vFBTo=;
	b=kQLVmCLWUWyRw3rfWFH3m67U1WhkNcofOGwF85aSUAe5cL5OBNfQyN3k3pAYq0F3YyXU
	 YmNrWmpzUTUYBa0Yq/yv3qTVVQ9/tyVn7Y4F/4Wzjb9HjUe/pgED12MU0jov4K5YC5XCs
	 RSFgBirina+ygK6D7dt2YPs6aOYQcx5RgLbgJx73zlQ8RysTnOJPB3qPTBfgiodJHL02y
	 caZ5Z4+tU3yPZ9MVxEClpQDb1N1uA8tRCEAJeUr1xQK/VYqlKVUvlLw3p1DkwM4ODHflh
	 +ygvU2ytHqc/5yfkzSVjeHCo5lanpjiEC3Db/ZoQUtp4ry+n4RFt28WdviYgHn6rviQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Po2Gv+pN;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67268606A325
	for <iommu@lists.linux.dev>; Thu, 22 Oct 2026 13:16:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67268606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Po2Gv+pN
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B2C01476;
	Thu, 22 Oct 2026 06:16:25 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D9A693F673;
	Thu, 22 Oct 2026 06:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1792674988; bh=VtjlyhfnDPej66ib6QAEpVj/N8t0KLq/+awBY3pvJWI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Po2Gv+pN5qUlVoTfmfm6+EiT9jkBnsjCdYxUB1uttjzopZ2ujfpPncmF8NG5AUHA/
	 ntV3DmM0O4FOtoaFsSCaE9vCLLGuGeVUWR3sgYLD5Vfg3x3t/YZ8m3si9+Ow2OnH08
	 xitDAI80+tuIJ7Q2ABl3pIfc3FZeSehoHXU+QxHE=
Message-ID: <6406c7b1-5e37-4c22-83c2-089c35ef54bf@arm.com>
Date: Thu, 22 Oct 2026 14:16:05 +0100
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/11] ARM: dma-mapping: Implement and expose DMA setup
 functions
To: Mikko Perttunen <mperttunen@nvidia.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Russell King <linux@armlinux.org.uk>, Heiko Stuebner <heiko@sntech.de>,
 Thierry Reding <thierry.reding@kernel.org>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Hunter <jonathanh@nvidia.com>, Krishna Reddy <vdumpa@nvidia.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Peter Griffin <peter.griffin@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, Chen-Yu Tsai <wens@kernel.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Yong Wu <yong.wu@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org
References: <20261016-b4-arm32-iommu-dma-cookie-v2-0-b06842a01938@nvidia.com>
 <20261016-b4-arm32-iommu-dma-cookie-v2-4-b06842a01938@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20261016-b4-arm32-iommu-dma-cookie-v2-4-b06842a01938@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/10/2026 7:46 am, Mikko Perttunen wrote:
> ARM DMA domains are currently allocated by the ARM DMA code, with struct
> dma_iommu_mapping owning the domain and the IOVA bookkeeping. To allow
> the IOMMU core to own DMA domains as is the case with other
> architectures, we have to allow that code to allocate the domain and get
> the cookie from the ARM DMA code.
> 
> Implement ARM versions of iommu_get/put_dma_cookie that create a struct
> dma_iommu_mapping that doesn't have its own domain, as well as
> iommu_setup/teardown_dma_ops that set the device's archdata.mapping,
> allowing ARM DMA ops to seamlessly work on these devices.
> 
> The code is protected by CONFIG_ARM_DMA_USE_IOMMU and mutually exclusive
> with the same-named functions in the dma-iommu code; and not reachable
> yet.
> 
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
>   arch/arm/include/asm/dma-iommu.h |  17 ++++++
>   arch/arm/mm/dma-mapping.c        | 118 ++++++++++++++++++++++++++++++++++-----
>   drivers/iommu/dma-iommu.h        |  50 +++++++++++------
>   3 files changed, 154 insertions(+), 31 deletions(-)
> 
> diff --git a/arch/arm/include/asm/dma-iommu.h b/arch/arm/include/asm/dma-iommu.h
> index 2ce4c5683e6d..85cf9b05faab 100644
> --- a/arch/arm/include/asm/dma-iommu.h
> +++ b/arch/arm/include/asm/dma-iommu.h
> @@ -19,6 +19,14 @@ struct dma_iommu_mapping {
>   	size_t			bits;		/* per bitmap */
>   	dma_addr_t		base;
>   
> +	/*
> +	 * Set for mappings created by arm_iommu_create_mapping(), where
> +	 * @domain is owned by the mapping.
> +	 * Clear for mappings that are a cookie of a domain owned by the IOMMU
> +	 * core.
> +	 */
> +	bool			owns_domain;

Do we strictly need this, or could we in fact already tell the 
difference via iommu_is_dma_domain()? (Since ARM-API-owned domains via 
iommu_paging_domain_alloc() will be IOMMU_DOMAIN_UNMANAGED)

> +
>   	spinlock_t		lock;
>   	struct kref		kref;
>   };
> @@ -32,5 +40,14 @@ int arm_iommu_attach_device(struct device *dev,
>   					struct dma_iommu_mapping *mapping);
>   void arm_iommu_detach_device(struct device *dev);
>   
> +#ifdef CONFIG_ARM_DMA_USE_IOMMU
> +struct iommu_domain;
> +
> +void iommu_setup_dma_ops(struct device *dev, struct iommu_domain *domain);
> +void iommu_teardown_dma_ops(struct device *dev);
> +int iommu_get_dma_cookie(struct iommu_domain *domain);
> +void iommu_put_dma_cookie(struct iommu_domain *domain);
> +#endif
> +
>   #endif /* __KERNEL__ */
>   #endif
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index 4284950a9246..f2d3e8ec3487 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -1531,6 +1531,79 @@ static void __arm_iommu_free_mapping(struct dma_iommu_mapping *mapping)
>   	kfree(mapping);
>   }
>   
> +static int __arm_iommu_init_cookie(struct iommu_domain *domain,
> +				   dma_addr_t base, u64 size)
> +{
> +	struct dma_iommu_mapping *mapping;
> +
> +	if (domain->cookie_type != IOMMU_COOKIE_NONE)
> +		return -EEXIST;
> +
> +	mapping = __arm_iommu_alloc_mapping(base, size);
> +	if (IS_ERR(mapping))
> +		return PTR_ERR(mapping);
> +
> +	mapping->domain = domain;
> +	domain->cookie_type = IOMMU_COOKIE_ARM_DMA;
> +	domain->arm_cookie = mapping;
> +
> +	return 0;
> +}
> +
> +/**
> + * iommu_get_dma_cookie - Set up a domain cookie for ARM IOMMU-based DMA API
> + * @domain: IOMMU_DOMAIN_DMA domain being configured
> + *
> + * Allocates IOVA bookkeeping for the domain based on the domain's specified
> + * geometry. The aperture can currently be at most 4GB in size, otherwise
> + * fails with -ERANGE.

Bit of a corner case, but I think that might technically break on 
stage-2-only arm-smmu implementations like MMU-400 where the default 
aperture will be 40 bits. It's probably better to explicitly cap our 
request to 4GB here to preserve the current behaviour.

> + */
> +int iommu_get_dma_cookie(struct iommu_domain *domain)
> +{
> +	dma_addr_t base = domain->geometry.aperture_start;
> +	u64 size;
> +
> +	if (base > domain->geometry.aperture_end)
> +		return -EINVAL;
> +
> +	size = (u64)domain->geometry.aperture_end - base + 1;
> +
> +	return __arm_iommu_init_cookie(domain, base, size);
> +}
> +
> +/**
> + * iommu_put_dma_cookie - Free domain cookie for ARM IOMMU-based DMA API
> + * @domain: the domain being freed
> + */
> +void iommu_put_dma_cookie(struct iommu_domain *domain)
> +{
> +	__arm_iommu_free_mapping(domain->arm_cookie);
> +}
> +
> +/**
> + * iommu_setup_dma_ops - Record a device's DMA API domain cookie
> + * @dev: the device
> + * @domain: the group's new default domain
> + *
> + * Records the cookie of @domain on @dev, or clears it if @domain is not a DMA
> + * API domain. The DMA ops themselves are per driver binding and are installed
> + * by arch_setup_dma_ops().
> + */
> +void iommu_setup_dma_ops(struct device *dev, struct iommu_domain *domain)
> +{
> +	to_dma_iommu_mapping(dev) = iommu_is_dma_domain(domain) ?
> +				    domain->arm_cookie : NULL;

It feels like we should actually set the dma_ops here for a real default 
domain. Sure it might make things a little more complex in the interim, 
but it'll be more logical when we come to remove the other path.

> +}
> +
> +/**
> + * iommu_teardown_dma_ops - Clear a device's DMA API domain cookie
> + * @dev: the device
> + */
> +void iommu_teardown_dma_ops(struct device *dev)
> +{
> +	to_dma_iommu_mapping(dev) = NULL;
> +}
> +
>   /**
>    * arm_iommu_create_mapping
>    * @dev: pointer to the client device (for IOMMU calls)
> @@ -1541,28 +1614,32 @@ static void __arm_iommu_free_mapping(struct dma_iommu_mapping *mapping)
>    * IO address ranges, which is required to perform memory allocation and
>    * mapping with IOMMU aware functions.
>    *
> + * Unlike a default domain set up by the IOMMU core, the returned mapping owns
> + * the domain it describes and releases it along with the last reference.
> + *
>    * The client device need to be attached to the mapping with
>    * arm_iommu_attach_device function.
>    */
>   struct dma_iommu_mapping *
>   arm_iommu_create_mapping(struct device *dev, dma_addr_t base, u64 size)
>   {
> -	struct dma_iommu_mapping *mapping;
> -
> -	mapping = __arm_iommu_alloc_mapping(base, size);
> -	if (IS_ERR(mapping))
> -		return mapping;
> +	struct iommu_domain *domain;
> +	int err;
>   
> -	mapping->domain = iommu_paging_domain_alloc(dev);
> -	if (IS_ERR(mapping->domain)) {
> -		int err = PTR_ERR(mapping->domain);
> +	domain = iommu_paging_domain_alloc(dev);
> +	if (IS_ERR(domain))
> +		return ERR_CAST(domain);
>   
> -		__arm_iommu_free_mapping(mapping);
> +	err = __arm_iommu_init_cookie(domain, base, size);
> +	if (err) {
> +		iommu_domain_free(domain);
>   		return ERR_PTR(err);
>   	}
>   
> -	kref_init(&mapping->kref);
> -	return mapping;
> +	domain->arm_cookie->owns_domain = true;
> +	kref_init(&domain->arm_cookie->kref);
> +
> +	return domain->arm_cookie;
>   }
>   EXPORT_SYMBOL_GPL(arm_iommu_create_mapping);
>   
> @@ -1571,8 +1648,8 @@ static void release_iommu_mapping(struct kref *kref)
>   	struct dma_iommu_mapping *mapping =
>   		container_of(kref, struct dma_iommu_mapping, kref);
>   
> +	/* Frees mapping too, via iommu_put_dma_cookie(). */
>   	iommu_domain_free(mapping->domain);
> -	__arm_iommu_free_mapping(mapping);
>   }
>   
>   static int extend_iommu_mapping(struct dma_iommu_mapping *mapping)
> @@ -1595,8 +1672,13 @@ static int extend_iommu_mapping(struct dma_iommu_mapping *mapping)
>   
>   void arm_iommu_release_mapping(struct dma_iommu_mapping *mapping)
>   {
> -	if (mapping)
> -		kref_put(&mapping->kref, release_iommu_mapping);
> +	if (!mapping)
> +		return;
> +
> +	if (WARN_ON(!mapping->owns_domain))
> +		return;
> +
> +	kref_put(&mapping->kref, release_iommu_mapping);
>   }
>   EXPORT_SYMBOL_GPL(arm_iommu_release_mapping);
>   
> @@ -1660,6 +1742,14 @@ void arm_iommu_detach_device(struct device *dev)
>   		return;
>   	}
>   
> +	/*
> +	 * This pairs with arm_iommu_attach_device() on a driver-owned mapping.
> +	 * A mapping which is merely the cookie of a core-owned default domain
> +	 * must not be torn down from here.
> +	 */
> +	if (WARN_ON(!mapping->owns_domain))

As mentioned, if we can't reasonably hide the proper default domains 
from external users of to_dma_iommu_mapping(), then I don't think we 
should warn here, just treat it as a quiet no-op - the reason for the 
"kick out the ARM domain" idiom is that it's in the way of attaching to 
a driver-owned domain (whether that be a bare iommu_domain or another 
ARM dma_iommu_mapping), but a real default domain is inherently out of 
the way already. That way we can freely convert the rest of the drivers 
to use default domains without impacting their users, then clean up the 
detach pattern from the client drivers separately afterwards.

Thanks,
Robin.

> +		return;
> +
>   	iommu_detach_device(mapping->domain, dev);
>   	kref_put(&mapping->kref, release_iommu_mapping);
>   	to_dma_iommu_mapping(dev) = NULL;
> diff --git a/drivers/iommu/dma-iommu.h b/drivers/iommu/dma-iommu.h
> index 349d6a57e5a0..71b23cb698c0 100644
> --- a/drivers/iommu/dma-iommu.h
> +++ b/drivers/iommu/dma-iommu.h
> @@ -7,25 +7,24 @@
>   
>   #include <linux/iommu.h>
>   
> -#ifdef CONFIG_IOMMU_DMA
> +/*
> + * Both dma-iommu.c and arch/arm/mm/dma-mapping.c implement functions to set up
> + * IOMMU_DOMAIN_DMA default domains. Only one provider can be compiled in at a
> + * time.
> + */
> +#if defined(CONFIG_ARM_DMA_USE_IOMMU)
> +
> +#include <asm/dma-iommu.h>
> +
> +#elif defined(CONFIG_IOMMU_DMA)
>   
>   void iommu_setup_dma_ops(struct device *dev, struct iommu_domain *domain);
>   void iommu_teardown_dma_ops(struct device *dev);
>   
>   int iommu_get_dma_cookie(struct iommu_domain *domain);
>   void iommu_put_dma_cookie(struct iommu_domain *domain);
> -void iommu_put_msi_cookie(struct iommu_domain *domain);
>   
> -int iommu_dma_init_fq(struct iommu_domain *domain);
> -
> -void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list);
> -
> -int iommu_dma_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
> -		     phys_addr_t msi_addr);
> -
> -extern bool iommu_dma_forcedac;
> -
> -#else /* CONFIG_IOMMU_DMA */
> +#else
>   
>   static inline void iommu_setup_dma_ops(struct device *dev,
>   				       struct iommu_domain *domain)
> @@ -36,11 +35,6 @@ static inline void iommu_teardown_dma_ops(struct device *dev)
>   {
>   }
>   
> -static inline int iommu_dma_init_fq(struct iommu_domain *domain)
> -{
> -	return -EINVAL;
> -}
> -
>   static inline int iommu_get_dma_cookie(struct iommu_domain *domain)
>   {
>   	return -ENODEV;
> @@ -50,6 +44,28 @@ static inline void iommu_put_dma_cookie(struct iommu_domain *domain)
>   {
>   }
>   
> +#endif
> +
> +#ifdef CONFIG_IOMMU_DMA
> +
> +void iommu_put_msi_cookie(struct iommu_domain *domain);
> +
> +int iommu_dma_init_fq(struct iommu_domain *domain);
> +
> +void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list);
> +
> +int iommu_dma_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
> +		     phys_addr_t msi_addr);
> +
> +extern bool iommu_dma_forcedac;
> +
> +#else /* CONFIG_IOMMU_DMA */
> +
> +static inline int iommu_dma_init_fq(struct iommu_domain *domain)
> +{
> +	return -EINVAL;
> +}
> +
>   static inline void iommu_put_msi_cookie(struct iommu_domain *domain)
>   {
>   }
> 

