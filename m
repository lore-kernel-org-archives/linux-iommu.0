From: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
Subject: [PATCH 4/9] VFIO_PLATFORM: Return info for device and its memory
	mapped IO regions
Date: Wed, 11 Dec 2013 21:58:28 +0100
Message-ID: <1386795513-32426-5-git-send-email-a.motakis@virtualopensystems.com>
References: <1386795513-32426-1-git-send-email-a.motakis@virtualopensystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1386795513-32426-1-git-send-email-a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
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
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "open list:VFIO DRIVER" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, a.rigo-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, B08248-KZfg59tc24xl57MIdRCFDg@public.gmane.org, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

A VFIO userspace driver will start by opening the VFIO device
that corresponds to an IOMMU group, and will use the ioctl interface
to get the basic device info, such as number of memory regions and
interrupts, and their properties.

This patch enables the IOCTLs:
 - VFIO_DEVICE_GET_INFO
 - VFIO_DEVICE_GET_REGION_INFO

 IRQ info is provided by one of the latter patches.

Signed-off-by: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
---
 drivers/vfio/platform/vfio_platform.c         | 74 ++++++++++++++++++++++++---
 drivers/vfio/platform/vfio_platform_private.h |  8 +++
 2 files changed, 76 insertions(+), 6 deletions(-)

diff --git a/drivers/vfio/platform/vfio_platform.c b/drivers/vfio/platform/vfio_platform.c
index 95dceac..4b402ea 100644
--- a/drivers/vfio/platform/vfio_platform.c
+++ b/drivers/vfio/platform/vfio_platform.c
@@ -34,15 +34,62 @@
 #define DRIVER_AUTHOR   "Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>"
 #define DRIVER_DESC     "VFIO for platform devices - User Level meta-driver"
 
+static int vfio_platform_regions_init(struct vfio_platform_device *vdev)
+{
+	int cnt = 0, i;
+
+	while (platform_get_resource(vdev->pdev, IORESOURCE_MEM, cnt))
+		cnt++;
+
+	vdev->num_regions = cnt;
+
+	vdev->region = kzalloc(sizeof(struct vfio_platform_region) * cnt,
+				GFP_KERNEL);
+	if (!vdev->region)
+		return -ENOMEM;
+
+	for (i = 0; i < cnt;  i++) {
+		struct vfio_platform_region region;
+		struct resource *res =
+			platform_get_resource(vdev->pdev, IORESOURCE_MEM, i);
+
+		region.addr = res->start;
+		region.size = resource_size(res);
+		region.flags = 0;
+
+		vdev->region[i] = region;
+	}
+
+	return 0;
+}
+
+static void vfio_platform_regions_cleanup(struct vfio_platform_device *vdev)
+{
+	kfree(vdev->region);
+}
+
 static void vfio_platform_release(void *device_data)
 {
+	struct vfio_platform_device *vdev = device_data;
+
+	vfio_platform_regions_cleanup(vdev);
+
 	module_put(THIS_MODULE);
 }
 
 static int vfio_platform_open(void *device_data)
 {
-	if (!try_module_get(THIS_MODULE))
+	struct vfio_platform_device *vdev = device_data;
+	int ret;
+
+	ret = vfio_platform_regions_init(vdev);
+	if (ret)
+		return ret;
+
+	if (!try_module_get(THIS_MODULE)) {
+		vfio_platform_regions_cleanup(vdev);
 		return -ENODEV;
+	}
 
 	return 0;
 }
@@ -65,18 +112,33 @@ static long vfio_platform_ioctl(void *device_data,
 			return -EINVAL;
 
 		info.flags = VFIO_DEVICE_FLAGS_PLATFORM;
-		info.num_regions = 0;
+		info.num_regions = vdev->num_regions;
 		info.num_irqs = 0;
 
 		return copy_to_user((void __user *)arg, &info, minsz);
 
-	} else if (cmd == VFIO_DEVICE_GET_REGION_INFO)
-		return -EINVAL;
+	} else if (cmd == VFIO_DEVICE_GET_REGION_INFO) {
+		struct vfio_region_info info;
+
+		minsz = offsetofend(struct vfio_region_info, offset);
+
+		if (copy_from_user(&info, (void __user *)arg, minsz))
+			return -EFAULT;
+
+		if (info.argsz < minsz)
+			return -EINVAL;
+
+		/* map offset to the physical address  */
+		info.offset = vdev->region[info.index].addr;
+		info.size = vdev->region[info.index].size;
+		info.flags = vdev->region[info.index].flags;
+
+		return copy_to_user((void __user *)arg, &info, minsz);
 
-	else if (cmd == VFIO_DEVICE_GET_IRQ_INFO)
+	} else if (cmd == VFIO_DEVICE_GET_IRQ_INFO) {
 		return -EINVAL;
 
-	else if (cmd == VFIO_DEVICE_SET_IRQS)
+	} else if (cmd == VFIO_DEVICE_SET_IRQS)
 		return -EINVAL;
 
 	else if (cmd == VFIO_DEVICE_RESET)
diff --git a/drivers/vfio/platform/vfio_platform_private.h b/drivers/vfio/platform/vfio_platform_private.h
index 6df8084..4705aa5 100644
--- a/drivers/vfio/platform/vfio_platform_private.h
+++ b/drivers/vfio/platform/vfio_platform_private.h
@@ -15,8 +15,16 @@
 #ifndef VFIO_PLATFORM_PRIVATE_H
 #define VFIO_PLATFORM_PRIVATE_H
 
+struct vfio_platform_region {
+	u64			addr;
+	resource_size_t		size;
+	u32			flags;
+};
+
 struct vfio_platform_device {
 	struct platform_device		*pdev;
+	struct vfio_platform_region	*region;
+	u32				num_regions;
 };
 
 #endif /* VFIO_PCI_PRIVATE_H */
-- 
1.8.3.2
