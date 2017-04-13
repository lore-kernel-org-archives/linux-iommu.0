From: Nate Watterson <nwatters-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH] iommu/dma: Setup iova_domain granule for IOMMU_DMA_MSI
	cookies
Date: Thu, 13 Apr 2017 15:38:51 -0400
Message-ID: <95dfaf27-9a74-7a6c-fa77-0fcfe1edbe6e@codeaurora.org>
References: <1492073715-7811-1-git-send-email-nwatters@codeaurora.org>
	<90fe2111-42e5-ecb1-d0bd-10e06883ae5d@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <90fe2111-42e5-ecb1-d0bd-10e06883ae5d-5wv7dgnIgG8@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: shankerd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Robin,

On 4/13/2017 7:21 AM, Robin Murphy wrote:
> Hi Nate,
> 
> On 13/04/17 09:55, Nate Watterson wrote:
>> Currently, the __iommu_dma_{map/free} functions call iova_{offset/align}
>> making them unsuitable for use with iommu_domains having an IOMMU_DMA_MSI
>> cookie since the cookie's iova_domain member, iovad, is uninitialized.
>>
>> Now that iommu_dma_get_msi_page() calls __iommu_dma_map() regardless
>> of cookie type, failures are being seen when mapping MSI target
>> addresses for devices attached to UNMANAGED domains. To work around
>> this issue, the iova_domain granule for IOMMU_DMA_MSI cookies is
>> initialized to the value returned by cookie_msi_granule().
> 
> Oh bum. Thanks for the report.
> 
> However, I really don't like bodging around it with deliberate undefined
> behaviour. Fixing things properly doesn't seem too hard:

I was not especially please with my solution, but I wanted to avoid
potentially missing any other spots in the code where granule was
used uninitialized. The compile time check made me feel a little
less dirty about innappropriately using the iova_domain with MSI
cookies.

> 
> ----->8-----
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 8348f366ddd1..62618e77bedc 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -396,13 +396,13 @@ static void iommu_dma_free_iova(struct
> iommu_dma_cookie *cookie,
>                  dma_addr_t iova, size_t size)
>   {
>          struct iova_domain *iovad = &cookie->iovad;
> -       unsigned long shift = iova_shift(iovad);
> 
>          /* The MSI case is only ever cleaning up its most recent
> allocation */
>          if (cookie->type == IOMMU_DMA_MSI_COOKIE)
>                  cookie->msi_iova -= size;
>          else
> -               free_iova_fast(iovad, iova >> shift, size >> shift);
> +               free_iova_fast(iovad, iova_pfn(iovad, iova),
> +                               size >> iova_shift(iovad));
>   }
> 
>   static void __iommu_dma_unmap(struct iommu_domain *domain, dma_addr_t
> dma_addr,
> @@ -617,11 +617,14 @@ static dma_addr_t __iommu_dma_map(struct device
> *dev, phys_addr_t phys,
>   {
>          struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
>          struct iommu_dma_cookie *cookie = domain->iova_cookie;
> -       struct iova_domain *iovad = &cookie->iovad;
> -       size_t iova_off = iova_offset(iovad, phys);
> +       size_t iova_off = 0;
>          dma_addr_t iova;
> 
> -       size = iova_align(iovad, size + iova_off);
> +       if (cookie->type == IOMMU_DMA_IOVA_COOKIE) {
> +               iova_off = iova_offset(&cookie->iovad, phys);
> +               size = iova_align(&cookie->iovad, size + iova_off);
> +       }
> +
>          iova = iommu_dma_alloc_iova(domain, size, dma_get_mask(dev), dev);
>          if (!iova)
>                  return DMA_ERROR_CODE;
> -----8<-----
> 
> Untested, and you'll probably want to double-check it anyway given that
> the original oversight was mine in the first place ;)

This looks good to me. As Shanker has already mentioned, it does fix the
faults we were previously seeing with direct device assignment. I also
verified that there aren't any other obvious cases of a granule == 0
being used in the dma_iommu code by adding BUG_ON(!iovad->granule) to
iova_{mask/align/offset/...} and running a variety of tests without
issue.

Are you going to post the patch?

> 
> Robin.
> 
>> Fixes: a44e6657585b ("iommu/dma: Clean up MSI IOVA allocation")
>> Signed-off-by: Nate Watterson <nwatters-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>> ---
>>   drivers/iommu/dma-iommu.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>> index 8348f366..d7b0816 100644
>> --- a/drivers/iommu/dma-iommu.c
>> +++ b/drivers/iommu/dma-iommu.c
>> @@ -127,6 +127,16 @@ int iommu_get_msi_cookie(struct iommu_domain *domain, dma_addr_t base)
>>   
>>   	cookie->msi_iova = base;
>>   	domain->iova_cookie = cookie;
>> +
>> +	/*
>> +	 * Setup granule for compatibility with __iommu_dma_{alloc/free} and
>> +	 * add a compile time check to ensure that writing granule won't
>> +	 * clobber msi_iova.
>> +	 */
>> +	cookie->iovad.granule = cookie_msi_granule(cookie);
>> +	BUILD_BUG_ON(offsetof(struct iova_domain, granule) <
>> +			sizeof(cookie->msi_iova));
>> +
>>   	return 0;
>>   }
>>   EXPORT_SYMBOL(iommu_get_msi_cookie);
>>
> 
-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
