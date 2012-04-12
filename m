From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: RE: [RFC 4/4] drm: Add NVIDIA Tegra support
Date: Thu, 12 Apr 2012 10:40:01 +0200
Message-ID: <025f01cd1887$da56b6e0$8f0424a0$%szyprowski@samsung.com>
References: <1334146230-1795-1-git-send-email-thierry.reding@avionic-design.de>
	<20120411133512.GL4296@phenom.ffwll.local>
	<20120411141108.GI27337@avionic-0098.adnet.avionic-design.de>
	<201204111518.41968.arnd@arndb.de>
	<20120412071816.GA18252@avionic-0098.mockup.avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <20120412071816.GA18252-RM9K5IK7kjIQXX3q8xo1gnVAuStQJXxyR5q1nwbD4aMs9pC9oP6+/A@public.gmane.org>
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
To: 'Thierry Reding' <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>, 'Arnd Bergmann' <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Tomasz Stanislawski <t.stanislaws-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, 'Daniel Vetter' <daniel-/w4YWyX8dFk@public.gmane.org>, 'Colin Cross' <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, 'Jon Mayo' <jmayo-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Thierry,

On Thursday, April 12, 2012 9:18 AM Thierry Reding wrote:

> * Arnd Bergmann wrote:
> > On Wednesday 11 April 2012, Thierry Reding wrote:
> > > Daniel Vetter wrote:
> > > > Well, you use the iommu api to map/unmap memory into the iommu for tegra,
> > > > whereas usually device drivers just use the dma api to do that. The usual
> > > > interface is dma_map_sg/dma_unmap_sg, but there are quite a few variants
> > > > around. I'm just wondering why this you've choosen this.
> > >
> > > I don't think this works on ARM. Maybe I'm not seeing the whole picture but
> > > judging by a quick look through the kernel tree there aren't any users that
> > > map DMA memory through an IOMMU.
> >
> > dma_map_sg is certainly the right interface to use, and Marek Szyprowski has
> > patches to make that work on ARM, hopefully going into v3.5, so you could
> > use those.
> 
> I've looked at Marek's patches but I don't think they'll work for Tegra 2 or
> Tegra 3. The corresponding iommu_map() functions only set one PTE, regardless
> of the number of bytes passed to them. However, the Tegra TRM indicates that
> mapping needs to be done on a per-page basis so contiguous regions cannot be
> combined. I suppose the IOMMU driver would have to be fixed to program more
> than a single page in that case.

I assume you want to map a set of pages into contiguous chunk in io address space.
This can be done with dma_map_sg() call once IOMMU aware implementation has been
assigned to the given device. DMA-mapping implementation is able to merge 
consecutive chunks of the scatter list in the dma/io address space if possible
(i.e. there are no in-page offsets between the chunks). With my implementation 
of IOMMU aware dma-mapping you usually you get a single DMA chunk from the 
provided scatter-list.

I know that this approach causes a lot of confusion at the first look, but that
how dma mapping api has been designed. The scatter list based approach has some
drawbacks - it is a bit oversized for most of the typical use cases for the 
gfx/multimedia buffers, but that's all we have now. 

Scatter lists were initially designed for the disk based block io operations, 
hence the presence of the in-page offsets and lengths for each chunk. For 
multimedia use cases providing an array of struct pages and asking dma-mapping 
to map them into contiguous memory is probably all we need. I wonder if 
introducing such new calls is a good idea. Anrd, what do think? It will 
definitely simplify the drivers and improve the code understanding. On the 
other hand it requires a significant amount of work in the dma-mapping 
framework for all architectures, but that's not a big issue for me.

> Also this doesn't yet solve the vmap() problem that is needed for the kernel
> virtual mapping. I did try using dma_alloc_writecombine(), but that only
> works for chunks of 2 MB or smaller, unless I use init_consistent_dma_size()
> during board setup, which isn't provided for in a DT setup. I couldn't find
> a better alternative, but I admit I'm not very familiar with all the VM APIs.
> Do you have any suggestions on how to solve this? Otherwise I'll try and dig
> in some more.

Yes, I'm aware of this issue I'm currently working on solving it. I hope to use 
standard vmalloc range for all coherent/writecombine allocations and get rid of
the custom 'consistent_dma' region at all.

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
