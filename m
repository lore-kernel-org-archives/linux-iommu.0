Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842E562B
	for <iommu@lists.linux.dev>; Wed,  8 Mar 2023 03:43:51 +0000 (UTC)
Received: from SHSend.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by SHSQR01.spreadtrum.com with ESMTP id 3283g5Qb087717;
	Wed, 8 Mar 2023 11:42:05 +0800 (+08)
	(envelope-from Chunyan.Zhang@unisoc.com)
Received: from ubt.spreadtrum.com (10.0.74.87) by BJMBX02.spreadtrum.com
 (10.0.64.8) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Wed, 8 Mar 2023
 11:42:02 +0800
From: Chunyan Zhang <chunyan.zhang@unisoc.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        "Robin
 Murphy" <robin.murphy@arm.com>
CC: <iommu@lists.linux.dev>, Baolu Lu <baolu.lu@linux.intel.com>,
        Baolin Wang
	<baolin.wang@linux.alibaba.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        "Chunyan
 Zhang" <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML
	<linux-kernel@vger.kernel.org>
Subject: [PATCH V2] iommu: sprd: release dma buffer to avoid memory leak
Date: Wed, 8 Mar 2023 11:41:58 +0800
Message-ID: <20230308034158.509458-1-chunyan.zhang@unisoc.com>
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
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL:SHSQR01.spreadtrum.com 3283g5Qb087717

Release page table DMA buffer when the IOMMU domain is not used:

- Domain freed.

- IOMMU is attaching to a new domain.
  Since one sprd IOMMU servers only one client device, if the IOMMU has
  been attached to other domain, it has to be detached first, that's
  saying the DMA buffer should be released, otherwise that would
  cause memory leak issue.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
V2:
* Added some comment in sprd_iommu_attach_device() for the reason
  of calling sprd_iommu_cleanup().

V1: https://lkml.org/lkml/2023/2/10/198
---
 drivers/iommu/sprd-iommu.c | 46 ++++++++++++++++++++++++++++++++------
 1 file changed, 39 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/sprd-iommu.c b/drivers/iommu/sprd-iommu.c
index ae94d74b73f4..fb2f96df3bca 100644
--- a/drivers/iommu/sprd-iommu.c
+++ b/drivers/iommu/sprd-iommu.c
@@ -62,6 +62,7 @@ enum sprd_iommu_version {
  * @eb: gate clock which controls IOMMU access
  */
 struct sprd_iommu_device {
+	struct sprd_iommu_domain	*dom;
 	enum sprd_iommu_version	ver;
 	u32			*prot_page_va;
 	dma_addr_t		prot_page_pa;
@@ -151,13 +152,6 @@ static struct iommu_domain *sprd_iommu_domain_alloc(unsigned int domain_type)
 	return &dom->domain;
 }
 
-static void sprd_iommu_domain_free(struct iommu_domain *domain)
-{
-	struct sprd_iommu_domain *dom = to_sprd_domain(domain);
-
-	kfree(dom);
-}
-
 static void sprd_iommu_first_vpn(struct sprd_iommu_domain *dom)
 {
 	struct sprd_iommu_device *sdev = dom->sdev;
@@ -230,6 +224,29 @@ static void sprd_iommu_hw_en(struct sprd_iommu_device *sdev, bool en)
 	sprd_iommu_update_bits(sdev, reg_cfg, mask, 0, val);
 }
 
+static void sprd_iommu_cleanup(struct sprd_iommu_device *sdev)
+{
+	struct sprd_iommu_domain *dom = sdev->dom;
+	size_t pgt_size = sprd_iommu_pgt_size(&dom->domain);
+
+	dma_free_coherent(sdev->dev, pgt_size, dom->pgt_va, dom->pgt_pa);
+	dom->sdev = NULL;
+	sdev->dom = NULL;
+	sprd_iommu_hw_en(sdev, false);
+}
+
+static void sprd_iommu_domain_free(struct iommu_domain *domain)
+{
+	struct sprd_iommu_domain *dom = to_sprd_domain(domain);
+	struct sprd_iommu_device *sdev = dom->sdev;
+
+	/* Free DMA buffer first if the domain has been attached */
+	if (sdev)
+		sprd_iommu_cleanup(sdev);
+
+	kfree(dom);
+}
+
 static int sprd_iommu_attach_device(struct iommu_domain *domain,
 				    struct device *dev)
 {
@@ -237,14 +254,29 @@ static int sprd_iommu_attach_device(struct iommu_domain *domain,
 	struct sprd_iommu_domain *dom = to_sprd_domain(domain);
 	size_t pgt_size = sprd_iommu_pgt_size(domain);
 
+	/* Return directly if the domain attached to IOMMU already */
 	if (dom->sdev)
 		return -EINVAL;
 
+	/* The IOMMU already attached to a domain */
+	if (sdev->dom) {
+		if (sdev->dom == dom)
+			return 0;
+
+		/*
+		 * Clean up the previous domain, one sprd IOMMU servers only
+		 * one client device, if the IOMMU has been attached to other
+		 * domain, it has to be detached first.
+		 */
+		sprd_iommu_cleanup(sdev);
+	}
+
 	dom->pgt_va = dma_alloc_coherent(sdev->dev, pgt_size, &dom->pgt_pa, GFP_KERNEL);
 	if (!dom->pgt_va)
 		return -ENOMEM;
 
 	dom->sdev = sdev;
+	sdev->dom = dom;
 
 	sprd_iommu_first_ppn(dom);
 	sprd_iommu_first_vpn(dom);
-- 
2.25.1

