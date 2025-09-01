Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB6E223DCE
	for <iommu@lists.linux.dev>; Mon,  1 Sep 2025 05:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756705313; cv=none; b=RPUe1IHdsyp0EG2FNByrhmH1mwt+JUj92HVdrwQFFGnJ4gbn4PcCgAb3HHXL0JIeLwIWk98ctp5dVxtqR2hUYzpYDwo5p0ZYT/pEj6GyeNLRxoaWAsNQ4LJ0BZqk8Iant8tXIlJWqSQUy4WJ52WVxf4Hr493ivkzK2pFFLWvly4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756705313; c=relaxed/simple;
	bh=NaW/5+ULiwXiwxrRUZsuHyiZHz6ocLyAXETDgsHbvoc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WXSa1SzKnVamTbej7PGiqzzeCWM9ZN0SohsO/LyqT511NDYSRcGBIHwVVeapfwjHNshV5NdBjnxAK0XtZNdRvnh5wXSmNebs483PmLmDA7TQlQSno9fg/ZmPnuE5+vP/PAipMsTLDFkHVAjhEo9v2rmBp7Gt3SSu9Lu56jxenHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JPqAGAvJ; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JPqAGAvJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756705311; x=1788241311;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NaW/5+ULiwXiwxrRUZsuHyiZHz6ocLyAXETDgsHbvoc=;
  b=JPqAGAvJUFIN35qnMsG9XlipJ2Q+L1/8futdub2s6BSf4eK7u83LtqNO
   +5+WuSo9YVu6c/Z8jLRF9p2eB8+8crkXn0JtpRmA12wl5mlaOsEIb6SRO
   77GAT6zEh1KIqllIQpfu97SBE+VpVlsgGBc5qo2UQ47pbO1kuo7shBULw
   C6nwz1wW7krhwyVJWH5aiiKhGVWWXk/ZXa5xdLgqDxDdbHeQQI+sBH9F/
   eeOB23aS75NTRZHxU4iQrrjY6svrjGZz+ZiK4jujJNPIjc7aYjQdlgvon
   5Mj+1R0aGOg5jE5OAQUjGeKBxfiouqAsVzS9Lm+9OcArsY0xBPaEJzmSy
   Q==;
X-CSE-ConnectionGUID: SVqNZTaETIKVbMzx2MnaEQ==
X-CSE-MsgGUID: tfucacQsSTqSUfClT37e0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11539"; a="58998198"
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; 
   d="scan'208";a="58998198"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2025 22:41:50 -0700
X-CSE-ConnectionGUID: qdAsDKITStC8oSdaj1yetw==
X-CSE-MsgGUID: nvmp077rRVuWHTxN9DhsWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; 
   d="scan'208";a="175036722"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by orviesa003.jf.intel.com with ESMTP; 31 Aug 2025 22:41:48 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/1] iommu/vt-d: Remove LPIG from page group response descriptor
Date: Mon,  1 Sep 2025 13:39:43 +0800
Message-ID: <20250901053943.1708490-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
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
---
 drivers/iommu/intel/iommu.h | 1 -
 drivers/iommu/intel/prq.c   | 7 ++-----
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index d09b92871659..2a3931c4cff9 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -462,7 +462,6 @@ enum {
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

