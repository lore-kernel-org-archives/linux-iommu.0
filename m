Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6838462
	for <iommu@lists.linux.dev>; Wed,  8 Mar 2023 17:31:53 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AFEA11063;
	Wed,  8 Mar 2023 09:32:36 -0800 (PST)
Received: from [10.57.90.59] (unknown [10.57.90.59])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6AE033F67D;
	Wed,  8 Mar 2023 09:31:52 -0800 (PST)
Message-ID: <fc295b0a-a10d-5101-aeb6-58e29c306a24@arm.com>
Date: Wed, 8 Mar 2023 17:31:47 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] iommu: Spelling s/cpmxchg64/cmpxchg64/
Content-Language: en-GB
To: Geert Uytterhoeven <geert+renesas@glider.be>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <eab156858147249d44463662eb9192202c39ab9f.1678295792.git.geert+renesas@glider.be>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <eab156858147249d44463662eb9192202c39ab9f.1678295792.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023-03-08 17:17, Geert Uytterhoeven wrote:
> Fix misspellings of "cmpxchg64"

Oof, thanks Geert!

Acked-by: Robin Murphy <robin.murphy@arm.com>

> Fixes: d286a58bc8f4d5cf ("iommu: Tidy up io-pgtable dependencies")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> ---
>   drivers/iommu/Kconfig | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index 889c7efd050bc89f..c4928514e5e2a5ca 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -33,7 +33,7 @@ config IOMMU_IO_PGTABLE_LPAE
>   	bool "ARMv7/v8 Long Descriptor Format"
>   	select IOMMU_IO_PGTABLE
>   	depends on ARM || ARM64 || COMPILE_TEST
> -	depends on !GENERIC_ATOMIC64	# for cpmxchg64()
> +	depends on !GENERIC_ATOMIC64	# for cmpxchg64()
>   	help
>   	  Enable support for the ARM long descriptor pagetable format.
>   	  This allocator supports 4K/2M/1G, 16K/32M and 64K/512M page
> @@ -72,7 +72,7 @@ config IOMMU_IO_PGTABLE_DART
>   	bool "Apple DART Formats"
>   	select IOMMU_IO_PGTABLE
>   	depends on ARM64 || COMPILE_TEST
> -	depends on !GENERIC_ATOMIC64	# for cpmxchg64()
> +	depends on !GENERIC_ATOMIC64	# for cmpxchg64()
>   	help
>   	  Enable support for the Apple DART pagetable formats. These include
>   	  the t8020 and t6000/t8110 DART formats used in Apple M1/M2 family
