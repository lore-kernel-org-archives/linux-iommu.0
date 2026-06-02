Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D712E37F8D7
	for <iommu@lists.linux.dev>; Tue,  2 Jun 2026 23:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780443416; cv=none; b=Po9hYkBiEuRY4wz3VYlY5VxZLfKAFWHZR5xjkOZNzbqZC75nTDV1+IaRJx9t7rk5RB9dByJhNWG1fA0uPmTxZGkIlGA/ofZLnfx0G2J0oicL0WwB9axMk42/Pet4c9KNXSfKLiH0845Shg58XA5yLrZZ48QPMpra3ggZFCo0yj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780443416; c=relaxed/simple;
	bh=bg9a90q7vThLPozRo1SItoJxz5cp3kq3hBfy/kU+5jg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ABPe/WGrLUDd7E5FPqLGNoHb3r87R0rv6udom9pQnSheqP4nlpbYHZZ3q/oZatPQ2v/JRjg2z3zlLA6XOBSm01jVRh6W3mlrxNT70l6J+EavCzfuseI5oqgh4JKkQfsjItJNDX6KKVNFy0T4dt58ihxon15+JtT6lb0/eB99G28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kj+1kCL/; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kj+1kCL/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780443415; x=1811979415;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bg9a90q7vThLPozRo1SItoJxz5cp3kq3hBfy/kU+5jg=;
  b=kj+1kCL/+QVkGom8l5cXGBc8lFw4o3qpCXFrtDQzfsv5trOGfG9JFh27
   yOnKRk2UFmJN6zE2XgRtTPImWJ3/cMx1oE6awkWysK9jJSJG2i14BMSAi
   SoM3ua7oQrFaO8/HbHXfeij0xkYnKfdHeFlForwNQuH98NNh4ORbt40q8
   3AcMixdajfN4MqfoopYBiDYyNoTuoDCSicEW84mvJ3ZZWHvxpVeoC+Oe4
   9oWbnnptpVeJFu7ivMnhVBpd+i8FVPRGvBp8ZJpbU8KzDskBFxPXL2ahI
   8IIE9KdodtlbTZY/xBLGLEZ87x8CZ+h46RYcXpbjdSsQwxCYWDLxc47wj
   w==;
X-CSE-ConnectionGUID: qaRol5TMSli/mvnbNk0rfg==
X-CSE-MsgGUID: O28h3XttQZ+FVyk56501xw==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="81369739"
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="81369739"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 16:36:54 -0700
X-CSE-ConnectionGUID: We1cSPMXQIq1encQqA2Dbg==
X-CSE-MsgGUID: TETKopAPToCiRiZISFkmmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="241068752"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa007.fm.intel.com with ESMTP; 02 Jun 2026 16:36:52 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Pranjal Shrivastava <praan@google.com>,
	Guanghui Feng <guanghuifeng@linux.alibaba.com>,
	=?UTF-8?q?Micha=C5=82=20Grzelak?= <michal.grzelak@intel.com>,
	Michael Bommarito <michael.bommarito@gmail.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] iommu/vt-d: Improve IOMMU fault information
Date: Wed,  3 Jun 2026 07:34:23 +0800
Message-ID: <20260602233426.357499-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260602233426.357499-1-baolu.lu@linux.intel.com>
References: <20260602233426.357499-1-baolu.lu@linux.intel.com>
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

