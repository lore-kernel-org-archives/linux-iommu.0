Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501A118C32C
	for <iommu@lists.linux.dev>; Mon, 20 Jan 2025 08:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737360111; cv=none; b=fY19aNZ6dQhD5OOVjQ0T+8TQfJz1uE4D7FnRq3oCmtEh0uFHttuq7eCApVT4B6WyWFnDIzZ52e89G8fQfDzvH6EWN8m35PAhcexNBrJADMS7GkK7WS6shIzwsTswudFKHYJXImjtb5LL+FIT503qwZABnsJmZtw08FqMcVk1QjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737360111; c=relaxed/simple;
	bh=ME6qRmhMy5w7ULK2komyBeEjrv6h21GUh2+eDKBPpQo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i3eMI3WBS5BNhJzLZW+OYdZ9NpCbwr5RnBCvRP7xmd422rslZ0P04jUkvFebg7woX+a8m40g8JucA9htJsea2LO53bEnwv4JraE9JiNldZvcpgRft/h7PyqfMZb2xSzhspuxlEbWqqMB41pPkaJBPvoIMGW9CgnyYB2DjiVec1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N4AxyEty; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N4AxyEty"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737360110; x=1768896110;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ME6qRmhMy5w7ULK2komyBeEjrv6h21GUh2+eDKBPpQo=;
  b=N4AxyEty0Q0yLN32fo88lhnsq2WNhswIPaOqNC7ulHBGGiZOYlFqIQfH
   qOY6ZWGYNguG0aZ1lQwo50TpIEn8IlXUje7M7w0o6KG4eVVcW4PHGGGc4
   7tfXQ12C4I9PaaOMk0ha66ItwIQM4kk1GMDL42iSVkpPLleWXrZGnbru7
   KsL8shsdWm/Pq9xs/Hu948wIXbaphF43a3CegOmzCXdy6lwi/+iUU/B54
   t6vQY0JV01EihiMcdTz3/VEm/ccjPR4M4Q4UAz+UPeYXStWVbKwk1h6xb
   LfgGgVG1XtSoCUDtZCn6IVZ1ait9dQWt3m687Iozo3lzOnhPqvYqsxGmX
   Q==;
X-CSE-ConnectionGUID: o5W0r2pkT8W8UyZoWarZXw==
X-CSE-MsgGUID: GKMBgzn1QDyudQ82Dijm3g==
X-IronPort-AV: E=McAfee;i="6700,10204,11320"; a="55278061"
X-IronPort-AV: E=Sophos;i="6.13,218,1732608000"; 
   d="scan'208";a="55278061"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2025 00:01:49 -0800
X-CSE-ConnectionGUID: gVpjxVVOQwyP4x9RNKAGug==
X-CSE-MsgGUID: zcEqS6fEQo6Bgb4JCpechA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,218,1732608000"; 
   d="scan'208";a="137261847"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by orviesa002.jf.intel.com with ESMTP; 20 Jan 2025 00:01:48 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/1] iommu/vt-d: Make intel_iommu_drain_pasid_prq() cover faults for RID
Date: Mon, 20 Jan 2025 16:01:44 +0800
Message-ID: <20250120080144.810455-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This driver supports page faults on PCI RID since commit <9f831c16c69e>
("iommu/vt-d: Remove the pasid present check in prq_event_thread") by
allowing the reporting of page faults with the pasid_present field cleared
to the upper layer for further handling. The fundamental assumption here
is that the detach or replace operations act as a fence for page faults.
This implies that all pending page faults associated with a specific RID
or PASID are flushed when a domain is detached or replaced from a device
RID or PASID.

However, the intel_iommu_drain_pasid_prq() helper does not correctly
handle faults for RID. This leads to faults potentially remaining pending
in the iommu hardware queue even after the domain is detached, thereby
violating the aforementioned assumption.

Fix this issue by extending intel_iommu_drain_pasid_prq() to cover faults
for RID.

Fixes: 9f831c16c69e ("iommu/vt-d: Remove the pasid present check in prq_event_thread")
Cc: stable@vger.kernel.org
Suggested-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/prq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/prq.c b/drivers/iommu/intel/prq.c
index c2d792db52c3..043f02d7b460 100644
--- a/drivers/iommu/intel/prq.c
+++ b/drivers/iommu/intel/prq.c
@@ -87,7 +87,8 @@ void intel_iommu_drain_pasid_prq(struct device *dev, u32 pasid)
 		struct page_req_dsc *req;
 
 		req = &iommu->prq[head / sizeof(*req)];
-		if (!req->pasid_present || req->pasid != pasid) {
+		if (req->rid != sid ||
+		    (req->pasid_present && req->pasid != pasid)) {
 			head = (head + sizeof(*req)) & PRQ_RING_MASK;
 			continue;
 		}
-- 
2.43.0

