From: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [Patch Part3 V5 0/8] Enable support of Intel DMAR device hotplug
Date: Fri, 12 Sep 2014 10:10:40 +0800
Message-ID: <1410487848-6027-1-git-send-email-jiang.liu@linux.intel.com>
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
drivers to support hotplug and is based on latest Linus master branch.

All prerequisite patches to support DMAR device hotplug have been merged
into the mainstream kernel, and this is the last patch set to enable
DMAR device hotplug.

You may access the patch set at:
https://github.com/jiangliu/linux.git iommu/hotplug_v5

This patch set has been tested on Intel development machine.
Appreciate any comments and tests.

Patch 1-4 enhances DMAR framework to support hotplug
Patch 5 enhances Intel interrupt remapping driver to support hotplug
Patch 6 enhances error handling in Intel IR driver
Patch 7 enhance Intel IOMMU to support hotplug
Patch 8 enhance ACPI pci_root driver to handle DMAR units

Jiang Liu (8):
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
 drivers/iommu/dmar.c                |  532 ++++++++++++++++++++++++++++-------
 drivers/iommu/intel-iommu.c         |  297 ++++++++++++++-----
 drivers/iommu/intel_irq_remapping.c |  233 +++++++++++----
 include/linux/dmar.h                |   50 +++-
 5 files changed, 888 insertions(+), 240 deletions(-)

-- 
1.7.10.4
