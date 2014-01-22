From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 04/11] iommu/arm-smmu: Introduce automatic
	stream-id-masking
Date: Wed, 22 Jan 2014 15:26:22 +0000
Message-ID: <20140122152622.GD14108@mudshark.cambridge.arm.com>
References: <1389876263-25759-1-git-send-email-andreas.herrmann@calxeda.com>
	<1389876263-25759-5-git-send-email-andreas.herrmann@calxeda.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1389876263-25759-5-git-send-email-andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
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
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Andreas,

This patch always requires some extra brain cycles when reviewing!

On Thu, Jan 16, 2014 at 12:44:16PM +0000, Andreas Herrmann wrote:
> Try to determine a mask that can be used for all StreamIDs of a master
> device. This allows to use just one SMR group instead of
> number-of-streamids SMR groups for a master device.
> 
> Changelog:

You can put the change log and notes after the '---' so they don't appear in
the commit log, although the commit message could probably use a brief
description of your algorithm.

> * Sorting of stream IDs (to make usage of S2CR independend of sequence of
>   stream IDs in DT)
>   - intentionally not implemented
>   - code does not rely on sorting
>   - in fact sorting might make things worse with this simple
>     implementation
>     + Example: master with stream IDs 4, 5, 6, 0xe, 0xf requires 3
>       SMRs when IDs are specified in this sorted order (one to map 4,
>       5, one to map 6, one to map 0xe, 0xf) but just 2 SMRs when
>       specified as 4, 5, 0xe, 0xf, 6 (one to map 4, 5, 0xe, 0xf and
>       one SMR to map 6)
>   - thus by modifying the DT information you can affect the number of
>     S2CRs required for stream matching
>   => I'd say "use common sense" when specifying stream IDs for a master
>    device in DT.

Then we probably want a comment in the driver helping people work out what
the best ordering is.

> @@ -1025,10 +1030,109 @@ static void arm_smmu_domain_destroy(struct iommu_domain *domain)
>  	kfree(smmu_domain);
>  }
>  
> +static int determine_smr_mask(struct arm_smmu_device *smmu,
> +			struct arm_smmu_master *master,
> +			struct arm_smmu_smr *smr, int start, int order)
> +{
> +	u16 i, zero_bits_mask, one_bits_mask, const_mask;
> +	int nr;
> +
> +	nr = 1 << order;
> +
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

This part always confuses me. Why do we check (1 << i) against nr? In fact,
in your example where we have SIDs {4,5,e,f,6}, then we'll call this
initially with start = 0, order = 2 and try to allocate an smr for
{4,5,e,f}. That will succeed with mask 1011b and id 0100b, but the mask has
a hamming weight of 3, which is != nr (2).

Where am I getting this wrong?

I also still need to convince myself that we can't end up generating smrs
which match the same SID. Is that what your check above is trying to handle?

> +static int determine_smr_mapping(struct arm_smmu_device *smmu,
> +				struct arm_smmu_master *master,
> +				struct arm_smmu_smr *smrs, int max_smrs)
> +{
> +	int nr_sid, nr, i, bit, start;
> +
> +	/*
> +	 * This function is called only once -- when a master is added
> +	 * to a domain. If master->num_s2crs != 0 then this master
> +	 * was already added to a domain.
> +	 */
> +	BUG_ON(master->num_s2crs);

I think I'd rather WARN and return -EINVAL. We needn't kill the kernel for
this.

> +
> +	start = nr = 0;
> +	nr_sid = master->num_streamids;
> +	do {
> +		/*
> +		 * largest power-of-2 number of streamids for which to
> +		 * determine a usable mask/id pair for stream matching
> +		 */
> +		bit = fls(nr_sid);

If you use __fls...

> +		if (!bit)
> +			return 0;
> +
> +		/*
> +		 * iterate over power-of-2 numbers to determine
> +		 * largest possible mask/id pair for stream matching
> +		 * of next 2**i streamids
> +		 */
> +		for (i = bit - 1; i >= 0; i--) {

... then you don't need this -1.

> +			if(!determine_smr_mask(smmu, master,

Cosmetic: space after 'if'.

>  	/* It worked! Now, poke the actual hardware */
> -	for (i = 0; i < master->num_streamids; ++i) {
> +	for (i = 0; i < master->num_s2crs; ++i) {
>  		u32 reg = SMR_VALID | smrs[i].id << SMR_ID_SHIFT |
>  			  smrs[i].mask << SMR_MASK_SHIFT;
> +		dev_dbg(smmu->dev, "SMR%d: 0x%x\n", smrs[i].idx, reg);

I think we can drop the dev_dbg statements from this patch.

Will
