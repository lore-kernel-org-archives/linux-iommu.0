Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0D936495B
	for <iommu@lists.linux.dev>; Tue, 10 Mar 2026 07:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773129494; cv=none; b=QzxpnuHPiEetmBsGZ5J+e0honTtcZQABOc+nIbhn1daX5ELGMNSfS+OZgPa3z4qq5FKbYdELYBvjZvy2ovgEFIezC1u26DV4L94QasV9c+4EYQDsQE2mchvQPdr+0oWDTm8gtHxY2kP/ps6xBrPsoQdX1S9Sll88Du9kf1u2FN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773129494; c=relaxed/simple;
	bh=9rrgTplL9Jyn3YMjwg2ZeOydsNyzxReM6UUAuxh5reM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q5tk60Wr4NXCr0ezLa+0d6gK/VgG4Z7JN5rlvx2cyGVnXxZtMQr8ZlGPcWLcPy8XOi46CNJvQr87ik7iW10o11H8cJzNofH35x8kwIwIfRNwoo0ixJataS66/RKxmTTBAxF2Fo8FVNE9WGEjcW5k2Ph6kqTzYDuHKnQrb8Io84o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hEGZLiNh; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hEGZLiNh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773129493; x=1804665493;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9rrgTplL9Jyn3YMjwg2ZeOydsNyzxReM6UUAuxh5reM=;
  b=hEGZLiNhoOwnmyXWfQHDqAXAGHlFz3gkI9z5DPGT3W04x8dDZQDOibUD
   P2j/aKhei39+OYr1i+9pamISfj+ZIzrjXiWgY6+6cQHeB4m9V786INGbx
   08y/9GY4ilW9zcfQipWaO74n26kMAORG/rJ01ishoqkJ6q2OhlAPzOnVl
   ii0Bh1ZYGlUYWSpxawxBBDnOFsm5f+WwDF1siRWosa6jSk5T6CgV91IvS
   +VdZ2rNN1qvATKtAecwBDhEZi74t/47K1Ab/YefCiiU68WRYSD/2zLQxp
   Wn+wD/UcuN9fj4CxBKwq4ja3lwCB3LP41bCfh/H63V0NWR1JabIVwopCw
   g==;
X-CSE-ConnectionGUID: SsVhmAeiTJGVQ8RNQSBULA==
X-CSE-MsgGUID: HUBMu3/HQxq1M9eRliB+WA==
X-IronPort-AV: E=McAfee;i="6800,10657,11724"; a="78045003"
X-IronPort-AV: E=Sophos;i="6.23,111,1770624000"; 
   d="scan'208";a="78045003"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 00:58:09 -0700
X-CSE-ConnectionGUID: Y3MHkOYCRJOTQu+Z55BGAA==
X-CSE-MsgGUID: RgOeO4QgR6S9fb3Et5pDCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,111,1770624000"; 
   d="scan'208";a="220066680"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by orviesa008.jf.intel.com with ESMTP; 10 Mar 2026 00:58:07 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/1] iommu/vt-d: Only handle IOPF for SVA when PRI is supported
Date: Tue, 10 Mar 2026 15:55:20 +0800
Message-ID: <20260310075520.295104-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In intel_svm_set_dev_pasid(), the driver unconditionally manages the IOPF
handling during a domain transition. However, commit a86fb7717320
("iommu/vt-d: Allow SVA with device-specific IOPF") introduced support for
SVA on devices that handle page faults internally without utilizing the
PCI PRI. On such devices, the IOMMU-side IOPF infrastructure is not
required. Calling iopf_for_domain_replace() on these devices is incorrect
and can lead to unexpected failures during PASID attachment or unwinding.

Add a check for info->pri_supported to ensure that the IOPF queue logic
is only invoked for devices that actually rely on the IOMMU's PRI-based
fault handling.

Fixes: 17fce9d2336d ("iommu/vt-d: Put iopf enablement in domain attach path")
Cc: stable@vger.kernel.org
Suggested-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/svm.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index fea10acd4f02..57cd1db7207a 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -164,9 +164,12 @@ static int intel_svm_set_dev_pasid(struct iommu_domain *domain,
 	if (IS_ERR(dev_pasid))
 		return PTR_ERR(dev_pasid);
 
-	ret = iopf_for_domain_replace(domain, old, dev);
-	if (ret)
-		goto out_remove_dev_pasid;
+	/* SVA with non-IOMMU/PRI IOPF handling is allowed. */
+	if (info->pri_supported) {
+		ret = iopf_for_domain_replace(domain, old, dev);
+		if (ret)
+			goto out_remove_dev_pasid;
+	}
 
 	/* Setup the pasid table: */
 	sflags = cpu_feature_enabled(X86_FEATURE_LA57) ? PASID_FLAG_FL5LP : 0;
@@ -181,7 +184,8 @@ static int intel_svm_set_dev_pasid(struct iommu_domain *domain,
 
 	return 0;
 out_unwind_iopf:
-	iopf_for_domain_replace(old, domain, dev);
+	if (info->pri_supported)
+		iopf_for_domain_replace(old, domain, dev);
 out_remove_dev_pasid:
 	domain_remove_dev_pasid(domain, dev, pasid);
 	return ret;
-- 
2.43.0

