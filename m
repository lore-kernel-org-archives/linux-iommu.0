From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH linux-next] iommu: add iommu for s390 platform
Date: Mon, 27 Oct 2014 18:58:35 +0100
Message-ID: <20141027175835.GC6202@8bytes.org>
References: <1413892645-37657-1-git-send-email-blaschka@linux.vnet.ibm.com>
	<20141022141728.GG10074@8bytes.org>
	<20141022154320.GA42442@tuxmaker.boeblingen.de.ibm.com>
	<20141023124115.GB10053@8bytes.org>
	<20141023140437.GA31009@tuxmaker.boeblingen.de.ibm.com>
	<20141027153201.517f4ff4@thinkpad>
	<20141027162502.GB6202@8bytes.org>
	<20141027180219.62b1ac4a@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20141027180219.62b1ac4a@thinkpad>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Gerald Schaefer <gerald.schaefer-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>
Cc: linux-s390-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sebott-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, Frank Blaschka <blaschka-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, schwidefsky-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Oct 27, 2014 at 06:02:19PM +0100, Gerald Schaefer wrote:
> On Mon, 27 Oct 2014 17:25:02 +0100
> Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org> wrote:
> > Is there some hardware reason for this or is that just an
> > implementation detail that can be changed. In other words, does the
> > hardware allow to use the same DMA table for multiple devices?
> 
> Yes, the HW would allow shared DMA tables, but the implementation would
> need some non-trivial changes. For example, we have a per-device spin_lock
> for DMA table manipulations and the code in arch/s390/pci/pci_dma.c knows
> nothing about IOMMU domains or shared DMA tables, it just implements a set
> of dma_map_ops.

I think it would make sense to move the DMA table handling code and the
dma_map_ops implementation to the IOMMU driver too. This is also how
some other IOMMU drivers implement it.

The plan is to consolidate the dma_ops implementations someday and have
a common implementation that works with all IOMMU drivers across
architectures. This would benefit s390 as well and obsoletes the driver
specific dma_ops implementation.

> Of course this would also go horribly wrong if a device was already
> in use (via the current dma_map_ops), but I guess using devices through
> the IOMMU_API prevents using them otherwise?

This is taken care of by the device drivers. A driver for a device
either uses the DMA-API or does its own management of DMA mappings using
the IOMMU-API. VFIO is an example for the later case.

> > I think it is much easier to use the same DMA table for all devices
> > in a domain, if the hardware allows that.
> 
> Yes, in this case, having one DMA table per domain and sharing it
> between all devices in that domain sounds like a good idea. However,
> I can't think of any use case for this, and Frank probably had a very
> special use case in mind where this scenario doesn't appear, hence the
> "one device per domain" restriction.

One usecase is device access from user-space via VFIO. A userspace
process might want to access multiple devices at the same time and VFIO
would implement this by assigning all of these devices to the same IOMMU
domain.

This requirement also comes also from the IOMMU-API itself. The
intention of the API is to make different IOMMUs look the same through
the API, and this is violated when drivers implement a 1-1
domain->device mapping.

> So, if having multiple devices per domain is a must, then we probably
> need a thorough rewrite of the arch/s390/pci/pci_dma.c code.

Yes, this is a requirement for new IOMMU drivers. We already have
drivers implementing the same 1-1 relation and we are about to fix them.
But I don't want to add new drivers doing the same.


	Joerg
