From: Yijing Wang <wangyijing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2] Enhance dmar to support device hotplug
Date: Thu, 21 Nov 2013 16:21:55 +0800
Message-ID: <1385022116-228-1-git-send-email-wangyijing@huawei.com>
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
To: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Hanjun Guo <guohanjun-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

This is the v2 patch, the v1 link: http://marc.info/?l=linux-pci&m=138364004628824&w=2

v1->v2: keep (pci_dev *) pointer array in dmar_drhd_uni, only use pci device id
		to update pci_dev * pointer info during device hotplug in intel iommu 
		driver notifier.

Currently, DMAR driver save target pci devices pointers for drhd/rmrr/atsr
in (pci_dev *) array, but never update these info after initialization.
It's not safe, because pci devices maybe hot added or removed during 
system running. They will have new pci_dev * pointer. So if there have 
two IOMMUs or more in system, these devices will find a wrong drhd during 
DMA mapping. And DMAR faults will occur. This patch save pci device id 
as well as (pci_dev *) to fix this issue. Pci device id will be used to update
pci_dev * poninter during device hotplug in intel iommu driver notifier.
Other, here use list to manage target devices for IOMMU, 
we can easily use list helper.

Yijing Wang (1):
  IOMMU: enhance dmar to support device hotplug

 drivers/iommu/dmar.c        |   82 +++++++++++-----------
 drivers/iommu/intel-iommu.c |  161 +++++++++++++++++++++++++++++-------------
 include/linux/dmar.h        |   24 ++++--
 3 files changed, 167 insertions(+), 100 deletions(-)
