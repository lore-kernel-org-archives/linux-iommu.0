Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371118BF0;
	Mon, 28 Nov 2022 14:22:04 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F27D8D6E;
	Mon, 28 Nov 2022 06:22:09 -0800 (PST)
Received: from [10.57.71.118] (unknown [10.57.71.118])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9C4FC3F67D;
	Mon, 28 Nov 2022 06:22:01 -0800 (PST)
Message-ID: <a4f7157f-bd1d-ed7e-161f-e39c8c940a02@arm.com>
Date: Mon, 28 Nov 2022 14:21:56 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] iommu/sun50i: Remove IOMMU_DOMAIN_IDENTITY
Content-Language: en-GB
To: Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev,
 Maxime Ripard <maxime@cerno.tech>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Joerg Roedel <joro@8bytes.org>,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@csie.org>,
 Will Deacon <will@kernel.org>
Cc: Joerg Roedel <jroedel@suse.de>, Andre Przywara <andre.przywara@arm.com>
References: <0-v1-97f0adf27b5e+1f0-s50_identity_jgg@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <0-v1-97f0adf27b5e+1f0-s50_identity_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2022-11-28 14:06, Jason Gunthorpe wrote:
> This driver treats IOMMU_DOMAIN_IDENTITY the same as UNMANAGED, which
> cannot possibly be correct.
> 
> UNMANAGED domains are required to start out blocking all DMAs. This seems
> to be what this driver does as it allocates a first level 'dt' for the IO
> page table that is 0 filled.
> 
> Thus UNMANAGED looks like a working IO page table, and so IDENTITY must be
> a mistake. Remove it.

Ah yes, this did once catch my eye ages ago and Andre confirmed that 
real hardware fell over with "iommu.passthrough=1", but it seems we both 
forgot about it again before a patch got written. Thanks for taking the 
time!

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Fixes: 4100b8c229b3 ("iommu: Add Allwinner H6 IOMMU driver")
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>   drivers/iommu/sun50i-iommu.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
> index cd9b74ee24def1..0843418434ff3a 100644
> --- a/drivers/iommu/sun50i-iommu.c
> +++ b/drivers/iommu/sun50i-iommu.c
> @@ -601,7 +601,6 @@ static struct iommu_domain *sun50i_iommu_domain_alloc(unsigned type)
>   	struct sun50i_iommu_domain *sun50i_domain;
>   
>   	if (type != IOMMU_DOMAIN_DMA &&
> -	    type != IOMMU_DOMAIN_IDENTITY &&
>   	    type != IOMMU_DOMAIN_UNMANAGED)
>   		return NULL;
>   
> 
> base-commit: 328827239b9ce3a95b5c0d33e8875651580de053
