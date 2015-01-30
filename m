From: Mark Hounschell <markh-n2QNKt385d+sTnJN9+BGXg@public.gmane.org>
Subject: =?utf-8?b?ZG1hX2FsbG9jX2NvaGVyZW50?= - cma - and IOMMU question
Date: Fri, 30 Jan 2015 19:12:26 +0000 (UTC)
Message-ID: <loom.20150130T194501-225@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

I've posted the following email to vger.kernel.org but got no response. I am
trying to adapt some of our out of kernel GPL drivers to use the AMD IOMMU.
Here is what I posted to LKML

"start quote"

Sorry for the noise. I've read everything DMA in the kernel Doc dir and
searched the web to no avail. So I thought I might get some useful info here.

I'm currently using a 3.18.3 (x86_64) kernel on an AMD platform. I am
currently doing 8MB DMAs to and from our device using the in kernel CMA
"cma=64M@0-4G" with no problems. This device is not DAC or scatter/gather
capable so the in kernel CMA has been great and replaced our old bigphysarea
usage.

We simply use dma_alloc_coherent and pass the dma_addr_t *dma_handle
returned from the dma_alloc_coherent function to our device as the "bus/pci"
address to use.

We also use remap_pfn_range on that dma_addr_t *dma_handle returned from 
the dma_alloc_coherent function to mmap userland to the buffer. All is good
until I enable the IOMMU. I then either get IO_PAGE_FAULTs, the DMA just
quietly never completes or the system gets borked.

[  106.115725] AMD-Vi: Event logged [IO_PAGE_FAULT device=03:00.0
domain=0x001b address=0x00000000aa500000 flags=0x0010]
[  106.115729] AMD-Vi: Event logged [IO_PAGE_FAULT device=03:00.0
domain=0x001b address=0x00000000aa500040 flags=0x0010]

Here are the IOMMU settings in my kernel config:

#grep IOMMU .config
# CONFIG_GART_IOMMU is not set
# CONFIG_CALGARY_IOMMU is not set
CONFIG_IOMMU_HELPER=y
CONFIG_VFIO_IOMMU_TYPE1=m
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y
CONFIG_AMD_IOMMU=y
# CONFIG_AMD_IOMMU_STATS is not set
CONFIG_AMD_IOMMU_V2=m
CONFIG_INTEL_IOMMU=y
CONFIG_INTEL_IOMMU_DEFAULT_ON=y
CONFIG_INTEL_IOMMU_FLOPPY_WA=y
# CONFIG_IOMMU_STRESS is not set


>From reading the in kernel doc it would appear that we could in fact, using
the IOMMU and the dma_map_sg function, get rid of the CMA requirement and
our device could DMA anywhere, even above the 4GB address space limit of our
device. But before going through this larger change to our GPL driver, I
want to understand if and/or why the dma_alloc_coherent function does not
appear to set up the IOMMU for me. Is the IOMMU only supported for
"streaming" DMA type and not for "coherent"? I read no reference to this in
the kernel doc?

Any hints would be greatly appreciated. Again, sorry for the noise. 


"end quote"

Sorry if this is not correct place to get info on the AMD IOMMU support in
the kernel. If it's not could someone point me in the right direction?

Thanks and Regards
Mark
