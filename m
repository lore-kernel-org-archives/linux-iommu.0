From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCH 1/4] iommu: introduce generic page table allocation
	framework
Date: Mon, 01 Dec 2014 15:33:09 +0200
Message-ID: <12888062.XNeNCOOP61@avalon>
References: <1417089078-22900-1-git-send-email-will.deacon@arm.com>
	<3337836.UezZ1Klsom@avalon> <20141201121338.GD18466@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20141201121338.GD18466-5wv7dgnIgG8@public.gmane.org>
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
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "prem.mallappa-dY08KVG/lbpWk0Htik3J/w@public.gmane.org" <prem.mallappa-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Robin Murphy <Robin.Murphy-5wv7dgnIgG8@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Will,

On Monday 01 December 2014 12:13:38 Will Deacon wrote:
> On Sun, Nov 30, 2014 at 10:00:21PM +0000, Laurent Pinchart wrote:
> > On Thursday 27 November 2014 11:51:15 Will Deacon wrote:
> > > diff --git a/drivers/iommu/io-pgtable.c b/drivers/iommu/io-pgtable.c
> > > new file mode 100644
> > > index 000000000000..82e39a0db94b
> > > --- /dev/null
> > > +++ b/drivers/iommu/io-pgtable.c
> > > @@ -0,0 +1,71 @@
> > > +/*
> > > + * Generic page table allocator for IOMMUs.
> > > + *
> > > + * This program is free software; you can redistribute it and/or modify
> > > + * it under the terms of the GNU General Public License version 2 as
> > > + * published by the Free Software Foundation.
> > > + *
> > > + * This program is distributed in the hope that it will be useful,
> > > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > > + * GNU General Public License for more details.
> > > + *
> > > + * You should have received a copy of the GNU General Public License
> > > + * along with this program; if not, write to the Free Software
> > > + * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
> > > 02111-1307, USA.

By the way you can remove this paragraph, we don't want to update all source 
files the day the FSF decides to move to a new address.

> > > + *
> > > + * Copyright (C) 2014 ARM Limited
> > > + *
> > > + * Author: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
> > > + */
> > > +
> > > +#include <linux/bug.h>
> > > +#include <linux/kernel.h>
> > > +#include <linux/types.h>
> > > +
> > > +#include "io-pgtable.h"
> > > +
> > > +static struct io_pgtable_init_fns
> > 
> > Any reason not to make the table const ?
> 
> No reason, I'll give it a go.
> 
> > > diff --git a/drivers/iommu/io-pgtable.h b/drivers/iommu/io-pgtable.h
> > > new file mode 100644
> > > index 000000000000..5ae75d9cae50
> > > --- /dev/null
> > > +++ b/drivers/iommu/io-pgtable.h
> > > @@ -0,0 +1,65 @@
> > > +#ifndef __IO_PGTABLE_H
> > > +#define __IO_PGTABLE_H
> > > +
> > > +struct io_pgtable_ops {
> > > +	int (*map)(struct io_pgtable_ops *ops, unsigned long iova,
> > 
> > How about passing a struct io_pgtable * instead of the ops pointer ? This
> > would require returning a struct io_pgtable from the alloc function, which
> > I suppose you didn't want to do to ensure the caller will not touch the
> > struct io_pgtable fields directly. Do we really need to go that far, or
> > can we simply document struct io_pgtable as being private to the pg alloc
> > framework core and allocators ? Someone who really wants to get hold of
> > the io_pgtable instance could use container_of on the ops anyway, like
> > the allocators do.
> 
> Hmm, currently the struct io_pgtable is private to the page table allocator,
> so I don't like the IOMMU driver having an explicit handle to that.

I agree with this, but given that struct io_pgtable is defined in a header 
used by the IOMMU driver, and given that it directly embeds struct 
io_pgtable_ops, there's no big difference between the two structures.

> I also like having the value returned from alloc_io_pgtable_ops being used
> as the handle to pass around -- it keeps things simple for the caller
> because there's one structure that you get back and that's the thing you use
> as a reference.

I agree with that as well, my proposal was to return a struct io_pgtable from 
alloc_io_pgtable_ops.

> What do we gain by returning the struct io_pgtable pointer instead?

The ops structure could be made a const pointer. That's a pretty small 
optimization, granted.

> > > +		   phys_addr_t paddr, size_t size, int prot);
> > > +	int (*unmap)(struct io_pgtable_ops *ops, unsigned long iova,
> > > +		     size_t size);
> > > +	phys_addr_t (*iova_to_phys)(struct io_pgtable_ops *ops,
> > > +				    unsigned long iova);
> > > +};
> > > +
> > > +struct iommu_gather_ops {
> > > +	/* Synchronously invalidate the entire TLB context */
> > > +	void (*tlb_flush_all)(void *cookie);
> > > +
> > > +	/* Queue up a TLB invalidation for a virtual address range */
> > > +	void (*tlb_add_flush)(unsigned long iova, size_t size, bool leaf,
> > > +			      void *cookie);
> > 
> > Is there a limit to the number of entries that can be queued, or any other
> > kind of restriction ? Implementing a completely generic TLB flush queue
> > can become complex for IOMMU drivers.
> 
> I think it's only as complicated as you decide to make it. For example,
> you could just issue the TLBI directly in the add_flush callback (like I
> do for the arm-smmu driver), but then don't bother polling the hardware
> for completion until the sync callback.
> 
> > I would also document in which context(s) this callback will be called, as
> > IOMMU drivers might be tempted to allocate memory in order to implement a
> > TLB flush queue.
> 
> Good idea.
> 
> > > +	/* Ensure any queued TLB invalidation has taken effect */
> > > +	void (*tlb_sync)(void *cookie);
> > > +
> > > +	/* Ensure page tables updates are visible to the IOMMU */
> > > +	void (*flush_pgtable)(void *ptr, size_t size, void *cookie);
> > > +};
> > 
> > I suppose kerneldoc will come in the next version ;-)
> 
> Bah, ok then, if you insist!

I'm afraid I do :-)

> > > +struct io_pgtable_cfg {
> > > +	int			quirks; /* IO_PGTABLE_QUIRK_* */
> > > +	unsigned long		pgsize_bitmap;
> > > +	unsigned int		ias;
> > > +	unsigned int		oas;
> > > +	struct iommu_gather_ops	*tlb;
> > > +
> > > +	/* Low-level data specific to the table format */
> > > +	union {
> > > +	};
> > > +};
> > > +
> > > +enum io_pgtable_fmt {
> > > +	IO_PGTABLE_NUM_FMTS,
> > > +};
> > > +
> > > +struct io_pgtable {
> > > +	enum io_pgtable_fmt	fmt;
> > > +	void			*cookie;
> > > +	struct io_pgtable_cfg	cfg;
> > > +	struct io_pgtable_ops	ops;
> > 
> > This could be turned into a const pointer if we pass struct io_pgtable
> > around instead of the ops.
> > 
> > > +};
> > > +
> > > +struct io_pgtable_init_fns {
> > > +	struct io_pgtable *(*alloc)(struct io_pgtable_cfg *cfg, void 
*cookie);
> > > +	void (*free)(struct io_pgtable *iop);
> > > +};
> > 
> > I would reorder structures into two groups, one clearly marked as private
> > that shouldn't be touched by IOMMU drivers, and then the io_pgtable_fmt
> > enum and the io_pgtable_cfg struct grouped with the two functions below.
> 
> Sure.
> 
> Thanks again for the review.

You're welcome.

-- 
Regards,

Laurent Pinchart
