From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: RE: [RFC 4/4] drm: Add NVIDIA Tegra support
Date: Thu, 12 Apr 2012 16:20:16 +0200
Message-ID: <02c801cd18b7$622d4c30$2687e490$%szyprowski@samsung.com>
References: <1334146230-1795-1-git-send-email-thierry.reding@avionic-design.de>
	<20120411133512.GL4296@phenom.ffwll.local>
	<20120411141108.GI27337@avionic-0098.adnet.avionic-design.de>
	<201204111518.41968.arnd@arndb.de>
	<20120412071816.GA18252@avionic-0098.mockup.avionic-design.de>
	<025f01cd1887$da56b6e0$8f0424a0$%szyprowski@samsung.com>
	<20120412134216.GB15701@avionic-0098.adnet.avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <20120412134216.GB15701-RM9K5IK7kjIyiCvfTdI0JKcOhU4Rzj621B7CTYaBSLdn68oJJulU0Q@public.gmane.org>
Content-language: pl
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: 'Thierry Reding' <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Cc: Tomasz Stanislawski <t.stanislaws-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Arnd Bergmann' <arnd-r2nGTMty4D4@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, 'Daniel Vetter' <daniel-/w4YWyX8dFk@public.gmane.org>, 'Colin Cross' <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, 'Jon Mayo' <jmayo-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Thierry,

On Thursday, April 12, 2012 3:42 PM Thierry Reding wrote:

> > > Also this doesn't yet solve the vmap() problem that is needed for the kernel
> > > virtual mapping. I did try using dma_alloc_writecombine(), but that only
> > > works for chunks of 2 MB or smaller, unless I use init_consistent_dma_size()
> > > during board setup, which isn't provided for in a DT setup. I couldn't find
> > > a better alternative, but I admit I'm not very familiar with all the VM APIs.
> > > Do you have any suggestions on how to solve this? Otherwise I'll try and dig
> > > in some more.
> >
> > Yes, I'm aware of this issue I'm currently working on solving it. I hope to use
> > standard vmalloc range for all coherent/writecombine allocations and get rid of
> > the custom 'consistent_dma' region at all.
> 
> Does your work aim at removing the 2 MB limitation or at remapping non-
> contiguous memory to a virtually linear buffer? I have some trouble
> understanding how removing the 2 MB limit would help, because if all buffers
> can be allocated contiguously then there wouldn't be any need for the IOMMU,
> right?

I would like to remove 2MiB limitation by moving these mapping to generic vmalloc
area. Please notice that this 2MiB limit is only applied to CPU virtual address
space and no physical memory is preallocated for consistent dma. 

ARM linear dma mapping implementation allocates coherent buffers by calling 
alloc_pages() and then creating a coherent mapping for the allocated buffer.

With IOMMU you can allocate chunks of memory and create a contiguous DMA mapping.
To fulfill dma mapping request you also need to create a cpu coherent mapping for 
them and right now my core uses the same remapping function as linear version.

The only limitation here will be vmalloc space and its fragmentation.

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
