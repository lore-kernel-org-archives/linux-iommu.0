From: Antonios Motakis <a.motakis@virtualopensystems.com>
Subject: [RFC PATCH v6 12/20] vfio/platform: support MMAP of MMIO regions
Date: Thu,  5 Jun 2014 19:03:20 +0200
Message-ID: <1401987808-23596-13-git-send-email-a.motakis@virtualopensystems.com>
References: <1401987808-23596-1-git-send-email-a.motakis@virtualopensystems.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1401987808-23596-1-git-send-email-a.motakis@virtualopensystems.com>
Sender: kvm-owner@vger.kernel.org
To: alex.williamson@redhat.com, kvmarm@lists.cs.columbia.edu, iommu@lists.linux-foundation.org
Cc: tech@virtualopensystems.com, a.rigo@virtualopensystems.com, kvm@vger.kernel.org, christoffer.dall@linaro.org, will.deacon@arm.com, kim.phillips@freescale.com, stuart.yoder@freescale.com, eric.auger@linaro.org, Antonios Motakis <a.motakis@virtualopensystems.com>, open list <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

Allow to memory map the MMIO regions of the device so userspace can
directly access them.

Signed-off-by: Antonios Motakis <a.motakis@virtualopensystems.com>
---
 drivers/vfio/platform/vfio_platform.c | 40 ++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/platform/vfio_platform.c b/drivers/vfio/platform/vfio_platform.c
index c66afbc..1515175 100644
--- a/drivers/vfio/platform/vfio_platform.c
+++ b/drivers/vfio/platform/vfio_platform.c
@@ -57,6 +57,11 @@ static int vfio_platform_regions_init(struct vfio_platform_device *vdev)
 		vdev->region[i].size = resource_size(res);
 		vdev->region[i].flags = VFIO_REGION_INFO_FLAG_READ
 					| VFIO_REGION_INFO_FLAG_WRITE;
+		/* Only regions addressed with PAGE granularity may be MMAPed
+		 * securely. */
+		if (!(vdev->region[i].addr & ~PAGE_MASK)
+				&& !(vdev->region[i].size & ~PAGE_MASK))
+			vdev->region[i].flags |= VFIO_REGION_INFO_FLAG_MMAP;
 	}
 
 	vdev->num_regions = cnt;
@@ -276,7 +281,40 @@ err:
 
 static int vfio_platform_mmap(void *device_data, struct vm_area_struct *vma)
 {
-	return -EINVAL;
+	struct vfio_platform_device *vdev = device_data;
+	unsigned int index;
+	u64 req_len, pgoff, req_start;
+	struct vfio_platform_region region;
+
+	index = vma->vm_pgoff >> (VFIO_PLATFORM_OFFSET_SHIFT - PAGE_SHIFT);
+
+	if (vma->vm_end < vma->vm_start)
+		return -EINVAL;
+	if ((vma->vm_flags & VM_SHARED) == 0)
+		return -EINVAL;
+	if (index >= vdev->num_regions)
+		return -EINVAL;
+	if (vma->vm_start & ~PAGE_MASK)
+		return -EINVAL;
+	if (vma->vm_end & ~PAGE_MASK)
+		return -EINVAL;
+
+	region = vdev->region[index];
+
+	req_len = vma->vm_end - vma->vm_start;
+	pgoff = vma->vm_pgoff &
+		((1U << (VFIO_PLATFORM_OFFSET_SHIFT - PAGE_SHIFT)) - 1);
+	req_start = pgoff << PAGE_SHIFT;
+
+	if (region.size < PAGE_SIZE || req_start + req_len > region.size)
+		return -EINVAL;
+
+	vma->vm_private_data = vdev;
+	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+	vma->vm_pgoff = (region.addr >> PAGE_SHIFT) + pgoff;
+
+	return remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
+			       req_len, vma->vm_page_prot);
 }
 
 static const struct vfio_device_ops vfio_platform_ops = {
-- 
1.8.3.2

