Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD4D566C40;
	Thu, 17 Sep 2026 14:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789653835; cv=none; b=kk8pNBrTATKtR6a/5SJWireFma5RkHQ/KI/VKzdS9XQdfmDz+iQMwRBn0eSvCr3dmgHPVRHmbKr/1bXkGlebU+bU5zrP1uVzNq9HL4Dxrqmg7Ga0x+lp+iUPMKGuh06TUW+X43yOne9qX3L1Z1EcZGHBZcxecXQsR1o18Or4CkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789653835; c=relaxed/simple;
	bh=BXxz2KNoF2JTZ11EftliKv4k4kmet4BM0uec7ldj4Ig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e4FEvWlqZQ2Kd15MM5/P+9JikIR83Q13fV+Ox3TAo1h3AvWgcekcFnU7q2EImgHA5Guc2QD2kYFUNWvDZTUR5SNdXIVv5iOUWhgt6IvPi0iu9q8x1LqMPHg/FOw/bQrNwWqTCiaek28jizRgCwFC6VY+wbsJlZlYvGAy5gp1mLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QWsnEz3K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QWsnEz3K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A9A31F00893;
	Thu, 17 Sep 2026 14:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789653833;
	bh=KLr2sxxUQXd91QPC5RoSQyGl1a4/RGG43Hu1q21LoG0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QWsnEz3KghNGNhrqiF2PyCMDFathdcgRmvEfbEiVVHHm7Vn5n27A0ECMz7ChpuOdQ
	 VwDfZfalR5wQiqfVvQDNSPPZW7DSnSn59wvZ4l8gnvMwit5X5hoKlqNcyvnKRsDWOR
	 bc3yukkfxlxBApGvdTySWgroGM70yzpCsx82FlimYM88E3InsHSlfoeDw+4PoxfkLZ
	 IFzA1ZhvSl1FUySVgaR5VxwG7cIrPEFxMCa2BCPJZbjcj4/IjqDqQC8jLy61t5RZSI
	 Utr+YC105kRUipPwv0h/Evge7G5bmedFWiuSu/7MuqO83SxGBbkFwRfsO5ITr8AxhL
	 yGCggWViRI51A==
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
To: linux-coco@lists.linux.dev,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Alexey Kardashevskiy <aik@amd.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Will Deacon <will@kernel.org>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [RFC PATCH v6 09/11] iommufd: Add the vdevice TSM request ioctl
Date: Thu, 17 Sep 2026 19:31:57 +0530
Message-ID: <20260917140159.1163281-10-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260917140159.1163281-1-aneesh.kumar@kernel.org>
References: <20260917140159.1163281-1-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A VMM needs to forward guest-originated TSM commands to the TSM
implementation managing an assigned device. The IOMMUFD vdevice
identifies that device within its vIOMMU and provides the appropriate
dispatch point.

Add IOMMU_VDEVICE_TSM_REQ to send an opaque request to a vdevice and
optionally return a response. Define common operation and guest
architecture identifiers for CCA, SEV and TDX requests.

The ioctl return value reports dispatch or data transfer errors, while
tsm_code carries the TSM-specific result.

Use sockptr_t for the internal request and response buffers so TSM
implementations are not tied to userspace pointers.

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 drivers/iommu/iommufd/Makefile          |  2 +
 drivers/iommu/iommufd/iommufd_private.h |  8 ++
 drivers/iommu/iommufd/main.c            |  3 +
 drivers/iommu/iommufd/tsm.c             | 98 +++++++++++++++++++++++++
 drivers/iommu/iommufd/viommu.c          |  2 +
 include/linux/iommufd.h                 |  5 ++
 include/linux/tsm.h                     | 25 +++++++
 include/uapi/linux/iommufd.h            | 73 ++++++++++++++++++
 8 files changed, 216 insertions(+)
 create mode 100644 drivers/iommu/iommufd/tsm.c

diff --git a/drivers/iommu/iommufd/Makefile b/drivers/iommu/iommufd/Makefile
index 7ed46c286c42..105a54ff89f5 100644
--- a/drivers/iommu/iommufd/Makefile
+++ b/drivers/iommu/iommufd/Makefile
@@ -11,6 +11,8 @@ iommufd-y := \
 	viommu.o \
 	viommu_provider.o
 
+iommufd-$(CONFIG_TSM) += tsm.o
+
 iommufd-$(CONFIG_IOMMUFD_TEST) += selftest.o
 
 obj-$(CONFIG_IOMMUFD) += iommufd.o
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index eae607eb5d76..0c67f2e1f137 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -721,6 +721,14 @@ void iommufd_vdevice_destroy(struct iommufd_object *obj);
 void iommufd_vdevice_abort(struct iommufd_object *obj);
 int iommufd_hw_queue_alloc_ioctl(struct iommufd_ucmd *ucmd);
 void iommufd_hw_queue_destroy(struct iommufd_object *obj);
+#ifdef CONFIG_TSM
+int iommufd_vdevice_tsm_req_ioctl(struct iommufd_ucmd *ucmd);
+#else
+static inline int iommufd_vdevice_tsm_req_ioctl(struct iommufd_ucmd *ucmd)
+{
+	return -EOPNOTSUPP;
+}
+#endif
 
 static inline struct iommufd_vdevice *
 iommufd_get_vdevice(struct iommufd_ctx *ictx, u32 id)
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 8c6d43601afb..4a42cda0e8f8 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -432,6 +432,7 @@ union ucmd_buffer {
 	struct iommu_veventq_alloc veventq;
 	struct iommu_vfio_ioas vfio_ioas;
 	struct iommu_viommu_alloc viommu;
+	struct iommu_vdevice_tsm_req tsm_req;
 #ifdef CONFIG_IOMMUFD_TEST
 	struct iommu_test_cmd test;
 #endif
@@ -493,6 +494,8 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
 		 __reserved),
 	IOCTL_OP(IOMMU_VIOMMU_ALLOC, iommufd_viommu_alloc_ioctl,
 		 struct iommu_viommu_alloc, out_viommu_id),
+	IOCTL_OP(IOMMU_VDEVICE_TSM_REQ, iommufd_vdevice_tsm_req_ioctl,
+		 struct iommu_vdevice_tsm_req, tsm_code),
 #ifdef CONFIG_IOMMUFD_TEST
 	IOCTL_OP(IOMMU_TEST_CMD, iommufd_test, struct iommu_test_cmd, last),
 #endif
diff --git a/drivers/iommu/iommufd/tsm.c b/drivers/iommu/iommufd/tsm.c
new file mode 100644
index 000000000000..2fb51a86c5ec
--- /dev/null
+++ b/drivers/iommu/iommufd/tsm.c
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2026 ARM Ltd.
+ */
+
+#include <linux/tsm.h>
+#include "iommufd_private.h"
+
+static bool iommufd_vdevice_tsm_req_arch_valid(u32 tvm_arch)
+{
+	switch (tvm_arch) {
+	case IOMMU_VDEVICE_TSM_TVM_ARCH_CCA:
+	case IOMMU_VDEVICE_TSM_TVM_ARCH_SEV:
+	case IOMMU_VDEVICE_TSM_TVM_ARCH_TDX:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool iommufd_vdevice_tsm_req_op_valid(u32 op, u32 tvm_arch)
+{
+	switch (op) {
+	case TSM_REQ_VALIDATE_MMIO:
+	case TSM_REQ_SET_TDI_STATE:
+		return true;
+	case TSM_REQ_SEV_ENABLE_DMA:
+	case TSM_REQ_SEV_DISABLE_DMA:
+		return tvm_arch == IOMMU_VDEVICE_TSM_TVM_ARCH_SEV;
+	case TSM_REQ_READ_OBJECT:
+	case TSM_REQ_REGEN_OBJECT:
+	case TSM_REQ_OBJECT_INFO:
+		return true;
+	default:
+		return false;
+	}
+}
+
+/**
+ * iommufd_vdevice_tsm_req_ioctl - Forward TSM requests
+ * @ucmd: user command data for IOMMU_VDEVICE_TSM_REQ
+ *
+ * Resolve @iommu_vdevice_tsm_req::vdevice_id to a vdevice and pass the
+ * request/response buffers to its vIOMMU provider.
+ *
+ * Return:
+ *  -errno on error.
+ *  positive residue if response/request bytes were left unconsumed.
+ *    if response buffer is provided, residue indicates the number of bytes
+ *    not used in response buffer
+ *    if there is no response buffer, residue indicates the number of bytes
+ *    not consumed in req buffer
+ *  0 otherwise.
+ */
+int iommufd_vdevice_tsm_req_ioctl(struct iommufd_ucmd *ucmd)
+{
+	int ret;
+	struct iommufd_vdevice *vdev;
+	struct iommu_vdevice_tsm_req *cmd = ucmd->cmd;
+	struct tsm_guest_req_info info = {
+		.op = cmd->op,
+		.tvm_arch = cmd->tvm_arch,
+		.req   = {
+			.user = u64_to_user_ptr(cmd->req_uptr),
+			.is_kernel = false,
+		},
+		.req_len = cmd->req_len,
+		.resp    =  {
+			.user = u64_to_user_ptr(cmd->resp_uptr),
+			.is_kernel = false,
+		},
+		.resp_len = cmd->resp_len,
+	};
+
+	if (!iommufd_vdevice_tsm_req_arch_valid(cmd->tvm_arch))
+		return -EINVAL;
+
+	if (!iommufd_vdevice_tsm_req_op_valid(cmd->op, cmd->tvm_arch))
+		return -EINVAL;
+
+	vdev = iommufd_get_vdevice(ucmd->ictx, cmd->vdevice_id);
+	if (IS_ERR(vdev))
+		return PTR_ERR(vdev);
+
+	cmd->tsm_code = 0;
+	if (!vdev->viommu->ops || !vdev->viommu->ops->vdevice_tsm_req)
+		ret = -EOPNOTSUPP;
+	else
+		ret = vdev->viommu->ops->vdevice_tsm_req(vdev, &info,
+							 &cmd->tsm_code);
+
+	/* Always copy the tsm_code as response */
+	if (iommufd_ucmd_respond(ucmd, sizeof(*cmd)))
+		ret = -EFAULT;
+
+	iommufd_put_object(ucmd->ictx, &vdev->obj);
+	return ret;
+}
diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index 66bbd6e4571d..c462086ff5df 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -3,6 +3,8 @@
  */
 #include <linux/file.h>
 #include "iommufd_private.h"
+#include <linux/cleanup.h>
+#include <linux/tsm.h>
 
 void iommufd_viommu_destroy(struct iommufd_object *obj)
 {
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 7b906e0d6400..f16b82034be9 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -27,6 +27,7 @@ struct iommufd_viommu_ops;
 struct iommufd_viommu_provider;
 struct module;
 struct page;
+struct tsm_guest_req_info;
 
 /**
  * struct iommufd_viommu_provider_ops - External vIOMMU implementation
@@ -199,6 +200,7 @@ struct iommufd_hw_queue {
  *                include/uapi/linux/iommufd.h)
  *                If driver has a deinit function to revert what vdevice_init op
  *                does, it should set it to the @vdev->destroy function pointer
+ * @vdevice_tsm_req: Forward a guest TSM request to a driver-owned vDEVICE
  * @get_hw_queue_size: Get the size of a driver-defined HW queue structure for a
  *                     given @viommu corresponding to @queue_type. Driver should
  *                     return 0 if HW queue aren't supported accordingly. It is
@@ -225,6 +227,9 @@ struct iommufd_viommu_ops {
 				struct iommu_user_data_array *array);
 	const size_t vdevice_size;
 	int (*vdevice_init)(struct iommufd_vdevice *vdev);
+	ssize_t (*vdevice_tsm_req)(struct iommufd_vdevice *vdev,
+				   struct tsm_guest_req_info *info,
+				   u64 *tsm_code);
 	size_t (*get_hw_queue_size)(struct iommufd_viommu *viommu,
 				    enum iommu_hw_queue_type queue_type);
 	/* AMD's HW will add hw_queue_init simply using @hw_queue->base_addr */
diff --git a/include/linux/tsm.h b/include/linux/tsm.h
index f38d6fcf9cc9..39bad60b4815 100644
--- a/include/linux/tsm.h
+++ b/include/linux/tsm.h
@@ -7,6 +7,8 @@
 #include <linux/types.h>
 #include <linux/uuid.h>
 #include <linux/device.h>
+#include <linux/sockptr.h>
+#include <uapi/linux/iommufd.h>
 
 #define TSM_REPORT_INBLOB_MAX 64
 #define TSM_REPORT_OUTBLOB_MAX SZ_16M
@@ -139,4 +141,27 @@ struct tsm_dev *find_tsm_dev(int id);
 struct pci_ide;
 int tsm_ide_stream_register(struct pci_ide *ide);
 void tsm_ide_stream_unregister(struct pci_ide *ide);
+
+#ifdef CONFIG_TSM
+/**
+ * struct tsm_guest_req_info - parameters for a guest-initiated TSM request
+ * @op: operation for the guest-initiated request
+ * @tvm_arch: guest TVM architecture
+ * @req: request data buffer filled by guest
+ * @req_len: the size of @req filled by guest
+ * @resp: response data buffer filled by host
+ * @resp_len: the size of @resp buffer filled by guest
+ */
+struct tsm_guest_req_info {
+	enum iommu_vdevice_tsm_guest_req_op op;
+	enum iommu_vdevice_tsm_guest_tvm_arch tvm_arch;
+	sockptr_t req;
+	size_t req_len;
+	sockptr_t resp;
+	size_t resp_len;
+};
+#else
+struct tsm_guest_req_info;
+#endif
+
 #endif /* __TSM_H */
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 0425d452d41e..43ed082a9421 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -57,6 +57,7 @@ enum {
 	IOMMUFD_CMD_IOAS_CHANGE_PROCESS = 0x92,
 	IOMMUFD_CMD_VEVENTQ_ALLOC = 0x93,
 	IOMMUFD_CMD_HW_QUEUE_ALLOC = 0x94,
+	IOMMUFD_CMD_VDEVICE_TSM_REQ = 0x96,
 };
 
 /**
@@ -1351,4 +1352,76 @@ struct iommu_hw_queue_alloc {
 	__aligned_u64 length;
 };
 #define IOMMU_HW_QUEUE_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_HW_QUEUE_ALLOC)
+
+/**
+ * enum iommu_vdevice_tsm_guest_tvm_arch - guest TVM architecture
+ * @IOMMU_VDEVICE_TSM_TVM_ARCH_CCA: Arm CCA TVM
+ * @IOMMU_VDEVICE_TSM_TVM_ARCH_SEV: AMD SEV TVM
+ * @IOMMU_VDEVICE_TSM_TVM_ARCH_TDX: Intel TDX TVM
+ */
+enum iommu_vdevice_tsm_guest_tvm_arch {
+	IOMMU_VDEVICE_TSM_TVM_ARCH_CCA = 1,
+	IOMMU_VDEVICE_TSM_TVM_ARCH_SEV,
+	IOMMU_VDEVICE_TSM_TVM_ARCH_TDX,
+};
+
+/**
+ * enum iommu_vdevice_tsm_guest_req_op - operation for guest TSM requests
+ * @TSM_REQ_VALIDATE_MMIO: Validate MMIO for the TDI
+ * @TSM_REQ_SET_TDI_STATE: Set TDI state
+ * @TSM_REQ_SEV_ENABLE_DMA: Enable SEV DMA
+ * @TSM_REQ_SEV_DISABLE_DMA: Disable SEV DMA
+ * @TSM_REQ_READ_OBJECT: Read a TSM object
+ * @TSM_REQ_REGEN_OBJECT: Regenerate a TSM object
+ * @TSM_REQ_OBJECT_INFO: Read TSM object information
+ */
+enum iommu_vdevice_tsm_guest_req_op {
+	TSM_REQ_VALIDATE_MMIO = 1,
+	TSM_REQ_SET_TDI_STATE,
+	TSM_REQ_SEV_ENABLE_DMA,
+	TSM_REQ_SEV_DISABLE_DMA,
+	TSM_REQ_READ_OBJECT,
+	TSM_REQ_REGEN_OBJECT,
+	TSM_REQ_OBJECT_INFO,
+};
+
+/**
+ * struct iommu_vdevice_tsm_req - ioctl(IOMMU_VDEVICE_TSM_REQ)
+ * @size: sizeof(struct iommu_vdevice_tsm_req)
+ * @vdevice_id: vDevice ID the guest request is for
+ * @op: One of enum iommu_vdevice_tsm_guest_req_op
+ * @tvm_arch: One of enum iommu_vdevice_tsm_guest_tvm_arch
+ * @req_len: Size in bytes of the input payload at @req_uptr
+ * @resp_len: Size in bytes of the output buffer at @resp_uptr
+ * @req_uptr: Userspace pointer to the guest-provided request payload
+ * @resp_uptr: Userspace pointer to the guest response buffer
+ * @tsm_code: TSM-specific result code returned by the TSM implementation
+ *
+ * Forward a TSM request to the TSM bound vDevice. This is intended for
+ * guest TSM/TDISP message transport where the host kernel only marshals
+ * bytes between userspace and the TSM implementation.
+ *
+ * The request operation is guest initiated. The TSM backend validates
+ * @tvm_arch against its bound TVM architecture assumptions.
+ *
+ * The request payload is read from @req_uptr/@req_len. If a response is
+ * expected, userspace provides @resp_uptr/@resp_len as writable storage for
+ * response bytes returned by the TSM path.
+ *
+ * The ioctl is only suitable for commands and results that the host kernel
+ * has no use, the host is only facilitating guest to TSM communication.
+ */
+struct iommu_vdevice_tsm_req {
+	__u32 size;
+	__u32 vdevice_id;
+	__u32 op;
+	__u32 tvm_arch;
+	__u32 req_len;
+	__u32 resp_len;
+	__aligned_u64 req_uptr;
+	__aligned_u64 resp_uptr;
+	__aligned_u64 tsm_code;
+};
+
+#define IOMMU_VDEVICE_TSM_REQ _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VDEVICE_TSM_REQ)
 #endif
-- 
2.43.0

