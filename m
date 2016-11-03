From: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [RFC 5/8] vfio/type1: Introduce RESV_IOVA_RANGE capability
Date: Thu,  3 Nov 2016 21:39:35 +0000
Message-ID: <1478209178-3009-6-git-send-email-eric.auger@redhat.com>
References: <1478209178-3009-1-git-send-email-eric.auger@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1478209178-3009-1-git-send-email-eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, eric.auger.pro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: drjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, punit.agrawal-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, pranav.sawargaonkar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This patch allows the user-space to retrieve the reserved IOVA range(s),
if any. The implementation is based on capability chains, now also added
to VFIO_IOMMU_GET_INFO.

Signed-off-by: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

---
---
 drivers/vfio/vfio_iommu_type1.c | 63 ++++++++++++++++++++++++++++++++++++++++-
 include/uapi/linux/vfio.h       | 16 ++++++++++-
 2 files changed, 77 insertions(+), 2 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 2ba1942..0d53ac1 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -965,6 +965,42 @@ static int vfio_domains_have_iommu_cache(struct vfio_iommu *iommu)
 	return ret;
 }
 
+static int add_resv_iova_range(struct vfio_info_cap *caps, u64 start, u64 end)
+{
+	struct vfio_iommu_type1_info_cap_resv_iova_range *cap;
+	struct vfio_info_cap_header *header;
+
+	header = vfio_info_cap_add(caps, sizeof(*cap),
+			VFIO_IOMMU_TYPE1_INFO_CAP_RESV_IOVA_RANGE, 1);
+
+	if (IS_ERR(header))
+		return PTR_ERR(header);
+
+	cap = container_of(header,
+			   struct vfio_iommu_type1_info_cap_resv_iova_range,
+			   header);
+
+	cap->start = start;
+	cap->end = end;
+	return 0;
+}
+
+static int build_resv_iova_range_caps(struct vfio_iommu *iommu,
+				      struct vfio_info_cap *caps)
+{
+	struct vfio_domain *domain;
+	struct iommu_reserved_region *resv;
+
+	domain = list_first_entry(&iommu->domain_list,
+				  struct vfio_domain, next);
+
+	iommu_reserved_region_for_each(resv, domain->domain)
+		add_resv_iova_range(caps, resv->start,
+				    resv->start + resv->length - 1);
+
+	return 0;
+}
+
 static long vfio_iommu_type1_ioctl(void *iommu_data,
 				   unsigned int cmd, unsigned long arg)
 {
@@ -986,8 +1022,10 @@ static long vfio_iommu_type1_ioctl(void *iommu_data,
 		}
 	} else if (cmd == VFIO_IOMMU_GET_INFO) {
 		struct vfio_iommu_type1_info info;
+		struct vfio_info_cap caps = { .buf = NULL, .size = 0 };
+		int ret;
 
-		minsz = offsetofend(struct vfio_iommu_type1_info, iova_pgsizes);
+		minsz = offsetofend(struct vfio_iommu_type1_info, cap_offset);
 
 		if (copy_from_user(&info, (void __user *)arg, minsz))
 			return -EFAULT;
@@ -999,6 +1037,29 @@ static long vfio_iommu_type1_ioctl(void *iommu_data,
 
 		info.iova_pgsizes = vfio_pgsize_bitmap(iommu);
 
+		ret = build_resv_iova_range_caps(iommu, &caps);
+		if (ret)
+			return ret;
+
+		if (caps.size) {
+			info.flags |= VFIO_IOMMU_INFO_CAPS;
+			if (info.argsz < sizeof(info) + caps.size) {
+				info.argsz = sizeof(info) + caps.size;
+				info.cap_offset = 0;
+			} else {
+				vfio_info_cap_shift(&caps, sizeof(info));
+				if (copy_to_user((void __user *)arg +
+						sizeof(info), caps.buf,
+						caps.size)) {
+					kfree(caps.buf);
+					return -EFAULT;
+				}
+				info.cap_offset = sizeof(info);
+			}
+
+			kfree(caps.buf);
+		}
+
 		return copy_to_user((void __user *)arg, &info, minsz) ?
 			-EFAULT : 0;
 
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 255a211..ae96f2c 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -488,7 +488,21 @@ struct vfio_iommu_type1_info {
 	__u32	argsz;
 	__u32	flags;
 #define VFIO_IOMMU_INFO_PGSIZES (1 << 0)	/* supported page sizes info */
-	__u64	iova_pgsizes;		/* Bitmap of supported page sizes */
+#define VFIO_IOMMU_INFO_CAPS	(1 << 1)	/* Info supports caps */
+	__u64	iova_pgsizes;	/* Bitmap of supported page sizes */
+	__u32   cap_offset;	/* Offset within info struct of first cap */
+	__u32	__resv;
+};
+
+/*
+ * The RESV_IOVA_RANGE capability allows to report the reserved IOVA range(s),
+ * if any.
+ */
+#define VFIO_IOMMU_TYPE1_INFO_CAP_RESV_IOVA_RANGE  1
+struct vfio_iommu_type1_info_cap_resv_iova_range {
+	struct vfio_info_cap_header header;
+	__u64 start;
+	__u64 end;
 };
 
 #define VFIO_IOMMU_GET_INFO _IO(VFIO_TYPE, VFIO_BASE + 12)
-- 
1.9.1
