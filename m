Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158397C
	for <iommu@lists.linux.dev>; Wed, 21 Sep 2022 02:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663728415; x=1695264415;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DBYj/rGUbvxJJj2sBf29c6K45mPiObuLJBUkxGqCPN4=;
  b=ajvNc30WX2W338w3B1BjSHXkIBETZryXwunjHknJPw23v65GhmHxSMAd
   5cCx5cMjC2GjsfMS2PqSfYeyXPpwduC/FlVgRTxN/c+y7PYjnIFNcBnTf
   gpGWv9T/EimJdg+gIsAGZGwR3EwqSURmjmxpy5iLuS5l8uKdS6pOofpTA
   ccI5z4H60P24nvlbVeVEYmmHDzXM+ck7/376RfoOBp00UfpdCNFOasgpC
   DheJ44189JAW8NFQs19VEr25LNU79dDOzf3VzVCbW/Do0jfniyvyKojaR
   ahH2BL/DcfCFqilf3TlEiRMbE+h1d+qLQ5H5YN4GKjux5Px73b4DqN+Ww
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="301277923"
X-IronPort-AV: E=Sophos;i="5.93,332,1654585200"; 
   d="scan'208";a="301277923"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 19:46:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,332,1654585200"; 
   d="scan'208";a="681573941"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga008.fm.intel.com with ESMTP; 20 Sep 2022 19:46:52 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Kevin Tian <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>,
	Robin Murphy <robin.murphy@arm.com>,
	George Hilliard <thirtythreeforty@gmail.com>,
	iommu@lists.linux.dev,
	iommu@lists.linux-foundation.org
Subject: [PATCH 2/2] iommu/vt-d: Check correct capability for sagaw determination
Date: Wed, 21 Sep 2022 10:40:54 +0800
Message-Id: <20220921024054.3570256-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220921024054.3570256-1-baolu.lu@linux.intel.com>
References: <20220921024054.3570256-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yi Liu <yi.l.liu@intel.com>

Check 5-level paging capability for 57 bits address width instead of
checking 1GB large page capability.

Fixes: 53fc7ad6edf2 ("iommu/vt-d: Correctly calculate sagaw value of IOMMU")
Cc: stable@vger.kernel.org
Reported-by: Raghunathan Srinivasan <raghunathan.srinivasan@intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Raghunathan Srinivasan <raghunathan.srinivasan@intel.com>
Link: https://lore.kernel.org/r/20220916071212.2223869-2-yi.l.liu@intel.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 64d30895a4c8..31bc50e538a3 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -399,7 +399,7 @@ static unsigned long __iommu_calculate_sagaw(struct intel_iommu *iommu)
 {
 	unsigned long fl_sagaw, sl_sagaw;
 
-	fl_sagaw = BIT(2) | (cap_fl1gp_support(iommu->cap) ? BIT(3) : 0);
+	fl_sagaw = BIT(2) | (cap_5lp_support(iommu->cap) ? BIT(3) : 0);
 	sl_sagaw = cap_sagaw(iommu->cap);
 
 	/* Second level only. */
-- 
2.34.1

