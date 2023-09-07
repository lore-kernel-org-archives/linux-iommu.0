Received: from unicom146.biz-email.net (unicom146.biz-email.net [210.51.26.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899C8136B
	for <iommu@lists.linux.dev>; Thu,  7 Sep 2023 07:16:07 +0000 (UTC)
Received: from unicom146.biz-email.net
        by unicom146.biz-email.net ((D)) with ASMTP (SSL) id CGV00052;
        Thu, 07 Sep 2023 15:14:52 +0800
Received: from localhost.localdomain (10.94.11.172) by
 jtjnmail201601.home.langchao.com (10.100.2.1) with Microsoft SMTP Server id
 15.1.2507.32; Thu, 7 Sep 2023 15:14:52 +0800
From: Bo Liu <liubo03@inspur.com>
To: <joro@8bytes.org>, <will@kernel.org>
CC: <robin.murphy@arm.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Bo Liu <liubo03@inspur.com>
Subject: [PATCH] iommu/omap: Use helper function IS_ERR_OR_NULL()
Date: Thu, 7 Sep 2023 03:14:09 -0400
Message-ID: <20230907071409.3805-1-liubo03@inspur.com>
X-Mailer: git-send-email 2.18.2
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.94.11.172]
tUid: 202390715145272120af2dc16d7ff9df14ab83fed208e
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

Use IS_ERR_OR_NULL() to detect an error pointer or a null pointer
open-coding to simplify the code.

Signed-off-by: Bo Liu <liubo03@inspur.com>
---
 drivers/iommu/omap-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 537e402f9bba..6d0e116cd0e2 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -881,7 +881,7 @@ static int omap_iommu_attach(struct omap_iommu *obj, u32 *iopgd)
  **/
 static void omap_iommu_detach(struct omap_iommu *obj)
 {
-	if (!obj || IS_ERR(obj))
+	if (IS_ERR_OR_NULL(obj))
 		return;
 
 	spin_lock(&obj->iommu_lock);
-- 
2.27.0

