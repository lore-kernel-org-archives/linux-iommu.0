Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03DDC8CE
	for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 01:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783904698; cv=none; b=F6xU9O/LgBVag93hQIKja9UgUnyymKbCRt4mTVB7ZpX0t7dMprqdsZo8sq0Zr2h/K1MJptOxAnsZ2oAjBZ4A0rhJNIq/osmFw9ViciVBiW2tklOHaj9vRtT2pd4gt9KN8cUleP9dYUvyF4AHKHVZzp6tiM6nanIDH5w2+S8y/gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783904698; c=relaxed/simple;
	bh=ppun8nqo7cXX0LJ/7mtBxlY8dQKXgxMxv1+dOvjWGGc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iLV5Pant7/i+9fQaceVm2v8cX8e7eaIRucEOiLrzigebYaZYK6vy5TsVK2sS9FDH81EmDAtfVA6/PEI1xccJc749uoqJp9qfwwev7yEpMT9DxZfO9ZVGwuUbnA2ljkDi3LsBOjWiCkhy4VgpZ2X50kGe1QFjSlnIKB/z0Uh1FaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=JR3lLhFy; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="JR3lLhFy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Sg
	VH8bmYF1aGyrdOHPoFLi3zsxubb1bjY+v4NGCk0LA=; b=JR3lLhFyJ0vxWy1VAj
	O5QvaLL11BaiWf9//tbMAZgcn6JQuDzqAxzwllWZVkIMCA7lnAyrLqFdSmtwLwE2
	Lx5gHobX/Ltkt4wSDb9hWbIL/V8ciTNyYQMfz7DZlQYYN4BfAcJ1QUf3BFbgAANF
	mA6YvsiS8t77COaihjR/35hDU=
Received: from xwm-TianYi510Pro-14IMB.. (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wCHcrOmOVRqcQjTJQ--.18769S2;
	Mon, 13 Jul 2026 09:04:39 +0800 (CST)
From: weimin xiong <15927021679@163.com>
To: iommu@lists.linux.dev
Cc: jean-philippe@linaro.org,
	jgg@nvidia.com,
	xiongweimin <xiongweimin@kylinos.cn>
Subject: [PATCH] iommu/virtio: Report faults via report_iommu_fault()
Date: Mon, 13 Jul 2026 09:04:42 +0800
Message-ID: <20260713010442.331096-1-15927021679@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCHcrOmOVRqcQjTJQ--.18769S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAr1UCryUuryDAw15Jry5Arb_yoWrWw4fpF
	Z5Ga93trsrXrn2ga17Jw4Uur10van0vF47Wr15KF4DCry3Grn5ta18CryFvws7CFZFv3W7
	t3WkC3ZF9F4UuaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UMlk3UUUUU=
X-CM-SenderInfo: jprvmjixqsilmxzbiqqrwthudrp/xtbC0Qcnr2pUOad3kAAA3Z

From: xiongweimin <xiongweimin@kylinos.cn>

Fault events currently only print a ratelimited error with the endpoint
ID. Upper layers (VFIO, drivers with domain fault handlers) cannot react.

Track endpoints in an xarray keyed by endpoint ID at probe/release time,
and call report_iommu_fault() when a fault carries an address and the
endpoint is attached to a domain. Keep the existing log as a fallback
when the endpoint is unknown or detached.

Signed-off-by: xiongweimin <xiongweimin@kylinos.cn>
Cc: iommu@lists.linux.dev
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>
---

--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -19,6 +19,7 @@
 #include <linux/virtio_config.h>
 #include <linux/virtio_ids.h>
 #include <linux/wait.h>
+#include <linux/xarray.h>
 
 #include <uapi/linux/virtio_iommu.h>
 
@@ -42,6 +43,8 @@
 	spinlock_t			request_lock;
 	struct list_head		requests;
 	void				*evts;
+	/* endpoint ID -> viommu_endpoint, for fault reporting */
+	struct xarray			endpoints;
 
 	/* Device configuration */
 	struct iommu_domain_geometry	geometry;
@@ -593,7 +596,10 @@
 static int viommu_fault_handler(struct viommu_dev *viommu,
 				struct virtio_iommu_fault *fault)
 {
+	struct viommu_endpoint *vdev;
+	struct iommu_domain *domain;
 	char *reason_str;
+	int fault_flags = IOMMU_FAULT_READ;
 
 	u8 reason	= fault->reason;
 	u32 flags	= le32_to_cpu(fault->flags);
@@ -613,16 +619,28 @@
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
 
@@ -1037,15 +1055,33 @@
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
@@ -1056,8 +1092,12 @@
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
@@ -1167,6 +1207,7 @@
 
 	spin_lock_init(&viommu->request_lock);
 	ida_init(&viommu->domain_ids);
+	xa_init(&viommu->endpoints);
 	viommu->dev = dev;
 	viommu->vdev = vdev;
 	INIT_LIST_HEAD(&viommu->requests);
@@ -1261,6 +1302,7 @@
 	virtio_reset_device(vdev);
 	vdev->config->del_vqs(vdev);
 
+	xa_destroy(&viommu->endpoints);
 	dev_info(&vdev->dev, "device removed\n");
 }
 

