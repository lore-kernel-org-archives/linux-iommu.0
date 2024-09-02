Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C7742ABE
	for <iommu@lists.linux.dev>; Mon,  2 Sep 2024 02:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725244288; cv=none; b=tuI52ApCqNprHW9GaEpo5kc36TFPJZxk4EmRNMgLJ3kdgE/uO406EuRZ4XuL69DNIuk3ErYqmeZzn+oTtm+Q8w31gdti4pzvm2BURg7uH1SQGMt1S8foU2gFLmP8oJ68uWsEM5p+YaYYrXaRXyuh9HeinSicdr8PUC6a5Uu0d+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725244288; c=relaxed/simple;
	bh=0PZrnab4FudM+5CSpi+Okv7WquImKuGdpCZBN2D7HPU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=heTWCAOxdPAsvEpUaxhzlXeaqwxROF9I8Tg/j0hmQvqse0Hu457FMwzqfkD5T+rsecg5xTsIjwNl19pcSqTpBLcRzWqzy13ZMkiFReRQkzklMUfpcRsIv0IBQLmgFIVKct8dfvklwLyNFgrBV+WI7QXz3rWW1osfOM7egY+6Ch0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zg5hdBGn; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zg5hdBGn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725244287; x=1756780287;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0PZrnab4FudM+5CSpi+Okv7WquImKuGdpCZBN2D7HPU=;
  b=Zg5hdBGntxajwPYIrwiZZsCoksgLEAphmSY6JdUGjCkjU3LXWl3cwm7J
   LkJr4qwvcrc3ydF7L6LUdxo6+19jCAav4uvasxs2A3Ql6IZkFJYhEZy9W
   0QZdfj1VVPjOPTCU3T6oa3yTDgKQVK8Icp/qh8XzV5xTYpNZYBK2hi4OZ
   rYxRV4NJc2V9lWHKCJQq/r0LnEDRweQOuC7pxaMJdy17e4QkrCSqKFR27
   igMRHPdtGXz+VrYLanN8oq508nnlObF+SGvCTcR9M1xTXV34AcyWQqy/1
   jHVdgdVqto25TJuX+VgiKrT89Jczr+b2fCwdlc36P+VfDAm3D0bqXIWY6
   Q==;
X-CSE-ConnectionGUID: aqhjBBLrTueAn1odfTapRQ==
X-CSE-MsgGUID: G7gVNQTSRkyqAAtiN3ZU2A==
X-IronPort-AV: E=McAfee;i="6700,10204,11182"; a="23994283"
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="23994283"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2024 19:31:25 -0700
X-CSE-ConnectionGUID: 1P/ZVzKXRUqkO+nQ/xRdpA==
X-CSE-MsgGUID: CKAJlbw+ReCXxPK1Ac2JDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="69359283"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orviesa004.jf.intel.com with ESMTP; 01 Sep 2024 19:31:24 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Tina Zhang <tina.zhang@intel.com>,
	Sanjay K Kumar <sanjay.k.kumar@intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 03/14] iommu/vt-d: Always reserve a domain ID for identity setup
Date: Mon,  2 Sep 2024 10:27:13 +0800
Message-Id: <20240902022724.67059-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240902022724.67059-1-baolu.lu@linux.intel.com>
References: <20240902022724.67059-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We will use a global static identity domain. Reserve a static domain ID
for it.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
Link: https://lore.kernel.org/r/20240809055431.36513-4-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/iommu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index a92da6375efe..baf79c6a5a84 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1440,10 +1440,10 @@ static int iommu_init_domains(struct intel_iommu *iommu)
 	 * entry for first-level or pass-through translation modes should
 	 * be programmed with a domain id different from those used for
 	 * second-level or nested translation. We reserve a domain id for
-	 * this purpose.
+	 * this purpose. This domain id is also used for identity domain
+	 * in legacy mode.
 	 */
-	if (sm_supported(iommu))
-		set_bit(FLPT_DEFAULT_DID, iommu->domain_ids);
+	set_bit(FLPT_DEFAULT_DID, iommu->domain_ids);
 
 	return 0;
 }
-- 
2.34.1

