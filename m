Return-Path: <SRS0=B8VN=72=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D09DFC433DF
	for <iommu@archiver.kernel.org>; Sat, 13 Jun 2020 01:51:07 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6901F20656
	for <iommu@archiver.kernel.org>; Sat, 13 Jun 2020 01:51:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6901F20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 07A8288E15;
	Sat, 13 Jun 2020 01:51:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xHRqI6wwRO1x; Sat, 13 Jun 2020 01:51:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id B315088E09;
	Sat, 13 Jun 2020 01:51:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A341BC0178;
	Sat, 13 Jun 2020 01:51:05 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4FBDEC016F
 for <iommu@lists.linux-foundation.org>; Sat, 13 Jun 2020 01:51:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 43EC988E10
 for <iommu@lists.linux-foundation.org>; Sat, 13 Jun 2020 01:51:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Wl0VC6pJrEZy for <iommu@lists.linux-foundation.org>;
 Sat, 13 Jun 2020 01:51:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 648FF88E09
 for <iommu@lists.linux-foundation.org>; Sat, 13 Jun 2020 01:51:01 +0000 (UTC)
IronPort-SDR: gug64eVdY5Rb8AZVplMGwfcQNdP+TUZEbR5ELWqoFf5hQWrKtWaU0PL9N+p1VXq+Dz7BmBxMwg
 gnkuzCDnBxtA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2020 18:51:00 -0700
IronPort-SDR: n8TOZwXxQc2vY+AGE8N2oqpIokLbdl8tXdJSHEmLFkbFrt/6Ilm2Yv4s5knPtHavTGnSwrqNXi
 Uw+7RcvzMTzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,505,1583222400"; d="scan'208";a="290053968"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.249.171.228])
 ([10.249.171.228])
 by orsmga002.jf.intel.com with ESMTP; 12 Jun 2020 18:50:58 -0700
Subject: Re: [PATCH 1/2] iommu/vt-d: Move Kconfig and Makefile bits down into
 intel directory
To: Jerry Snitselaar <jsnitsel@redhat.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org
References: <20200612231100.293734-1-jsnitsel@redhat.com>
 <20200612231100.293734-2-jsnitsel@redhat.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <7a5aac8f-3354-cc36-2f44-2ae6a46ed527@linux.intel.com>
Date: Sat, 13 Jun 2020 09:50:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200612231100.293734-2-jsnitsel@redhat.com>
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

On 2020/6/13 7:10, Jerry Snitselaar wrote:
> Move Intel Kconfig and Makefile bits down into intel directory
> with the rest of the Intel specific files.
> 
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Lu Baolu <baolu.lu@linux.intel.com>

Thanks!

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
> index aca76383f201..b12d4ec124f6 100644
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
> -	depends on INTEL_IOMMU && X86
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
> -	---help---
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
> -	---help---
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
> index 000000000000..ef5c4a7a9399
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
> +	depends on INTEL_IOMMU && X86
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
