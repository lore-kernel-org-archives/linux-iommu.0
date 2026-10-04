Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD023B3C0E
	for <iommu@lists.linux.dev>; Sun,  4 Oct 2026 16:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791130972; cv=none; b=TCEP56uoFgHyD6ewlHa9rv+rjsc2oWs2r3OEAIeIk+fjDG0U/GnPmknvmS8eRT+Qa0roshdgIiuqUqMWjH/VEW9pP4MFBYye83g+ndM74dQZHzI4IHxhI7vZlqBv12cpT84n0iKQS+GKGuoT/AidRIQuXBS/OV7r5f1dBG8ksdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791130972; c=relaxed/simple;
	bh=BsbbOOCBA0Em8sd8nfzRmEV9r3xUsdBFQ2VQ367lio8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J7qSLCuvtT1x4EWw5DpXB0Hj4m7xeomSwsxPRUKbazSe1lPWgp9b1BaRA+ghIa/eBxWIlMgtG9FQSt/O36iYmY5WhHJ2ceaoNFuXFe1OuDOvRlp8y3rhw4lykFzJ4qxZgp+BpltDbi7/nF8+02C6nlMPL2CR9Y2V/5nPVo1K8cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=p512mk8b; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="p512mk8b"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1791130959; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=93KOAzHiZgonLIrP05ulmCxduW+JGZwhYIrJjNqbI4I=;
	b=p512mk8b+U5BC4WNQjgAtxpr52RH4E+PkFgOQOipNjTRehWZzM9tgSCb6r8U3Xu61Lr7hHqXucZiMj7QYSVzbZ745Hx2R0Ly/6ONCZW5nKL3iC66ioQeW0V1jx5ClJjz7kbjSlAgnkIZ7yxBSQN/5GgIb0Bo4s4TQBEr3v2Z1PM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0XC2deBl_1791130958;
Received: from VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0XC2deBl_1791130958 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 05 Oct 2026 00:22:38 +0800
From: Guanghui Feng <guanghuifeng@linux.alibaba.com>
To: jgg@ziepe.ca
Cc: alex@shazbot.org,
	guanghuifeng@linux.alibaba.com,
	iommu@lists.linux.dev,
	joro@8bytes.org,
	kevin.tian@intel.com,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	robin.murphy@arm.com,
	will@kernel.org
Subject: [PATCH v3 2/2] iommufd: Add IOMMU_GET_PCI_MMIO_WINDOWS ioctl
Date: Mon,  5 Oct 2026 00:22:13 +0800
Message-ID: <20261004162213.3787623-3-guanghuifeng@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261004162213.3787623-1-guanghuifeng@linux.alibaba.com>
References: <20260921115513.GK11599@ziepe.ca>
 <20261004162213.3787623-1-guanghuifeng@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new per-device query ioctl that reports the PCI host bridge MMIO
windows behind a given device.  This allows userspace (e.g. QEMU) to
learn which address ranges a PCIe switch might misinterpret as
peer-to-peer DMA targets, and voluntarily keep its IOVA allocations away
from them.

The kernel does NOT reserve or enforce these ranges -- it only reports
them.  Userspace can choose to opt into avoiding these windows based on
its own topology knowledge and requirements.  This follows the principle
established by commit cd2c9fcf5c66 ("iommu/dma: Move PCI window region reservation back into dma specific path.")
that PCI window information should not be forced through the IOMMU
reserved-region API onto userspace.

The ioctl uses the standard "user provides array + count, kernel fills
and returns actual count, -EMSGSIZE if too small" pattern established by
IOMMU_IOAS_IOVA_RANGES.  Per-device granularity is chosen because PCI
host bridge windows are a property of the device's bus topology and are
available immediately after VFIO_DEVICE_BIND_IOMMUFD, before any IOAS
attachment.

Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
---
 drivers/iommu/iommufd/device.c          | 64 +++++++++++++++++++++++++
 drivers/iommu/iommufd/iommufd_private.h |  1 +
 drivers/iommu/iommufd/main.c            |  3 ++
 include/uapi/linux/iommufd.h            | 55 +++++++++++++++++++++
 4 files changed, 123 insertions(+)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index a664c70a6fe7..74a0642ff4fb 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -1747,3 +1747,67 @@ int iommufd_get_hw_info(struct iommufd_ucmd *ucmd)
 	iommufd_put_object(ucmd->ictx, &idev->obj);
 	return rc;
 }
+
+int iommufd_device_get_pci_mmio_windows(struct iommufd_ucmd *ucmd)
+{
+	struct iommu_pci_mmio_window __user *windows;
+	struct iommu_pci_mmio_windows *cmd = ucmd->cmd;
+	struct iommu_resv_region *resv, *next;
+	struct iommufd_device *idev;
+	LIST_HEAD(resv_windows);
+	u32 max_windows;
+	int rc;
+
+	if (cmd->flags)
+		return -EOPNOTSUPP;
+
+	idev = iommufd_get_device(ucmd, cmd->dev_id);
+	if (IS_ERR(idev))
+		return PTR_ERR(idev);
+
+	if (!dev_is_pci(idev->dev)) {
+		rc = -EOPNOTSUPP;
+		goto out_put;
+	}
+
+	rc = iommu_get_pci_resv_windows(to_pci_dev(idev->dev), &resv_windows);
+	if (rc)
+		goto out_put;
+
+	max_windows = cmd->num_windows;
+	windows = u64_to_user_ptr(cmd->windows);
+	cmd->num_windows = 0;
+	list_for_each_entry(resv, &resv_windows, list) {
+		if (!resv->length)
+			continue;
+
+		if (cmd->num_windows < max_windows) {
+			struct iommu_pci_mmio_window elm = {
+				.start = resv->start,
+				.last = resv->start + resv->length - 1,
+			};
+
+			if (copy_to_user(&windows[cmd->num_windows], &elm,
+					 sizeof(elm))) {
+				rc = -EFAULT;
+				goto out_free;
+			}
+		}
+		cmd->num_windows++;
+	}
+
+	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
+	if (rc)
+		goto out_free;
+	if (cmd->num_windows > max_windows)
+		rc = -EMSGSIZE;
+
+out_free:
+	list_for_each_entry_safe(resv, next, &resv_windows, list) {
+		list_del(&resv->list);
+		kfree(resv);
+	}
+out_put:
+	iommufd_put_object(ucmd->ictx, &idev->obj);
+	return rc;
+}
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index eb2e85b27e42..557f205e7836 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -535,6 +535,7 @@ iommufd_device_get_iommu_dev(struct iommufd_device *idev)
 void iommufd_device_pre_destroy(struct iommufd_object *obj);
 void iommufd_device_destroy(struct iommufd_object *obj);
 int iommufd_get_hw_info(struct iommufd_ucmd *ucmd);
+int iommufd_device_get_pci_mmio_windows(struct iommufd_ucmd *ucmd);
 
 struct device *iommufd_global_device(void);
 
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 9a921b153162..0d1be82c1ddd 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -449,6 +449,7 @@ union ucmd_buffer {
 	struct iommu_ioas_map map;
 	struct iommu_ioas_unmap unmap;
 	struct iommu_option option;
+	struct iommu_pci_mmio_windows pci_mmio_windows;
 	struct iommu_vdevice_alloc vdev;
 	struct iommu_veventq_alloc veventq;
 	struct iommu_vfio_ioas vfio_ioas;
@@ -480,6 +481,8 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
 		 struct iommu_fault_alloc, out_fault_fd),
 	IOCTL_OP(IOMMU_GET_HW_INFO, iommufd_get_hw_info, struct iommu_hw_info,
 		 __reserved),
+	IOCTL_OP(IOMMU_GET_PCI_MMIO_WINDOWS, iommufd_device_get_pci_mmio_windows,
+		 struct iommu_pci_mmio_windows, windows),
 	IOCTL_OP(IOMMU_HW_QUEUE_ALLOC, iommufd_hw_queue_alloc_ioctl,
 		 struct iommu_hw_queue_alloc, length),
 	IOCTL_OP(IOMMU_HWPT_ALLOC, iommufd_hwpt_alloc, struct iommu_hwpt_alloc,
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 206fa667c782..5707eb6130ee 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -58,6 +58,7 @@ enum {
 	IOMMUFD_CMD_VEVENTQ_ALLOC = 0x93,
 	IOMMUFD_CMD_HW_QUEUE_ALLOC = 0x94,
 	IOMMUFD_CMD_IOAS_NOIOMMU_GET_PA = 0x95,
+	IOMMUFD_CMD_GET_PCI_MMIO_WINDOWS = 0x96,
 };
 
 /**
@@ -1390,4 +1391,58 @@ struct iommu_hw_queue_alloc {
 	__aligned_u64 length;
 };
 #define IOMMU_HW_QUEUE_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_HW_QUEUE_ALLOC)
+
+/**
+ * struct iommu_pci_mmio_window - a PCI host bridge MMIO window
+ * @start: First PCI bus address of the window
+ * @last: Inclusive last PCI bus address of the window
+ *
+ * A memory window claimed by the PCI host bridge that a device sits
+ * behind.  Addresses are PCI bus addresses (i.e. what appears in the
+ * TLP), which differ from CPU physical addresses on platforms where the
+ * host bridge applies an address translation offset.  For a device
+ * using an identity (1:1) IOVA layout the IOVA equals the bus address,
+ * so these are the IOVAs that a PCIe switch could misinterpret as
+ * peer-to-peer DMA and route to the wrong device instead of memory.
+ */
+struct iommu_pci_mmio_window {
+	__aligned_u64 start;
+	__aligned_u64 last;
+};
+
+/**
+ * struct iommu_pci_mmio_windows - ioctl(IOMMU_GET_PCI_MMIO_WINDOWS)
+ * @size: sizeof(struct iommu_pci_mmio_windows)
+ * @flags: Must be 0
+ * @dev_id: The device bound to iommufd to query
+ * @num_windows: Input/output number of MMIO windows
+ * @windows: Pointer to the output array of struct iommu_pci_mmio_window
+ *
+ * Query the memory windows of the PCI host bridge that @dev_id sits
+ * behind.  This is advisory: the kernel does not reserve these ranges, it
+ * only reports them so userspace can choose to keep its IOVA allocations
+ * away from them and avoid accidental peer-to-peer DMA routing.  The
+ * reported windows are pessimistic (the whole host bridge window, not the
+ * precise BAR ranges that may actually conflict).  If a IOAS has devices
+ * behind multiple host bridges, query each device and take the union.
+ *
+ * On input num_windows is the length of the windows array.  On output it
+ * is the total number of windows.  The ioctl will return -EMSGSIZE and set
+ * num_windows to the required value if num_windows is too small.  In this
+ * case the caller should allocate a larger output array and re-issue the
+ * ioctl.
+ *
+ * Return: 0 on success, -EOPNOTSUPP if @dev_id is not a PCI device,
+ * -ENOENT if @dev_id is invalid, -EMSGSIZE if the output array is too
+ * small.
+ */
+struct iommu_pci_mmio_windows {
+	__u32 size;
+	__u32 flags;
+	__u32 dev_id;
+	__u32 num_windows;
+	__aligned_u64 windows;
+};
+#define IOMMU_GET_PCI_MMIO_WINDOWS \
+	_IO(IOMMUFD_TYPE, IOMMUFD_CMD_GET_PCI_MMIO_WINDOWS)
 #endif
-- 
2.43.7

