From: Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: Re: Error: DMA: Out of SW-IOMMU space [was: External USB drives
	become unresponsive after few hours.]
Date: Thu, 16 Apr 2015 14:42:52 -0400
Message-ID: <20150416184252.GE7388@x230.dumpdata.com>
References: <Pine.LNX.4.44L0.1504161010370.1391-100000@iolanthe.rowland.org>
	<552FCD25.9060807@gmail.com>
	<CAJ2095q3Gs=+e4ndKiD4EEX9LMh0Mjkv0nNOT=C-0aLD7tBDew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="BOKacYhQ+x31HxR3"
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAJ2095q3Gs=+e4ndKiD4EEX9LMh0Mjkv0nNOT=C-0aLD7tBDew-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Dorian Gray <yourfavouritegod-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Kernel development list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Alexander Duyck <alexander.duyck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 16, 2015 at 06:57:46PM +0200, Dorian Gray wrote:
> On 16 April 2015 at 16:15, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org> wrote:
> > This appears to be a problem with the IOMMU or SWIOTLB subsystems, not
> > the USB subsystem.  I have CC'ed the appropriate mailing lists.
> 
> Thanks, I'm far from being a kernel expert, so was expecting it could
> be wrong subsection.
> 
> 
> 
> On 16 April 2015 at 16:24, Suman Tripathi <stripathi-qTEPVZfXA3Y@public.gmane.org> wrote:
> > Try increasing the SWIOTLB size to 128MB .Default is 64MB.
> 
> Ok, so I'm back to k3.18.7 (default in the latest Fatdog), although
> I'm not sure what should be the exact value of swiotlb boot param?
> Got totally mixed results from uncle Google - some says the unit is in
> MiB, some that it's 4k pages and another that 128MiB = 65536, so I
> played it safe and used swiotlb=131072.
> Is this correct?
> It may take a few days, but I'll let you know if it worked (or for how
> long, if not).
> 
> 
> 
> On 16 April 2015 at 16:54, Alexander Duyck <alexander.duyck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > More likely would be a device driver that is DMA mapping memory but not
> > unmapping it after it is done resulting in the bounce buffer pool being
> > depleted.
> > You might want dump the list of drivers loaded on the system with lsmod,
> > and then possibly look at doing a git bisect for something introduced
> > between 3.17 and 3.18 since that seems to be when you started seeing
> > this issue.
> 
> Ok, I'll (try to) look at this, but like I said - I'm not a kernel
> (nor git) expert.
> Anyway, I guess I'm gonna start with this:
> https://wiki.gentoo.org/wiki/Kernel_git-bisect
> Who knows...perhaps I'll find something...

And easier way is to compile the kernel with CONFIG_DMA_API_DEBUG
and then load the attached module.

That should tell you who and what else is holding on the buffers.


> 
> 
> 
> Thank you all for the replies.
> Jake
> _______________________________________________
> iommu mailing list
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu

--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dump_dma.c"

/*
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License v2.0 as published by
 * the Free Software Foundation
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 */

#include <linux/module.h>
#include <linux/string.h>
#include <linux/types.h>
#include <linux/init.h>
#include <linux/stat.h>
#include <linux/err.h>
#include <linux/ctype.h>
#include <linux/slab.h>
#include <linux/limits.h>
#include <linux/device.h>
#include <linux/pci.h>
#include <linux/blkdev.h>
#include <linux/device.h>

#include <linux/init.h>
#include <linux/mm.h>
#include <linux/fcntl.h>
#include <linux/slab.h>
#include <linux/kmod.h>
#include <linux/major.h>
#include <linux/highmem.h>
#include <linux/blkdev.h>
#include <linux/module.h>
#include <linux/blkpg.h>
#include <linux/buffer_head.h>
#include <linux/mpage.h>
#include <linux/mount.h>
#include <linux/uio.h>
#include <linux/namei.h>
#include <asm/uaccess.h>

#include <linux/pagemap.h>
#include <linux/pagevec.h>

#include <linux/dma-debug.h>

#define DUMP_DMA_FUN  "0.1"

MODULE_AUTHOR("Konrad Rzeszutek Wilk <konrad@virtualiron>");
MODULE_DESCRIPTION("dump dma");
MODULE_LICENSE("GPL");
MODULE_VERSION(DUMP_DMA_FUN);

static int __init dump_dma_init(void)
{
	debug_dma_dump_mappings(NULL);
	return 0;
}

static void __exit dump_dma_exit(void)
{
}

module_init(dump_dma_init);
module_exit(dump_dma_exit);

--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--BOKacYhQ+x31HxR3--
