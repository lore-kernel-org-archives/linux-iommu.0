From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] iommu/arm-smmu: fix leak in arm_smmu_flush_pgtable
Date: Thu, 05 Mar 2015 10:38:45 +0000
Message-ID: <54F83235.70700@arm.com>
References: <1425514685-23831-1-git-send-email-mitchelh@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1425514685-23831-1-git-send-email-mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Mitchel Humpherys <mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Mitch,

On 05/03/15 00:18, Mitchel Humpherys wrote:
> We're currently mapping a page in arm_smmu_flush_pgtable without ever
> unmapping it.  Fix this by calling dma_unmap_page on the returned dma
> address.  Since the only reason we're calling dma_map_page is to make
> sure it actually gets flushed out to RAM, we can just call
> dma_unmap_page immediately following the map.
>
> Without this, eventually swiotlb runs out of memory and starts printing
> things like:
>
>      [   35.545076] arm-smmu d00000.arm,smmu: swiotlb buffer is full (sz: 128 bytes)
>

So, you have non-coherent SMMUs too ;) The real problem is that the 
SMMU's DMA mask is wrong (as it happens I've just given Will a patch to 
fix that) - this is really just doing a whole bunch of unnecessary work 
(two memory copies and two cache flushes, one of which isn't even 
flushing the right area) to hide the problem. With an appropriate DMA 
mask set, swiotlb_map_page becomes a no-op and we fall through to the 
cache flush without ever allocating anything.

Robin.

> Signed-off-by: Mitchel Humpherys <mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> ---
>   drivers/iommu/arm-smmu.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index fc13dd56953e..2ff8f35cf533 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -627,8 +627,13 @@ static void arm_smmu_flush_pgtable(void *addr, size_t size, void *cookie)
>   		 * recursion here as the SMMU table walker will not be wired
>   		 * through another SMMU.
>   		 */
> -		dma_map_page(smmu->dev, virt_to_page(addr), offset, size,
> -			     DMA_TO_DEVICE);
> +		dma_addr_t handle = dma_map_page(smmu->dev, virt_to_page(addr),
> +						offset, size, DMA_TO_DEVICE);
> +		if (handle == DMA_ERROR_CODE)
> +			dev_err(smmu->dev,
> +				"Couldn't flush page tables at %p!\n", addr);
> +		else
> +			dma_unmap_page(smmu->dev, handle, size, DMA_TO_DEVICE);
>   	}
>   }
>
>
