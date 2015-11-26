From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2] iommu/dma: Map scatterlists more parsimoniously
Date: Thu, 26 Nov 2015 17:36:20 +0000
Message-ID: <56574314.30205@arm.com>
References: <cf89e25139683d85862302e75f9923d101ba233e.1448016328.git.robin.murphy@arm.com>
	<20151126153728.GC17674@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20151126153728.GC17674-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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

On 26/11/15 15:37, Joerg Roedel wrote:
> On Fri, Nov 20, 2015 at 10:57:40AM +0000, Robin Murphy wrote:
>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>> index 3a20db4..427fdc1 100644
>> --- a/drivers/iommu/dma-iommu.c
>> +++ b/drivers/iommu/dma-iommu.c
>> @@ -441,6 +441,7 @@ int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
>>   	struct scatterlist *s, *prev = NULL;
>>   	dma_addr_t dma_addr;
>>   	size_t iova_len = 0;
>> +	unsigned long mask = dma_get_seg_boundary(dev);
>>   	int i;
>>
>>   	/*
>> @@ -452,6 +453,7 @@ int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
>>   	for_each_sg(sg, s, nents, i) {
>>   		size_t s_offset = iova_offset(iovad, s->offset);
>>   		size_t s_length = s->length;
>> +		size_t pad_len = (mask - iova_len + 1) & mask;
>>
>>   		sg_dma_address(s) = s->offset;
>>   		sg_dma_len(s) = s_length;
>> @@ -460,15 +462,13 @@ int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
>>   		s->length = s_length;
>>
>>   		/*
>> -		 * The simple way to avoid the rare case of a segment
>> -		 * crossing the boundary mask is to pad the previous one
>> -		 * to end at a naturally-aligned IOVA for this one's size,
>> -		 * at the cost of potentially over-allocating a little.
>> +		 * With a single size-aligned IOVA allocation, no segment risks
>> +		 * crossing the boundary mask unless the total size exceeds
>> +		 * the mask itself. The simple way to maintain alignment when
>> +		 * that does happen is to pad the previous segment to end at the
>> +		 * next boundary, at the cost of over-allocating a little.
>>   		 */
>> -		if (prev) {
>> -			size_t pad_len = roundup_pow_of_two(s_length);
>> -
>> -			pad_len = (pad_len - iova_len) & (pad_len - 1);
>> +		if (pad_len && pad_len < s_length - 1) {
>>   			prev->length += pad_len;
>>   			iova_len += pad_len;
>>   		}
>
> Hmm, this whole code looks overly complicated. Why don't you just add
> the sizes of the individual sg-elements together and then do an
> allocation aligned on the next power-of-two. This will not cross the
> boundary mask until the size is smaller than the mask.

Other than all of 4 lines referencing pad_len, that's exactly what it 
does! In the very common case when the boundary mask is larger than the 
total length such that (pad_len < s_length - 1) is always false, that's 
still exactly what it does!

> When the size is bigger than the mask you can either put a WARN on into
> and return error (to see if that really happens), or just do multiple
> smaller allocations that fit into the boundary mask.

That case is actually surprisingly common in at least one situation - a 
typical scatterlist coming in from the SCSI layer seems to have a max 
segment length of 65536, a boundary mask of 0xffff, and a short first 
segment followed by subsequent full segments (I guess they are the 
command buffer and data buffers respectively), meaning an alignment bump 
is needed fairly frequently there.

I wanted to avoid multiple allocations for various reasons:
  - iommu_map_sg() only takes a single base IOVA, but it's nice if we 
can make use of it.
  - Some of the "complication" would just be shifted into the unmap 
path, and having to make multiple unmap requests to the IOMMU driver 
increases the number of potentially costly TLB syncs.
  - It minimises contention in the IOVA allocator, which is apparently a 
real-world problem ;)
  - 'Proper' segment concatenation is only a small step on top of the 
current code - probably only a couple of extra lines in finalise_sg() (I 
just haven't yet looked into resurrecting it from iommu-dma v5 as I'm 
trying to get other things done).
  - Unless we bring back the really dumb "blindly iommu_map() each 
segment individually" function from iommu-dma v1, we have to scan the 
list doing all this segment boundary calculation regardless. At that 
point it seems far cheaper and simpler to add one number to another 
number along the way than to break off into a whole 
allocate/map/see-if-it-worked cycle every time.
  - I like to minimise the number of people complaining at me that whole 
scatterlists don't get mapped into contiguous IOVA ranges.

Robin.
