From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCH 1/4] iommu: introduce generic page table allocation
	framework
Date: Mon, 01 Dec 2014 00:00:21 +0200
Message-ID: <3337836.UezZ1Klsom@avalon>
References: <1417089078-22900-1-git-send-email-will.deacon@arm.com>
	<1417089078-22900-2-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1417089078-22900-2-git-send-email-will.deacon-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org, prem.mallappa-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, Robin.Murphy-5wv7dgnIgG8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Will,

Thank you for the patch.

On Thursday 27 November 2014 11:51:15 Will Deacon wrote:
> This patch introduces a generic framework for allocating page tables for
> an IOMMU. There are a number of reasons we want to do this:
> 
>   - It avoids duplication of complex table management code in IOMMU
>     drivers that use the same page table format
> 
>   - It removes any coupling with the CPU table format (and even the
>     architecture!)
> 
>   - It defines an API for IOMMU TLB maintenance
> 
> Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
> ---
>  drivers/iommu/Kconfig      |  8 ++++++
>  drivers/iommu/Makefile     |  1 +
>  drivers/iommu/io-pgtable.c | 71 +++++++++++++++++++++++++++++++++++++++++++
>  drivers/iommu/io-pgtable.h | 65 ++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 145 insertions(+)
>  create mode 100644 drivers/iommu/io-pgtable.c
>  create mode 100644 drivers/iommu/io-pgtable.h
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index dd5112265cc9..0f10554e7114 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -13,6 +13,14 @@ menuconfig IOMMU_SUPPORT
> 
>  if IOMMU_SUPPORT
> 
> +menu "Generic IOMMU Pagetable Support"
> +
> +# Selected by the actual pagetable implementations
> +config IOMMU_IO_PGTABLE
> +	bool
> +
> +endmenu
> +
>  config OF_IOMMU
>         def_bool y
>         depends on OF
> diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
> index 16edef74b8ee..aff244c78181 100644
> --- a/drivers/iommu/Makefile
> +++ b/drivers/iommu/Makefile
> @@ -1,6 +1,7 @@
>  obj-$(CONFIG_IOMMU_API) += iommu.o
>  obj-$(CONFIG_IOMMU_API) += iommu-traces.o
>  obj-$(CONFIG_IOMMU_API) += iommu-sysfs.o
> +obj-$(CONFIG_IOMMU_IO_PGTABLE) += io-pgtable.o
>  obj-$(CONFIG_OF_IOMMU)	+= of_iommu.o
>  obj-$(CONFIG_MSM_IOMMU) += msm_iommu.o msm_iommu_dev.o
>  obj-$(CONFIG_AMD_IOMMU) += amd_iommu.o amd_iommu_init.o
> diff --git a/drivers/iommu/io-pgtable.c b/drivers/iommu/io-pgtable.c
> new file mode 100644
> index 000000000000..82e39a0db94b
> --- /dev/null
> +++ b/drivers/iommu/io-pgtable.c
> @@ -0,0 +1,71 @@
> +/*
> + * Generic page table allocator for IOMMUs.
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
> + * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307,
> USA. + *
> + * Copyright (C) 2014 ARM Limited
> + *
> + * Author: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
> + */
> +
> +#include <linux/bug.h>
> +#include <linux/kernel.h>
> +#include <linux/types.h>
> +
> +#include "io-pgtable.h"
> +
> +static struct io_pgtable_init_fns

Any reason not to make the table const ?

> *io_pgtable_init_table[IO_PGTABLE_NUM_FMTS] =
> +{
> +};
> +
> +struct io_pgtable_ops *alloc_io_pgtable_ops(enum io_pgtable_fmt fmt,
> +					    struct io_pgtable_cfg *cfg,
> +					    void *cookie)
> +{
> +	struct io_pgtable *iop;
> +	struct io_pgtable_init_fns *fns;
> +
> +	if (fmt >= IO_PGTABLE_NUM_FMTS)
> +		return NULL;
> +
> +	fns = io_pgtable_init_table[fmt];
> +	if (!fns)
> +		return NULL;
> +
> +	iop = fns->alloc(cfg, cookie);
> +	if (!iop)
> +		return NULL;
> +
> +	iop->fmt	= fmt;
> +	iop->cookie	= cookie;
> +	iop->cfg	= *cfg;
> +
> +	return &iop->ops;
> +}
> +
> +/*
> + * It is the IOMMU driver's responsibility to ensure that the page table
> + * is no longer accessible to the walker by this point.
> + */
> +void free_io_pgtable_ops(struct io_pgtable_ops *ops)
> +{
> +	struct io_pgtable *iop;
> +
> +	if (!ops)
> +		return;
> +
> +	iop = container_of(ops, struct io_pgtable, ops);
> +	iop->cfg.tlb->tlb_flush_all(iop->cookie);
> +	io_pgtable_init_table[iop->fmt]->free(iop);
> +}
> diff --git a/drivers/iommu/io-pgtable.h b/drivers/iommu/io-pgtable.h
> new file mode 100644
> index 000000000000..5ae75d9cae50
> --- /dev/null
> +++ b/drivers/iommu/io-pgtable.h
> @@ -0,0 +1,65 @@
> +#ifndef __IO_PGTABLE_H
> +#define __IO_PGTABLE_H
> +
> +struct io_pgtable_ops {
> +	int (*map)(struct io_pgtable_ops *ops, unsigned long iova,

How about passing a struct io_pgtable * instead of the ops pointer ? This 
would require returning a struct io_pgtable from the alloc function, which I 
suppose you didn't want to do to ensure the caller will not touch the struct 
io_pgtable fields directly. Do we really need to go that far, or can we simply 
document struct io_pgtable as being private to the pg alloc framework core and 
allocators ? Someone who really wants to get hold of the io_pgtable instance 
could use container_of on the ops anyway, like the allocators do.

> +		   phys_addr_t paddr, size_t size, int prot);
> +	int (*unmap)(struct io_pgtable_ops *ops, unsigned long iova,
> +		     size_t size);
> +	phys_addr_t (*iova_to_phys)(struct io_pgtable_ops *ops,
> +				    unsigned long iova);
> +};
> +
> +struct iommu_gather_ops {
> +	/* Synchronously invalidate the entire TLB context */
> +	void (*tlb_flush_all)(void *cookie);
> +
> +	/* Queue up a TLB invalidation for a virtual address range */
> +	void (*tlb_add_flush)(unsigned long iova, size_t size, bool leaf,
> +			      void *cookie);

Is there a limit to the number of entries that can be queued, or any other 
kind of restriction ? Implementing a completely generic TLB flush queue can 
become complex for IOMMU drivers.

I would also document in which context(s) this callback will be called, as 
IOMMU drivers might be tempted to allocate memory in order to implement a TLB 
flush queue.

> +	/* Ensure any queued TLB invalidation has taken effect */
> +	void (*tlb_sync)(void *cookie);
> +
> +	/* Ensure page tables updates are visible to the IOMMU */
> +	void (*flush_pgtable)(void *ptr, size_t size, void *cookie);
> +};

I suppose kerneldoc will come in the next version ;-)

> +struct io_pgtable_cfg {
> +	int			quirks; /* IO_PGTABLE_QUIRK_* */
> +	unsigned long		pgsize_bitmap;
> +	unsigned int		ias;
> +	unsigned int		oas;
> +	struct iommu_gather_ops	*tlb;
> +
> +	/* Low-level data specific to the table format */
> +	union {
> +	};
> +};
> +
> +enum io_pgtable_fmt {
> +	IO_PGTABLE_NUM_FMTS,
> +};
> +
> +struct io_pgtable {
> +	enum io_pgtable_fmt	fmt;
> +	void			*cookie;
> +	struct io_pgtable_cfg	cfg;
> +	struct io_pgtable_ops	ops;

This could be turned into a const pointer if we pass struct io_pgtable around 
instead of the ops.

> +};
> +
> +struct io_pgtable_init_fns {
> +	struct io_pgtable *(*alloc)(struct io_pgtable_cfg *cfg, void *cookie);
> +	void (*free)(struct io_pgtable *iop);
> +};

I would reorder structures into two groups, one clearly marked as private that 
shouldn't be touched by IOMMU drivers, and then the io_pgtable_fmt enum and 
the io_pgtable_cfg struct grouped with the two functions below.

> +struct io_pgtable_ops *alloc_io_pgtable_ops(enum io_pgtable_fmt fmt,
> +					    struct io_pgtable_cfg *cfg,
> +					    void *cookie);
> +
> +/*
> + * Free an io_pgtable_ops structure. The caller *must* ensure that the
> + * page table is no longer live, but the TLB can be dirty.
> + */
> +void free_io_pgtable_ops(struct io_pgtable_ops *ops);
> +
> +#endif /* __IO_PGTABLE_H */

-- 
Regards,

Laurent Pinchart
