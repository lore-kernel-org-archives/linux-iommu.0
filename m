Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3917F34A78E;
	Mon, 27 Apr 2026 06:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777270246; cv=none; b=rjKQmHWv02YG7Ba6aurmebdLYdWVhPD2no/ICGRTlXQdmbx43uw2buFKNsTtZ2JsZu5zYC1j4arAnplawTvYmEUz87dEXFhu356k2EDBCOvm+YuQ/lHectPxv4gnZmk0R0ufkXYREARJn2q/fqab3o4EmIOZV9COmkgtv+Fib9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777270246; c=relaxed/simple;
	bh=Hp5HnxbAmMw5Nb5MF/pQEylDTfu3UENs902wE1b9ieg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JhgUH14XD8T2BOFS/rJSwbbZvZHgu1GkNp9VVq39FmnZUdUBAuTeY6g82oifcOi7pbI9ujWnESwnralQ/CGJ9vXfbAhdZMeivcruvoTsKJTCNUh5z5tyvuAgb0VIEbStXYbRUbDHyeo5vFzPhtysg8HwtAhelwavTCul0BUoW0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y2oiRlvd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y2oiRlvd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35C89C19425;
	Mon, 27 Apr 2026 06:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777270246;
	bh=Hp5HnxbAmMw5Nb5MF/pQEylDTfu3UENs902wE1b9ieg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y2oiRlvdX9SeGxLcLSwhdaY7MXULvVB0fN/nMGhYByyd32cc5McT4at5Bc+qtyyVq
	 yapkkOF+7UCfYIw9dZ+OwtLDmhQ+bQUx2pRA7Mw8/cahNFOARRwVq5XnJMTcyM2aMh
	 YhbZhrJMq3CNPCAiHzszsjhD4qu4fmo9m+OiiDNT6eG/keSlS+sHeDiqXkYA+WCYWX
	 XTmlLKKWEOQOv45Jw7hQikuyGfuAVp/XVLxN9C3qr/rkvgCOIkM06CBzRhXimpzQZA
	 GHTgco/LI0/73r8zJYYZRydU2G7fXr6WscpnmlEktuQXYPhS0IbWSu2umfJlXKcULR
	 zSvt7h993dYtA==
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
Subject: [PATCH v4 4/4] iommufd/vdevice: add TSM guest request ioctl
Date: Mon, 27 Apr 2026 11:40:05 +0530
Message-ID: <20260427061005.901854-5-aneesh.kumar@kernel.org>
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

Add IOMMU_VDEVICE_TSM_GUEST_REQUEST for issuing TSM guest request/response
transactions against an iommufd vdevice.

The ioctl takes a vdevice_id plus request/response user buffers and length
fields, and forwards the request through tsm_guest_req() to the PCI TSM
backend. This provides the host-side passthrough path used by CoCo guests
for TSM device attestation and acceptance flows after the device has been
bound to TSM.

Also add the supporting tsm_guest_req() helper and associated TSM core
interface definitions.

Based on changes from: Alexey Kardashevskiy <aik@amd.com>

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 drivers/iommu/iommufd/iommufd_private.h |  7 ++++
 drivers/iommu/iommufd/main.c            |  3 ++
 drivers/iommu/iommufd/tsm.c             | 49 +++++++++++++++++++++++++
 drivers/virt/coco/tsm-core.c            | 11 ++++++
 include/linux/tsm.h                     | 25 +++++++++++++
 include/uapi/linux/iommufd.h            | 41 +++++++++++++++++++++
 6 files changed, 136 insertions(+)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 14d2d6d1beec..8a27b946adef 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -701,11 +701,18 @@ int iommufd_hw_queue_alloc_ioctl(struct iommufd_ucmd *ucmd);
 void iommufd_hw_queue_destroy(struct iommufd_object *obj);
 #ifdef CONFIG_TSM
 int iommufd_vdevice_tsm_op_ioctl(struct iommufd_ucmd *ucmd);
+int iommufd_vdevice_tsm_guest_request_ioctl(struct iommufd_ucmd *ucmd);
 #else
 static inline int iommufd_vdevice_tsm_op_ioctl(struct iommufd_ucmd *ucmd)
 {
 	return -EOPNOTSUPP;
 }
+
+static inline int
+iommufd_vdevice_tsm_guest_request_ioctl(struct iommufd_ucmd *ucmd)
+{
+	return -EOPNOTSUPP;
+}
 #endif
 
 static inline struct iommufd_vdevice *
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index d73e6b391c6f..7f4bbdd0bda5 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -433,6 +433,7 @@ union ucmd_buffer {
 	struct iommu_vfio_ioas vfio_ioas;
 	struct iommu_viommu_alloc viommu;
 	struct iommu_vdevice_tsm_op tsm_op;
+	struct iommu_vdevice_tsm_guest_request gr;
 #ifdef CONFIG_IOMMUFD_TEST
 	struct iommu_test_cmd test;
 #endif
@@ -496,6 +497,8 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
 		 struct iommu_viommu_alloc, out_viommu_id),
 	IOCTL_OP(IOMMU_VDEVICE_TSM_OP, iommufd_vdevice_tsm_op_ioctl,
 		 struct iommu_vdevice_tsm_op, vdevice_id),
+	IOCTL_OP(IOMMU_VDEVICE_TSM_GUEST_REQUEST, iommufd_vdevice_tsm_guest_request_ioctl,
+		 struct iommu_vdevice_tsm_guest_request, resp_uptr),
 #ifdef CONFIG_IOMMUFD_TEST
 	IOCTL_OP(IOMMU_TEST_CMD, iommufd_test, struct iommu_test_cmd, last),
 #endif
diff --git a/drivers/iommu/iommufd/tsm.c b/drivers/iommu/iommufd/tsm.c
index 4e5fa7849342..2458bc27628d 100644
--- a/drivers/iommu/iommufd/tsm.c
+++ b/drivers/iommu/iommufd/tsm.c
@@ -58,3 +58,52 @@ int iommufd_vdevice_tsm_op_ioctl(struct iommufd_ucmd *ucmd)
 	iommufd_put_object(ucmd->ictx, &vdev->obj);
 	return rc;
 }
+
+/**
+ * iommufd_vdevice_tsm_guest_request_ioctl - Forward guest TSM requests
+ * @ucmd: user command data for IOMMU_VDEVICE_TSM_GUEST_REQUEST
+ *
+ * Resolve @iommu_vdevice_tsm_guest_request::vdevice_id to a vdevice and pass
+ * the request/response buffers to the TSM core.
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
+int iommufd_vdevice_tsm_guest_request_ioctl(struct iommufd_ucmd *ucmd)
+{
+	int rc;
+	struct iommufd_vdevice *vdev;
+	struct iommu_vdevice_tsm_guest_request *cmd = ucmd->cmd;
+	struct tsm_guest_req_info info = {
+		.scope = cmd->scope,
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
+	if (cmd->__reserved)
+		return -EOPNOTSUPP;
+
+	vdev = iommufd_get_vdevice(ucmd->ictx, cmd->vdevice_id);
+	if (IS_ERR(vdev))
+		return PTR_ERR(vdev);
+
+	rc = tsm_guest_req(vdev->idev->dev, &info);
+
+	/* No inline response, hence we don't need to copy the response */
+	iommufd_put_object(ucmd->ictx, &vdev->obj);
+	return rc;
+}
diff --git a/drivers/virt/coco/tsm-core.c b/drivers/virt/coco/tsm-core.c
index f0e35fc38776..6c46f5ef139c 100644
--- a/drivers/virt/coco/tsm-core.c
+++ b/drivers/virt/coco/tsm-core.c
@@ -259,6 +259,17 @@ int tsm_unbind(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(tsm_unbind);
 
+ssize_t tsm_guest_req(struct device *dev, struct tsm_guest_req_info *info)
+{
+	if (!dev_is_pci(dev))
+		return -EINVAL;
+
+	return pci_tsm_guest_req(to_pci_dev(dev), info->scope, info->req,
+				 info->req_len, info->resp, info->resp_len,
+				 NULL);
+}
+EXPORT_SYMBOL_GPL(tsm_guest_req);
+
 static void tsm_release(struct device *dev)
 {
 	struct tsm_dev *tsm_dev = container_of(dev, typeof(*tsm_dev), dev);
diff --git a/include/linux/tsm.h b/include/linux/tsm.h
index 85eb1717bddd..938da0324408 100644
--- a/include/linux/tsm.h
+++ b/include/linux/tsm.h
@@ -6,6 +6,7 @@
 #include <linux/types.h>
 #include <linux/uuid.h>
 #include <linux/device.h>
+#include <linux/sockptr.h>
 
 #define TSM_REPORT_INBLOB_MAX 64
 #define TSM_REPORT_OUTBLOB_MAX SZ_16M
@@ -131,6 +132,23 @@ struct kvm;
 #ifdef CONFIG_TSM
 int tsm_bind(struct device *dev, struct kvm *kvm, u64 tdi_id);
 int tsm_unbind(struct device *dev);
+
+/**
+ * struct tsm_guest_req_info - parameter for tsm_guest_req()
+ * @scope: scope for tsm guest request
+ * @req: request data buffer filled by guest
+ * @req_len: the size of @req filled by guest
+ * @resp: response data buffer filled by host
+ * @resp_len: the size of @resp buffer filled by guest
+ */
+struct tsm_guest_req_info {
+	u32 scope;
+	sockptr_t req;
+	size_t req_len;
+	sockptr_t resp;
+	size_t resp_len;
+};
+ssize_t tsm_guest_req(struct device *dev, struct tsm_guest_req_info *info);
 #else
 static inline int tsm_bind(struct device *dev, struct kvm *kvm, u64 tdi_id)
 {
@@ -141,6 +159,13 @@ static inline int tsm_unbind(struct device *dev)
 {
 	return 0;
 }
+
+struct tsm_guest_req_info;
+static inline ssize_t tsm_guest_req(struct device *dev,
+				    struct tsm_guest_req_info *info)
+{
+	return -EINVAL;
+}
 #endif
 
 #endif /* __TSM_H */
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index aabdfd86504c..47213663c0c1 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -58,6 +58,7 @@ enum {
 	IOMMUFD_CMD_VEVENTQ_ALLOC = 0x93,
 	IOMMUFD_CMD_HW_QUEUE_ALLOC = 0x94,
 	IOMMUFD_CMD_VDEVICE_TSM_OP = 0x95,
+	IOMMUFD_CMD_VDEVICE_TSM_GUEST_REQUEST = 0x96,
 };
 
 /**
@@ -1364,4 +1365,44 @@ struct iommu_hw_queue_alloc {
 	__aligned_u64 length;
 };
 #define IOMMU_HW_QUEUE_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_HW_QUEUE_ALLOC)
+
+/**
+ * struct iommu_vdevice_tsm_guest_request - ioctl(IOMMU_VDEVICE_TSM_GUEST_REQUEST)
+ * @size: sizeof(struct iommu_vdevice_tsm_guest_request)
+ * @vdevice_id: vDevice ID the guest request is for
+ * @scope: Bus-specific scope classification for the guest request
+ * @req_len: Size in bytes of the input payload at @req_uptr
+ * @resp_len: Size in bytes of the output buffer at @resp_uptr
+ * @__reserved: Must be 0
+ * @req_uptr: Userspace pointer to the guest-provided request payload
+ * @resp_uptr: Userspace pointer to the guest response buffer
+ *
+ * Forward a guest request to the TSM bound vDevice. This is intended for
+ * guest TSM/TDISP message transport where the host kernel only marshals
+ * bytes between userspace and the TSM implementation.
+ *
+ * The meaning and valid values of @scope are defined by the TSM backend for
+ * the device bus type.
+ *
+ * For PCI devices, @scope follows enum pci_tsm_req_scope. Requests outside
+ * the allowed PCI scope for this path are rejected.
+ *
+ * The request payload is read from @req_uptr/@req_len. If a response is
+ * expected, userspace provides @resp_uptr/@resp_len as writable storage for
+ * response bytes returned by the TSM path.
+ *
+ * The ioctl is only suitable for commands and results that the host kernel
+ * has no use, the host is only facilitating guest to TSM communication.
+ */
+struct iommu_vdevice_tsm_guest_request {
+	__u32 size;
+	__u32 vdevice_id;
+	__u32 scope;
+	__u32 req_len;
+	__u32 resp_len;
+	__u32 __reserved;
+	__aligned_u64 req_uptr;
+	__aligned_u64 resp_uptr;
+};
+#define IOMMU_VDEVICE_TSM_GUEST_REQUEST _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VDEVICE_TSM_GUEST_REQUEST)
 #endif
-- 
2.43.0

