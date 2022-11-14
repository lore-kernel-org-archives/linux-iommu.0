Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321A923A8
	for <iommu@lists.linux.dev>; Mon, 14 Nov 2022 09:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668417768; x=1699953768;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uJU2+7AiuWbeXCEmvvU/iSSjs/WzqaYsyF5mup6/980=;
  b=F6tonpghIAxyYRzwuSxQ/D8Chz6sx4MiIGkX43v3v5KODQJMkrYfXuwn
   njJFk3LZMNH7bUZF06RYmhC2l25bX27LW3JE1W2wWX0xEydUNF6Nw5BK5
   xG8JNXFH4Q7mbQbEn+OQunTs7C2tq8rfEZlOP9VAPKTAkBDIaURuZVd+e
   N7ja3m4SUSTIzaTnhvRi1q4aRWu7YmrGDDmsYNc/bOSTcHvwMDxeK8e3m
   529+BWsUhRH5kksnyXLTkEjuH+qS83FIFGqkjqh6nCbTvMe3Q81cf1WbK
   SiyW2sE+Fest8pAjna/U+ihKjyKtKpX3HX0Gg1fgdSXGBbU5Xzgr0u53a
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="295285285"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="295285285"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 01:22:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="701931366"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="701931366"
Received: from test.bj.intel.com ([10.238.158.71])
  by fmsmga008.fm.intel.com with ESMTP; 14 Nov 2022 01:22:45 -0800
From: Tina Zhang <tina.zhang@intel.com>
To: iommu@lists.linux.dev
Cc: baolu.lu@linux.intel.com,
	Tina Zhang <tina.zhang@intel.com>
Subject: [PATCH] iommu/vt-d: Set SRE bit when hardware has SRS cap
Date: Mon, 14 Nov 2022 03:55:14 -0500
Message-Id: <20221114085514.1105039-1-tina.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SRS cap is the hardware cap telling if the hardware IOMMU can support
requests seeking supervisor privilege or not. SRE bit in scalable-mode
PASID table entry is treated as Reserved(0) for implementation not
supporting SRS cap.

Checking SRS cap before setting SRE bit can avoid the non-recoverable
fault of "Non-zero reserved field set in PASID Table Entry" caused by
setting SRE bit while there is no SRS cap support.

Currently, both intel_pasid_setup_first_level() and
intel_pasid_setup_second_level() implicitly take care about of it. The
only missing SRS cap checking is in intel_pasid_setup_pass_through().

Fixes: 6f7db75e1c46 ("iommu/vt-d: Add second level page table interface")
Signed-off-by: Tina Zhang <tina.zhang@intel.com>
---
 drivers/iommu/intel/pasid.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index c30ddac40ee5..4a59035a5181 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -685,7 +685,8 @@ int intel_pasid_setup_pass_through(struct intel_iommu *iommu,
 	 * We should set SRE bit as well since the addresses are expected
 	 * to be GPAs.
 	 */
-	pasid_set_sre(pte);
+	if (ecap_srs(iommu->ecap))
+		pasid_set_sre(pte);
 	pasid_set_present(pte);
 	spin_unlock(&iommu->lock);
 
-- 
2.25.1

