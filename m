Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D8263C3
	for <iommu@lists.linux.dev>; Thu,  7 Sep 2023 12:57:55 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC9441480;
	Thu,  7 Sep 2023 05:58:26 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2ECDC3F7B4;
	Thu,  7 Sep 2023 05:57:48 -0700 (PDT)
Message-ID: <8c3fe8ce-4716-73f0-fb8a-ee982f212371@arm.com>
Date: Thu, 7 Sep 2023 13:57:42 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3] cma: check for memory region overlapping
Content-Language: en-GB
To: Binglei Wang <l3b2w1@gmail.com>, hch@lst.de, m.szyprowski@samsung.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20230726142823.6356-1-l3b2w1@gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230726142823.6356-1-l3b2w1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/07/2023 3:28 pm, Binglei Wang wrote:
> From: Binglei Wang <l3b2w1@gmail.com>
> 
> In the process of parsing the DTS, checks
> whether the memory region specified by the DTS CMA node area
> overlaps with the kernel text memory space reserved by memblock
> before calling early_init_fdt_scan_reserved_mem.

This description bears no relation to what the code actually does. 
rmem_cma_setup() happens well after parsing the DTS, as it is that 
initial parsing process in fdt_scan_reserved_mem() which *makes* the 
memblock reservations in the first place. Thus, as the revert patch 
demonstrates, by the time we get here to start *using* the reserved 
region via fdt_init_reserved_mem(), it is always guaranteed to overlap a 
reserved region because it trivially overlaps with itself.

Furthermore, even if the bootloader does stupidly load a non-relocatable 
kernel into memory that it's described as reserved, the kernel text 
pages should not be available for CMA to allocate from - and if they 
were, that would be a far more fundamental bug elsewhere - so what is 
the exact problem you're trying to solve here?

Thanks,
Robin.

> Maybe it's better to have some warning prompts printed.
> 
> Signed-off-by: Binglei Wang <l3b2w1@gmail.com>
> ---
> 
> Notes:
>      v3: fix compile error.
>      v2: delete the logic code for handling return -EBUSY.
>      v1: return -EBUSY when detect overlapping and handle the return case.
> 
>   kernel/dma/contiguous.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
> index 6ea80ae42..dc6d2af1e 100644
> --- a/kernel/dma/contiguous.c
> +++ b/kernel/dma/contiguous.c
> @@ -410,6 +410,11 @@ static int __init rmem_cma_setup(struct reserved_mem *rmem)
>   		return -EBUSY;
>   	}
>   
> +	if (memblock_is_region_reserved(rmem->base, rmem->size)) {
> +		pr_info("Reserved memory: overlap with other memblock reserved region\n");
> +		return -EBUSY;
> +	}
> +
>   	if (!of_get_flat_dt_prop(node, "reusable", NULL) ||
>   	    of_get_flat_dt_prop(node, "no-map", NULL))
>   		return -EINVAL;
