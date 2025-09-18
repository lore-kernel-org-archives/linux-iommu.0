Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A9A27A108
	for <iommu@lists.linux.dev>; Thu, 18 Sep 2025 05:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758171847; cv=none; b=MUxdB16jCiignuEBexT7WwlGHw1dZMzm5pAnIaRozT6BPR8BUPBZZ90YJbLQKPWCuzq54nJeanK3nr/G8/BvsFpZKNDTqibrFRALph/wucqkz/rYzOVMNv/sX1gS+UiAMCqEyZcJXbgdSNkiZ0sf6n98IdRpdfwudhOFk2qndJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758171847; c=relaxed/simple;
	bh=zIlB6FcHardt8kbvUs2KpFdkBGZVO3qdznG6wASoccU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qT3WB2g5Qdto8lSWSWrwcpvIFsvL7KE2pV/uJ+W8FU36k125KpLxT1KlHGyTNTeBHo+3Dc6ebou5H69bmzfu7f40O7rSQLDQ2CfKDdBO1iFP9TwRHYY/2Gwbv8wHZtMZrAvIpWIXEaWItLWq68nAosftGxZCqWDJO78micPo1Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K9xj+SAd; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K9xj+SAd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758171846; x=1789707846;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zIlB6FcHardt8kbvUs2KpFdkBGZVO3qdznG6wASoccU=;
  b=K9xj+SAdhrkUDZTJgFBTkNbUyTRzpMW2w1c1kXrKCTtFq/oAtJF6x+m9
   DGWpEOzHTg2j7Ea0YNpvjbxm88/FbcIoI7W5pItvkomZoVzw+pCYdsg6L
   5QRtuKdSDF59m8IXcc5cZH0dcDgogB2PEZ0SdNyEPSFJxYgyH5LzkpjJx
   sdGbZM2rUz2mojpQw5l0tz1MlExcAOZcn1BaPIWJgGNNJljg2WO2Llf/W
   UialUCzauGPlFjkAWOPyJh8HrJGXl05rR0QRBxttczjbFZ+Iusw9kQNvQ
   rQSZurLX6CR+HFsO56z5Nb4UTEVhZBd7mxLPLu6GaMp9DwRq3gOdvifLx
   Q==;
X-CSE-ConnectionGUID: 6qpcI8JVR5S7ba8ahmSyRQ==
X-CSE-MsgGUID: cYN8cGctQmaCB3BY9kdjTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11556"; a="60182259"
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; 
   d="scan'208";a="60182259"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 22:04:06 -0700
X-CSE-ConnectionGUID: nKXC74x8Qe2gcboeaAAvdg==
X-CSE-MsgGUID: 5MuBYmvrSjGQRCccNxaXzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; 
   d="scan'208";a="175353403"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa006.fm.intel.com with ESMTP; 17 Sep 2025 22:04:05 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] iommu/vt-d: Drop unused cap_super_offset()
Date: Thu, 18 Sep 2025 13:02:00 +0800
Message-ID: <20250918050204.359508-4-baolu.lu@linux.intel.com>
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

From: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>

The macro is unused. Drop the dead code.

Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
Link: https://lore.kernel.org/r/20250913015024.81186-1-yury.norov@gmail.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index d09b92871659..7da1cf88ce80 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -173,8 +173,6 @@
 #define cap_pgsel_inv(c)	(((c) >> 39) & 1)
 
 #define cap_super_page_val(c)	(((c) >> 34) & 0xf)
-#define cap_super_offset(c)	(((find_first_bit(&cap_super_page_val(c), 4)) \
-					* OFFSET_STRIDE) + 21)
 
 #define cap_fault_reg_offset(c)	((((c) >> 24) & 0x3ff) * 16)
 #define cap_max_fault_reg_offset(c) \
-- 
2.43.0

