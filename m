From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RFC PATCH v4 8/8] arm: dma-mapping: plumb our iommu mapping ops
	into arch_setup_dma_ops
Date: Mon, 17 Nov 2014 11:41:36 +0000
Message-ID: <20141117114135.GI18061@arm.com>
References: <1415991397-9618-1-git-send-email-will.deacon@arm.com>
	<1415991397-9618-9-git-send-email-will.deacon@arm.com>
	<5469DC13.6040700@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5469DC13.6040700-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <Robin.Murphy-5wv7dgnIgG8@public.gmane.org>
Cc: "jroedel-l3A5Bk7waGM@public.gmane.org" <jroedel-l3A5Bk7waGM@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org" <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Nov 17, 2014 at 11:29:23AM +0000, Robin Murphy wrote:
> On 14/11/14 18:56, Will Deacon wrote:
> > This patch plumbs the existing ARM IOMMU DMA infrastructure (which isn't
> > actually called outside of a few drivers) into arch_setup_dma_ops, so
> > that we can use IOMMUs for DMA transfers in a more generic fashion.
> >
> > Since this significantly complicates the arch_setup_dma_ops function,
> > it is moved out of line into dma-mapping.c. If CONFIG_ARM_DMA_USE_IOMMU
> > is not set, the iommu parameter is ignored and the normal ops are used
> > instead.
> >
> > Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
> 
> [...]
> 
> > +static bool arm_setup_iommu_dma_ops(struct device *dev, u64 dma_base, u64 size,
> > +				    struct iommu_ops *iommu)
> > +{
> > +	struct dma_iommu_mapping *mapping;
> > +
> > +	mapping = arm_iommu_create_mapping(dev->bus, dma_base, size);
> > +	if (IS_ERR(mapping)) {
> > +		pr_warn("Failed to create %llu-byte IOMMU mapping for device %s\n",
> > +				size, dev_name(dev));
> > +		return false;
> > +	}
> > +
> > +	if (arm_iommu_attach_device(dev, mapping)) {
> > +		pr_warn("Failed to attached device %s to IOMMU_mapping\n",
> > +				dev_name(dev));
> > +		arm_iommu_release_mapping(mapping);
> > +		return false;
> > +	}
> > +
> > +	return true;
> > +}
> > +
> > +static void arm_teardown_iommu_dma_ops(struct device *dev)
> > +{
> > +	struct dma_iommu_mapping *mapping = dev->archdata.mapping;
> > +
> > +	arm_iommu_detach_device(dev);
> > +	arm_iommu_release_mapping(mapping);
> > +}
> > +
> > +#else
> > +
> > +static bool arm_setup_iommu_dma_ops(struct device *dev, u64 dma_base, u64 size,
> > +				    struct iommu_ops *iommu)
> > +{
> > +	return false;
> > +}
> > +
> > +static void arm_teardown_iommu_dma_ops(struct device *dev) { }
> > +
> > +#define arm_get_iommu_dma_map_ops arm_get_dma_map_ops
> > +
> > +#endif	/* CONFIG_ARM_DMA_USE_IOMMU */
> > +
> > +static struct dma_map_ops *arm_get_dma_map_ops(bool coherent)
> > +{
> > +	return coherent ? &arm_coherent_dma_ops : &arm_dma_ops;
> > +}
> > +
> > +void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
> > +			struct iommu_ops *iommu, bool coherent)
> > +{
> > +	struct dma_map_ops *dma_ops;
> > +
> > +	if (arm_setup_iommu_dma_ops(dev, dma_base, size, iommu))
> 
> Is the loss of a null check on iommu (compared to previous versions) 
> intentional? It looks like you're always going to call 
> arm_setup_iommu_dma_ops here for everything regardless, and given that 
> that doesn't even look at the iommu parameter, relying on it to somehow 
> fail correctly smells a bit off.

Thanks, I'll fix that. I started writing a full implementation based off
a hypothetical ->get_default_domain callback (as suggested by Joerg), so
this is a hangover from that experiment.

Will
