Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC5C3EC2F0
	for <iommu@lists.linux.dev>; Mon, 27 Apr 2026 17:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777312623; cv=none; b=XK9sO2iEtygixq2xWkPH+9tYZO7VNTRohfNvPEh0RnyDMq5rpTENP5yyRT+wqMHh1y2aEaLByqOFKKovumg9kTdO0MAMkK9iE5U5yX57f1lfNYS+tLLiuqc4Lhu+/WSPPRjrUQRvXgNYa0k9pGh7UeH+Vmo345stW5vMJtweQEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777312623; c=relaxed/simple;
	bh=qD1+4rSMtt4ULuCNU76s0xvQxVAb+b7zgr5Un97ZxPQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EbGNS/W1LCF+gh5Ejsg6lWmSw+CMrxr7se4l0zgO+cV+8esEZ0Ivc04y/Cvg+zwuXcfkQBf+fWTqdbQB8SArROiW482bllmPqjE/FX6uq0kgpyA3prfN75Nagwrbwb47qWix/Ges0Ok+viQHeteFN67jA+CX4M0UhSbRpjNrcRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u+WexVb0; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u+WexVb0"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-36472c6a7d8so2656409a91.3
        for <iommu@lists.linux.dev>; Mon, 27 Apr 2026 10:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777312619; x=1777917419; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DZvQUlC5buTtM3avbD9rscPBVR4juLrgYjrdDPyoXaU=;
        b=u+WexVb0Tv9qyocgX21KKdk9ZJRgonJaxn5aZWeCReWMqZ0rtlMlNw5cfepEhFZU+h
         B9daZVg8kSBCwPLJMo2ASRvMDdbUdb7pt7y6V33E8aaM8B/I8iYhp8iBiWCy/K/+39uZ
         vVgXFaNUhhn04SO0uniU2jIfvYDXZ8/OLLwrOYctHOH+R7zBKNj59RhvXLQKRPuJwQw/
         GdAiSogeGyW2fVl5mCwmLwyuBhlMJK4As8+3wcJ+zVnAeDfpblp0k17CaoJoldnnPv+4
         8ul35stEKz0YWO5hCZ58Pi4AHyqaw4f0LNpPJW/nEnkIzcbd4hFJs1qUZwOLhRfLrio+
         1h0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777312619; x=1777917419;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DZvQUlC5buTtM3avbD9rscPBVR4juLrgYjrdDPyoXaU=;
        b=hrUQwSbOEDGbJ5btRsqp4d7cLyhE6Xq4wek4zQpst8oWU1ZDClQ9aoFASJ1xcoQqkz
         f7pgJxLzVvucoF0WFphysrqgRGKDlfE43aZt7B7qmzOirUz/ixfmyPDAVWdqK6jWcO3s
         75BPu2V7KIHzBUzXePiHo70ME9ma9W/GLblawqH3YaRfHpRNJYNjDswy6X0oDJlyYh9f
         CbVIEIpvUeN3a8XxycAYymr44Bc9YIpenmFuMMuEF3B+d4YH7zlDwsDUhIpbJkOc6LPm
         JBvyneavSt6cCEQFUXriV/EBvFXPW+Tk4YQUk+hI5nj1wMUIOriWMwu1Tg+huzldhiRs
         zWKw==
X-Forwarded-Encrypted: i=1; AFNElJ85YBEDIR0AKUEp2ZKMcZBShv4S83nCnDckZAolYg782OpAFDr4MWa1ivVVLIyWc3x/bMDQaQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxAcqp9DvJ0SraxQg607aSt9rcxM+WOLL8h8hhzIVMcU4Gn32/P
	0ljZmZwju952QKHt72uvT8PUDAGn4jpa+lC4/LF21n1jzGE3WIu/MnN+cQ+mDGUOKwgXcxlW8Tq
	9WH3P8zFptHY09g==
X-Received: from pghr24.prod.google.com ([2002:a63:e518:0:b0:c79:7991:6d2f])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3908:b0:35e:3e86:e2d3 with SMTP id 98e67ed59e1d1-36490bf8ef1mr128061a91.10.1777312618973;
 Mon, 27 Apr 2026 10:56:58 -0700 (PDT)
Date: Mon, 27 Apr 2026 17:56:31 +0000
In-Reply-To: <20260427175633.1978233-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260427175633.1978233-1-skhawaja@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260427175633.1978233-15-skhawaja@google.com>
Subject: [PATCH v2 14/16] iommufd: Add APIs to preserve/unpreserve a vfio cdev
From: Samiullah Khawaja <skhawaja@google.com>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Samiullah Khawaja <skhawaja@google.com>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Pranjal Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>, 
	YiFei Zhu <zhuyifei@google.com>
Content-Type: text/plain; charset="UTF-8"

Add APIs that can be used to preserve and unpreserve a vfio cdev. Use
the APIs exported by the IOMMU core to preserve/unpreserve device.

The LUO token of the preserved iommufd is fetched and returned back to
the caller as that can be used during restore to get the restored
iommufd. Handle to the preserved state of the device is also returned to
reassociate with the restored state after live update kexec.

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
index 3c88aa115d08..9b47eaf92d42 100644
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
2.54.0.545.g6539524ca2-goog

