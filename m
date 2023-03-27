Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1546929A9
	for <iommu@lists.linux.dev>; Mon, 27 Mar 2023 23:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679959061; x=1711495061;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qgUzvbGBHIHc0aGK2Q/F/EqhcZ8UqxtTsN6J1Ti6Lks=;
  b=EYUDvPEw3Mml0WwsU1FLNFSLiGpS40HJnC0ixhoNC+KYv37T+2TqxNwK
   LZlyARLZbd6TUqZkHXuY49Hu1LYnsn7F71PdowY9an9P1QyOsIeadkgbm
   H5seiTiVZxWLXQv1HTWg7ivMBorKYm9w0g8pCOH3hOakTcAyageUZtnQn
   oOdFmmnKVWpeIvvg5YhCUjmSzMg+/cHoL3zpx0Q8skn2yhAO8YEbQT2lZ
   EHbtTzck7YUgqfHNyG4adT2b/jIfZLxP2TeADcUuhIrpFAkQrrj4flkir
   lWBx5ZIYzRzJjwPmrTvteE6S762IcVTLPrcJYjD2pC8x5sB36MK538ICt
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="320817320"
X-IronPort-AV: E=Sophos;i="5.98,295,1673942400"; 
   d="scan'208";a="320817320"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 16:17:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="686144729"
X-IronPort-AV: E=Sophos;i="5.98,295,1673942400"; 
   d="scan'208";a="686144729"
Received: from srinivas-otcpl-7600.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.39.106])
  by fmsmga007.fm.intel.com with ESMTP; 27 Mar 2023 16:17:38 -0700
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
Subject: [PATCH v2 4/8] iommu/vt-d: Reserve RID_PASID from global SVA PASID space
Date: Mon, 27 Mar 2023 16:21:34 -0700
Message-Id: <20230327232138.1490712-5-jacob.jun.pan@linux.intel.com>
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

On VT-d platforms, RID_PASID is used for DMA request without PASID. We
should not treat RID_PASID special instead let it be allocated from the
global SVA PASID number space.

Consequently, for devices also do DMA with PASID, drivers will not worry
about conflicts when it comes to allocating PASIDs for in-kernel DMA.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 9f737ef55463..61c06f7ad8f7 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3956,6 +3956,10 @@ int __init intel_iommu_init(void)
 
 	intel_iommu_enabled = 1;
 
+#ifdef CONFIG_INTEL_IOMMU_SVM
+	/* Reserved RID_PASID from the global namespace for legacy DMA */
+	iommu_sva_reserve_pasid(PASID_RID2PASID, PASID_RID2PASID);
+#endif
 	return 0;
 
 out_free_dmar:
-- 
2.25.1

