From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] iommu/ipmmu-vmsa: Do not replace bus IOMMU ops on driver
	init.
Date: Tue, 19 Sep 2017 11:47:00 +0100
Message-ID: <944ded5f-58b9-43a9-fe1d-191b982545fa@arm.com>
References: <20170918100444.21878-1-Liviu.Dudau@arm.com>
	<2550948.Yqn2DEl6fn@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <2550948.Yqn2DEl6fn@avalon>
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
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Liviu Dudau <Liviu.Dudau-5wv7dgnIgG8@public.gmane.org>
Cc: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, IOMMU ML <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Laurent,

On 19/09/17 08:07, Laurent Pinchart wrote:
> Hi Liviu,
> 
> Thank you for the patch.
> 
> On Monday, 18 September 2017 13:04:44 EEST Liviu Dudau wrote:
>> If the IPMMU driver is compiled in the kernel it will replace the
>> platform bus IOMMU ops on running the ipmmu_init() function, regardless
>> if there is any IPMMU hardware present or not. This screws up systems
>> that just want to build a generic kernel that runs on multiple platforms
>> and use a different IOMMU implementation.
>>
>> Move the bus_set_iommu() call at the end of the ipmmu_probe() function
>> when we know that hardware is present. With current IOMMU framework it
>> should be safe (at least for OF case).
> 
> If I recall correctly the issue is that the IPMMU might be probed after bus 
> master devices when using the legacy IOMMU DT integration, which the ipmmu-
> vmsa driver does on ARM32. Calling bus_set_iommu() from the probe function 
> will then result in some devices losing IOMMU support.

Yes, that used to be the problem, but since IPMMU uses the generic
bindings and iommu_device_register(), it should now benefit from client
probe-deferral even when it doesn't support of_xlate().

Robin.

>> Now that the ipmmu_init() and ipmmu_exit() functions are simple calls to
>> platform_driver_register() and platform_driver_unregister(), replace
>> them with the module_platform_driver() macro call.
>>
>> Signed-off-by: Liviu Dudau <Liviu.Dudau-5wv7dgnIgG8@public.gmane.org>
>> Cc: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
>> ---
>>  drivers/iommu/ipmmu-vmsa.c | 29 +++++------------------------
>>  1 file changed, 5 insertions(+), 24 deletions(-)
>>
>> diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
>> index 2a38aa15be17d..c60569c74678d 100644
>> --- a/drivers/iommu/ipmmu-vmsa.c
>> +++ b/drivers/iommu/ipmmu-vmsa.c
>> @@ -1055,10 +1055,11 @@ static int ipmmu_probe(struct platform_device *pdev)
>> ipmmu_device_reset(mmu);
>>
>>  	/*
>> -	 * We can't create the ARM mapping here as it requires the bus to have
>> -	 * an IOMMU, which only happens when bus_set_iommu() is called in
>> -	 * ipmmu_init() after the probe function returns.
>> +	 * Now that we have validated the presence of the hardware, set
>> +	 * the bus IOMMU ops to enable future domain and device setup.
>>  	 */
>> +	if (!iommu_present(&platform_bus_type))
>> +		bus_set_iommu(&platform_bus_type, &ipmmu_ops);
>>
>>  	spin_lock(&ipmmu_devices_lock);
>>  	list_add(&mmu->list, &ipmmu_devices);
> 
> What branch is this patch based on ? ipmmu_devices_lock isn't in mainline.
> 
>> @@ -1100,27 +1101,7 @@ static struct platform_driver ipmmu_driver = {
>>  	.remove	= ipmmu_remove,
>>  };
>>
>> -static int __init ipmmu_init(void)
>> -{
>> -	int ret;
>> -
>> -	ret = platform_driver_register(&ipmmu_driver);
>> -	if (ret < 0)
>> -		return ret;
>> -
>> -	if (!iommu_present(&platform_bus_type))
>> -		bus_set_iommu(&platform_bus_type, &ipmmu_ops);
>> -
>> -	return 0;
>> -}
>> -
>> -static void __exit ipmmu_exit(void)
>> -{
>> -	return platform_driver_unregister(&ipmmu_driver);
>> -}
>> -
>> -subsys_initcall(ipmmu_init);
>> -module_exit(ipmmu_exit);
>> +module_platform_driver(ipmmu_driver);
>>
>>  MODULE_DESCRIPTION("IOMMU API for Renesas VMSA-compatible IPMMU");
>>  MODULE_AUTHOR("Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>");
> 
