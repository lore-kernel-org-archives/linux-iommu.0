Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E089836B18
	for <iommu@lists.linux.dev>; Tue, 24 Oct 2023 15:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hCTYdzi6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698161157; x=1729697157;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1Qo/FTvzNZXKNcxE6JDGjTJkXacRYoQ7dUGXNQJl+9Q=;
  b=hCTYdzi6YiIEbhEGJUJiWSIiTYP+2pyAejsxhY2P3DcQVmTt4z+2NxIV
   NB16ghnbuCIzuttDe+idN/PD0CY2KHxdXm2HcKNhLxkGMEmAf2/M6Cwhv
   Za4ur7NwKXEnuudO9xBidbpmU/jNPDxL2I5mSagz/+R4YyWSvY4dOhMTD
   LDrG5VG3tgz939D/5i611q1hx0GNU8BpQSx51BguonL3KwCUqYjCU6yOD
   T+tfbQN0Pq9kDUKiJKR+TT1nzGSMUpLKkmiFTUUKSndAKwLpTbbPNt+lo
   2sfoDIVasxFpgGMeCULzTd5fo+klOgqTwGHFhNFvcwxvVpa5LiahUbx1/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="418212188"
X-IronPort-AV: E=Sophos;i="6.03,248,1694761200"; 
   d="scan'208";a="418212188"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 08:14:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="1005688925"
X-IronPort-AV: E=Sophos;i="6.03,248,1694761200"; 
   d="scan'208";a="1005688925"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga006.fm.intel.com with ESMTP; 24 Oct 2023 08:14:17 -0700
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
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v7 6/8] iommu/vt-d: Set the nested domain to a device
Date: Tue, 24 Oct 2023 08:14:10 -0700
Message-Id: <20231024151412.50046-7-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231024151412.50046-1-yi.l.liu@intel.com>
References: <20231024151412.50046-1-yi.l.liu@intel.com>
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
index 859c60bead05..d9197dd72748 100644
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

