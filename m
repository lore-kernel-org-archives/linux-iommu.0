Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFAB5386
	for <iommu@lists.linux.dev>; Mon, 16 Oct 2023 03:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F8bZRogz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697427133; x=1728963133;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zgBbDJXbHtsNwJit7h5lRyc7ItRonwTU9Y4WoJHuj+4=;
  b=F8bZRogzJd1FRa+ajf3Hj7Z/44gP3oisErtGLVNIPb4KouWLQ3evvB4t
   YQCYxQPBidaAMLHNTidSCywIUNtL++uhU3qmzRWJTsl0U9oVGYPGoI/dB
   mLNRKK7CDXLiwUwKHLlTdRa8Vht9wd0HBBQMrjd6I2nXm/dqh1BPAehDX
   mcyMlrHA0RE4XrdvyMmTleQZj2Mg7dW2GgxJBbidOdCGHfhMUPOpqaFKm
   /q8th6alwOoIWjrdDcy6TaO4eLD62OWibP7wJdJtAmRcJxrFX8/Q+8/MV
   EBpSQXRmLYsoMdu1IkiX5Ay4T9GCK3MRPwn4ctuyRPjPTxVKOzDjZPgET
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="365701130"
X-IronPort-AV: E=Sophos;i="6.03,228,1694761200"; 
   d="scan'208";a="365701130"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2023 20:32:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="705444256"
X-IronPort-AV: E=Sophos;i="6.03,228,1694761200"; 
   d="scan'208";a="705444256"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orsmga003.jf.intel.com with ESMTP; 15 Oct 2023 20:32:11 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Jingqi Liu <Jingqi.liu@intel.com>,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] iommu/vt-d: debugfs: Dump entry pointing to huge page
Date: Mon, 16 Oct 2023 11:28:28 +0800
Message-Id: <20231016032830.101321-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231016032830.101321-1-baolu.lu@linux.intel.com>
References: <20231016032830.101321-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jingqi Liu <Jingqi.liu@intel.com>

For the page table entry pointing to a huge page, the data below the
level of the huge page is meaningless and does not need to be dumped.

Signed-off-by: Jingqi Liu <Jingqi.liu@intel.com>
Link: https://lore.kernel.org/r/20231013135811.73953-2-Jingqi.liu@intel.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/debugfs.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/debugfs.c b/drivers/iommu/intel/debugfs.c
index 1f925285104e..497c1561d3d2 100644
--- a/drivers/iommu/intel/debugfs.c
+++ b/drivers/iommu/intel/debugfs.c
@@ -311,9 +311,14 @@ static inline unsigned long level_to_directory_size(int level)
 static inline void
 dump_page_info(struct seq_file *m, unsigned long iova, u64 *path)
 {
-	seq_printf(m, "0x%013lx |\t0x%016llx\t0x%016llx\t0x%016llx\t0x%016llx\t0x%016llx\n",
-		   iova >> VTD_PAGE_SHIFT, path[5], path[4],
-		   path[3], path[2], path[1]);
+	seq_printf(m, "0x%013lx |\t0x%016llx\t0x%016llx\t0x%016llx",
+		   iova >> VTD_PAGE_SHIFT, path[5], path[4], path[3]);
+	if (path[2]) {
+		seq_printf(m, "\t0x%016llx", path[2]);
+		if (path[1])
+			seq_printf(m, "\t0x%016llx", path[1]);
+	}
+	seq_putc(m, '\n');
 }
 
 static void pgtable_walk_level(struct seq_file *m, struct dma_pte *pde,
-- 
2.34.1

