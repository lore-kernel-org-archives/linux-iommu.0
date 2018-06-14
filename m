From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v9 2/2] iommu/amd: Add basic debugfs infrastructure for
 AMD IOMMU
Date: Thu, 14 Jun 2018 16:56:53 -0700
Message-ID: <ae7f8610-de9a-1c0f-478f-3f7f1c6956c4@infradead.org>
References: <152883965482.1936.13657625103232933481.stgit@taos>
 <152883969032.1936.15155267369758178246.stgit@taos>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <152883969032.1936.15155267369758178246.stgit@taos>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Gary R Hook <gary.hook@amd.com>, iommu@lists.linux-foundation.org
Cc: joro@8bytes.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On 06/12/2018 02:41 PM, Gary R Hook wrote:
> Implement a skeleton framework for debugfs support in the AMD
> IOMMU.  Add an AMD-specific Kconfig boolean that depends upon
> general enablement of DebugFS in the IOMMU.
> 
> Signed-off-by: Gary R Hook <gary.hook@amd.com>

Gary,

Looks good to me.  Thanks.

> ---
>  drivers/iommu/Kconfig             |   12 ++++++++++++
>  drivers/iommu/Makefile            |    1 +
>  drivers/iommu/amd_iommu_debugfs.c |   33 +++++++++++++++++++++++++++++++++
>  drivers/iommu/amd_iommu_init.c    |    6 ++++--
>  drivers/iommu/amd_iommu_proto.h   |    6 ++++++
>  drivers/iommu/amd_iommu_types.h   |    5 +++++
>  6 files changed, 61 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/iommu/amd_iommu_debugfs.c
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index f9af25ac409f..5a9cef113763 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -146,6 +146,18 @@ config AMD_IOMMU_V2
>  	  hardware. Select this option if you want to use devices that support
>  	  the PCI PRI and PASID interface.
>  
> +config AMD_IOMMU_DEBUGFS
> +	bool "Enable AMD IOMMU internals in DebugFS"
> +	depends on AMD_IOMMU && IOMMU_DEBUGFS
> +	---help---
> +	  !!!WARNING!!!  !!!WARNING!!!  !!!WARNING!!!  !!!WARNING!!!
> +
> +	  DO NOT ENABLE THIS OPTION UNLESS YOU REALLY, -REALLY- KNOW WHAT YOU ARE DOING!!!
> +	  Exposes AMD IOMMU device internals in DebugFS.
> +
> +	  This option is -NOT- intended for production environments, and should
> +	  not generally be enabled.
> +
>  # Intel IOMMU support
>  config DMAR_TABLE
>  	bool
> diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
> index 74cfbc392862..47fd6ea9de2d 100644
> --- a/drivers/iommu/Makefile
> +++ b/drivers/iommu/Makefile
> @@ -11,6 +11,7 @@ obj-$(CONFIG_IOMMU_IOVA) += iova.o
>  obj-$(CONFIG_OF_IOMMU)	+= of_iommu.o
>  obj-$(CONFIG_MSM_IOMMU) += msm_iommu.o
>  obj-$(CONFIG_AMD_IOMMU) += amd_iommu.o amd_iommu_init.o
> +obj-$(CONFIG_AMD_IOMMU_DEBUGFS) += amd_iommu_debugfs.o
>  obj-$(CONFIG_AMD_IOMMU_V2) += amd_iommu_v2.o
>  obj-$(CONFIG_ARM_SMMU) += arm-smmu.o
>  obj-$(CONFIG_ARM_SMMU_V3) += arm-smmu-v3.o


-- 
~Randy
