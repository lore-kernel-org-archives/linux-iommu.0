Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE244848A
	for <iommu@lists.linux.dev>; Fri,  7 Apr 2023 18:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680890513; x=1712426513;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JiKWRtMCJrQDoJeK3U/0yd9kaHBuQqQPeP9njgeoB0o=;
  b=S39BH4Xfxs2H3IXMYH9XKOM3j82xxQbeMdeFEJo+isJLdgr59ESQFEgM
   7CIUlxUCnZhx1Q4+ukNr4q83MbwCGAOoVaIrTJ9M8F4G+C1UVrNn6lFG6
   M0XSDHsLPRPxL6FYgQmpKgS2KPFx/iIUsSs11e4OqoaWwCoAB2nH6+MkN
   L6Kv0IYJ0/gBkgTVoiDxgDJemhiCCKS2JMhU+dWVons8BaTUCBFLSsS23
   eOH6ozmhKwBIvLECsCsl12Gki32GoWRfWeYjffUHtbUc7UMeM/DGWWh/E
   EZgHeh0PUzpLCdlh4klsEoJth4tKSfN1Mi3N3aOJ1aFNw1XtzGo0GtJ19
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="343046456"
X-IronPort-AV: E=Sophos;i="5.98,327,1673942400"; 
   d="scan'208";a="343046456"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2023 11:01:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="776910042"
X-IronPort-AV: E=Sophos;i="5.98,327,1673942400"; 
   d="scan'208";a="776910042"
Received: from srinivas-otcpl-7600.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.39.106])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Apr 2023 11:01:49 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: LKML <linux-kernel@vger.kernel.org>,
	iommu@lists.linux.dev,
	"Robin Murphy" <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	"Lu Baolu" <baolu.lu@linux.intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	dmaengine@vger.kernel.org,
	vkoul@kernel.org
Cc: "Will Deacon" <will@kernel.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Raj Ashok <ashok.raj@intel.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>,
	"Yu, Fenghua" <fenghua.yu@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Tony Luck <tony.luck@intel.com>,
	"Zanussi, Tom" <tom.zanussi@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v4 2/7] iommu/vt-d: Remove PASID supervisor request support
Date: Fri,  7 Apr 2023 11:05:49 -0700
Message-Id: <20230407180554.2784285-3-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230407180554.2784285-1-jacob.jun.pan@linux.intel.com>
References: <20230407180554.2784285-1-jacob.jun.pan@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

There's no more usage,  remove PASID supervisor support.

Suggested-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel/pasid.c | 43 -------------------------------------
 drivers/iommu/intel/pasid.h |  7 ------
 2 files changed, 50 deletions(-)

diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 633e0a4a01e7..c5d479770e12 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -335,15 +335,6 @@ static inline void pasid_set_fault_enable(struct pasid_entry *pe)
 	pasid_set_bits(&pe->val[0], 1 << 1, 0);
 }
 
-/*
- * Setup the SRE(Supervisor Request Enable) field (Bit 128) of a
- * scalable mode PASID entry.
- */
-static inline void pasid_set_sre(struct pasid_entry *pe)
-{
-	pasid_set_bits(&pe->val[2], 1 << 0, 1);
-}
-
 /*
  * Setup the WPE(Write Protect Enable) field (Bit 132) of a
  * scalable mode PASID entry.
@@ -521,23 +512,6 @@ int intel_pasid_setup_first_level(struct intel_iommu *iommu,
 		return -EINVAL;
 	}
 
-	if (flags & PASID_FLAG_SUPERVISOR_MODE) {
-#ifdef CONFIG_X86
-		unsigned long cr0 = read_cr0();
-
-		/* CR0.WP is normally set but just to be sure */
-		if (unlikely(!(cr0 & X86_CR0_WP))) {
-			pr_err("No CPU write protect!\n");
-			return -EINVAL;
-		}
-#endif
-		if (!ecap_srs(iommu->ecap)) {
-			pr_err("No supervisor request support on %s\n",
-			       iommu->name);
-			return -EINVAL;
-		}
-	}
-
 	if ((flags & PASID_FLAG_FL5LP) && !cap_fl5lp_support(iommu->cap)) {
 		pr_err("No 5-level paging support for first-level on %s\n",
 		       iommu->name);
@@ -560,10 +534,6 @@ int intel_pasid_setup_first_level(struct intel_iommu *iommu,
 
 	/* Setup the first level page table pointer: */
 	pasid_set_flptr(pte, (u64)__pa(pgd));
-	if (flags & PASID_FLAG_SUPERVISOR_MODE) {
-		pasid_set_sre(pte);
-		pasid_set_wpe(pte);
-	}
 
 	if (flags & PASID_FLAG_FL5LP)
 		pasid_set_flpm(pte, 1);
@@ -658,12 +628,6 @@ int intel_pasid_setup_second_level(struct intel_iommu *iommu,
 	pasid_set_fault_enable(pte);
 	pasid_set_page_snoop(pte, !!ecap_smpwc(iommu->ecap));
 
-	/*
-	 * Since it is a second level only translation setup, we should
-	 * set SRE bit as well (addresses are expected to be GPAs).
-	 */
-	if (pasid != PASID_RID2PASID && ecap_srs(iommu->ecap))
-		pasid_set_sre(pte);
 	pasid_set_present(pte);
 	spin_unlock(&iommu->lock);
 
@@ -700,13 +664,6 @@ int intel_pasid_setup_pass_through(struct intel_iommu *iommu,
 	pasid_set_translation_type(pte, PASID_ENTRY_PGTT_PT);
 	pasid_set_fault_enable(pte);
 	pasid_set_page_snoop(pte, !!ecap_smpwc(iommu->ecap));
-
-	/*
-	 * We should set SRE bit as well since the addresses are expected
-	 * to be GPAs.
-	 */
-	if (ecap_srs(iommu->ecap))
-		pasid_set_sre(pte);
 	pasid_set_present(pte);
 	spin_unlock(&iommu->lock);
 
diff --git a/drivers/iommu/intel/pasid.h b/drivers/iommu/intel/pasid.h
index 20c54e50f533..d6b7d21244b1 100644
--- a/drivers/iommu/intel/pasid.h
+++ b/drivers/iommu/intel/pasid.h
@@ -41,13 +41,6 @@
 #define FLPT_DEFAULT_DID		1
 #define NUM_RESERVED_DID		2
 
-/*
- * The SUPERVISOR_MODE flag indicates a first level translation which
- * can be used for access to kernel addresses. It is valid only for
- * access to the kernel's static 1:1 mapping of physical memory — not
- * to vmalloc or even module mappings.
- */
-#define PASID_FLAG_SUPERVISOR_MODE	BIT(0)
 #define PASID_FLAG_NESTED		BIT(1)
 #define PASID_FLAG_PAGE_SNOOP		BIT(2)
 
-- 
2.25.1

