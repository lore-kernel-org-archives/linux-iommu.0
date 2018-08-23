From: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [RFC 05/13] vfio: VFIO_IOMMU_TLB_INVALIDATE
Date: Thu, 23 Aug 2018 14:17:28 +0200
Message-ID: <1535026656-8450-6-git-send-email-eric.auger@redhat.com>
References: <1535026656-8450-1-git-send-email-eric.auger@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1535026656-8450-1-git-send-email-eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "eric.auger.pro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org, jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, yi.l.liu"@linux.intel.com, will.deacon-5wv7dgnIgG8@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org
Cc: marc.zyngier-5wv7dgnIgG8@public.gmane.org, peter.maydell-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, christoffer.dall-5wv7dgnIgG8@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: "Liu, Yi L" <yi.l.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

This patch adds the VFIO_IOMMU_TLB_INVALIDATE ioctl with aims
at propagating stage1 IOMMU TLB invalidations from guest to host.

In the case of SVM virtualization on VT-d, host IOMMU driver has
no knowledge of caching structure updates unless the guest
invalidation activities are passed down to the host. So a new
IOCTL is needed to propagate the guest cache invalidation through
VFIO.

Signed-off-by: Liu, Yi L <yi.l.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

---

For SMMUv3 invalidations, the device parameter is not needed
---
 drivers/vfio/vfio_iommu_type1.c | 23 +++++++++++++++++++++++
 include/uapi/linux/vfio.h       |  7 +++++++
 2 files changed, 30 insertions(+)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 83c7f96..973bb4d 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -1687,6 +1687,15 @@ static int bind_guest_stage_fn(struct device *dev, void *data)
 	return iommu_bind_guest_stage(task->domain, dev, &ustruct->config);
 }
 
+static int do_tlb_inv_fn(struct device *dev, void *data)
+{
+	struct vfio_iommu_type1_tlb_invalidate *ustruct;
+	struct vfio_iommu_task *task = data;
+
+	ustruct = task->payload;
+	return iommu_tlb_invalidate(task->domain, dev, &ustruct->info);
+}
+
 static int vfio_iommu_dispatch_task(struct vfio_iommu *iommu, void *data,
 				    int (*fn)(struct device *, void *))
 {
@@ -1799,6 +1808,20 @@ static long vfio_iommu_type1_ioctl(void *iommu_data,
 
 		return vfio_iommu_dispatch_task(iommu, (u8 *)&ustruct,
 						bind_guest_stage_fn);
+	} else if (cmd == VFIO_IOMMU_TLB_INVALIDATE) {
+		struct vfio_iommu_type1_tlb_invalidate ustruct;
+
+		minsz = offsetofend(struct vfio_iommu_type1_tlb_invalidate,
+				    info);
+
+		if (copy_from_user(&ustruct, (void __user *)arg, minsz))
+			return -EFAULT;
+
+		if (ustruct.argsz < minsz || ustruct.flags)
+			return -EINVAL;
+
+		return vfio_iommu_dispatch_task(iommu, (u8 *)&ustruct,
+						do_tlb_inv_fn);
 	}
 
 	return -ENOTTY;
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index a5801ed..b59f9fc 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -673,6 +673,13 @@ struct vfio_iommu_type1_bind_guest_stage {
 };
 #define VFIO_IOMMU_BIND_GUEST_STAGE	_IO(VFIO_TYPE, VFIO_BASE + 22)
 
+struct vfio_iommu_type1_tlb_invalidate {
+	__u32   argsz;
+	__u32   flags;
+	struct iommu_tlb_invalidate_info info;
+};
+#define VFIO_IOMMU_TLB_INVALIDATE      _IO(VFIO_TYPE, VFIO_BASE + 23)
+
 /* -------- Additional API for SPAPR TCE (Server POWERPC) IOMMU -------- */
 
 /*
-- 
2.5.5
