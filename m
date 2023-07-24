Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E236D5679
	for <iommu@lists.linux.dev>; Mon, 24 Jul 2023 11:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690197227; x=1721733227;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Evb/uH75XnFTXbrCht5Yjl6IDfDcpiTHryTOzFFcMAQ=;
  b=h3o5pnDT5/KWnZtKO87Ady4zUBbTYiVUFdFY0RiDAEAu7UCp+VDIOqBA
   GakAV+T5waYMkOMsacNhZrgL2CzFSeaWzsp2bpDuK/Fyg7KfW59na9gXU
   DRfAY/INok270TtAqNdf0iLKlxEC1p8CWpSu6NM1pzDnkYuWKb9sndrfo
   yBX/UJVOyU4wgMzWtdZ6snw/XOe1jpPxQ937XabDNWB0dUCs7qCiWunzL
   VQn/e98ncMLZ5+lHHJasyfn80QiNwXQQG8w9doOOz7ZN1zDZYdQslLi6c
   g5xD392inpg4qXToFD+rVGwRyFD742O1Vt3aVzf/rhT5uv/NHC8nq32+e
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="347015024"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="347015024"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 04:13:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="839415556"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="839415556"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga002.fm.intel.com with ESMTP; 24 Jul 2023 04:13:46 -0700
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
	zhenzhong.duan@intel.com
Subject: [PATCH v4 08/12] iommu/vt-d: Make iotlb flush helpers to be extern
Date: Mon, 24 Jul 2023 04:13:30 -0700
Message-Id: <20230724111335.107427-9-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230724111335.107427-1-yi.l.liu@intel.com>
References: <20230724111335.107427-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This makes the helpers visible to nested.c.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/intel/iommu.c | 10 +++++-----
 drivers/iommu/intel/iommu.h |  6 ++++++
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 289e8c2417ad..3119a79ebc83 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1466,10 +1466,10 @@ static void iommu_flush_dev_iotlb(struct dmar_domain *domain,
 	spin_unlock_irqrestore(&domain->lock, flags);
 }
 
-static void iommu_flush_iotlb_psi(struct intel_iommu *iommu,
-				  struct dmar_domain *domain,
-				  unsigned long pfn, unsigned int pages,
-				  int ih, int map)
+void iommu_flush_iotlb_psi(struct intel_iommu *iommu,
+			   struct dmar_domain *domain,
+			   unsigned long pfn, unsigned int pages,
+			   int ih, int map)
 {
 	unsigned int aligned_pages = __roundup_pow_of_two(pages);
 	unsigned int mask = ilog2(aligned_pages);
@@ -1542,7 +1542,7 @@ static inline void __mapping_notify_one(struct intel_iommu *iommu,
 		iommu_flush_write_buffer(iommu);
 }
 
-static void intel_flush_iotlb_all(struct iommu_domain *domain)
+void intel_flush_iotlb_all(struct iommu_domain *domain)
 {
 	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
 	struct iommu_domain_info *info;
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 4b12166a9c3f..5b292213bcb8 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -859,6 +859,12 @@ int prepare_domain_attach_device(struct iommu_domain *domain,
 				 struct device *dev);
 bool intel_iommu_enforce_cache_coherency(struct iommu_domain *domain);
 void domain_update_iommu_cap(struct dmar_domain *domain);
+void iommu_flush_iotlb_psi(struct intel_iommu *iommu,
+			   struct dmar_domain *domain,
+			   unsigned long pfn, unsigned int pages,
+			   int ih, int map);
+void intel_flush_iotlb_all(struct iommu_domain *domain);
+
 
 int dmar_ir_support(void);
 
-- 
2.34.1

