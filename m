Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08D137B03C
	for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 02:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783994600; cv=none; b=ftP2WLY0zXosedIJbNMH+YOVgF+CDcEV8lPxRgS/hT6p5fAx7sfNvU7vWl4DUrE73sdKboWNwdfWrN1ddVXdVfRtpq9aFtdKQWWUt8w0ruRYJEDKkdY8pN4X8SKsYZp7h56GTYIlFMFYTjqeOdErjkCTiG0F3J3//ZcsBe/3Y6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783994600; c=relaxed/simple;
	bh=F/dkUauOyGpoEe18K/1eGkOgm1xHJJZXLEkrWNpcWMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OUOIjRM4KDcSnUUnMPoFyZON2nJ25eoxQGxFWPVJXNihMpt1ixIZ36BJ6ptedq1uB+z9dhUkraKwnzq11oM/QJYKb+6ZDRpR1OfgOAJYc4coptd632PYfHcmpCs6Uvw2Svw8ARn4oME9BLF9KnHU2O6O2XeAlJjmq/AjJZfwHsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Q8hQ0poO; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Q8hQ0poO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=A5
	aMnFNkUrpPv50lSdrPDKTy96S9FQDuMfU2uCS37JE=; b=Q8hQ0poO8I7JV0xdKy
	U2DVe5QKot0/Z8j8YzwuiLGNHtfYiCV7JLL3IP22W0+5A8CG+wt3NkrAMQefnzvq
	XE0Asb6B5MpLXEvMDSoX7Pf9Ww56N2dUrwSeBoI5VxeUgOnHIiuv0CHihsFzCWrQ
	k6zpRynRQwxZqICabfSUzxAvc=
Received: from xwm-TianYi510Pro-14IMB.. (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgCX1fPLmFVqoFhHGg--.38350S2;
	Tue, 14 Jul 2026 10:02:51 +0800 (CST)
From: weimin xiong <15927021679@163.com>
To: iommu@lists.linux.dev
Cc: baolu.lu@linux.intel.com,
	jean-philippe@linaro.org,
	jgg@nvidia.com,
	xiongweimin <xiongweimin@kylinos.cn>
Subject: [PATCH v2] iommu/virtio: Report faults via report_iommu_fault()
Date: Tue, 14 Jul 2026 10:02:51 +0800
Message-ID: <20260714020251.175824-1-15927021679@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260713010442.331096-1-15927021679@163.com>
References: <20260713010442.331096-1-15927021679@163.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgCX1fPLmFVqoFhHGg--.38350S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3AryxCw1DAF1xJFWxGr4UArb_yoW7GFW7pF
	Z5Cay5KrW7Xr1IgF43Jw4Uur1Fva1vqF47Wr15Kw4q9r13Kryrta18Cryrtw4fCFZrC3W7
	t3WDKa9ruF4UCaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jn6pPUUUUU=
X-CM-SenderInfo: jprvmjixqsilmxzbiqqrwthudrp/xtbC8wtI0GpVmMucYgAA3y

From: xiongweimin <xiongweimin@kylinos.cn>

Fault events currently only print a ratelimited error with the endpoint
ID. Drivers that registered a domain fault handler with
iommu_set_fault_handler() cannot react.

Track endpoints in an xarray keyed by endpoint ID at probe/release time,
and call report_iommu_fault() when a fault carries an address and the
endpoint is attached to a domain. Keep the existing log as a fallback
when the endpoint is unknown, detached, or no handler is installed
(report_iommu_fault() returns -ENOSYS).

This completes the TODO in viommu_fault_handler() and matches other
IOMMU drivers. It is not the VFIO/IOMMUFD IOPF path
(iommu_report_device_fault()); it covers DMA protection faults for
virtio endpoints.

Signed-off-by: xiongweimin <xiongweimin@kylinos.cn>
---
 drivers/iommu/virtio-iommu.c | 52 ++++++++++++++++++++++++++++++++----
 1 file changed, 47 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 587fc1319..3a46d97f2 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -19,6 +19,7 @@
 #include <linux/virtio_config.h>
 #include <linux/virtio_ids.h>
 #include <linux/wait.h>
+#include <linux/xarray.h>
 
 #include <uapi/linux/virtio_iommu.h>
 
@@ -42,6 +43,8 @@ struct viommu_dev {
 	spinlock_t			request_lock;
 	struct list_head		requests;
 	void				*evts;
+	/* endpoint ID -> viommu_endpoint, for fault reporting */
+	struct xarray			endpoints;
 
 	/* Device configuration */
 	struct iommu_domain_geometry	geometry;
@@ -593,7 +596,10 @@ static int viommu_probe_endpoint(struct viommu_dev *viommu, struct device *dev)
 static int viommu_fault_handler(struct viommu_dev *viommu,
 				struct virtio_iommu_fault *fault)
 {
+	struct viommu_endpoint *vdev;
+	struct iommu_domain *domain;
 	char *reason_str;
+	int fault_flags = IOMMU_FAULT_READ;
 
 	u8 reason	= fault->reason;
 	u32 flags	= le32_to_cpu(fault->flags);
@@ -613,16 +619,28 @@ static int viommu_fault_handler(struct viommu_dev *viommu,
 		break;
 	}
 
-	/* TODO: find EP by ID and report_iommu_fault */
-	if (flags & VIRTIO_IOMMU_FAULT_F_ADDRESS)
-		dev_err_ratelimited(viommu->dev, "%s fault from EP %u at %#llx [%s%s%s]\n",
+	if (flags & VIRTIO_IOMMU_FAULT_F_WRITE)
+		fault_flags = IOMMU_FAULT_WRITE;
+
+	rcu_read_lock();
+	vdev = xa_load(&viommu->endpoints, endpoint);
+	if (vdev && vdev->vdomain && (flags & VIRTIO_IOMMU_FAULT_F_ADDRESS)) {
+		domain = &vdev->vdomain->domain;
+		report_iommu_fault(domain, vdev->dev, address, fault_flags);
+		rcu_read_unlock();
+	} else if (flags & VIRTIO_IOMMU_FAULT_F_ADDRESS) {
+		rcu_read_unlock();
+		dev_err_ratelimited(viommu->dev,
+				    "%s fault from EP %u at %#llx [%s%s%s]\n",
 				    reason_str, endpoint, address,
 				    flags & VIRTIO_IOMMU_FAULT_F_READ ? "R" : "",
 				    flags & VIRTIO_IOMMU_FAULT_F_WRITE ? "W" : "",
 				    flags & VIRTIO_IOMMU_FAULT_F_EXEC ? "X" : "");
-	else
+	} else {
+		rcu_read_unlock();
 		dev_err_ratelimited(viommu->dev, "%s fault from EP %u\n",
 				    reason_str, endpoint);
+	}
 	return 0;
 }
 
@@ -1037,15 +1055,33 @@ static struct iommu_device *viommu_probe_device(struct device *dev)
 	INIT_LIST_HEAD(&vdev->resv_regions);
 	dev_iommu_priv_set(dev, vdev);
 
+	for (ret = 0; ret < fwspec->num_ids; ret++) {
+		int err = xa_insert(&viommu->endpoints, fwspec->ids[ret], vdev,
+				   GFP_KERNEL);
+		if (err) {
+			while (ret--)
+				xa_erase(&viommu->endpoints, fwspec->ids[ret]);
+			ret = err;
+			goto err_free_dev;
+		}
+	}
+
 	if (viommu->probe_size) {
 		/* Get additional information for this endpoint */
 		ret = viommu_probe_endpoint(viommu, dev);
 		if (ret)
-			goto err_free_dev;
+			goto err_unreg;
 	}
 
 	return &viommu->iommu;
 
+err_unreg:
+	{
+		int i;
+
+		for (i = 0; i < fwspec->num_ids; i++)
+			xa_erase(&viommu->endpoints, fwspec->ids[i]);
+	}
 err_free_dev:
 	iommu_put_resv_regions(dev, &vdev->resv_regions);
 	kfree(vdev);
@@ -1056,8 +1092,12 @@ static struct iommu_device *viommu_probe_device(struct device *dev)
 static void viommu_release_device(struct device *dev)
 {
 	struct viommu_endpoint *vdev = dev_iommu_priv_get(dev);
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	int i;
 
 	viommu_detach_dev(vdev);
+	for (i = 0; i < fwspec->num_ids; i++)
+		xa_erase(&vdev->viommu->endpoints, fwspec->ids[i]);
 	iommu_put_resv_regions(dev, &vdev->resv_regions);
 	kfree(vdev);
 }
@@ -1167,6 +1207,7 @@ static int viommu_probe(struct virtio_device *vdev)
 
 	spin_lock_init(&viommu->request_lock);
 	ida_init(&viommu->domain_ids);
+	xa_init(&viommu->endpoints);
 	viommu->dev = dev;
 	viommu->vdev = vdev;
 	INIT_LIST_HEAD(&viommu->requests);
@@ -1261,6 +1302,7 @@ static void viommu_remove(struct virtio_device *vdev)
 	virtio_reset_device(vdev);
 	vdev->config->del_vqs(vdev);
 
+	xa_destroy(&viommu->endpoints);
 	dev_info(&vdev->dev, "device removed\n");
 }
 
-- 
2.43.0


No virus found
		Checked by Hillstone Network AntiVirus

