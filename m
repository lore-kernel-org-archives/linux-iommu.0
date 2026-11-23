Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795395381;
	b=cwYufRN+bC6WaqJKUaNyZMisRrVcvS0R6CI1cf/QrA4YiFkuzbEk/AGpMvkNccWhlYng
	 w075yi8/D4P4CpPfELY1E4YkWPrEaAP8EtZ9LXWwa2KrqTnu8eSXVo96FjHVMG/7lWHYf
	 tRTClsJWISdX9EZoVlfb2Fze3nsiTELmPPOvV1r+53NQj+adu0j9Ct2cAb/kKkQeGJtmY
	 Ixjf+DVv7oBFBd+9Z/gXtMU/b+/WMvJ29vMaNd++CVp4Fq1GMNE7eOmO0xHN/PaGqbX8B
	 R6Z0RnfYwONjzo/FVscuzaQ5uDON05occ31jHklXlNuxSqw6lMCWTKcyl1OdKk/A2UQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795395381;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=6iOWOlhokRTvZ+1ZzgrBgIX5wJx1n4wumL1FFGWInLY=;
	b=DhbSXLi+Z7/c6qehH8gHima6/W/fWgb5rohwuIgFeaokzoJddNdGcnuP1vUyg6Hb4GXe
	 GXYua5EJCxzVCnAYO/PwEFp+ajrxIuYRRY32gebPl5P9akeYCY1+zyvUBsRR8pMc9+9Go
	 x05qEVs++AuWeJ9ASF/BCyZu9vI0Gp5BObmEJI42zesTCOLC6R/Hu3nOLw8wgPxFAw/7/
	 lgwbitdu0tkkDqu29zmmWvR57KO1JGqtrJjeC8mVf65YzecVVaacQI3z90Mto+GVGqjoB
	 FMAT6QSsrPMhbfTGHCQECw8pInCueIl7V8CKfYCStzTtDF1AAlMgW4PwfJm8qJGR/ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CsnqehUh;
	arc=none smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228AD606A31D
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 00:56:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 228AD606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CsnqehUh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795395381; x=1826931381;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=te+YbI60VJc4AmXexw7PT/rJUBZf+kBjHxUOZYIJA5o=;
  b=CsnqehUhVEsnsMT4xDBw9qRHKjeBLh2+IEAyc+ETO8HQxG8RcdZaPc2B
   IOCYj6LLIuvLL5PZL/grJKRJZ9gwI4B2HLAuAVisnXc2evtHwpPg/tSw3
   vBzpbb18Zz3esUD6RTcbFQa+rWDYm3frYpA1oDABVT2tl4L1H5QekObWw
   VMODJTQk6/q5YWskL+YPLQ26exfgFbluCvRXYkDOjMukUPpacDUXYCTuv
   zQkMmtv7mJxp3mj6NBO9PE4WIreaHZ13tFMplRuCpX8muiILaoGeiqabF
   B60MzWxVW0aeErFVjsAS0o5peXoTZvcvNb9Fqi0/nhoO85JFaykFc0gyt
   w==;
X-CSE-ConnectionGUID: xrMeXi+HS66nUoSOtEWF2A==
X-CSE-MsgGUID: gOfcf2SSRp2uSX92uINE9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11974"; a="4181285"
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="4181285"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2026 16:56:20 -0800
X-CSE-ConnectionGUID: vAywu57nTcOXEAyIQuBFbA==
X-CSE-MsgGUID: sTw9e0AqSGWQNQyI6LQtmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="11045618"
Received: from allen-box.sh.intel.com ([10.239.48.101])
  by orviesa003.jf.intel.com with ESMTP; 22 Nov 2026 16:56:18 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: iommu@lists.linux.dev
Cc: Kevin Tian <kevin.tian@intel.com>,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/1] iommu/vt-d: Block translation before removing IOPF in blocking attach
Date: Mon, 23 Nov 2026 08:43:10 +0800
Message-ID: <20261123004310.2828884-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

blocking_domain_attach_dev() drops the old domain's IOPF reference before
it calls device_block_translation(). When that is the last reference,
intel_iommu_disable_iopf() calls iopf_queue_remove_device() while the RID
still translates through the old domain and its page requests are still
being reported. This is wrong in two ways:

 - iopf_queue_remove_device() requires that no iommu_report_device_fault()
   is still running for the device. A report can have linked its group
   into the pending list without having called the iopf_handler yet;
   iopf_queue_remove_device() then responds to and frees that group, and
   the reporter hands the freed group to the handler.

 - With iopf_refcount already zero, the drain in
   device_block_translation() -> intel_pasid_tear_down_entry() ->
   intel_iommu_drain_pasid_prq() returns early, so the PRQ for the RID is
   never drained on this path at all.

The removal was placed first by commit 17fce9d2336d ("iommu/vt-d: Put
iopf enablement in domain attach path") because the old domain was then
taken from info->domain, which device_block_translation() clears.
Commit 91b55eb171cb ("iommu/vt-d: Use old domain parameter when attaching
the blocking domain") switched to the @old parameter, so the order can now
be swapped. Backports need that commit as well.

Fixes: 17fce9d2336d ("iommu/vt-d: Put iopf enablement in domain attach path")
Cc: stable@vger.kernel.org
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 5a2e705a2f2e..a8c0ccae844e 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2897,8 +2897,8 @@ static int blocking_domain_attach_dev(struct iommu_domain *domain,
 				      struct device *dev,
 				      struct iommu_domain *old)
 {
-	iopf_for_domain_remove(old, dev);
 	device_block_translation(dev);
+	iopf_for_domain_remove(old, dev);
 	return 0;
 }
 
-- 
2.43.0

