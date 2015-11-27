From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] iommu/dma: Map scatterlists more parsimoniously
Date: Fri, 27 Nov 2015 16:16:53 +0100
Message-ID: <20151127151653.GK2064@8bytes.org>
References: <cf89e25139683d85862302e75f9923d101ba233e.1448016328.git.robin.murphy@arm.com>
	<20151126153728.GC17674@8bytes.org> <56574314.30205@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <56574314.30205-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Nov 26, 2015 at 05:36:20PM +0000, Robin Murphy wrote:
> On 26/11/15 15:37, Joerg Roedel wrote:
> >When the size is bigger than the mask you can either put a WARN on into
> >and return error (to see if that really happens), or just do multiple
> >smaller allocations that fit into the boundary mask.
> 
> That case is actually surprisingly common in at least one situation
> - a typical scatterlist coming in from the SCSI layer seems to have
> a max segment length of 65536, a boundary mask of 0xffff, and a
> short first segment followed by subsequent full segments (I guess
> they are the command buffer and data buffers respectively), meaning
> an alignment bump is needed fairly frequently there.

The boundary_mask is a property of the underlying device, which one is
it with that boundary mask?

> I wanted to avoid multiple allocations for various reasons:
>  - iommu_map_sg() only takes a single base IOVA, but it's nice if we
> can make use of it.
>  - Some of the "complication" would just be shifted into the unmap
> path, and having to make multiple unmap requests to the IOMMU driver
> increases the number of potentially costly TLB syncs.

Yeah, its a trade-off between wasting iova space and a faster
implementation.

>  - It minimises contention in the IOVA allocator, which is
> apparently a real-world problem ;)

Thats why we currently evaluate options to get rid of it completly :)

>  - I like to minimise the number of people complaining at me that
> whole scatterlists don't get mapped into contiguous IOVA ranges.

Making that assumption is a bug anyway, this is the simple answer you
can give to anyone complaining.


	Joerg
