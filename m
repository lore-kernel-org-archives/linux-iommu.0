Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E863806DD
	for <iommu@lists.linux.dev>; Tue,  3 Feb 2026 22:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770156611; cv=none; b=uQMq+vi345IrzBQyh44FvzqQ9U9fNeVD0SDCggVsGI6POUdtfvWHTzBa9ijew4Oo6/fkhKtpbiMQY8zas69/bt6dE0yPKq8WWH8iIWeAHfAUheehZi64/+DRgo2MvgLNot7hG69X/CXOe6zuB/ZeuPnPk14M+8uTBLbIf3UMBv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770156611; c=relaxed/simple;
	bh=kib+TGW+Sn0wIp4wEuCVzIXogMh8yQTFjwVFCEPYhmY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tGsFxoMdGR28fTk5Gjynvonp90dBRfGOkBEgJnO3Gb7VVMrAYpy4c0Us2k/YjEw1Gsf4KFUWwBvFjzVSm3shTvD7uMpoccS0ponYHa+wor+L1xCivqe9GKXWJ4NAlWFtu5Iy6+U07fBMc97SO8L9eAGvw19rBqZxrye+up06FUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wqk/BFif; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wqk/BFif"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3545cc84ab1so7281159a91.0
        for <iommu@lists.linux.dev>; Tue, 03 Feb 2026 14:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770156609; x=1770761409; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cqqC2kaW5ecj2f4ECaQ1IWiF4359d2X2a1SnW9XYDSk=;
        b=Wqk/BFif5BUOEB7NDE4gaR9jdsbtgE2C9/Vo7TTC9VyVRnAbapOX2+hxGRnDniR+da
         HqsTKpjq66cKFLuXq2u5FZEUXOnlqt8sNclYt1BW881cLKDBJM/+gqM4Gm56c2KV0wDn
         52nsCQJbsXcrFYoZVNa5300ApwSgUyxtohErnBZ5qOJsd2ZhqdyvSEMqCrQc+gOz+q36
         8bzzCYpUaedenO2P1//XGmCt5EjURdU/ziBjIbiyuVG4WKuHmRwt2XU1UrPvNkm9s1Zj
         iJSP7Y0m0VndTJreMPFrmHitwDeeyj4qeU8Qt+mgW30qRusoN/4J1b3TfgnY+MMeZhNB
         wTZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770156609; x=1770761409;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cqqC2kaW5ecj2f4ECaQ1IWiF4359d2X2a1SnW9XYDSk=;
        b=lGB+PKX4AUv/sqXLT9spx6QTJ3yXfRwHLicVcXVKvevK7X0YFj9uEjPqOWQiWKMxXT
         QarkRnvJQaru0jXDtc5n0hdK4xfHWrqLtyeHUPNtSwtuVOSXsrCh2tMHR3t6Is4QR5CF
         g2XwpcEbGB9Plcc8aMDZi5g1CDiwFbb18qJJveBurlhp86f+Iq9E3dFwV6PgSTaabr+k
         JgjZxrBhclXT4Qx+sfqlfdrPOfO672mdHWSJ/FVEcRmxsxi4YbCpokdoh5HikrjQ+DPW
         YD4cYjNYPE3dhnW5UabIjvudYE0oxuO7GGtZoWuA01Y26+aOJ+DgmOVg+xvvQn3OOuSY
         3cnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvZoGLMNR6zEROHKvH4nxHQL0U8coip88f2vBWc2uHmN07TwrC2hNhKKnPM7L7m/y1ETns4Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx5Pfp2QFJFguPejBIQ7M9l7I7qyCK2bIeGh3wAZ7pM/MSWIGbL
	Sk52/qNj06yWVqY/En5g/huZj6+7wPLMmc7rUtKXF/09OdzJW5u6Dc/DZ6ZyHVzEoJYRhOsMT3Q
	kxwEyrLtJYlL3Rg==
X-Received: from pjpo9.prod.google.com ([2002:a17:90a:9f89:b0:34c:f8b8:349b])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:e70d:b0:34c:a35d:de19 with SMTP id 98e67ed59e1d1-354871ea85fmr658805a91.33.1770156609486;
 Tue, 03 Feb 2026 14:10:09 -0800 (PST)
Date: Tue,  3 Feb 2026 22:09:46 +0000
In-Reply-To: <20260203220948.2176157-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260203220948.2176157-1-skhawaja@google.com>
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260203220948.2176157-13-skhawaja@google.com>
Subject: [PATCH 12/14] iommufd: Add APIs to preserve/unpreserve a vfio cdev
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
the APIs exported by the IOMMU core to preserve/unpreserve device. Pass
the LUO preservation token of the attached iommufd into IOMMU preserve
device API. This establishes the ownership of the device with the
preserved iommufd.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/iommu/iommufd/device.c | 69 ++++++++++++++++++++++++++++++++++
 include/linux/iommufd.h        | 23 ++++++++++++
 2 files changed, 92 insertions(+)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 4c842368289f..30cb5218093b 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -2,6 +2,7 @@
 /* Copyright (c) 2021-2022, NVIDIA CORPORATION & AFFILIATES
  */
 #include <linux/iommu.h>
+#include <linux/iommu-lu.h>
 #include <linux/iommufd.h>
 #include <linux/pci-ats.h>
 #include <linux/slab.h>
@@ -1661,3 +1662,71 @@ int iommufd_get_hw_info(struct iommufd_ucmd *ucmd)
 	iommufd_put_object(ucmd->ictx, &idev->obj);
 	return rc;
 }
+
+#ifdef CONFIG_IOMMU_LIVEUPDATE
+int iommufd_device_preserve(struct liveupdate_session *s,
+			    struct iommufd_device *idev,
+			    u64 *tokenp)
+{
+	struct iommufd_group *igroup = idev->igroup;
+	struct iommufd_hwpt_paging *hwpt_paging;
+	struct iommufd_hw_pagetable *hwpt;
+	struct iommufd_attach *attach;
+	int ret;
+
+	mutex_lock(&igroup->lock);
+	attach = xa_load(&igroup->pasid_attach, IOMMU_NO_PASID);
+	if (!attach) {
+		ret = -ENOENT;
+		goto out;
+	}
+
+	hwpt = attach->hwpt;
+	hwpt_paging = find_hwpt_paging(hwpt);
+	if (!hwpt_paging || !hwpt_paging->lu_preserve) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = liveupdate_get_token_outgoing(s, idev->ictx->file, tokenp);
+	if (ret)
+		goto out;
+
+	ret = iommu_preserve_device(hwpt_paging->common.domain,
+				    idev->dev,
+				    *tokenp);
+out:
+	mutex_unlock(&igroup->lock);
+	return ret;
+}
+EXPORT_SYMBOL_NS_GPL(iommufd_device_preserve, "IOMMUFD");
+
+void iommufd_device_unpreserve(struct liveupdate_session *s,
+			       struct iommufd_device *idev,
+			       u64 token)
+{
+	struct iommufd_group *igroup = idev->igroup;
+	struct iommufd_hwpt_paging *hwpt_paging;
+	struct iommufd_hw_pagetable *hwpt;
+	struct iommufd_attach *attach;
+
+	mutex_lock(&igroup->lock);
+	attach = xa_load(&igroup->pasid_attach, IOMMU_NO_PASID);
+	if (!attach) {
+		WARN_ON(-ENOENT);
+		goto out;
+	}
+
+	hwpt = attach->hwpt;
+	hwpt_paging = find_hwpt_paging(hwpt);
+	if (!hwpt_paging || !hwpt_paging->lu_preserve) {
+		WARN_ON(-EINVAL);
+		goto out;
+	}
+
+	iommu_unpreserve_device(hwpt_paging->common.domain, idev->dev);
+out:
+	mutex_unlock(&igroup->lock);
+}
+EXPORT_SYMBOL_NS_GPL(iommufd_device_unpreserve, "IOMMUFD");
+#endif
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 6e7efe83bc5d..c4b3ed5b518c 100644
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
@@ -71,6 +72,28 @@ void iommufd_device_detach(struct iommufd_device *idev, ioasid_t pasid);
 struct iommufd_ctx *iommufd_device_to_ictx(struct iommufd_device *idev);
 u32 iommufd_device_to_id(struct iommufd_device *idev);
 
+#ifdef CONFIG_IOMMU_LIVEUPDATE
+int iommufd_device_preserve(struct liveupdate_session *s,
+			    struct iommufd_device *idev,
+			    u64 *tokenp);
+void iommufd_device_unpreserve(struct liveupdate_session *s,
+			       struct iommufd_device *idev,
+			       u64 token);
+#else
+static inline int iommufd_device_preserve(struct liveupdate_session *s,
+					  struct iommufd_device *idev,
+					  u64 *tokenp)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void iommufd_device_unpreserve(struct liveupdate_session *s,
+					     struct iommufd_device *idev,
+					     u64 token)
+{
+}
+#endif
+
 struct iommufd_access_ops {
 	u8 needs_pin_pages : 1;
 	void (*unmap)(void *data, unsigned long iova, unsigned long length);
-- 
2.53.0.rc2.204.g2597b5adb4-goog

