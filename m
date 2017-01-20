From: Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 1/3] mm: alloc_contig_range: allow to specify GFP mask
Date: Fri, 20 Jan 2017 13:35:40 +0100
Message-ID: <81849c0d-b7aa-faf2-484c-66b0ea0a7e95@suse.cz>
References: <20170119170707.31741-1-l.stach@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20170119170707.31741-1-l.stach@pengutronix.de>
Sender: kvm-owner@vger.kernel.org
To: Lucas Stach <l.stach@pengutronix.de>, Andrew Morton <akpm@linux-foundation.org>
Cc: Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Ralf Baechle <ralf@linux-mips.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Alexander Graf <agraf@suse.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Michal Hocko <mhocko@suse.com>, linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, linux-xtensa@linux-xtensa.org, iommu@lists.linux-foundation.org, linux-mm@kvack.org, kernel@peng
List-Id: iommu@lists.linux-foundation.org

On 01/19/2017 06:07 PM, Lucas Stach wrote:
> Currently alloc_contig_range assumes that the compaction should
> be done with the default GFP_KERNEL flags. This is probably
> right for all current uses of this interface, but may change as
> CMA is used in more use-cases (including being the default DMA
> memory allocator on some platforms).
> 
> Change the function prototype, to allow for passing through the
> GFP mask set by upper layers. No functional change in this patch,
> just making the assumptions a bit more obvious.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

[...]

> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index eced9fee582b..6d392d8dee36 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -7230,6 +7230,7 @@ static int __alloc_contig_migrate_range(struct compact_control *cc,
>   *			#MIGRATE_MOVABLE or #MIGRATE_CMA).  All pageblocks
>   *			in range must have the same migratetype and it must
>   *			be either of the two.
> + * @gfp_mask:	GFP mask to use during compaction
>   *
>   * The PFN range does not have to be pageblock or MAX_ORDER_NR_PAGES
>   * aligned, however it's the caller's responsibility to guarantee that
> @@ -7243,7 +7244,7 @@ static int __alloc_contig_migrate_range(struct compact_control *cc,
>   * need to be freed with free_contig_range().
>   */
>  int alloc_contig_range(unsigned long start, unsigned long end,
> -		       unsigned migratetype)
> +		       unsigned migratetype, gfp_t gfp_mask)
>  {
>  	unsigned long outer_start, outer_end;
>  	unsigned int order;
> @@ -7255,7 +7256,7 @@ int alloc_contig_range(unsigned long start, unsigned long end,
>  		.zone = page_zone(pfn_to_page(start)),
>  		.mode = MIGRATE_SYNC,
>  		.ignore_skip_hint = true,
> -		.gfp_mask = GFP_KERNEL,
> +		.gfp_mask = gfp_mask,

I think you should apply memalloc_noio_flags() here (and Michal should
then convert it to the new name in his scoped gfp_nofs series). Note
that then it's technically a functional change, but it's needed.
Otherwise looks good.

>  	};
>  	INIT_LIST_HEAD(&cc.migratepages);
>  
> 

