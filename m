From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RESEND PATCH 2/4] iommu: arm-smmu: split out register defines
Date: Fri, 14 Jul 2017 20:13:32 +0100
Message-ID: <20170714191332.GF26488@arm.com>
References: <20170713120747.20490-1-robdclark@gmail.com>
	<20170713120747.20490-3-robdclark@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170713120747.20490-3-robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Jul 13, 2017 at 08:07:45AM -0400, Rob Clark wrote:
> I want to re-use some of these for qcom_iommu, which has (roughly) the
> same context-bank registers.
> 
> Signed-off-by: Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/iommu/arm-smmu-regs.h | 227 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/iommu/arm-smmu.c      | 203 +------------------------------------
>  2 files changed, 228 insertions(+), 202 deletions(-)
>  create mode 100644 drivers/iommu/arm-smmu-regs.h
> 
> diff --git a/drivers/iommu/arm-smmu-regs.h b/drivers/iommu/arm-smmu-regs.h
> new file mode 100644
> index 000000000000..87589c863068
> --- /dev/null
> +++ b/drivers/iommu/arm-smmu-regs.h
> @@ -0,0 +1,227 @@
> +/*
> + * IOMMU API for ARM architected SMMU implementations.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
> + *
> + * Copyright (C) 2013 ARM Limited
> + *
> + * Author: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
> + */
> +
> +#ifndef _ARM_SMMU_REGS_H
> +#define _ARM_SMMU_REGS_H

[...]

> +/* Global TLB invalidation */
> +#define ARM_SMMU_GR0_TLBIVMID		0x64
> +#define ARM_SMMU_GR0_TLBIALLNSNH	0x68
> +#define ARM_SMMU_GR0_TLBIALLH		0x6c
> +#define ARM_SMMU_GR0_sTLBGSYNC		0x70
> +#define ARM_SMMU_GR0_sTLBGSTATUS	0x74
> +#define sTLBGSTATUS_GSACTIVE		(1 << 0)
> +#define TLB_LOOP_TIMEOUT		1000000	/* 1s! */
> +#define TLB_SPIN_COUNT			10

Do you need these TLB defines? They're not part of the architected register
state.

> +#define SCTLR_S1_ASIDPNE		(1 << 12)
> +#define SCTLR_CFCFG			(1 << 7)
> +#define SCTLR_CFIE			(1 << 6)
> +#define SCTLR_CFRE			(1 << 5)
> +#define SCTLR_E				(1 << 4)
> +#define SCTLR_AFE			(1 << 2)
> +#define SCTLR_TRE			(1 << 1)
> +#define SCTLR_M				(1 << 0)
> +
> +#define ARM_MMU500_ACTLR_CPRE		(1 << 1)
> +
> +#define ARM_MMU500_ACR_CACHE_LOCK	(1 << 26)
> +#define ARM_MMU500_ACR_SMTNMB_TLBEN	(1 << 8)

The MMU-500 defines can probably stay in arm-smmu.c.

Will
