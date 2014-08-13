From: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
Subject: [PATCH 2/4] VFIO: PLATFORM: DEVTREE: Return available property names
Date: Wed, 13 Aug 2014 13:02:17 +0200
Message-ID: <1407927740-14993-3-git-send-email-a.motakis@virtualopensystems.com>
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

For various reasons, the available properties of the platform device
node in the device tree node should be referred to by the property name.
Passing type = VFIO_DEVTREE_PROP_NAMES to VFIO_DEVICE_GET_DEVTREE_INFO,
returns a list of strings with the available properties that the VFIO
user can access.

Signed-off-by: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
---
 drivers/vfio/platform/devtree.c | 68 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 67 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/platform/devtree.c b/drivers/vfio/platform/devtree.c
index 91cab88..b8fd4138 100644
--- a/drivers/vfio/platform/devtree.c
+++ b/drivers/vfio/platform/devtree.c
@@ -20,8 +20,74 @@ bool vfio_platform_has_devtree(struct vfio_platform_device *vdev)
 	return !!vdev->of_node;
 }
 
+static int devtree_get_prop_names(struct device_node *np, void __user *datap,
+				  unsigned long datasz, int *lenp)
+{
+	struct property *prop;
+	int len = 0, sz;
+	int ret = 0;
+
+	for_each_property_of_node(np, prop) {
+		sz = strlen(prop->name) + 1;
+
+		if (datasz < sz) {
+			ret = -EAGAIN;
+			break;
+		}
+
+		if (copy_to_user(datap, prop->name, sz))
+			return -EFAULT;
+
+		datap += sz;
+		datasz -= sz;
+		len += sz;
+	}
+
+	/* if overflow occurs, calculate remaining length */
+	while (prop) {
+		len += strlen(prop->name) + 1;
+		prop = prop->next;
+	}
+
+	/* we expose the full_name in addition to the usual properties */
+	len += sz = strlen("full_name") + 1;
+	if (datasz < sz) {
+		ret = -EAGAIN;
+	} else if (copy_to_user(datap, "full_name", sz))
+		return -EFAULT;
+
+	*lenp = len;
+
+	return ret;
+}
+
 long vfio_platform_devtree_ioctl(struct vfio_platform_device *vdev,
 				 unsigned long arg)
 {
-	return -EINVAL; /* not implemented yet */
+	struct vfio_devtree_info info;
+	unsigned long minsz = offsetofend(struct vfio_devtree_info, length);
+	void __user *datap = (void __user *) arg + minsz;
+	unsigned long int datasz;
+	int ret = -EINVAL;
+
+	if (!vfio_platform_has_devtree(vdev))
+		return -EINVAL;
+
+	if (copy_from_user(&info, (void __user *)arg, minsz))
+		return -EFAULT;
+
+	if (info.argsz < minsz)
+		return -EINVAL;
+
+	datasz = info.argsz - minsz;
+
+	if (info.type == VFIO_DEVTREE_PROP_NAMES) {
+		ret = devtree_get_prop_names(vdev->of_node, datap, datasz,
+								&info.length);
+	}
+
+	if (copy_to_user((void __user *)arg, &info, minsz))
+		ret = -EFAULT;
+
+	return ret;
 }
-- 
1.8.3.2
