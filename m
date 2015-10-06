From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] iommu/s390: add iommu api for s390 pci devices
Date: Tue, 6 Oct 2015 12:19:52 +0200
Message-ID: <20151006101952.GA20886@8bytes.org>
References: <1440682383-27688-1-git-send-email-gerald.schaefer@de.ibm.com>
	<20150929124030.GI3036@8bytes.org>
	<20151001193028.73e48f7e@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20151001193028.73e48f7e@thinkpad>
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
Cc: kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sebastian Ott <sebott-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Martin Schwidefsky <schwidefsky-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Oct 01, 2015 at 07:30:28PM +0200, Gerald Schaefer wrote:
> Yes, the DMA API is already implemented in arch/s390/pci/pci_dma.c.
> I thought about moving it over to the new location in drivers/iommu/,
> but I don't see any benefit from it.

Okay, this is true for now. At some point we hopefully have a common
DMA-API implementation for all IOMMU driver, at which point s390 can
make use of it too and abandon its own implementation.

> Also, the two APIs are quite different on s390 and must not be mixed-up.
> For example, we have optimizations in the DMA API to reduce TLB flushes
> based on iommu bitmap wrap-around, which is not possible for the map/unmap
> logic in the IOMMU API. There is also the requirement that each device has
> its own DMA page table (not shared), which is important for DMA API device
> recovery and map/unmap on s390.

This sounds quite similar to what other IOMMU drivers also implement,
especially the AMD IOMMU driver. It also uses non-shared page-tables for
devices and implements the bitmap-allocator optimization.

> Hmm, not sure how this can replace my own struct. I need the struct to
> maintain a list of all devices that share a dma page table. And the
> devices need to be added and removed to/from that list in attach/detach_dev.
> 
> I also need that list during map/unmap, in order to do a TLB flush for
> all affected devices, and this happens under a spin lock.
> 
> So I guess I cannot use the iommu_group->devices list, which is managed
> in add/remove_device and under a mutex, if that was on your mind.

Yeah, right. Thanks for the explanation.


	Joerg
