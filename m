From: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v2] iommu/io-pgtable-arm: Don't use dma_to_phys()
Date: Tue, 22 Sep 2015 21:25:08 +0800
Message-ID: <1442928308.17514.3.camel@mhfsdcap03>
References: <59f4ebbf06e75a6176a366495211afd16d0048a3.1442507940.git.robin.murphy@arm.com>
	<1442566550.8145.156.camel@mhfsdcap03> <55FBEFBA.6000606@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <55FBEFBA.6000606-5wv7dgnIgG8@public.gmane.org>
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
Cc: Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, 2015-09-18 at 12:04 +0100, Robin Murphy wrote:
> On 18/09/15 09:55, Yong Wu wrote:
> > On Thu, 2015-09-17 at 17:42 +0100, Robin Murphy wrote:
> [...]
> >> the appropriate course of action. Further care (and ugliness) is also
> >> necessary in the comparison to avoid truncation if phys_addr_t and
> >> dma_addr_t differ in size.
> [...]
> >>   		/*
> >>   		 * We depend on the IOMMU being able to work with any physical
> >> -		 * address directly, so if the DMA layer suggests it can't by
> >> -		 * giving us back some translation, that bodes very badly...
> >> +		 * address directly, so if the DMA layer suggests otherwise by
> >> +		 * translating or truncating them, that bodes very badly...
> >>   		 */
> >> -		if (dma != __arm_lpae_dma_addr(dev, pages))
> >> +		if (dma != virt_to_phys(pages))
> >
> > Could I ask why not use __arm_lpae_dma_addr(pages) here?
> > dma is dma_addr_t.
> 
> Specifically, the problem case for that is when phys_addr_t is 64-bit 
> but dma_addr_t is 32-bit. The cast in __arm_lpae_dma_addr is necessary 
> to avoid a truncation warning when we make the DMA API calls, but we 
> actually need the opposite in the comparison here - comparing the 
> different types directly allows integer promotion to kick in 
> appropriately so we don't lose the top half of the larger address. 
> Otherwise, you'd never spot the difference between, say, your original 
> page at 0x88c0000000 and a bounce-buffered copy that happened to end up 
> mapped to 0xc0000000.

Thanks.

About here:
> @@ -629,6 +626,11 @@ arm_lpae_alloc_pgtable(struct io_pgtable_cfg
*cfg)
>       if (cfg->oas > ARM_LPAE_MAX_ADDR_BITS)
>               return NULL;
>  
> +     if (cfg->iommu_dev->dma_pfn_offset) {

Do we need change to :
	if (!selftest_running && cfg->iommu_dev->dma_pfn_offset) {

cfg->iommu_dev will be null while self test.

> +             dev_err(cfg->iommu_dev, "Cannot accommodate DMA offset
for IOMMU page tables\n");
> +             return NULL;
> +     }
> +
>       data = kmalloc(sizeof(*data), GFP_KERNEL);
>       if (!data)
>               return NULL;

> 
> Robin.
> 
