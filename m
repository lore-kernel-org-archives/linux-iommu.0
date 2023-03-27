Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC8A29A9
	for <iommu@lists.linux.dev>; Mon, 27 Mar 2023 23:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679959063; x=1711495063;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PlaKwgtgTDIkuR0MFbRqGUwlPRGR8ZvdcCBZ4YoMyBU=;
  b=cnw+attkwHtnw+w4MHyw+grZ7Yv8arWEsPMI3pRaU+CKY6Xa/h1g1M3R
   F3ZkppDx8w9A9bmh1Yn/c4Q+qT5V9ifjQGHuiBzacucLbWqYDc2S4a07r
   gOQA6C+DbfF2uuxvdYSwOtJ1RXVqOgD8xcU1OP5BlQ6Pt8ZFbEmG+eDh+
   +sgWmvunZTbxQVGTBzRzsjiHllHYkOrVOW2stoqkWgUrp/Hz/HPrqbVLd
   fSJWrraMQIsS9x4EVE/2GG6A/KEwQP6IQdEz1qSFkFIqsoFT//sS5bi+O
   48xCnXuL9BD+UgWTOQQR1tZtQmWx04BvWuk6CN/12NfjWxyU6aKIw5JHy
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="320817345"
X-IronPort-AV: E=Sophos;i="5.98,295,1673942400"; 
   d="scan'208";a="320817345"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 16:17:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="686144744"
X-IronPort-AV: E=Sophos;i="5.98,295,1673942400"; 
   d="scan'208";a="686144744"
Received: from srinivas-otcpl-7600.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.39.106])
  by fmsmga007.fm.intel.com with ESMTP; 27 Mar 2023 16:17:41 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: LKML <linux-kernel@vger.kernel.org>,
	iommu@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>,
	"Lu Baolu" <baolu.lu@linux.intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	dmaengine@vger.kernel.org,
	vkoul@kernel.org
Cc: "Robin Murphy" <robin.murphy@arm.com>,
	"Will Deacon" <will@kernel.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Raj Ashok <ashok.raj@intel.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>,
	"Yu, Fenghua" <fenghua.yu@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Tony Luck <tony.luck@intel.com>,
	"Zanussi, Tom" <tom.zanussi@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v2 7/8] iommu: Export iommu_get_dma_domain
Date: Mon, 27 Mar 2023 16:21:37 -0700
Message-Id: <20230327232138.1490712-8-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230327232138.1490712-1-jacob.jun.pan@linux.intel.com>
References: <20230327232138.1490712-1-jacob.jun.pan@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Devices that use ENQCMDS to submit work needs to retrieve its DMA
domain. It can then attach PASID to the DMA domain for shared mapping
(with RID) established by DMA API.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/iommu.c | 1 +
 include/linux/iommu.h | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 10db680acaed..c51d343a75d2 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2118,6 +2118,7 @@ struct iommu_domain *iommu_get_dma_domain(struct device *dev)
 {
 	return dev->iommu_group->default_domain;
 }
+EXPORT_SYMBOL_GPL(iommu_get_dma_domain);
 
 /*
  * IOMMU groups are really the natural working unit of the IOMMU, but
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 0471089dc1d0..1ef9a1109534 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -1089,6 +1089,11 @@ iommu_get_domain_for_dev_pasid(struct device *dev, ioasid_t pasid,
 {
 	return NULL;
 }
+
+static inline struct iommu_domain *iommu_get_dma_domain(struct device *dev)
+{
+	return NULL;
+}
 #endif /* CONFIG_IOMMU_API */
 
 /**
-- 
2.25.1

