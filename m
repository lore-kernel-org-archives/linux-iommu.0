From: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
Subject: [RFC PATCH v2 2/4] vfio: platform: devtree: return available property
	names
Date: Thu, 16 Oct 2014 17:54:34 +0200
Message-ID: <1413474876-28544-3-git-send-email-a.motakis@virtualopensystems.com>
References: <1413474876-28544-1-git-send-email-a.motakis@virtualopensystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1413474876-28544-1-git-send-email-a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: "open list:VFIO DRIVER" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

The available properties of a device are not indexed numerically,
instead they are accessible by property name.
Passing type = VFIO_DEVTREE_PROP_LIST to VFIO_DEVICE_GET_DEVTREE_INFO,
returns a list of strings with the available properties that the VFIO
user can access.

Signed-off-by: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
---
 drivers/vfio/platform/devtree.c | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/platform/devtree.c b/drivers/vfio/platform/devtree.c
index c057be3..032ee16 100644
--- a/drivers/vfio/platform/devtree.c
+++ b/drivers/vfio/platform/devtree.c
@@ -7,7 +7,42 @@
 static int devtree_get_prop_list(struct device_node *np, unsigned *lenp,
 				 void __user *datap, unsigned long datasz)
 {
-	return -EINVAL;
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
 }
 
 static int devtree_get_strings(struct device_node *np,
-- 
2.1.1
