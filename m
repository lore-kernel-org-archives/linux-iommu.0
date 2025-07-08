Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902552E5413
	for <iommu@lists.linux.dev>; Tue,  8 Jul 2025 17:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751995038; cv=none; b=sjge0O+jCDGGf+rKBVTDuMX+VdVekDB2EK3ZUMIfOF13rDfyeu9etOwWMXnhikxLdhsOM758yac8ITvw4D6TJTwk7TYjJflTZ5Vn0DYi7A1Pd530CqBa+jvsL77S0nIBOhYID0tFu539/rcEgmxp1cpHf3oxvYZry7XOQvY9w6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751995038; c=relaxed/simple;
	bh=Bmuh/sDssPO4umf8W/0oiXhmbwT9roC/mlhT4Wqy7YU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gTmyyjVSzQdNdWMQfOyMkirLGTKgrpmIgLU2ntlrL3CZTemGHFwmg7Pbh9u4bHxUDzoU460SeXWYQNNRXUEQ3lZ5IeMzvFJxOXOekSEbEn2L9Ihlmb0Uwa0X2nJoHWsEKa/Y/8mphJuAdfvK57+Buj/xgsbJcxe0sFlEYFVUxfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DCC69153B;
	Tue,  8 Jul 2025 10:17:02 -0700 (PDT)
Received: from [10.1.196.50] (e121345-lin.cambridge.arm.com [10.1.196.50])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3F5883F694;
	Tue,  8 Jul 2025 10:17:13 -0700 (PDT)
Message-ID: <ceedcc51-7a4e-4da0-bdcd-429e7c212d19@arm.com>
Date: Tue, 8 Jul 2025 18:17:10 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] of: reserved_mem: Restructure call site for
 dma_contiguous_early_fixup()
To: Oreoluwa Babatunde <oreoluwa.babatunde@oss.qualcomm.com>,
 robh@kernel.org, m.szyprowski@samsung.com
Cc: saravanak@google.com, quic_obabatun@quicinc.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, william.zhang@broadcom.com, kernel@oss.qualcomm.com,
 will@kernel.org, djakov@kernel.org
References: <20250708165627.845295-1-oreoluwa.babatunde@oss.qualcomm.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20250708165627.845295-1-oreoluwa.babatunde@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08/07/2025 5:56 pm, Oreoluwa Babatunde wrote:
> Restructure the call site for dma_contiguous_early_fixup() to
> where the reserved_mem nodes are being parsed from the DT so that
> dma_mmu_remap[] is populated before dma_contiguous_remap() is called.
> 
> Fixes: 8a6e02d0c00e ("of: reserved_mem: Restructure how the reserved memory regions are processed")
> Signed-off-by: Oreoluwa Babatunde <oreoluwa.babatunde@oss.qualcomm.com>
> ---
>   drivers/of/of_reserved_mem.c | 14 +++++++++++---
>   kernel/dma/contiguous.c      |  2 --
>   2 files changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
> index 77016c0cc296..132d2c66cafc 100644
> --- a/drivers/of/of_reserved_mem.c
> +++ b/drivers/of/of_reserved_mem.c
> @@ -25,6 +25,7 @@
>   #include <linux/memblock.h>
>   #include <linux/kmemleak.h>
>   #include <linux/cma.h>
> +#include <linux/dma-map-ops.h>
>   
>   #include "of_private.h"
>   
> @@ -175,13 +176,17 @@ static int __init __reserved_mem_reserve_reg(unsigned long node,
>   		base = dt_mem_next_cell(dt_root_addr_cells, &prop);
>   		size = dt_mem_next_cell(dt_root_size_cells, &prop);
>   
> -		if (size &&
> -		    early_init_dt_reserve_memory(base, size, nomap) == 0)
> +		if (size && early_init_dt_reserve_memory(base, size, nomap) == 0) {
> +			/* Architecture specific contiguous memory fixup. */
> +			if (of_flat_dt_is_compatible(node, "shared-dma-pool"))

Surely this is now going to call the fixup for *all* "shared-dma-pool" 
reservations, rather than just the ones which are specifically CMA 
regions? That seems potentially bad in a number of ways.

Thanks,
Robin.

> +				dma_contiguous_early_fixup(base, size);
> +
>   			pr_debug("Reserved memory: reserved region for node '%s': base %pa, size %lu MiB\n",
>   				uname, &base, (unsigned long)(size / SZ_1M));
> -		else
> +		} else {
>   			pr_err("Reserved memory: failed to reserve memory for node '%s': base %pa, size %lu MiB\n",
>   			       uname, &base, (unsigned long)(size / SZ_1M));
> +		}
>   
>   		len -= t_len;
>   	}
> @@ -472,6 +477,9 @@ static int __init __reserved_mem_alloc_size(unsigned long node, const char *unam
>   		       uname, (unsigned long)(size / SZ_1M));
>   		return -ENOMEM;
>   	}
> +	/* Architecture specific contiguous memory fixup. */
> +	if (of_flat_dt_is_compatible(node, "shared-dma-pool"))
> +		dma_contiguous_early_fixup(base, size);
>   
>   	/* Save region in the reserved_mem array */
>   	fdt_reserved_mem_save_node(node, uname, base, size);
> diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
> index 8df0dfaaca18..9e5d63efe7c5 100644
> --- a/kernel/dma/contiguous.c
> +++ b/kernel/dma/contiguous.c
> @@ -480,8 +480,6 @@ static int __init rmem_cma_setup(struct reserved_mem *rmem)
>   		pr_err("Reserved memory: unable to setup CMA region\n");
>   		return err;
>   	}
> -	/* Architecture specific contiguous memory fixup. */
> -	dma_contiguous_early_fixup(rmem->base, rmem->size);
>   
>   	if (default_cma)
>   		dma_contiguous_default_area = cma;
