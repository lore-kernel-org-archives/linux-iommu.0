From: Yongji Xie <xyjxie-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Subject: [RESEND PATCH v2 6/6] vfio-pci: Allow to expose MSI-X table to
	userspace if interrupt remapping is enabled
Date: Thu,  2 Jun 2016 14:10:03 +0800
Message-ID: <1464847803-22756-7-git-send-email-xyjxie@linux.vnet.ibm.com>
References: <1464847803-22756-1-git-send-email-xyjxie@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1464847803-22756-1-git-send-email-xyjxie-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: alistair-Y4h6yKqj69EXC2x5gXVKYQ@public.gmane.org, nikunj-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, zhong-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, aik-sLpHqDYs0B2HXe+LvDLADg@public.gmane.org, mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org, ruscur-3Su/lFKaw5ejKv3TNrM5DQ@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, gwshan-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, warrier-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, David.Laight-ZS65k/vG3HxXrIkS9f7CXA@public.gmane.org, paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This patch tries to expose MSI-X tables to userspace if hardware
enables interrupt remapping. This capability can ensure that a
given PCI device can only shoot the MSIs assigned for it. That
means a userspace driver could never hurt other devices or system
by writing to the exposed MSI-X table directly.

Signed-off-by: Yongji Xie <xyjxie-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
---
 drivers/vfio/pci/vfio_pci.c      |   17 ++++++++++++++---
 drivers/vfio/pci/vfio_pci_rdwr.c |    3 ++-
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 188b1ff..6bae388 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -487,8 +487,12 @@ static int msix_sparse_mmap_cap(struct vfio_pci_device *vdev,
 
 	end = pci_resource_len(vdev->pdev, vdev->msix_bar);
 
-	/* If MSI-X table is aligned to the start or end, only one area */
-	if (((vdev->msix_offset & PAGE_MASK) == 0) ||
+	/*
+	 * If MSI-X table is allowed to mmap because of the capability
+	 * of IRQ remapping or aligned to the start or end, only one area
+	 */
+	if ((vdev->pdev->bus->bus_flags & PCI_BUS_FLAGS_MSI_REMAP) ||
+	    ((vdev->msix_offset & PAGE_MASK) == 0) ||
 	    (PAGE_ALIGN(vdev->msix_offset + vdev->msix_size) >= end))
 		nr_areas = 1;
 
@@ -503,6 +507,12 @@ static int msix_sparse_mmap_cap(struct vfio_pci_device *vdev,
 			      struct vfio_region_info_cap_sparse_mmap, header);
 	sparse->nr_areas = nr_areas;
 
+	if (vdev->pdev->bus->bus_flags & PCI_BUS_FLAGS_MSI_REMAP) {
+		sparse->areas[i].offset = 0;
+		sparse->areas[i].size = end;
+		return 0;
+	}
+
 	if (vdev->msix_offset & PAGE_MASK) {
 		sparse->areas[i].offset = 0;
 		sparse->areas[i].size = vdev->msix_offset & PAGE_MASK;
@@ -1061,7 +1071,8 @@ static int vfio_pci_mmap(void *device_data, struct vm_area_struct *vma)
 	if (phys_len < PAGE_SIZE || req_start + req_len > phys_len)
 		return -EINVAL;
 
-	if (index == vdev->msix_bar) {
+	if (index == vdev->msix_bar &&
+		!(pdev->bus->bus_flags & PCI_BUS_FLAGS_MSI_REMAP)) {
 		/*
 		 * Disallow mmaps overlapping the MSI-X table; users don't
 		 * get to touch this directly.  We could find somewhere
diff --git a/drivers/vfio/pci/vfio_pci_rdwr.c b/drivers/vfio/pci/vfio_pci_rdwr.c
index 5ffd1d9..dbf9cd0 100644
--- a/drivers/vfio/pci/vfio_pci_rdwr.c
+++ b/drivers/vfio/pci/vfio_pci_rdwr.c
@@ -164,7 +164,8 @@ ssize_t vfio_pci_bar_rw(struct vfio_pci_device *vdev, char __user *buf,
 	} else
 		io = vdev->barmap[bar];
 
-	if (bar == vdev->msix_bar) {
+	if (bar == vdev->msix_bar &&
+		!(pdev->bus->bus_flags & PCI_BUS_FLAGS_MSI_REMAP)) {
 		x_start = vdev->msix_offset;
 		x_end = vdev->msix_offset + vdev->msix_size;
 	}
-- 
1.7.9.5
