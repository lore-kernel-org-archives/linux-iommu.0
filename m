From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 11/12] iommu/arm-smmu: Generic IOMMU DT bindings support
Date: Wed, 2 Mar 2016 13:30:43 +0000
Message-ID: <56D6EB03.403@arm.com>
References: <cover.1456514380.git.robin.murphy@arm.com>
	<a3edd4225fe8b39440fb9b6a70a70883d3cb103b.1456514380.git.robin.murphy@arm.com>
	<004c01d1731c$968ebb30$c3ac3190$@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <004c01d1731c$968ebb30$c3ac3190$@codeaurora.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Sricharan <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Thomas.Lendacky-5C7GfCeVMHo@public.gmane.org, Marc Zyngier <Marc.Zyngier-5wv7dgnIgG8@public.gmane.org>, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, stuart.yoder-3arQi8VN3Tc@public.gmane.org, tchalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 29/02/16 18:09, Sricharan wrote:
> Hi Robin,
>
>> -----Original Message-----

[...]

>> +static int __init arm_smmu_of_init(struct device_node *np) {
>> +	struct arm_smmu_device *smmu;
>> +	struct platform_device *pdev;
>> +	int ret = arm_smmu_init();
>> +
>> +	if (ret)
>> +		return ret;
>> +
>> +	pdev = of_platform_device_create(np, NULL,
>> platform_bus_type.dev_root);
>> +	if (!pdev)
>> +		return -ENODEV;
>> +
>> +	smmu = platform_get_drvdata(pdev);
>> +	of_iommu_set_ops(np, &arm_smmu_ops);
>> +
>> +	return 0;
>> +}
>> +IOMMU_OF_DECLARE(arm_smmuv1, "arm,smmu-v1",
>> arm_smmu_of_init);
>> +IOMMU_OF_DECLARE(arm_smmuv2, "arm,smmu-v2",
>> arm_smmu_of_init);
>> +IOMMU_OF_DECLARE(arm_mmu400, "arm,mmu-400",
>> arm_smmu_of_init);
>> +IOMMU_OF_DECLARE(arm_mmu401, "arm,mmu-401",
>> arm_smmu_of_init);
>> +IOMMU_OF_DECLARE(arm_mmu500, "arm,mmu-500",
>> arm_smmu_of_init);
>> +
>   Thanks for this series. I am going to use and test this. Also I wanted to
>   ask about the iommu probe deferral series [1] to avoid early device
> registration and wanted know the direction on that ?

It's certainly on my near-term to-do list to revisit. I recall running 
into problems with that series if the IOMMU was ready but the device 
itself then requested probe deferral, and I have vague memories of 
thinking more needed to be done generally around the failure/device 
teardown path too. I also had high hopes for the on-demand device 
probing series from around the same time[2], which would have helped 
simplify things quite a bit, but that also seems to have died after a 
brief stint breaking things in -next.

Anyway, Marc reckons that we also have the exact same probe-dependency 
problem for things like IRQ-MSI bridges, so I'll be looking into a more 
general solution at some point unless anyone wants to beat me to it ;)

Thanks,
Robin.

[2]:http://thread.gmane.org/gmane.linux.acpi.devel/78833

>
> [1] http://lkml.iu.edu/hypermail/linux/kernel/1505.3/03280.html
>
> Regards,
>   Sricharan
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
