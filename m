Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC1D17C2
	for <iommu@lists.linux.dev>; Wed,  9 Nov 2022 02:47:39 +0000 (UTC)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VULiWKz_1667962049;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VULiWKz_1667962049)
          by smtp.aliyun-inc.com;
          Wed, 09 Nov 2022 10:47:31 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: joro@8bytes.org
Cc: will@kernel.org,
	robin.murphy@arm.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Yang Li <yang.lee@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] iommu: Fix some kernel-doc comments
Date: Wed,  9 Nov 2022 10:47:29 +0800
Message-Id: <20221109024729.3957-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make the description of @group to @dev in iommu_device_release_dma_owner()
to clear the below warnings:

drivers/iommu/iommu.c:3235: warning: Function parameter or member 'dev' not described in 'iommu_device_release_dma_owner'
drivers/iommu/iommu.c:3235: warning: Excess function parameter 'group' description in 'iommu_device_release_dma_owner'

Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=2820
Fixes: 506c4809b2d3 ("iommu: Add device-centric DMA ownership interfaces")
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/iommu/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 4cb14e44e40f..d299fef4fd81 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3227,7 +3227,7 @@ EXPORT_SYMBOL_GPL(iommu_group_release_dma_owner);
 
 /**
  * iommu_device_release_dma_owner() - Release DMA ownership of a device
- * @group: The device.
+ * @dev: get the group that this device belongs to
  *
  * Release the DMA ownership claimed by iommu_device_claim_dma_owner().
  */
-- 
2.20.1.7.g153144c

