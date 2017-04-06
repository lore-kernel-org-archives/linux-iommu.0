From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RESEND,3/3] iommu/dma: Plumb in the per-CPU IOVA caches
Date: Thu, 6 Apr 2017 19:56:16 +0100
Message-ID: <c43b1f8f-02fd-978c-0dee-cc3f76a9924b@arm.com>
References: <fcb9121e608da4f62e21538f558710fbb12d4a69.1490971180.git.robin.murphy@arm.com>
	<alpine.DEB.2.20.1704061315040.4602@lazy>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <alpine.DEB.2.20.1704061315040.4602@lazy>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Manoj Iyer <manoj.iyer-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 06/04/17 19:15, Manoj Iyer wrote:
> On Fri, 31 Mar 2017, Robin Murphy wrote:
> 
>> With IOVA allocation suitably tidied up, we are finally free to opt in
>> to the per-CPU caching mechanism. The caching alone can provide a modest
>> improvement over walking the rbtree for weedier systems (iperf3 shows
>> ~10% more ethernet throughput on an ARM Juno r1 constrained to a single
>> 650MHz Cortex-A53), but the real gain will be in sidestepping the rbtree
>> lock contention which larger ARM-based systems with lots of parallel I/O
>> are starting to feel the pain of.
>>
>> Reviewed-by: Nate Watterson <nwatters-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>> Tested-by: Nate Watterson <nwatters-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
>> ---
>> drivers/iommu/dma-iommu.c | 39 ++++++++++++++++++---------------------
>> 1 file changed, 18 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>> index 1b94beb43036..8348f366ddd1 100644
>> --- a/drivers/iommu/dma-iommu.c
>> +++ b/drivers/iommu/dma-iommu.c
>> @@ -361,8 +361,7 @@ static dma_addr_t iommu_dma_alloc_iova(struct
>> iommu_domain *domain,
>> {
>>     struct iommu_dma_cookie *cookie = domain->iova_cookie;
>>     struct iova_domain *iovad = &cookie->iovad;
>> -    unsigned long shift, iova_len;
>> -    struct iova *iova = NULL;
>> +    unsigned long shift, iova_len, iova = 0;
>>
>>     if (cookie->type == IOMMU_DMA_MSI_COOKIE) {
>>         cookie->msi_iova += size;
>> @@ -371,41 +370,39 @@ static dma_addr_t iommu_dma_alloc_iova(struct
>> iommu_domain *domain,
>>
>>     shift = iova_shift(iovad);
>>     iova_len = size >> shift;
>> +    /*
>> +     * Freeing non-power-of-two-sized allocations back into the IOVA
>> caches
>> +     * will come back to bite us badly, so we have to waste a bit of
>> space
>> +     * rounding up anything cacheable to make sure that can't happen.
>> The
>> +     * order of the unadjusted size will still match upon freeing.
>> +     */
>> +    if (iova_len < (1 << (IOVA_RANGE_CACHE_MAX_SIZE - 1)))
>> +        iova_len = roundup_pow_of_two(iova_len);
>>
>>     if (domain->geometry.force_aperture)
>>         dma_limit = min(dma_limit, domain->geometry.aperture_end);
>>
>>     /* Try to get PCI devices a SAC address */
>>     if (dma_limit > DMA_BIT_MASK(32) && dev_is_pci(dev))
>> -        iova = alloc_iova(iovad, iova_len, DMA_BIT_MASK(32) >> shift,
>> -                  true);
>> -    /*
>> -     * Enforce size-alignment to be safe - there could perhaps be an
>> -     * attribute to control this per-device, or at least per-domain...
>> -     */
>> -    if (!iova)
>> -        iova = alloc_iova(iovad, iova_len, dma_limit >> shift, true);
>> +        iova = alloc_iova_fast(iovad, iova_len, DMA_BIT_MASK(32) >>
>> shift);
>>
>> -    return (dma_addr_t)iova->pfn_lo << shift;
>> +    if (!iova)
>> +        iova = alloc_iova_fast(iovad, iova_len, dma_limit >> shift);
>> +
>> +    return (dma_addr_t)iova << shift;
>> }
>>
>> static void iommu_dma_free_iova(struct iommu_dma_cookie *cookie,
>>         dma_addr_t iova, size_t size)
>> {
>>     struct iova_domain *iovad = &cookie->iovad;
>> -    struct iova *iova_rbnode;
>> +    unsigned long shift = iova_shift(iovad);
>>
>>     /* The MSI case is only ever cleaning up its most recent
>> allocation */
>> -    if (cookie->type == IOMMU_DMA_MSI_COOKIE) {
>> +    if (cookie->type == IOMMU_DMA_MSI_COOKIE)
>>         cookie->msi_iova -= size;
>> -        return;
>> -    }
>> -
>> -    iova_rbnode = find_iova(iovad, iova_pfn(iovad, iova));
>> -    if (WARN_ON(!iova_rbnode))
>> -        return;
>> -
>> -    __free_iova(iovad, iova_rbnode);
>> +    else
>> +        free_iova_fast(iovad, iova >> shift, size >> shift);
>> }
>>
>> static void __iommu_dma_unmap(struct iommu_domain *domain, dma_addr_t
>> dma_addr,
>>
> 
> This patch series helps to resolve the Ubuntu bug, where we see the
> Ubuntu Zesty (4.10 based) kernel reporting multi cpu soft lockups on
> QDF2400 SDP. https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1680549

Wow, how many separate buffers does that driver have mapped at once to
spend 22 seconds walking the rbtree for a single allocation!? I'd almost
expect that to indicate a deadlock.

I'm guessing you wouldn't have seen this on older kernels, since I
assume that particular platform is booting via ACPI, so wouldn't have
had the SMMU enabled without the IORT support which landed in 4.10.

> This patch series along with the following cherry-picks from Linus's tree
> dddd632b072f iommu/dma: Implement PCI allocation optimisation
> de84f5f049d9 iommu/dma: Stop getting dma_32bit_pfn wrong
> 
> were applied to Ubuntu Zesty 4.10 kernel (Ubuntu-4.10.0-18.20) and
> tested on a QDF2400 SDP.
> 
> Tested-by: Manoj Iyer <manoj.iyer-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>

Thanks,
Robin.

> 
> 
> -- 
> ============================
> Manoj Iyer
> Ubuntu/Canonical
> ARM Servers - Cloud
> ============================
