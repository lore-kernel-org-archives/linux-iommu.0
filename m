Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0773D6489
	for <iommu@lists.linux.dev>; Thu,  4 Jun 2026 06:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780553139; cv=none; b=MQacYBZ5OSlOFHHovXpLss5WQCEBmVjDfW28EDBHm5V3uCDQBi4mDM5pftSjXGr9pAknYpBpB0fZ6F3iB1c4uNPPm58ZWcCZe8y9z59drTnHQYqYIf0JGSFRk7o1NZl95K89AlH05mX/Id/j1mpaloIZIrzClpHW+Z6JnrtFPtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780553139; c=relaxed/simple;
	bh=bg9a90q7vThLPozRo1SItoJxz5cp3kq3hBfy/kU+5jg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jvSCas8y59/PwFtBnTQKyu0I5p2axWRHEATJcdMbC759FL3JMrycl3OcUdIYL0Tru/oSBWbmjQ3xuPTnv6RTYCIoz/jreZ16Ej3cnIu9kp/JOY+dO5eZ5V3pc5quxS5/F91t2Ivv3U6WqtB2jENVO8toIKcE3ajDz+zAB71PhT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WSto4Hft; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WSto4Hft"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780553139; x=1812089139;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bg9a90q7vThLPozRo1SItoJxz5cp3kq3hBfy/kU+5jg=;
  b=WSto4HftKvlxfvWuc5b6vQFl4g3qfHil0G+g+qkFsUwfvenoA03rW2Cd
   esdjheKOkHcWA5QG1MgyC07nPfq8ylz08sLOfyPkBdTrohrnJH0Vb3W/w
   jJzmGTcREUH1vTiUoI5pkTgTawDJ8IvXxEEz3kHfDOhpIyXIRq0ryGa4x
   vgOL9jtGUyZvQDqYjbmr1I7vSa8jhGZvoAh0uoQRnnFXa9cOb+kYo3/WA
   72A+gmfPBkK91NRcvYO4kaREYrJb0XM92QvrdiWbAK8v72YYUAM1RpWLn
   7IXX4fPaTAvVdHnOzSKkXGKKQMl0ouvACadbmjNflNsKo7Y5dIL5U9s4J
   A==;
X-CSE-ConnectionGUID: 1Vf2GdpJRHKyG307Z4Xuvw==
X-CSE-MsgGUID: Q6x1xlPQS7yfPRgmHdI0Jw==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="81554257"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="81554257"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 23:05:38 -0700
X-CSE-ConnectionGUID: RIQLWxasTaKcl+ll8cuhyg==
X-CSE-MsgGUID: 7hC163kSRXaU+8geGzIDrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="268112167"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa002.fm.intel.com with ESMTP; 03 Jun 2026 23:05:36 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Pranjal Shrivastava <praan@google.com>,
	Guanghui Feng <guanghuifeng@linux.alibaba.com>,
	=?UTF-8?q?Micha=C5=82=20Grzelak?= <michal.grzelak@intel.com>,
	Michael Bommarito <michael.bommarito@gmail.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] iommu/vt-d: Improve IOMMU fault information
Date: Thu,  4 Jun 2026 14:03:09 +0800
Message-ID: <20260604060311.365074-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260604060311.365074-1-baolu.lu@linux.intel.com>
References: <20260604060311.365074-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Guanghui Feng <guanghuifeng@linux.alibaba.com>

In some environments, multiple PCIe segments exist, and PCIe device
information needs to be differentiated and identified based on the
segment. When an IOMMU fault event occurs, the IOMMU and device segment
information should be output in detail in dmar_fault_do_one.

Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
Link: https://lore.kernel.org/r/20260528022943.1697564-1-guanghuifeng@linux.alibaba.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/dmar.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index d33c119a935e..767ec092accd 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1894,7 +1894,8 @@ static int dmar_fault_do_one(struct intel_iommu *iommu, int type,
 	reason = dmar_get_fault_reason(fault_reason, &fault_type);
 
 	if (fault_type == INTR_REMAP) {
-		pr_err("[INTR-REMAP] Request device [%02x:%02x.%d] fault index 0x%llx [fault reason 0x%02x] %s\n",
+		pr_err("[INTR-REMAP] Request device [%04x:%02x:%02x.%d] fault index 0x%llx [fault reason 0x%02x] %s\n",
+		       iommu->segment,
 		       source_id >> 8, PCI_SLOT(source_id & 0xFF),
 		       PCI_FUNC(source_id & 0xFF), addr >> 48,
 		       fault_reason, reason);
@@ -1903,14 +1904,16 @@ static int dmar_fault_do_one(struct intel_iommu *iommu, int type,
 	}
 
 	if (pasid == IOMMU_PASID_INVALID)
-		pr_err("[%s NO_PASID] Request device [%02x:%02x.%d] fault addr 0x%llx [fault reason 0x%02x] %s\n",
+		pr_err("[%s NO_PASID] Request device [%04x:%02x:%02x.%d] fault addr 0x%llx [fault reason 0x%02x] %s\n",
 		       type ? "DMA Read" : "DMA Write",
+		       iommu->segment,
 		       source_id >> 8, PCI_SLOT(source_id & 0xFF),
 		       PCI_FUNC(source_id & 0xFF), addr,
 		       fault_reason, reason);
 	else
-		pr_err("[%s PASID 0x%x] Request device [%02x:%02x.%d] fault addr 0x%llx [fault reason 0x%02x] %s\n",
+		pr_err("[%s PASID 0x%x] Request device [%04x:%02x:%02x.%d] fault addr 0x%llx [fault reason 0x%02x] %s\n",
 		       type ? "DMA Read" : "DMA Write", pasid,
+		       iommu->segment,
 		       source_id >> 8, PCI_SLOT(source_id & 0xFF),
 		       PCI_FUNC(source_id & 0xFF), addr,
 		       fault_reason, reason);
-- 
2.43.0

