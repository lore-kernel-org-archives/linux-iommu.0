Return-Path: <SRS0=ygJE=DB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE81C4363D
	for <iommu@archiver.kernel.org>; Thu, 24 Sep 2020 12:25:27 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E0FA21D7F
	for <iommu@archiver.kernel.org>; Thu, 24 Sep 2020 12:25:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E0FA21D7F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id CAF8F2E129;
	Thu, 24 Sep 2020 12:25:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LdOGeuLHt13P; Thu, 24 Sep 2020 12:25:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 646B32E113;
	Thu, 24 Sep 2020 12:25:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 58A5DC0890;
	Thu, 24 Sep 2020 12:25:20 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 134B9C0859
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 12:25:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id F3840874EE
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 12:25:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0d0KOX6bEPZh for <iommu@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 12:25:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by hemlock.osuosl.org (Postfix) with ESMTP id 89A8B873F3
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 12:25:17 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E2DF0113E;
 Thu, 24 Sep 2020 05:25:16 -0700 (PDT)
Received: from [10.57.48.76] (unknown [10.57.48.76])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2D14C3F73B;
 Thu, 24 Sep 2020 05:25:16 -0700 (PDT)
Subject: Re: [PATCH 02/13] iommu: amd: Prepare for generic IO page table
 framework
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
References: <20200923101442.73157-1-suravee.suthikulpanit@amd.com>
 <20200923101442.73157-3-suravee.suthikulpanit@amd.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <a2e28845-d162-281a-c762-698d1750bbea@arm.com>
Date: Thu, 24 Sep 2020 13:25:14 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <20200923101442.73157-3-suravee.suthikulpanit@amd.com>
Content-Language: en-GB
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

On 2020-09-23 11:14, Suravee Suthikulpanit wrote:
> Add initial hook up code to implement generic IO page table framework.
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>   drivers/iommu/amd/Kconfig           |  1 +
>   drivers/iommu/amd/Makefile          |  2 +-
>   drivers/iommu/amd/amd_iommu_types.h | 32 +++++++++++
>   drivers/iommu/amd/io_pgtable.c      | 89 +++++++++++++++++++++++++++++
>   drivers/iommu/amd/iommu.c           | 10 ----
>   drivers/iommu/io-pgtable.c          |  3 +
>   include/linux/io-pgtable.h          |  2 +
>   7 files changed, 128 insertions(+), 11 deletions(-)
>   create mode 100644 drivers/iommu/amd/io_pgtable.c
> 
> diff --git a/drivers/iommu/amd/Kconfig b/drivers/iommu/amd/Kconfig
> index 626b97d0dd21..a3cbafb603f5 100644
> --- a/drivers/iommu/amd/Kconfig
> +++ b/drivers/iommu/amd/Kconfig
> @@ -10,6 +10,7 @@ config AMD_IOMMU
>   	select IOMMU_API
>   	select IOMMU_IOVA
>   	select IOMMU_DMA
> +	select IOMMU_IO_PGTABLE
>   	depends on X86_64 && PCI && ACPI && HAVE_CMPXCHG_DOUBLE
>   	help
>   	  With this option you can enable support for AMD IOMMU hardware in
> diff --git a/drivers/iommu/amd/Makefile b/drivers/iommu/amd/Makefile
> index dc5a2fa4fd37..a935f8f4b974 100644
> --- a/drivers/iommu/amd/Makefile
> +++ b/drivers/iommu/amd/Makefile
> @@ -1,4 +1,4 @@
>   # SPDX-License-Identifier: GPL-2.0-only
> -obj-$(CONFIG_AMD_IOMMU) += iommu.o init.o quirks.o
> +obj-$(CONFIG_AMD_IOMMU) += iommu.o init.o quirks.o io_pgtable.o
>   obj-$(CONFIG_AMD_IOMMU_DEBUGFS) += debugfs.o
>   obj-$(CONFIG_AMD_IOMMU_V2) += iommu_v2.o
> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
> index f696ac7c5f89..77cd8d966fbc 100644
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h
> @@ -15,6 +15,7 @@
>   #include <linux/spinlock.h>
>   #include <linux/pci.h>
>   #include <linux/irqreturn.h>
> +#include <linux/io-pgtable.h>
>   
>   /*
>    * Maximum number of IOMMUs supported
> @@ -252,6 +253,19 @@
>   
>   #define GA_GUEST_NR		0x1
>   
> +#define IOMMU_IN_ADDR_BIT_SIZE  52
> +#define IOMMU_OUT_ADDR_BIT_SIZE 52
> +
> +/*
> + * This bitmap is used to advertise the page sizes our hardware support
> + * to the IOMMU core, which will then use this information to split
> + * physically contiguous memory regions it is mapping into page sizes
> + * that we support.
> + *
> + * 512GB Pages are not supported due to a hardware bug
> + */
> +#define AMD_IOMMU_PGSIZES	((~0xFFFUL) & ~(2ULL << 38))
> +
>   /* Bit value definition for dte irq remapping fields*/
>   #define DTE_IRQ_PHYS_ADDR_MASK	(((1ULL << 45)-1) << 6)
>   #define DTE_IRQ_REMAP_INTCTL_MASK	(0x3ULL << 60)
> @@ -461,6 +475,23 @@ struct amd_irte_ops;
>   
>   #define AMD_IOMMU_FLAG_TRANS_PRE_ENABLED      (1 << 0)
>   
> +#define io_pgtable_to_data(x) \
> +	container_of((x), struct amd_io_pgtable, iop)
> +
> +#define io_pgtable_ops_to_data(x) \
> +	io_pgtable_to_data(io_pgtable_ops_to_pgtable(x))
> +
> +#define io_pgtable_ops_to_domain(x) \
> +	container_of(io_pgtable_ops_to_data(x), \
> +		     struct protection_domain, iop)
> +
> +struct amd_io_pgtable {
> +	struct io_pgtable_cfg	pgtbl_cfg;
> +	struct io_pgtable	iop;
> +	int			mode;
> +	u64			*root;
> +};
> +
>   /*
>    * This structure contains generic data for  IOMMU protection domains
>    * independent of their use.
> @@ -469,6 +500,7 @@ struct protection_domain {
>   	struct list_head dev_list; /* List of all devices in this domain */
>   	struct iommu_domain domain; /* generic domain handle used by
>   				       iommu core code */
> +	struct amd_io_pgtable iop;
>   	spinlock_t lock;	/* mostly used to lock the page table*/
>   	u16 id;			/* the domain id written to the device table */
>   	atomic64_t pt_root;	/* pgtable root and pgtable mode */
> diff --git a/drivers/iommu/amd/io_pgtable.c b/drivers/iommu/amd/io_pgtable.c
> new file mode 100644
> index 000000000000..452cad26a2b3
> --- /dev/null
> +++ b/drivers/iommu/amd/io_pgtable.c
> @@ -0,0 +1,89 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * CPU-agnostic AMD IO page table allocator.
> + *
> + * Copyright (C) 2020 Advanced Micro Devices, Inc.
> + * Author: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> + */
> +
> +#define pr_fmt(fmt)     "AMD-Vi: " fmt
> +#define dev_fmt(fmt)    pr_fmt(fmt)
> +
> +#include <linux/atomic.h>
> +#include <linux/bitops.h>
> +#include <linux/io-pgtable.h>
> +#include <linux/kernel.h>
> +#include <linux/sizes.h>
> +#include <linux/slab.h>
> +#include <linux/types.h>
> +#include <linux/dma-mapping.h>
> +
> +#include <asm/barrier.h>
> +
> +#include "amd_iommu_types.h"
> +#include "amd_iommu.h"
> +
> +static void v1_tlb_flush_all(void *cookie)
> +{
> +}
> +
> +static void v1_tlb_flush_walk(unsigned long iova, size_t size,
> +				  size_t granule, void *cookie)
> +{
> +}
> +
> +static void v1_tlb_flush_leaf(unsigned long iova, size_t size,
> +				  size_t granule, void *cookie)
> +{
> +}
> +
> +static void v1_tlb_add_page(struct iommu_iotlb_gather *gather,
> +					 unsigned long iova, size_t granule,
> +					 void *cookie)
> +{
> +	struct protection_domain *pdom = cookie;
> +	struct iommu_domain *domain = &pdom->domain;
> +
> +	iommu_iotlb_gather_add_page(domain, gather, iova, granule);
> +}
> +
> +static const struct iommu_flush_ops amd_flush_ops = {
> +	.tlb_flush_all	= v1_tlb_flush_all,
> +	.tlb_flush_walk = v1_tlb_flush_walk,
> +	.tlb_flush_leaf = v1_tlb_flush_leaf,
> +	.tlb_add_page	= v1_tlb_add_page,
> +};
> +
> +struct io_pgtable_ops *amd_iommu_setup_io_pgtable_ops(struct iommu_dev_data *dev_data,
> +					     struct protection_domain *domain)
> +{
> +		domain->iop.pgtbl_cfg = (struct io_pgtable_cfg) {
> +		.pgsize_bitmap	= AMD_IOMMU_PGSIZES,
> +		.ias		= IOMMU_IN_ADDR_BIT_SIZE,
> +		.oas		= IOMMU_OUT_ADDR_BIT_SIZE,
> +		.coherent_walk	= false,

Is that right? Given that you seem to use regular kernel addresses for 
pagetable pages and don't have any obvious cache maintenance around PTE 
manipulation, I suspect not ;)

It's fair enough if your implementation doesn't use this and simply 
assumes coherency, but in that case it would be less confusing to have 
the driver set it to true for the sake of honesty, or just leave it out 
entirely - explicitly setting false gives the illusion of being meaningful.

Otherwise, the io-pgtable parts all look OK to me - it's nice to finally 
fulfil the original intent of not being an Arm-specific thing :D

Robin.

> +		.tlb		= &amd_flush_ops,
> +		.iommu_dev	= &dev_data->pdev->dev,
> +	};
> +
> +	return alloc_io_pgtable_ops(AMD_IOMMU_V1, &domain->iop.pgtbl_cfg, domain);
> +}
> +
> +/*
> + * ----------------------------------------------------
> + */
> +static void v1_free_pgtable(struct io_pgtable *iop)
> +{
> +}
> +
> +static struct io_pgtable *v1_alloc_pgtable(struct io_pgtable_cfg *cfg, void *cookie)
> +{
> +	struct protection_domain *pdom = (struct protection_domain *)cookie;
> +
> +	return &pdom->iop.iop;
> +}
> +
> +struct io_pgtable_init_fns io_pgtable_amd_iommu_v1_init_fns = {
> +	.alloc	= v1_alloc_pgtable,
> +	.free	= v1_free_pgtable,
> +};
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index e92b3f744292..2b7eb51dcbb8 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -59,16 +59,6 @@
>   #define HT_RANGE_START		(0xfd00000000ULL)
>   #define HT_RANGE_END		(0xffffffffffULL)
>   
> -/*
> - * This bitmap is used to advertise the page sizes our hardware support
> - * to the IOMMU core, which will then use this information to split
> - * physically contiguous memory regions it is mapping into page sizes
> - * that we support.
> - *
> - * 512GB Pages are not supported due to a hardware bug
> - */
> -#define AMD_IOMMU_PGSIZES	((~0xFFFUL) & ~(2ULL << 38))
> -
>   #define DEFAULT_PGTABLE_LEVEL	PAGE_MODE_3_LEVEL
>   
>   static DEFINE_SPINLOCK(pd_bitmap_lock);
> diff --git a/drivers/iommu/io-pgtable.c b/drivers/iommu/io-pgtable.c
> index 94394c81468f..6e9917ce980f 100644
> --- a/drivers/iommu/io-pgtable.c
> +++ b/drivers/iommu/io-pgtable.c
> @@ -24,6 +24,9 @@ io_pgtable_init_table[IO_PGTABLE_NUM_FMTS] = {
>   #ifdef CONFIG_IOMMU_IO_PGTABLE_ARMV7S
>   	[ARM_V7S] = &io_pgtable_arm_v7s_init_fns,
>   #endif
> +#ifdef CONFIG_AMD_IOMMU
> +	[AMD_IOMMU_V1] = &io_pgtable_amd_iommu_v1_init_fns,
> +#endif
>   };
>   
>   struct io_pgtable_ops *alloc_io_pgtable_ops(enum io_pgtable_fmt fmt,
> diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
> index 23285ba645db..db25d436cabd 100644
> --- a/include/linux/io-pgtable.h
> +++ b/include/linux/io-pgtable.h
> @@ -15,6 +15,7 @@ enum io_pgtable_fmt {
>   	ARM_64_LPAE_S2,
>   	ARM_V7S,
>   	ARM_MALI_LPAE,
> +	AMD_IOMMU_V1,
>   	IO_PGTABLE_NUM_FMTS,
>   };
>   
> @@ -254,5 +255,6 @@ extern struct io_pgtable_init_fns io_pgtable_arm_64_lpae_s1_init_fns;
>   extern struct io_pgtable_init_fns io_pgtable_arm_64_lpae_s2_init_fns;
>   extern struct io_pgtable_init_fns io_pgtable_arm_v7s_init_fns;
>   extern struct io_pgtable_init_fns io_pgtable_arm_mali_lpae_init_fns;
> +extern struct io_pgtable_init_fns io_pgtable_amd_iommu_v1_init_fns;
>   
>   #endif /* __IO_PGTABLE_H */
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
