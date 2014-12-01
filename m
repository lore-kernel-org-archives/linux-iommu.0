From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 1/4] iommu: introduce generic page table allocation
	framework
Date: Mon, 1 Dec 2014 13:53:37 +0000
Message-ID: <20141201135337.GF18466@arm.com>
References: <1417089078-22900-1-git-send-email-will.deacon@arm.com>
	<3337836.UezZ1Klsom@avalon> <20141201121338.GD18466@arm.com>
	<12888062.XNeNCOOP61@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <12888062.XNeNCOOP61@avalon>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "prem.mallappa-dY08KVG/lbpWk0Htik3J/w@public.gmane.org" <prem.mallappa-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Robin Murphy <Robin.Murphy-5wv7dgnIgG8@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Dec 01, 2014 at 01:33:09PM +0000, Laurent Pinchart wrote:
> On Monday 01 December 2014 12:13:38 Will Deacon wrote:
> > On Sun, Nov 30, 2014 at 10:00:21PM +0000, Laurent Pinchart wrote:
> > > On Thursday 27 November 2014 11:51:15 Will Deacon wrote:
> > > > diff --git a/drivers/iommu/io-pgtable.c b/drivers/iommu/io-pgtable.c
> > > > new file mode 100644
> > > > index 000000000000..82e39a0db94b
> > > > --- /dev/null
> > > > +++ b/drivers/iommu/io-pgtable.c
> > > > @@ -0,0 +1,71 @@
> > > > +/*
> > > > + * Generic page table allocator for IOMMUs.
> > > > + *
> > > > + * This program is free software; you can redistribute it and/or modify
> > > > + * it under the terms of the GNU General Public License version 2 as
> > > > + * published by the Free Software Foundation.
> > > > + *
> > > > + * This program is distributed in the hope that it will be useful,
> > > > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > > > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > > > + * GNU General Public License for more details.
> > > > + *
> > > > + * You should have received a copy of the GNU General Public License
> > > > + * along with this program; if not, write to the Free Software
> > > > + * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
> > > > 02111-1307, USA.
> 
> By the way you can remove this paragraph, we don't want to update all source 
> files the day the FSF decides to move to a new address.

Yeah, I missed that one (I fixed the lpae file already).

> > > > diff --git a/drivers/iommu/io-pgtable.h b/drivers/iommu/io-pgtable.h
> > > > new file mode 100644
> > > > index 000000000000..5ae75d9cae50
> > > > --- /dev/null
> > > > +++ b/drivers/iommu/io-pgtable.h
> > > > @@ -0,0 +1,65 @@
> > > > +#ifndef __IO_PGTABLE_H
> > > > +#define __IO_PGTABLE_H
> > > > +
> > > > +struct io_pgtable_ops {
> > > > +	int (*map)(struct io_pgtable_ops *ops, unsigned long iova,
> > > 
> > > How about passing a struct io_pgtable * instead of the ops pointer ? This
> > > would require returning a struct io_pgtable from the alloc function, which
> > > I suppose you didn't want to do to ensure the caller will not touch the
> > > struct io_pgtable fields directly. Do we really need to go that far, or
> > > can we simply document struct io_pgtable as being private to the pg alloc
> > > framework core and allocators ? Someone who really wants to get hold of
> > > the io_pgtable instance could use container_of on the ops anyway, like
> > > the allocators do.
> > 
> > Hmm, currently the struct io_pgtable is private to the page table allocator,
> > so I don't like the IOMMU driver having an explicit handle to that.
> 
> I agree with this, but given that struct io_pgtable is defined in a header 
> used by the IOMMU driver, and given that it directly embeds struct 
> io_pgtable_ops, there's no big difference between the two structures.

Right, but you have to do an explicit container_of and, with the kerneldoc
added, it should be clear that it's not a good idea to mess with things
like the cookie or the cfg after you've allocated the page tables.

> > I also like having the value returned from alloc_io_pgtable_ops being used
> > as the handle to pass around -- it keeps things simple for the caller
> > because there's one structure that you get back and that's the thing you use
> > as a reference.
> 
> I agree with that as well, my proposal was to return a struct io_pgtable from 
> alloc_io_pgtable_ops.
> 
> > What do we gain by returning the struct io_pgtable pointer instead?
> 
> The ops structure could be made a const pointer. That's a pretty small 
> optimization, granted.

I still think I'd rather keep things like they are. Let's see how it looks
in v2, when I've reordered the structures and documented them.

Will
