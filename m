From: "Liu, Yi L" <yi.l.liu@intel.com>
Subject: [RFC PATCH 5/8] VFIO: Add new IOTCL for PASID Table bind propagation
Date: Wed, 26 Apr 2017 18:12:02 +0800
Message-ID: <1493201525-14418-6-git-send-email-yi.l.liu@intel.com>
References: <1493201525-14418-1-git-send-email-yi.l.liu@intel.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1493201525-14418-1-git-send-email-yi.l.liu@intel.com>
Sender: kvm-owner@vger.kernel.org
To: kvm@vger.kernel.org, iommu@lists.linux-foundation.org, alex.williamson@redhat.com, peterx@redhat.com
Cc: jasowang@redhat.com, qemu-devel@nongnu.org, kevin.tian@intel.com, ashok.raj@intel.com, jacob.jun.pan@intel.com, tianyu.lan@intel.com, yi.l.liu@intel.com, jean-philippe.brucker@arm.com, "Liu, Yi L" <yi.l.liu@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

From: "Liu, Yi L" <yi.l.liu@linux.intel.com>

This patch adds VFIO_IOMMU_SVM_BIND_TASK for potential PASID table
binding requests.

On VT-d, this IOCTL cmd would be used to link the guest PASID page table
to host. While for other vendors, it may also be used to support other
kind of SVM bind request. Previously, there is a discussion on it with
ARM engineer. It can be found by the link below. This IOCTL cmd may
support SVM PASID bind request from userspace driver, or page table(cr3)
bind request from guest. These SVM bind requests would be supported by
adding different flags. e.g. VFIO_SVM_BIND_PASID is added to support
PASID bind from userspace driver, VFIO_SVM_BIND_PGTABLE is added to
support page table bind from guest.

https://patchwork.kernel.org/patch/9594231/

Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
---
 include/uapi/linux/vfio.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 519eff3..6b97987 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -547,6 +547,23 @@ struct vfio_iommu_type1_dma_unmap {
 #define VFIO_IOMMU_ENABLE	_IO(VFIO_TYPE, VFIO_BASE + 15)
 #define VFIO_IOMMU_DISABLE	_IO(VFIO_TYPE, VFIO_BASE + 16)
 
+/* IOCTL for Shared Virtual Memory Bind */
+struct vfio_device_svm {
+	__u32	argsz;
+#define VFIO_SVM_BIND_PASIDTBL	(1 << 0) /* Bind PASID Table */
+#define VFIO_SVM_BIND_PASID	(1 << 1) /* Bind PASID from userspace driver */
+#define VFIO_SVM_BIND_PGTABLE	(1 << 2) /* Bind guest mmu page table */
+	__u32	flags;
+	__u32	length;
+	__u8	data[];
+};
+
+#define VFIO_SVM_TYPE_MASK	(VFIO_SVM_BIND_PASIDTBL | \
+				VFIO_SVM_BIND_PASID | \
+				VFIO_SVM_BIND_PGTABLE)
+
+#define VFIO_IOMMU_SVM_BIND_TASK	_IO(VFIO_TYPE, VFIO_BASE + 22)
+
 /* -------- Additional API for SPAPR TCE (Server POWERPC) IOMMU -------- */
 
 /*
-- 
1.9.1
