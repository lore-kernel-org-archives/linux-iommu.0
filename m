From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 7/9] iommu/arm-smmu: Add function that conditionally
	isolates all masters of all SMMUs
Date: Fri, 27 Sep 2013 14:00:01 +0100
Message-ID: <20130927130001.GF9520@mudshark.cambridge.arm.com>
References: <1380234982-1677-1-git-send-email-andreas.herrmann@calxeda.com>
	<1380234982-1677-8-git-send-email-andreas.herrmann@calxeda.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1380234982-1677-8-git-send-email-andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Andreas,

On Thu, Sep 26, 2013 at 11:36:19PM +0100, Andreas Herrmann wrote:
> (Depending on DT information and module parameters) each device is put
> into its own protection domain (if possible).  For configuration with
> one or just a few masters per SMMU that is easy to achieve.
> 
> In case of many devices per SMMU (e.g. MMU-500 with it's distributed
> translation support) isolation of each device might not be possible --
> depending on number of available SMR groups and/or context banks.
> 
> Default is that device isolation is contolled per SMMU with SMMU node
> property "linux,arm-smmu-isolate-devices" in a DT. If the property is
> set for an SMMU node device isolation is performed.
> 
> Also introduce a module parameter:

Actually, I think I'd rather do away with the module paramater / command
line option altogether in favour of DT.

> +extern struct platform_device *of_find_device_by_node(struct device_node *np);
> +
> +static int arm_smmu_isolate_devices(void)
> +{
> +	struct dma_iommu_mapping *mapping;
> +	struct arm_smmu_device *smmu;
> +	struct rb_node *rbn;
> +	struct arm_smmu_master *master;
> +	struct platform_device *pdev;
> +	struct device *dev;
> +	void __iomem *gr0_base;
> +	u32 cr0;
> +	int ret = 0;
> +	size_t size;
> +
> +	list_for_each_entry(smmu, &arm_smmu_devices, list) {
> +		if (arm_smmu_disable_isolation ||
> +			(!(smmu->features & ARM_SMMU_FEAT_ISOLATE_DEVICES)
> +				&& !arm_smmu_force_isolation))
> +			continue;
> +		rbn = rb_first(&smmu->masters);
> +		while (rbn) {
> +			master = container_of(rbn, struct arm_smmu_master, node);
> +			pdev = of_find_device_by_node(master->of_node);
> +			if (!pdev)
> +				break;
> +			dev = &pdev->dev;
> +
> +			size = (size_t) dev->coherent_dma_mask;
> +			size = size ? : (unsigned long) dev->dma_mask;

Hmm, this could be *huge* with 64-bit capable DMA controllers (think LPAE).
Russell also has some pending dma mask cleanup, which might break some
assumptions here:

http://lists.infradead.org/pipermail/linux-arm-kernel/2013-September/199397.html

(namely that we're offsetting everything from zero).

Will
