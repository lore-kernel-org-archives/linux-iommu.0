Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70C4481FAC
	for <iommu@lists.linux.dev>; Thu,  2 Jul 2026 12:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782993674; cv=none; b=MmO2dUkVV+eh+IwyIjQKuhEMCEuHVGGSzlv88X/bJjIrRuIp5RH5JI7XAINAQX3fU0Q3vGsOffA7BRDCD2aomezHsdBSbbInZsLDSnLS95vXI0Zfw0kvH8yKELpE6fBR0VxUKmBtM9g+0T/l3tcflN+ddbSAoW6csD0+08tx2Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782993674; c=relaxed/simple;
	bh=Q++t6UDjEPmAM1sRpwFz4r69sHx9kEtoP4L1SoBqxGQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ulLCw/mCvsyDkz2ledhi1mjpaKRBks7wyeeZIywtewLJE5xFuHfRuw/surr5kxtpTXQKKAH98G6gfGPNYL9nYNhSnoqvTkyCs/KwKF8Gv15wX1vpDat+KMs9wSaYuJzVa3XRFjAGzyq9THboGvSY8rxUBi8902ZmzJF7Gk9NkQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=O5la7sBy; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="O5la7sBy"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 98D0D1655;
	Thu,  2 Jul 2026 05:01:06 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9EAAB3F85F;
	Thu,  2 Jul 2026 05:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1782993671; bh=Q++t6UDjEPmAM1sRpwFz4r69sHx9kEtoP4L1SoBqxGQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=O5la7sBy9fpG9oKdnfnA7d5kfya6c7tw+A6LroXoItQlVAf1iyPXjjgCxSHX0d7Vg
	 hIP+jrTnvTVFjlgfnrVCEIHoqJlHVFsg8UBSu4eTTScJh7rW6PCoFFGvCBZiVSLMHe
	 tpk4DdMS5+Pi+vpx5n7NY+ZVX92QhgW61o7a2Ubc=
Message-ID: <50d61140-15e2-471e-8a07-d4a3752ddcbc@arm.com>
Date: Thu, 2 Jul 2026 13:01:06 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] drm/i915/gem: split shared memory allocation table
 logic
To: Krzysztof Karas <krzysztof.karas@intel.com>,
 Andi Shyti <andi.shyti@kernel.org>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 iommu@lists.linux.dev, Andi Shyti <andi.shyti@linux.intel.com>,
 Joerg Roedel <joro@8bytes.org>, =?UTF-8?Q?Micha=C5=82_Grzelak?=
 <michal.grzelak@intel.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
 Sebastian Brzezinka <sebastian.brzezinka@intel.com>,
 Krzysztof Niemiec <krzysztof.niemiec@intel.com>
References: <20260701104437.236979-1-krzysztof.karas@intel.com>
 <20260701104437.236979-2-krzysztof.karas@intel.com>
 <akUibf3NyThHnXco@zenone.zhora.eu>
 <5yosfyp4yuvix56sc7uzsbelndiph2ibzzg747lyrklqjy4bxr@mbbbcvl2cczk>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <5yosfyp4yuvix56sc7uzsbelndiph2ibzzg747lyrklqjy4bxr@mbbbcvl2cczk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/07/2026 7:18 am, Krzysztof Karas wrote:
> Hi Andi,
> 
> thanks for reviewing!
> 
> On 2026-07-01 at 16:38:11 +0200, Andi Shyti wrote:
>> Hi Krzysztof,
>>
>> On Wed, Jul 01, 2026 at 10:44:35AM +0000, Krzysztof Karas wrote:
>>> shmem_sg_alloc_table is a complex and hard to read function.
>>> Split its logic into smaller pieces to improve readability and
>>> reduce indentation. Change the main "for" loop into "while" to
>>> get rid of obscure iterator "i" and be more explicit in
>>> traversing scatterlist.
>>
>> any chance we can split this cleanup into smaller pieces?
> Yeah, I'll work something out.
> 
>>
>>> Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
>>
>> ...
>>
>>> +static struct folio *shmem_shrink_get_folio(struct address_space *mapping,
>>> +					    unsigned long folio_index,
>>> +					    gfp_t gfp, unsigned int pages_left,
>>> +					    struct drm_i915_private *i915)
>>> +{
>>> +#define MAX_READS 2
>>
>> This MAX_READS here is very ugly! Just use 2 and explain it in a
>> comment. In the 'if' below you can check out of "if (... || i)"
>> and still explain it in a comment.
> If we are on the topic of personal preferences, I'd prefer
> moving this to a variable instead of leaving a magic number
> buried in the code. The comment is unnecessary if you figure out
> what this loop does and in the end "2" is just a number somebody
> picked way back.

FWIW since I'm looking at the thread - indeed if it's just a retry loop 
and the actual index value isn't significant, then often a count-down 
loop can be the most self-explanatory, e.g.:

	int retries = 2;

	while (retries--) {
		...
	}

Or perhaps in this case:

	do {
		folio = shmem_read_folio();
		if (IS_ERR(folio))
			i915_gem_shrink();
	while (!IS_ERR(folio) && --retries);
	return folio;

Cheers,
Robin.

>>
>>> +	struct folio *folio;
>>> +	unsigned int i;
>>> +
>>> +	for (i = 0; i < MAX_READS; i++) {
>>> +		cond_resched();
>>> +		folio = shmem_read_folio_gfp(mapping, folio_index, gfp);
>>> +		if (!IS_ERR(folio) || i == MAX_READS - 1)
>>> +			return folio;
>>> +
>>> +		i915_gem_shrink(NULL, i915, 2 * pages_left, NULL,
>>
>> /pages_left/page_count/
> I mean, sure, but is there a reason for using "count" instead of
> "left"?
> 
>>
>>> +				I915_SHRINK_BOUND | I915_SHRINK_UNBOUND);
>>> +
>>
>> ...
>>
>>> +	}
>>> +
>>> +	/* Should never happen */
>>> +	WARN_ON_ONCE(1);
>>
>> no need.
> Okay, I'll remove it.
> 
>>
>> Thanks,
>> Andi
>>
>>> +	return ERR_PTR(-EINVAL);
>>> +}
> 

