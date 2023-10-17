Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8DB883A
	for <iommu@lists.linux.dev>; Tue, 17 Oct 2023 03:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ml6a2Ihn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697512878; x=1729048878;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2IR/Jycn4fYLDKkd/59DW5lTr+45wMYcYu8xOLtatO8=;
  b=Ml6a2IhnrFo4y6YFcKa6zRHymlDJ4xcJ2zyQkV6A6MDfmQTC/ksWDesy
   wi5Gz0SVbiVuaB50bZaDw1Si+Z0OXVs2EravvnpQlfiTUT6y6b2rdgPZl
   /ct1dq06E2IUNklfnHFpdld+GZy+rEj/5az6t4ElqQNdAUlrLfHsnh3eC
   bnsTiuSskJgzrsO+o1Y36QJhuQGtAnWGomA9pd7S1vgqmF+YYH4c8RgZC
   P2Wp9PnzpmjKcQeYaKOvAWuafQ/pZGPtUXfpzeSJ3YFQ+pQhdMC61DDaJ
   BLA3ncN49xbE1KCLIqzJCpQBvTzenYBUiwqDmtKBAXIjQ7/imcQrWueGb
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="389560807"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="389560807"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 20:21:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="826269997"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="826269997"
Received: from sqa-gate.sh.intel.com (HELO spr-2s5.tsp.org) ([10.239.48.212])
  by fmsmga004.fm.intel.com with ESMTP; 16 Oct 2023 20:21:15 -0700
From: Tina Zhang <tina.zhang@intel.com>
To: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Tina Zhang <tina.zhang@intel.com>
Subject: [RFC PATCH 04/12] iommu/vt-d: Make dev_to_intel_iommu() helper global
Date: Tue, 17 Oct 2023 11:20:36 +0800
Message-Id: <20231017032045.114868-5-tina.zhang@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231017032045.114868-1-tina.zhang@intel.com>
References: <20231017032045.114868-1-tina.zhang@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make dev_to_intel_iommu() global so that it can be used by other files.

Signed-off-by: Tina Zhang <tina.zhang@intel.com>
---
 drivers/iommu/intel/iommu.c | 7 -------
 drivers/iommu/intel/iommu.h | 6 ++++++
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 3685ba90ec88..eeb658d3bc6e 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3609,13 +3609,6 @@ void intel_iommu_shutdown(void)
 	up_write(&dmar_global_lock);
 }
 
-static inline struct intel_iommu *dev_to_intel_iommu(struct device *dev)
-{
-	struct iommu_device *iommu_dev = dev_to_iommu_device(dev);
-
-	return container_of(iommu_dev, struct intel_iommu, iommu);
-}
-
 static ssize_t version_show(struct device *dev,
 			    struct device_attribute *attr, char *buf)
 {
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 7dac94f62b4e..1e972e7edeca 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -842,6 +842,12 @@ void *alloc_pgtable_page(int node, gfp_t gfp);
 void free_pgtable_page(void *vaddr);
 void iommu_flush_write_buffer(struct intel_iommu *iommu);
 struct intel_iommu *device_to_iommu(struct device *dev, u8 *bus, u8 *devfn);
+static inline struct intel_iommu *dev_to_intel_iommu(struct device *dev)
+{
+	struct iommu_device *iommu_dev = dev_to_iommu_device(dev);
+
+	return container_of(iommu_dev, struct intel_iommu, iommu);
+}
 
 #ifdef CONFIG_INTEL_IOMMU_SVM
 void intel_svm_check(struct intel_iommu *iommu);
-- 
2.39.3

