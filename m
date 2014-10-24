From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH linux-next] iommu: add iommu for s390 platform
Date: Sat, 25 Oct 2014 01:33:29 +0200
Message-ID: <20141024233329.GA6202@8bytes.org>
References: <1413892645-37657-1-git-send-email-blaschka@linux.vnet.ibm.com>
	<20141022141728.GG10074@8bytes.org>
	<20141022154320.GA42442@tuxmaker.boeblingen.de.ibm.com>
	<20141023124115.GB10053@8bytes.org>
	<20141023140437.GA31009@tuxmaker.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20141023140437.GA31009-++28Fms/gMmXI4yAdoq52KN5r0PSdgG1zG2AekJRRhI@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Frank Blaschka <blaschka-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Cc: linux-s390-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sebott-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, schwidefsky-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org, gerald.schaefer-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Frank,

On Thu, Oct 23, 2014 at 04:04:37PM +0200, Frank Blaschka wrote:
> > A domain is basically an abstraction for a DMA page table (or a
> > dma_table, as you call it on s390). So you can easily create similar
> > mappings for more than one device with it.
> >
> the clp instructions reports a start/end dma address for the pci device.
> on my system all devices report:
> 
> sdma = 0x100000000;
> edma = 0x1ffffffffffffff;

These values need to be reported through the IOMMU-API, so that the
users know which address ranges they can map.

> dma mappings are created for each device separately starting from 0x100000000
> and filling the the VIOA space for this device (until 0x1ffffffffffffff)
> 
> If we would like to have more then one device per domain I think:
> 
> we would have to slice the IOVA address space (0x100000000 - 0x1ffffffffffffff)
> of the domain and report only a slice to the pci device (clp)
> The iommu code would have to find the device by the dma (VIOA) address
> and then program the entry to the table of the particular device (and only this
> device).

Why do you need to splice an address space when more than one device is
assigned to it? Does that come from the hardware?

Usually its not problematic when devices share an address space. The
partitioning of that address-space between devices is done by an address
allocator which works on small chunks of memory (io-page-size
granularity).

But such an address allocator is part of the DMA-API, the IOMMU-API
which you implement here only cares about the mappings itself, not about
address allocation.


	Joerg
