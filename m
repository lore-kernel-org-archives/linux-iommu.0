From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v5 14/19] iommu/arm-smmu: Intelligent SMR allocation
Date: Thu, 1 Sep 2016 18:59:40 +0100
Message-ID: <382ae80f-9cd7-95e7-8d12-06abf282e581@arm.com>
References: <cover.1471975357.git.robin.murphy@arm.com>
	<693b7fdd58be254297eb43ac8f5e035beb5226b2.1471975357.git.robin.murphy@arm.com>
	<20160901151702.GC28180@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20160901151702.GC28180@red-moon>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, punit.agrawal-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 01/09/16 16:17, Lorenzo Pieralisi wrote:
[...]
>> +static int arm_smmu_find_sme(struct arm_smmu_device *smmu, u16 id, u16 mask)
>>  {
>>  	struct arm_smmu_smr *smrs = smmu->smrs;
>> -	int i, idx;
>> +	int i, idx = -ENOSPC;
>>  
>> -	/* Allocate the SMRs on the SMMU */
>> -	for_each_cfg_sme(cfg, i, idx) {
>> -		if (idx >= 0)
>> -			return -EEXIST;
>> +	/* Stream indexing is blissfully easy */
>> +	if (!smrs)
>> +		return id;
>>  
>> -		/* ...except on stream indexing hardware, of course */
>> -		if (!smrs) {
>> -			cfg->smendx[i] = cfg->streamids[i];
>> +	/* Validating SMRs is... less so */
>> +	for (i = 0; i < smmu->num_mapping_groups; ++i) {
>> +		if (!smrs[i].valid) {
>> +			if (idx < 0)
>> +				idx = i;
> 
> This is to stash an "empty" entry index in case none matches, right ?
> Let me say it is not that obvious, that deserves a comment since it
> is hard to follow.

Yes, since we have to iterate through every SMR anyway, this just keeps
a note of the first free entry we see along the way. It _could_ be
simplified slightly further by being made unconditional so that we end
up allocating top-down instead, although that would pessimize the
early-out cases below. I'll certainly comment it, though.

>>  			continue;
>>  		}
>>  
>> -		idx = arm_smmu_alloc_smr(smmu);
>> -		if (idx < 0) {
>> -			dev_err(smmu->dev, "failed to allocate free SMR\n");
>> -			goto err_free_smrs;
>> -		}
>> -		cfg->smendx[i] = idx;
>> +		/* Exact matches are good */
>> +		if (mask == smrs[i].mask && id == smrs[i].id)
>> +			return i;
>>  
>> -		smrs[idx].id = cfg->streamids[i];
>> -		smrs[idx].mask = 0; /* We don't currently share SMRs */
>> +		/* New unmasked IDs matching existing masks we can cope with */
>> +		if (!mask && !((smrs[i].id ^ id) & ~smrs[i].mask))
>> +			return i;
>> +
>> +		/* Overlapping masks are right out */
>> +		if (mask & smrs[i].mask)
>> +			return -EINVAL;
>> +
>> +		/* Distinct masks must match unambiguous ranges */
>> +		if (mask && !((smrs[i].id ^ id) & ~(smrs[i].mask | mask)))
>> +			return -EINVAL;
> 
> And this is to _prevent_ an entry to match the input streamid
> range (masked streamid) because it would create an ambiguous match ?

Indeed; say we have the (ID,mask) pair (0x0100,0x000f) already in an
SMR, then we'd allow (0x0000,0x00f0), since bit 8 still uniquely matches
one or the other, but we'd have to reject (0x0100,0x00f0) as that would
create a conflict for ID 0x0100. In general, unless there are distinct
bits outside both masks then there will always exist at least one ID
capable of causing a conflict.

> Basically here you keep looping because this function is at the
> same time allocating and validating the SMRS (ie you want to make
> sure there are no valid entries that clash with the streamid you
> are currently allocating).
> 
> It is a tad complicated and a bit hard to parse. I wonder if it would
> not be better to split into two SMRS validation and allocation
> functions, I think I fully grasped what you want to achieve but it is
> not that trivial.

Things were actually considerably more complicated until I realised the
neatness of hoisting the allocation (which itself is all of 4 lines
here) up into the same function. A real logical separation of concerns
would involve iterating through the whole array two-and-a-bit times,
first validating against conflicts, then looking to return an existing
entry which already matches, then finally falling back to allocating a
free entry. Even disregarding the efficiency angle, I'm not convinced
that having more code spread about with similar but subtly different
repetition would actually be any easier to follow (unfortunately earlier
implementations of this have been rebased into oblivion so I can't pull
one out to demonstrate). I'll definitely beef up the comments here - on
reflection these are more notes to myself than actual explanations for
others...

Robin.
