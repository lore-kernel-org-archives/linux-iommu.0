From: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [Patch Part3 V4 00/21] Enable support of Intel DMAR device hotplug
Date: Fri, 11 Jul 2014 14:19:24 +0800
Message-ID: <1405059585-10620-1-git-send-email-jiang.liu@linux.intel.com>
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
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Yinghai Lu <yinghai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Rafael J . Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-hotplug-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

When hot plugging a descrete IOH or a physical processor with embedded
IIO, we need to handle DMAR(or IOMMU) unit in the PCIe host bridge if
DMAR is in use. This patch set tries to enhance current DMAR/IOMMU/IR
drivers to support hotplug and is based on latest Joerg's iommu/next
branch.

Patch 1-13 are bugfixes and code improvement for current drivers.
Patch 14-17 enhances DMAR framework to support hotplug
Patch 18 enhances Intel interrupt remapping driver to support hotplug
Patch 19 enhances error handling in Intel IR driver
Patch 20 enhance Intel IOMMU to support hotplug
Patch 21 enhance ACPI pci_root driver to handle DMAR units

This patch set has been tested on Intel development machine.
Appreciate any comments and tests. With this patch set and
another IOAPIC hotplug patch set(http://www.mail-archive.com/linux-kernel
@vger.kernel.org/msg671316.html) applied, we could support full functional
socket hotplug on x86 platforms now.

V3->V4:
1) rebase onto iommu/next branch to solve conflicts
2) refine commit messages according to Bjorn's suggestion.

V2->V3:
1) rebase to latest v3.16-rc2
2) fix a bug in detecting super page support when hot-adding IOMMU

V1->V2:
1) enhance the way to simplify intel_unmap_sg()
2) rename dmar_device_hotplug() to dmar_device_add/remove()
3) coding style improvment

Best Regards!

Jiang Liu (21):
  iommu/vt-d: Match segment number when searching for dev_iotlb capable
    devices
  iommu/vt-d: Use correct domain id to flush virtual machine domains
  iommu/vt-d: Introduce helper functions to improve code readability
  iommu/vt-d: Introduce helper functions to make code symmetric for
    readability
  iommu/vt-d: Allocate dynamic domain id for virtual domains only
  iommu/vt-d: Fix possible invalid memory access caused by
    free_dmar_iommu()
  iommu/vt-d: Avoid freeing virtual machine domain in free_dmar_iommu()
  iommu/vt-d: Simplify include/linux/dmar.h
  iommu/vt-d: Change iommu_enable/disable_translation to return void
  iommu/vt-d: Simplify intel_unmap_sg() and kill duplicated code
  iommu/vt-d: Introduce helper domain_pfn_within_range() to simplify
    code
  iommu/vt-d: Introduce helper function iova_size() to improve code
    readability
  iommu/vt-d: Fix issue in computing domain's iommu_snooping flag
  iommu/vt-d: Introduce helper function dmar_walk_resources()
  iommu/vt-d: Dynamically allocate and free seq_id for DMAR units
  iommu/vt-d: Implement DMAR unit hotplug framework
  iommu/vt-d: Search for ACPI _DSM method for DMAR hotplug
  iommu/vt-d: Enhance intel_irq_remapping driver to support DMAR unit
    hotplug
  iommu/vt-d: Enhance error recovery in function
    intel_enable_irq_remapping()
  iommu/vt-d: Enhance intel-iommu driver to support DMAR unit hotplug
  pci, ACPI, iommu: Enhance pci_root to support DMAR device hotplug

 drivers/acpi/pci_root.c             |   16 +-
 drivers/iommu/dmar.c                |  531 ++++++++++++++++++++------
 drivers/iommu/intel-iommu.c         |  720 +++++++++++++++++++++--------------
 drivers/iommu/intel_irq_remapping.c |  233 +++++++++---
 include/linux/dmar.h                |   86 +++--
 include/linux/iova.h                |    5 +
 6 files changed, 1104 insertions(+), 487 deletions(-)

-- 
1.7.10.4
