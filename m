Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.110
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792935032;
	b=Tbna2EIlcswe8+NrSBZJPBt+OY4uBPyEjbc36cFu81hd9S+MTLBNleQNitvustCyeLR0
	 0TF/UGdZDi1IfRASGTY43wc+svek9AbdpCTF6djuMA3NONE753rOJmiqMJ57Jo4HrjmYi
	 AQkSq2fT8NvU6RtLQi3j712Gd7fh3xNjfK4uCuMxkn79o+ugQJRlQuhEmRExyVxdIKH7J
	 iRYZOV1VWpGgkBwRtLP95D3ljFNkuuhnQ2SpIamn+5kN0Qtw4Kl/tUvE7jW+ijXUTPoZA
	 EwXBZFLk+SJBONg6Srn66wPoDPciXeieaKa9kYR59YWhkVVHh3QM9v3E4YulL3PrmUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792935032;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=vvK/fsKZaeGoy/mnq6Bep8FiIzpvlZAu9Y/ujdijQxE=;
	b=juf2McpxuPUqr+BQBkeBl28wNGPrSgEXX1apZ2/txdBdfWz0PvxMhPY/Pz2kNvpN5mu7
	 hJfwuwfICSQAvYP6J3SHeBuncjm2vcAylWHHVDwKVt410goCNanPgDCh8Uhc8QU5OybOw
	 cYR3tAaiqkaAabn4FlAA/j7/2qtcT8gKhZrxON5jZtfG8aq5LS0jJG0WT8P4+DLnt5pPs
	 cpXQ91N07w4g8nWfpz2K4USRbSeJS8i1pUQcOD8m2Immu8LI7XApPfObHje24C8mHtyyT
	 OeoVKbhJg965XQmJrM7MASydbAQVrUAGUUjIHAXz/mfw9/Z9tll+sjv0hqMwY+Vn5cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b="L/9vcufr";
	arc=none smtp.remote-ip=115.124.30.110
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB02606A31A
	for <iommu@lists.linux.dev>; Sun, 25 Oct 2026 13:30:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CAB02606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=L/9vcufr
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1792935022; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=vvK/fsKZaeGoy/mnq6Bep8FiIzpvlZAu9Y/ujdijQxE=;
	b=L/9vcufrP9W2BVraKeHkxzwK8mXFu+jmvsapGm6Pvlp2ZBYAQVWez9sXroW6HG0vywIf6YdT751pkMhX1F2qYne/uKRacg2HUhJ0fhtjn5KgosCZK/f6hXtkdZax47jUVy4dPZfWL9oW1ZaWpwbOwkt8CFg8ZmMbJtiF1EaN6U0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0XDQQjMq_1792935021;
Received: from VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0XDQQjMq_1792935021 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 25 Oct 2026 21:30:22 +0800
From: Guanghui Feng <guanghuifeng@linux.alibaba.com>
To: jgg@ziepe.ca
Cc: alex@shazbot.org,
	iommu@lists.linux.dev,
	joro@8bytes.org,
	kevin.tian@intel.com,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	robin.murphy@arm.com,
	will@kernel.org
Subject: [PATCH v4 2/2] iommufd: Add IOMMU_GET_PCI_MMIO_WINDOWS ioctl
Date: Sun, 25 Oct 2026 21:30:00 +0800
Message-ID: <20261025133000.205508-3-guanghuifeng@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261025133000.205508-1-guanghuifeng@linux.alibaba.com>
References: <20261022193359.GF3381610@ziepe.ca>
 <20261025133000.205508-1-guanghuifeng@linux.alibaba.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a per-device query ioctl that reports the PCI host bridge MMIO
windows behind a given device.  This allows userspace (e.g. QEMU) to
learn which address ranges a PCIe switch might misinterpret as
peer-to-peer DMA targets, and voluntarily keep its IOVA allocations
away from them.

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
 include/uapi/linux/iommufd.h            | 59 +++++++++++++++++++++++
 4 files changed, 127 insertions(+)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 1b0bdf57ac8a..91d433823c51 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -1749,3 +1749,67 @@ int iommufd_get_hw_info(struct iommufd_ucmd *ucmd)
 	iommufd_put_object(ucmd->ictx, &idev->obj);
 	return rc;
 }
+
+struct pci_mmio_windows_ctx {
+	struct iommu_pci_mmio_window __user *out_windows;
+	u32 max_windows;
+	u32 num_windows;
+};
+
+static int pci_mmio_window_fn(phys_addr_t start, phys_addr_t end, void *data)
+{
+	struct pci_mmio_windows_ctx *ctx = data;
+
+	if (ctx->num_windows < ctx->max_windows) {
+		struct iommu_pci_mmio_window elm = {
+			.start = start,
+			.last = end,
+		};
+
+		if (copy_to_user(&ctx->out_windows[ctx->num_windows], &elm,
+				 sizeof(elm)))
+			return -EFAULT;
+	}
+	ctx->num_windows++;
+	return 0;
+}
+
+int iommufd_device_get_pci_mmio_windows(struct iommufd_ucmd *ucmd)
+{
+	struct iommu_pci_mmio_windows *cmd = ucmd->cmd;
+	struct pci_mmio_windows_ctx ctx;
+	struct iommufd_device *idev;
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
+	ctx.out_windows = u64_to_user_ptr(cmd->out_windows);
+	ctx.max_windows = cmd->num_windows;
+	ctx.num_windows = 0;
+
+	rc = iommu_for_each_pci_mmio_window(to_pci_dev(idev->dev),
+					    pci_mmio_window_fn, &ctx);
+	if (rc)
+		goto out_put;
+
+	cmd->num_windows = ctx.num_windows;
+	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
+	if (rc)
+		goto out_put;
+	if (ctx.num_windows > ctx.max_windows)
+		rc = -EMSGSIZE;
+
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
index 9a921b153162..7b8ecdd45b76 100644
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
+		 struct iommu_pci_mmio_windows, out_windows),
 	IOCTL_OP(IOMMU_HW_QUEUE_ALLOC, iommufd_hw_queue_alloc_ioctl,
 		 struct iommu_hw_queue_alloc, length),
 	IOCTL_OP(IOMMU_HWPT_ALLOC, iommufd_hwpt_alloc, struct iommu_hwpt_alloc,
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 010f47f7d3d2..c4a56a3dc6f9 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -58,6 +58,7 @@ enum {
 	IOMMUFD_CMD_VEVENTQ_ALLOC = 0x93,
 	IOMMUFD_CMD_HW_QUEUE_ALLOC = 0x94,
 	IOMMUFD_CMD_IOAS_NOIOMMU_GET_PA = 0x95,
+	IOMMUFD_CMD_GET_PCI_MMIO_WINDOWS = 0x96,
 };
 
 /**
@@ -1398,4 +1399,62 @@ struct iommu_hw_queue_alloc {
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
+ * behind.  These are PCI bus addresses (what appears in the TLP).
+ * A PCIe switch could misinterpret DMA to these addresses as
+ * peer-to-peer traffic and route it to the wrong device.
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
+ * @out_windows: Pointer to the output array of struct iommu_pci_mmio_window
+ *
+ * Query the memory windows of the PCI host bridge that @dev_id sits
+ * behind.  This is advisory: the kernel does not reserve these ranges,
+ * it only reports them so userspace can choose to keep its IOVA
+ * allocations away from them and avoid accidental peer-to-peer DMA
+ * routing.  The reported windows are pessimistic (the whole host bridge
+ * window, not the precise BAR ranges that may actually conflict).
+ *
+ * Windows are reported in host bridge resource list order.  They are
+ * typically non-overlapping (host bridge address decoders are exclusive)
+ * but no sorting guarantee is made.  Userspace should treat them as a
+ * set and compute the union if needed.
+ *
+ * If an IOAS has devices behind multiple host bridges, query each device
+ * and take the union of the results.
+ *
+ * On input num_windows is the length of the out_windows array.  On
+ * output it is the total number of windows.  The ioctl will return
+ * -EMSGSIZE and set num_windows to the required value if num_windows is
+ * too small.  In this case the caller should allocate a larger output
+ * array and re-issue the ioctl.
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
+	__aligned_u64 out_windows;
+};
+#define IOMMU_GET_PCI_MMIO_WINDOWS \
+	_IO(IOMMUFD_TYPE, IOMMUFD_CMD_GET_PCI_MMIO_WINDOWS)
 #endif
-- 
2.43.7

