From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC v2] dma-mapping: Use unsigned long for dma_attrs
Date: Tue, 31 May 2016 10:04:20 -0700
Message-ID: <20160531170420.GB25366@infradead.org>
References: <1464609246-6948-1-git-send-email-k.kozlowski@samsung.com>
 <1464609246-6948-2-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1464609246-6948-2-git-send-email-k.kozlowski@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Michal Hocko <mhocko@suse.com>, Arnd Bergmann <arnd@arndb.de>, linux-doc@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Joerg Roedel <joro@8bytes.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, hch@infradead.org, iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org, sstabellini@kernel.org, Andy Lutomirski <luto@kernel.org>, xen-devel@lists.xenproject.org, Andrew Morton <akpm@linux-foundation.org>, Mel Gorman <mgorman@techsingularity.net>, linux-arm-kernel@lists.infradead.org, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: iommu@lists.linux-foundation.org

On Mon, May 30, 2016 at 01:54:06PM +0200, Krzysztof Kozlowski wrote:
> The dma-mapping core and the implementations do not change the
> DMA attributes passed by pointer.  Thus the pointer can point to const
> data.  However the attributes do not have to be a bitfield. Instead
> unsigned long will do fine:
> 
> 1. This is just simpler.  Both in terms of reading the code and setting
>    attributes.  Instead of initializing local attributes on the stack and
>    passing pointer to it to dma_set_attr(), just set the bits.
> 
> 2. It brings safeness and checking for const correctness because the
>    attributes are passed by value.
> 
> Please have in mind that this is RFC, not finished yet.  Only ARM and
> ARM64 are fixed (and not everywhere).
> However other API users also have to be converted which is quite
> intrusive.  I would rather avoid it until the overall approach is
> accepted.

This looks great!  Please continue doing the full conversion.

> +/**
> + * List of possible attributes associated with a DMA mapping. The semantics
> + * of each attribute should be defined in Documentation/DMA-attributes.txt.
> + */
> +#define DMA_ATTR_WRITE_BARRIER		BIT(1)
> +#define DMA_ATTR_WEAK_ORDERING		BIT(2)
> +#define DMA_ATTR_WRITE_COMBINE		BIT(3)
> +#define DMA_ATTR_NON_CONSISTENT		BIT(4)
> +#define DMA_ATTR_NO_KERNEL_MAPPING	BIT(5)
> +#define DMA_ATTR_SKIP_CPU_SYNC		BIT(6)
> +#define DMA_ATTR_FORCE_CONTIGUOUS	BIT(7)
> +#define DMA_ATTR_ALLOC_SINGLE_PAGES	BIT(8)

No really for this patch, but I would much prefer to document them next
to the code in the long run.  Also I really think these BIT() macros
are a distraction compared to the (1 << N) notation.

> +/**
> + * dma_get_attr - check for a specific attribute
> + * @attr: attribute to look for
> + * @attrs: attributes to check within
> + */
> +static inline bool dma_get_attr(unsigned long attr, unsigned long attrs)
> +{
> +	return !!(attr & attrs);
> +}

I'd just kill this helper, much easier to simply open code it in the
caller.
