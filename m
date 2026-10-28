Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.119
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793171965;
	b=iUUtlwPbDNDUgVbZopPiQg5MmZrhgtEux0k3+6Q4IuHlLXoaFkFrmlhmZDbrO3Y1q4k9
	 BkAKPE+jQnvZ9K+EJAPKUVSUHU1SbyrnSiY2CrWqKYn+Ee3KVLBLMC7IFgriBXGjoIgK4
	 16PONY1h1v2br9jyFWJ50RZU/IBdgvNZf2MlHZa1q1+i+oO6VAQ2mIVW66B3FWU6isVW5
	 bO39k4Uln/byUB00OrdlD7KED5gObg7AMLCDNaanZAuAipqYa+h3cErWMgMZy7WeMVEoa
	 94tuBLXn9EKNUaRA6A5RvoNn53D4b0ki6F7jgRNFmxa5cHrmDcIR+vhQBD0tkSHTvPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793171965;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=iDtWAtQ9UJlQ7QtpVTKrQvbSoxBnQV9Ww8wHGNhN9T8=;
	b=PkNs7F5FN8s1n1FLJ/r4mM6u7+mXmCWLDKX/olNdyhkBam/Uu4/1z5vVTBjy/AVFszin
	 UDg9fW8EpQ1wvsTHnG8aYJOkVW5yOGrJTwxI/UW43PlKhlulF4CUnrJ5nNwkZb208Zhed
	 w/YpjLNXmaaNXIyPDDSLrxJr107hICA9fPNznfPwxAcqR7sody6xA9WlM5t7dIDfdd8St
	 0tgwRO2O6mg63ZEP6n40oTS7di/afuB+24GbswpqnQ9GkEzd8V166bu3LUhC7rF90lts9
	 hyjZ/YDWLViQVf4VABZ/IRrsNOZZpr3n49cDl8Sh/vBEqHtJOT67xVrDXylFd5f/lLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b="fN/AGw7m";
	arc=none smtp.remote-ip=115.124.30.119
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71E1606A31D
	for <iommu@lists.linux.dev>; Wed, 28 Oct 2026 07:19:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C71E1606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=fN/AGw7m
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793171961; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=iDtWAtQ9UJlQ7QtpVTKrQvbSoxBnQV9Ww8wHGNhN9T8=;
	b=fN/AGw7m+Gak/s2hDQ4obVr6PC8SfxS3XwUCn8AM+bi2N9PnT4qLSmsZDPAwL7P9gtgVkf3PVQld1YQmtyxjalGhMXZCix7OHA8dKaWaciEgDjJWd7V1t/fno/OajzAWXb07ZNk+cUJolUGCMJqDHyWs7fgesdyMf/bHWbZmWxs=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0XDg7jlL_1793171960;
Received: from VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0XDg7jlL_1793171960 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 28 Oct 2026 15:19:20 +0800
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
Subject: [PATCH v5 2/3] iommufd: Add IOMMU_GET_RECOMMENDED_RESERVATIONS ioctl
Date: Wed, 28 Oct 2026 15:19:05 +0800
Message-ID: <20261028071906.2325378-3-guanghuifeng@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261028071906.2325378-1-guanghuifeng@linux.alibaba.com>
References: <20261027183418.GJ1685504@ziepe.ca>
 <20261028071906.2325378-1-guanghuifeng@linux.alibaba.com>
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

Add a per-device query ioctl that reports the IOVA ranges the kernel
recommends reserving for a given device.  For PCI devices these are
the MMIO windows of the host bridge the device sits behind: DMA using
IOVAs inside those windows could be misrouted as peer-to-peer traffic
by a PCIe switch instead of reaching the root complex for IOMMU
translation.

The interface is advisory, and deliberately named after the general
concept of recommended reserved regions rather than its first source:
the kernel reports recommendations and userspace decides whether to
act on them, either by feeding them back through
IOMMU_IOAS_RESERVE_IOVAS or by avoiding the ranges in its own IOVA
allocation.  This follows the principle that PCI window information
should not be forced onto userspace through the IOMMU reserved-region
API, as established when the earlier attempt was reverted in commit
cd2c9fcf5c66 ("iommu/dma: Move PCI window region reservation back into dma specific path.")

The output reuses struct iommu_iova_range and follows the array +
count + EMSGSIZE protocol established by IOMMU_IOAS_IOVA_RANGES.
Per-device granularity is chosen because the recommendations derive
from the device's bus topology and are available immediately after
VFIO_DEVICE_BIND_IOMMUFD, before any IOAS attachment.

Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
---
 drivers/iommu/iommufd/device.c          | 65 +++++++++++++++++++++++++
 drivers/iommu/iommufd/iommufd_private.h |  1 +
 drivers/iommu/iommufd/main.c            |  4 ++
 include/uapi/linux/iommufd.h            | 38 +++++++++++++++
 4 files changed, 108 insertions(+)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 1b0bdf57ac8a..eedda48012a1 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -1749,3 +1749,68 @@ int iommufd_get_hw_info(struct iommufd_ucmd *ucmd)
 	iommufd_put_object(ucmd->ictx, &idev->obj);
 	return rc;
 }
+
+struct recommended_resv_ctx {
+	struct iommu_iova_range __user *out_ranges;
+	u32 max_ranges;
+	u32 num_ranges;
+};
+
+static int recommended_resv_window_fn(phys_addr_t start, phys_addr_t end,
+				      void *data)
+{
+	struct recommended_resv_ctx *ctx = data;
+
+	if (ctx->num_ranges < ctx->max_ranges) {
+		struct iommu_iova_range elm = {
+			.start = start,
+			.last = end,
+		};
+
+		if (copy_to_user(&ctx->out_ranges[ctx->num_ranges], &elm,
+				 sizeof(elm)))
+			return -EFAULT;
+	}
+	ctx->num_ranges++;
+	return 0;
+}
+
+int iommufd_device_get_recommended_reservations(struct iommufd_ucmd *ucmd)
+{
+	struct iommu_recommended_reservations *cmd = ucmd->cmd;
+	struct recommended_resv_ctx ctx;
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
+	ctx.out_ranges = u64_to_user_ptr(cmd->out_ranges);
+	ctx.max_ranges = cmd->num_ranges;
+	ctx.num_ranges = 0;
+
+	rc = iommu_for_each_pci_mmio_window(to_pci_dev(idev->dev),
+					    recommended_resv_window_fn, &ctx);
+	if (rc)
+		goto out_put;
+
+	cmd->num_ranges = ctx.num_ranges;
+	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
+	if (rc)
+		goto out_put;
+	if (ctx.num_ranges > ctx.max_ranges)
+		rc = -EMSGSIZE;
+
+out_put:
+	iommufd_put_object(ucmd->ictx, &idev->obj);
+	return rc;
+}
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index eb2e85b27e42..8016c3efca78 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -534,6 +534,7 @@ iommufd_device_get_iommu_dev(struct iommufd_device *idev)
 
 void iommufd_device_pre_destroy(struct iommufd_object *obj);
 void iommufd_device_destroy(struct iommufd_object *obj);
+int iommufd_device_get_recommended_reservations(struct iommufd_ucmd *ucmd);
 int iommufd_get_hw_info(struct iommufd_ucmd *ucmd);
 
 struct device *iommufd_global_device(void);
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 9a921b153162..85f8ea154218 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -449,6 +449,7 @@ union ucmd_buffer {
 	struct iommu_ioas_map map;
 	struct iommu_ioas_unmap unmap;
 	struct iommu_option option;
+	struct iommu_recommended_reservations recommended_reservations;
 	struct iommu_vdevice_alloc vdev;
 	struct iommu_veventq_alloc veventq;
 	struct iommu_vfio_ioas vfio_ioas;
@@ -480,6 +481,9 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
 		 struct iommu_fault_alloc, out_fault_fd),
 	IOCTL_OP(IOMMU_GET_HW_INFO, iommufd_get_hw_info, struct iommu_hw_info,
 		 __reserved),
+	IOCTL_OP(IOMMU_GET_RECOMMENDED_RESERVATIONS,
+		 iommufd_device_get_recommended_reservations,
+		 struct iommu_recommended_reservations, out_ranges),
 	IOCTL_OP(IOMMU_HW_QUEUE_ALLOC, iommufd_hw_queue_alloc_ioctl,
 		 struct iommu_hw_queue_alloc, length),
 	IOCTL_OP(IOMMU_HWPT_ALLOC, iommufd_hwpt_alloc, struct iommu_hwpt_alloc,
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 010f47f7d3d2..45ba7bd7abd5 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -58,6 +58,7 @@ enum {
 	IOMMUFD_CMD_VEVENTQ_ALLOC = 0x93,
 	IOMMUFD_CMD_HW_QUEUE_ALLOC = 0x94,
 	IOMMUFD_CMD_IOAS_NOIOMMU_GET_PA = 0x95,
+	IOMMUFD_CMD_GET_RECOMMENDED_RESERVATIONS = 0x96,
 };
 
 /**
@@ -1398,4 +1399,41 @@ struct iommu_hw_queue_alloc {
 	__aligned_u64 length;
 };
 #define IOMMU_HW_QUEUE_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_HW_QUEUE_ALLOC)
+
+/**
+ * struct iommu_recommended_reservations - ioctl(IOMMU_GET_RECOMMENDED_RESERVATIONS)
+ * @size: sizeof(struct iommu_recommended_reservations)
+ * @flags: Must be 0
+ * @dev_id: The device bound to iommufd to query
+ * @num_ranges: Input/output number of recommended ranges
+ * @out_ranges: Pointer to the output array of struct iommu_iova_range
+ *
+ * Query the IOVA ranges the kernel recommends reserving for @dev_id.
+ * For a PCI device these are the MMIO windows of its host bridge,
+ * where a PCIe switch could misroute DMA as peer-to-peer traffic.
+ * Advisory only: userspace may feed the ranges back through
+ * IOMMU_IOAS_RESERVE_IOVAS or handle them itself.
+ *
+ * Ranges are reported in resource order, not guaranteed sorted, and
+ * should be treated as a set.  Query each device and take the union
+ * when multiple devices are in use.
+ *
+ * On input num_ranges is the length of the out_ranges array.  On
+ * output it is the total number of ranges.  The ioctl will return
+ * -EMSGSIZE and set num_ranges to the required value if num_ranges is
+ * too small.
+ *
+ * Return: 0 on success, -EOPNOTSUPP if the device has no
+ * recommendations, -ENOENT if @dev_id is invalid, -EMSGSIZE if the
+ * output array is too small.
+ */
+struct iommu_recommended_reservations {
+	__u32 size;
+	__u32 flags;
+	__u32 dev_id;
+	__u32 num_ranges;
+	__aligned_u64 out_ranges;
+};
+#define IOMMU_GET_RECOMMENDED_RESERVATIONS \
+	_IO(IOMMUFD_TYPE, IOMMUFD_CMD_GET_RECOMMENDED_RESERVATIONS)
 #endif
-- 
2.43.7

