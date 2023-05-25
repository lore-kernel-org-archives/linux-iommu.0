Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4A519E7F
	for <iommu@lists.linux.dev>; Thu, 25 May 2023 16:12:49 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A82561042;
	Thu, 25 May 2023 09:13:33 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 060BB3F762;
	Thu, 25 May 2023 09:12:38 -0700 (PDT)
Message-ID: <ac8e86ba-fd2c-3816-8156-86af7ac8327c@arm.com>
Date: Thu, 25 May 2023 17:12:37 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v5 15/15] arm64: Enable ARCH_WANT_KMALLOC_DMA_BOUNCE for
 arm64
Content-Language: en-GB
To: Catalin Marinas <catalin.marinas@arm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Herbert Xu <herbert@gondor.apana.org.au>, Ard Biesheuvel <ardb@kernel.org>,
 Isaac Manjarres <isaacmanjarres@google.com>,
 Saravana Kannan <saravanak@google.com>, Alasdair Kergon <agk@redhat.com>,
 Daniel Vetter <daniel@ffwll.ch>, Joerg Roedel <joro@8bytes.org>,
 Mark Brown <broonie@kernel.org>, Mike Snitzer <snitzer@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-mm@kvack.org,
 iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org
References: <20230524171904.3967031-1-catalin.marinas@arm.com>
 <20230524171904.3967031-16-catalin.marinas@arm.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230524171904.3967031-16-catalin.marinas@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/05/2023 6:19 pm, Catalin Marinas wrote:
> With the DMA bouncing of unaligned kmalloc() buffers now in place,
> enable it for arm64 to allow the kmalloc-{8,16,32,48,96} caches. In
> addition, always create the swiotlb buffer even when the end of RAM is
> within the 32-bit physical address range (the swiotlb buffer can still
> be disabled on the kernel command line).
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> ---
>   arch/arm64/Kconfig   | 1 +
>   arch/arm64/mm/init.c | 7 ++++++-
>   2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index b1201d25a8a4..af42871431c0 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -120,6 +120,7 @@ config ARM64
>   	select CRC32
>   	select DCACHE_WORD_ACCESS
>   	select DYNAMIC_FTRACE if FUNCTION_TRACER
> +	select DMA_BOUNCE_UNALIGNED_KMALLOC

We may want to give the embedded folks an easier way of turning this 
off, since IIRC one of the reasons for the existing automatic behaviour 
was people not wanting to have to depend on the command line. Things 
with 256MB or so of RAM seem unlikely to get enough memory efficiency 
back from the smaller kmem caches to pay off the SWIOTLB allocation :)

Cheers,
Robin.

>   	select DMA_DIRECT_REMAP
>   	select EDAC_SUPPORT
>   	select FRAME_POINTER
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 66e70ca47680..3ac2e9d79ce4 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -442,7 +442,12 @@ void __init bootmem_init(void)
>    */
>   void __init mem_init(void)
>   {
> -	swiotlb_init(max_pfn > PFN_DOWN(arm64_dma_phys_limit), SWIOTLB_VERBOSE);
> +	bool swiotlb = max_pfn > PFN_DOWN(arm64_dma_phys_limit);
> +
> +	if (IS_ENABLED(CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC))
> +		swiotlb = true;
> +
> +	swiotlb_init(swiotlb, SWIOTLB_VERBOSE);
>   
>   	/* this will put all unused low memory onto the freelists */
>   	memblock_free_all();
