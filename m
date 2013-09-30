From: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
Subject: [PATCH 4/7] VFIO: DT: Support MMAP of MMIO regions
Date: Mon, 30 Sep 2013 17:28:40 +0200
Message-ID: <1380554923-17818-5-git-send-email-a.motakis@virtualopensystems.com>
References: <1380554923-17818-1-git-send-email-a.motakis@virtualopensystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1380554923-17818-1-git-send-email-a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, agraf-l3A5Bk7waGM@public.gmane.org, B08248-KZfg59tc24xl57MIdRCFDg@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Signed-off-by: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
---
 drivers/vfio/vfio_platform.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/vfio/vfio_platform.c b/drivers/vfio/vfio_platform.c
index a0abcfa..6364316 100644
--- a/drivers/vfio/vfio_platform.c
+++ b/drivers/vfio/vfio_platform.c
@@ -103,6 +103,10 @@ static long vfio_platform_ioctl(void *device_data,
 		info.offset = res.start;	/* map phys addr with offset */
 		info.size = resource_size(&res);
 		info.flags = 0;
+		/* Only regions addressed with PAGE granularity can be MMAPed
+		 * securely. */
+		if (!(info.offset & ~PAGE_MASK) && !(info.size & ~PAGE_MASK))
+			info.flags |= VFIO_REGION_INFO_FLAG_MMAP;
 
 		return copy_to_user((void __user *)arg, &info, minsz);
 
@@ -134,6 +138,18 @@ static long vfio_platform_ioctl(void *device_data,
 	return -ENOTTY;
 }
 
+static bool is_in_resource(struct resource res, u64 addr, u64 size)
+{
+	if (addr < res.start)
+		return false;
+	if (addr > res.end)
+		return false;
+	if (addr + size - 1 > res.end)
+		return false;
+
+	return true;
+}
+
 static ssize_t vfio_platform_read(void *device_data, char __user *buf,
 			     size_t count, loff_t *ppos)
 {
@@ -148,6 +164,34 @@ static ssize_t vfio_platform_write(void *device_data, const char __user *buf,
 
 static int vfio_platform_mmap(void *device_data, struct vm_area_struct *vma)
 {
+	struct vfio_platform_device *vdev = device_data;
+	struct device_node *of_node = vdev->pdev->dev.of_node;
+	u64 req_len = vma->vm_end - vma->vm_start;
+	u64 addr = vma->vm_pgoff << PAGE_SHIFT;
+	struct resource res;
+	int i;
+
+	if (vma->vm_end < vma->vm_start)
+		return -EINVAL;
+	if (vma->vm_start & ~PAGE_MASK)
+		return -EINVAL;
+	if (vma->vm_end & ~PAGE_MASK)
+		return -EINVAL;
+	if ((vma->vm_flags & VM_SHARED) == 0)
+		return -EINVAL;
+
+	for (i = 0; !of_address_to_resource(of_node, i, &res); i++) {
+		if (!is_in_resource(res, addr, req_len))
+			continue;
+
+		vma->vm_private_data = vdev;
+		vma->vm_flags |= VM_IO | VM_DONTEXPAND | VM_DONTDUMP;
+		vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+
+		return remap_pfn_range(vma, vma->vm_start, addr,
+				       req_len, vma->vm_page_prot);
+	}
+
 	return -EINVAL;
 }
 
-- 
1.8.1.2
