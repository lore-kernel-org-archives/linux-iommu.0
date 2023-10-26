Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD24E5380
	for <iommu@lists.linux.dev>; Thu, 26 Oct 2023 04:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OZzrrC1N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698295343; x=1729831343;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ES8n81i3PjoHeEkR3Se1CXSo3INruHcGQ//e8Uega0E=;
  b=OZzrrC1Nf5dDouyzgG6sR5LJXGBw0ftnxMFKI7Gx2+n3tBaTUnbL6qNf
   ahi33E6xVbXY6UTdMHmByNyiObbi3mf+2eaAXcL9YIxRAH8x7HaWCg/Du
   Jn19zOEEA4Yq0uq3SVyN2zcvfDZ7aHb3/K9trd6h1+9NzHEWtbjUs3yKv
   dXAqK/jfjSr7z+MlStVB0rIO8XM1lJ31+l7z8qMlPRSHeMcfLDiDSiC8g
   psPCY/JkQZw4Pr+Y5VAUGeiXfO8KDkYrwg5WThtEEiIFtlQR9x7eJqA/K
   jgyg5ZSlounFFlaPSnwUXBVik3xFJKPdA0ZXRN0xN1981wqp40Pw5iJke
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="367670733"
X-IronPort-AV: E=Sophos;i="6.03,252,1694761200"; 
   d="scan'208";a="367670733"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 21:42:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="829478515"
X-IronPort-AV: E=Sophos;i="6.03,252,1694761200"; 
   d="scan'208";a="829478515"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga004.fm.intel.com with ESMTP; 25 Oct 2023 21:42:20 -0700
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
	xin.zeng@intel.com
Subject: [PATCH v8 2/8] iommu/vt-d: Extend dmar_domain to support nested domain
Date: Wed, 25 Oct 2023 21:42:10 -0700
Message-Id: <20231026044216.64964-3-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026044216.64964-1-yi.l.liu@intel.com>
References: <20231026044216.64964-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lu Baolu <baolu.lu@linux.intel.com>

The nested domain fields are exclusive to those that used for a DMA
remapping domain. Use union to avoid memory waste.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/intel/iommu.h | 36 ++++++++++++++++++++++++++++++------
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index cc7301579773..244f111ea0bb 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -25,6 +25,7 @@
 
 #include <asm/cacheflush.h>
 #include <asm/iommu.h>
+#include <uapi/linux/iommufd.h>
 
 /*
  * VT-d hardware uses 4KiB page size regardless of host page size.
@@ -605,15 +606,38 @@ struct dmar_domain {
 	struct list_head devices;	/* all devices' list */
 	struct list_head dev_pasids;	/* all attached pasids */
 
-	struct dma_pte	*pgd;		/* virtual address */
-	int		gaw;		/* max guest address width */
-
-	/* adjusted guest address width, 0 is level 2 30-bit */
-	int		agaw;
 	int		iommu_superpage;/* Level of superpages supported:
 					   0 == 4KiB (no superpages), 1 == 2MiB,
 					   2 == 1GiB, 3 == 512GiB, 4 == 1TiB */
-	u64		max_addr;	/* maximum mapped address */
+	union {
+		/* DMA remapping domain */
+		struct {
+			/* virtual address */
+			struct dma_pte	*pgd;
+			/* max guest address width */
+			int		gaw;
+			/*
+			 * adjusted guest address width:
+			 *   0: level 2 30-bit
+			 *   1: level 3 39-bit
+			 *   2: level 4 48-bit
+			 *   3: level 5 57-bit
+			 */
+			int		agaw;
+			/* maximum mapped address */
+			u64		max_addr;
+		};
+
+		/* Nested user domain */
+		struct {
+			/* parent page table which the user domain is nested on */
+			struct dmar_domain *s2_domain;
+			/* user page table pointer (in GPA) */
+			unsigned long s1_pgtbl;
+			/* page table attributes */
+			struct iommu_hwpt_vtd_s1 s1_cfg;
+		};
+	};
 
 	struct iommu_domain domain;	/* generic domain data structure for
 					   iommu core */
-- 
2.34.1

