Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FE41C06
	for <iommu@lists.linux.dev>; Mon, 12 Jun 2023 03:00:22 +0000 (UTC)
X-UUID: 625a568d3da64d2aa78ff3d2e669f391-20230612
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:8dbb7674-442a-4ae3-b328-85febe458103,IP:5,U
	RL:0,TC:0,Content:0,EDM:-25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-35
X-CID-INFO: VERSION:1.1.22,REQID:8dbb7674-442a-4ae3-b328-85febe458103,IP:5,URL
	:0,TC:0,Content:0,EDM:-25,RT:0,SF:-15,FILE:0,BULK:0,RULE:EDM_GE969F26,ACTI
	ON:release,TS:-35
X-CID-META: VersionHash:120426c,CLOUDID:6d5a183e-de1e-4348-bc35-c96f92f1dcbb,B
	ulkID:230612101800XIEZGSAS,BulkQuantity:0,Recheck:0,SF:17|19|44|38|24|102,
	TC:nil,Content:0,EDM:1,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,
	OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 625a568d3da64d2aa78ff3d2e669f391-20230612
X-User: gehao@kylinos.cn
Received: from localhost.localdomain [(116.128.244.169)] by mailgw
	(envelope-from <gehao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1936308362; Mon, 12 Jun 2023 10:17:55 +0800
From: Hao Ge <gehao@kylinos.cn>
To: joro@8bytes.org,
	suravee.suthikulpanit@amd.com,
	will@kernel.org,
	robin.murphy@arm.com
Cc: kevin.tian@intel.com,
	jgg@ziepe.ca,
	vasant.hegde@amd.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	gehao618@163.com,
	Hao Ge <gehao@kylinos.cn>
Subject: [PATCH] iommu/amd: Fix memory leak when domain type checks fail
Date: Mon, 12 Jun 2023 10:17:18 +0800
Message-Id: <20230612021718.82293-1-gehao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When domain type checks fail,we also should free protection_domain struct
to avoid memory leak in protection_domain_alloc

Fixes: 29f54745f245 ("iommu/amd: Add missing domain type checks")
Signed-off-by: Hao Ge <gehao@kylinos.cn>
---
 drivers/iommu/amd/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index dc1ec6849775..f08e65629c74 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2094,7 +2094,7 @@ static struct protection_domain *protection_domain_alloc(unsigned int type)
 	} else if (type == IOMMU_DOMAIN_DMA || type == IOMMU_DOMAIN_DMA_FQ) {
 		pgtable = amd_iommu_pgtable;
 	} else {
-		return NULL;
+		goto out_err;
 	}
 
 	switch (pgtable) {
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus
