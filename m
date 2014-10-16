From: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
Subject: [RFC PATCH v2 3/4] vfio: platform: devtree: access property as a list
	of strings
Date: Thu, 16 Oct 2014 17:54:35 +0200
Message-ID: <1413474876-28544-4-git-send-email-a.motakis@virtualopensystems.com>
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

Certain device tree properties (e.g. the device node name, the compatible
string), are available as a list of strings (separated by the null
terminating character). Let the VFIO user query this type of properties.

Signed-off-by: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
---
 drivers/vfio/platform/devtree.c | 43 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/platform/devtree.c b/drivers/vfio/platform/devtree.c
index 032ee16..6d25f97 100644
--- a/drivers/vfio/platform/devtree.c
+++ b/drivers/vfio/platform/devtree.c
@@ -45,11 +45,52 @@ static int devtree_get_prop_list(struct device_node *np, unsigned *lenp,
 	return ret;
 }
 
+static int devtree_get_full_name(struct device_node *np, unsigned *lenp,
+				 void __user *datap, unsigned long datasz)
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
 static int devtree_get_strings(struct device_node *np,
 			       char *name, unsigned *lenp,
 			       void __user *datap, unsigned long datasz)
 {
-	return -EINVAL;
+	struct property *prop;
+	int len;
+
+	prop = of_find_property(np, name, &len);
+
+	if (!prop) {
+		/* special case full_name as a property that is not on the fdt,
+		 * but we wish to return to the user as it includes the full
+		 * path of the device */
+		if (!strcmp(name, "full_name"))
+			return devtree_get_full_name(np, lenp, datap, datasz);
+		else
+			return -EINVAL;
+	}
+
+	if (lenp)
+		*lenp = len;
+
+	if (len > datasz)
+		return -EAGAIN;
+
+	if (copy_to_user(datap, prop->value, len))
+		return -EFAULT;
+
+	return 0;
 }
 
 static int devtree_get_uint(struct device_node *np, char *name,
-- 
2.1.1
