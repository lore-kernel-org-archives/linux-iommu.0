From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Subject: Re: [PATCH 1/1] iommu/arm-smmu-v3: replace writel with writel_relaxed
 in queue_inc_prod
Date: Wed, 21 Jun 2017 09:28:23 +0800
Message-ID: <5949CBB7.1030908@huawei.com>
References: <1497956694-11784-1-git-send-email-thunder.leizhen@huawei.com>
 <acafb87c-4ba9-4a44-f868-c8f882717ab1@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <acafb87c-4ba9-4a44-f868-c8f882717ab1@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>, Joerg Roedel <joro@8bytes.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, iommu <iommu@lists.linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>
Cc: Xinwei Hu <huxinwei@huawei.com>, Zefan Li <lizefan@huawei.com>, Hanjun Guo <guohanjun@huawei.com>, Tianhong Ding <dingtianhong@huawei.com>
List-Id: iommu@lists.linux-foundation.org



On 2017/6/20 19:35, Robin Murphy wrote:
> On 20/06/17 12:04, Zhen Lei wrote:
>> This function is protected by spinlock, and the latter will do memory
>> barrier implicitly. So that we can safely use writel_relaxed. In fact, the
>> dmb operation will lengthen the time protected by lock, which indirectly
>> increase the locking confliction in the stress scene.
> 
> If you remove the DSB between writing the commands (to Normal memory)
> and writing the pointer (to Device memory), how can you guarantee that
> the complete command is visible to the SMMU and it isn't going to try to
> consume stale memory contents? The spinlock is irrelevant since it's
> taken *before* the command is written.
OK, I see, thanks. Let's me see if there are any other methods. And I think
that this may should be done well by hardware.

> 
> Robin.
> 
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>  drivers/iommu/arm-smmu-v3.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
>> index 380969a..d2fbee3 100644
>> --- a/drivers/iommu/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm-smmu-v3.c
>> @@ -728,7 +728,7 @@ static void queue_inc_prod(struct arm_smmu_queue *q)
>>  	u32 prod = (Q_WRP(q, q->prod) | Q_IDX(q, q->prod)) + 1;
>>
>>  	q->prod = Q_OVF(q, q->prod) | Q_WRP(q, prod) | Q_IDX(q, prod);
>> -	writel(q->prod, q->prod_reg);
>> +	writel_relaxed(q->prod, q->prod_reg);
>>  }
>>
>>  /*
>> --
>> 2.5.0
>>
>>
> 
> 
> .
> 

-- 
Thanks!
BestRegards
