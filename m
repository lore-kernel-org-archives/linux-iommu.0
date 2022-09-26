Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AC82F50
	for <iommu@lists.linux.dev>; Mon, 26 Sep 2022 13:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664198495; x=1695734495;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VwD2ax6c2ADqceGj0aumfZ+lcLBCp9hQ4LGfMfk/sJA=;
  b=N/R+XNJFDg9kH5JolqwvK89m5IUBI+pLj1sM6FzWcJptkaVf4Nn4exp3
   rPNcXU+uhh/6XuK68B/rTjSZOpX2ItN6pSVpLbPFz2O6t8Fnj7QDPL5ft
   O9Qz1XX1+jxqr9dvAqb9Gkkxk4K7o1hHSB6mayD2/puMpmfSm+k5aDqRL
   7dQIhg9bCHUayaKE/VPNDAvly/yF1/bhawKZNkl0Ed03B2y8D2uUd/+fJ
   k+UthsaLHyxLNCJ72laWR0kK4Saw3MOUcfsAeyq4I5SvfYZ7zvKDJvfqD
   lxrzscKfIQrYNilhAugvO1VFE8FnGUPcmkaucTJ2jQVAV+xnSeweCQtZe
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="288162541"
X-IronPort-AV: E=Sophos;i="5.93,346,1654585200"; 
   d="scan'208";a="288162541"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 06:21:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="683525663"
X-IronPort-AV: E=Sophos;i="5.93,346,1654585200"; 
   d="scan'208";a="683525663"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga008.fm.intel.com with ESMTP; 26 Sep 2022 06:21:34 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] iommu/vt-d: Remove pasid_set_eafe()
Date: Mon, 26 Sep 2022 21:15:26 +0800
Message-Id: <20220926131529.4045281-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220926131529.4045281-1-baolu.lu@linux.intel.com>
References: <20220926131529.4045281-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is not used anywhere in the tree. Remove it to avoid dead code.
No functional change intended.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20220915081645.1834555-1-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/pasid.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index c5e7e8b020a5..ccaf32949254 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -392,16 +392,6 @@ pasid_set_flpm(struct pasid_entry *pe, u64 value)
 	pasid_set_bits(&pe->val[2], GENMASK_ULL(3, 2), value << 2);
 }
 
-/*
- * Setup the Extended Access Flag Enable (EAFE) field (Bit 135)
- * of a scalable mode PASID entry.
- */
-static inline void
-pasid_set_eafe(struct pasid_entry *pe)
-{
-	pasid_set_bits(&pe->val[2], 1 << 7, 1 << 7);
-}
-
 static void
 pasid_cache_invalidation_with_pasid(struct intel_iommu *iommu,
 				    u16 did, u32 pasid)
-- 
2.34.1

