From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v4 6/8] iommu/arm-smmu: Implement of_xlate() for SMMUv3
Date: Fri, 15 Jul 2016 19:27:04 +0100
Message-ID: <57892AF8.3020103@arm.com>
References: <cover.1467388950.git.robin.murphy@arm.com>
 <925b054b1e96dc83c0b1dc9607785d0346187366.1467388950.git.robin.murphy@arm.com>
 <20160715135506.GA4687@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160715135506.GA4687@red-moon>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Cc: will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 15/07/16 14:55, Lorenzo Pieralisi wrote:
> On Fri, Jul 01, 2016 at 05:50:15PM +0100, Robin Murphy wrote:
> 
> [...]
> 
>> +static int arm_smmu_of_xlate(struct device *dev, struct of_phandle_args *args)
>> +{
>> +	int ret;
>> +
>> +	/* We only support PCI, for now */
>> +	if (!dev_is_pci(dev))
>> +		return -ENODEV;
> 
> Given that a) the check above is removed in a later patch and b)
> code below does not depend on SMMU v3, I think the aim should
> be to make this a core function (ie I am asking this since I will
> need it in IORT based translation and I do not want to add yet another
> *_xlate hook to iommu_op), iommu_fwspec_xlate() ?

Indeed, this is only tied to OF by the current datatypes, and that's
straightforward to change. Ultimately the purpose is just for
firmware/bus code to pass in some words of configuration data, and the
driver to respond with what corresponding runtime data it wants to
associate with the device. As I suggested over on the fsl-mc discussion,
the caller might not even really be 'firmware' at all.

> What I will do with my next RFC is move the iommu_fwspec out of
> OF_IOMMU code in a separate compilation unit and we will take the
> discussion from there.

Sounds good. If the end result starts looking clear, it might be an idea
to squash some patches and skip this intermediate OF-specific step
entirely (I was just hesitant to do that myself without a clear view of
the IORT side).

>> +
>> +	ret = iommu_fwspec_init(dev, args->np);
>> +	if (!ret)
>> +		ret = iommu_fwspec_add_ids(dev, &args->args[0], 1);
>> +
>> +	return ret;
>> +}
>> +
>>  static struct iommu_ops arm_smmu_ops = {
>>  	.capable		= arm_smmu_capable,
>>  	.domain_alloc		= arm_smmu_domain_alloc,
>> @@ -1947,6 +1894,7 @@ static struct iommu_ops arm_smmu_ops = {
>>  	.device_group		= pci_device_group,
>>  	.domain_get_attr	= arm_smmu_domain_get_attr,
>>  	.domain_set_attr	= arm_smmu_domain_set_attr,
>> +	.of_xlate		= arm_smmu_of_xlate,
>>  	.pgsize_bitmap		= -1UL, /* Restricted during device attach */
>>  };
>>  
>> @@ -2697,6 +2645,22 @@ static void __exit arm_smmu_exit(void)
>>  subsys_initcall(arm_smmu_init);
>>  module_exit(arm_smmu_exit);
>>  
>> +static int __init arm_smmu_of_init(struct device_node *np)
>> +{
>> +	static bool registered;
>> +
>> +	if (!registered)
>> +		registered = !arm_smmu_init();
> 
> We also need a static variable in arm_smmu_init() to make sure
> we do not try to execute it multiple times :( (here and
> subsys_initcall).

Strictly, yes, although since there didn't seem to be any real issue
with just letting the initcall fail when register_driver() detects the
collision, I'd hoped we might be able to keep this bodge together in one
place. I guess it might end up printing some unwanted failure message
though, so I'll take another look.

Thanks,
Robin.

> Thanks,
> Lorenzo
> 
>> +
>> +	if (!of_platform_device_create(np, NULL, platform_bus_type.dev_root))
>> +		return -ENODEV;
>> +
>> +	of_iommu_set_ops(np, &arm_smmu_ops);
>> +
>> +	return 0;
>> +}
>> +IOMMU_OF_DECLARE(arm_smmuv3, "arm,smmu-v3", arm_smmu_of_init);
>> +
>>  MODULE_DESCRIPTION("IOMMU API for ARM architected SMMUv3 implementations");
>>  MODULE_AUTHOR("Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>");
>>  MODULE_LICENSE("GPL v2");
>> -- 
>> 2.8.1.dirty
>>
> 

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
