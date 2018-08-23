From: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [RFC 06/13] vfio: VFIO_IOMMU_BIND_MSI
Date: Thu, 23 Aug 2018 14:17:29 +0200
Message-ID: <1535026656-8450-7-git-send-email-eric.auger@redhat.com>
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

This patch adds the VFIO_IOMMU_BIND_MSI ioctl which aims at
passing the guest MSI binding to the host.

Signed-off-by: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/vfio/vfio_iommu_type1.c | 31 +++++++++++++++++++++++++++++++
 include/uapi/linux/vfio.h       |  7 +++++++
 2 files changed, 38 insertions(+)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 973bb4d..2962cb9 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -1696,6 +1696,24 @@ static int do_tlb_inv_fn(struct device *dev, void *data)
 	return iommu_tlb_invalidate(task->domain, dev, &ustruct->info);
 }
 
+static int
+vfio_iommu_bind_guest_msi(struct vfio_iommu *iommu,
+			  struct vfio_iommu_type1_guest_msi_binding *ustruct)
+{
+	struct vfio_domain *d;
+	int ret;
+
+	mutex_lock(&iommu->lock);
+	list_for_each_entry(d, &iommu->domain_list, next) {
+		ret = iommu_bind_guest_msi(d->domain, &ustruct->binding);
+		if (ret)
+			break;
+	}
+	mutex_unlock(&iommu->lock);
+	return ret;
+}
+
+
 static int vfio_iommu_dispatch_task(struct vfio_iommu *iommu, void *data,
 				    int (*fn)(struct device *, void *))
 {
@@ -1822,6 +1840,19 @@ static long vfio_iommu_type1_ioctl(void *iommu_data,
 
 		return vfio_iommu_dispatch_task(iommu, (u8 *)&ustruct,
 						do_tlb_inv_fn);
+	} else if (cmd == VFIO_IOMMU_BIND_MSI) {
+		struct vfio_iommu_type1_guest_msi_binding ustruct;
+
+		minsz = offsetofend(struct vfio_iommu_type1_guest_msi_binding,
+				    binding);
+
+		if (copy_from_user(&ustruct, (void __user *)arg, minsz))
+			return -EFAULT;
+
+		if (ustruct.argsz < minsz || ustruct.flags)
+			return -EINVAL;
+
+		return vfio_iommu_bind_guest_msi(iommu, &ustruct);
 	}
 
 	return -ENOTTY;
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index b59f9fc..b7a9943 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -680,6 +680,13 @@ struct vfio_iommu_type1_tlb_invalidate {
 };
 #define VFIO_IOMMU_TLB_INVALIDATE      _IO(VFIO_TYPE, VFIO_BASE + 23)
 
+struct vfio_iommu_type1_guest_msi_binding {
+	__u32   argsz;
+	__u32   flags;
+	struct iommu_guest_msi_binding binding;
+};
+#define VFIO_IOMMU_BIND_MSI      _IO(VFIO_TYPE, VFIO_BASE + 24)
+
 /* -------- Additional API for SPAPR TCE (Server POWERPC) IOMMU -------- */
 
 /*
-- 
2.5.5
