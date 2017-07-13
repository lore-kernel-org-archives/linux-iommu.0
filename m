From: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH V4 4/6] iommu/arm-smmu: Add the device_link between
	masters and smmu
Date: Thu, 13 Jul 2017 09:29:30 +0530
Message-ID: <52b24d55-b7d5-2d50-4bb4-3e94d81c1be6@codeaurora.org>
References: <1499333825-7658-1-git-send-email-vivek.gautam@codeaurora.org>
	<1499333825-7658-5-git-send-email-vivek.gautam@codeaurora.org>
	<20170712225547.GA22780@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170712225547.GA22780-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
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



On 07/13/2017 04:25 AM, Stephen Boyd wrote:
> On 07/06, Vivek Gautam wrote:
>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>> index ddbfa8ab69e6..75567d9698ab 100644
>> --- a/drivers/iommu/arm-smmu.c
>> +++ b/drivers/iommu/arm-smmu.c
>> @@ -1348,6 +1348,7 @@ static int arm_smmu_add_device(struct device *dev)
>>   	struct arm_smmu_device *smmu;
>>   	struct arm_smmu_master_cfg *cfg;
>>   	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
>> +	struct device_link *link = NULL;
> Unnecessary initialization?

Right, will drop this.
Thanks.

>
>>   	int i, ret;
>>   
>>   	if (using_legacy_binding) {
>> @@ -1403,6 +1404,16 @@ static int arm_smmu_add_device(struct device *dev)
>>   
>>   	pm_runtime_put_sync(smmu->dev);
>>   
>> +	/*
>> +	 * Establish the link between smmu and master, so that the
>> +	 * smmu gets runtime enabled/disabled as per the master's
>> +	 * needs.
>> +	 */
>> +	link = device_link_add(dev, smmu->dev, DL_FLAG_PM_RUNTIME);
>> +	if (!link)
>> +		dev_warn(smmu->dev, "Unable to create device link between %s and %s\n",
>> +			 dev_name(smmu->dev), dev_name(dev));
>> +
>>   	return 0;
>>   

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
