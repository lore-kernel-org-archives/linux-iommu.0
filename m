From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 8/9] iommu: add support for ARM Ltd. System MMU
	architecture
Date: Thu, 20 Jun 2013 23:26:46 +0200
Message-ID: <20130620212646.GG11309@8bytes.org>
References: <1370889285-22799-1-git-send-email-will.deacon@arm.com>
	<1370889285-22799-9-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1370889285-22799-9-git-send-email-will.deacon-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: Olav Haugan <ohaugan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Will,

On Mon, Jun 10, 2013 at 07:34:44PM +0100, Will Deacon wrote:
> This patch adds support for SMMUs implementing the ARM System MMU
> architecture versions 1 or 2. Both arm and arm64 are supported, although
> the v7s descriptor format is not used.
> 
> Cc: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
> Cc: Olav Haugan <ohaugan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> Cc: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
> Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>

A few general questions:

How have you tested this code? Has it been run on real hardware? What
were the results?

The code looks good and clean in general, minus a few places mentioned
below were I have questions and/or suggestions:

> +static struct arm_smmu_device *find_parent_smmu(struct arm_smmu_device *smmu)
> +{
> +	struct arm_smmu_device *parent, *tmp;
> +
> +	if (!smmu->parent_of_node)
> +		return NULL;
> +
> +	list_for_each_entry_safe(parent, tmp, &arm_smmu_devices, list)
> +		if (parent->dev->of_node == smmu->parent_of_node)
> +			return parent;

Why do you need the _safe variant here? You are not changing the list in
this loop so you should be fine with list_for_each_entry().

> +
> +	dev_warn(smmu->dev,
> +		 "Failed to find SMMU parent despite parent in DT\n");
> +	return NULL;
> +}

> +/* Wait for any pending TLB invalidations to complete */
> +static void arm_smmu_tlb_sync(struct arm_smmu_device *smmu)
> +{
> +	void __iomem *gr0_base = ARM_SMMU_GR0(smmu);
> +
> +	writel_relaxed(0, gr0_base + ARM_SMMU_GR0_sTLBGSYNC);
> +	while (readl_relaxed(gr0_base + ARM_SMMU_GR0_sTLBGSTATUS)
> +	       & sTLBGSTATUS_GSACTIVE)
> +		cpu_relax();

Other IOMMU drivers have a timeout for this loop and report an error
when the state does not change. I think this makes sense here too so
that the kernel will not just stop spinning in that loop if something
goes wrong but prints an error instead.

> +}
> +static void arm_smmu_flush_pgtable(struct arm_smmu_device *smmu, void *addr,
> +				   size_t size)
> +{
> +	unsigned long offset = (unsigned long)addr & ~PAGE_MASK;
> +
> +	/*
> +	 * If the SMMU can't walk tables in the CPU caches, treat them
> +	 * like non-coherent DMA...
> +	 */
> +	if (!(smmu->features & ARM_SMMU_FEAT_COHERENT_WALK))
> +		dma_map_page(smmu->dev, virt_to_page(addr), offset, size,
> +			     DMA_TO_DEVICE);

Why can you call into DMA-API here? A DMA-API implementation may call
back into this IOMMU driver, no? So this looks a little bit like a
layering violation.

> +}

> +static int arm_smmu_map(struct iommu_domain *domain, unsigned long iova,
> +			phys_addr_t paddr, size_t size, int flags)
> +{
> +	struct arm_smmu_domain *smmu_domain = domain->priv;
> +	struct arm_smmu_device *smmu = smmu_domain->leaf_smmu;
> +
> +	if (!smmu_domain || !smmu)
> +		return -ENODEV;
> +
> +	/*
> +	 * Check for silent address truncation up the SMMU chain.
> +	 */
> +	do {
> +		phys_addr_t output_mask = (1ULL << smmu->s2_output_size) - 1;
> +		if ((phys_addr_t)iova & ~output_mask)
> +			return -ERANGE;
> +	} while ((smmu = find_parent_smmu(smmu)));

This looks a bit too expensive to have in the map path. How about saving
something like an effective_output_mask (or output_size) which contains
the logical OR of every mask up the path? This would make this check a
lot cheaper.

> +
> +	return arm_smmu_create_mapping(smmu_domain, iova, paddr, size, flags);
> +}
> +
> +static size_t arm_smmu_unmap(struct iommu_domain *domain, unsigned long iova,
> +			     size_t size)
> +{
> +	int ret;
> +	struct arm_smmu_domain *smmu_domain = domain->priv;
> +	struct arm_smmu_cfg *root_cfg = &smmu_domain->root_cfg;
> +	struct arm_smmu_device *smmu = root_cfg->smmu;
> +	void __iomem *gr0_base = ARM_SMMU_GR0(smmu);
> +
> +	ret = arm_smmu_create_mapping(smmu_domain, iova, 0, size, 0);

Since this function does also unmapping, how about renaming it to
arm_smmu_handle_mapping(). The 'create' part in there is misleading.

> +	writel_relaxed(root_cfg->vmid, gr0_base + ARM_SMMU_GR0_TLBIVMID);
> +	arm_smmu_tlb_sync(smmu);
> +	return ret ? ret : size;
> +}
> +static int arm_smmu_add_device(struct device *dev)
> +{
> +	struct arm_smmu_device *child, *parent, *smmu;
> +	struct arm_smmu_device *tmp[2];
> +	struct arm_smmu_master *master = NULL;
> +
> +	list_for_each_entry_safe(parent, tmp[0], &arm_smmu_devices, list) {

Again, why do you use the _safe variant, you do not seem to change the
lists traversed here.

> +		smmu = parent;
> +
> +		/* Try to find a child of the current SMMU. */
> +		list_for_each_entry_safe(child, tmp[1], &arm_smmu_devices, list) {
> +			if (child->parent_of_node == parent->dev->of_node) {
> +				/* Does the child sit above our master? */
> +				master = find_smmu_master(child, dev->of_node);
> +				if (master) {
> +					smmu = NULL;
> +					break;
> +				}
> +			}
> +		}
> +
> +		/* We found some children, so keep searching. */
> +		if (!smmu) {
> +			master = NULL;
> +			continue;
> +		}
> +
> +		master = find_smmu_master(smmu, dev->of_node);
> +		if (master)
> +			break;
> +	}
> +
> +	if (!master)
> +		return -ENODEV;
> +
> +	dev->archdata.iommu = smmu;
> +	return 0;
> +}
