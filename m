Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A82A34B1A3
	for <iommu@lists.linux.dev>; Mon, 16 Mar 2026 06:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773642359; cv=none; b=R0oO2P3j6OI2jzY4JFNCmAAZS4ZbhEH80WPGV0SM9fjl65wo0yJwpRoeCnS1zEmEvJosSnnPdp/HvsN2Ac88ji9wFjOQNLFpk/BBpha1xJ0396AbSkIllTV72I9tvP65mJuIFz+KLQ0psKvaiiLKIntZMc2Zkc/IvaPPVy7rzL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773642359; c=relaxed/simple;
	bh=Um8M71F1K3TlRW3nLzOvwq96y/0ASMpCsD8f2eJwOvo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SERlzgXjLSBelmwxlnsEaC7j3ROFQ+OEWKlCrxANHttkvU8MEEBKgR6vPfpck6cLuLZpL9ocwCagUoTZ2hveTh68p/kzyy1GU0LCwmjhWd3EKgJfS9RZikNcu48QjAdxaiNvTOl4sbyzQFufudyaqxcmOf4amIHKzARw7dTu94Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RNVuWQXb; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RNVuWQXb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773642359; x=1805178359;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Um8M71F1K3TlRW3nLzOvwq96y/0ASMpCsD8f2eJwOvo=;
  b=RNVuWQXbqJTn09UPIldxTvnGQPTgBi/fv6dLU9RF6C5e9wtDxoeyVzNV
   YTH1nQiOOnaXI6fx338MHpBZ5hcperLiJPvccdvdS6niqCi9pKbedKVJ4
   PRODhelT9MEFNHVTquSsLPEGx6+yBcz6mwzIyt2WZT1cbHS9uVmAVgLWK
   1TAqsdjOCEfoByKfogD+n7vDAMhG7ZIYoxeS9NJdjF10gMKCNtNQZ/XZ5
   ZQm8vYm7I01cki6TGn51aeJorKLCrBVPmC52qpuyC+ousK8jnigr1iXX4
   Z6wWRAAbqs3Q5gJtFxDN3yRQwqWNyQWc8XTsbRv6UDQDI2DeLBlFpePM9
   Q==;
X-CSE-ConnectionGUID: jmj8n3b4Rni1TlLRjg8bEA==
X-CSE-MsgGUID: 4FLQaFQATp6/P2o2z50f3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="86129196"
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; 
   d="scan'208";a="86129196"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2026 23:25:58 -0700
X-CSE-ConnectionGUID: 9mwLQ2s4QouqwM3Cgp/a5g==
X-CSE-MsgGUID: +9lddCtZTJWFYaUYcfEnQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; 
   d="scan'208";a="225925490"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2026 23:25:56 -0700
Message-ID: <02344098-c2da-4634-8f34-e03c88d030a2@linux.intel.com>
Date: Mon, 16 Mar 2026 14:24:57 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] iommu: Lift and generalize the STE/CD update code
 from SMMUv3
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Dmytro Maluka <dmaluka@chromium.org>,
 Samiullah Khawaja <skhawaja@google.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260309060648.276762-1-baolu.lu@linux.intel.com>
 <20260309060648.276762-2-baolu.lu@linux.intel.com>
 <abOjJf4HJ50vCIyg@Asurada-Nvidia>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <abOjJf4HJ50vCIyg@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/13/26 13:39, Nicolin Chen wrote:
> Hi Baolu,

Hi Nicolin,

Thanks for the comments.

> 
> On Mon, Mar 09, 2026 at 02:06:41PM +0800, Lu Baolu wrote:
>> +struct entry_sync_writer_ops64;
>> +struct entry_sync_writer64 {
>> +	const struct entry_sync_writer_ops64 *ops;
>> +	size_t num_quantas;
>> +	size_t vbit_quanta;
>> +};
> 
> Though I could guess what the @num_quantas and @vbit_quanta likely
> mean, it'd be nicer to have some notes elaborating them.

Yes. I will make it like this,

struct entry_sync_writer64 {
         const struct entry_sync_writer_ops64 *ops;
         /* Total size of the entry in atomic units: */
         size_t num_quantas;
         /* The index of the quanta containing the Valid bit: */
         size_t vbit_quanta;
};

The same to entry_sync_writer128.

> 
>> +/*
>> + * Figure out if we can do a hitless update of entry to become target. Returns a
>> + * bit mask where 1 indicates that a quanta word needs to be set disruptively.
>> + * unused_update is an intermediate value of entry that has unused bits set to
>> + * their new values.
>> + */
>> +static u8 NS(entry_quanta_diff)(struct entry_sync_writer *writer,
>> +				const quanta_t *entry, const quanta_t *target,
>> +				quanta_t *unused_update, quanta_t *memory)
>> +{
>> +	quanta_t *target_used = memory + writer->num_quantas * 1;
>> +	quanta_t *cur_used = memory + writer->num_quantas * 2;
> 
> Should we have a kdoc somewhere mentioning that the two arrays are
> neighbors (IIUIC)?

The library uses a single block of scratchpad memory and offsets into 
it. A WARN_ON() is added in NS(entry_sync_write) to ensure this:

         if (WARN_ON(memory_len !=
                     ENTRY_SYNC_MEMORY_LEN(writer) * sizeof(*memory)))
                 return;

How about adding below comments around this WARN_ON()?

/*
  * The scratchpad memory is organized into three neighbors:
  * 1. [0, num_quantas): 'unused_update' - intermediate state with
  *    ignored bits updated.
  * 2. [num_quantas, 2*num_quantas): 'target_used' - bits active in
  *    the target state.
  * 3. [2*num_quantas, 3*num_quantas): 'cur_used' - bits active in
  *    the current state.
  */

>> +	u8 used_qword_diff = 0;
> 
> It seems to me that we want use "quanta" v.s. "qword"? 128 bits can
> be called "dqword" as well though.

Yes. "qword" is a bit too x86-centric. Since the library is designed
around the concept of an atomic "quanta" of update, I will unify the
terminology ("quanta" in general) and use used_quanta_diff

> 
>> +	unsigned int i;
>> +
>> +	writer->ops->get_used(entry, cur_used);
>> +	writer->ops->get_used(target, target_used);
> 
> SMMU has get_update_safe now. Can we take it together?

I will look into the SMMUv3 get_update_safe implementation. Or integrate
that specially when we transition the ARM SMMUv3 driver to use this
generic entry_sync library.

> 
>> +void NS(entry_sync_write)(struct entry_sync_writer *writer, quanta_t *entry,
>> +			  const quanta_t *target, quanta_t *memory,
>> +			  size_t memory_len)
>> +{
>> +	quanta_t *unused_update = memory + writer->num_quantas * 0;
>> +	u8 used_qword_diff;
>> +
>> +	if (WARN_ON(memory_len !=
>> +		    ENTRY_SYNC_MEMORY_LEN(writer) * sizeof(*memory)))
>> +		return;
>> +
>> +	used_qword_diff = NS(entry_quanta_diff)(writer, entry, target,
>> +						unused_update, memory);
>> +	if (hweight8(used_qword_diff) == 1) {
>> +		/*
>> +		 * Only one quanta needs its used bits to be changed. This is a
>> +		 * hitless update, update all bits the current entry is ignoring
>> +		 * to their new values, then update a single "critical quanta"
>> +		 * to change the entry and finally 0 out any bits that are now
>> +		 * unused in the target configuration.
>> +		 */
>> +		unsigned int critical_qword_index = ffs(used_qword_diff) - 1;
>> +
>> +		/*
>> +		 * Skip writing unused bits in the critical quanta since we'll
>> +		 * be writing it in the next step anyways. This can save a sync
>> +		 * when the only change is in that quanta.
>> +		 */
>> +		unused_update[critical_qword_index] =
>> +			entry[critical_qword_index];
>> +		NS(entry_set)(writer, entry, unused_update, 0,
>> +			      writer->num_quantas);
>> +		NS(entry_set)(writer, entry, target, critical_qword_index, 1);
>> +		NS(entry_set)(writer, entry, target, 0, writer->num_quantas);
>> +	} else if (used_qword_diff) {
>> +		/*
>> +		 * At least two quantas need their inuse bits to be changed.
>> +		 * This requires a breaking update, zero the V bit, write all
>> +		 * qwords but 0, then set qword 0
>> +		 */
> 
> Still, it'd be nicer to unify the wording between "quanta" and
> "qword".

Yes.

> 
> [..]
>> +EXPORT_SYMBOL(NS(entry_sync_write));
> 
> There is also a KUNIT test coverage in arm-smmu-v3 for all of these
> functions. Maybe we can make that generic as well?

Same here.

> 
>> +#define entry_sync_writer entry_sync_writer64
>> +#define quanta_t __le64
> [..]
>> +#define entry_sync_writer entry_sync_writer128
>> +#define quanta_t u128
> 
> u64 can be called 64 too, though we might not have use case for now.
> 
> But maybe we could just call them:
>      entry_sync_writer_le64
>      entry_sync_writer_u128
> ?
I'm fine with the new naming. It is more explicit. I will update the
names unless there are further objections.

Thanks,
baolu
