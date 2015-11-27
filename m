From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2] iommu/dma: Map scatterlists more parsimoniously
Date: Fri, 27 Nov 2015 19:49:41 +0000
Message-ID: <5658B3D5.9010008@arm.com>
References: <cf89e25139683d85862302e75f9923d101ba233e.1448016328.git.robin.murphy@arm.com>
	<20151126153728.GC17674@8bytes.org> <56574314.30205@arm.com>
	<20151127151653.GK2064@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20151127151653.GK2064-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 27/11/15 15:16, Joerg Roedel wrote:
> On Thu, Nov 26, 2015 at 05:36:20PM +0000, Robin Murphy wrote:
>> On 26/11/15 15:37, Joerg Roedel wrote:
>>> When the size is bigger than the mask you can either put a WARN on into
>>> and return error (to see if that really happens), or just do multiple
>>> smaller allocations that fit into the boundary mask.
>>
>> That case is actually surprisingly common in at least one situation
>> - a typical scatterlist coming in from the SCSI layer seems to have
>> a max segment length of 65536, a boundary mask of 0xffff, and a
>> short first segment followed by subsequent full segments (I guess
>> they are the command buffer and data buffers respectively), meaning
>> an alignment bump is needed fairly frequently there.
>
> The boundary_mask is a property of the underlying device, which one is
> it with that boundary mask?

That particular one is actually ATA_DMA_BOUNDARY, which is used by 
several drivers - sata_sil24 is the specific one I was testing with.

>> I wanted to avoid multiple allocations for various reasons:
>>   - iommu_map_sg() only takes a single base IOVA, but it's nice if we
>> can make use of it.
>>   - Some of the "complication" would just be shifted into the unmap
>> path, and having to make multiple unmap requests to the IOMMU driver
>> increases the number of potentially costly TLB syncs.
>
> Yeah, its a trade-off between wasting iova space and a faster
> implementation.

Certainly my hunch is that in the great majority of use-cases 
(particularly on 64-bit systems) the IOVA space itself is going to be 
considerably less precious than the time spent managing it.

>>   - It minimises contention in the IOVA allocator, which is
>> apparently a real-world problem ;)
>
> Thats why we currently evaluate options to get rid of it completly :)

Heh, as long as the interface is sane, the implementation backing it can 
change as much as it likes. AFAICS it's still going to be generally the 
case that searching for one space once is more efficient than multiple 
searches for multiple spaces, though.

>>   - I like to minimise the number of people complaining at me that
>> whole scatterlists don't get mapped into contiguous IOVA ranges.
>
> Making that assumption is a bug anyway, this is the simple answer you
> can give to anyone complaining.

And indeed I have, repeatedly ;)

Anyway, this patch is merely making an objective improvement to the way 
the existing code does the thing it does: for comparison, 'dd bs=1M 
count=1K ...' reading from a USB mass storage device with the current 
code adds unnecessary padding to a segment in the order of a couple of 
hundred times; with this patch it never happens at all, which seems like 
precisely what you asked for.

Robin.
