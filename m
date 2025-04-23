Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8D51386DA
	for <iommu@lists.linux.dev>; Wed, 23 Apr 2025 17:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745427763; cv=none; b=Jn9bnsPRLnbo4KbZd0slHKWW77jHuBfWlvTD8kpCVhF/D4QKVSnyPkgkDp6YHFXD4Ny3EqzWg1X2LEV/vCgryt1lkwqQWrpSnQtLOTfQPR9rnQfFk2BZUZBpYmJ1oCLDzXp0fS4AqxeqYFJU0/3a/U1HqtvII92I8x8HrtNGFAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745427763; c=relaxed/simple;
	bh=jnhX8vAIa9TceWzwRkr/EyM2QB8Y09yqhl5U1I5KLTY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oPZ+5D5ad6iczuQdP39/ajbAoryGfPfqim0Its/f1STMdsJTIK3t3d5bNS8yOYPoii8irLpGNrFHjYONGSE83j0N2uIMfVVvQvTYjuKECr5hDS/p2FWp4woYqFKaE8rlftthwCYlEfhs5BtpreHMNt9Ht+fmFYDfRloIe0ARxW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E46921063;
	Wed, 23 Apr 2025 10:02:35 -0700 (PDT)
Received: from [10.57.74.63] (unknown [10.57.74.63])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 50AC23F66E;
	Wed, 23 Apr 2025 10:02:38 -0700 (PDT)
Message-ID: <4af7c59e-bb1b-4b9e-a61d-90d911df430b@arm.com>
Date: Wed, 23 Apr 2025 18:02:36 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [v2] iommu/io-pgtable-arm: dynamically allocate selftest
 device struct
To: Arnd Bergmann <arnd@kernel.org>, Will Deacon <will@kernel.org>,
 Joerg Roedel <joro@8bytes.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Mostafa Saleh <smostafa@google.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Lu Baolu <baolu.lu@linux.intel.com>,
 Rob Clark <robdclark@chromium.org>, Kunkun Jiang <jiangkunkun@huawei.com>,
 Ashish Mhetre <amhetre@nvidia.com>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250423164826.2931382-1-arnd@kernel.org>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20250423164826.2931382-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-04-23 5:48 pm, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> In general a 'struct device' is way too large to be put on the kernel
> stack. Apparently something just caused it to grow a slightly larger,
> which pushed the arm_lpae_do_selftests() function over the warning
> limit in some configurations:
> 
> drivers/iommu/io-pgtable-arm.c:1423:19: error: stack frame size (1032) exceeds limit (1024) in 'arm_lpae_do_selftests' [-Werror,-Wframe-larger-than]
>   1423 | static int __init arm_lpae_do_selftests(void)
>        |                   ^
> 
> Change the function to use a dynamically allocated faux_device
> instead of the on-stack device structure.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Fixes: ca25ec247aad ("iommu/io-pgtable-arm: Remove iommu_dev==NULL special case")
> Link: https://lore.kernel.org/all/ab75a444-22a1-47f5-b3c0-253660395b5a@arm.com/
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v2: use faux device instead of platform_device, as Robin suggested.
>      The faux device is more appropriate here since the is no actual physical
>      device, though on the other hand the v1 patch had the advantage of not
>      actually needing to register the device.
> ---
>   drivers/iommu/io-pgtable-arm.c | 13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> index 545229cf62d2..bbd42323c029 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -13,6 +13,7 @@
>   #include <linux/bitops.h>
>   #include <linux/io-pgtable.h>
>   #include <linux/kernel.h>
> +#include <linux/device/faux.h>
>   #include <linux/sizes.h>
>   #include <linux/slab.h>
>   #include <linux/types.h>
> @@ -1437,15 +1438,17 @@ static int __init arm_lpae_do_selftests(void)
>   	};
>   
>   	int i, j, k, pass = 0, fail = 0;
> -	struct device dev;
> +	struct faux_device *dev;
>   	struct io_pgtable_cfg cfg = {
>   		.tlb = &dummy_tlb_ops,
>   		.coherent_walk = true,
> -		.iommu_dev = &dev,
>   	};
>   
> -	/* __arm_lpae_alloc_pages() merely needs dev_to_node() to work */
> -	set_dev_node(&dev, NUMA_NO_NODE);
> +	dev = faux_device_create("io-pgtable-test", NULL, 0);
> +	if (!dev)
> +		return -ENOMEM;
> +
> +	cfg.iommu_dev = &dev->dev;
>   
>   	for (i = 0; i < ARRAY_SIZE(pgsize); ++i) {
>   		for (j = 0; j < ARRAY_SIZE(address_size); ++j) {
> @@ -1465,6 +1468,8 @@ static int __init arm_lpae_do_selftests(void)
>   	}
>   
>   	pr_info("selftest: completed with %d PASS %d FAIL\n", pass, fail);
> +	faux_device_destroy(dev);
> +
>   	return fail ? -EFAULT : 0;
>   }
>   subsys_initcall(arm_lpae_do_selftests);

