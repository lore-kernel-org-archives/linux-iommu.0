From: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
Subject: [PATCH 3/4] VFIO: PLATFORM: DEVTREE: Access property as a list of
	strings
Date: Wed, 13 Aug 2014 13:02:18 +0200
Message-ID: <1407927740-14993-4-git-send-email-a.motakis@virtualopensystems.com>
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

Certain device tree properties (e.g. the device node name, the compatible
string), are available as a list of strings (separated by the null
terminating character). Let the VFIO user query this type of properties.

Signed-off-by: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
---
 drivers/vfio/platform/devtree.c | 60 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/drivers/vfio/platform/devtree.c b/drivers/vfio/platform/devtree.c
index b8fd4138..80c60d4 100644
--- a/drivers/vfio/platform/devtree.c
+++ b/drivers/vfio/platform/devtree.c
@@ -61,6 +61,43 @@ static int devtree_get_prop_names(struct device_node *np, void __user *datap,
 	return ret;
 }
 
+static int devtree_get_strings(struct device_node *np, char *name,
+			       void __user *datap, unsigned long datasz)
+{
+	struct property *prop;
+	int len;
+
+	prop = of_find_property(np, name, &len);
+
+	if (!prop)
+		return -EINVAL;
+
+	if (len > datasz)
+		return -EAGAIN;
+
+	if (copy_to_user(datap, prop->value, len))
+		return -EFAULT;
+	else
+		return 0;
+}
+
+static int devtree_get_full_name(struct device_node *np, void __user *datap,
+				 unsigned long datasz, int *lenp)
+{
+	int len = strlen(np->full_name) + 1;
+
+	if (lenp)
+		*lenp = len;
+
+	if (len > datasz)
+		return -EAGAIN;
+
+	if (copy_to_user(datap, np->full_name, len))
+		return -EFAULT;
+
+	return 0;
+}
+
 long vfio_platform_devtree_ioctl(struct vfio_platform_device *vdev,
 				 unsigned long arg)
 {
@@ -68,6 +105,7 @@ long vfio_platform_devtree_ioctl(struct vfio_platform_device *vdev,
 	unsigned long minsz = offsetofend(struct vfio_devtree_info, length);
 	void __user *datap = (void __user *) arg + minsz;
 	unsigned long int datasz;
+	char *name;
 	int ret = -EINVAL;
 
 	if (!vfio_platform_has_devtree(vdev))
@@ -84,8 +122,30 @@ long vfio_platform_devtree_ioctl(struct vfio_platform_device *vdev,
 	if (info.type == VFIO_DEVTREE_PROP_NAMES) {
 		ret = devtree_get_prop_names(vdev->of_node, datap, datasz,
 								&info.length);
+		goto out;
 	}
 
+	name = kzalloc(datasz, GFP_KERNEL);
+	if (!name)
+		return -ENOMEM;
+	if (copy_from_user(name, datap, datasz))
+		return -EFAULT;
+
+	if (!of_find_property(vdev->of_node, name, &info.length)) {
+		/* special case full_name as a property that is not on the fdt,
+		 * but we wish to return to the user as it includes the full
+		 * path of the device */
+		if (!strcmp(name, "full_name") &&
+				(info.type == VFIO_DEVTREE_ARR_TYPE_STRING))
+			ret = devtree_get_full_name(vdev->of_node, datap,
+						    datasz, &info.length);
+
+	} else if (info.type == VFIO_DEVTREE_ARR_TYPE_STRING)
+		ret = devtree_get_strings(vdev->of_node, name, datap, datasz);
+
+	kfree(name);
+
+out:
 	if (copy_to_user((void __user *)arg, &info, minsz))
 		ret = -EFAULT;
 
-- 
1.8.3.2
