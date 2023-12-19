Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3B414F78
	for <iommu@lists.linux.dev>; Tue, 19 Dec 2023 11:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 91FF61FB;
	Tue, 19 Dec 2023 03:13:03 -0800 (PST)
Received: from [10.57.85.119] (unknown [10.57.85.119])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 22CD23F738;
	Tue, 19 Dec 2023 03:12:18 -0800 (PST)
Message-ID: <76e192f0-fd53-48a8-9f62-086fb1d8a55f@arm.com>
Date: Tue, 19 Dec 2023 11:12:16 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] iommu: Don't reserve 0-length IOVA region
Content-Language: en-GB
To: Ashish Mhetre <amhetre@nvidia.com>, joro@8bytes.org, will@kernel.org,
 treding@nvidia.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-tegra@vger.kernel.org
References: <20231205065656.9544-1-amhetre@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20231205065656.9544-1-amhetre@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023-12-05 6:56 am, Ashish Mhetre wrote:
> When the bootloader/firmware doesn't setup the framebuffers, their
> address and size are 0 in "iommu-addresses" property. If IOVA region is
> reserved with 0 length, then it ends up corrupting the IOVA rbtree with
> an entry which has pfn_hi < pfn_lo.
> If we intend to use display driver in kernel without framebuffer then
> it's causing the display IOMMU mappings to fail as entire valid IOVA
> space is reserved when address and length are passed as 0.
> An ideal solution would be firmware removing the "iommu-addresses"
> property and corresponding "memory-region" if display is not present.
> But the kernel should be able to handle this by checking for size of
> IOVA region and skipping the IOVA reservation if size is 0. Also, add
> a warning if firmware is requesting 0-length IOVA region reservation.

Acked-by: Robin Murphy <robin.murphy@arm.com>

> Fixes: a5bf3cfce8cb ("iommu: Implement of_iommu_get_resv_regions()")
> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
> ---
>   drivers/iommu/of_iommu.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> index 47302b637cc0..42cffb0ee5e2 100644
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -264,6 +264,10 @@ void of_iommu_get_resv_regions(struct device *dev, struct list_head *list)
>   					prot |= IOMMU_CACHE;
>   
>   				maps = of_translate_dma_region(np, maps, &iova, &length);
> +				if (length == 0) {
> +					dev_warn(dev, "Cannot reserve IOVA region of 0 size\n");
> +					continue;
> +				}
>   				type = iommu_resv_region_get_type(dev, &phys, iova, length);
>   
>   				region = iommu_alloc_resv_region(iova, length, prot, type,
