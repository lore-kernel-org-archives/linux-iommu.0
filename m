From: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
Subject: [RFC PATCH v3 3/3] vfio: platform: return device properties as arrays
	of unsigned integers
Date: Fri, 19 Dec 2014 22:20:31 +0100
Message-ID: <1419024032-1269-4-git-send-email-a.motakis@virtualopensystems.com>
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

Certain properties of a device are accessible as an array of unsigned
integers, either u64, u32, u16, or u8. Let the VFIO user query this
type of device properties.

Signed-off-by: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
---
 drivers/vfio/platform/properties.c | 62 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 61 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/platform/properties.c b/drivers/vfio/platform/properties.c
index 39c6342..645f6e5c 100644
--- a/drivers/vfio/platform/properties.c
+++ b/drivers/vfio/platform/properties.c
@@ -55,7 +55,67 @@ static int dev_property_get_uint(struct device *dev, char *name,
 				 uint32_t type, unsigned *lenp,
 				 void __user *datap, unsigned long datasz)
 {
-	return -EINVAL;
+	int ret, n;
+	u8 *out;
+	size_t sz;
+	int (*func)(const struct device *, const char *, void *, size_t)
+		= NULL;
+
+	switch (type) {
+	case VFIO_DEV_PROPERTY_TYPE_U64:
+		sz = sizeof(u64);
+		func = (int (*)(const struct device *,
+				const char *, void *, size_t))
+			device_property_read_u64_array;
+		break;
+	case VFIO_DEV_PROPERTY_TYPE_U32:
+		sz = sizeof(u32);
+		func = (int (*)(const struct device *,
+				const char *, void *, size_t))
+			device_property_read_u32_array;
+		break;
+	case VFIO_DEV_PROPERTY_TYPE_U16:
+		sz = sizeof(u16);
+		func = (int (*)(const struct device *,
+				const char *, void *, size_t))
+			device_property_read_u16_array;
+		break;
+	case VFIO_DEV_PROPERTY_TYPE_U8:
+		sz = sizeof(u8);
+		func = (int (*)(const struct device *,
+				const char *, void *, size_t))
+			device_property_read_u8_array;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	/* get size of array */
+	n = func(dev, name, NULL, 0);
+	if (n < 0)
+		return n;
+
+	if (lenp)
+		*lenp = n * sz;
+
+	if (n * sz > datasz)
+		return -EOVERFLOW;
+
+	out = kcalloc(n, sz, GFP_KERNEL);
+	if (!out)
+		return -EFAULT;
+
+	ret = func(dev, name, out, n);
+	if (ret)
+		goto out;
+
+	if (copy_to_user(datap, out, n * sz))
+		ret = -EFAULT;
+
+out:
+	kfree(out);
+	return ret;
 }
 
 int vfio_platform_dev_properties(struct device *dev,
-- 
2.1.3
