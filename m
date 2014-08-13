From: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
Subject: [PATCH 4/4] VFIO: PLATFORM: DEVTREE: Return arrays of u32, u16, or u8
Date: Wed, 13 Aug 2014 13:02:19 +0200
Message-ID: <1407927740-14993-5-git-send-email-a.motakis@virtualopensystems.com>
References: <1407927740-14993-1-git-send-email-a.motakis@virtualopensystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1407927740-14993-1-git-send-email-a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
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
Cc: kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, will.deacon-5wv7dgnIgG8@public.gmane.org, a.rigo-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org, stuart.yoder-KZfg59tc24xl57MIdRCFDg@public.gmane.org, Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Certain properties of a device tree node are accessible as an array
of unsigned integers, either u32, u16, or u8. Let the VFIO user query
this type of device node properties.

Signed-off-by: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
---
 drivers/vfio/platform/devtree.c | 99 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/drivers/vfio/platform/devtree.c b/drivers/vfio/platform/devtree.c
index 80c60d4..331cc34 100644
--- a/drivers/vfio/platform/devtree.c
+++ b/drivers/vfio/platform/devtree.c
@@ -98,6 +98,96 @@ static int devtree_get_full_name(struct device_node *np, void __user *datap,
 	return 0;
 }
 
+static int devtree_get_u32_arr(const struct device_node *np, const char *name,
+			       void __user *datap, unsigned long datasz)
+{
+	int ret;
+	int n;
+	u32 *out;
+
+	n = of_property_count_elems_of_size(np, name, sizeof(u32));
+	if (n < 0)
+		return n;
+
+	if (n * sizeof(u32) > datasz)
+		return -EAGAIN;
+
+	out = kcalloc(n, sizeof(u32), GFP_KERNEL);
+	if (!out)
+		return -EFAULT;
+
+	ret = of_property_read_u32_array(np, name, out, n);
+	if (ret)
+		goto out;
+
+	if (copy_to_user(datap, out, n * sizeof(u32)))
+		ret = -EFAULT;
+
+out:
+	kfree(out);
+	return ret;
+}
+
+static int devtree_get_u16_arr(const struct device_node *np, const char *name,
+			       void __user *datap, unsigned long datasz)
+{
+	int ret;
+	int n;
+	u16 *out;
+
+	n = of_property_count_elems_of_size(np, name, sizeof(u16));
+	if (n < 0)
+		return n;
+
+	if (n * sizeof(u16) > datasz)
+		return -EAGAIN;
+
+	out = kcalloc(n, sizeof(u16), GFP_KERNEL);
+	if (!out)
+		return -EFAULT;
+
+	ret = of_property_read_u16_array(np, name, out, n);
+	if (ret)
+		goto out;
+
+	if (copy_to_user(datap, out, n * sizeof(u16)))
+		ret = -EFAULT;
+
+out:
+	kfree(out);
+	return ret;
+}
+
+static int devtree_get_u8_arr(const struct device_node *np, const char *name,
+			       void __user *datap, unsigned long datasz)
+{
+	int ret;
+	int n;
+	u8 *out;
+
+	n = of_property_count_elems_of_size(np, name, sizeof(u8));
+	if (n < 0)
+		return n;
+
+	if (n * sizeof(u8) > datasz)
+		return -EAGAIN;
+
+	out = kcalloc(n, sizeof(u8), GFP_KERNEL);
+	if (!out)
+		return -EFAULT;
+
+	ret = of_property_read_u8_array(np, name, out, n);
+	if (ret)
+		goto out;
+
+	if (copy_to_user(datap, out, n * sizeof(u8)))
+		ret = -EFAULT;
+
+out:
+	kfree(out);
+	return ret;
+}
+
 long vfio_platform_devtree_ioctl(struct vfio_platform_device *vdev,
 				 unsigned long arg)
 {
@@ -143,6 +233,15 @@ long vfio_platform_devtree_ioctl(struct vfio_platform_device *vdev,
 	} else if (info.type == VFIO_DEVTREE_ARR_TYPE_STRING)
 		ret = devtree_get_strings(vdev->of_node, name, datap, datasz);
 
+	else if (info.type == VFIO_DEVTREE_ARR_TYPE_U32)
+		ret = devtree_get_u32_arr(vdev->of_node, name, datap, datasz);
+
+	else if (info.type == VFIO_DEVTREE_ARR_TYPE_U16)
+		ret = devtree_get_u16_arr(vdev->of_node, name, datap, datasz);
+
+	else if (info.type == VFIO_DEVTREE_ARR_TYPE_U8)
+		ret = devtree_get_u8_arr(vdev->of_node, name, datap, datasz);
+
 	kfree(name);
 
 out:
-- 
1.8.3.2
