From: Baolin Wang <baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] dma-coherent: Change the bitmap APIs
Date: Sun, 3 Jun 2018 10:11:55 +0800
Message-ID: <CAMz4kuKM4mKyzh8Ws=82RgtOdLa8d_Dsq-=P0grqpGa=e=q3bQ@mail.gmail.com>
References: <c5765cf69bf222757463ba2653ac760b42b785e6.1527745258.git.baolin.wang@linaro.org>
	<892fabb55ebe7bb35aa3f0be03ee3f93132b7acc.1527745258.git.baolin.wang@linaro.org>
	<8ef2eacf-97af-3449-c3ef-c64516ee05ea@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <8ef2eacf-97af-3449-c3ef-c64516ee05ea-5wv7dgnIgG8@public.gmane.org>
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
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, hch-jcswGhMUV9g@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 1 June 2018 at 01:38, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org> wrote:
> On 31/05/18 06:55, Baolin Wang wrote:
>>
>> The device coherent memory uses the bitmap helper functions, which take an
>> order of PAGE_SIZE, that means the pages size is always a power of 2 as
>> the
>> allocation region. For Example, allocating 33 MB from a 33 MB dma_mem
>> region
>> requires 64MB free memory in that region.
>>
>> Thus we can change to use bitmap_find_next_zero_area()/bitmap_set()/
>> bitmap_clear() to present the allocation coherent memory, and reduce the
>> allocation granularity to be one PAGE_SIZE.
>>
>> Moreover from Arnd's description:
>> "I believe that bitmap_allocate_region() was chosen here because it is
>> more efficient than bitmap_find_next_zero_area(), at least that is the
>> explanation given in
>> https://en.wikipedia.org/wiki/Buddy_memory_allocation.
>>
>> It's quite possible that we don't actually care about efficiency of
>> dma_alloc_*() since a) it's supposed to be called very rarely, and
>> b) the overhead of accessing uncached memory is likely higher than the
>> search through a relatively small bitmap".
>>
>> Thus I think we can convert to change the allocation granularity to be
>> one PAGE_SIZE replacing with new bitmap APIs, which will not cause
>> efficiency issue.
>
>
> To quote the DMA API docs:
>
>   "The CPU virtual address and the DMA address are both
>    guaranteed to be aligned to the smallest PAGE_SIZE order which
>    is greater than or equal to the requested size.  This invariant
>    exists (for example) to guarantee that if you allocate a chunk
>    which is smaller than or equal to 64 kilobytes, the extent of the
>    buffer you receive will not cross a 64K boundary."
>
> Now obviously there's a point above which that stops being practical, but

Agree.

> it's probably safe to assume that a device asking for a multi-megabyte
> buffer doesn't actually have stringent boundary requirements either. For
> smaller sizes, though, it definitely can matter. At the very least up to
> 64KB, and probably up as far as MAX_ORDER-size requests, we need to preserve
> the existing behaviour or something, somewhere, will break.

Some devices really don't care the boundary issue, and as you said
maybe some devices will care for smaller sizes. So I think this is
depend on the devices' requirement, then can we add one boundary
parameter for the allocation according to the devices requirement? Or
like I said, we will waste lots of reserved memory if the granularity
is so large.

Thanks for your comments.

-- 
Baolin.wang
Best Regards
