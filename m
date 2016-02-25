From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [RFC 3/3] iommu: dma-iommu: use common implementation also on ARM
	architecture
Date: Thu, 25 Feb 2016 15:44:44 +0100
Message-ID: <4895295.FP9RzJmAYS@wuerfel>
References: <1455870164-25337-1-git-send-email-m.szyprowski@samsung.com>
	<2724572.qtPjgumFDJ@wuerfel> <56CEF2E9.5040706@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <56CEF2E9.5040706-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Sakari Ailus <sakari.ailus-X3B1VOXEql0@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Mark Yao <mark.yao-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thursday 25 February 2016 13:26:17 Marek Szyprowski wrote:
> >> +}
> >> +
> >> +extern void *arch_alloc_from_atomic_pool(size_t size, struct page **ret_page,
> >> +                                     gfp_t flags);
> >> +extern bool arch_in_atomic_pool(void *start, size_t size);
> >> +extern int arch_free_from_atomic_pool(void *start, size_t size);
> >> +
> >> +
> > doesn't feel completely right yet. In particular the arch_flush_page()
> > interface is probably still too specific to ARM/ARM64 and won't work
> > that way on other architectures.
> >
> > I think it would be better to do this either more generic, or less generic:
> >
> > a) leave the iommu_dma_map_ops definition in the architecture specific
> >     code, but make it call helper functions in the drivers/iommu to do all
> >     of the really generic parts.
> >
> > b) clarify that this is only applicable to arch/arm and arch/arm64, and
> >     unify things further between these two, as they have very similar
> >     requirements in the CPU architecture.
> 
> Some really generic parts are already in iommu/dma-iommu.c and one can build
> it's own, non-ARM CPU architecture based IOMMU/DMA-mapping code. Initially I
> also wanted to use that generic code on both ARM and ARM64, but it 
> turned out
> that both archs, ARM and ARM64 will duplicate 99% of code, which use this
> 'generic' functions. This was the reason why I dedided to move all that
> common code from arch/{arm,arm64}/mm/dma-mapping.c to
> drivers/iommu/dma-iommu-ops.c
> 
> I'm not sure if I can design all the changes that need to be made to
> drivers/iommu/dma-iommu-ops.c to make it more generic. Maybe when one will
> try to use that code with other, non-ARM architecture based arch glue code,
> a better abstraction can be developed. For now I would like to keep all this
> code in a common place so both arm and arm64 will benefit from improvements
> done there.

Fair enough. Let's stay with your approach then.

	Arnd
