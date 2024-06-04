Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA4613D62C
	for <iommu@lists.linux.dev>; Tue,  4 Jun 2024 01:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717466060; cv=none; b=th1K8330KvmPd9DV6xsHX207ko3JJEKtvWFJNg4uOEYpVP9el1dD2bSF7NtgA2PvddgZCjOlDR3m3tppIqJjMBCDdgLxiwxcAfDUJCVRvTzve4EA5JbSCNo4j+gL4S3pOaudEHcXLP65bR6/oxM8WEoy2+nojatMXnUBkWc4Czc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717466060; c=relaxed/simple;
	bh=xf05GvXEO+I215J3GQWK9zqCkzSYPhbVb/+Tz/JkYCQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tTYL90y8l9Q36NdyChDmj+c9iTpT6X/XE3TtlyEfS+3/ot2S3EM8SB/14Q0EvyWOPRc8S08Kuwl4S80OEaH0rWO0qDIPg4zyT98FBsRMv/gWMMxLiDsajqiRwyI+hf+eMHudDP2Y3SiikGy8SBFNUM3xuxYq1F0IeZzLlH0gavI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YNFU8r09; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YNFU8r09"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717466059; x=1749002059;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xf05GvXEO+I215J3GQWK9zqCkzSYPhbVb/+Tz/JkYCQ=;
  b=YNFU8r096BP5eDpFKO4OW1JwI75Mqry21pp3shGBWCg3Axv5BTZih8a4
   oeY/kEGDsoasMOUio1Pc/NfeqPVGqsE6mRe87dIuKlFLVvFgqEIhGfddZ
   EvkVZoMkVk3x1BRaegcs3CE6VeQY8dNkpcpt180sJ8tvV7JdJg4Wz5j8x
   GKpIFaIr1vU6VlLtLTyIHRP9dRiE+PYYK+e3Xu2d+7Ge6bWutLVlkY0OB
   RPCoYwjkwf+jqgJC4ZAy+5dqWmLtt56OLm4wTM+QHcOz/SbsU3+xosaLH
   Eu+ixg4X8prp3JdbSfTVJbAmsL4JZM6dUF4/1/tNjzJVj8HfP9IBtDkMt
   g==;
X-CSE-ConnectionGUID: y1f3Bu5uS+m1ciEPQLvnsg==
X-CSE-MsgGUID: m4u+gCPbQJqBzklMxsfyGQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="25384928"
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="25384928"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 18:54:19 -0700
X-CSE-ConnectionGUID: tnO3brn5RtKaOeayj/FeKQ==
X-CSE-MsgGUID: JOqcCzIaQuu78m9RMY08Xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="37661828"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by orviesa008.jf.intel.com with ESMTP; 03 Jun 2024 18:54:15 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: Yi Liu <yi.l.liu@intel.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Kalle Valo <kvalo@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	mst@redhat.com,
	Jason Wang <jasowang@redhat.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	iommu@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 05/22] iommu: Add iommu_paging_domain_alloc() interface
Date: Tue,  4 Jun 2024 09:51:17 +0800
Message-Id: <20240604015134.164206-6-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240604015134.164206-1-baolu.lu@linux.intel.com>
References: <20240604015134.164206-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit <17de3f5fdd35> ("iommu: Retire bus ops") removes iommu ops from
bus. The iommu subsystem no longer relies on bus for operations. So the
bus parameter in iommu_domain_alloc() is no longer relevant.

Add a new interface named iommu_paging_domain_alloc(), which explicitly
indicates the allocation of a paging domain for DMA managed by a kernel
driver. The new interface takes a device pointer as its parameter, that
better aligns with the current iommu subsystem.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/iommu.h |  6 ++++++
 drivers/iommu/iommu.c | 20 ++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 6648b2415474..16401de7802d 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -781,6 +781,7 @@ extern bool device_iommu_capable(struct device *dev, enum iommu_cap cap);
 extern bool iommu_group_has_isolated_msi(struct iommu_group *group);
 extern struct iommu_domain *iommu_domain_alloc(const struct bus_type *bus);
 struct iommu_domain *iommu_user_domain_alloc(struct device *dev, u32 flags);
+struct iommu_domain *iommu_paging_domain_alloc(struct device *dev);
 extern void iommu_domain_free(struct iommu_domain *domain);
 extern int iommu_attach_device(struct iommu_domain *domain,
 			       struct device *dev);
@@ -1092,6 +1093,11 @@ static inline struct iommu_domain *iommu_user_domain_alloc(struct device *dev, u
 	return ERR_PTR(-ENODEV);
 }
 
+static inline struct iommu_domain *iommu_paging_domain_alloc(struct device *dev)
+{
+	return ERR_PTR(-ENODEV);
+}
+
 static inline void iommu_domain_free(struct iommu_domain *domain)
 {
 }
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index f1416892ef8e..7df4a021b040 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2016,6 +2016,10 @@ static int __iommu_domain_alloc_dev(struct device *dev, void *data)
 	return 0;
 }
 
+/*
+ * The iommu ops in bus has been retired. Do not use this interface in
+ * new drivers.
+ */
 struct iommu_domain *iommu_domain_alloc(const struct bus_type *bus)
 {
 	const struct iommu_ops *ops = NULL;
@@ -2074,6 +2078,22 @@ struct iommu_domain *iommu_user_domain_alloc(struct device *dev, u32 flags)
 }
 EXPORT_SYMBOL_GPL(iommu_user_domain_alloc);
 
+/**
+ * iommu_paging_domain_alloc() - Allocate a paging domain
+ * @dev: device for which the domain is allocated
+ *
+ * Allocate a paging domain which will be managed by a kernel driver. Return
+ * allocated domain if successful, or a ERR pointer for failure.
+ */
+struct iommu_domain *iommu_paging_domain_alloc(struct device *dev)
+{
+	if (!dev_has_iommu(dev))
+		return ERR_PTR(-ENODEV);
+
+	return __iommu_domain_alloc(dev_iommu_ops(dev), dev, IOMMU_DOMAIN_UNMANAGED);
+}
+EXPORT_SYMBOL_GPL(iommu_paging_domain_alloc);
+
 void iommu_domain_free(struct iommu_domain *domain)
 {
 	if (domain->type == IOMMU_DOMAIN_SVA)
-- 
2.34.1

