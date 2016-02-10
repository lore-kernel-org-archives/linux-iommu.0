From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH V3 1/5] perf/amd/iommu: Consolidate and move
 perf_event_amd_iommu header
Date: Wed, 10 Feb 2016 17:41:16 +0100
Message-ID: <20160210164116.GG23914@pd.tnic>
References: <1455058435-8716-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <1455058435-8716-2-git-send-email-Suravee.Suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1455058435-8716-2-git-send-email-Suravee.Suthikulpanit@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Cc: joro@8bytes.org, peterz@infradead.org, mingo@redhat.com, acme@kernel.org, andihartmann@freenet.de, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Feb 09, 2016 at 04:53:51PM -0600, Suravee Suthikulpanit wrote:
> This patch consolidates "arch/x86/kernel/cpu/perf_event_amd_iommu.h" and
> "drivers/iommu/amd_iommu_proto.h", which contain duplicate function
> declarations, into "include/linux/perf/perf_event_amd_iommu.h"
> 
> Reviewed-by: Joerg Roedel <jroedel@suse.de>
> Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> ---
>  arch/x86/kernel/cpu/perf_event_amd_iommu.c |  2 +-
>  arch/x86/kernel/cpu/perf_event_amd_iommu.h | 40 ------------------------------
>  drivers/iommu/amd_iommu_init.c             |  2 ++
>  drivers/iommu/amd_iommu_proto.h            |  7 ------
>  include/linux/perf/perf_event_amd_iommu.h  | 40 ++++++++++++++++++++++++++++++
>  5 files changed, 43 insertions(+), 48 deletions(-)
>  delete mode 100644 arch/x86/kernel/cpu/perf_event_amd_iommu.h
>  create mode 100644 include/linux/perf/perf_event_amd_iommu.h

Is this a header which will be used on something else besides x86 or why
is it being moved to include/linux/ ?

If not, it should go into arch/x86/events/ with the rest of the perf
private headers.

...

> diff --git a/include/linux/perf/perf_event_amd_iommu.h b/include/linux/perf/perf_event_amd_iommu.h
> new file mode 100644
> index 0000000..845d173
> --- /dev/null
> +++ b/include/linux/perf/perf_event_amd_iommu.h
> @@ -0,0 +1,40 @@
> +/*
> + * Copyright (C) 2013 Advanced Micro Devices, Inc.
> + *
> + * Author: Steven Kinney <Steven.Kinney@amd.com>
> + * Author: Suravee Suthikulpanit <Suraveee.Suthikulpanit@amd.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef _PERF_EVENT_AMD_IOMMU_H_
> +#define _PERF_EVENT_AMD_IOMMU_H_
> +
> +/* iommu pc mmio region register indexes */
> +#define IOMMU_PC_COUNTER_REG			0x00
> +#define IOMMU_PC_COUNTER_SRC_REG		0x08
> +#define IOMMU_PC_PASID_MATCH_REG		0x10
> +#define IOMMU_PC_DOMID_MATCH_REG		0x18
> +#define IOMMU_PC_DEVID_MATCH_REG		0x20
> +#define IOMMU_PC_COUNTER_REPORT_REG		0x28
> +
> +/* maximun specified bank/counters */

s/maximun/maximum/

> +#define PC_MAX_SPEC_BNKS			64
> +#define PC_MAX_SPEC_CNTRS			16
> +
> +/* iommu pc reg masks*/
> +#define IOMMU_BASE_DEVID			0x0000
> +
> +/* amd_iommu_init.c external support functions */
> +extern bool amd_iommu_pc_supported(void);
> +
> +extern u8 amd_iommu_pc_get_max_banks(u16 devid);
> +
> +extern u8 amd_iommu_pc_get_max_counters(u16 devid);
> +
> +extern int amd_iommu_pc_get_set_reg_val(u16 devid, u8 bank, u8 cntr,
> +			u8 fxn, u64 *value, bool is_write);

You can drop the "extern" qualifiers while at it - they're not needed.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
