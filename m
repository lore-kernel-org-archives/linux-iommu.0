Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896CC10E0
	for <iommu@lists.linux.dev>; Tue, 21 Jun 2022 14:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655822907; x=1687358907;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ycx1bkVXPrbmcJKHWTEOkCYhcIUfTBYC7pxFYcHJfLU=;
  b=SSwvMmKf5WYs9kDlV+JbhpsEdZiuwmB7RGWpicaZFrp6RAVd0Mo7wqgU
   5ECh+T3IYDMkoU7o5sW712j6iZ0orNeG7qRZ7mkaxSSJj5yKmDPqMEblw
   /8jDnL5E7lSe5jfIkcTMqaE4xbkUb94vrbNKJvkoFeJmTREAoHPJGWNVk
   bcKLjB3l8sfQX8W4GjAdgbpbg+ZAOOYaWsdFYfCdWEgvuHNL/dakuTRjb
   JIkJbkMjvvZ+i1auM/6ZDd4JdqNC59UQ5Wh+14RKXTfa6ul7QW6IvWHNZ
   G+5cF2k5I/fD0rsz35UCG5fJcM6gQ/Mu6VkQD+0jOsnY3kv6Q1MjDLarx
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10384"; a="280867157"
X-IronPort-AV: E=Sophos;i="5.92,209,1650956400"; 
   d="scan'208";a="280867157"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 07:48:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,209,1650956400"; 
   d="scan'208";a="643659292"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga008.fm.intel.com with ESMTP; 21 Jun 2022 07:48:20 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Christoph Hellwig <hch@infradead.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Ashok Raj <ashok.raj@intel.com>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vinod Koul <vkoul@kernel.org>
Cc: Eric Auger <eric.auger@redhat.com>,
	Liu Yi L <yi.l.liu@intel.com>,
	Jacob jun Pan <jacob.jun.pan@intel.com>,
	iommu@lists.linux-foundation.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v9 05/11] iommu/vt-d: Add SVA domain support
Date: Tue, 21 Jun 2022 22:43:47 +0800
Message-ID: <20220621144353.17547-6-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220621144353.17547-1-baolu.lu@linux.intel.com>
References: <20220621144353.17547-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <20220621144347.SwwtHKLC2AViQj6_jgaftUydMduESVnVTFV2Ld7yof4@z>

Add support for SVA domain allocation and provide an SVA-specific
iommu_domain_ops.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/intel-iommu.h |  5 ++++
 drivers/iommu/intel/iommu.c |  2 ++
 drivers/iommu/intel/svm.c   | 49 +++++++++++++++++++++++++++++++++++++
 3 files changed, 56 insertions(+)

diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 31e3edc0fc7e..9007428a68f1 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -743,6 +743,7 @@ void intel_svm_unbind(struct iommu_sva *handle);
 u32 intel_svm_get_pasid(struct iommu_sva *handle);
 int intel_svm_page_response(struct device *dev, struct iommu_fault_event *evt,
 			    struct iommu_page_response *msg);
+struct iommu_domain *intel_svm_domain_alloc(void);
 
 struct intel_svm_dev {
 	struct list_head list;
@@ -768,6 +769,10 @@ struct intel_svm {
 };
 #else
 static inline void intel_svm_check(struct intel_iommu *iommu) {}
+static inline struct iommu_domain *intel_svm_domain_alloc(void)
+{
+	return NULL;
+}
 #endif
 
 #ifdef CONFIG_INTEL_IOMMU_DEBUGFS
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 44016594831d..993a1ce509a8 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4298,6 +4298,8 @@ static struct iommu_domain *intel_iommu_domain_alloc(unsigned type)
 		return domain;
 	case IOMMU_DOMAIN_IDENTITY:
 		return &si_domain->domain;
+	case IOMMU_DOMAIN_SVA:
+		return intel_svm_domain_alloc();
 	default:
 		return NULL;
 	}
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index d04880a291c3..7d4f9d173013 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -931,3 +931,52 @@ int intel_svm_page_response(struct device *dev,
 	mutex_unlock(&pasid_mutex);
 	return ret;
 }
+
+static int intel_svm_set_dev_pasid(struct iommu_domain *domain,
+				   struct device *dev, ioasid_t pasid)
+{
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct intel_iommu *iommu = info->iommu;
+	struct mm_struct *mm = domain->mm;
+	struct iommu_sva *sva;
+	int ret = 0;
+
+	mutex_lock(&pasid_mutex);
+	sva = intel_svm_bind_mm(iommu, dev, mm);
+	if (IS_ERR(sva))
+		ret = PTR_ERR(sva);
+	mutex_unlock(&pasid_mutex);
+
+	return ret;
+}
+
+static void intel_svm_block_dev_pasid(struct iommu_domain *domain,
+				      struct device *dev, ioasid_t pasid)
+{
+	mutex_lock(&pasid_mutex);
+	intel_svm_unbind_mm(dev, pasid);
+	mutex_unlock(&pasid_mutex);
+}
+
+static void intel_svm_domain_free(struct iommu_domain *domain)
+{
+	kfree(to_dmar_domain(domain));
+}
+
+static const struct iommu_domain_ops intel_svm_domain_ops = {
+	.set_dev_pasid		= intel_svm_set_dev_pasid,
+	.block_dev_pasid	= intel_svm_block_dev_pasid,
+	.free			= intel_svm_domain_free,
+};
+
+struct iommu_domain *intel_svm_domain_alloc(void)
+{
+	struct dmar_domain *domain;
+
+	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
+	if (!domain)
+		return NULL;
+	domain->domain.ops = &intel_svm_domain_ops;
+
+	return &domain->domain;
+}
-- 
2.25.1

