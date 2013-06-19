From: Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>
Subject: Re: DMA mapping API(IOMMU) for ARM64?
Date: Wed, 19 Jun 2013 12:11:38 +0100
Message-ID: <20130619111137.GJ9261@MacBook-Pro.local>
References: <20130618.053955.305832937374936961.hdoyu@nvidia.com>
	<20130618101914.GB3539@mudshark.cambridge.arm.com>
	<5159282.rrJMaZuYMv@wuerfel>
	<20130618.140137.1551430695673122122.hdoyu@nvidia.com>
	<20130618125054.GL9930@arm.com> <51C0DA4F.1010405@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <51C0DA4F.1010405-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Don Dutile <ddutile-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, "linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org" <linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Jun 18, 2013 at 11:08:15PM +0100, Don Dutile wrote:
> On 06/18/2013 08:50 AM, Catalin Marinas wrote:
> > On Tue, Jun 18, 2013 at 12:01:37PM +0100, Hiroshi Doyu wrote:
> >> Arnd Bergmann<arnd-r2nGTMty4D4@public.gmane.org>  wrote @ Tue, 18 Jun 2013 12:32:44 +0200:
> >>> On Tuesday 18 June 2013 11:19:14 Will Deacon wrote:
> >>>> I've spoken briefly with Catalin about this and it seems like there might be
> >>>> *some* scope for sharing common dma-mapping code between architectures.
> >>>> There doesn't really need to be any architecture-specific details in
> >>>> allocating iova space and the interface to the iommu drivers is
> >>>> well-defined. The arch-specific stuff is bogged down in the non-coherent
> >>>> buffer management, but that doesn't necessarily equate to lots of code.
> >>>>
> >>>> So, the best bet would be to figure out how to split up what we have under
> >>>> arch/arm/ so that it can be re-used by arm64 and potentially other
> >>>> architectures (powerpc has some simple stuff for coherent mappings and some
> >>>> less-simple stuff for non-coherent buffers).
> >>>
> >>> I'm sure that other architectures are interested in sharing the code.
> >>> Best move it into the global mm/ directory, at least the version for
> >>> coherent mappings.
> >>
> >> I'm guessing that this kind of unification usually takes some time
> >> since we need to factor out the common code from the different
> >> ${ARCH}/mm/dma-mapping.c. Also some of ${ARCH} has IOMMU support in
> >> it. So if we want to develop our 64-bit ARM with working DMA mapping
> >> API during this transition, the step to take would be:
> >>
> >> 1, Copy arch/arm/mm/dma-mapping.c arch/arm64/mm/dma-mapping.c(+swiotlb)
> >> 2, Adapt arch/arm64/mm/dma-mapping.c(+swiotlb) to 64bit compatible.
> >> 3, Factor out the common code from them into mm/dma-mapping.c
> >
> > Or add the relevant code to something like lib/iommu-helper.c, convert
> > arm64 to use that and we can work on converting arm and other
> > architectures afterwards.
> >
> why not in current drivers/iommu directory ?

That's not really specific to the iommu driver implementation, they have
a clearly defined interface. For similarity with swiotlb and given that
we already have iommu-helper.c, lib/ looks best to me. Anyway, let's
first see how the code looks like, it can be moved later.

-- 
Catalin
