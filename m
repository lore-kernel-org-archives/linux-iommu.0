Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E870C37FF61
	for <iommu@lists.linux.dev>; Thu,  2 Apr 2026 07:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775113222; cv=none; b=df30MGln170Qc78oM9RicIrjstfjITTGBjgmjBfgIDYZQueUF4CRTJl100A6/gRTjzN2RrZC0UCAkkfOIE8eWdtSwIbXMN9Y5umLr/V8ui8Zx16dv41rQ5mFUlf7UmETgv35K+sRLPomtjq748LvScF0v+RpUn5seMidPB3EBNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775113222; c=relaxed/simple;
	bh=xStoa0Ey6WylcAN2CcgxQJ47ZYn/QFSaqt1J12896QY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uHhmmca9df24JDsgjIg1jJCVJmrq7Ooy3X8FpZDQmG2LCzr9XudAawVsIqUourI0Z9SMZvSDJ3C+T0gyLoAEPYgwhJJM21TUVRE8RIdnUGQzFb5hB59Wy9htuKWQvC9q/Co1JcJ96TMOaGSt9jk3KuISmkjW+KrGEX3IuWWPApE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OrI5pkha; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OrI5pkha"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775113219; x=1806649219;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xStoa0Ey6WylcAN2CcgxQJ47ZYn/QFSaqt1J12896QY=;
  b=OrI5pkha2qyJ2ilkMRW+9rWT8/EbjCUvymlbOUvZvYElHu/Ix2oqNGWX
   mM/zkB3kqN54WtOXxTgQyO89rYX/b2A6KmNXZroiu2OblC8QNqI/FAdVg
   S65l3CsGOCALqaqK6Tzpwdbi6Ey/1H8/7/EElbdcySrADnXiGJur1l7Ot
   F8RrJSNTkP9WWr4n1r7R9r50mB4lN5W3vphdinDcHU6PYKvwV+dSZSkxB
   B01EBz1PvcvW8S9OdOlJItPF3wjxnNazAgucbVtBFDvauVi8UBZjmofD2
   D03jDPeaAbj2g4a3f8jA3FSUN2eaKSJaJWpY/ZpZy0KrjpFXTA6yIEZTz
   Q==;
X-CSE-ConnectionGUID: JfvqnWrERHKx0N0pFDdwww==
X-CSE-MsgGUID: iXQnZMZnQlGvwtAX7OyjCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11746"; a="76053633"
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; 
   d="scan'208";a="76053633"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 00:00:19 -0700
X-CSE-ConnectionGUID: T4MpjILjSBC/1qLdiRJKNw==
X-CSE-MsgGUID: +O+6x2juQqy8iYjqKVgpaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; 
   d="scan'208";a="231847803"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by orviesa005.jf.intel.com with ESMTP; 02 Apr 2026 00:00:18 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 03/10] iommu/vt-d: Support dirty tracking on PASID
Date: Thu,  2 Apr 2026 14:57:26 +0800
Message-ID: <20260402065734.1687476-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260402065734.1687476-1-baolu.lu@linux.intel.com>
References: <20260402065734.1687476-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

In order to support passthrough device with PASID capability in QEMU,
e.g., DSA device, kernel needs to support attaching PASID to a domain.

But attaching is not allowed if the domain is a second stage domain or
nested domain with dirty tracking.

The reason is kernel lacking support for dirty tracking on such domain
attached to PASID. By adding dirty tracking on PASID, the check can be
removed.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20260330101108.12594-4-zhenzhong.duan@intel.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c  | 12 +++++++++---
 drivers/iommu/intel/nested.c |  6 +-----
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 965e0330ec4b..26135ff3a289 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3618,9 +3618,6 @@ static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
 	if (!pasid_supported(iommu) || dev_is_real_dma_subdevice(dev))
 		return -EOPNOTSUPP;
 
-	if (domain->dirty_ops)
-		return -EINVAL;
-
 	if (context_copied(iommu, info->bus, info->devfn))
 		return -EBUSY;
 
@@ -3688,6 +3685,7 @@ static void *intel_iommu_hw_info(struct device *dev, u32 *length,
 static int domain_set_dirty_tracking(struct dmar_domain *domain, bool enable)
 {
 	struct device_domain_info *info;
+	struct dev_pasid_info *dev_pasid;
 	int ret = 0;
 
 	lockdep_assert_held(&domain->lock);
@@ -3695,6 +3693,14 @@ static int domain_set_dirty_tracking(struct dmar_domain *domain, bool enable)
 	list_for_each_entry(info, &domain->devices, link) {
 		ret = intel_pasid_setup_dirty_tracking(info->iommu, info->dev,
 						       IOMMU_NO_PASID, enable);
+		if (ret)
+			return ret;
+	}
+
+	list_for_each_entry(dev_pasid, &domain->dev_pasids, link_domain) {
+		info = dev_iommu_priv_get(dev_pasid->dev);
+		ret = intel_pasid_setup_dirty_tracking(info->iommu, info->dev,
+						       dev_pasid->pasid, enable);
 		if (ret)
 			break;
 	}
diff --git a/drivers/iommu/intel/nested.c b/drivers/iommu/intel/nested.c
index 16c82ba47d30..2b979bec56ce 100644
--- a/drivers/iommu/intel/nested.c
+++ b/drivers/iommu/intel/nested.c
@@ -148,7 +148,6 @@ static int intel_nested_set_dev_pasid(struct iommu_domain *domain,
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
-	struct iommu_domain *s2_domain = &dmar_domain->s2_domain->domain;
 	struct intel_iommu *iommu = info->iommu;
 	struct dev_pasid_info *dev_pasid;
 	int ret;
@@ -156,13 +155,10 @@ static int intel_nested_set_dev_pasid(struct iommu_domain *domain,
 	if (!pasid_supported(iommu) || dev_is_real_dma_subdevice(dev))
 		return -EOPNOTSUPP;
 
-	if (s2_domain->dirty_ops)
-		return -EINVAL;
-
 	if (context_copied(iommu, info->bus, info->devfn))
 		return -EBUSY;
 
-	ret = paging_domain_compatible(s2_domain, dev);
+	ret = paging_domain_compatible(&dmar_domain->s2_domain->domain, dev);
 	if (ret)
 		return ret;
 
-- 
2.43.0

