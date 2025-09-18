Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9797127C162
	for <iommu@lists.linux.dev>; Thu, 18 Sep 2025 05:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758171849; cv=none; b=D096x/SY531Nu7yV2/UGK131Xjb9zIK9ZSQ2gLiq21qRso6zm4BAcbF7NouUAWatYJmhDT5gZwVw8Kyx1pac8Wp15eSa7his2q6T+l4nqYer0VoXPROF88hfD9XzaY1v8PxfvtJ3e1z68d6fHM8ef62QifdyXcC6bfUUzxwG0BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758171849; c=relaxed/simple;
	bh=agWi5rS8mtHtpuBk3+yZ7A10OphKCTIfwAfaBMo3pEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZI0KkgWtqve6z4DKjfIO2eqdKWptm8pclNmFqu6j0UsV+UV7PJr6K0lDjraV3uHob5vb2YHU+OaIT/j6t/o7b2YShwCLXvStiGAvQAeGVsrOVUxKvRPYqTRpeLjTykH1lU5d/Q1k/iaBhbcNVjwLwQG5Voreh+AIKZisaoOOFik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eaxW+r+6; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eaxW+r+6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758171847; x=1789707847;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=agWi5rS8mtHtpuBk3+yZ7A10OphKCTIfwAfaBMo3pEw=;
  b=eaxW+r+6NdB9sGSOm5BJhtt8WfU9PFnvqve0Tn99a5s6R/0tnruYLLoo
   9Eos8z7FZCNomzc+QVXQRIDSRdYUwfFtnOLrQRlAgP6l7YD4GEpHUesbU
   fOqt+Cnyqp/Kms4inXcYy/xpBZmdunRdTzx+JHSPc/SnZg2FK2akdjPKR
   1aQC5Tw5tvrhEbTG2+nMHMxFDBw1b4c2E6pRsRZPALlhnj5c+UgmY0jN2
   ulX7f/ws77r3ORA6b+dmOQSl/9SUve56F/qMxRwQC5DjLIb0v6qTVl2kN
   ch7uDfL8ssTngakkElnqJCkHKvXWDyIuhBx2IBbUyQ+PNSgT+b4qcVjDj
   A==;
X-CSE-ConnectionGUID: pJZxufRUTcKBcaapmybCNQ==
X-CSE-MsgGUID: 4oEB6n83QViC+OjY9zfTWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11556"; a="60182264"
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; 
   d="scan'208";a="60182264"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 22:04:07 -0700
X-CSE-ConnectionGUID: AS4OLpgTRL6taShsdKCyJA==
X-CSE-MsgGUID: SC5B1GRuQVKU+TMI4JX2Kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; 
   d="scan'208";a="175353405"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa006.fm.intel.com with ESMTP; 17 Sep 2025 22:04:06 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] iommu/vt-d: Remove LPIG from page group response descriptor
Date: Thu, 18 Sep 2025 13:02:01 +0800
Message-ID: <20250918050204.359508-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250918050204.359508-1-baolu.lu@linux.intel.com>
References: <20250918050204.359508-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bit 66 in the page group response descriptor used to be the LPIG (Last
Page in Group), but it was marked as Reserved since Specification 4.0.
Remove programming on this bit to make it consistent with the latest
specification.

Existing hardware all treats bit 66 of the page group response descriptor
as "ignored", therefore this change doesn't break any existing hardware.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Link: https://lore.kernel.org/r/20250901053943.1708490-1-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/iommu.h | 1 -
 drivers/iommu/intel/prq.c   | 7 ++-----
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 7da1cf88ce80..21d79414385c 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -460,7 +460,6 @@ enum {
 #define QI_PGRP_PASID(pasid)	(((u64)(pasid)) << 32)
 
 /* Page group response descriptor QW1 */
-#define QI_PGRP_LPIG(x)		(((u64)(x)) << 2)
 #define QI_PGRP_IDX(idx)	(((u64)(idx)) << 3)
 
 
diff --git a/drivers/iommu/intel/prq.c b/drivers/iommu/intel/prq.c
index 52570e42a14c..ff63c228e6e1 100644
--- a/drivers/iommu/intel/prq.c
+++ b/drivers/iommu/intel/prq.c
@@ -151,8 +151,7 @@ static void handle_bad_prq_event(struct intel_iommu *iommu,
 			QI_PGRP_PASID_P(req->pasid_present) |
 			QI_PGRP_RESP_CODE(result) |
 			QI_PGRP_RESP_TYPE;
-	desc.qw1 = QI_PGRP_IDX(req->prg_index) |
-			QI_PGRP_LPIG(req->lpig);
+	desc.qw1 = QI_PGRP_IDX(req->prg_index);
 
 	qi_submit_sync(iommu, &desc, 1, 0);
 }
@@ -379,19 +378,17 @@ void intel_iommu_page_response(struct device *dev, struct iopf_fault *evt,
 	struct iommu_fault_page_request *prm;
 	struct qi_desc desc;
 	bool pasid_present;
-	bool last_page;
 	u16 sid;
 
 	prm = &evt->fault.prm;
 	sid = PCI_DEVID(bus, devfn);
 	pasid_present = prm->flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID;
-	last_page = prm->flags & IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE;
 
 	desc.qw0 = QI_PGRP_PASID(prm->pasid) | QI_PGRP_DID(sid) |
 			QI_PGRP_PASID_P(pasid_present) |
 			QI_PGRP_RESP_CODE(msg->code) |
 			QI_PGRP_RESP_TYPE;
-	desc.qw1 = QI_PGRP_IDX(prm->grpid) | QI_PGRP_LPIG(last_page);
+	desc.qw1 = QI_PGRP_IDX(prm->grpid);
 	desc.qw2 = 0;
 	desc.qw3 = 0;
 
-- 
2.43.0

