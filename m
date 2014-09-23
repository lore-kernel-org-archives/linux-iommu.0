From: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
Subject: [PATCHv7 16/26] vfio/platform: read and write support for the device
	fd
Date: Tue, 23 Sep 2014 16:46:15 +0200
Message-ID: <1411483586-29304-17-git-send-email-a.motakis@virtualopensystems.com>
References: <1411483586-29304-1-git-send-email-a.motakis@virtualopensystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1411483586-29304-1-git-send-email-a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

VFIO returns a file descriptor which we can use to manipulate the memory
regions of the device. Usually, the user will mmap memory regions that are
addressable on page boundaries, however for memory regions where this is
not the case we cannot provide mmap functionality due to security concerns.
For this reason we also need allow to read and write to the memory regions
via the file descriptor.

Signed-off-by: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
---
 drivers/vfio/platform/vfio_platform_common.c  | 121 +++++++++++++++++++++++++-
 drivers/vfio/platform/vfio_platform_private.h |   1 +
 2 files changed, 119 insertions(+), 3 deletions(-)

diff --git a/drivers/vfio/platform/vfio_platform_common.c b/drivers/vfio/platform/vfio_platform_common.c
index 469bdcb..589b226 100644
--- a/drivers/vfio/platform/vfio_platform_common.c
+++ b/drivers/vfio/platform/vfio_platform_common.c
@@ -48,7 +48,8 @@ static int vfio_platform_regions_init(struct vfio_platform_device *vdev)
 
 		vdev->regions[i].addr = res->start;
 		vdev->regions[i].size = resource_size(res);
-		vdev->regions[i].flags = 0;
+		vdev->regions[i].flags = VFIO_REGION_INFO_FLAG_READ
+					| VFIO_REGION_INFO_FLAG_WRITE;
 	}
 
 	vdev->num_regions = cnt;
@@ -61,6 +62,11 @@ err:
 
 static void vfio_platform_regions_cleanup(struct vfio_platform_device *vdev)
 {
+	int i;
+
+	for (i = 0; i < vdev->num_regions; i++)
+		iounmap(vdev->regions[i].ioaddr);
+
 	vdev->num_regions = 0;
 	kfree(vdev->regions);
 }
@@ -155,13 +161,122 @@ static long vfio_platform_ioctl(void *device_data,
 static ssize_t vfio_platform_read(void *device_data, char __user *buf,
 			     size_t count, loff_t *ppos)
 {
-	return -EINVAL;
+	struct vfio_platform_device *vdev = device_data;
+	unsigned int index = VFIO_PLATFORM_OFFSET_TO_INDEX(*ppos);
+	loff_t off = *ppos & VFIO_PLATFORM_OFFSET_MASK;
+	unsigned int done = 0;
+
+	if (index >= vdev->num_regions)
+		return -EINVAL;
+
+	if (!vdev->regions[index].ioaddr) {
+		vdev->regions[index].ioaddr =
+			ioremap_nocache(vdev->regions[index].addr,
+					vdev->regions[index].size);
+
+		if (!vdev->regions[index].ioaddr)
+			return -ENOMEM;
+	}
+
+	while (count) {
+		size_t filled;
+
+		if (count >= 4 && !(off % 4)) {
+			u32 val;
+
+			val = ioread32(vdev->regions[index].ioaddr + off);
+			if (copy_to_user(buf, &val, 4))
+				goto err;
+
+			filled = 4;
+		} else if (count >= 2 && !(off % 2)) {
+			u16 val;
+
+			val = ioread16(vdev->regions[index].ioaddr + off);
+			if (copy_to_user(buf, &val, 2))
+				goto err;
+
+			filled = 2;
+		} else {
+			u8 val;
+
+			val = ioread8(vdev->regions[index].ioaddr + off);
+			if (copy_to_user(buf, &val, 1))
+				goto err;
+
+			filled = 1;
+		}
+
+
+		count -= filled;
+		done += filled;
+		off += filled;
+		buf += filled;
+	}
+
+	return done;
+err:
+	return -EFAULT;
 }
 
 static ssize_t vfio_platform_write(void *device_data, const char __user *buf,
 			      size_t count, loff_t *ppos)
 {
-	return -EINVAL;
+	struct vfio_platform_device *vdev = device_data;
+	unsigned int index = VFIO_PLATFORM_OFFSET_TO_INDEX(*ppos);
+	loff_t off = *ppos & VFIO_PLATFORM_OFFSET_MASK;
+	unsigned int done = 0;
+
+	if (index >= vdev->num_regions)
+		return -EINVAL;
+
+	if (!vdev->regions[index].ioaddr) {
+		vdev->regions[index].ioaddr =
+			ioremap_nocache(vdev->regions[index].addr,
+					vdev->regions[index].size);
+
+		if (!vdev->regions[index].ioaddr)
+			return -ENOMEM;
+	}
+
+	while (count) {
+		size_t filled;
+
+		if (count >= 4 && !(off % 4)) {
+			u32 val;
+
+			if (copy_from_user(&val, buf, 4))
+				goto err;
+			iowrite32(val, vdev->regions[index].ioaddr + off);
+
+			filled = 4;
+		} else if (count >= 2 && !(off % 2)) {
+			u16 val;
+
+			if (copy_from_user(&val, buf, 2))
+				goto err;
+			iowrite16(val, vdev->regions[index].ioaddr + off);
+
+			filled = 2;
+		} else {
+			u8 val;
+
+			if (copy_from_user(&val, buf, 1))
+				goto err;
+			iowrite8(val, vdev->regions[index].ioaddr + off);
+
+			filled = 1;
+		}
+
+		count -= filled;
+		done += filled;
+		off += filled;
+		buf += filled;
+	}
+
+	return done;
+err:
+	return -EFAULT;
 }
 
 static int vfio_platform_mmap(void *device_data, struct vm_area_struct *vma)
diff --git a/drivers/vfio/platform/vfio_platform_private.h b/drivers/vfio/platform/vfio_platform_private.h
index 383164a..4145fd6 100644
--- a/drivers/vfio/platform/vfio_platform_private.h
+++ b/drivers/vfio/platform/vfio_platform_private.h
@@ -28,6 +28,7 @@ struct vfio_platform_region {
 	u64			addr;
 	resource_size_t		size;
 	u32			flags;
+	void __iomem		*ioaddr;
 };
 
 struct vfio_platform_device {
-- 
1.8.3.2
