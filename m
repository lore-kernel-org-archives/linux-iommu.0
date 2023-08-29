Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF8D17AAA
	for <iommu@lists.linux.dev>; Tue, 29 Aug 2023 14:22:33 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 982712F4;
	Tue, 29 Aug 2023 07:23:12 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 731133F64C;
	Tue, 29 Aug 2023 07:22:32 -0700 (PDT)
Message-ID: <6f936d6e-9f27-ba72-68de-0ed27c0dbbe1@arm.com>
Date: Tue, 29 Aug 2023 15:22:22 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] dma/pool: trivial: add semicolon after label
 attributes
To: Chunhui He <hchunhui@mail.ustc.edu.cn>, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20230826085317.69713-1-hchunhui@mail.ustc.edu.cn>
Content-Language: en-GB
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230826085317.69713-1-hchunhui@mail.ustc.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/08/2023 9:53 am, Chunhui He wrote:
> The gcc document says label attributes are ambiguous if they are
> not immediately followed by a semicolon. Although the ambiguity
> does not arise in C90/99, it would be better to add it.

AFAICS, what that clearly says is that *C++* label attributes can be 
ambiguous. This is not C++ code. Even in C11, declarations still cannot 
be labelled, so it should still be the case that, per the same GCC 
documentation, "the ambiguity does not arise". And even if the language 
did allow it, an inline declaration at that point at the end of a 
function would be downright weird and against the kernel coding style 
anyway.

So, I don't really see what's "better" about cluttering up C code with 
unnecessary C++isms; it's just weird noise to me. The only thing I think 
it *does* achieve is introduce the chance that the static checker 
brigade eventually identifies a redundant semicolon and we get more 
patches to remove it again.

Thanks,
Robin.

> Link: https://gcc.gnu.org/onlinedocs/gcc/Attribute-Syntax.html#Label-Attributes-2
> Signed-off-by: Chunhui He <hchunhui@mail.ustc.edu.cn>
> ---
>   kernel/dma/pool.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
> index 1acec2e22827..f99f02b88c40 100644
> --- a/kernel/dma/pool.c
> +++ b/kernel/dma/pool.c
> @@ -136,7 +136,7 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
>   #ifdef CONFIG_DMA_DIRECT_REMAP
>   	dma_common_free_remap(addr, pool_size);
>   #endif
> -free_page: __maybe_unused
> +free_page: __maybe_unused;
>   	__free_pages(page, order);
>   out:
>   	return ret;
