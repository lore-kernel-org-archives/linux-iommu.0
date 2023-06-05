Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F4611C9F
	for <iommu@lists.linux.dev>; Mon,  5 Jun 2023 11:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685964584; x=1717500584;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gx4+lmIMuKPgij1u1iO7wrD0iCQa441hN4golMffdVk=;
  b=MXHWig3DRlD2Wcnj62S84pj78AMl4zwAmzoMsr3dBn225d6AfSIH4kEm
   Q4NUJEx2OeqzZqLj0b48QCbr+SJqD+oHsegUMHgU9jkLTiN5AeLK8UP2K
   CHR9HXCWCPuYgsA/wYQBURBPJDbx9yWCQf7hbWIbhknQXGTcTPpBLfbc5
   Bh4fHMBFU0sA6L8w9IAdKbQltkzEpIYGBcchHhATE6FxnOrUdlcbP2hg9
   Khoo3oLu5avkjuKG0KP/EvstDIAHXVHpqo2TGQJCZATU5guY/EIqqcRCo
   4Z9EjM1Xv0JCtBI+ycFulxTc4dibmfDqhf3SVBqD3OnpjHB7c3AIjeIRg
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="336699345"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="336699345"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 04:29:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="708626657"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="708626657"
Received: from tower.bj.intel.com ([10.238.157.62])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 04:29:40 -0700
From: Yanfei Xu <yanfei.xu@intel.com>
To: dwmw2@infradead.org,
	baolu.lu@linux.intel.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	yanfei.xu@intel.com
Subject: [PATCH v3 0/2] Misc cleanup for iommu/vt-d
Date: Mon,  5 Jun 2023 19:26:57 +0800
Message-Id: <20230605112659.308981-1-yanfei.xu@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No functional changes intended

v1->v2:
1.Change to use check and return for dmar_reenable_qi()
2.Remove WARN_ON of 'table' instead of using BUG_ON
3.Also remove useless WARN_ON of domain id

v2->v3:
Move check for 'ret' value to correct conditional statement.
(For patch2. Pointed out by Robin)

Yanfei Xu (2):
  iommu/vt-d: Handle the failure case of dmar_reenable_qi()
  iommu/vt-d: Remove two WARN_ON in domain_context_mapping_one()

 drivers/iommu/intel/iommu.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

-- 
2.34.1

