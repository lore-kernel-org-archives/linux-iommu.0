From: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
Subject: [PATCH 5/7] VFIO: DT: Read and write support for the device fd
Date: Mon, 30 Sep 2013 17:28:41 +0200
Message-ID: <1380554923-17818-6-git-send-email-a.motakis@virtualopensystems.com>
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

VFIO returns a file descriptor which we can use to manipulate the memory
regions of the device. Since some memory regions we cannot mmap due to
security concerns, we also allow to read and write to this file descriptor
directly.

Signed-off-by: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
---
 drivers/vfio/vfio_platform.c | 37 ++++++++++++++++++++++++++++++++++---
 1 file changed, 34 insertions(+), 3 deletions(-)

diff --git a/drivers/vfio/vfio_platform.c b/drivers/vfio/vfio_platform.c
index 6364316..b92d7bb 100644
--- a/drivers/vfio/vfio_platform.c
+++ b/drivers/vfio/vfio_platform.c
@@ -102,7 +102,8 @@ static long vfio_platform_ioctl(void *device_data,
 
 		info.offset = res.start;	/* map phys addr with offset */
 		info.size = resource_size(&res);
-		info.flags = 0;
+		info.flags = VFIO_REGION_INFO_FLAG_READ
+				| VFIO_REGION_INFO_FLAG_WRITE;
 		/* Only regions addressed with PAGE granularity can be MMAPed
 		 * securely. */
 		if (!(info.offset & ~PAGE_MASK) && !(info.size & ~PAGE_MASK))
@@ -153,13 +154,43 @@ static bool is_in_resource(struct resource res, u64 addr, u64 size)
 static ssize_t vfio_platform_read(void *device_data, char __user *buf,
 			     size_t count, loff_t *ppos)
 {
-	return 0;
+	struct vfio_platform_device *vdev = device_data;
+	struct device_node *of_node = vdev->pdev->dev.of_node;
+	struct resource res;
+	int i;
+
+	for (i = 0; !of_address_to_resource(of_node, i, &res); i++) {
+		if (!is_in_resource(res, *ppos, count))
+			continue;
+
+		if (copy_to_user(buf, ppos, count))
+			return -EFAULT;
+		else
+			return count;
+	}
+
+	return -EINVAL;
 }
 
 static ssize_t vfio_platform_write(void *device_data, const char __user *buf,
 			      size_t count, loff_t *ppos)
 {
-	return 0;
+	struct vfio_platform_device *vdev = device_data;
+	struct device_node *of_node = vdev->pdev->dev.of_node;
+	struct resource res;
+	int i;
+
+	for (i = 0; !of_address_to_resource(of_node, i, &res); i++) {
+		if (!is_in_resource(res, *ppos, count))
+			continue;
+
+		if (copy_from_user(ppos, buf, count))
+			return -EFAULT;
+		else
+			return count;
+	}
+
+	return -EINVAL;
 }
 
 static int vfio_platform_mmap(void *device_data, struct vm_area_struct *vma)
-- 
1.8.1.2
