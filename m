Received: from outbound.baidu.com (mx14.baidu.com [220.181.3.101])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 0F0F037DEA3
	for <iommu@lists.linux.dev>; Sat, 30 May 2026 11:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.3.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780140558; cv=none; b=nrxYQfd9ihw4COrs9NiNvlSdoqQX5sg34IiOM6wc6hXa9rvNXGqlwAcxrLoAnc+9+pGlirW/eB5dH/zLZtiGecBb+lYCH/93e2LIW/3PkTSimTah/eXIzGt9uQDR+CtI0vLmdfUj4aKt/rebghFqNSVJFLr9G/Q7tfZ1YY431bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780140558; c=relaxed/simple;
	bh=q9Nqs7Vct+E3lnckbJsRpt7hDsrB9skpywJyUx1PshM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oEwaAXnE0vdobZv6NiLwlLc2fxNC9/t3gcdEf4O3I0hO+npidqiRybcHQLiptOcI+TfPeVVrm24Rvb//e18yAR9I61oqxpM6n5fFroKgFlrRhe2sx9Ru7B7ADKopkqdhoGZOJ5pU2NKWEL/zu7Y7bKcADtSb59nbf+XJPIAFjFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b=XDqZrZJY; arc=none smtp.client-ip=220.181.3.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b="XDqZrZJY"
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.47
From: lirongqing <lirongqing@baidu.com>
To: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Will
 Deacon <will@kernel.org>, Lu Baolu <baolu.lu@linux.intel.com>, Luis
 Chamberlain <mcgrof@kernel.org>, Leon Romanovsky <leon@kernel.org>, Logan
 Gunthorpe <logang@deltatee.com>, Bjorn Helgaas <bhelgaas@google.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH] iommu/dma-iommu: Fix wrong scatterlist length assignment in P2PDMA path
Date: Sat, 30 May 2026 07:28:52 -0400
Message-ID: <20260530112852.2321-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjhj-exc4.internal.baidu.com (172.31.3.14) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1780140545;
	bh=fXK3xxBmCA0vj7UeNs7YwJFbu2LW0hQ+Blen52r1tBk=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=XDqZrZJYOGUrE3S0U1fujsq7GTHo/gjaxh9+4t46j6nOVL/YgQKtONCqdF58uFC9E
	 wpnFyHDMCwmaoLY7iEKSrnCHnxx94noYE5n/dwnTPdjlqfDgM3YfO/u11yugQKZs7M
	 QU9N0mzQj07OBkvPx+uhXzY7UNR+5/DffUp65BvqJoRUKi6N058rRydkQuCmAt4Tke
	 3nWCFhmx0ak/EzWtpF7IMS2RXldfgPwlBzqArIEk+OME0IygVARZGBoziasuCh3S3z
	 eQANuJwICp+ncaPWVysULlwB39onNR65cy76X1HfzyCTG/zmQCJaQqIduTqi5giiAD
	 xqL2hEAAcx/vQ==

From: Li RongQing <lirongqing@baidu.com>

In iommu_dma_map_sg(), when handling PCI P2PDMA cases, the DMA length
of the current scatterlist segment `s` is incorrectly assigned from the
head entry `sg->length` instead of the current entry `s->length`.

This typo causes all P2PDMA segments in the scatterlist to inherit the
length of the first segment, leading to corrupted DMA lengths for multi-
segment scatterlists.

Fix this by using `s->length` instead of `sg->length`.

Fixes: a25e7962db ("PCI/P2PDMA: Refactor the p2pdma mapping helpers")
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 drivers/iommu/dma-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 54d96e8..e8d4c2d 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1465,7 +1465,7 @@ int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
 			 */
 			s->dma_address = pci_p2pdma_bus_addr_map(
 				p2pdma_state.mem, sg_phys(s));
-			sg_dma_len(s) = sg->length;
+			sg_dma_len(s) = s->length;
 			sg_dma_mark_bus_address(s);
 			continue;
 		default:
-- 
2.9.4

