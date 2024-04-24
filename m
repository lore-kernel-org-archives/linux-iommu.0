Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87643360
	for <iommu@lists.linux.dev>; Wed, 24 Apr 2024 07:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713943094; cv=none; b=UNPUKgfz2blfoubVpu65Q4zBR9qU2d2TO7Cb5wqCLvzZVtempS+qkEDrCoy5qJb+MzsQTgQguuqkPqj27O4z8kZmLegcNSJ0625yRdJZvTt0I5xFWamFhTRNizdwX1Gr1SntgK1Q8DIVTdoD1EVZo4Eu73xGqabOLgeFqbiIPuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713943094; c=relaxed/simple;
	bh=rHvTSou8/1tjMflgd49XX0brDYVz5e086lRWrdYfOqU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fcskv2dXKPsZzVL1EMV0S6LORq/l/Bbw5FYQCC5VNA2B2SsUZ/cEHcGsKCRwJVYklLB1vWg92BY97RC2Ecw44w2BlOfCImDyI0IhTMy01+KI4S2NTjIHJ1db7pyEg5wlAMjI94aCAlHaj0d6f1CrikpZoeyOT6YEo6nZdLX2tLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mSwKTAhm; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mSwKTAhm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713943093; x=1745479093;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rHvTSou8/1tjMflgd49XX0brDYVz5e086lRWrdYfOqU=;
  b=mSwKTAhm1aDJmyC8SxdUhID1XBhTzD7ttWC+5PxqOGmgrX5A5h8ET3Gq
   smz0c9ZHE5BJnKiwxLMW/SQ8FU9qbvz9logfOsL0+QoLbH6/U32e7HGPd
   NwvqnxDrozCDxf6xRXTmgIUsXTJQRxKqKhSHvqlbxJa4/NK85Ps6C+AR1
   pkv3J4PItWDXBHNdD/UJeV0SvpO5xqBv3eNnp9md5iOeB4+rrjM4k9H3N
   gA4qjaAIjwwyo9gKKKG7W5D0NbQ0o9LPnt+xCiYMq0yBncgIKgUOODQER
   6NfEVIBuiuQoKe5JhynpP7QXTmnuLIcWtQdNLqs4OrKcUXTy+lEVId2ZS
   A==;
X-CSE-ConnectionGUID: EpK2feKVR0iVCbrgwUVtoA==
X-CSE-MsgGUID: Phqdw0xTTBq+lx9sN1fnBg==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="27073084"
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="27073084"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 00:18:12 -0700
X-CSE-ConnectionGUID: dBBdC8bbSQiYj5zuD91yuw==
X-CSE-MsgGUID: GfVKluqPRAaPI5u/XhXE0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="24664637"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa010.fm.intel.com with ESMTP; 24 Apr 2024 00:18:09 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Jingqi Liu <Jingqi.liu@intel.com>,
	Dimitri Sivanich <sivanich@hpe.com>,
	Uros Bizjak <ubizjak@gmail.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 01/18] iommu/vt-d: Remove redundant assignment to variable err
Date: Wed, 24 Apr 2024 15:16:27 +0800
Message-Id: <20240424071644.178250-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424071644.178250-1-baolu.lu@linux.intel.com>
References: <20240424071644.178250-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Colin Ian King <colin.i.king@gmail.com>

Variable err is being assigned a value that is never read. It is
either being re-assigned later on error exit paths, or never referenced
on the non-error path.

Cleans up clang scan build warning:
drivers/iommu/intel/dmar.c:1070:2: warning: Value stored to 'err' is
never read [deadcode.DeadStores]`

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
Link: https://lore.kernel.org/r/20240411090535.306326-1-colin.i.king@gmail.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/dmar.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 36d7427b1202..351be9455214 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1067,7 +1067,6 @@ static int alloc_iommu(struct dmar_drhd_unit *drhd)
 		goto error_free_seq_id;
 	}
 
-	err = -EINVAL;
 	if (!cap_sagaw(iommu->cap) &&
 	    (!ecap_smts(iommu->ecap) || ecap_slts(iommu->ecap))) {
 		pr_info("%s: No supported address widths. Not attempting DMA translation.\n",
-- 
2.34.1

