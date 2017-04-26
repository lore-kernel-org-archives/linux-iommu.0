From: "Liu, Yi L" <yi.l.liu@intel.com>
Subject: [RFC PATCH 8/8] VFIO: do IOMMU TLB invalidation from guest
Date: Wed, 26 Apr 2017 18:12:05 +0800
Message-ID: <1493201525-14418-9-git-send-email-yi.l.liu@intel.com>
References: <1493201525-14418-1-git-send-email-yi.l.liu@intel.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1493201525-14418-1-git-send-email-yi.l.liu@intel.com>
Sender: kvm-owner@vger.kernel.org
To: kvm@vger.kernel.org, iommu@lists.linux-foundation.org, alex.williamson@redhat.com, peterx@redhat.com
Cc: jasowang@redhat.com, qemu-devel@nongnu.org, kevin.tian@intel.com, ashok.raj@intel.com, jacob.jun.pan@intel.com, tianyu.lan@intel.com, yi.l.liu@intel.com, jean-philippe.brucker@arm.com, "Liu, Yi L" <yi.l.liu@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

From: "Liu, Yi L" <yi.l.liu@linux.intel.com>

This patch adds support for VFIO_IOMMU_TLB_INVALIDATE cmd in
vfio_iommu_type1.

For SVM virtualization on VT-d, for VFIO_IOMMU_TLB_INVALIDATE, it
calls iommu_ops->do_invalidate() to submit the guest iommu cache
invalidation to pIOMMU.

Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
---
 drivers/vfio/vfio_iommu_type1.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 30b6d48..6cebdfd 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -1528,6 +1528,17 @@ static int bind_pasid_tbl_fn(struct device *dev, void *data)
 	return ret;
 }
 
+static int do_tlb_inv_fn(struct device *dev, void *data)
+{
+	int ret = 0;
+	struct vfio_svm_task *task = data;
+	struct tlb_invalidate_info *inv_info;
+
+	inv_info = task->payload;
+	ret = iommu_do_invalidate(task->domain, dev, inv_info);
+	return ret;
+}
+
 static int vfio_do_svm_task(struct vfio_iommu *iommu, void *data,
 				int (*fn)(struct device *, void *))
 {
@@ -1654,6 +1665,21 @@ static long vfio_iommu_type1_ioctl(void *iommu_data,
 		}
 		kfree(data);
 		return ret;
+	} else if (cmd == VFIO_IOMMU_TLB_INVALIDATE) {
+		struct vfio_iommu_tlb_invalidate hdr;
+		u8 *data = NULL;
+		int ret = 0;
+
+		minsz = offsetofend(struct vfio_iommu_tlb_invalidate, length);
+		if (copy_from_user(&hdr, (void __user *)arg, minsz))
+			return -EFAULT;
+		if (hdr.length == 0)
+			return -EINVAL;
+		data = memdup_user((void __user *)(arg + minsz),
+				hdr.length);
+		ret = vfio_do_svm_task(iommu, data, do_tlb_inv_fn);
+		kfree(data);
+		return ret;
 	}
 
 	return -ENOTTY;
-- 
1.9.1
