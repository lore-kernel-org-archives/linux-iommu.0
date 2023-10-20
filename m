Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3780912E68
	for <iommu@lists.linux.dev>; Fri, 20 Oct 2023 09:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GAbEhM6v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697794375; x=1729330375;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SiOnd5LkRXUXCS5mAkcNqw6aqRwvfv1UQkCHpPzwFmw=;
  b=GAbEhM6vLP/9sCjvGToH8zsVZel/i/KL5vEkRasKOdNhXAZIfaz9pDwK
   iVgHeWGWHdyv6n2CtSnMpJZ3EMR8RlUEuJEUn2FXal3bhXTuOHQItSnlE
   YBpZgE05PMI+My2DsFdGs0dG0FYC2ZGgnouw30LkKArKDH0Kp0YmGpOvQ
   4c0JyJF3Xrn4Qd84kLOOQ/O+1e/1o8/dHduMf6Q7Hs/P4eaPiYgNcPcom
   G5OlHB9rKM+y+1R0pwxBRNSWSevdaUhmkqu3RUs9fCaP7iWGP6sMyU30q
   4dnIJN+sRfSmQNsSBd4q/8sl1hpD5fBvCSMQ3bRIIbcvbukm9GXCn/k7y
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="450691738"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="450691738"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 02:32:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="733906308"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="733906308"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orsmga006.jf.intel.com with ESMTP; 20 Oct 2023 02:32:54 -0700
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	alex.williamson@redhat.com,
	jgg@nvidia.com,
	kevin.tian@intel.com,
	robin.murphy@arm.com,
	baolu.lu@linux.intel.com
Cc: cohuck@redhat.com,
	eric.auger@redhat.com,
	nicolinc@nvidia.com,
	kvm@vger.kernel.org,
	mjrosato@linux.ibm.com,
	chao.p.peng@linux.intel.com,
	yi.l.liu@intel.com,
	yi.y.sun@linux.intel.com,
	peterx@redhat.com,
	jasowang@redhat.com,
	shameerali.kolothum.thodi@huawei.com,
	lulu@redhat.com,
	suravee.suthikulpanit@amd.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	zhenzhong.duan@intel.com,
	joao.m.martins@oracle.com,
	xin.zeng@intel.com,
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v6 6/8] iommu/vt-d: Set the nested domain to a device
Date: Fri, 20 Oct 2023 02:32:44 -0700
Message-Id: <20231020093246.17015-7-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231020093246.17015-1-yi.l.liu@intel.com>
References: <20231020093246.17015-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds the helper for setting the nested domain to a device hence
enable nested domain usage on Intel VT-d.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/intel/nested.c | 54 ++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/iommu/intel/nested.c b/drivers/iommu/intel/nested.c
index 5a2920a98e47..19538fb616db 100644
--- a/drivers/iommu/intel/nested.c
+++ b/drivers/iommu/intel/nested.c
@@ -12,8 +12,61 @@
 #define pr_fmt(fmt)	"DMAR: " fmt
 
 #include <linux/iommu.h>
+#include <linux/pci.h>
+#include <linux/pci-ats.h>
 
 #include "iommu.h"
+#include "pasid.h"
+
+static int intel_nested_attach_dev(struct iommu_domain *domain,
+				   struct device *dev)
+{
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
+	struct intel_iommu *iommu = info->iommu;
+	unsigned long flags;
+	int ret = 0;
+
+	if (info->domain)
+		device_block_translation(dev);
+
+	if (iommu->agaw < dmar_domain->s2_domain->agaw) {
+		dev_err_ratelimited(dev, "Adjusted guest address width not compatible\n");
+		return -ENODEV;
+	}
+
+	/*
+	 * Stage-1 domain cannot work alone, it is nested on a s2_domain.
+	 * The s2_domain will be used in nested translation, hence needs
+	 * to ensure the s2_domain is compatible with this IOMMU.
+	 */
+	ret = prepare_domain_attach_device(&dmar_domain->s2_domain->domain, dev);
+	if (ret) {
+		dev_err_ratelimited(dev, "s2 domain is not compatible\n");
+		return ret;
+	}
+
+	ret = domain_attach_iommu(dmar_domain, iommu);
+	if (ret) {
+		dev_err_ratelimited(dev, "Failed to attach domain to iommu\n");
+		return ret;
+	}
+
+	ret = intel_pasid_setup_nested(iommu, dev,
+				       IOMMU_NO_PASID, dmar_domain);
+	if (ret) {
+		domain_detach_iommu(dmar_domain, iommu);
+		dev_err_ratelimited(dev, "Failed to setup pasid entry\n");
+		return ret;
+	}
+
+	info->domain = dmar_domain;
+	spin_lock_irqsave(&dmar_domain->lock, flags);
+	list_add(&info->link, &dmar_domain->devices);
+	spin_unlock_irqrestore(&dmar_domain->lock, flags);
+
+	return 0;
+}
 
 static void intel_nested_domain_free(struct iommu_domain *domain)
 {
@@ -21,6 +74,7 @@ static void intel_nested_domain_free(struct iommu_domain *domain)
 }
 
 static const struct iommu_domain_ops intel_nested_domain_ops = {
+	.attach_dev		= intel_nested_attach_dev,
 	.free			= intel_nested_domain_free,
 };
 
-- 
2.34.1

