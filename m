From: "Leizhen (ThunderTown)" <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2 2/3] iommu/arm-smmu-v3: add support for unmap an iova
	range with only one tlb sync
Date: Thu, 19 Oct 2017 11:17:27 +0800
Message-ID: <59E81947.50307@huawei.com>
References: <1505221238-9428-1-git-send-email-thunder.leizhen@huawei.com>
	<1505221238-9428-3-git-send-email-thunder.leizhen@huawei.com>
	<20171018130003.GE4077@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20171018130003.GE4077-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: Kefeng Wang <wangkefeng.wang-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jinyue Li <lijinyue-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Libin <huawei.libin-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Hanjun Guo <guohanjun-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



On 2017/10/18 21:00, Will Deacon wrote:
> On Tue, Sep 12, 2017 at 09:00:37PM +0800, Zhen Lei wrote:
>> This patch is base on: 
>> (add02cfdc9bc2 "iommu: Introduce Interface for IOMMU TLB Flushing")
>>
>> Because iotlb_sync is moved out of ".unmap = arm_smmu_unmap", some interval
>> ".unmap" calls should explicitly followed by a iotlb_sync operation.
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
>> ---
>>  drivers/iommu/arm-smmu-v3.c    | 10 ++++++++++
>>  drivers/iommu/io-pgtable-arm.c | 30 ++++++++++++++++++++----------
>>  drivers/iommu/io-pgtable.h     |  1 +
>>  3 files changed, 31 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
>> index ef42c4b..e92828e 100644
>> --- a/drivers/iommu/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm-smmu-v3.c
>> @@ -1772,6 +1772,15 @@ arm_smmu_unmap(struct iommu_domain *domain, unsigned long iova, size_t size)
>>  	return ops->unmap(ops, iova, size);
>>  }
>>  
>> +static void arm_smmu_iotlb_sync(struct iommu_domain *domain)
>> +{
>> +	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
>> +	struct io_pgtable_ops *ops = smmu_domain->pgtbl_ops;
>> +
>> +	if (ops && ops->iotlb_sync)
>> +		ops->iotlb_sync(ops);
>> +}
>> +
>>  static phys_addr_t
>>  arm_smmu_iova_to_phys(struct iommu_domain *domain, dma_addr_t iova)
>>  {
>> @@ -1991,6 +2000,7 @@ static struct iommu_ops arm_smmu_ops = {
>>  	.attach_dev		= arm_smmu_attach_dev,
>>  	.map			= arm_smmu_map,
>>  	.unmap			= arm_smmu_unmap,
>> +	.iotlb_sync		= arm_smmu_iotlb_sync,
>>  	.map_sg			= default_iommu_map_sg,
>>  	.iova_to_phys		= arm_smmu_iova_to_phys,
>>  	.add_device		= arm_smmu_add_device,
>> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
>> index e8018a3..805efc9 100644
>> --- a/drivers/iommu/io-pgtable-arm.c
>> +++ b/drivers/iommu/io-pgtable-arm.c
>> @@ -304,6 +304,8 @@ static int arm_lpae_init_pte(struct arm_lpae_io_pgtable *data,
>>  		WARN_ON(!selftest_running);
>>  		return -EEXIST;
>>  	} else if (iopte_type(pte, lvl) == ARM_LPAE_PTE_TYPE_TABLE) {
>> +		size_t unmapped;
>> +
>>  		/*
>>  		 * We need to unmap and free the old table before
>>  		 * overwriting it with a block entry.
>> @@ -312,7 +314,9 @@ static int arm_lpae_init_pte(struct arm_lpae_io_pgtable *data,
>>  		size_t sz = ARM_LPAE_BLOCK_SIZE(lvl, data);
>>  
>>  		tblp = ptep - ARM_LPAE_LVL_IDX(iova, lvl, data);
>> -		if (WARN_ON(__arm_lpae_unmap(data, iova, sz, lvl, tblp) != sz))
>> +		unmapped = __arm_lpae_unmap(data, iova, sz, lvl, tblp);
>> +		io_pgtable_tlb_sync(&data->iop);
>> +		if (WARN_ON(unmapped != sz))
>>  			return -EINVAL;
>>  	}
>>  
>> @@ -584,7 +588,6 @@ static int __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
>>  			/* Also flush any partial walks */
>>  			io_pgtable_tlb_add_flush(iop, iova, size,
>>  						ARM_LPAE_GRANULE(data), false);
>> -			io_pgtable_tlb_sync(iop);
>>  			ptep = iopte_deref(pte, data);
>>  			__arm_lpae_free_pgtable(data, lvl + 1, ptep);
>>  		} else {
>> @@ -609,7 +612,6 @@ static int __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
>>  static int arm_lpae_unmap(struct io_pgtable_ops *ops, unsigned long iova,
>>  			  size_t size)
>>  {
>> -	size_t unmapped;
>>  	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
>>  	arm_lpae_iopte *ptep = data->pgd;
>>  	int lvl = ARM_LPAE_START_LVL(data);
>> @@ -617,11 +619,14 @@ static int arm_lpae_unmap(struct io_pgtable_ops *ops, unsigned long iova,
>>  	if (WARN_ON(iova >= (1ULL << data->iop.cfg.ias)))
>>  		return 0;
>>  
>> -	unmapped = __arm_lpae_unmap(data, iova, size, lvl, ptep);
>> -	if (unmapped)
>> -		io_pgtable_tlb_sync(&data->iop);
>> +	return __arm_lpae_unmap(data, iova, size, lvl, ptep);
>> +}
> 
> This change is already queued in Joerg's tree, due to a patch from Robin.
Yes, I see. So this one can be skipped.

> 
> Will
> 
> .
> 

-- 
Thanks!
BestRegards
