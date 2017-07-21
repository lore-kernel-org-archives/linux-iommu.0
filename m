From: xxm <xxm-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: Re: [PATCH V2 2/3] iommu/rockchip: add multi irqs support
Date: Fri, 21 Jul 2017 15:54:40 +0800
Message-ID: <675fd7bf-7551-4f95-9b9c-8a2151e59ee1@rock-chips.com>
References: <1500618430-114821-1-git-send-email-xxm@rock-chips.com>
	<1500618430-114821-2-git-send-email-xxm@rock-chips.com>
	<5666211.VjCXUuunyU@phil>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <5666211.VjCXUuunyU@phil>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Cc: linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Heiko,


On 07/21/2017 03:07 PM, Heiko Stuebner wrote:
> Am Freitag, 21. Juli 2017, 14:27:09 CEST schrieb Simon Xue:
>> From: Simon <xxm-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
>>
>> RK3368 vpu mmu have two irqs, this patch support multi irqs
>>
>> Signed-off-by: Simon <xxm-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
>> ---
>> changes since V1:
>>   - use devm_kcalloc instead of devm_kzalloc when alloc irq array
>>
>>   drivers/iommu/rockchip-iommu.c | 34 ++++++++++++++++++++++++----------
>>   1 file changed, 24 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
>> index 4ba48a2..3c462c0 100644
>> --- a/drivers/iommu/rockchip-iommu.c
>> +++ b/drivers/iommu/rockchip-iommu.c
>> @@ -90,7 +90,8 @@ struct rk_iommu {
>>   	struct device *dev;
>>   	void __iomem **bases;
>>   	int num_mmu;
>> -	int irq;
>> +	int *irq;
>> +	int num_irq;
>>   	struct iommu_device iommu;
>>   	struct list_head node; /* entry in rk_iommu_domain.iommus */
>>   	struct iommu_domain *domain; /* domain to which iommu is attached */
>> @@ -825,10 +826,12 @@ static int rk_iommu_attach_device(struct iommu_domain *domain,
>>   
>>   	iommu->domain = domain;
>>   
>> -	ret = devm_request_irq(iommu->dev, iommu->irq, rk_iommu_irq,
>> -			       IRQF_SHARED, dev_name(dev), iommu);
>> -	if (ret)
>> -		return ret;
>> +	for (i = 0; i < iommu->num_irq; i++) {
>> +		ret = devm_request_irq(iommu->dev, iommu->irq[i], rk_iommu_irq,
>> +				       IRQF_SHARED, dev_name(dev), iommu);
>> +		if (ret)
>> +			return ret;
>> +	}
>>   
>>   	for (i = 0; i < iommu->num_mmu; i++) {
>>   		rk_iommu_write(iommu->bases[i], RK_MMU_DTE_ADDR,
>> @@ -878,7 +881,8 @@ static void rk_iommu_detach_device(struct iommu_domain *domain,
>>   	}
>>   	rk_iommu_disable_stall(iommu);
>>   
>> -	devm_free_irq(iommu->dev, iommu->irq, iommu);
>> +	for (i = 0; i < iommu->num_irq; i++)
>> +		devm_free_irq(iommu->dev, iommu->irq[i], iommu);
>>   
>>   	iommu->domain = NULL;
>>   
>> @@ -1157,10 +1161,20 @@ static int rk_iommu_probe(struct platform_device *pdev)
>>   	if (iommu->num_mmu == 0)
>>   		return PTR_ERR(iommu->bases[0]);
>>   
>> -	iommu->irq = platform_get_irq(pdev, 0);
>> -	if (iommu->irq < 0) {
>> -		dev_err(dev, "Failed to get IRQ, %d\n", iommu->irq);
>> -		return -ENXIO;
>> +	while (platform_get_irq(pdev, iommu->num_irq) >= 0)
>> +		iommu->num_irq++;
> Hmm, this could also result in a iommu having 0 irqs if wrongly
> configured and probe would still suceed. This sounds somehow
> wrong to me.
>
> But I'm not sure if there is precedent on how to handle a variable
> number of interrupts correctly somewhere.

How about add a judgement for iommu->num_irq ? like this:
if (!iommu->num_irq)
	return -ENOXIO;

>
> Heiko
>
>> +
>> +	iommu->irq = devm_kcalloc(dev, iommu->num_irq, sizeof(*iommu->irq),
>> +				  GFP_KERNEL);
>> +	if (!iommu->irq)
>> +		return -ENOMEM;
>> +
>> +	for (i = 0; i < iommu->num_irq; i++) {
>> +		iommu->irq[i] = platform_get_irq(pdev, i);
>> +		if (iommu->irq[i] < 0) {
>> +			dev_err(dev, "Failed to get IRQ, %d\n", iommu->irq[i]);
>> +			return -ENXIO;
>> +		}
>>   	}
>>   
>>   	err = iommu_device_sysfs_add(&iommu->iommu, dev, NULL, dev_name(dev));
>>
>
>
>
>
