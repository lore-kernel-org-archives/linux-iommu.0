Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D5623C9
	for <iommu@lists.linux.dev>; Tue, 15 Nov 2022 07:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668497480; x=1700033480;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=f/EQVxj62tLtKfBgUY8KuLhjUMZUtipEPhQ+i2eSZus=;
  b=euX7ZXBz/v4T+3YYc6Tl9i65ZZxvS1QLmBkgIYtfsF3WPaAAimzNde3t
   FA4qi78JbX2m9BCfKPFFCEhnOJARfRHwkTMeLv/ofRZ2Rc7MoiesA3kz6
   qutiM31e0xMlbNGkUfqpYhniOMOSHvR+qjYumDIYrtMxhvMUhxEThgtyi
   ATxX5AX9OSheVdaet0UEHimkDgNlX9njNmb8Ri1Gf2D1dNc573sRl9Ptm
   EBgigDySDQ7UXYkv5KI8joJJCwjZer8ZfHbwm+GxK9Tqr6YKDX2IVk1v6
   ZP8XF9mgzDGzeJ23IvVvmUgnMo4BZ0PieRztYDnTE+KO4TzSEsCQGdpuP
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="312190313"
X-IronPort-AV: E=Sophos;i="5.96,165,1665471600"; 
   d="scan'208";a="312190313"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 23:31:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="702333190"
X-IronPort-AV: E=Sophos;i="5.96,165,1665471600"; 
   d="scan'208";a="702333190"
Received: from test.bj.intel.com ([10.238.158.71])
  by fmsmga008.fm.intel.com with ESMTP; 14 Nov 2022 23:31:18 -0800
From: Tina Zhang <tina.zhang@intel.com>
To: iommu@lists.linux.dev
Cc: baolu.lu@linux.intel.com,
	Tina Zhang <tina.zhang@intel.com>
Subject: [PATCH v2] iommu/vt-d: Set SRE bit when hardware has SRS cap
Date: Tue, 15 Nov 2022 02:03:46 -0500
Message-Id: <20221115070346.1112273-1-tina.zhang@intel.com>
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

V2: Add SRS cap checking in intel_pasid_setup_second_level()

Fixes: 6f7db75e1c46 ("iommu/vt-d: Add second level page table interface")
Signed-off-by: Tina Zhang <tina.zhang@intel.com>
---
 drivers/iommu/intel/pasid.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index c30ddac40ee5..23dee5db7439 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -642,7 +642,7 @@ int intel_pasid_setup_second_level(struct intel_iommu *iommu,
 	 * Since it is a second level only translation setup, we should
 	 * set SRE bit as well (addresses are expected to be GPAs).
 	 */
-	if (pasid != PASID_RID2PASID)
+	if ((pasid != PASID_RID2PASID) && ecap_srs(iommu->ecap))
 		pasid_set_sre(pte);
 	pasid_set_present(pte);
 	spin_unlock(&iommu->lock);
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

