Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F7A154BE5
	for <iommu@lists.linux.dev>; Tue,  7 Jan 2025 02:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736216395; cv=none; b=bPvBR5xbJWTQObmxTt+6Nn+4PJLECUqDmMlfVNYNTBivr1EcrmqJ1qizBDU/VLcJ4HtaobNinacD8mI+DOOi8U1jjN1XirEVdJtQm4wI7/+YklL5rN7wGUR3ZYUJa67VelaheV4tMuBzBdm6lSKQsg6fjqDy4u1Yaf5+c9DxRdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736216395; c=relaxed/simple;
	bh=KM4FYWhRUwFYMcf5ydnrUNjsaKgxN0jLwDpgnwM7liQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CDjfkwlYUhh9md1KjcyZ4g+G7APsKRAkn0sN82jGHsyAhiIYnPivW0cqklK2cY9R1aRqr5y9/VRI8M6r/lmlxQLJvhQDKKe7uYVuFrfu/OghfWnT+VGJRWxEuDO5x5Gqx+S1XB4cbPAsKHjOZVeoA6QSG5DUeJtmJ8ZCa0sVjks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SYZlG6j8; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SYZlG6j8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736216394; x=1767752394;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KM4FYWhRUwFYMcf5ydnrUNjsaKgxN0jLwDpgnwM7liQ=;
  b=SYZlG6j8j/u8Xy8B9IUyspCs14SAR2br5d5uOgLIH5WBqQXLB6+L9kHH
   DTwV5Nd7p/YVK4LQw1JxDVSwFxzIBYh3cdxe7WRfVqPCTWnFrexXDuXnu
   yUqzOFsh4xrsiyK3FF+tbJYTr9ttpRjoNoTiGWBnOm4Yk91flVu1DIEdK
   KnfDNLxnPqwVkXBZJmZ1B8ZnkG2+mItuxfHTD/3GgrxZrwbYiwSChUvQH
   LMqhgl9NMupJ1GbKjpGazg+6UstpkJ2uKtX0hqgSpBM8b1UNCgeWf7qct
   kwzJDO+MXEHjgzyPRi0Z4hVaP00TPanzrbAoZcDNCsUyHzFot1MlnQ65D
   g==;
X-CSE-ConnectionGUID: 6T7a5/vnTsaB45nvpoec0Q==
X-CSE-MsgGUID: EQ9YrFpHSuaW1T0Wlq06Ew==
X-IronPort-AV: E=McAfee;i="6700,10204,11307"; a="47800787"
X-IronPort-AV: E=Sophos;i="6.12,294,1728975600"; 
   d="scan'208";a="47800787"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2025 18:19:53 -0800
X-CSE-ConnectionGUID: WBKXre/hTUyGhMxX8UcmbQ==
X-CSE-MsgGUID: nKatQ96xRN6uWEZcuJVcLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,294,1728975600"; 
   d="scan'208";a="102442974"
Received: from allen-sbox.sh.intel.com ([10.239.159.30])
  by orviesa009.jf.intel.com with ESMTP; 06 Jan 2025 18:19:52 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	Kees Bakker <kees@ijzerbout.nl>,
	Zhenzhong Duan <zhenzhong.duan@intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] iommu/vt-d: Draining PRQ in sva unbind path when FPD bit set
Date: Tue,  7 Jan 2025 10:17:45 +0800
Message-ID: <20250107021746.6908-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250107021746.6908-1-baolu.lu@linux.intel.com>
References: <20250107021746.6908-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a device uses a PASID for SVA (Shared Virtual Address), it's possible
that the PASID entry is marked as non-present and FPD bit set before the
device flushes all ongoing DMA requests and removes the SVA domain. This
can occur when an exception happens and the process terminates before the
device driver stops DMA and calls the iommu driver to unbind the PASID.

There's no need to drain the PRQ in the mm release path. Instead, the PRQ
will be drained in the SVA unbind path. But in such case,
intel_pasid_tear_down_entry() only checks the presence of the pasid entry
and returns directly.

Add the code to clear the FPD bit and drain the PRQ.

Fixes: c43e1ccdebf2 ("iommu/vt-d: Drain PRQs when domain removed from RID")
Suggested-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20241217024240.139615-1-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/pasid.c | 22 +++++++++++++++++++++-
 drivers/iommu/intel/pasid.h |  6 ++++++
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 5b7d85f1e143..fb59a7d35958 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -244,11 +244,31 @@ void intel_pasid_tear_down_entry(struct intel_iommu *iommu, struct device *dev,
 
 	spin_lock(&iommu->lock);
 	pte = intel_pasid_get_entry(dev, pasid);
-	if (WARN_ON(!pte) || !pasid_pte_is_present(pte)) {
+	if (WARN_ON(!pte)) {
 		spin_unlock(&iommu->lock);
 		return;
 	}
 
+	if (!pasid_pte_is_present(pte)) {
+		if (!pasid_pte_is_fault_disabled(pte)) {
+			WARN_ON(READ_ONCE(pte->val[0]) != 0);
+			spin_unlock(&iommu->lock);
+			return;
+		}
+
+		/*
+		 * When a PASID is used for SVA by a device, it's possible
+		 * that the pasid entry is non-present with the Fault
+		 * Processing Disabled bit set. Clear the pasid entry and
+		 * drain the PRQ for the PASID before return.
+		 */
+		pasid_clear_entry(pte);
+		spin_unlock(&iommu->lock);
+		intel_iommu_drain_pasid_prq(dev, pasid);
+
+		return;
+	}
+
 	did = pasid_get_domain_id(pte);
 	pgtt = pasid_pte_get_pgtt(pte);
 	intel_pasid_clear_entry(dev, pasid, fault_ignore);
diff --git a/drivers/iommu/intel/pasid.h b/drivers/iommu/intel/pasid.h
index 082f4fe20216..668d8ece6b14 100644
--- a/drivers/iommu/intel/pasid.h
+++ b/drivers/iommu/intel/pasid.h
@@ -73,6 +73,12 @@ static inline bool pasid_pte_is_present(struct pasid_entry *pte)
 	return READ_ONCE(pte->val[0]) & PASID_PTE_PRESENT;
 }
 
+/* Get FPD(Fault Processing Disable) bit of a PASID table entry */
+static inline bool pasid_pte_is_fault_disabled(struct pasid_entry *pte)
+{
+	return READ_ONCE(pte->val[0]) & PASID_PTE_FPD;
+}
+
 /* Get PGTT field of a PASID table entry */
 static inline u16 pasid_pte_get_pgtt(struct pasid_entry *pte)
 {
-- 
2.43.0

