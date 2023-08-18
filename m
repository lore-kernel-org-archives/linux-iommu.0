Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBE017AB7
	for <iommu@lists.linux.dev>; Fri, 18 Aug 2023 09:16:25 +0000 (UTC)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0Vq1xg1D_1692350166;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0Vq1xg1D_1692350166)
          by smtp.aliyun-inc.com;
          Fri, 18 Aug 2023 17:16:14 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: dwmw2@infradead.org
Cc: baolu.lu@linux.intel.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] iommu/vt-d: Remove unused function
Date: Fri, 18 Aug 2023 17:16:03 +0800
Message-Id: <20230818091603.64800-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function are defined in the pasid.c file, but not called
elsewhere, so delete the unused function.

drivers/iommu/intel/pasid.c:342:20: warning: unused function 'pasid_set_wpe'.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=6185
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/iommu/intel/pasid.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 8f92b92f3d2a..06ddb3c927f5 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -335,15 +335,6 @@ static inline void pasid_set_fault_enable(struct pasid_entry *pe)
 	pasid_set_bits(&pe->val[0], 1 << 1, 0);
 }
 
-/*
- * Setup the WPE(Write Protect Enable) field (Bit 132) of a
- * scalable mode PASID entry.
- */
-static inline void pasid_set_wpe(struct pasid_entry *pe)
-{
-	pasid_set_bits(&pe->val[2], 1 << 4, 1 << 4);
-}
-
 /*
  * Setup the P(Present) field (Bit 0) of a scalable mode PASID
  * entry.
-- 
2.20.1.7.g153144c

