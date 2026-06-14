Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C5C38E8C1
	for <iommu@lists.linux.dev>; Sun, 14 Jun 2026 23:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781480267; cv=none; b=ZDazDfSK4OUwZojyqEFBpHnxMhXnDtSGgoeFvG47g1gjDAS/voG0Im/XnhLvhaFPmCQ4DXeNayDPTctkuBbVhgkFRqQ18K5fl1PQRZXJ73UmtYGhpFWGjJ48SyOGO/lH7qWuQNf0izI88iAq+8kPzN57taqFWo3cmhPUZMSwxno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781480267; c=relaxed/simple;
	bh=w1Nrt1DPDRflTkd7XZpFoQm8H8bCpYk151oEiyENXZw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=g9q8wZqdzqn/scQAgaLgrRwhFVPWNSVgN9n40tfEa2k/1T+ASeUOJFazZE41+Erxh2ZYwiYbtOqgZqDov9c1xlklzAHuFdGHRe74a6CCXzFRZKZ/75G6fijb+yIrfDN0q3aRBbqpUNhcOgdq2PErMlcfAralCu3PCopSA3oRYv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HfbTnHVG; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HfbTnHVG"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-842cb4c62f9so2199418b3a.0
        for <iommu@lists.linux.dev>; Sun, 14 Jun 2026 16:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781480263; x=1782085063; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Gjm+J/sDlpbKzFCPRSBGIw0iFcduYCgoTrVDKBULpsY=;
        b=HfbTnHVGRjRs+vd+2M8HGZfVwPgQ9eCkPe+nuNdxIHTYq/q2MBMhGHLdd2y8xlVfgN
         XJQIUqUlcLj2iCZrhPtHJsp8grDHoOMt6BZGWzPc6jVOKihBLw/kst0sBp2pDW3Vi7b1
         Blw1OaVeUd2NiwTpVEElhM28lfvISBUlqYXBPQMu4Hu/zUKIH/Cvc0Y5tn8cAIbE8T3v
         PWbd5f1bRe4zvN1EQlDf+kG+kN1m04pj18msjzbAn9V2U3wnEpGDVxW11B3tpTukKDsp
         DXXm0HOahfx7B+l10iK8J4bZF7fVZRxHnPXmz7NhwnvQNIzOzxTxEYGNVTkawxAG4XZc
         wSdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781480263; x=1782085063;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gjm+J/sDlpbKzFCPRSBGIw0iFcduYCgoTrVDKBULpsY=;
        b=iEsygZ9RG/9FpO6Q0Pz+yMEmpvKCCsISn0GK8gtEhrQ8aaE1mkSyqZ+7qdGnV3ytjg
         EQP84nH+AeTQUWpQS4moMyTWW7dEE4tPjlx70NA5xKHAd203jBZEmTKXMDEnIywA2e3K
         5qhRAuP7v9Ft7hKy5nSCnxYCgGHIK+93kTpeZ6yJLbpe0RRwzmHZK2OmnpDjIHLoS+pN
         V4Vx283/+RO55JhX6EUCmXQF/R84msBJfC1mP1sNZO2Z29M4jK5Zy6g06/ER4D7QUjnR
         QkDz/+rCQ+JbN9C1z/+x8wdo4G7vEbr0jMl0tuLE4F/C0uowDDAotgNxeVmBDIkTHGkv
         qKIg==
X-Forwarded-Encrypted: i=1; AFNElJ/u2vxW+iAyop+4fRumwOZ7Bq4/DbolISiIc2YalngDxXRuu/QvnKIR9gAgz/4tG77XKmzhCg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy/AmdhQGDZuQc64dVHd1yT9K6rGQVH5lpM241iTJEUYISCoNWx
	6J1AFoucwF+LETLFGfg8qZsOrH/whTNKIxeUjfDhigUWPfq1xWg+6yq7TQUd0Qw5j1QgCW+iGue
	rFcCW5Lov/j20LQ==
X-Received: from pfw3.prod.google.com ([2002:a05:6a00:a263:b0:82f:4d28:b8c5])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:3993:b0:835:51fd:b7ea with SMTP id d2e1a72fcca58-8434975254bmr9961638b3a.19.1781480262726;
 Sun, 14 Jun 2026 16:37:42 -0700 (PDT)
Date: Sun, 14 Jun 2026 23:37:26 +0000
In-Reply-To: <20260614233728.2212104-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260614233728.2212104-1-skhawaja@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260614233728.2212104-17-skhawaja@google.com>
Subject: [PATCH v3 16/18] iommufd: Add APIs to preserve/unpreserve a vfio cdev
From: Samiullah Khawaja <skhawaja@google.com>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Samiullah Khawaja <skhawaja@google.com>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Pranjal Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

Add APIs that can be used to preserve and unpreserve a vfio cdev. Use
the APIs exported by the IOMMU core to preserve/unpreserve device.

The LUO token of the preserved iommufd is fetched and returned back to
the caller as that can be used during restore to get the restored
iommufd. Handle to the preserved state of the device is also returned to
reassociate with the restored state after live update kexec.

Reviewed-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/iommu/iommufd/device.c          | 102 ++++++++++++++++++++++++
 drivers/iommu/iommufd/iommufd_private.h |   3 +
 include/linux/iommufd.h                 |  29 +++++++
 3 files changed, 134 insertions(+)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 170a7005f0bc..d19fece00da3 100644
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
@@ -610,6 +611,10 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 	int rc;
 
 	mutex_lock(&igroup->lock);
+	if (iommufd_device_is_preserved(idev)) {
+		rc = -EBUSY;
+		goto err_unlock;
+	}
 
 	attach = xa_cmpxchg(&igroup->pasid_attach, pasid, NULL,
 			    XA_ZERO_ENTRY, GFP_KERNEL);
@@ -1665,3 +1670,100 @@ int iommufd_get_hw_info(struct iommufd_ucmd *ucmd)
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
+	if (xa_find_after(&igroup->pasid_attach,
+			  &start, UINT_MAX, XA_PRESENT))
+		return true;
+
+	return false;
+}
+
+int iommufd_device_preserve(struct liveupdate_session *s,
+			    struct iommufd_device *idev,
+			    u64 *iommufd_tokenp,
+			    u64 *preserved_state)
+{
+	struct iommufd_group *igroup = idev->igroup;
+	struct iommufd_hwpt_paging *hwpt_paging;
+	struct iommufd_hw_pagetable *hwpt;
+	struct iommufd_attach *attach;
+	int ret;
+
+	mutex_lock(&igroup->lock);
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
+	hwpt = attach->hwpt;
+	hwpt_paging = find_hwpt_paging(hwpt);
+	if (!hwpt_paging || !hwpt_paging->liveupdate_preserved) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = liveupdate_get_token_outgoing(s, idev->ictx->file, iommufd_tokenp);
+	if (ret)
+		goto out;
+
+	ret = iommu_preserve_device(hwpt_paging->common.domain,
+				    idev->dev,
+				    preserved_state);
+
+	if (!ret)
+		igroup->liveupdate_preserved = true;
+out:
+	mutex_unlock(&igroup->lock);
+	return ret;
+}
+EXPORT_SYMBOL_NS_GPL(iommufd_device_preserve, "IOMMUFD");
+
+void iommufd_device_unpreserve(struct liveupdate_session *s,
+			       struct iommufd_device *idev)
+{
+	struct iommufd_group *igroup = idev->igroup;
+	struct iommufd_hwpt_paging *hwpt_paging;
+	struct iommufd_hw_pagetable *hwpt;
+	struct iommufd_attach *attach;
+
+	mutex_lock(&igroup->lock);
+	attach = xa_load(&igroup->pasid_attach, IOMMU_NO_PASID);
+	if (!attach) {
+		WARN(1, "IOMMU_NO_PASID attachment not found");
+		igroup->liveupdate_preserved = false;
+		goto out;
+	}
+
+	hwpt = attach->hwpt;
+	hwpt_paging = find_hwpt_paging(hwpt);
+	if (!hwpt_paging || !hwpt_paging->liveupdate_preserved) {
+		WARN(1, "Attached domain is not preserved");
+		igroup->liveupdate_preserved = false;
+		goto out;
+	}
+
+	iommu_unpreserve_device(hwpt_paging->common.domain, idev->dev);
+	igroup->liveupdate_preserved = false;
+out:
+	mutex_unlock(&igroup->lock);
+}
+EXPORT_SYMBOL_NS_GPL(iommufd_device_unpreserve, "IOMMUFD");
+
+bool iommufd_device_is_preserved(struct iommufd_device *idev)
+{
+	return idev && idev->igroup && idev->igroup->liveupdate_preserved;
+}
+EXPORT_SYMBOL_NS_GPL(iommufd_device_is_preserved, "IOMMUFD");
+#endif
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 9e0e46f1f7ed..c217d00e2b6d 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -486,6 +486,9 @@ struct iommufd_group {
 	struct xarray pasid_attach;
 	struct iommufd_sw_msi_maps required_sw_msi;
 	phys_addr_t sw_msi_start;
+#ifdef CONFIG_IOMMU_LIVEUPDATE
+	bool liveupdate_preserved;
+#endif
 };
 
 /*
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 6e7efe83bc5d..d1fd5d71e0fd 100644
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
@@ -71,6 +72,34 @@ void iommufd_device_detach(struct iommufd_device *idev, ioasid_t pasid);
 struct iommufd_ctx *iommufd_device_to_ictx(struct iommufd_device *idev);
 u32 iommufd_device_to_id(struct iommufd_device *idev);
 
+#ifdef CONFIG_IOMMU_LIVEUPDATE
+int iommufd_device_preserve(struct liveupdate_session *s,
+			    struct iommufd_device *idev,
+			    u64 *iommufd_tokenp,
+			    u64 *preserved_state);
+void iommufd_device_unpreserve(struct liveupdate_session *s,
+			       struct iommufd_device *idev);
+bool iommufd_device_is_preserved(struct iommufd_device *idev);
+#else
+static inline int iommufd_device_preserve(struct liveupdate_session *s,
+					  struct iommufd_device *idev,
+					  u64 *iommufd_tokenp,
+					  u64 *preserved_state)
+{
+	return -EOPNOTSUPP;
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
+
 struct iommufd_access_ops {
 	u8 needs_pin_pages : 1;
 	void (*unmap)(void *data, unsigned long iova, unsigned long length);
-- 
2.54.0.1136.gdb2ca164c4-goog

