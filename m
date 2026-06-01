Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97FF0363C62
	for <iommu@lists.linux.dev>; Mon,  1 Jun 2026 21:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780349001; cv=none; b=WwLNs7VGZS2fZ6l1kZ/Or4kEEcuX3RugoGYuy4ZuHj2QOHksIMcp3/Vc8nVeFoITWAOTkvW79CqZqCtE2xlWHGwjYAlU+VWxF5usLCCuPDjigI0LlA2RfVu3AP7dE+ovJdj/TKUT9GH+ECqDBeLd/j7y1whogBBWK/g+uak46zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780349001; c=relaxed/simple;
	bh=OkglKhf/e4Ihij+LZLsfFyDEAiFhUwVwN1Isl5FwdHQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T8WbJgGFBUFBSVKM1bhyyFznLOG+dY0FFPPiDn75l89vNO3dLnmPoqg0UjHy4ad/2yqMRTX6HCJ9KERmH0ZlEeczYs34YkqQfe3/u1GmE3xiT50VlB3JDmwpeOoEeXa074Oh8Qau4+RYvrvWTwfoU7MH2+HYzf4MlqdULA7E4fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=TT1RVCnR; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="TT1RVCnR"
Received: from [192.168.0.88] (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id EAE9E20B7166;
	Mon,  1 Jun 2026 14:23:05 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EAE9E20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1780348986;
	bh=GX7y2/x1j07in9PdQjtP0lVXFQBVcWgLycYttpqiiCA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TT1RVCnRPRxuTTv1+Y6Y923LIryi2X+5lt/IXEU372GeV1F3kY5NSEGsSmyyu+ad6
	 qYiTFLZaQQOKTBq0vART6J1aJ0FWF1pIK9iPSuN9vJlYJLkO9FBJOOouiKrK2myCaH
	 GZR7sd3SJ2LCA+TiHLD3q/AaV3T/I28m5CA2LCw8=
Message-ID: <99bc22c3-0fa9-044d-071c-53cc8c2b7548@linux.microsoft.com>
Date: Mon, 1 Jun 2026 14:23:18 -0700
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH V1] iommu/hyperv: Create hyperv subdirectory under
 drivers/iommu
Content-Language: en-US
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 mhklinux@outlook.com, wei.liu@kernel.org, zhangyu1@linux.microsoft.com,
 schakrabarti@linux.microsoft.com
References: <20260529014148.297154-1-mrathor@linux.microsoft.com>
 <20260601090735.00005f55@linux.microsoft.com>
From: Mukesh R <mrathor@linux.microsoft.com>
In-Reply-To: <20260601090735.00005f55@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/1/26 09:07, Jacob Pan wrote:
> Hi Mukesh,
> 
> On Thu, 28 May 2026 18:41:48 -0700
> Mukesh R <mrathor@linux.microsoft.com> wrote:
> 
>> Create hyperv subdirectory under drivers/iommu in anticipation of more
>> hyperv related files from upcoming PCI passthru and pv-IOMMU patches.
>> Also, the current file hyperv-iommu.c actually implements irq
>> remapping, so rename to more appropriate hv-irq-remap.c and move it
>> under the new hyperv subdirectory. Since this file implements
>> irq_remap_ops exposed by drivers/iommu/irq_remapping.h, it cannot be
>> relocated to the irq directory. This is in sync with other backend
>> directories like amd and intel there.
>>
>> Lastly, this file should not be tied to CONFIG_HYPERV_IOMMU, but to
>> CONFIG_HYPERV and CONFIG_IRQ_REMAP.
>>
>> Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
>> ---
>>   MAINTAINERS                                             | 2 +-
>>   drivers/iommu/Kconfig                                   | 9 ---------
>>   drivers/iommu/Makefile                                  | 2 +-
>>   drivers/iommu/hyperv/Makefile                           | 2 ++
>>   drivers/iommu/{hyperv-iommu.c => hyperv/hv-irq-remap.c} | 8 +-------
>>   drivers/iommu/irq_remapping.c                           | 2 +-
>>   6 files changed, 6 insertions(+), 19 deletions(-)
>>   create mode 100644 drivers/iommu/hyperv/Makefile
>>   rename drivers/iommu/{hyperv-iommu.c => hyperv/hv-irq-remap.c} (99%)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index b539be153f6a..93a7105e9cef 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -11988,7 +11988,7 @@ F:	drivers/clocksource/hyperv_timer.c
>>   F:	drivers/hid/hid-hyperv.c
>>   F:	drivers/hv/
>>   F:	drivers/input/serio/hyperv-keyboard.c
>> -F:	drivers/iommu/hyperv-iommu.c
>> +F:	drivers/iommu/hyperv/
>>   F:	drivers/net/ethernet/microsoft/
>>   F:	drivers/net/hyperv/
>>   F:	drivers/pci/controller/pci-hyperv-intf.c
>> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
>> index f86262b11416..1becc0f20222 100644
>> --- a/drivers/iommu/Kconfig
>> +++ b/drivers/iommu/Kconfig
>> @@ -351,15 +351,6 @@ config MTK_IOMMU_V1
>>   
>>   	  if unsure, say N here.
>>   
>> -config HYPERV_IOMMU
>> -	bool "Hyper-V IRQ Handling"
>> -	depends on HYPERV && X86
>> -	select IOMMU_API
>> -	default HYPERV
>> -	help
>> -	  Stub IOMMU driver to handle IRQs to support Hyper-V Linux
>> -	  guest and root partitions.
>> -
>>   config VIRTIO_IOMMU
>>   	tristate "Virtio IOMMU driver"
>>   	depends on VIRTIO
>> diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
>> index 0275821f4ef9..d9683422aecb 100644
>> --- a/drivers/iommu/Makefile
>> +++ b/drivers/iommu/Makefile
>> @@ -4,6 +4,7 @@ obj-$(CONFIG_AMD_IOMMU) += amd/
>>   obj-$(CONFIG_INTEL_IOMMU) += intel/
>>   obj-$(CONFIG_RISCV_IOMMU) += riscv/
>>   obj-$(CONFIG_GENERIC_PT) += generic_pt/fmt/
>> +obj-$(CONFIG_HYPERV) += hyperv/
>>   obj-$(CONFIG_IOMMU_API) += iommu.o
>>   obj-$(CONFIG_IOMMU_SUPPORT) += iommu-pages.o
>>   obj-$(CONFIG_IOMMU_API) += iommu-traces.o
>> @@ -30,7 +31,6 @@ obj-$(CONFIG_TEGRA_IOMMU_SMMU) += tegra-smmu.o
>>   obj-$(CONFIG_EXYNOS_IOMMU) += exynos-iommu.o
>>   obj-$(CONFIG_FSL_PAMU) += fsl_pamu.o fsl_pamu_domain.o
>>   obj-$(CONFIG_S390_IOMMU) += s390-iommu.o
>> -obj-$(CONFIG_HYPERV_IOMMU) += hyperv-iommu.o
>>   obj-$(CONFIG_VIRTIO_IOMMU) += virtio-iommu.o
>>   obj-$(CONFIG_IOMMU_SVA) += iommu-sva.o
>>   obj-$(CONFIG_IOMMU_IOPF) += io-pgfault.o
>> diff --git a/drivers/iommu/hyperv/Makefile
>> b/drivers/iommu/hyperv/Makefile new file mode 100644
>> index 000000000000..0053e00e08e6
>> --- /dev/null
>> +++ b/drivers/iommu/hyperv/Makefile
>> @@ -0,0 +1,2 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +obj-$(CONFIG_IRQ_REMAP) += hv-irq-remap.o
> Should the name be x86 specific? This file will never be built for ARM
> because:
>   CONFIG_IRQ_REMAP depends on:
>   depends on X86_64 && X86_IO_APIC && PCI_MSI && ACPI
> 
> perhaps, hv-x86-irq-remap.c? hv-irq-remap.c sounds like a
> generic Hyper-V IRQ-remapping backend and may be misleading once arm64
> Hyper-V IOMMU/interrupt support grows under this directory.

we could, but looking at early version of hyperv-iommu-arm.c, it looks
very similar, and so if there are very few ifdefs, we could just
keep one file rather than replicating bunch of code.

Thanks,
-Mukesh


>> diff --git a/drivers/iommu/hyperv-iommu.c
>> b/drivers/iommu/hyperv/hv-irq-remap.c similarity index 99%
>> rename from drivers/iommu/hyperv-iommu.c
>> rename to drivers/iommu/hyperv/hv-irq-remap.c
>> index 479103261ae6..b34ee9589190 100644
>> --- a/drivers/iommu/hyperv-iommu.c
>> +++ b/drivers/iommu/hyperv/hv-irq-remap.c
>> @@ -7,13 +7,11 @@
>>    *
>>    * Author : Lan Tianyu <Tianyu.Lan@microsoft.com>
>>    */
>> -
>>   #include <linux/types.h>
>>   #include <linux/interrupt.h>
>>   #include <linux/irq.h>
>>   #include <linux/iommu.h>
>>   #include <linux/module.h>
>> -
>>   #include <asm/apic.h>
>>   #include <asm/cpu.h>
>>   #include <asm/hw_irq.h>
>> @@ -22,9 +20,7 @@
>>   #include <asm/hypervisor.h>
>>   #include <asm/mshyperv.h>
>>   
>> -#include "irq_remapping.h"
>> -
>> -#ifdef CONFIG_IRQ_REMAP
>> +#include "../irq_remapping.h"
>>   
>>   /*
>>    * According 82093AA IO-APIC spec , IO APIC has a 24-entry Interrupt
>> @@ -330,5 +326,3 @@ static const struct irq_domain_ops
>> hyperv_root_ir_domain_ops = { .alloc =
>> hyperv_root_irq_remapping_alloc, .free =
>> hyperv_root_irq_remapping_free, };
>> -
>> -#endif
>> diff --git a/drivers/iommu/irq_remapping.c
>> b/drivers/iommu/irq_remapping.c index c2443659812a..41bf65e4ea88
>> 100644 --- a/drivers/iommu/irq_remapping.c
>> +++ b/drivers/iommu/irq_remapping.c
>> @@ -108,7 +108,7 @@ int __init irq_remapping_prepare(void)
>>   	else if (IS_ENABLED(CONFIG_AMD_IOMMU) &&
>>   		 amd_iommu_irq_ops.prepare() == 0)
>>   		remap_ops = &amd_iommu_irq_ops;
>> -	else if (IS_ENABLED(CONFIG_HYPERV_IOMMU) &&
>> +	else if (IS_ENABLED(CONFIG_HYPERV) &&
>>   		 hyperv_irq_remap_ops.prepare() == 0)
>>   		remap_ops = &hyperv_irq_remap_ops;
>>   	else

