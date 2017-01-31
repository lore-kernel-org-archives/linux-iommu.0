From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH v2 1/2] iommu/dma: Add support for
	DMA_ATTR_FORCE_CONTIGUOUS
Date: Tue, 31 Jan 2017 11:24:15 +0100
Message-ID: <CAMuHMdUDh0S=aWDXe=Sc0YJjC2DLNgTtr_m0REL=fiBQwgEpPw@mail.gmail.com>
References: <1485531259-17513-1-git-send-email-geert+renesas@glider.be>
	<1485531259-17513-2-git-send-email-geert+renesas@glider.be>
	<73d47a53-3146-6719-ec20-39a5633350fa@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <73d47a53-3146-6719-ec20-39a5633350fa-5wv7dgnIgG8@public.gmane.org>
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
Cc: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-Renesas <linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Robin,

On Fri, Jan 27, 2017 at 6:50 PM, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org> wrote:
> On 27/01/17 15:34, Geert Uytterhoeven wrote:
>> Add helpers for allocating physically contiguous DMA buffers to the
>> generic IOMMU DMA code.  This can be useful when two or more devices
>> with different memory requirements are involved in buffer sharing.
>>
>> The iommu_dma_{alloc,free}_contiguous() functions complement the existing
>> iommu_dma_{alloc,free}() functions, and allow architecture-specific code
>> to implement support for the DMA_ATTR_FORCE_CONTIGUOUS attribute on
>> systems with an IOMMU.  As this uses the CMA allocator, setting this
>> attribute has a runtime-dependency on CONFIG_DMA_CMA.
>>
>> Note that unlike the existing iommu_dma_alloc() helper,
>> iommu_dma_alloc_contiguous() has no callback to flush pages.
>> Ensuring the returned region is made visible to a non-coherent device is
>> the responsibility of the caller.
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
>> ---
>> v2:
>>   - Provide standalone iommu_dma_{alloc,free}_contiguous() functions, as
>>     requested by Robin Murphy,
>>   - Simplify operations by getting rid of the page array/scatterlist
>>     dance, as the buffer is contiguous,
>>   - Move CPU cache magement into the caller, which is much simpler with
>>     a single contiguous buffer.
>
> Thanks for the rework, that's a lot easier to make sense of! Now, please
> don't hate me, but...

I don't hate you at all. I'm just a drivers/iommu rookie ;-)

>> --- a/drivers/iommu/dma-iommu.c
>> +++ b/drivers/iommu/dma-iommu.c

>> +/**
>> + * iommu_dma_alloc_contiguous - Allocate and map a buffer contiguous in IOVA
>> + *                           and physical space
>> + * @dev: Device to allocate memory for. Must be a real device attached to an
>> + *    iommu_dma_domain
>> + * @size: Size of buffer in bytes
>> + * @prot: IOMMU mapping flags
>> + * @handle: Out argument for allocated DMA handle
>> + *
>> + * Return: Buffer page pointer, or NULL on failure.
>> + *
>> + * Note that unlike iommu_dma_alloc(), it's the caller's responsibility to
>> + * ensure the returned region is made visible to the given non-coherent device.
>> + */
>> +struct page *iommu_dma_alloc_contiguous(struct device *dev, size_t size,
>> +             int prot, dma_addr_t *handle)
>> +{
>> +     struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
>> +     struct iova_domain *iovad = cookie_iovad(domain);
>> +     dma_addr_t dma_addr;
>> +     unsigned int count;
>> +     struct page *page;
>> +     struct iova *iova;
>> +     int ret;
>> +
>> +     *handle = DMA_ERROR_CODE;
>> +
>> +     size = PAGE_ALIGN(size);
>> +     count = size >> PAGE_SHIFT;
>> +     page = dma_alloc_from_contiguous(dev, count, get_order(size));
>> +     if (!page)
>> +             return NULL;
>> +
>> +     iova = __alloc_iova(domain, size, dev->coherent_dma_mask);
>> +     if (!iova)
>> +             goto out_free_pages;
>> +
>> +     size = iova_align(iovad, size);
>> +     dma_addr = iova_dma_addr(iovad, iova);
>> +     ret = iommu_map(domain, dma_addr, page_to_phys(page), size, prot);
>> +     if (ret < 0)
>> +             goto out_free_iova;
>> +
>> +     *handle = dma_addr;
>> +     return page;
>> +
>> +out_free_iova:
>> +     __free_iova(iovad, iova);
>> +out_free_pages:
>> +     dma_release_from_contiguous(dev, page, count);
>> +     return NULL;
>> +}
>
> ...now that I can see it clearly, isn't this more or less just:
>
>         page = dma_alloc_from_contiguous(dev, ...);
>         if (page)
>                 dma_addr = iommu_dma_map_page(dev, page, ...);
> ?
>
> Would it not be even simpler to just make those two calls directly from
> the arm64 code?

You're right. Will update. Thanks a lot!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
