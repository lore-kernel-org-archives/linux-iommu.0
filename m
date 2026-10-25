Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792894796;
	b=RtEeKnKq4Mlt3zTkCI4szfokNjh0aXKx9o6lNLIt+2lMRW3GqKpdLW3E4kX8iaVqAWsX
	 i2Z0jgDoS7FIlrcuEKpJ4skTGTidARV69++b28pOqG5TYmNrS6z5cKMOUVL86eMwyDHU8
	 8UmK3fuGtqsKtWlDILD1BVL9gg11H7gSRKdfARqpZEXB4g1UTGCos8ZVJK43qn4ZqRiPD
	 rH/C3kixDZzWVAH9BFlPtLDkkFLMKKr2NxDfuvib04AijdQWGpidkmHGPguGzP4buIgtL
	 Kf4gPNbuTVeEN7jimaBpcKXRBfil6fmuvgZwBV9Z5ByKZzhjAWt/8iVmXK0iF9ufoEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792894796;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=RisrFF04hwyIe3tAIC+08Z8PAu7uAcFhadSZbUURClU=;
	b=Z1FCGKuumefVj7VI5dY7PqNraCuarTg78T1LGzEMiMEQVcYWNY5TX+soAy0Jt8XEOPtn
	 MeaKFUAYe4HT1kEmjWWL5clbesR7duJkQp2Nzmky0fpv1ggo0EU/OshzxbsU9dDd5Cy/i
	 ow8IAhdkwfQZVgKJVmZAUQcJesqNlizvjInQ+GUbfpM4jwj/S+mG2us38Z3UMBgqBYouv
	 jz1fvLehlnYrv8juGPYhFFNpeHCyZogzKVRQ1Yj0lCN0Fl9XAqGcxSjYlcRbQPF+tvSBP
	 8g2JZmB+pzfaqZd7GygRdyT9IGdTrAxOvvs5UdiR9ec00aVUXdlcKmnmwOrUOhQIaXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=qric1QOG;
	arc=none smtp.remote-ip=209.85.214.197
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748C2606D6B3
	for <iommu@lists.linux.dev>; Sun, 25 Oct 2026 02:19:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 748C2606D6B3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=qric1QOG
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2e61a48d5b7so20833875ad.1
        for <iommu@lists.linux.dev>; Sat, 24 Oct 2026 19:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792894796; x=1793499596; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RisrFF04hwyIe3tAIC+08Z8PAu7uAcFhadSZbUURClU=;
        b=qric1QOGMJ9ocQA/A7i0mp+XkLr88M0/uDQZUQUok1JuJpKmdY/jcocA+thUCe+t6o
         koC1myzanzRVXB6+b6B449/aRg0CJIT3Wk795j6IXSOnSDuvlftPzDR9RqFepdEZh9ag
         zFcm1UEDyaUscw1Kf5GqPEUqWGRJQioMqaSOvIgC8Nwfm1dE+xpQShwKCwLbUwXFs7Bf
         YaNKorX2YwV20wh1TGX3WrdhZOF7eUSbVNnZBgTsYePYS8DOUORTpM1r8WZE8b4z8l1Z
         ZFO13ns1ZMTDnncAB/O4gqOIQ15YDpL5FlEOw7EnSOsr6wAelcUVwiF5cNeorl1XJMXw
         puvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792894796; x=1793499596;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RisrFF04hwyIe3tAIC+08Z8PAu7uAcFhadSZbUURClU=;
        b=UuUzzPE2gr6oHg2LNXOZT37c/c3jhOZ7+1Rfdld6E6AFHu49h4sPUrSQs1Jiixr1X4
         sN4HPhMp01p2CsFQJ335lFMb2y4Ykv4GRecDr8ouoFdc7xKKU0ZCa7jZcfKKTRKVYHp7
         hYZvh568FTdFKj2vcZsmUKJImSYZJK4Gp/hczHkvgRQcrjCbsxZ2MOplP1dwTsv10Vm0
         9mytVBahFr3dPIrYGF/YA/ob2IE51rxKHOJWgTG9NUDJ++Te6IrrmqyX9Ju8mw249GdP
         yQUuW9UP0Rlz5TxxxGVLWz2DOmcy5zvCBLX4eZKbPr90Fq7RMDo9MW/efdg7NedEbpz7
         P03A==
X-Forwarded-Encrypted: i=1; AKwUvBytAEL0SkLE7S+9m8x0ggc/1gx4F+uFx82bfAEWpQ6IFhSNTgaFjrK5hscXbDl3WAqdIK9MQw==@lists.linux.dev
X-Gm-Message-State: AFq9FYKfYe6qdHRvcqSA5FR1wUeJwGkZmAkYkzjNgc544HizIQyX8C4y
	l2Hu0tBRFaXoxjkW3HPFJ1HX+NAl12y/9EW1CgxWOwyzX5BqddVVBHjo7ZslqJpI/z6va8dK5Cg
	CFnCKKIYbQgAArw==
X-Received: from plge11.prod.google.com ([2002:a17:902:cf4b:b0:2ea:775d:de30])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:c949:b0:2e9:569a:214d with SMTP id d9443c01a7336-2ea9cc866e0mr18938485ad.43.1792894795505;
 Sat, 24 Oct 2026 19:19:55 -0700 (PDT)
Date: Sun, 25 Oct 2026 02:19:27 +0000
In-Reply-To: <20261025021930.674647-1-skhawaja@google.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261025021930.674647-1-skhawaja@google.com>
X-Mailer: git-send-email 2.56.0.257.gf7497c7d27-goog
Message-ID: <20261025021930.674647-17-skhawaja@google.com>
Subject: [PATCH v6 16/18] iommufd: Add APIs to preserve/unpreserve a vfio cdev
From: Samiullah Khawaja <skhawaja@google.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	David Woodhouse <dwmw2@infradead.org>
Cc: Samiullah Khawaja <skhawaja@google.com>, Pranjal Shrivastava <praan@google.com>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vipin Sharma <vipinsh@google.com>, Ankit Soni <Ankit.Soni@amd.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, John Starks <dev@jstarks.net>
Content-Type: text/plain; charset="UTF-8"

Add APIs that can be used to preserve and unpreserve a vfio cdev. Use
the APIs exported by the IOMMU core to preserve/unpreserve device.

The LUO token of the preserved iommufd is fetched and returned back to
the caller as that can be used during restore to get the restored
iommufd.

Reviewed-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/iommu/iommufd/device.c          | 156 ++++++++++++++++++++++++
 drivers/iommu/iommufd/iommufd_private.h |   6 +
 include/linux/iommufd.h                 |  29 +++++
 3 files changed, 191 insertions(+)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index a664c70a6fe7..c8ea2e288240 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -2,6 +2,7 @@
 /* Copyright (c) 2021-2022, NVIDIA CORPORATION & AFFILIATES
  */
 #include <linux/iommu.h>
+#include <linux/iommu-liveupdate.h>
 #include <linux/iommufd.h>
 #include <linux/pci-ats.h>
 #include <linux/slab.h>
@@ -686,6 +687,10 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 	int rc;
 
 	mutex_lock(&igroup->lock);
+	if (iommufd_device_is_preserved(idev)) {
+		rc = -EBUSY;
+		goto err_unlock;
+	}
 
 	attach = xa_cmpxchg(&igroup->pasid_attach, pasid, NULL,
 			    XA_ZERO_ENTRY, GFP_KERNEL);
@@ -868,6 +873,10 @@ iommufd_device_do_replace(struct iommufd_device *idev, ioasid_t pasid,
 	int rc;
 
 	mutex_lock(&igroup->lock);
+	if (iommufd_device_is_preserved(idev)) {
+		rc = -EBUSY;
+		goto err_unlock;
+	}
 
 	attach = xa_load(&igroup->pasid_attach, pasid);
 	if (!attach) {
@@ -1747,3 +1756,150 @@ int iommufd_get_hw_info(struct iommufd_ucmd *ucmd)
 	iommufd_put_object(ucmd->ictx, &idev->obj);
 	return rc;
 }
+
+#ifdef CONFIG_IOMMU_LIVEUPDATE
+static bool _iommufd_device_has_pasid_attachments(struct iommufd_device *idev)
+{
+	struct iommufd_group *igroup = idev->igroup;
+	unsigned long start = IOMMU_NO_PASID;
+
+	if (xa_find_after(&igroup->pasid_attach, &start, UINT_MAX, XA_PRESENT))
+		return true;
+
+	return false;
+}
+
+/**
+ * iommufd_device_preserve() - Preserve an iommufd device across live update
+ * @s: Live update session
+ * @idev: Target iommufd device
+ * @iommufd_tokenp: Pointer to store outgoing iommufd token
+ *
+ * Return: 0 on success, or negative error code.
+ */
+int iommufd_device_preserve(struct liveupdate_session *s,
+			    struct iommufd_device *idev,
+			    u64 *iommufd_tokenp)
+{
+	struct iommufd_hwpt_paging *hwpt_paging;
+	struct iommufd_hw_pagetable *hwpt;
+	struct iommufd_attach *attach;
+	struct iommufd_group *igroup;
+	int ret;
+
+	if (!idev)
+		return -EINVAL;
+
+	if (iommufd_device_is_noiommu(idev))
+		return -EOPNOTSUPP;
+
+	igroup = idev->igroup;
+	mutex_lock(&igroup->lock);
+	if (idev->liveupdate_preserved) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	if (_iommufd_device_has_pasid_attachments(idev)) {
+		ret = -EOPNOTSUPP;
+		goto out;
+	}
+
+	attach = xa_load(&igroup->pasid_attach, IOMMU_NO_PASID);
+	if (!attach) {
+		ret = -ENOENT;
+		goto out;
+	}
+
+	if (!xa_load(&attach->device_array, idev->obj.id)) {
+		ret = -ENOENT;
+		goto out;
+	}
+
+	hwpt = attach->hwpt;
+	if (!hwpt_is_paging(hwpt)) {
+		ret = -EOPNOTSUPP;
+		goto out;
+	}
+
+	hwpt_paging = to_hwpt_paging(hwpt);
+	ret = liveupdate_get_token_outgoing(s, idev->ictx->file, iommufd_tokenp);
+	if (ret)
+		goto out;
+
+	if (!hwpt_paging->liveupdate_preserved) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = iommu_preserve_device(hwpt_paging->common.domain,
+				    idev->dev,
+				    *iommufd_tokenp);
+
+	if (!ret) {
+		igroup->num_liveupdate_preserved++;
+		idev->liveupdate_preserved = true;
+	}
+out:
+	mutex_unlock(&igroup->lock);
+	return ret;
+}
+EXPORT_SYMBOL_NS_GPL(iommufd_device_preserve, "IOMMUFD");
+
+/**
+ * iommufd_device_unpreserve() - Unpreserve an iommufd device
+ * @s: Live update session
+ * @idev: Target iommufd device
+ */
+void iommufd_device_unpreserve(struct liveupdate_session *s,
+			       struct iommufd_device *idev)
+{
+	struct iommufd_hwpt_paging *hwpt_paging;
+	struct iommufd_hw_pagetable *hwpt;
+	struct iommufd_attach *attach;
+	struct iommufd_group *igroup;
+
+	if (!idev)
+		return;
+
+	igroup = idev->igroup;
+	mutex_lock(&igroup->lock);
+	if (!idev->liveupdate_preserved)
+		goto out;
+
+	attach = xa_load(&igroup->pasid_attach, IOMMU_NO_PASID);
+	if (!attach) {
+		WARN(1, "IOMMU_NO_PASID attachment not found");
+		goto out;
+	}
+
+	hwpt = attach->hwpt;
+	if (WARN(!hwpt_is_paging(hwpt), "Attached HWPT is not a paging HWPT"))
+		goto out;
+
+	hwpt_paging = to_hwpt_paging(hwpt);
+	if (!hwpt_paging->liveupdate_preserved) {
+		WARN(1, "Attached domain is not preserved");
+		goto out;
+	}
+
+	iommu_unpreserve_device(hwpt_paging->common.domain, idev->dev);
+	igroup->num_liveupdate_preserved--;
+	idev->liveupdate_preserved = false;
+out:
+	mutex_unlock(&igroup->lock);
+}
+EXPORT_SYMBOL_NS_GPL(iommufd_device_unpreserve, "IOMMUFD");
+
+/**
+ * iommufd_device_is_preserved() - Check if an iommufd device is preserved
+ * @idev: Target iommufd device
+ *
+ * Return: true if preserved, false otherwise.
+ */
+bool iommufd_device_is_preserved(struct iommufd_device *idev)
+{
+	return idev && idev->igroup && idev->igroup->num_liveupdate_preserved;
+}
+EXPORT_SYMBOL_NS_GPL(iommufd_device_is_preserved, "IOMMUFD");
+#endif
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 69d902b69b82..4760fffd2512 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -507,6 +507,9 @@ struct iommufd_group {
 	struct xarray pasid_attach;
 	struct iommufd_sw_msi_maps required_sw_msi;
 	phys_addr_t sw_msi_start;
+#ifdef CONFIG_IOMMU_LIVEUPDATE
+	int num_liveupdate_preserved;
+#endif
 };
 
 /*
@@ -524,6 +527,9 @@ struct iommufd_device {
 	bool enforce_cache_coherency;
 	struct iommufd_vdevice *vdev;
 	bool destroying;
+#ifdef CONFIG_IOMMU_LIVEUPDATE
+	bool liveupdate_preserved;
+#endif
 };
 
 static inline struct iommufd_device *
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 6e7efe83bc5d..80382aceca18 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -9,6 +9,7 @@
 #include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/iommu.h>
+#include <linux/liveupdate.h>
 #include <linux/refcount.h>
 #include <linux/types.h>
 #include <linux/xarray.h>
@@ -213,6 +214,15 @@ int iommufd_access_rw(struct iommufd_access *access, unsigned long iova,
 int iommufd_vfio_compat_ioas_get_id(struct iommufd_ctx *ictx, u32 *out_ioas_id);
 int iommufd_vfio_compat_ioas_create(struct iommufd_ctx *ictx);
 int iommufd_vfio_compat_set_no_iommu(struct iommufd_ctx *ictx);
+
+#ifdef CONFIG_IOMMU_LIVEUPDATE
+int iommufd_device_preserve(struct liveupdate_session *s,
+			    struct iommufd_device *idev,
+			    u64 *iommufd_tokenp);
+void iommufd_device_unpreserve(struct liveupdate_session *s,
+			       struct iommufd_device *idev);
+bool iommufd_device_is_preserved(struct iommufd_device *idev);
+#endif
 #else /* !CONFIG_IOMMUFD */
 static inline struct iommufd_ctx *iommufd_ctx_from_file(struct file *file)
 {
@@ -397,4 +407,23 @@ static inline void iommufd_viommu_destroy_mmap(struct iommufd_viommu *viommu,
 {
 	_iommufd_destroy_mmap(viommu->ictx, &viommu->obj, offset);
 }
+
+#if !IS_ENABLED(CONFIG_IOMMU_LIVEUPDATE) || !IS_ENABLED(CONFIG_IOMMUFD)
+static inline int iommufd_device_preserve(struct liveupdate_session *s,
+					  struct iommufd_device *idev,
+					  u64 *iommufd_tokenp)
+{
+	return 0;
+}
+
+static inline void iommufd_device_unpreserve(struct liveupdate_session *s,
+					     struct iommufd_device *idev)
+{
+}
+
+static inline bool iommufd_device_is_preserved(struct iommufd_device *idev)
+{
+	return false;
+}
+#endif
 #endif
-- 
2.56.0.257.gf7497c7d27-goog

