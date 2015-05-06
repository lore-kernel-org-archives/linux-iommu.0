From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v6 01/25] arm: dma-mapping: add support for creating reserved
 mappings in iova space
Date: Wed, 06 May 2015 15:01:00 +0100
Message-ID: <554A1E9C.7060101@arm.com>
References: <1430727380-10912-1-git-send-email-m.szyprowski@samsung.com> <1430727380-10912-2-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: 8BIT
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1430727380-10912-2-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: Rob Herring <robh@kernel.org>, Thierry Reding <treding@nvidia.com>, Shaik Ameer Basha <shaik.ameer@samsung.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Inki Dae <inki.dae@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>, Will Deacon <Will.Deacon@arm.com>, Tomasz Figa <tomasz.figa@gmail.com>, "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>, Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Javier Martinez Canillas <javier@dowhile0.org>, Cho KyongHo <pullip.cho@samsung.com>, David Wodhouse <dwmw2@infradead.org>
List-Id: iommu@lists.linux-foundation.org

Hi Marek,

On 04/05/15 09:15, Marek Szyprowski wrote:
> Some devices (like frame buffers) are enabled by bootloader and configured
> to perform DMA operations automatically (like displaying boot logo or splash
> screen). Such devices operate and perform DMA operation usually until the
> proper driver for them is loaded and probed. However before that happens,
> system usually loads IOMMU drivers and configures dma parameters for each
> device. When such initial configuration is created and enabled, it usually
> contains empty translation rules betweem IO address space and physical
> memory, because no buffers nor memory regions have been requested by the
> respective driver.
>
> This patch adds support for "iommu-reserved-mapping", which can be used
> to provide definitions for mappings that need to be created on system
> boot to let such devices (enabled by bootloader) to operate properly
> until respective driver is probed.

This appears to only work if you assume the driver is going to tear down 
the existing domain entirely; what about drivers that don't manage 
IOMMUs explicitly, or if there are multiple active devices behind the 
same IOMMU which (in future) start out in the same default domain? If 
any device is happy to remain in the default domain then it would be 
nice to clear the reservations once they are no longer needed.

Could we not address the issue in a more robust way, like fleshing out 
an implementation of the nascent IOMMU_DOMAIN_IDENTITY type, then just 
flagging such devices to stipulate that their boot-time default domain 
must be an identity-mapped one?

> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>   Documentation/devicetree/bindings/iommu/iommu.txt |  44 +++++++++
>   arch/arm/mm/dma-mapping.c                         | 112 ++++++++++++++++++++++
>   2 files changed, 156 insertions(+)
>
[...]
> @@ -2048,6 +2092,66 @@ void arm_iommu_detach_device(struct device *dev)
>   }
>   EXPORT_SYMBOL_GPL(arm_iommu_detach_device);
>
> +static int arm_iommu_add_reserved(struct device *dev,
> +                       struct dma_iommu_mapping *domain, phys_addr_t phys,
> +                       dma_addr_t dma, size_t size)
> +{
> +       int ret;
> +
> +       ret = __reserve_iova(domain, dma, size);
> +       if (ret) {
> +               dev_err(dev, "failed to reserve mapping\n");
> +               return -EINVAL;
> +       }
> +
> +       ret = iommu_map(domain->domain, dma, phys, size, IOMMU_READ);
> +       if (ret != 0) {
> +               dev_err(dev, "create IOMMU mapping\n");
> +               return ret;
> +       }
> +
> +       dev_info(dev, "created reserved DMA mapping (%pa -> %pad, %zu bytes)\n",
> +                &phys, &dma, size);
> +
> +       return 0;
> +}
> +
> +static int arm_iommu_init_reserved(struct device *dev,
> +                                  struct dma_iommu_mapping *domain)
> +{
> +       const char *name = "iommu-reserved-mapping";
> +       const __be32 *prop = NULL;
> +       int len, naddr, nsize;
> +       struct device_node *node = dev->of_node;
> +       phys_addr_t phys;
> +       dma_addr_t dma;
> +       size_t size;
> +
> +       if (!node)
> +               return 0;
> +
> +       naddr = of_n_addr_cells(node);
> +       nsize = of_n_size_cells(node);
> +
> +       prop = of_get_property(node, name, &len);
> +       if (!prop)
> +               return 0;
> +
> +       len /= sizeof(u32);
> +
> +       if (len < 2 * naddr + nsize) {
> +               dev_err(dev, "invalid length (%d cells) of %s property\n",
> +                       len, name);
> +               return -EINVAL;
> +       }
> +
> +       phys = of_read_number(prop, naddr);
> +       dma = of_read_number(prop + naddr, naddr);
> +       size = of_read_number(prop + 2*naddr, nsize);
> +
> +       return arm_iommu_add_reserved(dev, domain, phys, dma, size);
 > +}

I may be missing something, but I don't see how this can handle multiple 
ranges for the same device as the binding says.

>   static struct dma_map_ops *arm_get_iommu_dma_map_ops(bool coherent)
>   {
>          return coherent ? &iommu_coherent_ops : &iommu_ops;
> @@ -2068,6 +2172,14 @@ static bool arm_setup_iommu_dma_ops(struct device *dev, u64 dma_base, u64 size,
>                  return false;
>          }
>
> +       if (arm_iommu_init_reserved(dev, mapping) != 0) {
> +               pr_warn("Failed to initialize reserved mapping for device %s\n",
> +                       dev_name(dev));
> +               __arm_iommu_detach_device(dev);
> +               arm_iommu_release_mapping(mapping);
> +               return false;
> +       }
> +
>          if (__arm_iommu_attach_device(dev, mapping)) {
>                  pr_warn("Failed to attached device %s to IOMMU_mapping\n",
>                                  dev_name(dev));

I'm hoping Joerg is still working on his default domain series, because 
the domain creation in arch_setup_dma_ops turns out to be horrible on a 
number of levels (like everything happening in the wrong order for 
platform devices). If that doesn't negate this issue entirely, it's 
going to significantly break this way of hooking up the solution 
(depending on what the drivers do) - worth some consideration, at least.

Robin.
