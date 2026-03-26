Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0363C9EE7
	for <iommu@lists.linux.dev>; Thu, 26 Mar 2026 10:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774521405; cv=none; b=MvxLQeRh94kzOfYhTtdtMwwzZJpeprSw+shy0ATOIFijw/oIxCwvjaAEJy6T9ciVd6TzQYwoNqVem7NQvtIkbu7/0Ayu6KjXfRYq7Iy/pXhJouzLxLBjM7Yufb147SnzqwqKof17GDvy8vPOr3GrbpgNQRbnZ5Lrioo/Ej+GwxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774521405; c=relaxed/simple;
	bh=4kDuPJzBip97WEhmoSD0fv7UFM5vNLsLpPJFhY2uSFw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AeBYEQTGawp9xOO8iLXbZBnQRbAV1v0G4yq0IsYQVEbU9VUT03J8jfC4A4Uk+hTGvfflavfAXbYKx70HA7sdjTfU1nYAnVpebGC8oVmiVwjRwBqGv38Sy8zjW6xFo4tqHckdlmcITgRLl2azSD1DOczCcw74P2NkBZl38yigohM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=JXOAbSW6; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="JXOAbSW6"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 961601AED;
	Thu, 26 Mar 2026 03:36:35 -0700 (PDT)
Received: from [10.57.76.165] (unknown [10.57.76.165])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6D6893FB90;
	Thu, 26 Mar 2026 03:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1774521401; bh=4kDuPJzBip97WEhmoSD0fv7UFM5vNLsLpPJFhY2uSFw=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=JXOAbSW6KheXGF70FaoVMwo5yE4O5itS4kNM6FyWpqDbVUoEaxIRggO1UNQYWUc4Q
	 89ogD9FuUknJF3VvSZs1m7UmjOyCyTz0G9dRMojH1EUN4tytkbWwsUtPBM9wENnipL
	 sz0wK5jCuLlA4WrpDAnK82nGgRNCKLiC8gob8qOs=
Message-ID: <ee12aa71-b5ea-4364-be36-5d902ef035f2@arm.com>
Date: Thu, 26 Mar 2026 10:36:32 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/amd: Default to passthrough mode for improved
 performance
To: lirongqing <lirongqing@baidu.com>, Joerg Roedel <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260326093801.2213-1-lirongqing@baidu.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260326093801.2213-1-lirongqing@baidu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-03-26 9:38 am, lirongqing wrote:
> From: Li RongQing <lirongqing@baidu.com>
> 
> On x86 platforms, AMD IOMMU is typically enabled by default. When the
> kernel is compiled with CONFIG_IOMMU_DEFAULT_DMA_LAZY, the IOMMU
> operates in translated mode with deferred TLB flushing. While this
> provides a security layer, it introduces measurable performance
> overhead compared to Intel systems where the IOMMU often defaults
> to a disabled state.
> 
> To optimize out-of-the-box performance for AMD users, shift the
> default to passthrough mode when the following conditions are met:
> 1. No explicit IOMMU mode was requested via the command line.
> 2. The kernel was configured to use 'lazy' DMA remapping by default.
> 3. Memory encryption (SME/SEV) is not active, as these features
>     require translation for security.
> 
> This change allows standard DMA operations to bypass remapping
> overhead while maintaining the ability for users to explicitly
> enable translation if required.
> 
> To support this, export iommu_dma_is_user_configured() from the
> IOMMU core to allow vendor drivers to check if the DMA API
> configuration was overridden by the user.

Frankly, no. CONFIG_IOMMU_DEFAULT_PASSTHROUGH already exists for users 
who want that behaviour. IF you want an equivalent of 
CONFIG_INTEL_IOMMU_DEFAULT_ON which prevents the IOMMU being used at all 
then implement that (however I imagine a lot of VFIO users would be 
unhappy about changing the default of that at this point). You can't 
just completely break CONFIG_IOMMU_DEFAULT_DMA_LAZY for all the users 
who do want its particular behaviour.

Note that "lazy" mode does still represent nearly all of the 
security/memory safety functionality offered by the IOMMU, so it does 
have significant value - strict mode only adds protection for 
use-after-free of memory which _was_ already a legitimate DMA buffer for 
the given device at one point. A better title for this patch would be 
"Silently make AMD systems less secure unless users go out of their way 
to add command-line arguments to work around this change"...

There may well also still be some performance difference between the 
IOMMU being enabled in passthrough, and being truly disabled - I seem to 
recall the Intel GPU folks saying that was significant enough to care 
about at least on some older Intel systems.

Thansk,
Robin.

> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
>   drivers/iommu/amd/init.c | 9 +++++++++
>   drivers/iommu/iommu.c    | 6 ++++++
>   include/linux/iommu.h    | 1 +
>   3 files changed, 16 insertions(+)
> 
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index f3fd7f3..e89a5ce 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -3619,6 +3619,15 @@ void __init amd_iommu_detect(void)
>   	amd_iommu_detected = true;
>   	iommu_detected = 1;
>   	x86_init.iommu.iommu_init = amd_iommu_init;
> +
> +	if (!iommu_dma_is_user_configured()) {
> +		if (!cc_platform_has(CC_ATTR_MEM_ENCRYPT) &&
> +				IS_ENABLED(CONFIG_IOMMU_DEFAULT_DMA_LAZY)) {
> +			pr_info("Defaulting to Passthrough mode for performance\n");
> +			iommu_set_default_passthrough(false);
> +		}
> +	}
> +
>   	return;
>   
>   disable_snp:
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 50718ab..a950dbb 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -4091,3 +4091,9 @@ int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr)
>   	return ret;
>   }
>   #endif /* CONFIG_IRQ_MSI_IOMMU */
> +
> +bool iommu_dma_is_user_configured(void)
> +{
> +	return !!(iommu_cmd_line & IOMMU_CMD_LINE_DMA_API);
> +}
> +EXPORT_SYMBOL_GPL(iommu_dma_is_user_configured);
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 54b8b48..c3ff8a9 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -967,6 +967,7 @@ int iommu_set_pgtable_quirks(struct iommu_domain *domain,
>   		unsigned long quirks);
>   
>   void iommu_set_dma_strict(void);
> +bool iommu_dma_is_user_configured(void);
>   
>   extern int report_iommu_fault(struct iommu_domain *domain, struct device *dev,
>   			      unsigned long iova, int flags);

