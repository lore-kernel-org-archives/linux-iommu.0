From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Subject: Re: [PATCH 1/5] iommu/arm-smmu-v3: put off the execution of TLBI* to
 reduce lock confliction
Date: Thu, 29 Jun 2017 10:08:15 +0800
Message-ID: <5954610F.9020807@huawei.com>
References: <1498484330-10840-1-git-send-email-thunder.leizhen@huawei.com>
 <1498484330-10840-2-git-send-email-thunder.leizhen@huawei.com>
 <20170628093207.GB11053@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170628093207.GB11053@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Will Deacon <will.deacon@arm.com>
Cc: John Garry <john.garry@huawei.com>, Joerg Roedel <joro@8bytes.org>, Hanjun Guo <guohanjun@huawei.com>, linux-kernel <linux-kernel@vger.kernel.org>, Xinwei Hu <huxinwei@huawei.com>, iommu <iommu@lists.linux-foundation.org>, Zefan Li <lizefan@huawei.com>, nwatters@codeaurora.org, Tianhong Ding <dingtianhong@huawei.com>, Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: iommu@lists.linux-foundation.org



On 2017/6/28 17:32, Will Deacon wrote:
> Hi Zhen Lei,
> 
> Nate (CC'd), Robin and I have been working on something very similar to
> this series, but this patch is different to what we had planned. More below.
> 
> On Mon, Jun 26, 2017 at 09:38:46PM +0800, Zhen Lei wrote:
>> Because all TLBI commands should be followed by a SYNC command, to make
>> sure that it has been completely finished. So we can just add the TLBI
>> commands into the queue, and put off the execution until meet SYNC or
>> other commands. To prevent the followed SYNC command waiting for a long
>> time because of too many commands have been delayed, restrict the max
>> delayed number.
>>
>> According to my test, I got the same performance data as I replaced writel
>> with writel_relaxed in queue_inc_prod.
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>  drivers/iommu/arm-smmu-v3.c | 42 +++++++++++++++++++++++++++++++++++++-----
>>  1 file changed, 37 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
>> index 291da5f..4481123 100644
>> --- a/drivers/iommu/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm-smmu-v3.c
>> @@ -337,6 +337,7 @@
>>  /* Command queue */
>>  #define CMDQ_ENT_DWORDS			2
>>  #define CMDQ_MAX_SZ_SHIFT		8
>> +#define CMDQ_MAX_DELAYED		32
>>  
>>  #define CMDQ_ERR_SHIFT			24
>>  #define CMDQ_ERR_MASK			0x7f
>> @@ -472,6 +473,7 @@ struct arm_smmu_cmdq_ent {
>>  			};
>>  		} cfgi;
>>  
>> +		#define CMDQ_OP_TLBI_NH_ALL	0x10
>>  		#define CMDQ_OP_TLBI_NH_ASID	0x11
>>  		#define CMDQ_OP_TLBI_NH_VA	0x12
>>  		#define CMDQ_OP_TLBI_EL2_ALL	0x20
>> @@ -499,6 +501,7 @@ struct arm_smmu_cmdq_ent {
>>  
>>  struct arm_smmu_queue {
>>  	int				irq; /* Wired interrupt */
>> +	u32				nr_delay;
>>  
>>  	__le64				*base;
>>  	dma_addr_t			base_dma;
>> @@ -722,11 +725,16 @@ static int queue_sync_prod(struct arm_smmu_queue *q)
>>  	return ret;
>>  }
>>  
>> -static void queue_inc_prod(struct arm_smmu_queue *q)
>> +static void queue_inc_swprod(struct arm_smmu_queue *q)
>>  {
>> -	u32 prod = (Q_WRP(q, q->prod) | Q_IDX(q, q->prod)) + 1;
>> +	u32 prod = q->prod + 1;
>>  
>>  	q->prod = Q_OVF(q, q->prod) | Q_WRP(q, prod) | Q_IDX(q, prod);
>> +}
>> +
>> +static void queue_inc_prod(struct arm_smmu_queue *q)
>> +{
>> +	queue_inc_swprod(q);
>>  	writel(q->prod, q->prod_reg);
>>  }
>>  
>> @@ -761,13 +769,24 @@ static void queue_write(__le64 *dst, u64 *src, size_t n_dwords)
>>  		*dst++ = cpu_to_le64(*src++);
>>  }
>>  
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
> 
> So here, you're effectively putting invalidation commands into the command
> queue without updating PROD. Do you actually see a performance advantage
> from doing so? Another side of the argument would be that we should be
Yes, my sas ssd performance test showed that it can improve about 100-150K/s(the same to I directly replace
writel with writel_relaxed). And the average execution time of iommu_unmap(which called by iommu_dma_unmap_sg)
dropped from 10us to 5us.

> moving PROD as soon as we can, so that the SMMU can process invalidation
> commands in the background and reduce the cost of the final SYNC operation
> when the high-level unmap operation is complete.
There maybe that __iowmb() is more expensive than wait for tlbi complete. Except the time of __iowmb()
itself, it also protected by spinlock, lock confliction will rise rapidly in the stress scene. __iowmb()
average cost 300-500ns(Sorry, I forget the exact value).

In addition, after applied this patcheset and Robin's v2, and my earlier dma64 iova optimization patchset.
Our net performance test got the same data to global bypass. But sas ssd still have more than 20% dropped.
Maybe we should still focus at map/unamp, because the average execution time of iova alloc/free is only
about 400ns.

By the way, patch2-5 is more effective than this one, it can improve more than 350K/s. And with it, we can
got about 100-150K/s improvement of Robin's v2. Otherwise, I saw non effective of Robin's v2. Sorry, I have
not tested how about this patch without patch2-5. Further more, I got the same performance data to global
bypass for the traditional mechanical hard disk with only patch2-5(without this patch and Robin's).

> 
> Will
> 
> .
> 

-- 
Thanks!
BestRegards
