Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F235636CDE2;
	Mon, 27 Apr 2026 06:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777270241; cv=none; b=a263+EJfwAvIk8tpVGKx0pGqmKPCltYJqMqgASoFf5ZaafDPGRnOnKL7nJAgHPHVBGQ04/7ma8fv67411blFo+vVuPemmABHWtHtdqFcPrOBgVdUsIWZmK8f8lh/TTpKyXGJA7aWSnB/I+6DTz/Krkud4IFxHFr5EMK6zYZ5+9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777270241; c=relaxed/simple;
	bh=/TuP7k7o4mfug5ma2TZl6voJcTWtYtrqwVFMu0KcjPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J2TxB78SOd5IgnE3CXoXEROl/HeS6A64SOK1FW1YaHBPRAuWKyT7hpuaU7wcRRkrJh2Nj8XHjQQ/eDOv1luAIbnXtdGSCaSs03mXkMwQO5NZbK52Br9g+WDHrY7GyNNGDh++Sty+t9OJjtYBnwMmbK23JC2QKXg5iI/8ytCkbJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cru5fxg5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cru5fxg5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6F1CC2BCB4;
	Mon, 27 Apr 2026 06:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777270240;
	bh=/TuP7k7o4mfug5ma2TZl6voJcTWtYtrqwVFMu0KcjPo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cru5fxg5A5+8Qe+N0bMb4AhYDoJIqS05eiOnc4tjZdbpaWXR17euDTNK3S1orpNqI
	 HJOTLkOVVkzVnooLY1B9N94PARDySyfDewQZFNJCyPv9mBYCoYoKz0uiGgHKCsr6Y0
	 3Z9wqtNIwjxsspRZT6mvnJcjx7aNNjrnwPw3LMwj8q1fx0LBxcBEKf/x3qttd0zt5r
	 Ie/j/9d8wbx1ndY07lSmsD0+q7n6wgds7gsJhJKedtBViQN5nE7V+AP2TIBNlFF3IU
	 GK0dRvoiJFNVg8Aorx1ataAwSZt/nhdqo0qa5jLyCNWjYvyKakA1Pk00aQbhCprOlL
	 WoB9LRcRVIAnw==
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
To: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	Alexey Kardashevskiy <aik@amd.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Joerg Roedel <joro@8bytes.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Will Deacon <will@kernel.org>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH v4 3/4] iommufd/tsm: add vdevice TSM bind/unbind ioctl
Date: Mon, 27 Apr 2026 11:40:04 +0530
Message-ID: <20260427061005.901854-4-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427061005.901854-1-aneesh.kumar@kernel.org>
References: <20260427061005.901854-1-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce IOMMU_VDEVICE_TSM_OP to allow userspace to issue TSM bind/unbind
operations for an iommufd vdevice.

The new ioctl:
- looks up the vdevice object from vdevice_id
- resolves the associated KVM VM from the vIOMMU KVM file reference
- dispatches bind/unbind via tsm_bind()/tsm_unbind()

Also add common TSM helpers in tsm-core and wire vdevice teardown to unbind
the device from TSM state.

This provides iommufd plumbing to bind a TDI to a confidential guest through
the TSM layer.

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 drivers/iommu/iommufd/Makefile          |  2 +
 drivers/iommu/iommufd/iommufd_private.h |  8 ++++
 drivers/iommu/iommufd/main.c            |  3 ++
 drivers/iommu/iommufd/tsm.c             | 60 +++++++++++++++++++++++++
 drivers/iommu/iommufd/viommu.c          |  4 ++
 drivers/virt/coco/tsm-core.c            | 19 ++++++++
 include/linux/tsm.h                     | 17 +++++++
 include/uapi/linux/iommufd.h            | 26 +++++++++++
 8 files changed, 139 insertions(+)
 create mode 100644 drivers/iommu/iommufd/tsm.c

diff --git a/drivers/iommu/iommufd/Makefile b/drivers/iommu/iommufd/Makefile
index 71d692c9a8f4..431089089ee9 100644
--- a/drivers/iommu/iommufd/Makefile
+++ b/drivers/iommu/iommufd/Makefile
@@ -10,6 +10,8 @@ iommufd-y := \
 	vfio_compat.o \
 	viommu.o
 
+iommufd-$(CONFIG_TSM) += tsm.o
+
 iommufd-$(CONFIG_IOMMUFD_TEST) += selftest.o
 
 obj-$(CONFIG_IOMMUFD) += iommufd.o
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index c48a568c6cbb..14d2d6d1beec 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -699,6 +699,14 @@ void iommufd_vdevice_destroy(struct iommufd_object *obj);
 void iommufd_vdevice_abort(struct iommufd_object *obj);
 int iommufd_hw_queue_alloc_ioctl(struct iommufd_ucmd *ucmd);
 void iommufd_hw_queue_destroy(struct iommufd_object *obj);
+#ifdef CONFIG_TSM
+int iommufd_vdevice_tsm_op_ioctl(struct iommufd_ucmd *ucmd);
+#else
+static inline int iommufd_vdevice_tsm_op_ioctl(struct iommufd_ucmd *ucmd)
+{
+	return -EOPNOTSUPP;
+}
+#endif
 
 static inline struct iommufd_vdevice *
 iommufd_get_vdevice(struct iommufd_ctx *ictx, u32 id)
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 8c6d43601afb..d73e6b391c6f 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -432,6 +432,7 @@ union ucmd_buffer {
 	struct iommu_veventq_alloc veventq;
 	struct iommu_vfio_ioas vfio_ioas;
 	struct iommu_viommu_alloc viommu;
+	struct iommu_vdevice_tsm_op tsm_op;
 #ifdef CONFIG_IOMMUFD_TEST
 	struct iommu_test_cmd test;
 #endif
@@ -493,6 +494,8 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
 		 __reserved),
 	IOCTL_OP(IOMMU_VIOMMU_ALLOC, iommufd_viommu_alloc_ioctl,
 		 struct iommu_viommu_alloc, out_viommu_id),
+	IOCTL_OP(IOMMU_VDEVICE_TSM_OP, iommufd_vdevice_tsm_op_ioctl,
+		 struct iommu_vdevice_tsm_op, vdevice_id),
 #ifdef CONFIG_IOMMUFD_TEST
 	IOCTL_OP(IOMMU_TEST_CMD, iommufd_test, struct iommu_test_cmd, last),
 #endif
diff --git a/drivers/iommu/iommufd/tsm.c b/drivers/iommu/iommufd/tsm.c
new file mode 100644
index 000000000000..4e5fa7849342
--- /dev/null
+++ b/drivers/iommu/iommufd/tsm.c
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2026 ARM Ltd.
+ */
+
+#include <linux/tsm.h>
+#include "iommufd_private.h"
+
+/**
+ * iommufd_vdevice_tsm_op_ioctl - Handle vdevice TSM operations
+ * @ucmd: user command data for IOMMU_VDEVICE_TSM_OP
+ *
+ * Currently only supports TSM bind/unbind operations
+ * Resolve @iommu_vdevice_tsm_op::vdevice_id to a vdevice and dispatch the
+ * requested bind/unbind operation through the TSM core.
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
+int iommufd_vdevice_tsm_op_ioctl(struct iommufd_ucmd *ucmd)
+{
+	int rc;
+	struct kvm *kvm;
+	struct iommufd_vdevice *vdev;
+	struct iommu_vdevice_tsm_op *cmd = ucmd->cmd;
+
+	if (cmd->flags)
+		return -EOPNOTSUPP;
+
+	vdev = iommufd_get_vdevice(ucmd->ictx, cmd->vdevice_id);
+	if (IS_ERR(vdev))
+		return PTR_ERR(vdev);
+
+	kvm = vdev->viommu->kvm;
+	if (!kvm) {
+		rc = -ENODEV;
+		goto out_put_vdev;
+	}
+
+	/* tsm layer will take care of parallel calls to tsm_bind/unbind */
+	switch (cmd->type) {
+	case IOMMU_VDEVICE_TSM_BIND:
+		rc = tsm_bind(vdev->idev->dev, kvm, vdev->virt_id);
+		break;
+	case IOMMU_VDEVICE_TSM_UNBIND:
+		rc = tsm_unbind(vdev->idev->dev);
+		break;
+	default:
+		rc = -EINVAL;
+		goto out_put_vdev;
+	}
+
+	if (rc)
+		goto out_put_vdev;
+
+	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
+
+out_put_vdev:
+	iommufd_put_object(ucmd->ictx, &vdev->obj);
+	return rc;
+}
diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index 1e023d1cf8d5..ec9054d3ec92 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -3,6 +3,8 @@
  */
 #include <linux/kvm_host.h>
 #include "iommufd_private.h"
+#include <linux/cleanup.h>
+#include <linux/tsm.h>
 
 void iommufd_viommu_destroy(struct iommufd_object *obj)
 {
@@ -133,6 +135,8 @@ void iommufd_vdevice_abort(struct iommufd_object *obj)
 
 	lockdep_assert_held(&idev->igroup->lock);
 
+	tsm_unbind(idev->dev);
+
 	if (vdev->destroy)
 		vdev->destroy(vdev);
 	/* xa_cmpxchg is okay to fail if alloc failed xa_cmpxchg previously */
diff --git a/drivers/virt/coco/tsm-core.c b/drivers/virt/coco/tsm-core.c
index ae3617abd2ac..f0e35fc38776 100644
--- a/drivers/virt/coco/tsm-core.c
+++ b/drivers/virt/coco/tsm-core.c
@@ -240,6 +240,25 @@ void tsm_ide_stream_unregister(struct pci_ide *ide)
 }
 EXPORT_SYMBOL_GPL(tsm_ide_stream_unregister);
 
+int tsm_bind(struct device *dev, struct kvm *kvm, u64 tdi_id)
+{
+	if (!dev_is_pci(dev))
+		return -EINVAL;
+
+	return pci_tsm_bind(to_pci_dev(dev), kvm, tdi_id);
+}
+EXPORT_SYMBOL_GPL(tsm_bind);
+
+int tsm_unbind(struct device *dev)
+{
+	if (!dev_is_pci(dev))
+		return -EINVAL;
+
+	pci_tsm_unbind(to_pci_dev(dev));
+	return 0;
+}
+EXPORT_SYMBOL_GPL(tsm_unbind);
+
 static void tsm_release(struct device *dev)
 {
 	struct tsm_dev *tsm_dev = container_of(dev, typeof(*tsm_dev), dev);
diff --git a/include/linux/tsm.h b/include/linux/tsm.h
index 7f72a154b6b2..85eb1717bddd 100644
--- a/include/linux/tsm.h
+++ b/include/linux/tsm.h
@@ -126,4 +126,21 @@ struct tsm_dev *find_tsm_dev(int id);
 struct pci_ide;
 int tsm_ide_stream_register(struct pci_ide *ide);
 void tsm_ide_stream_unregister(struct pci_ide *ide);
+
+struct kvm;
+#ifdef CONFIG_TSM
+int tsm_bind(struct device *dev, struct kvm *kvm, u64 tdi_id);
+int tsm_unbind(struct device *dev);
+#else
+static inline int tsm_bind(struct device *dev, struct kvm *kvm, u64 tdi_id)
+{
+	return -EINVAL;
+}
+
+static inline int tsm_unbind(struct device *dev)
+{
+	return 0;
+}
+#endif
+
 #endif /* __TSM_H */
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 1dafbc552d37..aabdfd86504c 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -57,6 +57,7 @@ enum {
 	IOMMUFD_CMD_IOAS_CHANGE_PROCESS = 0x92,
 	IOMMUFD_CMD_VEVENTQ_ALLOC = 0x93,
 	IOMMUFD_CMD_HW_QUEUE_ALLOC = 0x94,
+	IOMMUFD_CMD_VDEVICE_TSM_OP = 0x95,
 };
 
 /**
@@ -1134,6 +1135,31 @@ struct iommu_vdevice_alloc {
 };
 #define IOMMU_VDEVICE_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VDEVICE_ALLOC)
 
+/**
+ * enum iommu_vdevice_tsm_op_type - operation type for struct iommu_vdevice_tsm_op
+ * @IOMMU_VDEVICE_TSM_BIND: Bind a vDevice to TSM
+ * @IOMMU_VDEVICE_TSM_UNBIND: Unbind a vDevice from TSM
+ */
+enum iommu_vdevice_tsm_op_type {
+	IOMMU_VDEVICE_TSM_BIND = 0x1,
+	IOMMU_VDEVICE_TSM_UNBIND,
+};
+
+/**
+ * struct iommu_vdevice_tsm_op - ioctl(IOMMU_VDEVICE_TSM_OP)
+ * @size: sizeof(struct iommu_vdevice_tsm_op)
+ * @type: Type of TSM operation. Must be defined in enum iommu_vdevice_tsm_op_type
+ * @flags: Must be 0
+ * @vdevice_id: Object handle for the vDevice. Returned from IOMMU_VDEVICE_ALLOC
+ */
+struct iommu_vdevice_tsm_op {
+	__u32 size;
+	__u32 type;
+	__u32 flags;
+	__u32 vdevice_id;
+};
+#define IOMMU_VDEVICE_TSM_OP _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VDEVICE_TSM_OP)
+
 /**
  * struct iommu_ioas_change_process - ioctl(VFIO_IOAS_CHANGE_PROCESS)
  * @size: sizeof(struct iommu_ioas_change_process)
-- 
2.43.0

