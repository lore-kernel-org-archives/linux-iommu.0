Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794283730;
	b=SV18o69SQre5CcPXrU79K2ZeF7I7ZIxxXYELDKaK21nsY2NYgOp5903LEDps6Fw/Cjmd
	 N99XTi/mOW4dUmlGksXsUy+AeCJl5HzYwSG4LUc+IbyaqXlQJB8oe8S103QyzzT66GSNm
	 ydboyhiOEtPcsE0PMZ7CHmK9xpi9N3bDGDDgbbbVtiJdL8DBUI6jsjUVfrgX7MswUnuV0
	 2+leInemcAInTe2oSTf+9lFb1E8QeggbWckAcy/2JaJw2tv/Z7q9ct9T1rvehuYicjE/N
	 OZi376xPSSrBg4/jFwCJEmzzJONoeGPHYqbvvKf7fEIrodJFAvqB4+SxTvI0RLdlPsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794283730;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=rN4oVufvi2nGwVnUu37zg0Qg8FnmGc5b0APYU80CoWI=;
	b=z2R0Ue5DjDhC9sQVzWgi3jt/0PKI52ITlUKv1kFyzPZmXO/rEwCqf/s1X/Gw7PO77033
	 ZVlilUcLBABdwAK1QARIRYnxfyGye+pq1R4L+KxX50BNndE/d3QBRos240P3wGo0iIkUn
	 YKMUTRRu9bV1DqWf05z6UIaGbIqNdsL1LnU+91HahQp4FDBfocX2495Nb8qD0bkYn9xaM
	 5Kcfu/QvhYtY7RMdg8Y+xAN1bxhQ0vYetOOuawKCesS0JfzXLmGszK1FNnF2e2PZ5h2k2
	 l95BRk5mv+l9KQapZ2JWt8BNEnxLGkbWit9zC1dQvS4j0G3e6RxmfoeintmD6v9cQPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=AlAhorV5;
	arc=none smtp.remote-ip=209.85.215.197
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC850606B7E4
	for <iommu@lists.linux.dev>; Tue, 10 Nov 2026 04:08:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC850606B7E4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=AlAhorV5
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cdb96533adfso919270a12.3
        for <iommu@lists.linux.dev>; Mon, 09 Nov 2026 20:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794283729; x=1794888529; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rN4oVufvi2nGwVnUu37zg0Qg8FnmGc5b0APYU80CoWI=;
        b=AlAhorV5ZL67mLK5MWCxysmArOJviN6N/0pTNfJwczWioFqe/AyU/W+MDyqmGqthM6
         FVy0MmzTgfPORAaUmAKzCSIAkrtXRoAziLe6zBB/Sp3kaux7RuttHBs9JM7RONFXTa3o
         VVCQb4iMRsLhOVUes+1RRbL/MGvYgGgrsPY6+yBI5JBDnbw+BHTrHNuVIfHH54fXNTaO
         rvNZFLH3otXFaLUCxmyjUE23DVQZiWj+2kMsi8Z3K4+5x62t2lNkAw4M7VnH7VbR/nhJ
         xvFDJ1djQvFnWPdvLgjETmrFlvQNl64UXbZ1xt824+ebpd1Y70hPjAtG+SJZ6Cc+yjR8
         KVPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794283729; x=1794888529;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rN4oVufvi2nGwVnUu37zg0Qg8FnmGc5b0APYU80CoWI=;
        b=e94q+O5rKTVfnWownoX/vLxpwpP1ozO3ug4RXuhh1IBJjy/HP21MdBx69pVMHZkqtY
         eC0QI9INdI+xeDDXkNjhZpfDLqXoGNU0ET9BU+nkil35WAvgLHvDCJkdeeI75YMITYsv
         SVTp70ctbelar6K84APSFFD/HLs64SdgjpJMbCeQp4s720ho7ovekwrU8XlFY0EKlQ57
         Jqej1BpFMlvGgOlrP7hHwuDohQ0D6Ru9zVWd7tLM9zh4A61m9jifQ2GhU9HIzsQzeHTl
         DKC5X8O7P1ggPMl5zgsVGU2muFkfD1S/x9zQVjaxUUG3PQTMo4koy0MtSRuGjBq/monL
         lsQw==
X-Forwarded-Encrypted: i=1; AL+hErGWvWZ17MOR/nrk3gbp2dpO7beJJuz5RhjjxJpBKfnMZIcaqG6IXrrk02DjpTuRVJvlA0q1CA==@lists.linux.dev
X-Gm-Message-State: APuU4Z+ykiGS+PS/nJfsa33eFiLGuLIAStM6X1QR08GV/xjdcygQ95V/
	TFWjI5+S+nXOeWUGkQ0j/mrKUZQM6ZGJI85erxsw9JGJW0MkMh/oRfG4ToOxn84qzM68KqWoKzB
	79OBYsj0A9IbeUw==
X-Received: from pjboe18.prod.google.com ([2002:a17:90b:3952:b0:3b0:a2c4:246b])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1f90:b0:3a8:f70f:2437 with SMTP id 98e67ed59e1d1-3b166d1deddmr1478231a91.50.1794283728975;
 Mon, 09 Nov 2026 20:08:48 -0800 (PST)
Date: Tue, 10 Nov 2026 04:08:22 +0000
In-Reply-To: <20261110040828.1774343-1-skhawaja@google.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261110040828.1774343-1-skhawaja@google.com>
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
Message-ID: <20261110040828.1774343-17-skhawaja@google.com>
Subject: [PATCH v7 16/18] iommufd: Add APIs to preserve/unpreserve a vfio cdev
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
 drivers/iommu/iommufd/device.c          | 153 ++++++++++++++++++++++++
 drivers/iommu/iommufd/iommufd_private.h |   3 +
 include/linux/iommufd.h                 |  33 +++++
 3 files changed, 189 insertions(+)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 1b0bdf57ac8a..1e42e85af819 100644
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
@@ -1749,3 +1758,147 @@ int iommufd_get_hw_info(struct iommufd_ucmd *ucmd)
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
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 3087f5b2def8..f673a07cbc32 100644
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
@@ -215,6 +216,15 @@ int iommufd_access_rw(struct iommufd_access *access, unsigned long iova,
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
@@ -399,4 +409,27 @@ static inline void iommufd_viommu_destroy_mmap(struct iommufd_viommu *viommu,
 {
 	_iommufd_destroy_mmap(viommu->ictx, &viommu->obj, offset);
 }
+
+#if !IS_ENABLED(CONFIG_IOMMU_LIVEUPDATE) || !IS_ENABLED(CONFIG_IOMMUFD)
+/*
+ * vfio-pci live update works without IOMMU state preservation, so the device
+ * is still preserved, just without its IOMMU state.
+ */
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
2.56.0.506.g506a7eabc5-goog

