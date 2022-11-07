Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECCEE3209
	for <iommu@lists.linux.dev>; Mon,  7 Nov 2022 13:03:42 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 72BFB1FB;
	Mon,  7 Nov 2022 05:03:45 -0800 (PST)
Received: from [10.57.36.87] (unknown [10.57.36.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 462E63F73D;
	Mon,  7 Nov 2022 05:03:36 -0800 (PST)
Message-ID: <6e846f75-b330-9523-4356-41d5f9e48f12@arm.com>
Date: Mon, 7 Nov 2022 13:03:31 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v3 13/13] dma: arm64: Add
 CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC and enable it for arm64
Content-Language: en-GB
To: Catalin Marinas <catalin.marinas@arm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann
 <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Herbert Xu <herbert@gondor.apana.org.au>, Ard Biesheuvel <ardb@kernel.org>,
 Isaac Manjarres <isaacmanjarres@google.com>,
 Saravana Kannan <saravanak@google.com>, Alasdair Kergon <agk@redhat.com>,
 Daniel Vetter <daniel@ffwll.ch>, Joerg Roedel <joro@8bytes.org>,
 Mark Brown <broonie@kernel.org>, Mike Snitzer <snitzer@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-mm@kvack.org,
 iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org
References: <20221106220143.2129263-1-catalin.marinas@arm.com>
 <20221106220143.2129263-14-catalin.marinas@arm.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20221106220143.2129263-14-catalin.marinas@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2022-11-06 22:01, Catalin Marinas wrote:
> With all the infrastructure in place for bouncing small kmalloc()
> buffers, add the corresponding Kconfig entry and select it for arm64.

AFAICS we're missing the crucial part to ensure that SWIOTLB is 
available even when max_pfn <= arm64_dma_phys_limit, which is very 
likely to be true on low-memory systems that care most about kmalloc 
wastage. The only way to override that currently is with 
"swiotlb=force", but bouncing *everything* is not desirable either.

Thanks,
Robin.

> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Robin Murphy <robin.murphy@arm.com>
> ---
>   arch/arm64/Kconfig | 1 +
>   kernel/dma/Kconfig | 8 ++++++++
>   2 files changed, 9 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 3991cb7b8a33..f889cf16e6ab 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -100,6 +100,7 @@ config ARM64
>   	select ARCH_WANT_FRAME_POINTERS
>   	select ARCH_WANT_HUGE_PMD_SHARE if ARM64_4K_PAGES || (ARM64_16K_PAGES && !ARM64_VA_BITS_36)
>   	select ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
> +	select ARCH_WANT_KMALLOC_DMA_BOUNCE
>   	select ARCH_WANT_LD_ORPHAN_WARN
>   	select ARCH_WANTS_NO_INSTR
>   	select ARCH_WANTS_THP_SWAP if ARM64_4K_PAGES
> diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
> index d6fab8e3cbae..b56e76371023 100644
> --- a/kernel/dma/Kconfig
> +++ b/kernel/dma/Kconfig
> @@ -86,6 +86,14 @@ config SWIOTLB
>   	bool
>   	select NEED_DMA_MAP_STATE
>   
> +config ARCH_WANT_KMALLOC_DMA_BOUNCE
> +	bool
> +
> +config DMA_BOUNCE_UNALIGNED_KMALLOC
> +	def_bool y
> +	depends on ARCH_WANT_KMALLOC_DMA_BOUNCE
> +	depends on SWIOTLB && !SLOB
> +
>   config DMA_RESTRICTED_POOL
>   	bool "DMA Restricted Pool"
>   	depends on OF && OF_RESERVED_MEM && SWIOTLB
