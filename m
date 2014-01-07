From: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [Patch Part2 V1 00/14] Enhance DMAR drivers to handle PCI/memory
	hotplug events
Date: Tue,  7 Jan 2014 17:00:20 +0800
Message-ID: <1389085234-22296-1-git-send-email-jiang.liu@linux.intel.com>
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
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Yinghai Lu <yinghai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Intel DMA/interrupt remapping drivers scan available PCI/memory devices
at startup and cache discovered hardware topologies. They don't update
cached information if PCI/memory hotplug event happens at runtime, then
the stale information may break DMA/interrupt remapping logic.

This patchset first (Patch 1-8) tries to introduces some helper
functions and fixes several bugs, then (Patch 9,10) uses a global
rwsem and RCU to protect global DMA/interrupt remapping data
structures, and finally (Patch 11-14) hook PCI/memory hotplug events
to update cached information.

It's also a preparation for supporting of DMA/interrupt remapping
hotplug.

Jiang Liu (14):
  iommu/vt-d: factor out dmar_alloc_dev_scope() for later reuse
  iommu/vt-d: move private structures and variables into intel-iommu.c
  iommu/vt-d: simplify function get_domain_for_dev()
  iommu/vt-d: free resources if failed to create domain for PCIe
    endpoint
  iommu/vt-d: create device_domain_info structure for intermediate P2P
    bridges
  iommu/vt-d: fix incorrect iommu_count for si_domain
  iommu/vt-d: fix error in detect ATS capability
  iommu/vt-d: introduce macro for_each_dev_scope() to walk device scope
    entries
  iommu/vt-d: introduce a rwsem to protect global data structures
  iommu/vt-d: use RCU to protect global resources in interrupt context
  iommu/vt-d, PCI: update DRHD/RMRR/ATSR device scope caches when PCI
    hotplug happens
  iommu/vt-d, PCI: unify the way to process DMAR device scope array
  iommu/vt-d: update device to static identity domain mapping for PCI
    hotplug
  iommu/vt-d: update IOMMU state when memory hotplug happens

 drivers/iommu/dmar.c                |  412 +++++++++++++++++--------
 drivers/iommu/intel-iommu.c         |  583 +++++++++++++++++++++--------------
 drivers/iommu/intel_irq_remapping.c |  108 ++++---
 include/linux/dmar.h                |   75 +++--
 4 files changed, 753 insertions(+), 425 deletions(-)

-- 
1.7.10.4
