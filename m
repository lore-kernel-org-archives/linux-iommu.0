From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] ARM: dma-mapping: Don't tear third-party mappings
Date: Tue, 16 May 2017 16:47:36 +0100
Message-ID: <2602abb1-e777-700c-bc95-14e576372537@arm.com>
References: <6d9fa319-4401-c47a-7985-9a349838bcaf@arm.com>
	<20170516151434.18830-1-laurent.pinchart+renesas@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170516151434.18830-1-laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 16/05/17 16:14, Laurent Pinchart wrote:
> arch_setup_dma_ops() is used in device probe code paths to create an
> IOMMU mapping and attach it to the device. The function assumes that the
> device is attached to a device-specific IOMMU instance (or at least a
> device-specific TLB in a shared IOMMU instance) and thus creates a
> separate mapping for every device.
> 
> On several systems (Renesas R-Car Gen2 being one of them), that
> assumption is not true, and IOMMU mappings must be shared between
> multiple devices. In those cases the IOMMU driver knows better than the
> generic ARM dma-mapping layer and attaches mapping to devices manually
> with arm_iommu_attach_device(), which sets the DMA ops for the device.
> 
> The arch_setup_dma_ops() function takes this into account and bails out
> immediately if the device already has DMA ops assigned. However, the
> corresponding arch_teardown_dma_ops() function, called from driver
> unbind code paths (including probe deferral), will tear the mapping down
> regardless of who created it. When the device is reprobed
> arch_setup_dma_ops() will be called again but won't perform any
> operation as the DMA ops will still be set.
> 
> We need to reset the DMA ops in arch_teardown_dma_ops() to fix this.
> However, we can't do so unconditionally, as then a new mapping would be
> created by arch_setup_dma_ops() when the device is reprobed, regardless
> of whether the device needs to share a mapping or not. We must thus keep
> track of whether arch_setup_dma_ops() created the mapping, and only in
> that case tear it down in arch_teardown_dma_ops().
> 
> Keep track of that information in the dev_archdata structure. As the
> structure is embedded in all instances of struct device let's not grow
> it, but turn the existing dma_coherent bool field into a bitfield that
> can be used for other purposes.
> 
> Fixes: 7b07cbefb68d ("iommu: of: Handle IOMMU lookup failure with deferred probing or error")
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
> ---
>  arch/arm/include/asm/device.h | 3 ++-
>  arch/arm/mm/dma-mapping.c     | 5 +++++
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/include/asm/device.h b/arch/arm/include/asm/device.h
> index 36ec9c8f6e16..3234fe9bba6e 100644
> --- a/arch/arm/include/asm/device.h
> +++ b/arch/arm/include/asm/device.h
> @@ -19,7 +19,8 @@ struct dev_archdata {
>  #ifdef CONFIG_XEN
>  	const struct dma_map_ops *dev_dma_ops;
>  #endif
> -	bool dma_coherent;
> +	unsigned int dma_coherent:1;

This should only ever be accessed by the Xen DMA code via the
is_device_dma_coherent() helper, so I can't see the change of storage
type causing any problems.

> +	unsigned int dma_ops_setup:1;
>  };
>  
>  struct omap_device;
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index c742dfd2967b..e0272f9140e2 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -2430,9 +2430,14 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
>  		dev->dma_ops = xen_dma_ops;
>  	}
>  #endif
> +	dev->archdata.dma_ops_setup = true;
>  }
>  
>  void arch_teardown_dma_ops(struct device *dev)
>  {
> +	if (!dev->archdata.dma_ops_setup)
> +		return;
> +
>  	arm_teardown_iommu_dma_ops(dev);
> +	set_dma_ops(dev, NULL);

Should we clear dma_ops_setup here for symmetry? I guess in practice
it's down to the IOMMU driver so will never change after the first
probe, but it still feels like a bit of a nagging loose end.

With that (or firm reassurance that it's OK not to),

Reviewed-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>

Apologies for being too arm64-focused in the earlier reviews and
overlooking this. Should the patch supersede 8674/1 currently in
Russell's incoming box?

Robin.

>  }
> 
