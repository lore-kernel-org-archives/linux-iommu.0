From: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
Subject: [RFC PATCH v2 4/4] vfio: platform: devtree: return arrays of u32, u16,
	or u8 data
Date: Thu, 16 Oct 2014 17:54:36 +0200
Message-ID: <1413474876-28544-5-git-send-email-a.motakis@virtualopensystems.com>
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

Certain properties of a device tree node are accessible as an array
of unsigned integers, either u32, u16, or u8. Let the VFIO user query
this type of device node properties. Accessing u64 arrays is not yet
implemented in this RFC.

Signed-off-by: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
---
 drivers/vfio/platform/devtree.c | 55 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/platform/devtree.c b/drivers/vfio/platform/devtree.c
index 6d25f97..17f55d4 100644
--- a/drivers/vfio/platform/devtree.c
+++ b/drivers/vfio/platform/devtree.c
@@ -97,7 +97,60 @@ static int devtree_get_uint(struct device_node *np, char *name,
 			    uint32_t type, unsigned *lenp,
 			    void __user *datap, unsigned long datasz)
 {
-	return -EINVAL;
+	int ret, n;
+	size_t sz;
+	u8 *out;
+	int (*func)(const struct device_node *, const char *, void *, size_t)
+		= NULL;
+
+	switch (type) {
+	case VFIO_DEVTREE_TYPE_U32:
+		sz = sizeof(u32);
+		func = (int (*)(const struct device_node *,
+				const char *, void *, size_t))
+			of_property_read_u32_array;
+		break;
+	case VFIO_DEVTREE_TYPE_U16:
+		sz = sizeof(u16);
+		func = (int (*)(const struct device_node *,
+				const char *, void *, size_t))
+			of_property_read_u16_array;
+		break;
+	case VFIO_DEVTREE_TYPE_U8:
+		sz = sizeof(u8);
+		func = (int (*)(const struct device_node *,
+				const char *, void *, size_t))
+			of_property_read_u8_array;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	n = of_property_count_elems_of_size(np, name, sz);
+	if (n < 0)
+		return n;
+
+	if (lenp)
+		*lenp = n * sz;
+
+	if (n * sz > datasz)
+		return -EAGAIN;
+
+	out = kcalloc(n, sz, GFP_KERNEL);
+	if (!out)
+		return -EFAULT;
+
+	ret = func(np, name, out, n);
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
 
 int vfio_platform_devtree_info(struct device_node *np,
-- 
2.1.1
