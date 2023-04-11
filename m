Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572E9211C
	for <iommu@lists.linux.dev>; Tue, 11 Apr 2023 06:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681195707; x=1712731707;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KLcSzST6hDd+fcr/F74YMXpjYh9sQavSmsQ3e9U8YPk=;
  b=RQVVS7HfGVziNJ99EU0fG+R5ZvJWpoJpIpuJqTU1JIfTK0XWPmHfDoyW
   EF0+9F4lVYYmzJM9P9p2nM6EFRiN/HEmvhGTuSlvDIAd3GlgTNUMvRKob
   kb1MMxdzOArbqISChWUCwUomBmjGw1Ac6M15fkDu+Rz2D5vwaRTqFzIW6
   UCMnuWLZaLgIhWS4il8oW2aP0+ZoE+Wz4941FL0MaNpU+NLa3G/nEehCy
   80VQoIC0Q2zgGcXk1CrnbWGybTvxhRPnA637gkysEcbHgozlfqfa8qlAj
   FpqCyHpqTtZCDgyLtwPmORIXqPdeWG04Hj36k5C1JjdR7+9H8EYxFticB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="341028554"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="341028554"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2023 23:48:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="1018256594"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="1018256594"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmsmga005.fm.intel.com with ESMTP; 10 Apr 2023 23:48:24 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Vinod Koul <vkoul@kernel.org>,
	Tina Zhang <tina.zhang@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 07/17] iommu/vt-d: Do not use GFP_ATOMIC when not needed
Date: Tue, 11 Apr 2023 14:48:05 +0800
Message-Id: <20230411064815.31456-8-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230411064815.31456-1-baolu.lu@linux.intel.com>
References: <20230411064815.31456-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

There is no need to use GFP_ATOMIC here. GFP_KERNEL is already used for
some other memory allocations just a few lines above.

Commit e3a981d61d15 ("iommu/vt-d: Convert allocations to GFP_KERNEL") has
changed the other memory allocation flags.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Link: https://lore.kernel.org/r/e2a8a1019ffc8a86b4b4ed93def3623f60581274.1675542576.git.christophe.jaillet@wanadoo.fr
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/irq_remapping.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
index df9e261af0b5..a1b987335b31 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -548,7 +548,7 @@ static int intel_setup_irq_remapping(struct intel_iommu *iommu)
 		goto out_free_table;
 	}
 
-	bitmap = bitmap_zalloc(INTR_REMAP_TABLE_ENTRIES, GFP_ATOMIC);
+	bitmap = bitmap_zalloc(INTR_REMAP_TABLE_ENTRIES, GFP_KERNEL);
 	if (bitmap == NULL) {
 		pr_err("IR%d: failed to allocate bitmap\n", iommu->seq_id);
 		goto out_free_pages;
-- 
2.34.1

