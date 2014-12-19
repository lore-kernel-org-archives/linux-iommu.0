From: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
Subject: [RFC PATCH v3 2/3] vfio: platform: access device property as a list
	of strings
Date: Fri, 19 Dec 2014 22:20:30 +0100
Message-ID: <1419024032-1269-3-git-send-email-a.motakis@virtualopensystems.com>
References: <1419024032-1269-1-git-send-email-a.motakis@virtualopensystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1419024032-1269-1-git-send-email-a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
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

Certain device properties (e.g. the device node name, the compatible
string), are available as a list of strings (separated by the null
terminating character). Let the VFIO user query this type of properties.

Signed-off-by: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
---
 drivers/vfio/platform/properties.c | 43 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/platform/properties.c b/drivers/vfio/platform/properties.c
index 8b90465..39c6342 100644
--- a/drivers/vfio/platform/properties.c
+++ b/drivers/vfio/platform/properties.c
@@ -7,7 +7,48 @@ static int dev_property_get_strings(struct device *dev,
 				    char *name, unsigned *lenp,
 				    void __user *datap, unsigned long datasz)
 {
-	return -EINVAL;
+	const char **val;
+	int n, i, ret;
+
+	*lenp = 0;
+
+	n = device_property_read_string_array(dev, name, NULL, 0);
+	if (n < 0)
+		return n;
+
+	val = kcalloc(n, sizeof(char*), GFP_KERNEL);
+	if (!val)
+		return -ENOMEM;
+
+	ret = device_property_read_string_array(dev, name, val, n);
+	if (ret < 0)
+		goto out;
+
+	ret = 0;
+
+	for (i = 0; i < n; i++) {
+		size_t len = strlen(val[i]) + 1;
+
+		if (datasz < len) {
+			ret = -EOVERFLOW;
+			while (i < n)
+				*lenp += strlen(val[i++]) + 1;
+			goto out;
+		}
+
+		if (copy_to_user(datap, val[i], len)) {
+			ret = -EFAULT;
+			goto out;
+		}
+
+		*lenp += len;
+		datap += len;
+		datasz -= len;
+	}
+
+out:
+	kfree(val);
+	return ret;
 }
 
 static int dev_property_get_uint(struct device *dev, char *name,
-- 
2.1.3
