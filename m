Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD8B11182
	for <iommu@lists.linux.dev>; Fri, 19 May 2023 15:49:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4E51C433D2;
	Fri, 19 May 2023 15:49:06 +0000 (UTC)
Date: Fri, 19 May 2023 16:49:04 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Ard Biesheuvel <ardb@kernel.org>,
	Isaac Manjarres <isaacmanjarres@google.com>,
	Saravana Kannan <saravanak@google.com>,
	Alasdair Kergon <agk@redhat.com>, Daniel Vetter <daniel@ffwll.ch>,
	Joerg Roedel <joro@8bytes.org>, Mark Brown <broonie@kernel.org>,
	Mike Snitzer <snitzer@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, linux-mm@kvack.org,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 01/15] mm/slab: Decouple ARCH_KMALLOC_MINALIGN from
 ARCH_DMA_MINALIGN
Message-ID: <ZGeacMJi2SEn+6C3@arm.com>
References: <20230518173403.1150549-1-catalin.marinas@arm.com>
 <20230518173403.1150549-2-catalin.marinas@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230518173403.1150549-2-catalin.marinas@arm.com>

On Thu, May 18, 2023 at 06:33:49PM +0100, Catalin Marinas wrote:
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 6b3e155b70bf..3f76e7c53ada 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -235,14 +235,24 @@ void kmem_dump_obj(void *object);
>   * alignment larger than the alignment of a 64-bit integer.
>   * Setting ARCH_DMA_MINALIGN in arch headers allows that.
>   */
> -#if defined(ARCH_DMA_MINALIGN) && ARCH_DMA_MINALIGN > 8
> +#ifdef ARCH_DMA_MINALIGN
> +#define ARCH_HAS_DMA_MINALIGN
> +#if ARCH_DMA_MINALIGN > 8 && !defined(ARCH_KMALLOC_MINALIGN)
>  #define ARCH_KMALLOC_MINALIGN ARCH_DMA_MINALIGN
> -#define KMALLOC_MIN_SIZE ARCH_DMA_MINALIGN
> -#define KMALLOC_SHIFT_LOW ilog2(ARCH_DMA_MINALIGN)
> +#endif
>  #else
> +#define ARCH_DMA_MINALIGN __alignof__(unsigned long long)
> +#endif
> +
> +#ifndef ARCH_KMALLOC_MINALIGN
>  #define ARCH_KMALLOC_MINALIGN __alignof__(unsigned long long)
>  #endif
>  
> +#if ARCH_KMALLOC_MINALIGN > 8
> +#define KMALLOC_MIN_SIZE ARCH_KMALLOC_MINALIGN
> +#define KMALLOC_SHIFT_LOW ilog2(KMALLOC_MIN_SIZE)
> +#endif

And another fixup here (reported by the test robot; I pushed the fixups
to the git branch):

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 3f76e7c53ada..50dcf9cfbf62 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -246,9 +246,7 @@ void kmem_dump_obj(void *object);

 #ifndef ARCH_KMALLOC_MINALIGN
 #define ARCH_KMALLOC_MINALIGN __alignof__(unsigned long long)
-#endif
-
-#if ARCH_KMALLOC_MINALIGN > 8
+#elif ARCH_KMALLOC_MINALIGN > 8
 #define KMALLOC_MIN_SIZE ARCH_KMALLOC_MINALIGN
 #define KMALLOC_SHIFT_LOW ilog2(KMALLOC_MIN_SIZE)
 #endif

-- 
Catalin
