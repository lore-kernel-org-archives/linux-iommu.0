Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623FC20F0
	for <iommu@lists.linux.dev>; Mon,  6 Mar 2023 06:25:33 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (localhost [127.0.0.2] (may be forged))
	by SHSQR01.spreadtrum.com with ESMTP id 3265Qwfs020403
	for <iommu@lists.linux.dev>; Mon, 6 Mar 2023 13:26:58 +0800 (+08)
	(envelope-from Chunyan.Zhang@unisoc.com)
Received: from SHSend.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by SHSQR01.spreadtrum.com with ESMTP id 3265QHdV017866;
	Mon, 6 Mar 2023 13:26:17 +0800 (+08)
	(envelope-from Chunyan.Zhang@unisoc.com)
Received: from ubt.spreadtrum.com (10.0.74.87) by BJMBX02.spreadtrum.com
 (10.0.64.8) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Mon, 6 Mar 2023
 13:26:15 +0800
From: Chunyan Zhang <chunyan.zhang@unisoc.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        "Robin
 Murphy" <robin.murphy@arm.com>
CC: <iommu@lists.linux.dev>, Baolin Wang <baolin.wang@linux.alibaba.com>,
        Orson Zhai <orsonzhai@gmail.com>, Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH V2] iommu: sprd: fix a dma buffer leak issue
Date: Mon, 6 Mar 2023 13:26:13 +0800
Message-ID: <20230306052613.411400-1-chunyan.zhang@unisoc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.74.87]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL:SHSQR01.spreadtrum.com 3265QHdV017866

The DMA buffer used to store the address mpping table is alloced when
attaching device to a domain, and had been released in .detach_dev()
callback which will never be called since this driver supports default
domain, that will cause memory leak.

Move the dma buffer free before freeing sprd iommu domain to fix
this issue.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
V2: Modified commit message
---
 drivers/iommu/sprd-iommu.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/iommu/sprd-iommu.c b/drivers/iommu/sprd-iommu.c
index ae94d74b73f4..4de2e79d2226 100644
--- a/drivers/iommu/sprd-iommu.c
+++ b/drivers/iommu/sprd-iommu.c
@@ -154,6 +154,17 @@ static struct iommu_domain *sprd_iommu_domain_alloc(unsigned int domain_type)
 static void sprd_iommu_domain_free(struct iommu_domain *domain)
 {
 	struct sprd_iommu_domain *dom = to_sprd_domain(domain);
+	size_t pgt_size = sprd_iommu_pgt_size(domain);
+	struct sprd_iommu_device *sdev = dom->sdev;
+
+	/*
+	 * If the domain has been attached to a device already,
+	 * free the dma buffer first.
+	 */
+	if (sdev) {
+		dma_free_coherent(sdev->dev, pgt_size, dom->pgt_va, dom->pgt_pa);
+		dom->sdev = NULL;
+	}
 
 	kfree(dom);
 }
-- 
2.25.1

