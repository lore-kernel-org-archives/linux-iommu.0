From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [RFC PATCH v4 8/8] arm: dma-mapping: plumb our iommu mapping
 ops into arch_setup_dma_ops
Date: Mon, 17 Nov 2014 11:29:23 +0000
Message-ID: <5469DC13.6040700@arm.com>
References: <1415991397-9618-1-git-send-email-will.deacon@arm.com>
 <1415991397-9618-9-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1415991397-9618-9-git-send-email-will.deacon@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Will Deacon <will.deacon@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Cc: "jroedel@suse.de" <jroedel@suse.de>, "arnd@arndb.de" <arnd@arndb.de>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "laurent.pinchart@ideasonboard.com" <laurent.pinchart@ideasonboard.com>, "Varun.Sethi@freescale.com" <Varun.Sethi@freescale.com>, "hdoyu@nvidia.com" <hdoyu@nvidia.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>, "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>
List-Id: iommu@lists.linux-foundation.org

Hi Will,

On 14/11/14 18:56, Will Deacon wrote:
> This patch plumbs the existing ARM IOMMU DMA infrastructure (which isn't
> actually called outside of a few drivers) into arch_setup_dma_ops, so
> that we can use IOMMUs for DMA transfers in a more generic fashion.
>
> Since this significantly complicates the arch_setup_dma_ops function,
> it is moved out of line into dma-mapping.c. If CONFIG_ARM_DMA_USE_IOMMU
> is not set, the iommu parameter is ignored and the normal ops are used
> instead.
>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

[...]

> +static bool arm_setup_iommu_dma_ops(struct device *dev, u64 dma_base, u64 size,
> +				    struct iommu_ops *iommu)
> +{
> +	struct dma_iommu_mapping *mapping;
> +
> +	mapping = arm_iommu_create_mapping(dev->bus, dma_base, size);
> +	if (IS_ERR(mapping)) {
> +		pr_warn("Failed to create %llu-byte IOMMU mapping for device %s\n",
> +				size, dev_name(dev));
> +		return false;
> +	}
> +
> +	if (arm_iommu_attach_device(dev, mapping)) {
> +		pr_warn("Failed to attached device %s to IOMMU_mapping\n",
> +				dev_name(dev));
> +		arm_iommu_release_mapping(mapping);
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
> +static void arm_teardown_iommu_dma_ops(struct device *dev)
> +{
> +	struct dma_iommu_mapping *mapping = dev->archdata.mapping;
> +
> +	arm_iommu_detach_device(dev);
> +	arm_iommu_release_mapping(mapping);
> +}
> +
> +#else
> +
> +static bool arm_setup_iommu_dma_ops(struct device *dev, u64 dma_base, u64 size,
> +				    struct iommu_ops *iommu)
> +{
> +	return false;
> +}
> +
> +static void arm_teardown_iommu_dma_ops(struct device *dev) { }
> +
> +#define arm_get_iommu_dma_map_ops arm_get_dma_map_ops
> +
> +#endif	/* CONFIG_ARM_DMA_USE_IOMMU */
> +
> +static struct dma_map_ops *arm_get_dma_map_ops(bool coherent)
> +{
> +	return coherent ? &arm_coherent_dma_ops : &arm_dma_ops;
> +}
> +
> +void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
> +			struct iommu_ops *iommu, bool coherent)
> +{
> +	struct dma_map_ops *dma_ops;
> +
> +	if (arm_setup_iommu_dma_ops(dev, dma_base, size, iommu))

Is the loss of a null check on iommu (compared to previous versions) 
intentional? It looks like you're always going to call 
arm_setup_iommu_dma_ops here for everything regardless, and given that 
that doesn't even look at the iommu parameter, relying on it to somehow 
fail correctly smells a bit off.


Robin.

> +		dma_ops = arm_get_iommu_dma_map_ops(coherent);
> +	else
> +		dma_ops = arm_get_dma_map_ops(coherent);
> +
> +	set_dma_ops(dev, dma_ops);
> +}
> +
> +void arch_teardown_dma_ops(struct device *dev)
> +{
> +	arm_teardown_iommu_dma_ops(dev);
> +}
>
