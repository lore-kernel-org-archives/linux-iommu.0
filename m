From: "Leizhen (ThunderTown)" <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2 7/7] iommu/arm-smmu: Support non-PCI devices with SMMUv3
Date: Fri, 17 Jun 2016 09:54:11 +0800
Message-ID: <57635843.6000906@huawei.com>
References: <cover.1464966939.git.robin.murphy@arm.com>
	<42a8a71932f766d70ea9dcae5d11d5f33dcc3652.1464966939.git.robin.murphy@arm.com>
	<20160614151642.GC16531@arm.com> <5760ADC6.8000803@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <5760ADC6.8000803-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi,
I only applied these patch series on lastest 4.7-rc3, is there any patches I missed?
According to my test, it seems can not work. The problem is:

[    0.916536] Call trace:
[    0.918967] [<ffff00000808882c>] dump_backtrace+0x0/0x1ac
[    0.924361] [<ffff0000080889ec>] show_stack+0x14/0x1c
[    0.929384] [<ffff00000833c290>] dump_stack+0x8c/0xac
[    0.934425] [<ffff000008093550>] do_iommu_attach.isra.11+0x24/0x7c				//called iommu_get_domain_for_dev, but currently dev->iommu_group is NULL
[    0.940589] [<ffff000008093604>] __iommu_attach_notifier.part.13+0x5c/0xc8
[    0.947443] [<ffff000008093690>] __iommu_attach_notifier+0x20/0x2c
[    0.953608] [<ffff0000080d4c88>] notifier_call_chain+0x4c/0x88
[    0.959408] [<ffff0000080d5010>] __blocking_notifier_call_chain+0x44/0x74
[    0.966159] [<ffff0000080d5054>] blocking_notifier_call_chain+0x14/0x1c
[    0.972754] [<ffff000008489600>] device_add+0x3ac/0x53c
[    0.977959] [<ffff000008671810>] of_device_add+0x58/0x64
[    0.983240] [<ffff0000086720c8>] of_platform_device_create_pdata+0x90/0xe8
[    0.990077] [<ffff00000867220c>] of_platform_bus_create+0xd0/0x31c
[    0.996265] [<ffff000008672574>] of_platform_populate+0x48/0xac
[    1.002169] [<ffff000008af2654>] arm64_device_init+0x30/0x58
[    1.007813] [<ffff000008081a14>] do_one_initcall+0x38/0x128
[    1.013354] [<ffff000008af0cc4>] kernel_init_freeable+0x14c/0x1ec
[    1.019439] [<ffff0000087a92d0>] kernel_init+0x10/0xfc
[    1.024556] [<ffff000008084e10>] ret_from_fork+0x10/0x40

[    0.906207] Failed to set up IOMMU for device tst_smmu; retaining platform DMA ops		//error info

[    0.963782] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    0.970442] ACPI: Interpreter disabled.
[    0.974429] arm-smmu-v3 d0040000.smmu_alg: ias 44-bit, oas 44-bit (features 0x00000f0d)

[    0.996948] Call trace:
[    0.999400] [<ffff00000808882c>] dump_backtrace+0x0/0x1ac
[    1.004787] [<ffff0000080889ec>] show_stack+0x14/0x1c
[    1.009846] [<ffff00000833c290>] dump_stack+0x8c/0xac
[    1.014905] [<ffff0000084829d4>] arm_smmu_add_device+0x44/0x160
[    1.020801] [<ffff00000847a218>] add_iommu_group+0x20/0x44
[    1.026291] [<ffff00000848a43c>] bus_for_each_dev+0x58/0x98
[    1.031866] [<ffff00000847b220>] bus_set_iommu+0x9c/0xf8
[    1.037150] [<ffff000008b1b420>] arm_smmu_init+0x78/0x84
[    1.042475] [<ffff000008081a14>] do_one_initcall+0x38/0x128
[    1.048043] [<ffff000008af0cc4>] kernel_init_freeable+0x14c/0x1ec
[    1.054138] [<ffff0000087a931c>] kernel_init+0x10/0xfc
[    1.059264] [<ffff000008084e10>] ret_from_fork+0x10/0x40

[    1.171026] iommu: Adding device tst_smmu to group 0						//It's already late.

On 2016/6/15 9:22, Leizhen (ThunderTown) wrote:
> 
> 
> On 2016/6/14 23:16, Will Deacon wrote:
>> [adding ThunderTown, since he might be able to test this for us]
> 
> OK. I'm so glad to do it.
> 
>>
>> On Fri, Jun 03, 2016 at 06:15:42PM +0100, Robin Murphy wrote:
>>> With the device <-> stream ID relationship suitably abstracted and
>>> of_xlate() hooked up, we no longer have any PCI-specifics in play,
>>> so adding support for the simpler kinds of platform device (a single
>>> unique stream ID each) becomes trivial; let's do it!
>>>
>>> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
>>> ---
>>>
>>> v2: New. Consider this one "extra bonus material" as I'm not sure there
>>>     are even any suitable devices on our model to test it with (it
>>>     _should_ be OK, given that I know the basic infrastructure on either
>>>     side works...)
>>>
>>>  drivers/iommu/Kconfig       |  2 +-
>>>  drivers/iommu/arm-smmu-v3.c | 36 ++++++++++++++++++++++++++++++------
>>>  2 files changed, 31 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
>>> index ad0860383cb3..d1c66afefeed 100644
>>> --- a/drivers/iommu/Kconfig
>>> +++ b/drivers/iommu/Kconfig
>>> @@ -308,7 +308,7 @@ config ARM_SMMU
>>>  
>>>  config ARM_SMMU_V3
>>>  	bool "ARM Ltd. System MMU Version 3 (SMMUv3) Support"
>>> -	depends on ARM64 && PCI
>>> +	depends on ARM64
>>>  	select IOMMU_API
>>>  	select IOMMU_IO_PGTABLE_LPAE
>>>  	select GENERIC_MSI_IRQ_DOMAIN
>>> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
>>> index 28dcc5ca237e..6379f0ab24fc 100644
>>> --- a/drivers/iommu/arm-smmu-v3.c
>>> +++ b/drivers/iommu/arm-smmu-v3.c
>>> @@ -35,6 +35,8 @@
>>>  #include <linux/pci.h>
>>>  #include <linux/platform_device.h>
>>>  
>>> +#include <linux/amba/bus.h>
>>> +
>>>  #include "io-pgtable.h"
>>>  
>>>  /* MMIO registers */
>>> @@ -1773,6 +1775,22 @@ static void arm_smmu_remove_device(struct device *dev)
>>>  	iommu_group_remove_device(dev);
>>>  }
>>>  
>>> +static struct iommu_group *arm_smmu_device_group(struct device *dev)
>>> +{
>>> +	struct iommu_group *group;
>>> +
>>> +	/*
>>> +	 * We've currently no means of grouping non-PCI masters, so
>>> +	 * there'd better not be any non-unique stream IDs in the DT...
>>> +	 */
>>
>> Worse: what if a SID in the DT aliases with a PCI master? It might be
>> nice to have some basic snity checking, at least.
>>
>> Will
>>
>> .
>>
