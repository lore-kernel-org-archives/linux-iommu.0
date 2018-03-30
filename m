From: Gary R Hook <gary.hook-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/2] iommu/amd: Add basic debugfs infrastructure for AMD
	IOMMU
Date: Fri, 30 Mar 2018 14:08:23 -0500
Message-ID: <3eb931c8-fd4f-f08e-3449-00eb02aff52b@amd.com>
References: <152236384612.3266.1451709369164076985.stgit@taos>
	<152236409481.3266.6464716993249076762.stgit@taos>
	<cac20ad6-4de7-b722-6ae7-769dd7655c74@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <cac20ad6-4de7-b722-6ae7-769dd7655c74-5C7GfCeVMHo@public.gmane.org>
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
To: Tom Lendacky <thomas.lendacky-5C7GfCeVMHo@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 03/29/2018 11:16 PM, Tom Lendacky wrote:
> On 3/29/2018 5:54 PM, Gary R Hook wrote:
>> Implement a skeleton framework for debugfs support in the
>> AMD IOMMU.
>>
>>
>> Signed-off-by: Gary R Hook <gary.hook-5C7GfCeVMHo@public.gmane.org>
>> ---
>>   drivers/iommu/Kconfig             |    6 ++---
>>   drivers/iommu/Makefile            |    2 +-
>>   drivers/iommu/amd_iommu_debugfs.c |   47 +++++++++++++++++++++++++++++++++++++
>>   drivers/iommu/amd_iommu_init.c    |    9 ++++---
>>   drivers/iommu/amd_iommu_proto.h   |    6 +++++
>>   drivers/iommu/amd_iommu_types.h   |    3 ++
>>   include/linux/iommu.h             |    8 +++---
>>   7 files changed, 69 insertions(+), 12 deletions(-)
>>   create mode 100644 drivers/iommu/amd_iommu_debugfs.c
>>
>> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
>> index d40248446214..8d50151d5bf4 100644
>> --- a/drivers/iommu/Kconfig
>> +++ b/drivers/iommu/Kconfig
>> @@ -65,9 +65,9 @@ config IOMMU_DEBUG
>>   	depends on DEBUG_FS
>>   	default n
>>   	help
>> -	  Base enablement for access to any IOMMU device. Allows individual
>> -	  drivers to populate debugfs for access to IOMMU registers and
>> -	  data structures.
>> +	  Enable exposure of IOMMU device internals. Allow devices to
>> +	  populate debugfs for access to IOMMU registers and data
>> +	  structures.
> 
> This help text shouldn't change just because a driver is making use of
> the interface that was created in the previous patch.

Roger. It should be changed in the base patch only.
> 
>>   
>>   config IOMMU_IOVA
>>   	tristate
>> diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
>> index 5e5c3339681d..0ca250f626d9 100644
>> --- a/drivers/iommu/Makefile
>> +++ b/drivers/iommu/Makefile
>> @@ -11,7 +11,7 @@ obj-$(CONFIG_IOMMU_IOVA) += iova.o
>>   obj-$(CONFIG_OF_IOMMU)	+= of_iommu.o
>>   obj-$(CONFIG_MSM_IOMMU) += msm_iommu.o
>>   obj-$(CONFIG_AMD_IOMMU) += amd_iommu.o amd_iommu_init.o
>> -obj-$(CONFIG_AMD_IOMMU_DEBUG) += amd_iommu_debugfs.o
>> +obj-$(CONFIG_IOMMU_DEBUG) += amd_iommu_debugfs.o
>>   obj-$(CONFIG_AMD_IOMMU_V2) += amd_iommu_v2.o
>>   obj-$(CONFIG_ARM_SMMU) += arm-smmu.o
>>   obj-$(CONFIG_ARM_SMMU_V3) += arm-smmu-v3.o
>> diff --git a/drivers/iommu/amd_iommu_debugfs.c b/drivers/iommu/amd_iommu_debugfs.c
>> new file mode 100644
>> index 000000000000..3547ad3339c1
>> --- /dev/null
>> +++ b/drivers/iommu/amd_iommu_debugfs.c
>> @@ -0,0 +1,47 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * AMD IOMMU driver
>> + *
>> + * Copyright (C) 2018 Advanced Micro Devices, Inc.
>> + *
>> + * Author: Gary R Hook <gary.hook-5C7GfCeVMHo@public.gmane.org>
>> + */
>> +
>> +#ifdef	CONFIG_IOMMU_DEBUG
> 
> Since the module won't be built unless this is defined, you don't
> need this.

For some reason my build is trying to compile this file, even though I 
have the debug option disabled. Gotta track this down.

> 
>> +
>> +#include <linux/debugfs.h>
>> +#include <linux/iommu.h>
>> +#include <linux/pci.h>
>> +#include "amd_iommu_proto.h"
>> +#include "amd_iommu_types.h"
>> +
>> +static struct dentry *iommu_debugfs_dir;
>> +static DEFINE_RWLOCK(iommu_debugfs_lock);
> 
> Use amd_iommu_...
> 
> Also, didn't you run into an issue with the CCP and debugfs creation
> during probe using a RWLOCK?  Should probably make this a mutex.

Yes, and had to make a change. I will do so here.

> 
>> +
>> +#define	MAX_NAME_LEN	20
>> +
>> +void amd_iommu_debugfs_setup(struct amd_iommu *iommu)
>> +{
>> +	char name[MAX_NAME_LEN + 1];
>> +	struct dentry *d_top;
>> +	unsigned long flags;
>> +
>> +	if (!debugfs_initialized())
>> +		return;
>> +
>> +	write_lock_irqsave(&iommu_debugfs_lock, flags);
>> +	if (!iommu_debugfs_dir && (d_top = iommu_debugfs_setup()))
>> +		iommu_debugfs_dir = debugfs_create_dir("amd", d_top);
>> +	write_unlock_irqrestore(&iommu_debugfs_lock, flags);
>> +	if (iommu_debugfs_dir) {
>> +		snprintf(name, MAX_NAME_LEN, "iommu%02d", iommu->index);
>> +		iommu->debugfs_instance = debugfs_create_dir(name,
>> +							     iommu_debugfs_dir);
>> +		if (!iommu->debugfs_instance)
>> +			debugfs_remove_recursive(iommu_debugfs_dir);
> 
> So this might cause an error.  You remove it, but don't set the variable
> to NULL, so the next IOMMU that is probed could try to use it.  But why
> are you deleting it anyway?

Right you are. My thought was to remove everything driver-specific in 
the event of a failure. Do we not like that?

> 
>> +	}
>> +
>> +	return;
>> +}
>> +
>> +#endif
>> diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
>> index 99d48c42a12f..43856c7f4ea1 100644
>> --- a/drivers/iommu/amd_iommu_init.c
>> +++ b/drivers/iommu/amd_iommu_init.c
>> @@ -89,6 +89,7 @@
>>   #define ACPI_DEVFLAG_ATSDIS             0x10000000
>>   
>>   #define LOOP_TIMEOUT	100000
>> +
> 
> Spurious newline.

D'oh!

> 
>>   /*
>>    * ACPI table definitions
>>    *
>> @@ -2720,6 +2721,7 @@ int __init amd_iommu_enable_faulting(void)
>>    */
>>   static int __init amd_iommu_init(void)
>>   {
>> +	struct amd_iommu *iommu;
>>   	int ret;
>>   
>>   	ret = iommu_go_to_state(IOMMU_INITIALIZED);
>> @@ -2729,14 +2731,15 @@ static int __init amd_iommu_init(void)
>>   			disable_iommus();
>>   			free_iommu_resources();
>>   		} else {
>> -			struct amd_iommu *iommu;
>> -
>>   			uninit_device_table_dma();
>>   			for_each_iommu(iommu)
>>   				iommu_flush_all_caches(iommu);
>>   		}
>>   	}
>>   
>> +	for_each_iommu(iommu)
>> +		amd_iommu_debugfs_setup(iommu);
>> +
>>   	return ret;
>>   }
>>   
>> @@ -2783,8 +2786,6 @@ int __init amd_iommu_detect(void)
>>   	iommu_detected = 1;
>>   	x86_init.iommu.iommu_init = amd_iommu_init;
>>   
>> -dump_stack();
>> -
>>   	return 1;
>>   }
>>   
>> diff --git a/drivers/iommu/amd_iommu_proto.h b/drivers/iommu/amd_iommu_proto.h
>> index 640c286a0ab9..e19cebc5c740 100644
>> --- a/drivers/iommu/amd_iommu_proto.h
>> +++ b/drivers/iommu/amd_iommu_proto.h
>> @@ -33,6 +33,12 @@ extern void amd_iommu_uninit_devices(void);
>>   extern void amd_iommu_init_notifier(void);
>>   extern int amd_iommu_init_api(void);
>>   
>> +#ifdef	CONFIG_IOMMU_DEBUG
> 
> Use space instead of tab.

Yep, fixed it.

> 
>> +extern void amd_iommu_debugfs_setup(struct amd_iommu *iommu);
>> +#else
>> +static inline void amd_iommu_debugfs_setup(struct amd_iommu *iommu) {}
>> +#endif
>> +
>>   /* Needed for interrupt remapping */
>>   extern int amd_iommu_prepare(void);
>>   extern int amd_iommu_enable(void);
>> diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
>> index f6b24c7d8b70..6dca9fe38518 100644
>> --- a/drivers/iommu/amd_iommu_types.h
>> +++ b/drivers/iommu/amd_iommu_types.h
>> @@ -591,6 +591,9 @@ struct amd_iommu {
>>   
>>   	u32 flags;
>>   	volatile u64 __aligned(8) cmd_sem;
>> +
>> +	/* DebugFS Info */
>> +	struct dentry *debugfs_instance;
>>   };
>>   
>>   static inline struct amd_iommu *dev_to_amd_iommu(struct device *dev)
>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>> index 98527f9b473b..dbfff811aa25 100644
>> --- a/include/linux/iommu.h
>> +++ b/include/linux/iommu.h
>> @@ -412,6 +412,10 @@ void iommu_fwspec_free(struct device *dev);
>>   int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids);
>>   const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode);
>>   
>> +#ifdef	CONFIG_IOMMU_DEBUG
>> +extern struct dentry *iommu_debugfs_setup(void);
>> +#endif
>> +
> 
> Any reason why this moved?  If it was not in the right place in the first
> patch, that's where it should be fixed.

It was in the wrong place, but you are correct. I'll properly move it in 
the other patch. Thanks.

> 
> Thanks,
> Tom
> 
>>   #else /* CONFIG_IOMMU_API */
>>   
>>   struct iommu_ops {};
>> @@ -696,10 +700,6 @@ const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode)
>>   	return NULL;
>>   }
>>   
>> -#ifdef	CONFIG_IOMMU_DEBUG
>> -extern struct dentry *iommu_debugfs_setup(void);
>> -#endif
>> -
>>   #endif /* CONFIG_IOMMU_API */
>>   
>>   #endif /* __LINUX_IOMMU_H */
>>
