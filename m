From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 11/11] arm: dma-mapping: Add support to extend DMA IOMMU
	mappings
Date: Wed, 29 Jan 2014 11:05:37 +0000
Message-ID: <20140129110537.GG26622@mudshark.cambridge.arm.com>
References: <1389876263-25759-1-git-send-email-andreas.herrmann@calxeda.com>
	<1389876263-25759-12-git-send-email-andreas.herrmann@calxeda.com>
	<52E8DE7D.5020801@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <52E8DE7D.5020801-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
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
Cc: Nicolas Pitre <nicolas.pitre-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Marek,

On Wed, Jan 29, 2014 at 10:57:01AM +0000, Marek Szyprowski wrote:
> On 2014-01-16 13:44, Andreas Herrmann wrote:
> > Instead of using just one bitmap to keep track of IO virtual addresses
> > (handed out for IOMMU use) introduce a list of iova_ranges (each
> > having its own bitmap). This allows us to extend existing mappings
> > when running out of iova space for a mapping.
> >
> > If there is not enough space in the mapping to service an IO virtual
> > address allocation request, __alloc_iova() tries to extend the mapping
> > -- by allocating another bitmap -- and makes another allocation
> > attempt using the freshly allocated bitmap.
> >
> > This allows arm iommu drivers to start with a decent initial size when
> > an dma_iommu_mapping is created and still to avoid running out of IO
> > virtual addresses for the mapping.
> >
> > Tests were done on Calxeda ECX-2000 with smmu for sata and xgmac.
> > I've used SZ_512K both for initial mapping size and grow_size.
> 
> Thanks for implementing this feature! I remember it was discussed from
> early beginning of arm dma iommu support, but I never had enough time
> to actually implement it. I briefly checked the code and it look fine,
> however I really wonder if we need separate grow_size parameter?
> Personally I would simplify it to simply grow the bitmap by initial
> size until it reaches the maximal size.

That sounds sensible, but I also think it would be worth taking into account
the page sizes supported by the IOMMU as well, since aligning to those makes
sense from a TLB utilisation perspective.

> The whole concept of the simplified bitmap (where 1 bit != 1 page) for
> iova allocation is a specific feature of this code and it has nothing
> to the hardware. After thinking a bit more on the existing
> implementation I've already observed that it is sometimes hard to
> understand the parameters for arm_iommu_create_mapping() function,
> especially the 'order' argument is ofter misunderstood. With your
> patch we got two additional parameters. Maybe it will be much better
> to use only 2 arguments: max_mapping_size and allocation_accuracy.
> The initial bitmap size can be then calculated to fit it into single
> memory page (that's quite important to avoid allocations larger that
> a single memory page). 'allocation_accuracy' will serve the same way
> as 'order' parameter now (but expressed in bytes rather than being
> the multiplier for the number of pages). This way the
> arm_iommu_create_mapping() function should be much easier to
> understand, while keeping the implementation details hidden from the
> caller.

Hmm, I wouldn't guess the SI unit of accuracy to be bytes ;)

Will
