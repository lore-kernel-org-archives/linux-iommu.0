From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: RE: [RFC 4/4] drm: Add NVIDIA Tegra support
Date: Thu, 12 Apr 2012 15:30:52 +0200
Message-ID: <02aa01cd18b0$7b2586a0$717093e0$%szyprowski@samsung.com>
References: <1334146230-1795-1-git-send-email-thierry.reding@avionic-design.de>
	<20120412071816.GA18252@avionic-0098.mockup.avionic-design.de>
	<025f01cd1887$da56b6e0$8f0424a0$%szyprowski@samsung.com>
	<201204121118.19685.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <201204121118.19685.arnd-r2nGTMty4D4@public.gmane.org>
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
To: 'Arnd Bergmann' <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Tomasz Stanislawski <t.stanislaws-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, 'Thierry Reding' <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, 'Daniel Vetter' <daniel-/w4YWyX8dFk@public.gmane.org>, 'Colin Cross' <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, 'Jon Mayo' <jmayo-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Arnd,

On Thursday, April 12, 2012 1:18 PM Arnd Bergmann wrote:

> On Thursday 12 April 2012, Marek Szyprowski wrote:
> > Scatter lists were initially designed for the disk based block io operations,
> > hence the presence of the in-page offsets and lengths for each chunk. For
> > multimedia use cases providing an array of struct pages and asking dma-mapping
> > to map them into contiguous memory is probably all we need. I wonder if
> > introducing such new calls is a good idea. Anrd, what do think? It will
> > definitely simplify the drivers and improve the code understanding. On the
> > other hand it requires a significant amount of work in the dma-mapping
> > framework for all architectures, but that's not a big issue for me.
> 
> My feeling is that it's too much like the existing _sg version, so I wouldn't
> add yet another variant. While having a simple page array is definitely
> simpler and potentially faster, I think the API is already too complex
> and we need to be very careful with new additions.

You are right, the API is already complex. The idea of adding page array came after
explaining once again how the _sg functions work and how to use them for this
specific use case.

There is one more point for page array. Scatter-lists are also very inefficient
in terms of the used memory. In the worst case we create a single scatterlist 
entry for every single page of the large buffer. For each entry we really use 
only a page pointer, leaving offset at zero and size set to 4KiB, dma_address
and dma_length entries are usually used only for the first element in the list.

On the other hand scatter lists are the only way to describe a complex block IO
requests which is spread across multiple io buffers, which are smaller than a
single page.

Having a specialized set of functions in the API is not bad in general. Maybe
the obscurity of the current _sg functions was the reason that almost every 
developer involved in gfx/multimedia and memory management tried to provide 
his own solution instead of using the dma-mapping api. 

We already have dma_map_page() and dma_map_single() which are very similar. 
Maybe adding dma_map_pages() won't be such a bad idea? 

If not maybe we should provide some kind of helper functions which converts 
page array to scatterlist and then maps them.

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
