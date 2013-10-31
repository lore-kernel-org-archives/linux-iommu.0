From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 4/6] iommu/arm-smmu: Introduce automatic stream-id-masking
Date: Thu, 31 Oct 2013 17:55:11 +0000
Message-ID: <20131031175511.GA31082@mudshark.cambridge.arm.com>
References: <1382127195-15261-1-git-send-email-andreas.herrmann@calxeda.com>
	<1382127195-15261-5-git-send-email-andreas.herrmann@calxeda.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1382127195-15261-5-git-send-email-andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
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

Cheers for the new patch, some comments/questions in line...

On Fri, Oct 18, 2013 at 09:13:13PM +0100, Andreas Herrmann wrote:
> Try to determine a mask that can be used for all StreamIDs of a master
> device. This allows to use just one SMR group instead of
> number-of-streamids SMR groups for a master device.
> 
> Signed-off-by: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
> ---
>  drivers/iommu/arm-smmu.c |  121 ++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 105 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index a65a559..5f585fc 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -28,6 +28,7 @@
>   *	- Context fault reporting
>   */
>  
> +#define DEBUG

You can drop this change from the patch.

>  #define pr_fmt(fmt) "arm-smmu: " fmt
>  
>  #include <linux/delay.h>
> @@ -42,6 +43,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
> +#include <linux/bitops.h>
>  
>  #include <linux/amba/bus.h>
>  
> @@ -338,8 +340,9 @@ struct arm_smmu_master {
>  	 * SMMU chain.
>  	 */
>  	struct rb_node			node;
> -	int				num_streamids;
> +	u32				num_streamids;
>  	u16				streamids[MAX_MASTER_STREAMIDS];
> +	int				num_used_smrs;
>  
>  	/*
>  	 * We only need to allocate these on the root SMMU, as we
> @@ -1025,10 +1028,90 @@ static void arm_smmu_domain_destroy(struct iommu_domain *domain)
>  	kfree(smmu_domain);
>  }
>  
> +static int determine_smr_mask(struct arm_smmu_master *master,
> +			struct arm_smmu_smr *smr, int start, int nr)
> +{
> +	u16 i, zero_bits_mask, one_bits_mask, const_mask;
> +
> +	BUG_ON(!is_power_of_2(nr));

If you change the parameters to take a bit number instead of a value, then
you don't need the BUG_ON by construction.

> +	if (nr == 1) {
> +		/* no mask, use streamid to match and be done with it */
> +		smr->mask = 0;
> +		smr->id = master->streamids[start];
> +		return 0;
> +	}
> +
> +	zero_bits_mask = 0;
> +	one_bits_mask = 0xffff;
> +	for (i = start; i < start + nr; i++) {
> +		zero_bits_mask |= master->streamids[i];   /* const 0 bits */
> +		one_bits_mask &= master->streamids[i]; /* const 1 bits */
> +	}
> +	zero_bits_mask = ~zero_bits_mask;
> +
> +	/* bits having constant values (either 0 or 1) */
> +	const_mask = zero_bits_mask | one_bits_mask;
> +
> +	i = hweight16(~const_mask);
> +	if ((1 << i) == nr) {
> +		smr->mask = ~const_mask;
> +		smr->id = one_bits_mask;

An extra thing to think about is the number of implemented bits in the SMR
registers (I believe this is implemented defined). We currently do a basic
sanity check in arm_smmu_device_cfg_probe, where we check that the mask and
id fields are sufficient for each other, but we should also check this
against the real ids and masks once they are known.

> +	} else {
> +		/* no usable mask for this set of streamids */
> +		return 1;
> +	}
> +
> +	return 0;
> +}
> +
> +static int determine_smr_mapping(struct arm_smmu_master *master,
> +				struct arm_smmu_smr *smrs, int max_smrs)
> +{
> +	int nr_sid, nr, i, bit, start;
> +
> +	start = nr = 0;
> +	nr_sid = master->num_streamids;
> +	do {
> +		/*
> +		 * largest power-of-2 number of streamids for which to
> +		 * determine a usable mask/id pair for stream matching
> +		 */
> +		bit = fls(nr_sid);
> +		if (!bit)
> +			return 0;
> +
> +		/*
> +		 * iterate over power-of-2 numbers to determine
> +		 * largest possible mask/id pair for stream matching
> +		 * of next <nr> streamids
> +		 */
> +		for (i = bit - 1; i >= 0; i--) {
> +			nr = 1 << i;
> +			if(!determine_smr_mask(master,
> +						&smrs[master->num_used_smrs],
> +						start, nr))

Does this rely on the stream IDs being sorted? We're not actually trying all
combinations of IDs, so it seems like changing the order of IDs in the
device tree will potentially change the number of smrs you end up using.

> +				break;
> +		}
> +
> +		nr_sid -= nr;
> +		start += nr;
> +		master->num_used_smrs++;

Does the manipulation of num_used_smrs here mean that we should only call
this function exactly once? Would it be worth checking that num_used_smrs is
zero when we enter this function?

Also, in v1, we discussed about checking for duplicate stream ids in
register_smmu_master. Did you look into that?

> +	} while (master->num_used_smrs <= max_smrs);
> +
> +	if (nr_sid) {
> +		/* not enough mapping groups available */
> +		master->num_used_smrs = 0;
> +		return -ENOSPC;
> +	}
> +
> +	return 0;
> +}
> +
>  static int arm_smmu_master_configure_smrs(struct arm_smmu_device *smmu,
>  					  struct arm_smmu_master *master)
>  {
> -	int i;
> +	int i, max_smrs, ret;
>  	struct arm_smmu_smr *smrs;
>  	void __iomem *gr0_base = ARM_SMMU_GR0(smmu);
>  
> @@ -1038,42 +1121,45 @@ static int arm_smmu_master_configure_smrs(struct arm_smmu_device *smmu,
>  	if (master->smrs)
>  		return -EEXIST;
>  
> -	smrs = kmalloc(sizeof(*smrs) * master->num_streamids, GFP_KERNEL);
> +	max_smrs = min(smmu->num_mapping_groups, master->num_streamids);
> +	smrs = kmalloc(sizeof(*smrs) * max_smrs, GFP_KERNEL);
>  	if (!smrs) {
>  		dev_err(smmu->dev, "failed to allocate %d SMRs for master %s\n",
> -			master->num_streamids, master->of_node->name);
> +			max_smrs, master->of_node->name);
>  		return -ENOMEM;
>  	}
>  
> +	ret = determine_smr_mapping(master, smrs, max_smrs);
> +	if (ret)
> +		goto err_free_smrs;
> +
>  	/* Allocate the SMRs on the root SMMU */
> -	for (i = 0; i < master->num_streamids; ++i) {
> +	for (i = 0; i < master->num_used_smrs; ++i) {
>  		int idx = __arm_smmu_alloc_bitmap(smmu->smr_map, 0,
>  						  smmu->num_mapping_groups);
>  		if (IS_ERR_VALUE(idx)) {
>  			dev_err(smmu->dev, "failed to allocate free SMR\n");
> -			goto err_free_smrs;
> +			goto err_free_bitmap;
>  		}
> -
> -		smrs[i] = (struct arm_smmu_smr) {
> -			.idx	= idx,
> -			.mask	= 0, /* We don't currently share SMRs */
> -			.id	= master->streamids[i],
> -		};
> +		smrs[i].idx = idx;
>  	}
>  
>  	/* It worked! Now, poke the actual hardware */
> -	for (i = 0; i < master->num_streamids; ++i) {
> +	for (i = 0; i < master->num_used_smrs; ++i) {
>  		u32 reg = SMR_VALID | smrs[i].id << SMR_ID_SHIFT |
>  			  smrs[i].mask << SMR_MASK_SHIFT;
> +		dev_dbg(smmu->dev, "SMR%d: 0x%x\n", smrs[i].idx, reg);
>  		writel_relaxed(reg, gr0_base + ARM_SMMU_GR0_SMR(smrs[i].idx));
>  	}
>  
>  	master->smrs = smrs;
>  	return 0;
>  
> -err_free_smrs:
> +err_free_bitmap:
>  	while (--i >= 0)
>  		__arm_smmu_free_bitmap(smmu->smr_map, smrs[i].idx);
> +	master->num_used_smrs = 0;
> +err_free_smrs:
>  	kfree(smrs);
>  	return -ENOSPC;
>  }
> @@ -1112,7 +1198,7 @@ static void arm_smmu_bypass_stream_mapping(struct arm_smmu_device *smmu,
>  static int arm_smmu_domain_add_master(struct arm_smmu_domain *smmu_domain,
>  				      struct arm_smmu_master *master)
>  {
> -	int i, ret;
> +	int i, ret, num_s2crs;
>  	struct arm_smmu_device *parent, *smmu = smmu_domain->root_cfg.smmu;
>  	void __iomem *gr0_base = ARM_SMMU_GR0(smmu);
>  
> @@ -1136,11 +1222,14 @@ static int arm_smmu_domain_add_master(struct arm_smmu_domain *smmu_domain,
>  	}
>  
>  	/* Now we're at the root, time to point at our context bank */
> -	for (i = 0; i < master->num_streamids; ++i) {
> +	num_s2crs = master->num_used_smrs ? master->num_used_smrs :
> +		master->num_streamids;

I know we already changed it once, but checks like this are ugly, so perhaps
renaming num_user_smrs (again!) to something like num_s2crs, then just
making sure that it is set to num_streamids if we're not using stream
matching?

Will
