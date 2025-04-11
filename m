Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C0E1DD9AC
	for <iommu@lists.linux.dev>; Fri, 11 Apr 2025 13:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744377585; cv=none; b=p7rrVtsEmW29WlL5cDGSH8Y11TvkZLQAaUM1y30jmPau1KhfKKbFw1estVbZwLoweSOGwOu7sW4tpZAOrcXQh/1EflQNXu/1Lst4V5o/fkMU3p4H1RNItam5j8zB4rEA/z+NVZUMfFDULsEnNtMjHR/ZL5ETMOCjyu6muVbQDQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744377585; c=relaxed/simple;
	bh=qFvMGql/cEW31NPnv3bTQfWoCfSEwWIMfkNjqDnykKw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fVnby+vqiUbb/e4/7P+LoHDK9sdWqY39xR2OBakL1WtYjhhqPGPOpMFsKsPmpEY/Cp+cAuC9AIRQOKJCLZTmORr2BKXmgOW+ssQIQtJpVAgYvVmx76tRnzXgPLgiiAeHq2eEGHtLJt79J4vmZM8/Jg4U4N+ipG/2ossVhqFhMgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9865A106F;
	Fri, 11 Apr 2025 06:19:41 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 617BA3F59E;
	Fri, 11 Apr 2025 06:19:40 -0700 (PDT)
Message-ID: <60c980c1-16b6-460e-89a4-203e9f0cbf3b@arm.com>
Date: Fri, 11 Apr 2025 14:19:38 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/io-pgtable-arm: dynamically allocate selftest
 device struct
To: Arnd Bergmann <arnd@kernel.org>, Will Deacon <will@kernel.org>,
 Joerg Roedel <joro@8bytes.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Mostafa Saleh <smostafa@google.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
 Rob Clark <robdclark@chromium.org>, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250411125423.1411061-1-arnd@kernel.org>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20250411125423.1411061-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/04/2025 1:54 pm, Arnd Bergmann wrote:
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
> Change the function to use a dynamically allocated platform_device
> instead of the on-stack device structure. The device is not actually
> registered with the system, but is initialized enough to be used here.
> 
> Fixes: ca25ec247aad ("iommu/io-pgtable-arm: Remove iommu_dev==NULL special case")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   drivers/iommu/io-pgtable-arm.c | 13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> index 7632c80edea6..9f3bf0b5e8da 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -13,6 +13,7 @@
>   #include <linux/bitops.h>
>   #include <linux/io-pgtable.h>
>   #include <linux/kernel.h>
> +#include <linux/platform_device.h>
>   #include <linux/sizes.h>
>   #include <linux/slab.h>
>   #include <linux/types.h>
> @@ -1433,15 +1434,17 @@ static int __init arm_lpae_do_selftests(void)
>   	};
>   
>   	int i, j, k, pass = 0, fail = 0;
> -	struct device dev;

Could we not simply make this static? Per the comment it's only here to 
serve a NUMA node lookup buried deep in the pagetable allocator (TBH my 
first thought was to just put an int on the stack and contrive a pointer 
as the inverse of dev_to_node(), but I decided that would probably be 
too contentious...)

> +	struct platform_device *pdev;
>   	struct io_pgtable_cfg cfg = {
>   		.tlb = &dummy_tlb_ops,
>   		.coherent_walk = true,
> -		.iommu_dev = &dev,
>   	};
>   
> -	/* __arm_lpae_alloc_pages() merely needs dev_to_node() to work */
> -	set_dev_node(&dev, NUMA_NO_NODE);
> +	pdev = platform_device_alloc("io-pgtable-test", 0);

Otherwise, this would seem to be another perfect case for the new 
faux_device.

Thanks,
Robin.

> +	if (!pdev)
> +		return -ENOMEM;
> +
> +	cfg.iommu_dev = &pdev->dev;
>   
>   	for (i = 0; i < ARRAY_SIZE(pgsize); ++i) {
>   		for (j = 0; j < ARRAY_SIZE(address_size); ++j) {
> @@ -1461,6 +1464,8 @@ static int __init arm_lpae_do_selftests(void)
>   	}
>   
>   	pr_info("selftest: completed with %d PASS %d FAIL\n", pass, fail);
> +	platform_device_put(pdev);
> +
>   	return fail ? -EFAULT : 0;
>   }
>   subsys_initcall(arm_lpae_do_selftests);
