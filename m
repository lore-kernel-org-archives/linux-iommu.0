From: Tom Lendacky <thomas.lendacky-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH v2 2/2] iommu/amd: Add basic debugfs infrastructure for
	AMD IOMMU
Date: Thu, 5 Apr 2018 15:00:13 -0500
Message-ID: <e0f5258f-f69d-d5bd-3d48-8cf0676d354a@amd.com>
References: <152286703837.3286.11286329185822795742.stgit@taos>
	<152286810663.3286.1200646003836116320.stgit@taos>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <152286810663.3286.1200646003836116320.stgit@taos>
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
To: Gary R Hook <gary.hook-5C7GfCeVMHo@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 4/4/2018 1:55 PM, Gary R Hook wrote:
> Implement a skeleton framework for debugfs support in the
> AMD IOMMU.
> 
> 
> Signed-off-by: Gary R Hook <gary.hook-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/iommu/Makefile            |    1 +
>  drivers/iommu/amd_iommu_debugfs.c |   45 +++++++++++++++++++++++++++++++++++++
>  drivers/iommu/amd_iommu_init.c    |    7 ++++--
>  drivers/iommu/amd_iommu_proto.h   |    8 ++++++-
>  drivers/iommu/amd_iommu_types.h   |    3 ++
>  5 files changed, 61 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/iommu/amd_iommu_debugfs.c
> 
> diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
> index 5eb1121d54b9..0ca250f626d9 100644
> --- a/drivers/iommu/Makefile
> +++ b/drivers/iommu/Makefile
> @@ -11,6 +11,7 @@ obj-$(CONFIG_IOMMU_IOVA) += iova.o
>  obj-$(CONFIG_OF_IOMMU)	+= of_iommu.o
>  obj-$(CONFIG_MSM_IOMMU) += msm_iommu.o
>  obj-$(CONFIG_AMD_IOMMU) += amd_iommu.o amd_iommu_init.o
> +obj-$(CONFIG_IOMMU_DEBUG) += amd_iommu_debugfs.o
>  obj-$(CONFIG_AMD_IOMMU_V2) += amd_iommu_v2.o
>  obj-$(CONFIG_ARM_SMMU) += arm-smmu.o
>  obj-$(CONFIG_ARM_SMMU_V3) += arm-smmu-v3.o
> diff --git a/drivers/iommu/amd_iommu_debugfs.c b/drivers/iommu/amd_iommu_debugfs.c
> new file mode 100644
> index 000000000000..282100a655b3
> --- /dev/null
> +++ b/drivers/iommu/amd_iommu_debugfs.c
> @@ -0,0 +1,45 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * AMD IOMMU driver
> + *
> + * Copyright (C) 2018 Advanced Micro Devices, Inc.
> + *
> + * Author: Gary R Hook <gary.hook-5C7GfCeVMHo@public.gmane.org>
> + */
> +
> +#include <linux/debugfs.h>
> +#include <linux/iommu.h>
> +#include <linux/pci.h>
> +#include "amd_iommu_proto.h"
> +#include "amd_iommu_types.h"
> +
> +static struct dentry *amd_iommu_debugfs;
> +static DEFINE_MUTEX(amd_iommu_debugfs_lock);
> +
> +#define	MAX_NAME_LEN	20
> +
> +void amd_iommu_debugfs_setup(struct amd_iommu *iommu)
> +{
> +	char name[MAX_NAME_LEN + 1];
> +	struct dentry *d_top;
> +
> +	if (!debugfs_initialized())
> +		return;
> +
> +	mutex_lock(&amd_iommu_debugfs_lock);
> +	if (!amd_iommu_debugfs) {
> +		d_top = iommu_debugfs_setup();
> +		if (d_top)
> +			amd_iommu_debugfs = debugfs_create_dir("amd", d_top);
> +	}
> +	mutex_unlock(&amd_iommu_debugfs_lock);
> +	if (amd_iommu_debugfs) {
> +		snprintf(name, MAX_NAME_LEN, "iommu%02d", iommu->index);
> +		iommu->debugfs = debugfs_create_dir(name,
> +						    amd_iommu_debugfs);
> +		if (!iommu->debugfs) {
> +			debugfs_remove_recursive(amd_iommu_debugfs);
> +			amd_iommu_debugfs = NULL;
> +		}
> +	}
> +}
> diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
> index 6fe2d0346073..43856c7f4ea1 100644
> --- a/drivers/iommu/amd_iommu_init.c
> +++ b/drivers/iommu/amd_iommu_init.c
> @@ -89,6 +89,7 @@
>  #define ACPI_DEVFLAG_ATSDIS             0x10000000
>  
>  #define LOOP_TIMEOUT	100000
> +

Spurious new line.

>  /*
>   * ACPI table definitions
>   *
> @@ -2720,6 +2721,7 @@ int __init amd_iommu_enable_faulting(void)
>   */
>  static int __init amd_iommu_init(void)
>  {
> +	struct amd_iommu *iommu;
>  	int ret;
>  
>  	ret = iommu_go_to_state(IOMMU_INITIALIZED);
> @@ -2729,14 +2731,15 @@ static int __init amd_iommu_init(void)
>  			disable_iommus();
>  			free_iommu_resources();
>  		} else {
> -			struct amd_iommu *iommu;
> -
>  			uninit_device_table_dma();
>  			for_each_iommu(iommu)
>  				iommu_flush_all_caches(iommu);
>  		}
>  	}
>  
> +	for_each_iommu(iommu)
> +		amd_iommu_debugfs_setup(iommu);
> +
>  	return ret;
>  }
>  
> diff --git a/drivers/iommu/amd_iommu_proto.h b/drivers/iommu/amd_iommu_proto.h
> index 640c286a0ab9..1cfaae28c2cd 100644
> --- a/drivers/iommu/amd_iommu_proto.h
> +++ b/drivers/iommu/amd_iommu_proto.h
> @@ -33,6 +33,12 @@ extern void amd_iommu_uninit_devices(void);
>  extern void amd_iommu_init_notifier(void);
>  extern int amd_iommu_init_api(void);
>  
> +#ifdef CONFIG_IOMMU_DEBUG
> +void amd_iommu_debugfs_setup(struct amd_iommu *iommu);
> +#else
> +static inline void amd_iommu_debugfs_setup(struct amd_iommu *iommu) {}
> +#endif
> +
>  /* Needed for interrupt remapping */
>  extern int amd_iommu_prepare(void);
>  extern int amd_iommu_enable(void);
> @@ -58,7 +64,7 @@ extern int amd_iommu_domain_clear_gcr3(struct iommu_domain *dom, int pasid);
>  extern struct iommu_domain *amd_iommu_get_v2_domain(struct pci_dev *pdev);
>  
>  #ifdef CONFIG_IRQ_REMAP
> -extern int amd_iommu_create_irq_domain(struct amd_iommu *iommu);
> +int amd_iommu_create_irq_domain(struct amd_iommu *iommu);

I don't think this change is required for the debugfs support.

Thanks,
Tom

>  #else
>  static inline int amd_iommu_create_irq_domain(struct amd_iommu *iommu)
>  {
> diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
> index f6b24c7d8b70..43c52797810e 100644
> --- a/drivers/iommu/amd_iommu_types.h
> +++ b/drivers/iommu/amd_iommu_types.h
> @@ -591,6 +591,9 @@ struct amd_iommu {
>  
>  	u32 flags;
>  	volatile u64 __aligned(8) cmd_sem;
> +
> +	/* DebugFS Info */
> +	struct dentry *debugfs;
>  };
>  
>  static inline struct amd_iommu *dev_to_amd_iommu(struct device *dev)
> 
