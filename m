From: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v3 00/10] iommu: Bounce page for untrusted devices
Date: Sun, 21 Apr 2019 09:17:09 +0800
Message-ID: <20190421011719.14909-1-baolu.lu@linux.intel.com>
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
To: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, alan.cox-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pengfei.xu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

The Thunderbolt vulnerabilities are public and have a nice
name as Thunderclap [1] [3] nowadays. This patch series aims
to mitigate those concerns.

An external PCI device is a PCI peripheral device connected
to the system through an external bus, such as Thunderbolt.
What makes it different is that it can't be trusted to the
same degree as the devices build into the system. Generally,
a trusted PCIe device will DMA into the designated buffers
and not overrun or otherwise write outside the specified
bounds. But it's different for an external device.

The minimum IOMMU mapping granularity is one page (4k), so
for DMA transfers smaller than that a malicious PCIe device
can access the whole page of memory even if it does not
belong to the driver in question. This opens a possibility
for DMA attack. For more information about DMA attacks
imposed by an untrusted PCI/PCIe device, please refer to [2].

This implements bounce buffer for the untrusted external
devices. The transfers should be limited in isolated pages
so the IOMMU window does not cover memory outside of what
the driver expects. Full pages within a buffer could be
directly mapped in IOMMU page table, but for partial pages
we use bounce page instead.

The implementation of bounce buffers for untrusted devices
will cause a little performance overhead, but we didn't see
any user experience problems. The users could use the kernel
parameter defined in the IOMMU driver to remove the performance
overhead if they trust their devices enough.

The first part of this patch series (PATCH1/10 ~ 4/10) extends
the swiotlb APIs to support bounce buffer in page manner. The
second part (PATCH 5/10) introduce the APIs for bounce page:

 * iommu_bounce_map(dev, addr, paddr, size, dir, attrs)
   - Map a buffer start at DMA address @addr in bounce page
     manner. For buffer parts that doesn't cross a whole
     minimal IOMMU page, the bounce page policy is applied.
     A bounce page mapped by swiotlb will be used as the DMA
     target in the IOMMU page table. Otherwise, the physical
     address @paddr is mapped instead.
 
 * iommu_bounce_unmap(dev, addr, size, dir, attrs)
   - Unmap the buffer mapped with iommu_bounce_map(). The bounce
     page will be torn down after the bounced data get synced.
 
 * iommu_bounce_sync_single(dev, addr, size, dir, target)
   - Synce the bounced data in case the bounce mapped buffer is
     reused.

The third part of this patch series (PATCH 6/10 ~ 10/10) uses
the bounce page APIs to map/unmap/sync DMA buffers for those
untrusted devices in Intel IOMMU driver.

The third part of this patch series depends on a patch set posted
here [4] for discussion. It delegates Intel IOMMU DMA domains to
the iommu generic layer.

The bounce page idea:
Based-on-idea-by: Mika Westerberg <mika.westerberg-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Based-on-idea-by: Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Based-on-idea-by: Alan Cox <alan.cox-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Based-on-idea-by: Kevin Tian <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

The patch series has been tested by:
Tested-by: Xu Pengfei <pengfei.xu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Tested-by: Mika Westerberg <mika.westerberg-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

Reference:
[1] https://thunderclap.io/
[2] https://thunderclap.io/thunderclap-paper-ndss2019.pdf
[3] https://christian.kellner.me/2019/02/27/thunderclap-and-linux/
[4] https://lkml.org/lkml/2019/3/4/644

Best regards,
Lu Baolu

Change log:
  v2->v3:
  - The previous v2 was posed here:
    https://lkml.org/lkml/2019/3/27/157
  - Reuse the existing swiotlb APIs for bounce buffer by
    extending it to support bounce page.
  - Move the bouce page APIs into iommu generic layer.
  - This patch series is based on 5.1-rc1.

  v1->v2:
  - The previous v1 was posted here:
    https://lkml.org/lkml/2019/3/12/66
  - Refactor the code to remove struct bounce_param;
  - During the v1 review cycle, we discussed the possibility
    of reusing swiotlb code to avoid code dumplication, but
    we found the swiotlb implementations are not ready for the
    use of bounce page pool.
    https://lkml.org/lkml/2019/3/19/259
  - This patch series has been rebased to v5.1-rc2.

Lu Baolu (10):
  iommu: Add helper to get minimal page size of domain
  swiotlb: Factor out slot allocation and free
  swiotlb: Limit tlb address range inside slot pool
  swiotlb: Extend swiotlb to support page bounce
  iommu: Add bounce page APIs
  iommu/vt-d: Add trace events for domain map/unmap
  iommu/vt-d: Keep swiotlb on if bounce page is necessary
  iommu/vt-d: Check whether device requires bounce buffer
  iommu/vt-d: Add dma sync ops for untrusted devices
  iommu/vt-d: Use bounce buffer for untrusted devices

 .../admin-guide/kernel-parameters.txt         |   5 +
 drivers/iommu/Kconfig                         |  15 +
 drivers/iommu/Makefile                        |   1 +
 drivers/iommu/intel-iommu.c                   | 276 ++++++++++++++----
 drivers/iommu/intel-trace.c                   |  14 +
 drivers/iommu/iommu.c                         | 275 +++++++++++++++++
 include/linux/dma-mapping.h                   |   6 +
 include/linux/iommu.h                         |  50 ++++
 include/trace/events/intel_iommu.h            | 132 +++++++++
 kernel/dma/swiotlb.c                          | 117 ++++++--
 10 files changed, 808 insertions(+), 83 deletions(-)
 create mode 100644 drivers/iommu/intel-trace.c
 create mode 100644 include/trace/events/intel_iommu.h

-- 
2.17.1
