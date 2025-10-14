Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C912C311C1E
	for <iommu@lists.linux.dev>; Tue, 14 Oct 2025 13:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760449442; cv=none; b=IuadqoCVnn7FWOC803D1KaiqOfb76n5u+y0b9SpRCHGtP0BlQbD8XoUCY4QM0fk+TGt1aPTJrLO+8/mTDBv79dSz4R6kQWagznHNHzdgXVVGJEUr2W7qPv8RaJ4ODauGn2Nf9KNycp+gsMmOB9NHArK7ASYB4JDaSPRDHtA2+VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760449442; c=relaxed/simple;
	bh=NL5gMjzIm0QbUfN+rnFWw63P7rg5EKBSFSryLFbyvDs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qQtac4C8cn1c0Mn6jFqbmlLgQm6/rX2nHyA0Pr+B+E9b8if/vAEH3S/wt0czXAoI5EAHiBPOmEkpE+JDDR80gXQA5QTKoqhTYh+1NcVGwAK/RuTYnG4kF7KhZ4+uwcbRmS0qXBkBr2YPAEYxu6p10CiyuqnXT8Kx9zXjYmIsbC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2E7DB1A9A;
	Tue, 14 Oct 2025 06:43:51 -0700 (PDT)
Received: from [10.57.7.84] (unknown [10.57.7.84])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EE97E3F66E;
	Tue, 14 Oct 2025 06:43:56 -0700 (PDT)
Message-ID: <86ca3918-4992-41a2-894f-f1fd8ce4121f@arm.com>
Date: Tue, 14 Oct 2025 14:43:53 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/4] iommu/io-pgtable-arm-selftests: Use KUnit
To: Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: will@kernel.org, joro@8bytes.org, jgg@ziepe.ca, praan@google.com,
 Jason Gunthorpe <jgg@nvidia.com>
References: <20250929155001.3287719-1-smostafa@google.com>
 <20250929155001.3287719-5-smostafa@google.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20250929155001.3287719-5-smostafa@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-09-29 4:49 pm, Mostafa Saleh wrote:
> Integrate the selftests as part of kunit.
> 
> Now instead of the test only being run at boot, it can run:
> 
> - With CONFIG_IOMMU_IO_PGTABLE_LPAE_KUNIT_TEST=y
>    It will automatically run at boot as before.
> 
> - Otherwise with CONFIG_IOMMU_IO_PGTABLE_KUNIT_TEST=m:
>    1) on module load:
>       Once the module load the self test will run
>       # modprobe io-pgtable-arm-selftests
> 
>    2) debugfs
>       With CONFIG_KUNIT_DEBUGFS=y You can run the test with
>       # echo 1 > /sys/kernel/debug/kunit/io-pgtable-arm-test/run
> 
>    3) Using kunit.py
>       You can also use the helper script which uses Qemu in the background
> 
>       # ./tools/testing/kunit/kunit.py run --build_dir build_kunit_arm64 --arch arm64 \
>         --make_options LLVM=1 --kunitconfig ./kunit/kunitconfig
>        [18:01:09] ============= io-pgtable-arm-test (1 subtest) ==============
>        [18:01:09] [PASSED] arm_lpae_do_selftests
>        [18:01:09] =============== [PASSED] io-pgtable-arm-test ===============
>        [18:01:09] ============================================================
> 
> Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>   drivers/iommu/Kconfig                    | 11 ++--
>   drivers/iommu/Makefile                   |  2 +-
>   drivers/iommu/io-pgtable-arm-selftests.c | 82 +++++++++++++-----------
>   3 files changed, 51 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index 553522ef3ca9..d50685433347 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -40,12 +40,13 @@ config IOMMU_IO_PGTABLE_LPAE
>   	  sizes at both stage-1 and stage-2, as well as address spaces
>   	  up to 48-bits in size.
>   
> -config IOMMU_IO_PGTABLE_LPAE_SELFTEST
> -	tristate "LPAE selftests"
> -	depends on IOMMU_IO_PGTABLE_LPAE
> +config IOMMU_IO_PGTABLE_LPAE_KUNIT_TEST
> +	tristate "KUnit tests for LPAE"
> +	depends on IOMMU_IO_PGTABLE_LPAE && KUNIT
> +	default KUNIT_ALL_TESTS
>   	help
> -	  Enable self-tests for LPAE page table allocator. This performs
> -	  a series of page-table consistency checks during boot.
> +	  Enable kunit tests for LPAE page table allocator. This performs
> +	  a series of page-table consistency checks.
>   
>   	  If unsure, say N here.
>   
> diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
> index 5250a2eea13f..ac3851570303 100644
> --- a/drivers/iommu/Makefile
> +++ b/drivers/iommu/Makefile
> @@ -12,7 +12,7 @@ obj-$(CONFIG_IOMMU_DMA) += dma-iommu.o
>   obj-$(CONFIG_IOMMU_IO_PGTABLE) += io-pgtable.o
>   obj-$(CONFIG_IOMMU_IO_PGTABLE_ARMV7S) += io-pgtable-arm-v7s.o
>   obj-$(CONFIG_IOMMU_IO_PGTABLE_LPAE) += io-pgtable-arm.o
> -obj-$(CONFIG_IOMMU_IO_PGTABLE_LPAE_SELFTEST) += io-pgtable-arm-selftests.o
> +obj-$(CONFIG_IOMMU_IO_PGTABLE_LPAE_KUNIT_TEST) += io-pgtable-arm-selftests.o
>   obj-$(CONFIG_IOMMU_IO_PGTABLE_DART) += io-pgtable-dart.o
>   obj-$(CONFIG_IOMMU_IOVA) += iova.o
>   obj-$(CONFIG_OF_IOMMU)	+= of_iommu.o
> diff --git a/drivers/iommu/io-pgtable-arm-selftests.c b/drivers/iommu/io-pgtable-arm-selftests.c
> index 32c6a5c7af53..b61849a8a685 100644
> --- a/drivers/iommu/io-pgtable-arm-selftests.c
> +++ b/drivers/iommu/io-pgtable-arm-selftests.c
> @@ -6,7 +6,8 @@
>    *
>    * Author: Will Deacon <will.deacon@arm.com>
>    */
> -#include <linux/device/faux.h>
> +#include <kunit/device.h>
> +#include <kunit/test.h>
>   #include <linux/io-pgtable.h>
>   #include <linux/kernel.h>
>   
> @@ -47,13 +48,14 @@ static void arm_lpae_dump_ops(struct io_pgtable_ops *ops)
>   		cfg->pgsize_bitmap, cfg->ias, cfg->oas);
>   }
>   
> -#define __FAIL(ops, i)	({						\
> -		WARN(1, "selftest: test failed for fmt idx %d\n", (i));	\
> -		arm_lpae_dump_ops(ops);					\
> -		-EFAULT;						\
> +#define __FAIL(test, ops, i)	({						\
> +		KUNIT_FAIL(test, "");						\
> +		kunit_err(test, "selftest: test failed for fmt idx %d\n", (i));	\

This looks suspect - AFAICS open-coded kunit_err() is intended for test 
infrastucture errors (like the allocation in the next hunk below), while 
for an actual test report message it seems it should just be:

	KUNIT_FAIL(test, "selftest: test failed for fmt idx %d\n", (i));

> +		arm_lpae_dump_ops(ops);						\
> +		-EFAULT;							\
>   })
>   
> -static int arm_lpae_run_tests(struct io_pgtable_cfg *cfg)
> +static int arm_lpae_run_tests(struct kunit *test, struct io_pgtable_cfg *cfg)
>   {
>   	static const enum io_pgtable_fmt fmts[] = {
>   		ARM_64_LPAE_S1,
> @@ -69,7 +71,7 @@ static int arm_lpae_run_tests(struct io_pgtable_cfg *cfg)
>   		cfg_cookie = cfg;
>   		ops = alloc_io_pgtable_ops(fmts[i], cfg, cfg);
>   		if (!ops) {
> -			pr_err("selftest: failed to allocate io pgtable ops\n");
> +			kunit_err(test, "selftest: failed to allocate io pgtable ops\n");
>   			return -ENOMEM;
>   		}
>   
> @@ -78,13 +80,13 @@ static int arm_lpae_run_tests(struct io_pgtable_cfg *cfg)
>   		 * Empty page tables shouldn't provide any translations.
>   		 */
>   		if (ops->iova_to_phys(ops, 42))
> -			return __FAIL(ops, i);
> +			return __FAIL(test, ops, i);
>   
>   		if (ops->iova_to_phys(ops, SZ_1G + 42))
> -			return __FAIL(ops, i);
> +			return __FAIL(test, ops, i);
>   
>   		if (ops->iova_to_phys(ops, SZ_2G + 42))
> -			return __FAIL(ops, i);
> +			return __FAIL(test, ops, i);
>   
>   		/*
>   		 * Distinct mappings of different granule sizes.
> @@ -97,16 +99,16 @@ static int arm_lpae_run_tests(struct io_pgtable_cfg *cfg)
>   					   IOMMU_READ | IOMMU_WRITE |
>   					   IOMMU_NOEXEC | IOMMU_CACHE,
>   					   GFP_KERNEL, &mapped))
> -				return __FAIL(ops, i);
> +				return __FAIL(test, ops, i);
>   
>   			/* Overlapping mappings */
>   			if (!ops->map_pages(ops, iova, iova + size, size, 1,
>   					    IOMMU_READ | IOMMU_NOEXEC,
>   					    GFP_KERNEL, &mapped))
> -				return __FAIL(ops, i);
> +				return __FAIL(test, ops, i);
>   
>   			if (ops->iova_to_phys(ops, iova + 42) != (iova + 42))
> -				return __FAIL(ops, i);
> +				return __FAIL(test, ops, i);
>   
>   			iova += SZ_1G;
>   		}
> @@ -117,18 +119,18 @@ static int arm_lpae_run_tests(struct io_pgtable_cfg *cfg)
>   			size = 1UL << j;
>   
>   			if (ops->unmap_pages(ops, iova, size, 1, NULL) != size)
> -				return __FAIL(ops, i);
> +				return __FAIL(test, ops, i);
>   
>   			if (ops->iova_to_phys(ops, iova + 42))
> -				return __FAIL(ops, i);
> +				return __FAIL(test, ops, i);
>   
>   			/* Remap full block */
>   			if (ops->map_pages(ops, iova, iova, size, 1,
>   					   IOMMU_WRITE, GFP_KERNEL, &mapped))
> -				return __FAIL(ops, i);
> +				return __FAIL(test, ops, i);
>   
>   			if (ops->iova_to_phys(ops, iova + 42) != (iova + 42))
> -				return __FAIL(ops, i);
> +				return __FAIL(test, ops, i);
>   
>   			iova += SZ_1G;
>   		}
> @@ -144,11 +146,11 @@ static int arm_lpae_run_tests(struct io_pgtable_cfg *cfg)
>   				   IOMMU_READ | IOMMU_WRITE |
>   				   IOMMU_NOEXEC | IOMMU_CACHE,
>   				   GFP_KERNEL, &mapped))
> -			return __FAIL(ops, i);
> +			return __FAIL(test, ops, i);
>   		if (mapped != size)
> -			return __FAIL(ops, i);
> +			return __FAIL(test, ops, i);
>   		if (ops->unmap_pages(ops, iova, size, 1, NULL) != size)
> -			return __FAIL(ops, i);
> +			return __FAIL(test, ops, i);
>   
>   		free_io_pgtable_ops(ops);
>   	}
> @@ -156,7 +158,7 @@ static int arm_lpae_run_tests(struct io_pgtable_cfg *cfg)
>   	return 0;
>   }
>   
> -static int arm_lpae_do_selftests(void)
> +static void arm_lpae_do_selftests(struct kunit *test)
>   {
>   	static const unsigned long pgsize[] = {
>   		SZ_4K | SZ_2M | SZ_1G,
> @@ -169,18 +171,19 @@ static int arm_lpae_do_selftests(void)
>   	};
>   
>   	int i, j, k, pass = 0, fail = 0;
> -	struct faux_device *dev;
> +	struct device *dev;
>   	struct io_pgtable_cfg cfg = {
>   		.tlb = &dummy_tlb_ops,
>   		.coherent_walk = true,
>   		.quirks = IO_PGTABLE_QUIRK_NO_WARN,
>   	};
>   
> -	dev = faux_device_create("io-pgtable-test", NULL, 0);
> -	if (!dev)
> -		return -ENOMEM;
> +	dev = kunit_device_register(test, "io-pgtable-test");
> +	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, dev);

Conversely, this is infrastructure, not an actual test of expected 
io-pgtable behaviour, so I think just:

	cfg.iommu_dev = kunit_device_register(test, "io-pgtable-test");
	if (IS_ERR(cfg.iommu_dev))
		return;

(it doesn't return NULLs either)

Otherwise, there's clearly scope for plenty more follow-up work 
streamlining and breaking the whole thing up into KUnit idioms, pulling 
the v7s test in, etc... However as a first step to at least set things 
firmly on the right KUnit-shaped path, I agree this seems enough for now.

Thanks,
Robin.

> +	if (IS_ERR_OR_NULL(dev))
> +		return;
>   
> -	cfg.iommu_dev = &dev->dev;
> +	cfg.iommu_dev = dev;
>   
>   	for (i = 0; i < ARRAY_SIZE(pgsize); ++i) {
>   		for (j = 0; j < ARRAY_SIZE(address_size); ++j) {
> @@ -189,9 +192,9 @@ static int arm_lpae_do_selftests(void)
>   				cfg.pgsize_bitmap = pgsize[i];
>   				cfg.ias = address_size[k];
>   				cfg.oas = address_size[j];
> -				pr_info("selftest: pgsize_bitmap 0x%08lx, IAS %u OAS %u\n",
> -					pgsize[i], cfg.ias, cfg.oas);
> -				if (arm_lpae_run_tests(&cfg))
> +				kunit_info(test, "selftest: pgsize_bitmap 0x%08lx, IAS %u OAS %u\n",
> +					   pgsize[i], cfg.ias, cfg.oas);
> +				if (arm_lpae_run_tests(test, &cfg))
>   					fail++;
>   				else
>   					pass++;
> @@ -199,17 +202,20 @@ static int arm_lpae_do_selftests(void)
>   		}
>   	}
>   
> -	pr_info("selftest: completed with %d PASS %d FAIL\n", pass, fail);
> -	faux_device_destroy(dev);
> -
> -	return fail ? -EFAULT : 0;
> +	kunit_info(test, "selftest: completed with %d PASS %d FAIL\n", pass, fail);
>   }
>   
> -static void arm_lpae_exit_selftests(void)
> -{
> -}
> +static struct kunit_case io_pgtable_arm_test_cases[] = {
> +	KUNIT_CASE(arm_lpae_do_selftests),
> +	{},
> +};
> +
> +static struct kunit_suite io_pgtable_arm_test = {
> +	.name = "io-pgtable-arm-test",
> +	.test_cases = io_pgtable_arm_test_cases,
> +};
> +
> +kunit_test_suite(io_pgtable_arm_test);
>   
> -subsys_initcall(arm_lpae_do_selftests);
> -module_exit(arm_lpae_exit_selftests);
>   MODULE_DESCRIPTION("io-pgtable-arm library selftest");
>   MODULE_LICENSE("GPL");
