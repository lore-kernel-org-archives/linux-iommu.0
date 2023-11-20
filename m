Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3881711706
	for <iommu@lists.linux.dev>; Mon, 20 Nov 2023 11:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-UUID: 1bed3ad0837e41ccb08c40b898ce1a6b-20231120
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:6ed99b82-eeb3-431c-af0d-49f9253223d0,IP:20,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:30
X-CID-INFO: VERSION:1.1.32,REQID:6ed99b82-eeb3-431c-af0d-49f9253223d0,IP:20,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:30
X-CID-META: VersionHash:5f78ec9,CLOUDID:235b9895-10ce-4e4b-85c2-c9b5229ff92b,B
	ulkID:231120175404TQAIPAGQ,BulkQuantity:0,Recheck:0,SF:38|24|17|19|44|66|1
	02,TC:nil,Content:0,EDM:5,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL
	:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS
X-UUID: 1bed3ad0837e41ccb08c40b898ce1a6b-20231120
X-User: chentao@kylinos.cn
Received: from vt.. [(116.128.244.171)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1342836172; Mon, 20 Nov 2023 17:54:03 +0800
From: Kunwu Chan <chentao@kylinos.cn>
To: joro@8bytes.org,
	suravee.suthikulpanit@amd.com,
	will@kernel.org,
	robin.murphy@arm.com
Cc: kunwu.chan@hotmail.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH] iommu/amd: Set variable amd_dirty_ops to static
Date: Mon, 20 Nov 2023 17:53:42 +0800
Message-Id: <20231120095342.1102999-1-chentao@kylinos.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the followng warning:
drivers/iommu/amd/iommu.c:67:30: warning: symbol
 'amd_dirty_ops' was not declared. Should it be static?

This variable is only used in its defining file, so it should be static.

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 drivers/iommu/amd/iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index fcc987f5d4ed..9f7064360828 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -64,7 +64,7 @@ LIST_HEAD(hpet_map);
 LIST_HEAD(acpihid_map);
 
 const struct iommu_ops amd_iommu_ops;
-const struct iommu_dirty_ops amd_dirty_ops;
+static const struct iommu_dirty_ops amd_dirty_ops;
 
 int amd_iommu_max_glx_val = -1;
 
@@ -2635,7 +2635,7 @@ static bool amd_iommu_enforce_cache_coherency(struct iommu_domain *domain)
 	return true;
 }
 
-const struct iommu_dirty_ops amd_dirty_ops = {
+static const struct iommu_dirty_ops amd_dirty_ops = {
 	.set_dirty_tracking = amd_iommu_set_dirty_tracking,
 	.read_and_clear_dirty = amd_iommu_read_and_clear_dirty,
 };
-- 
2.34.1

