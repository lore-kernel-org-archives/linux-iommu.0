From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 8/9] iommu: add support for ARM Ltd. System MMU
	architecture
Date: Fri, 21 Jun 2013 11:23:18 +0100
Message-ID: <20130621102318.GB7766@mudshark.cambridge.arm.com>
References: <1370889285-22799-1-git-send-email-will.deacon@arm.com>
	<1370889285-22799-9-git-send-email-will.deacon@arm.com>
	<20130620212646.GG11309@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130620212646.GG11309-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Olav Haugan <ohaugan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Jun 20, 2013 at 10:26:46PM +0100, Joerg Roedel wrote:
> Hi Will,

Hi Joerg,

First, thanks for looking at this patch. I really appreciate it.

> On Mon, Jun 10, 2013 at 07:34:44PM +0100, Will Deacon wrote:
> > This patch adds support for SMMUs implementing the ARM System MMU
> > architecture versions 1 or 2. Both arm and arm64 are supported, although
> > the v7s descriptor format is not used.
> > 
> > Cc: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > Cc: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
> > Cc: Olav Haugan <ohaugan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> > Cc: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
> > Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
> 
> A few general questions:
> 
> How have you tested this code? Has it been run on real hardware? What
> were the results?

I've only tested it with software models, however they are fairly
sophisticated and provide *lots* of tunables, so you can test different
configurations which don't actually exist in hardware yet. You also get a
tonne of trace output, so you can inspect things like page table walking and
TLB filling to make sure the driver is setting things up as you planned.

I have also tested on MMU-400 (AArch32) and MMU-500 (both AArch32 and
AArch64, with 4k and 64k pages in the latter case) models. The setup I used
was 4 PL330 DMA controllers driven by dmatest.ko, which I hacked to call into
the ARM dma-mapping API to create a separate domain for each controller.

The results were that the memory-to-memory DMA didn't show any corruption. I
also managed to tickle access faults by messing around with the permissions,
then remap the buffers and resume the transfers.

> The code looks good and clean in general, minus a few places mentioned
> below were I have questions and/or suggestions:

Cheers, responses inline.

> > +static struct arm_smmu_device *find_parent_smmu(struct arm_smmu_device *smmu)
> > +{
> > +	struct arm_smmu_device *parent, *tmp;
> > +
> > +	if (!smmu->parent_of_node)
> > +		return NULL;
> > +
> > +	list_for_each_entry_safe(parent, tmp, &arm_smmu_devices, list)
> > +		if (parent->dev->of_node == smmu->parent_of_node)
> > +			return parent;
> 
> Why do you need the _safe variant here? You are not changing the list in
> this loop so you should be fine with list_for_each_entry().

For a system with multiple SMMUs (regardless of chaining), couldn't this
code run in parallel with probing of another SMMU (which has to add to the
arm_smmu_devices list)? The same applies for device removal, which could
perhaps be driven from some power-managment code.

> > +
> > +	dev_warn(smmu->dev,
> > +		 "Failed to find SMMU parent despite parent in DT\n");
> > +	return NULL;
> > +}
> 
> > +/* Wait for any pending TLB invalidations to complete */
> > +static void arm_smmu_tlb_sync(struct arm_smmu_device *smmu)
> > +{
> > +	void __iomem *gr0_base = ARM_SMMU_GR0(smmu);
> > +
> > +	writel_relaxed(0, gr0_base + ARM_SMMU_GR0_sTLBGSYNC);
> > +	while (readl_relaxed(gr0_base + ARM_SMMU_GR0_sTLBGSTATUS)
> > +	       & sTLBGSTATUS_GSACTIVE)
> > +		cpu_relax();
> 
> Other IOMMU drivers have a timeout for this loop and report an error
> when the state does not change. I think this makes sense here too so
> that the kernel will not just stop spinning in that loop if something
> goes wrong but prints an error instead.

Good idea, I'll add that.

> > +}
> > +static void arm_smmu_flush_pgtable(struct arm_smmu_device *smmu, void *addr,
> > +				   size_t size)
> > +{
> > +	unsigned long offset = (unsigned long)addr & ~PAGE_MASK;
> > +
> > +	/*
> > +	 * If the SMMU can't walk tables in the CPU caches, treat them
> > +	 * like non-coherent DMA...
> > +	 */
> > +	if (!(smmu->features & ARM_SMMU_FEAT_COHERENT_WALK))
> > +		dma_map_page(smmu->dev, virt_to_page(addr), offset, size,
> > +			     DMA_TO_DEVICE);
> 
> Why can you call into DMA-API here? A DMA-API implementation may call
> back into this IOMMU driver, no? So this looks a little bit like a
> layering violation.

So this is subtle, and the comment could probably do with more explanation.

The problem is that the SMMU hardware page table walker might not be able to
snoop the CPU caches. This means that after writing page table entries on
the CPU, we have to flush them *all* the way out to main memory, so the SMMU
can pick them up. There are only two other places I can think of where we
have to do something like this in Linux:

  (1) In the bowels of CPU suspend, where we may need to clean all of our
      caches prior to shutdown. This is all hidden away in low-level arch
      code.

  (2) When dealing with non-coherent DMA, since we have to transfer buffer
      ownership between the CPU and the device. There is an API for this.

so, in fact, non-coherent DMA is a perfect fit for what we're trying to
achieve with the SMMU page tables! I admit it looks odd, but it can't
possibly go recursive because the master in question is a page-table walker,
rather than anything backed by a struct device.

> > +}
> 
> > +static int arm_smmu_map(struct iommu_domain *domain, unsigned long iova,
> > +			phys_addr_t paddr, size_t size, int flags)
> > +{
> > +	struct arm_smmu_domain *smmu_domain = domain->priv;
> > +	struct arm_smmu_device *smmu = smmu_domain->leaf_smmu;
> > +
> > +	if (!smmu_domain || !smmu)
> > +		return -ENODEV;
> > +
> > +	/*
> > +	 * Check for silent address truncation up the SMMU chain.
> > +	 */
> > +	do {
> > +		phys_addr_t output_mask = (1ULL << smmu->s2_output_size) - 1;
> > +		if ((phys_addr_t)iova & ~output_mask)
> > +			return -ERANGE;
> > +	} while ((smmu = find_parent_smmu(smmu)));
> 
> This looks a bit too expensive to have in the map path. How about saving
> something like an effective_output_mask (or output_size) which contains
> the logical OR of every mask up the path? This would make this check a
> lot cheaper.

As mentioned in the DT binding thread, it's rare that this loop would
execute more than once, and largely inconceivable that it would execute more
than twice, so I don't know how much we need to worry about the cost.

> > +
> > +	return arm_smmu_create_mapping(smmu_domain, iova, paddr, size, flags);
> > +}
> > +
> > +static size_t arm_smmu_unmap(struct iommu_domain *domain, unsigned long iova,
> > +			     size_t size)
> > +{
> > +	int ret;
> > +	struct arm_smmu_domain *smmu_domain = domain->priv;
> > +	struct arm_smmu_cfg *root_cfg = &smmu_domain->root_cfg;
> > +	struct arm_smmu_device *smmu = root_cfg->smmu;
> > +	void __iomem *gr0_base = ARM_SMMU_GR0(smmu);
> > +
> > +	ret = arm_smmu_create_mapping(smmu_domain, iova, 0, size, 0);
> 
> Since this function does also unmapping, how about renaming it to
> arm_smmu_handle_mapping(). The 'create' part in there is misleading.

Yep, that's a hangover from when I originally had separate functions. Will
fix,

> > +	writel_relaxed(root_cfg->vmid, gr0_base + ARM_SMMU_GR0_TLBIVMID);
> > +	arm_smmu_tlb_sync(smmu);
> > +	return ret ? ret : size;
> > +}
> > +static int arm_smmu_add_device(struct device *dev)
> > +{
> > +	struct arm_smmu_device *child, *parent, *smmu;
> > +	struct arm_smmu_device *tmp[2];
> > +	struct arm_smmu_master *master = NULL;
> > +
> > +	list_for_each_entry_safe(parent, tmp[0], &arm_smmu_devices, list) {
> 
> Again, why do you use the _safe variant, you do not seem to change the
> lists traversed here.

Same reasoning as above. Happy to remove it if it's not actually required...

Cheers again,

Will
