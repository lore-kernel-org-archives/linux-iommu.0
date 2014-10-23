From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH linux-next] iommu: add iommu for s390 platform
Date: Thu, 23 Oct 2014 14:41:15 +0200
Message-ID: <20141023124115.GB10053@8bytes.org>
References: <1413892645-37657-1-git-send-email-blaschka@linux.vnet.ibm.com>
	<20141022141728.GG10074@8bytes.org>
	<20141022154320.GA42442@tuxmaker.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20141022154320.GA42442-++28Fms/gMmXI4yAdoq52KN5r0PSdgG1zG2AekJRRhI@public.gmane.org>
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

On Wed, Oct 22, 2014 at 05:43:20PM +0200, Frank Blaschka wrote:
> Basically there are no limitations. Depending on the s390 maschine
> generation a device starts its IOVA at a specific address (announced by
> the HW). But as I already told each device starts at the same address.
> I think this prevents having multiple devices on the same IOMMU domain.

Why, each device has its own IOVA address space, so IOVA A could map to
physical address X for one device and to Y for another, no? And if you
point multiple devices to the same dma_table they share the mappings
(and thus the address space). Or am I getting something wrong?

> yes, you are absolutely right. There is a per-device dma_table.
> There is no general IOMMU device but each pci device has its own IOMMU
> translation capability.

I see, in this way it is similar to ARM where there is often also one IOMMU
per master device.

> Is there a possibility the IOMMU domain can support e.g. something like
> 
> VIOA 0x10000 -> pci device 1
> VIOA 0x10000 -> pci device 2

A domain is basically an abstraction for a DMA page table (or a
dma_table, as you call it on s390). So you can easily create similar
mappings for more than one device with it.



	Joerg
