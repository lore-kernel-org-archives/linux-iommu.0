From: leizhen <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2 5/9] iommu/arm-smmu: skip the execution of
	CMD_PREFETCH_CONFIG
Date: Thu, 9 Jul 2015 09:30:44 +0800
Message-ID: <559DCEC4.7030104@huawei.com>
References: <1436239822-14132-1-git-send-email-thunder.leizhen@huawei.com>
	<1436239822-14132-6-git-send-email-thunder.leizhen@huawei.com>
	<559D1F91.6000508@arm.com> <20150708171107.GC6348@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20150708171107.GC6348-5wv7dgnIgG8@public.gmane.org>
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
Cc: "huxinwei-hv44wF8Li93QT0dZR+AlfA@public.gmane.org" <huxinwei-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Zefan Li <lizefan-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Tianhong Ding <dingtianhong-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 2015/7/9 1:11, Will Deacon wrote:
> Hi Robin,
> 
> FWIW, I already queued this ;)
> 
> On Wed, Jul 08, 2015 at 02:03:13PM +0100, Robin Murphy wrote:
>> On 07/07/15 04:30, Zhen Lei wrote:
>>> Hisilicon SMMUv3 devices treat CMD_PREFETCH_CONFIG as a illegal command,
>>> execute it will trigger GERROR interrupt. Although the gerror code manage
>>> to turn the prefetch into a SYNC, and the system can continue to run
>>> normally, but it's ugly to print error information.
>>
>> No mention of the DT binding change, and no corresponding documentation 
>> update either.
> 
> I've added that.

Thank you very much. You are a real gentleman.

> 
>>> Signed-off-by: Zhen Lei <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
>>> ---
>> [...]
>>> +static struct arm_smmu_option_prop arm_smmu_options[] = {
>>> +	{ ARM_SMMU_OPT_SKIP_PREFETCH, "hisilicon,broken-prefetch-cmd" },
>>> +	{ 0, NULL},
>>> +};
>> [...]
>>> +static void parse_driver_options(struct arm_smmu_device *smmu)
>>> +{
>>> +	int i = 0;
>>> +
>>> +	do {
>>> +		if (of_property_read_bool(smmu->dev->of_node,
>>> +						arm_smmu_options[i].prop)) {
>>> +			smmu->options |= arm_smmu_options[i].opt;
>>> +			dev_notice(smmu->dev, "option %s\n",
>>> +				arm_smmu_options[i].prop);
>>> +		}
>>> +	} while (arm_smmu_options[++i].opt);
>>> +}
>>> +
>>
>> Nitpicking for sure, but I'm still waiting for a good excuse to rewrite 
>> this overcomplicated loop logic in the SMMUv2 driver - can't we just 
>> treat a static array as a static array and iterate over the thing in the 
>> obvious way?
>>
>> 	for (i = 0; i < ARRAY_SIZE(arm_smmu_options); i++)
> 
> I'd rather have consistency with the other driver and I really have no
> personal preference about how we iterate over an array. If you have a
> technical reason to change both the drivers, please send a patch.
> 
> Will
> 
> .
> 
