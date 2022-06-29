Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0522C7F1
	for <iommu@lists.linux.dev>; Wed, 29 Jun 2022 07:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656489120; x=1688025120;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hkGm7YDPu5xil+VGf8bn6+rNMEI6Bw40A3ib6a6DFDY=;
  b=DQd4gbrNpbxrV82hwV1ziiS6iEDlMvCLixs45P9KjGC9LYWz0dzGcgTR
   zqbdRzWN5aRD0Cwl9B9GpWaXtGc91qvHbk/FpgWPBvh9xJnFAVF4JyKrE
   c0K209c/dOrNg6a6pt5nd5dWEcOmKMoSqI614rWSRKT5VnN0lHy4PYw7r
   RbCSAf0JuXCMs1VfRdEM+ISBFPgd+h01VHH6gihA1sIAFwxTyA2SumvZU
   VM3F0SXd+6R0bFf8YBD1FUvUAtziyGBdZQ6P4w25ysFkAWPW1dFrcKTPW
   kavYhCTVnSohgYnuQxWnNcgJmwMDjwnj3kfOiVJlu8y/GcbYEzZ6j/U59
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="280718504"
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; 
   d="scan'208";a="280718504"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 00:51:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; 
   d="scan'208";a="588209588"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga007.jf.intel.com with ESMTP; 29 Jun 2022 00:51:54 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: iommu@lists.linux-foundation.org,
	iommu@lists.linux.dev
Cc: Kevin Tian <kevin.tian@intel.com>,
	Ashok Raj <ashok.raj@intel.com>,
	Liu Yi L <yi.l.liu@intel.com>,
	Jacob jun Pan <jacob.jun.pan@intel.com>,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v3 02/11] iommu/vt-d: Remove clearing translation data in disable_dmar_iommu()
Date: Wed, 29 Jun 2022 15:47:16 +0800
Message-ID: <20220629074725.2331441-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220629074725.2331441-1-baolu.lu@linux.intel.com>
References: <20220629074725.2331441-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <20220629074716.Gol5sZ0S0-VMf6Z9-3SSWSXve94C67-OtSekTY8Cz68@z>

The disable_dmar_iommu() is called when IOMMU initialization fails or
the IOMMU is hot-removed from the system. In both cases, there is no
need to clear the IOMMU translation data structures for devices.

On the initialization path, the device probing only happens after the
IOMMU is initialized successfully, hence there're no translation data
structures.

On the hot-remove path, there is no real use case where the IOMMU is
hot-removed, but the devices that it manages are still alive in the
system. The translation data structures were torn down during device
release, hence there's no need to repeat it in IOMMU hot-remove path
either. This removes the unnecessary code and only leaves a check.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/pasid.h |  1 +
 drivers/iommu/intel/iommu.c | 21 +++++++--------------
 2 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/intel/pasid.h b/drivers/iommu/intel/pasid.h
index bf5b937848b4..20c54e50f533 100644
--- a/drivers/iommu/intel/pasid.h
+++ b/drivers/iommu/intel/pasid.h
@@ -39,6 +39,7 @@
  * only and pass-through transfer modes.
  */
 #define FLPT_DEFAULT_DID		1
+#define NUM_RESERVED_DID		2
 
 /*
  * The SUPERVISOR_MODE flag indicates a first level translation which
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 3b6571681bdd..43aaec5bdd84 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1716,23 +1716,16 @@ static int iommu_init_domains(struct intel_iommu *iommu)
 
 static void disable_dmar_iommu(struct intel_iommu *iommu)
 {
-	struct device_domain_info *info, *tmp;
-	unsigned long flags;
-
 	if (!iommu->domain_ids)
 		return;
 
-	spin_lock_irqsave(&device_domain_lock, flags);
-	list_for_each_entry_safe(info, tmp, &device_domain_list, global) {
-		if (info->iommu != iommu)
-			continue;
-
-		if (!info->dev || !info->domain)
-			continue;
-
-		__dmar_remove_one_dev_info(info);
-	}
-	spin_unlock_irqrestore(&device_domain_lock, flags);
+	/*
+	 * All iommu domains must have been detached from the devices,
+	 * hence there should be no domain IDs in use.
+	 */
+	if (WARN_ON(bitmap_weight(iommu->domain_ids, cap_ndoms(iommu->cap))
+		    > NUM_RESERVED_DID))
+		return;
 
 	if (iommu->gcmd & DMA_GCMD_TE)
 		iommu_disable_translation(iommu);
-- 
2.25.1

