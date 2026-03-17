Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45702857F0
	for <iommu@lists.linux.dev>; Tue, 17 Mar 2026 13:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773754695; cv=none; b=Ta5Z0WM5rR1mAud0cod9pKkpQlXz274tnE6HR0OkIpW6OdvoiWp3br1YJNASGbNhSKwwtWEOqFR+sCAILDtxydbfBm7MnkxAn1z7i3LBVxKl8x3xHWM9Myzbcqx0pvNA+gwda1BA5i+aGpm9ZZnjhSBobenjYFjncrixxdUpl6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773754695; c=relaxed/simple;
	bh=m4SM5UZPIgtIMDR3UP82V7wWQ5FlutJoCf0YaJi6vTI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yk75dgfNa6Q5SVJOvj6tmErpOiKpTEHecrp4vejnhlgK0o3uFiQeIWaT8v/RuA6oyP3+u1eSxu8maXwRvoSmX1KOfmBRO6Hv8I02WPURKpG/rlYC4Dl3iMy+EJqf7hYwH3eEZgFfkGbMZCFtQ2LQ2TU7JMsUroztKG7BruYUDnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 390A91477;
	Tue, 17 Mar 2026 06:38:07 -0700 (PDT)
Received: from [10.57.60.199] (unknown [10.57.60.199])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2ADA03F778;
	Tue, 17 Mar 2026 06:38:12 -0700 (PDT)
Message-ID: <6ea250dd-ab9f-4abd-8fa8-77560e5dc6ab@arm.com>
Date: Tue, 17 Mar 2026 13:38:09 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/arm-smmu-v3: Allocate cmdq_batch on the heap
To: Pranjal Shrivastava <praan@google.com>,
 Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: will@kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, jserv@ccns.ncku.edu.tw
References: <20260311094444.3714302-1-yphbchou0911@gmail.com>
 <abF6un_jrQ8zGZZ4@google.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <abF6un_jrQ8zGZZ4@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-03-11 2:22 pm, Pranjal Shrivastava wrote:
> On Wed, Mar 11, 2026 at 05:44:44PM +0800, Cheng-Yang Chou wrote:
>> The arm_smmu_cmdq_batch structure is large and was being allocated on
>> the stack in four call sites, causing stack frame sizes to exceed the
>> 1024-byte limit:
>>
>> - arm_smmu_atc_inv_domain: 1120 bytes
>> - arm_smmu_atc_inv_master: 1088 bytes
>> - arm_smmu_sync_cd: 1088 bytes
>> - __arm_smmu_tlb_inv_range: 1072 bytes
>>
>> Move these allocations to the heap using kmalloc_obj() and kfree() to
>> eliminate the -Wframe-larger-than=1024 warnings and prevent potential
>> stack overflows.

Pro tip: you can also eliminate the warning by setting CONFIG_FRAME_WARN 
to a larger number, or to 0. The default is 2048, so you're already only 
getting a warning because you've gone out of your way to ask for a 
warning. The smaller the number you choose, the more warnings you'll 
get, but does that alone justify "fixing" them?

It's certainly plausible that we could get to issuing invalidation 
commands at the bottom of a relatively long callchain through 
subsystem/client driver/DMA API code, but have you observed a stack 
overflow in practice? It's not like these functions are re-entrant, or 
calling out to unknown external code, so while ~1KB is admittedly 
reasonably big, we can at least reason that there's never going to be 
much more *beyond* that (basically just whatever 
arm_smmu_cmdq_issue_cmdlist() uses).

> Thanks for the patch. I agree that we should address these warnings, but
> moving these allocations to the heap via kmalloc_obj() in the fast path
> is problematic. Introducing heap allocation adds unnecessary latency and
> potential for allocation failure in hot paths.
> 
> So, yes, we are using a lot of stack but we're using it to do good
> things..
> 
> IMO, if we really want to address these, instead of kmalloc, we could
> potentially consider some pre-allocated per-CPU buffers (that's a lot of
> additional book-keeping though) to keep the data off the stack or
> something similar following a simple rule: The fast path must be
> deterministic- no SLAB allocations and no introducing new failure points
> 
> The last thing we'd want is a graphic driver's shrinker calling
> dma-unmaps when the system is already under heavy memory pressure and
> calling kmalloc leading to a circular dependency or allocation failure
> exactly when the system needs to perform the unmap the most.

ISTR it's worse than that, and in fact we must not even attempt to 
allocate in a reclaim path at all, or it risks deadlock. So since the 
SMMU driver cannot realistically know the context of *why* it's being 
asked to unmap/invalidate something, I'm not sure it can ever be assumed 
to be safe.

Thanks,
Robin.

> 
> Thanks,
> Praan
> 
>> Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
>> ---
>>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 66 +++++++++++++++------
>>   1 file changed, 48 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> index 4d00d796f078..734546dc6a78 100644
>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> @@ -1281,7 +1281,7 @@ static void arm_smmu_sync_cd(struct arm_smmu_master *master,
>>   			     int ssid, bool leaf)
>>   {
>>   	size_t i;
>> -	struct arm_smmu_cmdq_batch cmds;
>> +	struct arm_smmu_cmdq_batch *cmds;
>>   	struct arm_smmu_device *smmu = master->smmu;
>>   	struct arm_smmu_cmdq_ent cmd = {
>>   		.opcode	= CMDQ_OP_CFGI_CD,
>> @@ -1291,13 +1291,23 @@ static void arm_smmu_sync_cd(struct arm_smmu_master *master,
>>   		},
>>   	};
>>   
>> -	arm_smmu_cmdq_batch_init(smmu, &cmds, &cmd);
>> +	cmds = kmalloc_obj(*cmds);
>> +	if (!cmds) {
>> +		struct arm_smmu_cmdq_ent cmd_all = { .opcode = CMDQ_OP_CFGI_ALL };
>> +
>> +		WARN_ONCE(1, "arm-smmu-v3: failed to allocate cmdq_batch, falling back to full CD invalidation\n");
>> +		arm_smmu_cmdq_issue_cmd_with_sync(smmu, &cmd_all);
>> +		return;
>> +	}
>> +
>> +	arm_smmu_cmdq_batch_init(smmu, cmds, &cmd);
>>   	for (i = 0; i < master->num_streams; i++) {
>>   		cmd.cfgi.sid = master->streams[i].id;
>> -		arm_smmu_cmdq_batch_add(smmu, &cmds, &cmd);
>> +		arm_smmu_cmdq_batch_add(smmu, cmds, &cmd);
>>   	}
>>   
>> -	arm_smmu_cmdq_batch_submit(smmu, &cmds);
>> +	arm_smmu_cmdq_batch_submit(smmu, cmds);
>> +	kfree(cmds);
>>   }
>>   
>>   static void arm_smmu_write_cd_l1_desc(struct arm_smmu_cdtab_l1 *dst,
>> @@ -2225,31 +2235,37 @@ arm_smmu_atc_inv_to_cmd(int ssid, unsigned long iova, size_t size,
>>   static int arm_smmu_atc_inv_master(struct arm_smmu_master *master,
>>   				   ioasid_t ssid)
>>   {
>> -	int i;
>> +	int i, ret;
>>   	struct arm_smmu_cmdq_ent cmd;
>> -	struct arm_smmu_cmdq_batch cmds;
>> +	struct arm_smmu_cmdq_batch *cmds;
>>   
>>   	arm_smmu_atc_inv_to_cmd(ssid, 0, 0, &cmd);
>>   
>> -	arm_smmu_cmdq_batch_init(master->smmu, &cmds, &cmd);
>> +	cmds = kmalloc_obj(*cmds);
>> +	if (!cmds)
>> +		return -ENOMEM;
>> +
>> +	arm_smmu_cmdq_batch_init(master->smmu, cmds, &cmd);
>>   	for (i = 0; i < master->num_streams; i++) {
>>   		cmd.atc.sid = master->streams[i].id;
>> -		arm_smmu_cmdq_batch_add(master->smmu, &cmds, &cmd);
>> +		arm_smmu_cmdq_batch_add(master->smmu, cmds, &cmd);
>>   	}
>>   
>> -	return arm_smmu_cmdq_batch_submit(master->smmu, &cmds);
>> +	ret = arm_smmu_cmdq_batch_submit(master->smmu, cmds);
>> +	kfree(cmds);
>> +	return ret;
>>   }
>>   
>>   int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain,
>>   			    unsigned long iova, size_t size)
>>   {
>>   	struct arm_smmu_master_domain *master_domain;
>> -	int i;
>> +	int i, ret;
>>   	unsigned long flags;
>>   	struct arm_smmu_cmdq_ent cmd = {
>>   		.opcode = CMDQ_OP_ATC_INV,
>>   	};
>> -	struct arm_smmu_cmdq_batch cmds;
>> +	struct arm_smmu_cmdq_batch *cmds;
>>   
>>   	if (!(smmu_domain->smmu->features & ARM_SMMU_FEAT_ATS))
>>   		return 0;
>> @@ -2271,7 +2287,11 @@ int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain,
>>   	if (!atomic_read(&smmu_domain->nr_ats_masters))
>>   		return 0;
>>   
>> -	arm_smmu_cmdq_batch_init(smmu_domain->smmu, &cmds, &cmd);
>> +	cmds = kmalloc_obj(*cmds);
>> +	if (!cmds)
>> +		return -ENOMEM;
>> +
>> +	arm_smmu_cmdq_batch_init(smmu_domain->smmu, cmds, &cmd);
>>   
>>   	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
>>   	list_for_each_entry(master_domain, &smmu_domain->devices,
>> @@ -2294,12 +2314,14 @@ int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain,
>>   
>>   		for (i = 0; i < master->num_streams; i++) {
>>   			cmd.atc.sid = master->streams[i].id;
>> -			arm_smmu_cmdq_batch_add(smmu_domain->smmu, &cmds, &cmd);
>> +			arm_smmu_cmdq_batch_add(smmu_domain->smmu, cmds, &cmd);
>>   		}
>>   	}
>>   	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
>>   
>> -	return arm_smmu_cmdq_batch_submit(smmu_domain->smmu, &cmds);
>> +	ret = arm_smmu_cmdq_batch_submit(smmu_domain->smmu, cmds);
>> +	kfree(cmds);
>> +	return ret;
>>   }
>>   
>>   /* IO_PGTABLE API */
>> @@ -2334,7 +2356,7 @@ static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
>>   	struct arm_smmu_device *smmu = smmu_domain->smmu;
>>   	unsigned long end = iova + size, num_pages = 0, tg = 0;
>>   	size_t inv_range = granule;
>> -	struct arm_smmu_cmdq_batch cmds;
>> +	struct arm_smmu_cmdq_batch *cmds;
>>   
>>   	if (!size)
>>   		return;
>> @@ -2362,7 +2384,14 @@ static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
>>   			num_pages++;
>>   	}
>>   
>> -	arm_smmu_cmdq_batch_init(smmu, &cmds, cmd);
>> +	cmds = kmalloc_obj(*cmds);
>> +	if (!cmds) {
>> +		WARN_ONCE(1, "arm-smmu-v3: failed to allocate cmdq_batch, falling back to full TLB invalidation\n");
>> +		arm_smmu_tlb_inv_context(smmu_domain);
>> +		return;
>> +	}
>> +
>> +	arm_smmu_cmdq_batch_init(smmu, cmds, cmd);
>>   
>>   	while (iova < end) {
>>   		if (smmu->features & ARM_SMMU_FEAT_RANGE_INV) {
>> @@ -2391,10 +2420,11 @@ static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
>>   		}
>>   
>>   		cmd->tlbi.addr = iova;
>> -		arm_smmu_cmdq_batch_add(smmu, &cmds, cmd);
>> +		arm_smmu_cmdq_batch_add(smmu, cmds, cmd);
>>   		iova += inv_range;
>>   	}
>> -	arm_smmu_cmdq_batch_submit(smmu, &cmds);
>> +	arm_smmu_cmdq_batch_submit(smmu, cmds);
>> +	kfree(cmds);
>>   }
>>   
>>   static void arm_smmu_tlb_inv_range_domain(unsigned long iova, size_t size,
>> -- 
>> 2.48.1
>>
>>

