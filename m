From: Baptiste Reynal <b.reynal-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
Subject: [RFC 1/6] headers sync
Date: Fri, 12 Jun 2015 16:20:05 +0200
Message-ID: <1434118810-28219-2-git-send-email-b.reynal@virtualopensystems.com>
References: <1434118810-28219-1-git-send-email-b.reynal@virtualopensystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1434118810-28219-1-git-send-email-b.reynal-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org
Cc: tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Signed-off-by: Baptiste Reynal <b.reynal-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
---
 linux-headers/linux/kvm.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index fad9e5c..d48d7b1 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -1003,6 +1003,19 @@ struct kvm_device_attr {
 #define   KVM_DEV_VFIO_GROUP_ADD			1
 #define   KVM_DEV_VFIO_GROUP_DEL			2
 
+#define  KVM_DEV_ARM_SMMU_V2_CFG		1
+#define   KVM_DEV_ARM_SMMU_V2_CFG_INIT			1
+#define   KVM_DEV_ARM_SMMU_V2_CFG_IRQ			2
+#define   KVM_DEV_ARM_SMMU_V2_CFG_SIZE			3
+#define  KVM_DEV_ARM_SMMU_V2_VFIO		2
+#define   KVM_DEV_ARM_SMMU_V2_VFIO_GROUP_ADD		1
+#define   KVM_DEV_ARM_SMMU_V2_VFIO_GROUP_DEL		2
+
+struct arm_smmu_v2_vfio_group_sid {
+	__u32	fd;	/* file descriptor of the VFIO group */
+	__u16	sid;
+};
+
 enum kvm_device_type {
 	KVM_DEV_TYPE_FSL_MPIC_20	= 1,
 #define KVM_DEV_TYPE_FSL_MPIC_20	KVM_DEV_TYPE_FSL_MPIC_20
@@ -1018,6 +1031,8 @@ enum kvm_device_type {
 #define KVM_DEV_TYPE_FLIC		KVM_DEV_TYPE_FLIC
 	KVM_DEV_TYPE_ARM_VGIC_V3,
 #define KVM_DEV_TYPE_ARM_VGIC_V3	KVM_DEV_TYPE_ARM_VGIC_V3
+	KVM_DEV_TYPE_ARM_SMMU_V2,
+#define KVM_DEV_TYPE_ARM_SMMU_V2	KVM_DEV_TYPE_ARM_SMMU_V2
 	KVM_DEV_TYPE_MAX,
 };
 
-- 
2.4.3
