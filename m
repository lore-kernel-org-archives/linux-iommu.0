From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Subject: Re: [PATCH 1/5] iommu/arm-smmu-v3: put off the execution of TLBI* to
 reduce lock confliction
Date: Wed, 23 Aug 2017 09:21:33 +0800
Message-ID: <599CD89D.7080600@huawei.com>
References: <1498484330-10840-1-git-send-email-thunder.leizhen@huawei.com>
 <1498484330-10840-2-git-send-email-thunder.leizhen@huawei.com>
 <20170822154142.GA19533@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170822154142.GA19533@8bytes.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Joerg Roedel <joro@8bytes.org>
Cc: John Garry <john.garry@huawei.com>, Hanjun Guo <guohanjun@huawei.com>, Will Deacon <will.deacon@arm.com>, linux-kernel <linux-kernel@vger.kernel.org>, Xinwei Hu <huxinwei@huawei.com>, iommu <iommu@lists.linux-foundation.org>, Zefan Li <lizefan@huawei.com>, Tianhong Ding <dingtianhong@huawei.com>, Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: iommu@lists.linux-foundation.org



On 2017/8/22 23:41, Joerg Roedel wrote:
> On Mon, Jun 26, 2017 at 09:38:46PM +0800, Zhen Lei wrote:
>> -static int queue_insert_raw(struct arm_smmu_queue *q, u64 *ent)
>> +static int queue_insert_raw(struct arm_smmu_queue *q, u64 *ent, int optimize)
>>  {
>>  	if (queue_full(q))
>>  		return -ENOSPC;
>>  
>>  	queue_write(Q_ENT(q, q->prod), ent, q->ent_dwords);
>> -	queue_inc_prod(q);
>> +
>> +	/*
>> +	 * We don't want too many commands to be delayed, this may lead the
>> +	 * followed sync command to wait for a long time.
>> +	 */
>> +	if (optimize && (++q->nr_delay < CMDQ_MAX_DELAYED)) {
>> +		queue_inc_swprod(q);
>> +	} else {
>> +		queue_inc_prod(q);
>> +		q->nr_delay = 0;
>> +	}
>> +
>>  	return 0;
>>  }
>>  
>> @@ -909,6 +928,7 @@ static void arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu)
>>  static void arm_smmu_cmdq_issue_cmd(struct arm_smmu_device *smmu,
>>  				    struct arm_smmu_cmdq_ent *ent)
>>  {
>> +	int optimize = 0;
>>  	u64 cmd[CMDQ_ENT_DWORDS];
>>  	unsigned long flags;
>>  	bool wfe = !!(smmu->features & ARM_SMMU_FEAT_SEV);
>> @@ -920,8 +940,17 @@ static void arm_smmu_cmdq_issue_cmd(struct arm_smmu_device *smmu,
>>  		return;
>>  	}
>>  
>> +	/*
>> +	 * All TLBI commands should be followed by a sync command later.
>> +	 * The CFGI commands is the same, but they are rarely executed.
>> +	 * So just optimize TLBI commands now, to reduce the "if" judgement.
>> +	 */
>> +	if ((ent->opcode >= CMDQ_OP_TLBI_NH_ALL) &&
>> +	    (ent->opcode <= CMDQ_OP_TLBI_NSNH_ALL))
>> +		optimize = 1;
>> +
>>  	spin_lock_irqsave(&smmu->cmdq.lock, flags);
>> -	while (queue_insert_raw(q, cmd) == -ENOSPC) {
>> +	while (queue_insert_raw(q, cmd, optimize) == -ENOSPC) {
>>  		if (queue_poll_cons(q, false, wfe))
>>  			dev_err_ratelimited(smmu->dev, "CMDQ timeout\n");
>>  	}
> 
> This doesn't look correct. How do you make sure that a given IOVA range
> is flushed before the addresses are reused?
Hi, Joerg:
	It's actullay guaranteed by the upper layer functions, for example:
	static int arm_lpae_unmap(
        ...
    	unmapped = __arm_lpae_unmap(data, iova, size, lvl, ptep);	//__arm_lpae_unmap will indirectly call arm_smmu_cmdq_issue_cmd to invalidate tlbs
	if (unmapped)
		io_pgtable_tlb_sync(&data->iop);			//a tlb_sync wait all tlbi operations finished

	
	I also described it in the next patch(2/5). Showed below:

Some people might ask: Is it safe to do so? The answer is yes. The standard
processing flow is:
	alloc iova
	map
	process data
	unmap
	tlb invalidation and sync
	free iova

What should be guaranteed is: "free iova" action is behind "unmap" and "tlbi
operation" action, that is what we are doing right now. This ensures that:
all TLBs of an iova-range have been invalidated before the iova reallocated.

Best regards,
	LeiZhen

> 
> 
> Regards,
> 
> 	Joerg
> 
> 
> .
> 

-- 
Thanks!
BestRegards
