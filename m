From: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v14 16/16] vfio/type1: Introduce MSI_RESV capability
Date: Wed, 12 Oct 2016 13:22:24 +0000
Message-ID: <1476278544-3397-17-git-send-email-eric.auger@redhat.com>
References: <1476278544-3397-1-git-send-email-eric.auger@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1476278544-3397-1-git-send-email-eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
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
Cc: drjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Manish.Jaggi-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org, p.fedin-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, pranav.sawargaonkar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, yehuday-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This patch allows the user-space to retrieve the MSI reserved region
requirements, if any. The implementation is based on capability chains,
now also added to VFIO_IOMMU_GET_INFO.

The returned info comprises the size and the alignment requirements

In case the userspace must provide the IOVA aperture, we currently report
a size/alignment based on all the doorbells registered by the host kernel.
This may exceed the actual needs.

Signed-off-by: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

---
v13 -> v14:
- new capability struct
- change the padding in vfio_iommu_type1_info

v11 -> v12:
- msi_doorbell_pages was renamed msi_doorbell_calc_pages

v9 -> v10:
- move cap_offset after iova_pgsizes
- replace __u64 alignment by __u32 order
- introduce __u32 flags in vfio_iommu_type1_info_cap_msi_geometry and
  fix alignment
- call msi-doorbell API to compute the size/alignment

v8 -> v9:
- use iommu_msi_supported flag instead of programmable
- replace IOMMU_INFO_REQUIRE_MSI_MAP flag by a more sophisticated
  capability chain, reporting the MSI geometry

v7 -> v8:
- use iommu_domain_msi_geometry

v6 -> v7:
- remove the computation of the number of IOVA pages to be provisionned.
  This number depends on the domain/group/device topology which can
  dynamically change. Let's rely instead rely on an arbitrary max depending
  on the system

v4 -> v5:
- move msi_info and ret declaration within the conditional code

v3 -> v4:
- replace former vfio_domains_require_msi_mapping by
  more complex computation of MSI mapping requirements, especially the
  number of pages to be provided by the user-space.
- reword patch title

RFC v1 -> v1:
- derived from
  [RFC PATCH 3/6] vfio: Extend iommu-info to return MSIs automap state
- renamed allow_msi_reconfig into require_msi_mapping
- fixed VFIO_IOMMU_GET_INFO
---
 drivers/vfio/vfio_iommu_type1.c | 67 ++++++++++++++++++++++++++++++++++++++++-
 include/uapi/linux/vfio.h       | 20 +++++++++++-
 2 files changed, 85 insertions(+), 2 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index c18ba9d..6775da3 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -1147,6 +1147,46 @@ static int vfio_domains_have_iommu_cache(struct vfio_iommu *iommu)
 	return ret;
 }
 
+static int msi_resv_caps(struct vfio_iommu *iommu, struct vfio_info_cap *caps)
+{
+	struct iommu_domain_msi_resv msi_resv = {.size = 0, .alignment = 0};
+	struct vfio_iommu_type1_info_cap_msi_resv *cap;
+	struct vfio_info_cap_header *header;
+	struct iommu_domain_msi_resv iter;
+	struct vfio_domain *d;
+
+	mutex_lock(&iommu->lock);
+
+	list_for_each_entry(d, &iommu->domain_list, next) {
+		if (iommu_domain_get_attr(d->domain,
+					  DOMAIN_ATTR_MSI_RESV, &iter))
+			continue;
+		if (iter.size >  msi_resv.size) {
+			msi_resv.size = iter.size;
+			msi_resv.alignment = iter.alignment;
+		}
+	}
+
+	if (!msi_resv.size)
+		return 0;
+
+	mutex_unlock(&iommu->lock);
+
+	header = vfio_info_cap_add(caps, sizeof(*cap),
+				   VFIO_IOMMU_TYPE1_INFO_CAP_MSI_RESV, 1);
+
+	if (IS_ERR(header))
+		return PTR_ERR(header);
+
+	cap = container_of(header, struct vfio_iommu_type1_info_cap_msi_resv,
+			   header);
+
+	cap->alignment = msi_resv.alignment;
+	cap->size = msi_resv.size;
+
+	return 0;
+}
+
 static long vfio_iommu_type1_ioctl(void *iommu_data,
 				   unsigned int cmd, unsigned long arg)
 {
@@ -1168,8 +1208,10 @@ static long vfio_iommu_type1_ioctl(void *iommu_data,
 		}
 	} else if (cmd == VFIO_IOMMU_GET_INFO) {
 		struct vfio_iommu_type1_info info;
+		struct vfio_info_cap caps = { .buf = NULL, .size = 0 };
+		int ret;
 
-		minsz = offsetofend(struct vfio_iommu_type1_info, iova_pgsizes);
+		minsz = offsetofend(struct vfio_iommu_type1_info, cap_offset);
 
 		if (copy_from_user(&info, (void __user *)arg, minsz))
 			return -EFAULT;
@@ -1181,6 +1223,29 @@ static long vfio_iommu_type1_ioctl(void *iommu_data,
 
 		info.iova_pgsizes = vfio_pgsize_bitmap(iommu);
 
+		ret = msi_resv_caps(iommu, &caps);
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
index 4a9dbc2..e34a9a6 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -488,7 +488,23 @@ struct vfio_iommu_type1_info {
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
+ * The MSI_RESV capability allows to report the MSI reserved IOVA requirements:
+ * In case this capability is supported, the userspace must provide an IOVA
+ * window characterized by @size and @alignment using VFIO_IOMMU_MAP_DMA with
+ * RESERVED_MSI_IOVA flag.
+ */
+#define VFIO_IOMMU_TYPE1_INFO_CAP_MSI_RESV  1
+struct vfio_iommu_type1_info_cap_msi_resv {
+	struct vfio_info_cap_header header;
+	__u64 size;		/* requested IOVA aperture size in bytes */
+	__u64 alignment;	/* requested byte alignment of the window */
 };
 
 #define VFIO_IOMMU_GET_INFO _IO(VFIO_TYPE, VFIO_BASE + 12)
@@ -503,6 +519,8 @@ struct vfio_iommu_type1_info {
  * IOVA region that will be used on some platforms to map the host MSI frames.
  * In that specific case, vaddr is ignored. Once registered, an MSI reserved
  * IOVA region stays until the container is closed.
+ * The requirement for provisioning such reserved IOVA range can be checked by
+ * checking the VFIO_IOMMU_TYPE1_INFO_CAP_MSI_RESV capability.
  */
 struct vfio_iommu_type1_dma_map {
 	__u32	argsz;
-- 
1.9.1
