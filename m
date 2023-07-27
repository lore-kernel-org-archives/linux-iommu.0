Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79B28BEA
	for <iommu@lists.linux.dev>; Thu, 27 Jul 2023 05:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690437087; x=1721973087;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OrB4GkbjupQVUOggSlcnw0nzLKoABWATL0bGy51+mmY=;
  b=Zv04eCerdeZyPVF/qTIQdulAavEEpRX05V0Zm8X1YTAZk2EA6bua7wuK
   iJ3aMXwt84WPpC2+wV7iFy6BtvyM6kI623TOFc+O4d4ScAnEwGf1sHpgM
   I7P37qGqBq5z1SVgOxyfAU8LE+f1z5eRmazTNKHWlglyEibQOvKGjLtC0
   6aHEe8/0AJtgA8ogbcRmqkV56R2hR/PPr6iuXMAH4QtwKUU88mlX1jBoH
   haj69OeLxtX7U/2kcn0NdhlD/1Yhv3S9cfp57QA14tX7wGIv0/fKXcIvY
   XT/b/ZqsLNLDL5aAFrz+GSHnL7498GfalIkKsBFdJXyLw5Efl1C4DkiNS
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="399152664"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="399152664"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 22:51:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="840585335"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="840585335"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmsmga002.fm.intel.com with ESMTP; 26 Jul 2023 22:51:24 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>
Cc: Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	iommu@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 12/12] iommu: Add helper to set iopf handler for domain
Date: Thu, 27 Jul 2023 13:48:37 +0800
Message-Id: <20230727054837.147050-13-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230727054837.147050-1-baolu.lu@linux.intel.com>
References: <20230727054837.147050-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To avoid open code everywhere.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/iommu.h | 11 ++++++++++-
 drivers/iommu/iommu.c | 20 ++++++++++++++++++--
 2 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index d725500344a4..4e0b75befefc 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -132,6 +132,7 @@ struct iommu_page_response {
 
 typedef int (*iommu_fault_handler_t)(struct iommu_domain *,
 			struct device *, unsigned long, int, void *);
+typedef int (*iommu_iopf_handler_t)(struct iopf_group *group);
 
 struct iommu_domain_geometry {
 	dma_addr_t aperture_start; /* First address that can be mapped    */
@@ -181,7 +182,7 @@ struct iommu_domain {
 	unsigned long pgsize_bitmap;	/* Bitmap of page sizes in use */
 	struct iommu_domain_geometry geometry;
 	struct iommu_dma_cookie *iova_cookie;
-	int (*iopf_handler)(struct iopf_group *group);
+	iommu_iopf_handler_t iopf_handler;
 	void *fault_data;
 	union {
 		struct {
@@ -581,6 +582,8 @@ extern ssize_t iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
 extern phys_addr_t iommu_iova_to_phys(struct iommu_domain *domain, dma_addr_t iova);
 extern void iommu_set_fault_handler(struct iommu_domain *domain,
 			iommu_fault_handler_t handler, void *token);
+void iommu_domain_set_iopf_handler(struct iommu_domain *domain,
+				   iommu_iopf_handler_t handler, void *data);
 
 extern void iommu_get_resv_regions(struct device *dev, struct list_head *list);
 extern void iommu_put_resv_regions(struct device *dev, struct list_head *list);
@@ -904,6 +907,12 @@ static inline void iommu_set_fault_handler(struct iommu_domain *domain,
 {
 }
 
+static inline void iommu_domain_set_iopf_handler(struct iommu_domain *domain,
+						 iommu_iopf_handler_t handler,
+						 void *data)
+{
+}
+
 static inline void iommu_get_resv_regions(struct device *dev,
 					struct list_head *list)
 {
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 9d964d16d0ad..2254b0ef91fb 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1839,6 +1839,23 @@ void iommu_set_fault_handler(struct iommu_domain *domain,
 }
 EXPORT_SYMBOL_GPL(iommu_set_fault_handler);
 
+/**
+ * iommu_domain_set_iopf_handler() - set io page fault handler for a domain
+ * @domain: iommu domain
+ * @handler: fault handler
+ * @data: user data, will be passed back to the fault handler
+ *
+ * This function should be used by iommu domain users which want to be notified
+ * whenever an IOMMU I/O page fault happens.
+ */
+void iommu_domain_set_iopf_handler(struct iommu_domain *domain,
+				   iommu_iopf_handler_t handler, void *data)
+{
+	domain->iopf_handler = handler;
+	domain->fault_data = data;
+}
+EXPORT_SYMBOL_GPL(iommu_domain_set_iopf_handler);
+
 static struct iommu_domain *__iommu_domain_alloc(const struct bus_type *bus,
 						 unsigned type)
 {
@@ -3328,8 +3345,7 @@ struct iommu_domain *iommu_sva_domain_alloc(struct device *dev,
 	domain->type = IOMMU_DOMAIN_SVA;
 	mmgrab(mm);
 	domain->mm = mm;
-	domain->iopf_handler = iommu_sva_handle_iopf_group;
-	domain->fault_data = mm;
+	iommu_domain_set_iopf_handler(domain, iommu_sva_handle_iopf_group, mm);
 
 	return domain;
 }
-- 
2.34.1

