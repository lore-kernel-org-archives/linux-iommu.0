From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v4 2/2] drm/nouveau: tegra: Detach from ARM DMA/IOMMU
	mapping
Date: Thu, 31 May 2018 18:56:53 +0100
Message-ID: <412f15b5-6beb-3980-1ea4-7a9719786006@arm.com>
References: <20180530140625.21247-1-thierry.reding@gmail.com>
	<20180530140625.21247-3-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180530140625.21247-3-thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Content-Language: en-GB
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ben Skeggs <bskeggs-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Christoph Hellwig <hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>
Cc: nouveau-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 30/05/18 15:06, Thierry Reding wrote:
> From: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> 
> Depending on the kernel configuration, early ARM architecture setup code
> may have attached the GPU to a DMA/IOMMU mapping that transparently uses
> the IOMMU to back the DMA API. Tegra requires special handling for IOMMU
> backed buffers (a special bit in the GPU's MMU page tables indicates the
> memory path to take: via the SMMU or directly to the memory controller).
> Transparently backing DMA memory with an IOMMU prevents Nouveau from
> properly handling such memory accesses and causes memory access faults.
> 
> As a side-note: buffers other than those allocated in instance memory
> don't need to be physically contiguous from the GPU's perspective since
> the GPU can map them into contiguous buffers using its own MMU. Mapping
> these buffers through the IOMMU is unnecessary and will even lead to
> performance degradation because of the additional translation. One
> exception to this are compressible buffers which need large pages. In
> order to enable these large pages, multiple small pages will have to be
> combined into one large (I/O virtually contiguous) mapping via the
> IOMMU. However, that is a topic outside the scope of this fix and isn't
> currently supported. An implementation will want to explicitly create
> these large pages in the Nouveau driver, so detaching from a DMA/IOMMU
> mapping would still be required.
> 
> Signed-off-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
> Changes in v4:
> - use existing APIs to detach from a DMA/IOMMU mapping
> 
> Changes in v3:
> - clarify the use of IOMMU mapping for compressible buffers
> - squash multiple patches into this
> 
>   drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c b/drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c
> index 78597da6313a..0e372a190d3f 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c
> @@ -23,6 +23,10 @@
>   #ifdef CONFIG_NOUVEAU_PLATFORM_DRIVER
>   #include "priv.h"
>   
> +#if IS_ENABLED(CONFIG_ARM_DMA_USE_IOMMU)
> +#include <asm/dma-iommu.h>
> +#endif
> +
>   static int
>   nvkm_device_tegra_power_up(struct nvkm_device_tegra *tdev)
>   {
> @@ -105,6 +109,15 @@ nvkm_device_tegra_probe_iommu(struct nvkm_device_tegra *tdev)
>   	unsigned long pgsize_bitmap;
>   	int ret;
>   
> +#if IS_ENABLED(CONFIG_ARM_DMA_USE_IOMMU)
> +	if (dev->archdata.mapping) {
> +		struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);

Nit: there's arguably little point using the helper here after you've 
already shattered the illusion by poking dev->archdata.mapping directly, 
but I guess this disappears again anyway once the refcounting gets 
sorted out and the mapping releases itself properly, so:

Reviewed-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>

> +
> +		arm_iommu_detach_device(dev);
> +		arm_iommu_release_mapping(mapping);
> +	}
> +#endif
> +
>   	if (!tdev->func->iommu_bit)
>   		return;
>   
> 
