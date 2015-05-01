From: <wdavis-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 0/6] IOMMU/DMA map_resource support for peer-to-peer
Date: Fri, 1 May 2015 13:32:12 -0500
Message-ID: <1430505138-2877-1-git-send-email-wdavis@nvidia.com>
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
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: jglisse-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Will Davis <wdavis-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, jhubbard-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, tripperda-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Will Davis <wdavis-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

Hi,

This patch series adds DMA APIs to map and unmap a struct resource to and from
a PCI device's IOVA domain, and implements the AMD, Intel, and nommu versions
of these interfaces.

This solves a long-standing problem with the existing DMA-remapping interfaces,
which require that a struct page be given for the region to be mapped into a
device's IOVA domain. This requirement cannot support peer device BAR ranges,
for which no struct pages exist.

The underlying implementations of map_page and map_sg convert the struct page
into its physical address anyway, so we just need a way to route the physical
address of the BAR region to these implementations. The new interfaces do this
by taking the struct resource describing a device's BAR region, from which the
physical address is derived.

The Intel and nommu versions have been verified on a dual Intel Xeon E5405
workstation. I'm in the process of obtaining hardware to test the AMD version
as well. Please review.

Thanks,
Will

Will Davis (6):
  dma-debug: add checking for map/unmap_resource
  DMA-API: Introduce dma_(un)map_resource
  dma-mapping: pci: add pci_(un)map_resource
  iommu/amd: Implement (un)map_resource
  iommu/vt-d: implement (un)map_resource
  x86: add pci-nommu implementation of map_resource

 arch/x86/kernel/pci-nommu.c              | 17 +++++++
 drivers/iommu/amd_iommu.c                | 76 ++++++++++++++++++++++++++------
 drivers/iommu/intel-iommu.c              | 18 ++++++++
 include/asm-generic/dma-mapping-broken.h |  9 ++++
 include/asm-generic/dma-mapping-common.h | 34 ++++++++++++++
 include/asm-generic/pci-dma-compat.h     | 14 ++++++
 include/linux/dma-debug.h                | 20 +++++++++
 include/linux/dma-mapping.h              |  7 +++
 lib/dma-debug.c                          | 48 ++++++++++++++++++++
 9 files changed, 230 insertions(+), 13 deletions(-)

-- 
2.3.7
