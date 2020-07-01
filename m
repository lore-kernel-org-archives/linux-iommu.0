Return-Path: <SRS0=cxdO=AM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31855C433E0
	for <iommu@archiver.kernel.org>; Wed,  1 Jul 2020 01:54:25 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0131320771
	for <iommu@archiver.kernel.org>; Wed,  1 Jul 2020 01:54:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0131320771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id A12CE250E3;
	Wed,  1 Jul 2020 01:54:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8edJfhkWAmaR; Wed,  1 Jul 2020 01:54:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id BD0AF23109;
	Wed,  1 Jul 2020 01:54:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A3EFBC0865;
	Wed,  1 Jul 2020 01:54:21 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6D170C016E
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jul 2020 01:54:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 62B8F88D55
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jul 2020 01:54:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rPS1sNON5hdj for <iommu@lists.linux-foundation.org>;
 Wed,  1 Jul 2020 01:54:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 483BD88CE4
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jul 2020 01:54:19 +0000 (UTC)
IronPort-SDR: GFmyvNTOtESW3jDAWUCUEbR5v8jCMcjtlSnnNp+6VuXLYSuIw5yHCtZjQZ7ixD84lUJuqrkSjE
 Begu4cnjWkZQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9668"; a="207953980"
X-IronPort-AV: E=Sophos;i="5.75,298,1589266800"; d="scan'208";a="207953980"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2020 18:54:18 -0700
IronPort-SDR: uI1fcK2/LQWkscXrgGT+Nt1FH4qrKclVdwTneeaHmiUZPdGTv7zwjbsgzQ9SLskK6AQ4/nitpd
 cdCoIcMHYeXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,298,1589266800"; d="scan'208";a="265269594"
Received: from allen-box.sh.intel.com (HELO [10.239.159.139])
 ([10.239.159.139])
 by fmsmga007.fm.intel.com with ESMTP; 30 Jun 2020 18:54:16 -0700
Subject: Re: [PATCH v2 1/2] iommu/vt-d: Move Kconfig and Makefile bits down
 into intel directory
To: Jerry Snitselaar <jsnitsel@redhat.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org
References: <20200630200636.48600-1-jsnitsel@redhat.com>
 <20200630200636.48600-2-jsnitsel@redhat.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <67b765e4-5285-a706-f32a-f5e1bc78c306@linux.intel.com>
Date: Wed, 1 Jul 2020 09:49:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200630200636.48600-2-jsnitsel@redhat.com>
Content-Language: en-US
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Jerry,

On 7/1/20 4:06 AM, Jerry Snitselaar wrote:
> Move Intel Kconfig and Makefile bits down into intel directory
> with the rest of the Intel specific files.
> 
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu

> Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
> ---
>   drivers/iommu/Kconfig        | 86 +-----------------------------------
>   drivers/iommu/Makefile       |  8 +---
>   drivers/iommu/intel/Kconfig  | 86 ++++++++++++++++++++++++++++++++++++
>   drivers/iommu/intel/Makefile |  7 +++
>   4 files changed, 96 insertions(+), 91 deletions(-)
>   create mode 100644 drivers/iommu/intel/Kconfig
>   create mode 100644 drivers/iommu/intel/Makefile
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index 6dc49ed8377a..281cd6bd0fe0 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -176,91 +176,7 @@ config AMD_IOMMU_DEBUGFS
>   	  This option is -NOT- intended for production environments, and should
>   	  not generally be enabled.
>   
> -# Intel IOMMU support
> -config DMAR_TABLE
> -	bool
> -
> -config INTEL_IOMMU
> -	bool "Support for Intel IOMMU using DMA Remapping Devices"
> -	depends on PCI_MSI && ACPI && (X86 || IA64)
> -	select IOMMU_API
> -	select IOMMU_IOVA
> -	select NEED_DMA_MAP_STATE
> -	select DMAR_TABLE
> -	select SWIOTLB
> -	select IOASID
> -	help
> -	  DMA remapping (DMAR) devices support enables independent address
> -	  translations for Direct Memory Access (DMA) from devices.
> -	  These DMA remapping devices are reported via ACPI tables
> -	  and include PCI device scope covered by these DMA
> -	  remapping devices.
> -
> -config INTEL_IOMMU_DEBUGFS
> -	bool "Export Intel IOMMU internals in Debugfs"
> -	depends on INTEL_IOMMU && IOMMU_DEBUGFS
> -	help
> -	  !!!WARNING!!!
> -
> -	  DO NOT ENABLE THIS OPTION UNLESS YOU REALLY KNOW WHAT YOU ARE DOING!!!
> -
> -	  Expose Intel IOMMU internals in Debugfs.
> -
> -	  This option is -NOT- intended for production environments, and should
> -	  only be enabled for debugging Intel IOMMU.
> -
> -config INTEL_IOMMU_SVM
> -	bool "Support for Shared Virtual Memory with Intel IOMMU"
> -	depends on INTEL_IOMMU && X86_64
> -	select PCI_PASID
> -	select PCI_PRI
> -	select MMU_NOTIFIER
> -	select IOASID
> -	help
> -	  Shared Virtual Memory (SVM) provides a facility for devices
> -	  to access DMA resources through process address space by
> -	  means of a Process Address Space ID (PASID).
> -
> -config INTEL_IOMMU_DEFAULT_ON
> -	def_bool y
> -	prompt "Enable Intel DMA Remapping Devices by default"
> -	depends on INTEL_IOMMU
> -	help
> -	  Selecting this option will enable a DMAR device at boot time if
> -	  one is found. If this option is not selected, DMAR support can
> -	  be enabled by passing intel_iommu=on to the kernel.
> -
> -config INTEL_IOMMU_BROKEN_GFX_WA
> -	bool "Workaround broken graphics drivers (going away soon)"
> -	depends on INTEL_IOMMU && BROKEN && X86
> -	help
> -	  Current Graphics drivers tend to use physical address
> -	  for DMA and avoid using DMA APIs. Setting this config
> -	  option permits the IOMMU driver to set a unity map for
> -	  all the OS-visible memory. Hence the driver can continue
> -	  to use physical addresses for DMA, at least until this
> -	  option is removed in the 2.6.32 kernel.
> -
> -config INTEL_IOMMU_FLOPPY_WA
> -	def_bool y
> -	depends on INTEL_IOMMU && X86
> -	help
> -	  Floppy disk drivers are known to bypass DMA API calls
> -	  thereby failing to work when IOMMU is enabled. This
> -	  workaround will setup a 1:1 mapping for the first
> -	  16MiB to make floppy (an ISA device) work.
> -
> -config INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON
> -	bool "Enable Intel IOMMU scalable mode by default"
> -	depends on INTEL_IOMMU
> -	help
> -	  Selecting this option will enable by default the scalable mode if
> -	  hardware presents the capability. The scalable mode is defined in
> -	  VT-d 3.0. The scalable mode capability could be checked by reading
> -	  /sys/devices/virtual/iommu/dmar*/intel-iommu/ecap. If this option
> -	  is not selected, scalable mode support could also be enabled by
> -	  passing intel_iommu=sm_on to the kernel. If not sure, please use
> -	  the default value.
> +source "drivers/iommu/intel/Kconfig"
>   
>   config IRQ_REMAP
>   	bool "Support for Interrupt Remapping"
> diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
> index 342190196dfb..71dd2f382e78 100644
> --- a/drivers/iommu/Makefile
> +++ b/drivers/iommu/Makefile
> @@ -1,4 +1,5 @@
>   # SPDX-License-Identifier: GPL-2.0
> +obj-y += intel/
>   obj-$(CONFIG_IOMMU_API) += iommu.o
>   obj-$(CONFIG_IOMMU_API) += iommu-traces.o
>   obj-$(CONFIG_IOMMU_API) += iommu-sysfs.o
> @@ -17,13 +18,8 @@ obj-$(CONFIG_AMD_IOMMU_V2) += amd/iommu_v2.o
>   obj-$(CONFIG_ARM_SMMU) += arm_smmu.o
>   arm_smmu-objs += arm-smmu.o arm-smmu-impl.o arm-smmu-qcom.o
>   obj-$(CONFIG_ARM_SMMU_V3) += arm-smmu-v3.o
> -obj-$(CONFIG_DMAR_TABLE) += intel/dmar.o
> -obj-$(CONFIG_INTEL_IOMMU) += intel/iommu.o intel/pasid.o
> -obj-$(CONFIG_INTEL_IOMMU) += intel/trace.o
> -obj-$(CONFIG_INTEL_IOMMU_DEBUGFS) += intel/debugfs.o
> -obj-$(CONFIG_INTEL_IOMMU_SVM) += intel/svm.o
>   obj-$(CONFIG_IPMMU_VMSA) += ipmmu-vmsa.o
> -obj-$(CONFIG_IRQ_REMAP) += intel/irq_remapping.o irq_remapping.o
> +obj-$(CONFIG_IRQ_REMAP) += irq_remapping.o
>   obj-$(CONFIG_MTK_IOMMU) += mtk_iommu.o
>   obj-$(CONFIG_MTK_IOMMU_V1) += mtk_iommu_v1.o
>   obj-$(CONFIG_OMAP_IOMMU) += omap-iommu.o
> diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
> new file mode 100644
> index 000000000000..877beec9d987
> --- /dev/null
> +++ b/drivers/iommu/intel/Kconfig
> @@ -0,0 +1,86 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +# Intel IOMMU support
> +config DMAR_TABLE
> +	bool
> +
> +config INTEL_IOMMU
> +	bool "Support for Intel IOMMU using DMA Remapping Devices"
> +	depends on PCI_MSI && ACPI && (X86 || IA64)
> +	select IOMMU_API
> +	select IOMMU_IOVA
> +	select NEED_DMA_MAP_STATE
> +	select DMAR_TABLE
> +	select SWIOTLB
> +	select IOASID
> +	help
> +	  DMA remapping (DMAR) devices support enables independent address
> +	  translations for Direct Memory Access (DMA) from devices.
> +	  These DMA remapping devices are reported via ACPI tables
> +	  and include PCI device scope covered by these DMA
> +	  remapping devices.
> +
> +config INTEL_IOMMU_DEBUGFS
> +	bool "Export Intel IOMMU internals in Debugfs"
> +	depends on INTEL_IOMMU && IOMMU_DEBUGFS
> +	help
> +	  !!!WARNING!!!
> +
> +	  DO NOT ENABLE THIS OPTION UNLESS YOU REALLY KNOW WHAT YOU ARE DOING!!!
> +
> +	  Expose Intel IOMMU internals in Debugfs.
> +
> +	  This option is -NOT- intended for production environments, and should
> +	  only be enabled for debugging Intel IOMMU.
> +
> +config INTEL_IOMMU_SVM
> +	bool "Support for Shared Virtual Memory with Intel IOMMU"
> +	depends on INTEL_IOMMU && X86_64
> +	select PCI_PASID
> +	select PCI_PRI
> +	select MMU_NOTIFIER
> +	select IOASID
> +	help
> +	  Shared Virtual Memory (SVM) provides a facility for devices
> +	  to access DMA resources through process address space by
> +	  means of a Process Address Space ID (PASID).
> +
> +config INTEL_IOMMU_DEFAULT_ON
> +	def_bool y
> +	prompt "Enable Intel DMA Remapping Devices by default"
> +	depends on INTEL_IOMMU
> +	help
> +	  Selecting this option will enable a DMAR device at boot time if
> +	  one is found. If this option is not selected, DMAR support can
> +	  be enabled by passing intel_iommu=on to the kernel.
> +
> +config INTEL_IOMMU_BROKEN_GFX_WA
> +	bool "Workaround broken graphics drivers (going away soon)"
> +	depends on INTEL_IOMMU && BROKEN && X86
> +	help
> +	  Current Graphics drivers tend to use physical address
> +	  for DMA and avoid using DMA APIs. Setting this config
> +	  option permits the IOMMU driver to set a unity map for
> +	  all the OS-visible memory. Hence the driver can continue
> +	  to use physical addresses for DMA, at least until this
> +	  option is removed in the 2.6.32 kernel.
> +
> +config INTEL_IOMMU_FLOPPY_WA
> +	def_bool y
> +	depends on INTEL_IOMMU && X86
> +	help
> +	  Floppy disk drivers are known to bypass DMA API calls
> +	  thereby failing to work when IOMMU is enabled. This
> +	  workaround will setup a 1:1 mapping for the first
> +	  16MiB to make floppy (an ISA device) work.
> +
> +config INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON
> +	bool "Enable Intel IOMMU scalable mode by default"
> +	depends on INTEL_IOMMU
> +	help
> +	  Selecting this option will enable by default the scalable mode if
> +	  hardware presents the capability. The scalable mode is defined in
> +	  VT-d 3.0. The scalable mode capability could be checked by reading
> +	  /sys/devices/virtual/iommu/dmar*/intel-iommu/ecap. If this option
> +	  is not selected, scalable mode support could also be enabled by
> +	  passing intel_iommu=sm_on to the kernel. If not sure, please use
> +	  the default value.
> diff --git a/drivers/iommu/intel/Makefile b/drivers/iommu/intel/Makefile
> new file mode 100644
> index 000000000000..fb8e1e8c8029
> --- /dev/null
> +++ b/drivers/iommu/intel/Makefile
> @@ -0,0 +1,7 @@
> +# SPDX-License-Identifier: GPL-2.0
> +obj-$(CONFIG_DMAR_TABLE) += dmar.o
> +obj-$(CONFIG_INTEL_IOMMU) += iommu.o pasid.o
> +obj-$(CONFIG_INTEL_IOMMU) += trace.o
> +obj-$(CONFIG_INTEL_IOMMU_DEBUGFS) += debugfs.o
> +obj-$(CONFIG_INTEL_IOMMU_SVM) += svm.o
> +obj-$(CONFIG_IRQ_REMAP) += irq_remapping.o
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
