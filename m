Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8AAC1F4701
	for <iommu@lists.linux.dev>; Mon, 14 Jul 2025 04:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752468771; cv=none; b=gkjP/KNvONn8Ga+NhckCNsOSJY3+2tuq1fdaiMm0r7FlyGMsMQZQDKW/h8kFfsDB55wphZtYNVY4H7LHgQSJYKMZ+EBeXgZaMn8fnyVl1B95weTUvbAn0i19xHR8OBe/jUbzXmgBVOq+E7TgkI5cy/R5kikcdW0K7nZIFSOQRUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752468771; c=relaxed/simple;
	bh=syDR/ggoQRcY2z+FN85gCRMGWAqN9JGTyQdffmweMoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WOeWbehoGaLpDDgE+MumHKT0//4yNvyTczUEXjS+jTQY9TONAbqrxkonFp3/PUaxWYfuA7zOCgb+UI6JvVyEUa7+oUAeQe/SK/cZmrUl8CVNmEIRS32eyn0sIguNC8zFuQtZMN6KpEkz5w4knuduU91+yE2BN0Sdz6FS7mHCCos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bAeeMQFE; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bAeeMQFE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752468769; x=1784004769;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=syDR/ggoQRcY2z+FN85gCRMGWAqN9JGTyQdffmweMoo=;
  b=bAeeMQFExm++bxeWcDejc295bkWYokbY3L4hseKBh3YlNgttSdnwpO3S
   P2ql6yp5lKWqiGu1gvcA68RUggPsIQf6NoEHAMIGIlysUvrSL3Xzdz3TI
   U7WayogWkgtnpRyVJ7GgtY//Y/mkYRBZYFHgYcXlcIl9cJRBL05eiIQK0
   CSoqz3t3FQ4m7yenXugBi5Rr002oT60v9fffSoU9MXpWdCyTfv+UP0F/+
   eJSpEDgjmNfRUwRYTiRuJDXpdhlN4AdbgZjxO1n+fDnbdQ0TpZmH4LMR5
   UQAGXVylAmLFW/lhUDiogexK9S//0b4c5iJM4A/+0uawyQXNlCts8PzkU
   g==;
X-CSE-ConnectionGUID: sDaCqKJfQQmUYQqzPBz1qw==
X-CSE-MsgGUID: wov+yz8ZQISMZN/6M6tikQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="53765037"
X-IronPort-AV: E=Sophos;i="6.16,310,1744095600"; 
   d="scan'208";a="53765037"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2025 21:52:47 -0700
X-CSE-ConnectionGUID: EHG8kM0tSCq1tMSgDxKGPA==
X-CSE-MsgGUID: J/LEche7Sp2vi2tu6+bBcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,310,1744095600"; 
   d="scan'208";a="161166145"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by orviesa003.jf.intel.com with ESMTP; 13 Jul 2025 21:52:47 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 01/11] iommu/vt-d: Remove the CONFIG_X86 wrapping from iommu init hook
Date: Mon, 14 Jul 2025 12:50:18 +0800
Message-ID: <20250714045028.958850-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250714045028.958850-1-baolu.lu@linux.intel.com>
References: <20250714045028.958850-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>

iommu init hook is wrapped in CONFI_X86 and is a remnant of dmar.c when
it was a common code in "drivers/pci/dmar.c". This was added in commit
(9d5ce73a64be2 x86: intel-iommu: Convert detect_intel_iommu to use
iommu_init hook)

Now this is built only for x86. This config wrap could be removed.

Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/20250616131740.3499289-1-vineeth@bitbyteword.org
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/dmar.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index b61d9ea27aa9..ec975c73cfe6 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -935,14 +935,11 @@ void __init detect_intel_iommu(void)
 		pci_request_acs();
 	}
 
-#ifdef CONFIG_X86
 	if (!ret) {
 		x86_init.iommu.iommu_init = intel_iommu_init;
 		x86_platform.iommu_shutdown = intel_iommu_shutdown;
 	}
 
-#endif
-
 	if (dmar_tbl) {
 		acpi_put_table(dmar_tbl);
 		dmar_tbl = NULL;
-- 
2.43.0

