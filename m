From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v5 09/19] iommu/arm-smmu: Consolidate stream map entry
	state
Date: Thu, 1 Sep 2016 19:32:57 +0100
Message-ID: <20160901183257.GT6721@arm.com>
References: <cover.1471975357.git.robin.murphy@arm.com>
	<26fcf7d3138816b9546a3dcc2bbbc2f229f34c91.1471975357.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <26fcf7d3138816b9546a3dcc2bbbc2f229f34c91.1471975357.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, punit.agrawal-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Aug 23, 2016 at 08:05:20PM +0100, Robin Murphy wrote:
> In order to consider SMR masking, we really want to be able to validate
> ID/mask pairs against existing SMR contents to prevent stream match
> conflicts, which at best would cause transactions to fault unexpectedly,
> and at worst lead to silent unpredictable behaviour. With our SMMU
> instance data holding only an allocator bitmap, and the SMR values
> themselves scattered across master configs hanging off devices which we
> may have no way of finding, there's essentially no way short of digging
> everything back out of the hardware. Similarly, the thought of power
> management ops to support suspend/resume faces the exact same problem.
> 
> By massaging the software state into a closer shape to the underlying
> hardware, everything comes together quite nicely; the allocator and the
> high-level view of the data become a single centralised state which we
> can easily keep track of, and to which any updates can be validated in
> full before being synchronised to the hardware itself.
> 
> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> ---
>  drivers/iommu/arm-smmu.c | 147 +++++++++++++++++++++++++++--------------------
>  1 file changed, 86 insertions(+), 61 deletions(-)

[...]

> +static int arm_smmu_master_alloc_smes(struct arm_smmu_device *smmu,
> +				      struct arm_smmu_master_cfg *cfg)
> +{
> +	struct arm_smmu_smr *smrs = smmu->smrs;
> +	int i, idx;
>  
>  	/* Allocate the SMRs on the SMMU */
>  	for (i = 0; i < cfg->num_streamids; ++i) {
> -		int idx = __arm_smmu_alloc_bitmap(smmu->smr_map, 0,
> -						  smmu->num_mapping_groups);
> +		if (cfg->smendx[i] >= 0)
> +			return -EEXIST;
> +
> +		/* ...except on stream indexing hardware, of course */
> +		if (!smrs) {
> +			cfg->smendx[i] = cfg->streamids[i];
> +			continue;
> +		}
> +
> +		idx = arm_smmu_alloc_smr(smmu);
>  		if (idx < 0) {
>  			dev_err(smmu->dev, "failed to allocate free SMR\n");
>  			goto err_free_smrs;
>  		}
> +		cfg->smendx[i] = idx;
>  
> -		smrs[i] = (struct arm_smmu_smr) {
> -			.idx	= idx,
> -			.mask	= 0, /* We don't currently share SMRs */
> -			.id	= cfg->streamids[i],
> -		};
> +		smrs[idx].id = cfg->streamids[i];
> +		smrs[idx].mask = 0; /* We don't currently share SMRs */
>  	}
>  
> +	if (!smrs)
> +		return 0;
> +
>  	/* It worked! Now, poke the actual hardware */
> -	for (i = 0; i < cfg->num_streamids; ++i) {
> -		u32 reg = SMR_VALID | smrs[i].id << SMR_ID_SHIFT |
> -			  smrs[i].mask << SMR_MASK_SHIFT;
> -		writel_relaxed(reg, gr0_base + ARM_SMMU_GR0_SMR(smrs[i].idx));
> -	}
> +	for (i = 0; i < cfg->num_streamids; ++i)
> +		arm_smmu_write_smr(smmu, cfg->smendx[i]);
>  
> -	cfg->smrs = smrs;
>  	return 0;
>  
>  err_free_smrs:
> -	while (--i >= 0)
> -		__arm_smmu_free_bitmap(smmu->smr_map, smrs[i].idx);
> -	kfree(smrs);
> +	while (i--) {
> +		arm_smmu_free_smr(smmu, cfg->smendx[i]);
> +		cfg->smendx[i] = INVALID_SMENDX;
> +	}

Hmm, don't you have an off-by-one here? At least, looking at the final
code, we branch to out_err from within the for_each_cfg_sme loop, but
before we've incremented smmu->s2crs[idx].count, so the arm_smmu_free_smr
will erroneously decrement that.

Will
