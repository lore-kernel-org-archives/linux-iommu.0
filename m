Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8E237C930
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 23:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780530970; cv=none; b=jgwjtICSK0Y/GkoogSPzdogoxJknYitqM6Z4cif5bnx4Rsf5r39CrKTJLHH7jrKNA/50Y9X9KYA7bTrT2gDBBk6AQ2lYVxqiNFAquLJH40MicpA23/x9nItZGMDR017aypAHelLSwdmbcIyTXi1FfzJFq8GJA0oP0E31IWNfKCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780530970; c=relaxed/simple;
	bh=WPPaD+cosOhIgBRIvRgBpZDA9QOcO9PXvpxxnO+Y6ic=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cjU07VtTfso4Dt7d2KPTKc0YiFMyNYyIKmbqoJhX9nYHKFUnMbOUDC/hOv35XRk3wg3TQNRVlJ/CkOsalxfGouOKABsqB6QEMVk8Zc3awP4ylCY9nLDsn0atEgDqgRdwJpHd/YvyRfuMfs0993SzQE9s1FEYMeFOGEGpIThUriI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=fPeHkIoS; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="fPeHkIoS"
Received: from localhost (unknown [52.148.140.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id 686B620B7168;
	Wed,  3 Jun 2026 16:55:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 686B620B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1780530951;
	bh=M6jDSCL48RubWv6igHsQlwzlRhKiRg4iJ9FQaJmT6hU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fPeHkIoSJdsAltLiKHpjs383o0Q9HTlt7cR/k1ToFwYettIdRlt/1Jciyo0E9rQI+
	 zA25qehpfEC2s0uCxQmovK+QS1+VPY8L4GaVFcOKcQN001y/BV9aAXiUhUsVzCcO7Y
	 myjk5cl8R1pnxwLpefEnfXN4fSljh5XtxPX6pdeY=
Date: Wed, 3 Jun 2026 16:56:04 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Mukesh R <mrathor@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 mhklinux@outlook.com, wei.liu@kernel.org, zhangyu1@linux.microsoft.com,
 schakrabarti@linux.microsoft.com, jacob.pan@linux.microsoft.com
Subject: Re: [PATCH V2] iommu/hyperv: Create hyperv subdirectory under
 drivers/iommu
Message-ID: <20260603165604.00006e9f@linux.microsoft.com>
In-Reply-To: <20260603225010.1347623-1-mrathor@linux.microsoft.com>
References: <20260603225010.1347623-1-mrathor@linux.microsoft.com>
Organization: LSG
X-Mailer: Claws Mail 3.21.0 (GTK+ 2.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Mukesh,

On Wed,  3 Jun 2026 15:50:10 -0700
Mukesh R <mrathor@linux.microsoft.com> wrote:

> Create hyperv subdirectory under drivers/iommu in anticipation of more
> hyperv related files from upcoming PCI passthru and pv-IOMMU patches.
> Also, the current file hyperv-iommu.c actually implements irq
> remapping on x86, so rename to more appropriate hv-irq-remap-x86.c
> and move it under the new hyperv subdirectory. Since this file
> implements irq_remap_ops exposed by drivers/iommu/irq_remapping.h, it
> cannot be relocated to the irq directory. This is in sync with other
> backend directories like amd and intel there.
> 
> Lastly, this file should not be tied to CONFIG_HYPERV_IOMMU, but to
> CONFIG_HYPERV and CONFIG_IRQ_REMAP.
> 
> Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
> ---
> V2: rename hv-irq-remap.c to hv-irq-remap-x86.c
> ---
>  MAINTAINERS                                              | 2 +-
>  drivers/iommu/Kconfig                                    | 9
> --------- drivers/iommu/Makefile                                   |
> 2 +- drivers/iommu/hyperv/Makefile                            | 2 ++
>  .../iommu/{hyperv-iommu.c => hyperv/hv-irq-remap-x86.c}  | 8 +-------
>  drivers/iommu/irq_remapping.c                            | 2 +-
>  6 files changed, 6 insertions(+), 19 deletions(-)
>  create mode 100644 drivers/iommu/hyperv/Makefile
>  rename drivers/iommu/{hyperv-iommu.c => hyperv/hv-irq-remap-x86.c}
> (99%)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b539be153f6a..93a7105e9cef 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11988,7 +11988,7 @@ F:	drivers/clocksource/hyperv_timer.c
>  F:	drivers/hid/hid-hyperv.c
>  F:	drivers/hv/
>  F:	drivers/input/serio/hyperv-keyboard.c
> -F:	drivers/iommu/hyperv-iommu.c
> +F:	drivers/iommu/hyperv/
>  F:	drivers/net/ethernet/microsoft/
>  F:	drivers/net/hyperv/
>  F:	drivers/pci/controller/pci-hyperv-intf.c
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index f86262b11416..1becc0f20222 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -351,15 +351,6 @@ config MTK_IOMMU_V1
>  
>  	  if unsure, say N here.
>  
> -config HYPERV_IOMMU
> -	bool "Hyper-V IRQ Handling"
> -	depends on HYPERV && X86
> -	select IOMMU_API
> -	default HYPERV
> -	help
> -	  Stub IOMMU driver to handle IRQs to support Hyper-V Linux
> -	  guest and root partitions.
> -
>  config VIRTIO_IOMMU
>  	tristate "Virtio IOMMU driver"
>  	depends on VIRTIO
> diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
> index 0275821f4ef9..d9683422aecb 100644
> --- a/drivers/iommu/Makefile
> +++ b/drivers/iommu/Makefile
> @@ -4,6 +4,7 @@ obj-$(CONFIG_AMD_IOMMU) += amd/
>  obj-$(CONFIG_INTEL_IOMMU) += intel/
>  obj-$(CONFIG_RISCV_IOMMU) += riscv/
>  obj-$(CONFIG_GENERIC_PT) += generic_pt/fmt/
> +obj-$(CONFIG_HYPERV) += hyperv/
>  obj-$(CONFIG_IOMMU_API) += iommu.o
>  obj-$(CONFIG_IOMMU_SUPPORT) += iommu-pages.o
>  obj-$(CONFIG_IOMMU_API) += iommu-traces.o
> @@ -30,7 +31,6 @@ obj-$(CONFIG_TEGRA_IOMMU_SMMU) += tegra-smmu.o
>  obj-$(CONFIG_EXYNOS_IOMMU) += exynos-iommu.o
>  obj-$(CONFIG_FSL_PAMU) += fsl_pamu.o fsl_pamu_domain.o
>  obj-$(CONFIG_S390_IOMMU) += s390-iommu.o
> -obj-$(CONFIG_HYPERV_IOMMU) += hyperv-iommu.o
>  obj-$(CONFIG_VIRTIO_IOMMU) += virtio-iommu.o
>  obj-$(CONFIG_IOMMU_SVA) += iommu-sva.o
>  obj-$(CONFIG_IOMMU_IOPF) += io-pgfault.o
> diff --git a/drivers/iommu/hyperv/Makefile
> b/drivers/iommu/hyperv/Makefile new file mode 100644
> index 000000000000..6ef0ef97f3dd
> --- /dev/null
> +++ b/drivers/iommu/hyperv/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0
> +obj-$(CONFIG_IRQ_REMAP) += hv-irq-remap-x86.o
> diff --git a/drivers/iommu/hyperv-iommu.c
> b/drivers/iommu/hyperv/hv-irq-remap-x86.c similarity index 99%
> rename from drivers/iommu/hyperv-iommu.c
> rename to drivers/iommu/hyperv/hv-irq-remap-x86.c
> index 479103261ae6..b34ee9589190 100644
> --- a/drivers/iommu/hyperv-iommu.c
> +++ b/drivers/iommu/hyperv/hv-irq-remap-x86.c
> @@ -7,13 +7,11 @@
>   *
>   * Author : Lan Tianyu <Tianyu.Lan@microsoft.com>
>   */
> -
nit:  we can avoid unrelated whitespace churn.

>  #include <linux/types.h>
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
>  #include <linux/iommu.h>
>  #include <linux/module.h>
> -
ditto

>  #include <asm/apic.h>
>  #include <asm/cpu.h>
>  #include <asm/hw_irq.h>
> @@ -22,9 +20,7 @@
>  #include <asm/hypervisor.h>
>  #include <asm/mshyperv.h>
>  
> -#include "irq_remapping.h"
> -
> -#ifdef CONFIG_IRQ_REMAP
> +#include "../irq_remapping.h"
>  
>  /*
>   * According 82093AA IO-APIC spec , IO APIC has a 24-entry Interrupt
> @@ -330,5 +326,3 @@ static const struct irq_domain_ops
> hyperv_root_ir_domain_ops = { .alloc =
> hyperv_root_irq_remapping_alloc, .free =
> hyperv_root_irq_remapping_free, };
> -
> -#endif
> diff --git a/drivers/iommu/irq_remapping.c
> b/drivers/iommu/irq_remapping.c index c2443659812a..41bf65e4ea88
> 100644 --- a/drivers/iommu/irq_remapping.c
> +++ b/drivers/iommu/irq_remapping.c
> @@ -108,7 +108,7 @@ int __init irq_remapping_prepare(void)
>  	else if (IS_ENABLED(CONFIG_AMD_IOMMU) &&
>  		 amd_iommu_irq_ops.prepare() == 0)
>  		remap_ops = &amd_iommu_irq_ops;
> -	else if (IS_ENABLED(CONFIG_HYPERV_IOMMU) &&
> +	else if (IS_ENABLED(CONFIG_HYPERV) &&
>  		 hyperv_irq_remap_ops.prepare() == 0)
>  		remap_ops = &hyperv_irq_remap_ops;
>  	else
Other than the above nits, feel free to add:
Reviewed-by: Jacob Pan <jacob.pan@linux.microsoft.com>
