From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 2/3] iommu/dma: Use correct offset in map_sg
Date: Wed, 9 Mar 2016 15:00:19 +0000
Message-ID: <56E03A83.9050909@arm.com>
References: <9a84191ed813c23db7901f8c73f514d081495bdf.1450457730.git.robin.murphy@arm.com>
	<4812a34857b081e45c36d7e887840f3675da74dc.1450457730.git.robin.murphy@arm.com>
	<CANqRtoSHa1fzQge4ntK9Jt_XFiL0AKWtUti93-cwS-aOkJQcjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CANqRtoSHa1fzQge4ntK9Jt_XFiL0AKWtUti93-cwS-aOkJQcjg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Magnus,

Thanks for bringing this up...

On 09/03/16 07:50, Magnus Damm wrote:
> On Sat, Dec 19, 2015 at 2:01 AM, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org> wrote:
>> When mapping a non-page-aligned scatterlist entry, we copy the original
>> offset to the output DMA address before aligning it to hand off to
>> iommu_map_sg(), then later adding the IOVA page address portion to get
>> the final mapped address. However, when the IOVA page size is smaller
>> than the CPU page size, it is the offset within the IOVA page we want,
>> not that within the CPU page, which can easily be larger than an IOVA
>> page and thus result in an incorrect final address.
>>
>> Fix the bug by taking only the IOVA-aligned part of the offset as the
>> basis of the DMA address, not the whole thing.
>>
>> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
>> ---
>>   drivers/iommu/dma-iommu.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>> index 982e716..03811e3 100644
>> --- a/drivers/iommu/dma-iommu.c
>> +++ b/drivers/iommu/dma-iommu.c
>> @@ -458,7 +458,7 @@ int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
>>                  size_t s_length = s->length;
>>                  size_t pad_len = (mask - iova_len + 1) & mask;
>>
>> -               sg_dma_address(s) = s->offset;
>> +               sg_dma_address(s) = s_offset;
>>                  sg_dma_len(s) = s_length;
>>                  s->offset -= s_offset;
>>                  s_length = iova_align(iovad, s_length + s_offset);
>> --
>> 1.9.1
>
> Hi Robin,
>
> Thanks a lot for your fix! While I don't have any doubt that your
> patch fixes a real issue I wonder if another update is needed.
> Depending on what is expected perhaps just the comment above the code
> wants an update or maybe the "un-swizzling" needs more work. With this
> patch applied the code looks semi-complete to me at this point.
>
> Currently the comment just above the hunk says:
>
>      /*
>       * Work out how much IOVA space we need, and align the segments to
>       * IOVA granules for the IOMMU driver to handle. With some clever
>       * trickery we can modify the list in-place, but reversibly, by
>       * hiding the original data in the as-yet-unused DMA fields.
>       */
>
> With your fix the "original data" is no longer stored in the unused
> DMA fields.

OK, so we're now  moving some of the data rather than taking a literal 
copy, but the point remains that we're not throwing any information away 
- we can move the remainder back again if necessary. As far as I'm 
concerned the comment is still valid, but if it's open to 
misinterpretation I can try rephrasing it.

> Instead the s_offset value is stored as modified in
> sg_dma_address() which in turn will make the iommu_dma_map_sg()
> function return with modified sg->s_offset both on success and
> failure.
>
> Perhaps this is intentional design, or maybe __invalidate_sg() and
> __finalize_sg() both need to support roll back? Any ideas?

What's missing is that some idiot forgot about the hard-to-exercise 
failure path and didn't update __invalidate_sg() to match. I'll get 
right on that...

Robin.

> Thanks,
>
> / magnus
>
> My untested hack to support roll back on top of next-20160308 does
> something like this...
>
> --- 0001/drivers/iommu/dma-iommu.c
> +++ work/drivers/iommu/dma-iommu.c    2016-03-09 16:33:21.250513000 +0900
> @@ -392,7 +392,7 @@ void iommu_dma_unmap_page(struct device
>    * Handling IOVA concatenation can come later, if needed
>    */
>   static int __finalise_sg(struct device *dev, struct scatterlist *sg, int nents,
> -        dma_addr_t dma_addr)
> +             dma_addr_t dma_addr, struct iova_domain *iovad)
>   {
>       struct scatterlist *s;
>       int i;
> @@ -405,7 +405,7 @@ static int __finalise_sg(struct device *
>
>           s->offset = s_offset;
>           s->length = s_length;
> -        sg_dma_address(s) = dma_addr + s_offset;
> +        sg_dma_address(s) = dma_addr + iova_offset(iovad, s_offset);
>           dma_addr += s_dma_len;
>       }
>       return i;
> @@ -455,11 +455,13 @@ int iommu_dma_map_sg(struct device *dev,
>        * hiding the original data in the as-yet-unused DMA fields.
>        */
>       for_each_sg(sg, s, nents, i) {
> -        size_t s_offset = iova_offset(iovad, s->offset);
> +        size_t s_offset = s->offset;
>           size_t s_length = s->length;
>
>           sg_dma_address(s) = s_offset;
>           sg_dma_len(s) = s_length;
> +
> +        s_offset = iova_offset(iovad, s_offset);
>           s->offset -= s_offset;
>           s_length = iova_align(iovad, s_length + s_offset);
>           s->length = s_length;
> @@ -494,7 +496,7 @@ int iommu_dma_map_sg(struct device *dev,
>       if (iommu_map_sg(domain, dma_addr, sg, nents, prot) < iova_len)
>           goto out_free_iova;
>
> -    return __finalise_sg(dev, sg, nents, dma_addr);
> +    return __finalise_sg(dev, sg, nents, dma_addr, iovad);
>
>   out_free_iova:
>       __free_iova(iovad, iova);
>
