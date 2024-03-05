Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4877C1AAD7
	for <iommu@lists.linux.dev>; Tue,  5 Mar 2024 01:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709602771; cv=none; b=WXt4OLdccgOyt0vF5ybrIEA4XVkF9VDh/+lECQVasJYIEqyWwNCzvx6B/cyRc50qQGJNZ+ZIpG7h8Hpl+j3r8aFDTl2XyyHab+L4fS8YlVKkSh+6CMOXeQ9fvmOrMHCpVNIaFd6rw8fPutwT5obEy9EzpHPBNq7TkMGSscjWmx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709602771; c=relaxed/simple;
	bh=qIJJGnwDPVDv4F7r6y/s39ika2Bz0nOGa718N4ZxZGg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bqi8KqBWfFzCrM3BisbriAXjTzlZKnuZjRtayJd28lvAXefc+3wN8a5PjUMvVcOcWtyG7X/hndzwPAtvo1EldjIbB1ZoCBDRGiEW6mSsuRGyjEFTERBL0sZv777VI4IcxwCAsHT+cbF3xayGKdcJSKpCbsLxY0J98Zl6diOTwGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mFmIfGE5; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mFmIfGE5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709602771; x=1741138771;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qIJJGnwDPVDv4F7r6y/s39ika2Bz0nOGa718N4ZxZGg=;
  b=mFmIfGE56TnbUzhoto/WVFtsDjuIqYvQuv8gvF5eeIj/eYJmVYVafp6S
   WWkok/a8bh+GIb8VDRHT4F4Va3lEl1z6hqlHZ566lAnAcHq9uqQJms4vf
   kYjMlEy+SO5WCEC5RltzX9v2CcIsNS7kU4Rn8dERg8Q6uY1M39kko/rUZ
   6hAXykN5wX1gl0IjcW7Kf8N9gbDFu+azlGk1I0o74fuhPlUqIEDauCPm6
   1bJagQqc5VlAj04qYzQC4t/LVUs0lCE4sqg8xCQ8Aqs81iy24zDRpF/hO
   alxrVi/mdZs5P9F8hF9h7AnOe9iUTcDSWObRqUvvrSro2KVqrWR3cw0R3
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="4286735"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="4286735"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 17:39:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="13865517"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orviesa004.jf.intel.com with ESMTP; 04 Mar 2024 17:39:28 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Eric Badger <ebadger@purestorage.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v3 5/5] iommu/vt-d: Remove scalabe mode in domain_context_clear_one()
Date: Tue,  5 Mar 2024 09:33:05 +0800
Message-Id: <20240305013305.204605-6-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240305013305.204605-1-baolu.lu@linux.intel.com>
References: <20240305013305.204605-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

domain_context_clear_one() only handles the context entry teardown in
legacy mode. Remove the scalable mode check in it to avoid dead code.

Remove an unnecessary check in the code as well.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 drivers/iommu/intel/iommu.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index d682eb6ad4d2..50eb9aed47cc 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2175,9 +2175,6 @@ static void domain_context_clear_one(struct device_domain_info *info, u8 bus, u8
 	struct context_entry *context;
 	u16 did_old;
 
-	if (!iommu)
-		return;
-
 	spin_lock(&iommu->lock);
 	context = iommu_context_addr(iommu, bus, devfn, 0);
 	if (!context) {
@@ -2185,14 +2182,7 @@ static void domain_context_clear_one(struct device_domain_info *info, u8 bus, u8
 		return;
 	}
 
-	if (sm_supported(iommu)) {
-		if (hw_pass_through && domain_type_is_si(info->domain))
-			did_old = FLPT_DEFAULT_DID;
-		else
-			did_old = domain_id_iommu(info->domain, iommu);
-	} else {
-		did_old = context_domain_id(context);
-	}
+	did_old = context_domain_id(context);
 
 	context_clear_entry(context);
 	__iommu_flush_cache(iommu, context, sizeof(*context));
@@ -2203,9 +2193,6 @@ static void domain_context_clear_one(struct device_domain_info *info, u8 bus, u8
 				   DMA_CCMD_MASK_NOBIT,
 				   DMA_CCMD_DEVICE_INVL);
 
-	if (sm_supported(iommu))
-		qi_flush_pasid_cache(iommu, did_old, QI_PC_ALL_PASIDS, 0);
-
 	iommu->flush.flush_iotlb(iommu,
 				 did_old,
 				 0,
-- 
2.34.1

