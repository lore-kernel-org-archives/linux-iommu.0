From: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH V4 3/6] iommu/arm-smmu: Invoke pm_runtime during probe,
	add/remove device
Date: Thu, 13 Jul 2017 10:43:59 +0530
Message-ID: <5ee0bacd-e557-a6c4-a897-844fb12ea6ae@codeaurora.org>
References: <1499333825-7658-1-git-send-email-vivek.gautam@codeaurora.org>
	<1499333825-7658-4-git-send-email-vivek.gautam@codeaurora.org>
	<20170712225459.GZ22780@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170712225459.GZ22780-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, stanimir.varbanov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Stephen,


On 07/13/2017 04:24 AM, Stephen Boyd wrote:
> On 07/06, Vivek Gautam wrote:
>> @@ -1231,12 +1237,18 @@ static int arm_smmu_map(struct iommu_domain *domain, unsigned long iova,
>>   static size_t arm_smmu_unmap(struct iommu_domain *domain, unsigned long iova,
>>   			     size_t size)
>>   {
>> -	struct io_pgtable_ops *ops = to_smmu_domain(domain)->pgtbl_ops;
>> +	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
>> +	struct io_pgtable_ops *ops = smmu_domain->pgtbl_ops;
>> +	size_t ret;
>>   
>>   	if (!ops)
>>   		return 0;
>>   
>> -	return ops->unmap(ops, iova, size);
>> +	pm_runtime_get_sync(smmu_domain->smmu->dev);
> Can these map/unmap ops be called from an atomic context? I seem
> to recall that being a problem before.

That's something which was dropped in the following patch merged in master:
523d7423e21b iommu/arm-smmu: Remove io-pgtable spinlock

Looks like we don't  need locks here anymore?

Best Regards
Vivek

>
>
>> +	ret = ops->unmap(ops, iova, size);
>> +	pm_runtime_put_sync(smmu_domain->smmu->dev);
>> +
>> +	return ret;
>>   }
>>   
>>   static phys_addr_t arm_smmu_iova_to_phys_hard(struct iommu_domain *domain,

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
