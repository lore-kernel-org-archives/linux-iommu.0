Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FBC539A
	for <iommu@lists.linux.dev>; Thu, 21 Sep 2023 07:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695282890; x=1726818890;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2qafvDTEA4tHJGGUOtUPjMOBwx7ln2B9qY4E8ARD9Lg=;
  b=LzkM8F5VRYWAr4V2S5rbK6kpv6Ps3VrvfN6iRGFL4c0c/yyHOAT74AB5
   C4yw9iW/T81AU7E5sRfRCamFkESXHsVlbRDsybJXdxFbFidMcoRDj3y3u
   d0IlKOFueRoydjhqWuBjfwUFFk0Zk/+z4nZDf5D0KweXu/CsUf2tUJ76b
   j4H46JGiZf9vbXbec8Cm/Nkss9s4hUMFfVrVzzwCwjNb3/yisJEmErB0o
   s+ZaAumVpbx8czszR5nry5Z4sS/aF8wq4LQNuOSv9BNGqalCIH8ba+Wfl
   pB8wsxkhAsHCu6+4zvrMIjtNxYYs6PQuAr8Tt0O20COkXI9ltAhYOIf7g
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="370764388"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; 
   d="scan'208";a="370764388"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 00:54:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="812523053"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; 
   d="scan'208";a="812523053"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga008.fm.intel.com with ESMTP; 21 Sep 2023 00:54:44 -0700
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
	joao.m.martins@oracle.com
Subject: [PATCH v5 02/11] iommu/vt-d: Extend dmar_domain to support nested domain
Date: Thu, 21 Sep 2023 00:54:22 -0700
Message-Id: <20230921075431.125239-3-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921075431.125239-1-yi.l.liu@intel.com>
References: <20230921075431.125239-1-yi.l.liu@intel.com>
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
---
 drivers/iommu/intel/iommu.h | 35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index c18fb699c87a..4a7f1cc16afa 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -597,15 +597,38 @@ struct dmar_domain {
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

