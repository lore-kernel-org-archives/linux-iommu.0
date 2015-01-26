From: Joseph Lo <josephl-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC PATCH 4/5] arm64: add IOMMU dma_ops
Date: Mon, 26 Jan 2015 11:25:45 +0800
Message-ID: <54C5B3B9.1040300@nvidia.com>
References: <cover.1421086706.git.robin.murphy@arm.com>
	<aa7de3b1dd189c31eb8b14d0c0eea699183f8a2c.1421086706.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <aa7de3b1dd189c31eb8b14d0c0eea699183f8a2c.1421086706.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, stefano.stabellini-mvvWK6WmYclDPfheJLI6IQ@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 01/13/2015 04:48 AM, Robin Murphy wrote:
> Taking some inspiration from the arch/arm code, implement the
> arch-specific side of the DMA mapping ops using the new IOMMU-DMA layer.
>
> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> ---
>   arch/arm64/include/asm/device.h      |   3 +
>   arch/arm64/include/asm/dma-mapping.h |  12 ++
>   arch/arm64/mm/dma-mapping.c          | 297 +++++++++++++++++++++++++++++++++++
>   3 files changed, 312 insertions(+)
>
[snip]
> +static struct dma_map_ops iommu_dma_ops = {
> +	.alloc = __iommu_alloc_attrs,
> +	.free = __iommu_free_attrs,
> +	.mmap = __swiotlb_mmap,

Hi Robin,

Thanks for posting this series. I spent some time to re-write Tegra-smmu 
driver to work with the new DT-based iommu initialization procedure and 
do some modification in Tegra/DRM driver to make it work with 
IOMMU-backed DMA mapping API.

Found two issues, one is the mmap function here.
The mmap function is not reliable, the userspace application and kernel 
easily leads to crash after calling this. Can we mmap the CPU VA to the 
IOVA?
This issue was gone after replacing it with the same function 
(arm_iommu_mmap_attrs) in the ARM32 kernel. And everything just works fine.

> +	.map_page = __iommu_map_page,
> +	.unmap_page = __iommu_unmap_page,
> +	.map_sg = __iommu_map_sg_attrs,
> +	.unmap_sg = __iommu_unmap_sg_attrs,
> +	.sync_single_for_cpu = __iommu_sync_single_for_cpu,
> +	.sync_single_for_device = __iommu_sync_single_for_device,
> +	.sync_sg_for_cpu = __iommu_sync_sg_for_cpu,
> +	.sync_sg_for_device = __iommu_sync_sg_for_device,
> +	.dma_supported = iommu_dma_supported,
> +	.mapping_error = iommu_dma_mapping_error,
> +};
> +
> +static void __iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
> +				  struct iommu_ops *ops)
> +{
> +	struct iommu_dma_mapping *mapping;
> +
> +	if (!ops)
> +		return;
> +
> +	mapping = iommu_dma_create_mapping(ops, dma_base, size);

The other issue is here. We create a DMA range here, but the 
__iova_alloc not really working with that, if the end of the range was 
under 4G limitation. The allocation address always starts from 
0xfffxxxxx, because we set the .dma_mask to DMA_BIT_MASK(32) by default. 
If we don't expect that, we need one more function call like 
dma_coerce_mask_and_coherent(dev, 0x80000000) for the range of 0 to 2G 
for example.

Does this the expectation when we use this framework?

(Except the issue of __alloc_iova, I am ok with this. We could set up a 
default range from 0 to 4G for every device by default, and then isolate 
the virtual range by reset the .dma_mask of the device later.)

Thanks,
-Joseph

> +	if (!mapping) {
> +		pr_warn("Failed to create %llu-byte IOMMU mapping for device %s\n",
> +				size, dev_name(dev));
> +		return;
> +	}
> +
> +	if (iommu_dma_attach_device(dev, mapping))
> +		pr_warn("Failed to attach device %s to IOMMU mapping\n",
> +				dev_name(dev));
> +	else
> +		dev->archdata.dma_ops = &iommu_dma_ops;
> +
> +	/* drop the initial mapping refcount */
> +	iommu_dma_release_mapping(mapping);
> +}
> +
> +#else
> +
> +static void __iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
> +				  struct iommu_ops *iommu)
> +{ }
> +
> +#endif  /* CONFIG_IOMMU_DMA */
>
