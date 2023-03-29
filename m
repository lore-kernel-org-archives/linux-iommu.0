Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B88187C
	for <iommu@lists.linux.dev>; Wed, 29 Mar 2023 13:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680095887; x=1711631887;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=imHStYRrxsj9AIb6E4TmvcKXjUvzT06u5uoHcPf8iaY=;
  b=MJBAOpOHG7C7eaHDoY7twZOSnejqEKpGWHuJx5JWg71WABqo111q5X4a
   2J8k+hoT54OxODfh+VIDfX2VLDOE3n6kUlSg9Dm0TSouk1Nddegb585Ua
   opxplbp6hUT0HrKENEHuz++yt1RMFlkzwQjsNzo7mOx5TD8W11QxUgvU8
   p1AQNiz6Diw/TtpYHlseEPIrg5xthcYYz3D7xjT/Mw+neORmnZWmGTh4k
   d55HshtZaIWQef1nozMOqvEDXM3Erdy1qSY8z/P5fVxo3NKopfTdi5KSa
   T0/aPyHWnbhlKS9rStRqijgXRiQu3I1GTOXjvfTcrGTlpu3bJv5yDkk6e
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="343293145"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="343293145"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 06:18:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="686821236"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="686821236"
Received: from test.bj.intel.com ([10.238.158.71])
  by fmsmga007.fm.intel.com with ESMTP; 29 Mar 2023 06:18:06 -0700
From: Tina Zhang <tina.zhang@intel.com>
To: iommu@lists.linux.dev
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	Tina Zhang <tina.zhang@intel.com>,
	Yongwei Ma <yongwei.ma@intel.com>
Subject: [PATCH 1/4] iommu/vt-d: Fix null pointer access in invalidate_range callback
Date: Wed, 29 Mar 2023 08:46:51 -0400
Message-Id: <20230329124654.2698853-2-tina.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230329124654.2698853-1-tina.zhang@intel.com>
References: <20230329124654.2698853-1-tina.zhang@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the missing check to avoid null pointer dereference.

The patch fixes below issue reported by klocwork tool:
Pointer 'info' returned from call to function 'dev_iommu_priv_get'
at line 180 may be NULL and may be dereferenced at line 186.

This patch can fix a potential null pointer dereference issue of
releasing a device working in svm mode.

Reported-by: Yongwei Ma <yongwei.ma@intel.com>
Signed-off-by: Tina Zhang <tina.zhang@intel.com>
---
 drivers/iommu/intel/svm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 7367f56c3bad..837c1a4642e7 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -179,7 +179,7 @@ static void __flush_svm_range_dev(struct intel_svm *svm,
 {
 	struct device_domain_info *info = dev_iommu_priv_get(sdev->dev);
 
-	if (WARN_ON(!pages))
+	if (WARN_ON(!info || !pages))
 		return;
 
 	qi_flush_piotlb(sdev->iommu, sdev->did, svm->pasid, address, pages, ih);
-- 
2.34.1

