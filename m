Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795409407;
	b=s80zqhpQAmliRKsQebJ97MdkehKTPA1LZjF9E2feEowuRWdVXrRKAVJUUJd6DFsne/Gv
	 eIHT33WTBEy4+oty3L9DpM0ymQzr0QJpE0pEc88uIJjccQK8RsdqlWdpSA7vFssiXyIRd
	 1d7heGR7yAgqGTU+pDHXt39eUm9akfo/RxZm+1Ai4Kgd8/b3oPRBFQRogUnDc7Otqg/Rw
	 H/kObz1o1XR0PO3dF/VRZYSBlsSZ24Zs6Y+NaRbLFn6mElaYoiy+DEhTz2VD5dxfxMSMK
	 tSHaqDc4EJ4RDqO21Z/b4lydZcoY2k9l/GIcx0hoylDBlQwq/vXHaXPPeiQn+OCZJHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795409407;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=XelVmczJyRiEtn59XFj8dUf2SH6q40PfnZHB1W2yI6E=;
	b=u2gMWR9sdjy8/PR9F4D7OmVZ2AgSa5bfMqfp6OWZxi2rbyRz6kGSv8/98rie4v5bc2Ni
	 DwL5gtDeBlPc64w7bOf1Eh5UcmH1zE9W+g2NLojLJi5DZRglymT9vX3vbOd31Nmgxg+pV
	 y0wp1iZShbFFqFvyxALgrYb9EWIpMlA/YU7NWH7k/+R22YNDiUqyjXrvEgFYCa21VHPb7
	 t5BHZ42rno6oAtdyf5+EzYQ0xvr0Db7xpNJZQQMPKSDBA1iVm+ygmIM9cVs1xd0laIIrS
	 UWjqxiR4eBNXRaXB4GyfYlQYjQes8nnPwDywjaGBpHz3gKDmPiMB/prY1MV76iUeRTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=EjWxaTNt;
	arc=none smtp.remote-ip=209.85.214.197
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651AC606C5F5
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 04:50:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 651AC606C5F5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=EjWxaTNt
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ed08904845so41179035ad.3
        for <iommu@lists.linux.dev>; Sun, 22 Nov 2026 20:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795409406; x=1796014206; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XelVmczJyRiEtn59XFj8dUf2SH6q40PfnZHB1W2yI6E=;
        b=EjWxaTNtzsOidlq93MpOhVy/5pZheVt5MskQB07t7MvqaX0QMTYcIrMQ48MTate/G1
         lxlrDUI/+96bUQNt3Fgmrl7BGl1yXsO/J35UebWArAEt559k+pDLyUJIsOOcYd3/y+gh
         QKUC/WnBz2504KAK68/6ihQAsSxaOX+584yrqFyB375Pw71kTR6BNkO5qdREBPFm0o9M
         oBjRrF/JNWWv92CAsgCrtEj2XxoN9olokt//5+NJTUQ/KQQGDyC2F/VeAwtp6TbsRWGz
         W/3N7eH56YkdALSsSAy3puKZ+txufyDiGItXp96FFyBwYQlpedBjKk5fm7wfv3XAHxXF
         1gxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795409406; x=1796014206;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XelVmczJyRiEtn59XFj8dUf2SH6q40PfnZHB1W2yI6E=;
        b=SFOFMVBJ9gQOSUDr14KmjhMAc7m3Dvp2m32b3dAq+rmRDzERv1Zhp+TREfHsFekgih
         MTBTeco2Td4MhHegDS3ClRLpUg/FultsKrvwOmAVsqaGDDGrXNt+TDz9hC5rZ9XYJ3dx
         jzk5+424zbvCZ/pAeCHeUy57KtQRMfcPYSJ5WmEkpnkpQreIqtr9ecUeRkLndu25d7Mf
         MLbr8lYtjK9bN9FJa2zSU1sIadk6yDMVA6MkLlISTwE8wFLOTA4tTeDeVa/Vf/jiRdcA
         S6gSIF+RvTvim2Fda2Yu58u90yChypWiCggxZFZCADmL1+I+cztI6VSNIJsbsCMgfK3e
         kbpA==
X-Forwarded-Encrypted: i=1; AL+hErFH8ElrZqlqx5sGT0NFXFsC9ikkEEQLrr5Ys3vbfJSShNasLCaKLgN5kGvFVSkoU4mR4VWlcg==@lists.linux.dev
X-Gm-Message-State: APuU4Z+ux0eBjniCzh/J1L0284n5bBk3W8GwHBgbnfuDymeyfcxTCA6v
	ZOO/a256PEXwbTp3jVG6jKQYCOrtIWf16+P6AH42R6OuigzkiF3Dg5mXeZVFZMLr4eHdzsBGjLZ
	yN+9L25Ho7KtrUA==
X-Received: from plhc7.prod.google.com ([2002:a17:903:2347:b0:2f0:4463:7c88])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:17cd:b0:3ab:4f1:4f76 with SMTP id 98e67ed59e1d1-3b41c900b24mr9744653a91.24.1795409405529;
 Sun, 22 Nov 2026 20:50:05 -0800 (PST)
Date: Mon, 23 Nov 2026 04:49:48 +0000
In-Reply-To: <20261123044949.3610702-1-skhawaja@google.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261123044949.3610702-1-skhawaja@google.com>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
Message-ID: <20261123044949.3610702-18-skhawaja@google.com>
Subject: [PATCH v8 17/18] iommufd: Add APIs to preserve/unpreserve a vfio cdev
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

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/iommufd/device.c          | 154 ++++++++++++++++++++++++
 drivers/iommu/iommufd/iommufd_private.h |   3 +
 drivers/iommu/iommufd/liveupdate.c      |  26 ++++
 include/linux/iommufd.h                 |  27 +++++
 4 files changed, 210 insertions(+)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 1b0bdf57ac8a..ebfc96445f71 100644
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
@@ -869,6 +874,10 @@ iommufd_device_do_replace(struct iommufd_device *idev, ioasid_t pasid,
 	int rc;
 
 	mutex_lock(&igroup->lock);
+	if (iommufd_device_is_preserved(idev)) {
+		rc = -EBUSY;
+		goto err_unlock;
+	}
 
 	attach = xa_load(&igroup->pasid_attach, pasid);
 	if (!attach) {
@@ -1135,6 +1144,9 @@ void iommufd_device_detach(struct iommufd_device *idev, ioasid_t pasid)
 {
 	struct iommufd_hw_pagetable *hwpt;
 
+	if (pasid == IOMMU_NO_PASID)
+		iommufd_device_unpreserve(idev);
+
 	hwpt = iommufd_hw_pagetable_detach(idev, pasid);
 	if (!hwpt)
 		return;
@@ -1749,3 +1761,145 @@ int iommufd_get_hw_info(struct iommufd_ucmd *ucmd)
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
+	if (!ret)
+		idev->liveupdate_preserved = true;
+out:
+	mutex_unlock(&igroup->lock);
+	return ret;
+}
+EXPORT_SYMBOL_NS_GPL(iommufd_device_preserve, "IOMMUFD");
+
+/**
+ * iommufd_device_unpreserve() - Unpreserve an iommufd device
+ * @idev: Target iommufd device
+ */
+void iommufd_device_unpreserve(struct iommufd_device *idev)
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
+	iommu_unpreserve_device(idev->dev);
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
+	return idev && idev->liveupdate_preserved;
+}
+EXPORT_SYMBOL_NS_GPL(iommufd_device_is_preserved, "IOMMUFD");
+#endif
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 69d902b69b82..df231d1e7d09 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -524,6 +524,9 @@ struct iommufd_device {
 	bool enforce_cache_coherency;
 	struct iommufd_vdevice *vdev;
 	bool destroying;
+#ifdef CONFIG_IOMMU_LIVEUPDATE
+	bool liveupdate_preserved;
+#endif
 };
 
 static inline struct iommufd_device *
diff --git a/drivers/iommu/iommufd/liveupdate.c b/drivers/iommu/iommufd/liveupdate.c
index 21a6efafb960..d49c5ce3c65c 100644
--- a/drivers/iommu/iommufd/liveupdate.c
+++ b/drivers/iommu/iommufd/liveupdate.c
@@ -210,6 +210,30 @@ static int iommufd_preserve_hwpt(struct iommufd_hwpt_paging *hwpt,
 	return rc;
 }
 
+/* Preserved devices must be unpreserved when the iommufd is unpreserved. */
+static void iommufd_unpreserve_devices(struct iommufd_ctx *ictx)
+{
+	struct iommufd_device *idev;
+	struct iommufd_object *obj;
+	unsigned long index;
+
+	xa_lock(&ictx->objects);
+	xa_for_each(&ictx->objects, index, obj) {
+		if (obj->type != IOMMUFD_OBJ_DEVICE)
+			continue;
+
+		idev = container_of(obj, struct iommufd_device, obj);
+		if (!iommufd_device_is_preserved(idev) || !iommufd_lock_obj(obj))
+			continue;
+
+		xa_unlock(&ictx->objects);
+		iommufd_device_unpreserve(idev);
+		iommufd_put_object(ictx, obj);
+		xa_lock(&ictx->objects);
+	}
+	xa_unlock(&ictx->objects);
+}
+
 static void _iommufd_unpreserve(struct iommufd_ctx *ictx,
 				struct iommufd_ser *ser)
 {
@@ -217,6 +241,8 @@ static void _iommufd_unpreserve(struct iommufd_ctx *ictx,
 	struct iommufd_object *obj;
 	unsigned long index;
 
+	iommufd_unpreserve_devices(ictx);
+
 	xa_lock(&ictx->objects);
 	xa_for_each_marked(&ictx->objects, index, obj, IOMMUFD_OBJ_LIVEUPDATE_MARK) {
 		if (obj->type != IOMMUFD_OBJ_HWPT_PAGING)
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 3087f5b2def8..1ad2a21cfcdf 100644
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
@@ -215,6 +216,14 @@ int iommufd_access_rw(struct iommufd_access *access, unsigned long iova,
 int iommufd_vfio_compat_ioas_get_id(struct iommufd_ctx *ictx, u32 *out_ioas_id);
 int iommufd_vfio_compat_ioas_create(struct iommufd_ctx *ictx);
 int iommufd_vfio_compat_set_no_iommu(struct iommufd_ctx *ictx);
+
+#ifdef CONFIG_IOMMU_LIVEUPDATE
+int iommufd_device_preserve(struct liveupdate_session *s,
+			    struct iommufd_device *idev,
+			    u64 *iommufd_tokenp);
+void iommufd_device_unpreserve(struct iommufd_device *idev);
+bool iommufd_device_is_preserved(struct iommufd_device *idev);
+#endif
 #else /* !CONFIG_IOMMUFD */
 static inline struct iommufd_ctx *iommufd_ctx_from_file(struct file *file)
 {
@@ -399,4 +408,22 @@ static inline void iommufd_viommu_destroy_mmap(struct iommufd_viommu *viommu,
 {
 	_iommufd_destroy_mmap(viommu->ictx, &viommu->obj, offset);
 }
+
+#if !IS_ENABLED(CONFIG_IOMMU_LIVEUPDATE) || !IS_ENABLED(CONFIG_IOMMUFD)
+static inline int iommufd_device_preserve(struct liveupdate_session *s,
+					  struct iommufd_device *idev,
+					  u64 *iommufd_tokenp)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void iommufd_device_unpreserve(struct iommufd_device *idev)
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
2.56.1.809.ga0b61035b5-goog

